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
    wget \
    unzip \
    tar \
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
    DocumentRoot /workspaces\n\
    <Directory /workspaces>\n\
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
COPY start-services.sh /usr/local/bin/start-services.sh
RUN chmod +x /usr/local/bin/start-services.sh

# Keep services running
CMD ["/usr/local/bin/start-services.sh"]
# Expose ports
EXPOSE 80 3306

WORKDIR /workspaces/
