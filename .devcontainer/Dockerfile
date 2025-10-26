FROM ubuntu:22.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install Apache, PHP, MariaDB and other essential tools
RUN apt-get update && apt-get install -y \
    apache2 \
    mariadb-server \
    php \
    php-mysql \
    php-cli \
    php-curl \
    php-gd \
    php-mbstring \
    php-xml \
    php-xmlrpc \
    php-zip \
    libapache2-mod-php \
    git \
    curl \
    vim \
    sudo \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Enable Apache modules
RUN a2enmod rewrite php8.1

# Create a non-root user for development
RUN useradd -m -s /bin/bash vscode && \
    echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Configure Apache to serve from /workspace
RUN echo '<VirtualHost *:80>\n\
    DocumentRoot /workspace\n\
    <Directory /workspace>\n\
        Options Indexes FollowSymLinks MultiViews\n\
        AllowOverride All\n\
        Require all granted\n\
    </Directory>\n\
    ErrorLog ${APACHE_LOG_DIR}/error.log\n\
    CustomLog ${APACHE_LOG_DIR}/access.log combined\n\
</VirtualHost>' > /etc/apache2/sites-available/000-default.conf

# Configure PHP
RUN echo 'short_open_tag = On\n\
display_errors = On\n\
display_startup_errors = On\n\
error_reporting = E_ALL\n\
upload_max_filesize = 64M\n\
post_max_size = 64M' >> /etc/php/8.1/apache2/php.ini

# Initialize MariaDB data directory
RUN mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql && \
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Create startup script
RUN echo '#!/bin/bash\n\
set -e\n\
\n\
# Start MariaDB\n\
echo "Starting MariaDB..."\n\
sudo service mariadb start\n\
\n\
# Wait for MariaDB to be ready\n\
echo "Waiting for MariaDB to be ready..."\n\
for i in {1..30}; do\n\
    if sudo mysqladmin ping &>/dev/null; then\n\
        echo "MariaDB is ready!"\n\
        break\n\
    fi\n\
    echo "Waiting for MariaDB... ($i/30)"\n\
    sleep 1\n\
done\n\
\n\
# Set up MariaDB root user (allow access without password for development)\n\
echo "Configuring MariaDB..."\n\
sudo mysql -e "ALTER USER '\''root'\''@'\''localhost'\'' IDENTIFIED VIA mysql_native_password USING PASSWORD('\'''\\'');" || true\n\
sudo mysql -e "CREATE USER IF NOT EXISTS '\''root'\''@'\''%'\'' IDENTIFIED BY '\'''\'';" || true\n\
sudo mysql -e "GRANT ALL PRIVILEGES ON *.* TO '\''root'\''@'\''%'\'' WITH GRANT OPTION;" || true\n\
sudo mysql -e "FLUSH PRIVILEGES;" || true\n\
\n\
# Start Apache\n\
echo "Starting Apache..."\n\
sudo service apache2 start\n\
\n\
echo "LAMP stack is ready!"\n\
echo "Apache is serving files from /workspace on port 80"\n\
echo "MariaDB is running on port 3306 (root user with no password)"\n\
echo ""\n\
echo "You can create PHP files in the workspace and access them via http://localhost"\n\
echo "For multiple projects, create subdirectories (e.g., /workspace/project1, /workspace/project2)"\n\
' > /usr/local/bin/start-services.sh && chmod +x /usr/local/bin/start-services.sh

# Keep services running
CMD ["bash", "-c", "sudo service mariadb start && sudo service apache2 start && tail -f /dev/null"]

# Expose ports
EXPOSE 80 3306

WORKDIR /workspace
