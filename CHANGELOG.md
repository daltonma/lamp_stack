# Changelog

All notable changes to this LAMP Stack Development Container will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [1.0.0] - 2025-10-26

### Added
- Initial release of single-container LAMP stack development environment
- DevContainer configuration for VS Code and GitHub Codespaces
- Dockerfile with Ubuntu 22.04, Apache 2.4, MariaDB 10.6, and PHP 8.1
- Automatic service startup script
- Apache configuration to serve from `/workspace` directory
- PHP configuration optimized for development and learning
- MariaDB with no-password root access for simplicity
- Port forwarding for Apache (80) and MariaDB (3306)
- Non-root user (vscode) with sudo privileges
- Support for multiple projects via subdirectories

### Documentation
- Comprehensive README.md with setup and usage instructions
- CONTRIBUTING.md guide for students and instructors
- QUICK-REFERENCE.md with common commands and code snippets
- SUMMARY.md documenting implementation details
- .gitignore for common development files

### Examples
- welcome.html - Introduction and feature overview
- index.php - PHP info page for environment testing
- test-db.php - MariaDB connection test
- example-projects/project1 - Simple HTML and PHP example
- example-projects/project2 - Form submission example

### PHP Extensions Included
- php-mysql - MySQL/MariaDB support
- php-cli - Command line interface
- php-curl - cURL support for HTTP requests
- php-gd - Image manipulation
- php-mbstring - Multibyte string support
- php-xml - XML parsing
- php-xmlrpc - XML-RPC support
- php-zip - ZIP archive support
- libapache2-mod-php - Apache PHP module

### Apache Modules Enabled
- mod_rewrite - URL rewriting for clean URLs
- mod_php - PHP support

### Features
- Single command setup (open in Codespaces or Dev Container)
- Automatic service initialization on container start
- Development-friendly error reporting
- 64MB file upload limit
- Support for .htaccess files
- Directory browsing enabled
- Comprehensive logging

### Security Notes
- ⚠️ Development only configuration
- ⚠️ No database password for simplicity
- ⚠️ Permissive Apache settings
- ⚠️ Error display enabled
- ⚠️ Not suitable for production use

## [Unreleased]

### Potential Future Additions
- phpMyAdmin for visual database management
- Composer for PHP package management
- XDebug for debugging
- Additional PHP frameworks
- Database backup/restore utilities
- Pre-configured virtual hosts
- SSL/HTTPS support for local development
- Node.js integration for full-stack development
- Redis or Memcached for caching examples

---

## Notes for Instructors

### Version Compatibility
- This configuration is tested with VS Code Dev Containers extension
- Compatible with GitHub Codespaces
- Requires Docker on local machines

### Customization
Instructors can fork this repository and customize:
- PHP version and extensions in Dockerfile
- Apache configuration in Dockerfile
- Pre-installed packages and tools
- Example projects and starter code
- Documentation to match course requirements

### Recommended Updates
- Keep base image (Ubuntu) updated for security patches
- Update PHP extensions as needed for course content
- Add framework-specific configurations as required

## Support

For issues, questions, or contributions:
- Open an issue on GitHub
- Submit a pull request for improvements
- Contact repository maintainer

## License

MIT License - See LICENSE file for details
