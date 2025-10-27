#!/usr/bin/env bash
set -euo pipefail

# Defaults (can be overridden via docker run -e or devcontainer env)
MYSQL_ROOT_PASSWORD="${MYSQL_ROOT_PASSWORD:-rootpass}"
MYSQL_DATABASE="${MYSQL_DATABASE:-course_db}"
MYSQL_USER="${MYSQL_USER:-student}"
MYSQL_PASSWORD="${MYSQL_PASSWORD:-}"

# Helper to wait for MySQL to become available
wait_for_mysql() {
  local tries=30
  until mysqladmin ping --silent; do
    tries=$((tries-1))
    if [ "$tries" -le 0 ]; then
      echo "MySQL did not start in time" >&2
      return 1
    fi
    sleep 1
  done
}

initialize_database() {
  echo "Initializing MariaDB data directory..."
  # Try mysqld --initialize-insecure (MySQL style) or fallback to mysql_install_db (MariaDB legacy)
  if mysqld --initialize-insecure --user=mysql --datadir=/var/lib/mysql 2>/dev/null; then
    echo "Used mysqld --initialize-insecure"
  else
    echo "Falling back to mysql_install_db"
    mysql_install_db --user=mysql --datadir=/var/lib/mysql >/dev/null
  fi
  chown -R mysql:mysql /var/lib/mysql
}

first_time_setup() {
  # Start temporary mysqld in background to perform initialization tasks
  mysqld_safe --datadir=/var/lib/mysql --skip-networking=0 &

  # Wait for mysql to accept connections
  wait_for_mysql

  echo "Securing and creating initial DB/user..."
  mysql -u root <<-EOSQL
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
    CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
    CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
    FLUSH PRIVILEGES;
EOSQL

  # Shutdown temporary mysqld cleanly
  mysqladmin -uroot -p"${MYSQL_ROOT_PASSWORD}" shutdown || true
  sleep 1
}

# If no mysql system tables are present, initialize and set up DB
if [ ! -d /var/lib/mysql/mysql ]; then
  initialize_database
  first_time_setup
else
  echo "MariaDB data directory already initialized."
fi

# Start MariaDB in background
echo "Starting MariaDB..."
service mariadb start

# Ensure proper ownership of workspace files (useful when host mounts are present)
chown -R www-data:www-data /var/www/html || true
# Optionally let vscode user own workspace files if they exist
chown -R vscode:www-data /var/www/html || true

# Finally, start Apache in the foreground (PID 1)
echo "Starting Apache (foreground)..."
service apache2 start
