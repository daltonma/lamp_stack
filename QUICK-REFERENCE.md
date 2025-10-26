# LAMP Stack Quick Reference

## Common Commands

### Apache (Web Server)
```bash
# Check status
sudo service apache2 status

# Start Apache
sudo service apache2 start

# Restart Apache
sudo service apache2 restart

# Stop Apache
sudo service apache2 stop

# View error logs
sudo tail -f /var/log/apache2/error.log

# View access logs
sudo tail -f /var/log/apache2/access.log
```

### MariaDB (Database)
```bash
# Access MySQL command line
mysql -u root

# Access specific database
mysql -u root database_name

# Create database
mysql -u root -e "CREATE DATABASE mydb;"

# Import SQL file
mysql -u root database_name < backup.sql

# Export database
mysqldump -u root database_name > backup.sql

# Check status
sudo service mariadb status

# Restart MariaDB
sudo service mariadb restart
```

### MySQL Commands (Once in mysql CLI)
```sql
-- Show all databases
SHOW DATABASES;

-- Use a database
USE database_name;

-- Show tables
SHOW TABLES;

-- Describe table structure
DESCRIBE table_name;

-- Create a database
CREATE DATABASE mydb;

-- Drop a database
DROP DATABASE mydb;

-- Exit
EXIT;
```

## PHP Snippets

### Database Connection
```php
<?php
// MySQLi Object-Oriented
$conn = new mysqli("localhost", "root", "", "database_name");

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Use the connection
$result = $conn->query("SELECT * FROM users");

// Close connection
$conn->close();
?>
```

### Form Handling
```php
<?php
// GET request
$name = $_GET['name'] ?? 'Guest';

// POST request
$email = $_POST['email'] ?? '';

// Sanitize input
$safe_input = htmlspecialchars($user_input);
?>
```

### Session Management
```php
<?php
// Start session
session_start();

// Set session variable
$_SESSION['username'] = 'john';

// Get session variable
$username = $_SESSION['username'] ?? null;

// Destroy session
session_destroy();
?>
```

### File Upload
```php
<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_FILES['file'])) {
    $file = $_FILES['file'];
    $upload_dir = 'uploads/';
    
    if (!is_dir($upload_dir)) {
        mkdir($upload_dir, 0777, true);
    }
    
    $target_file = $upload_dir . basename($file['name']);
    
    if (move_uploaded_file($file['tmp_name'], $target_file)) {
        echo "File uploaded successfully!";
    } else {
        echo "Upload failed!";
    }
}
?>
```

### Include Files
```php
<?php
// Include once
include_once 'header.php';

// Require (will error if file not found)
require 'config.php';

// Require once
require_once 'functions.php';
?>
```

## HTML Forms

### Basic Form
```html
<form method="POST" action="process.php">
    <label for="name">Name:</label>
    <input type="text" id="name" name="name" required>
    
    <label for="email">Email:</label>
    <input type="email" id="email" name="email" required>
    
    <button type="submit">Submit</button>
</form>
```

### File Upload Form
```html
<form method="POST" action="upload.php" enctype="multipart/form-data">
    <input type="file" name="file" required>
    <button type="submit">Upload</button>
</form>
```

## Useful File Locations

- **Web root:** `/workspace` (your repository directory)
- **Apache config:** `/etc/apache2/sites-available/000-default.conf`
- **PHP config:** `/etc/php/8.1/apache2/php.ini`
- **Apache logs:** `/var/log/apache2/`
- **MySQL data:** `/var/lib/mysql/`

## File Permissions

```bash
# Make file readable and writable
chmod 644 file.php

# Make file executable
chmod +x script.sh

# Change ownership
sudo chown vscode:vscode file.php

# Recursive ownership change
sudo chown -R vscode:vscode /workspace/project/
```

## Debugging Tips

### PHP Errors
1. Check error logs: `sudo tail -f /var/log/apache2/error.log`
2. Enable error display (already enabled in this container)
3. Use `var_dump()` and `print_r()` to inspect variables
4. Add error checking after database queries

### Common Issues

**White screen (no output):**
- Check for syntax errors in PHP code
- Look at error logs
- Ensure PHP tags are correct: `<?php ... ?>`

**Database connection fails:**
- Verify MariaDB is running: `sudo service mariadb status`
- Check connection credentials (host: localhost, user: root, password: empty)
- Verify database exists: `mysql -u root -e "SHOW DATABASES;"`

**Page not found (404):**
- Check file path and name (case-sensitive)
- Verify file is in `/workspace` or subdirectory
- Check URL matches file location

**Changes not showing:**
- Hard refresh: Ctrl+Shift+R (Windows/Linux) or Cmd+Shift+R (Mac)
- Clear browser cache
- Check you're editing the correct file

## Git Basics

```bash
# Check status
git status

# Add files
git add .

# Commit changes
git commit -m "Description of changes"

# Push to GitHub
git push

# Pull latest changes
git pull

# View commit history
git log --oneline
```

## Project Structure Example

```
/workspace
  ├── project-name/
  │   ├── index.php          # Home page
  │   ├── config.php         # Database configuration
  │   ├── css/
  │   │   └── style.css      # Stylesheets
  │   ├── js/
  │   │   └── script.js      # JavaScript
  │   ├── images/
  │   │   └── logo.png       # Images
  │   ├── includes/
  │   │   ├── header.php     # Reusable header
  │   │   └── footer.php     # Reusable footer
  │   └── uploads/           # User uploads
  └── another-project/
      └── ...
```

## Security Reminders

⚠️ **This is a development environment only!**

- Never use in production
- No password on database (development only)
- Error messages displayed (development only)
- Always sanitize user input: `htmlspecialchars()`
- Use prepared statements for database queries
- Validate and sanitize file uploads

## Need Help?

1. Check the error logs
2. Read the error message carefully
3. Search for the error online
4. Ask your instructor
5. Check the CONTRIBUTING.md file for more details
