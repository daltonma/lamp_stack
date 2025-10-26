# LAMP Stack Development Container

A single-container LAMP stack (Linux, Apache, MariaDB, PHP) for development in VS Code and GitHub Codespaces. Perfect for introductory web development courses in PHP and HTML.

## Features

- **Single Container**: Everything runs in one container for simplicity
- **Full LAMP Stack**:
  - Linux (Ubuntu 22.04)
  - Apache 2.4 Web Server
  - MariaDB 10.6 Database
  - PHP 8.1 with common extensions
- **Multiple Projects**: Organize projects in subdirectories
- **Auto-configured**: Services start automatically
- **Development-ready**: Includes error reporting and helpful PHP settings

## Getting Started

### Using GitHub Codespaces

1. Click the **Code** button on this repository
2. Select **Create codespace on main**
3. Wait for the container to build and start
4. Access your web server at the forwarded port 80

### Using VS Code with Dev Containers

1. Install [Docker Desktop](https://www.docker.com/products/docker-desktop)
2. Install the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) for VS Code
3. Clone this repository
4. Open the folder in VS Code
5. When prompted, click "Reopen in Container" (or use Command Palette: "Dev Containers: Reopen in Container")
6. Wait for the container to build and start
7. Access your web server at `http://localhost`

## Usage

### Creating PHP Files

Simply create PHP files in the workspace root or any subdirectory:

```php
<?php
// hello.php
echo "Hello, World!";
?>
```

Access at: `http://localhost/hello.php`

### Multiple Projects

Organize multiple projects in subdirectories:

```
/workspace
  ├── project1/
  │   ├── index.php
  │   └── about.php
  ├── project2/
  │   └── index.html
  └── shared/
      └── config.php
```

- Project 1: `http://localhost/project1/`
- Project 2: `http://localhost/project2/`

### Database Access

**Connection Details:**
- **Host**: `localhost`
- **Username**: `root`
- **Password**: (empty)
- **Port**: `3306`

**Example PHP Connection:**

```php
<?php
$conn = new mysqli("localhost", "root", "");

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

echo "Connected successfully";
$conn->close();
?>
```

**Using MySQL Command Line:**

```bash
mysql -u root
```

### Testing the Installation

Visit these pages to verify everything is working:

- `http://localhost/welcome.html` - Welcome page with info
- `http://localhost/index.php` - PHP info page
- `http://localhost/test-db.php` - Database connection test

## Configuration

### PHP Settings

PHP is configured for development with:
- Error reporting enabled
- Display errors enabled
- 64MB upload limit
- Short open tags enabled

To modify PHP settings, edit `/etc/php/8.1/apache2/php.ini` inside the container.

### Apache Configuration

Apache is configured to:
- Serve files from `/workspace` (your repository root)
- Allow `.htaccess` overrides
- Enable `mod_rewrite` for clean URLs
- Support multiple directories

The Apache configuration is located at `/etc/apache2/sites-available/000-default.conf`.

### Managing Services

Services start automatically, but you can also control them manually:

```bash
# Restart Apache
sudo service apache2 restart

# Restart MariaDB
sudo service mariadb restart

# Check service status
sudo service apache2 status
sudo service mariadb status
```

## Common Tasks

### Creating a Database

```bash
mysql -u root -e "CREATE DATABASE myapp;"
```

Or in PHP:

```php
<?php
$conn = new mysqli("localhost", "root", "");
$conn->query("CREATE DATABASE IF NOT EXISTS myapp");
$conn->close();
?>
```

### Importing SQL Files

```bash
mysql -u root database_name < backup.sql
```

### Installing PHP Packages with Composer

Composer is not included by default. Install it if needed:

```bash
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
```

## Troubleshooting

### Services Not Running

If services aren't running, start them manually:

```bash
bash /usr/local/bin/start-services.sh
```

### Port Already in Use

If port 80 or 3306 is already in use on your host machine, you can modify the port forwarding in `.devcontainer/devcontainer.json`.

### Permission Issues

The container runs as the `vscode` user with sudo access. If you encounter permission issues:

```bash
sudo chown -R vscode:vscode /workspace
```

## Technical Details

- **Base Image**: Ubuntu 22.04
- **User**: `vscode` (non-root with sudo)
- **Apache Version**: 2.4
- **PHP Version**: 8.1
- **MariaDB Version**: 10.6
- **Document Root**: `/workspace` (your repository directory)

## Educational Use

This container is designed for teaching introductory web development with PHP. It provides:

- A simple, single-container setup (no Docker Compose complexity)
- Immediate feedback with error reporting enabled
- Easy database access without authentication barriers
- Support for multiple student projects in one workspace
- Real-world LAMP stack experience

## Security Note

⚠️ **This configuration is for DEVELOPMENT ONLY.** It includes:
- No database password
- Permissive Apache settings
- Enabled error display
- Root MySQL access from anywhere

Never use this configuration in production environments.

## License

MIT License - Feel free to use this for educational purposes.
