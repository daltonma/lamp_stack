# Contributing Guide

This repository is designed for educational use in introductory web development courses. Here's how to use it effectively.

## For Students

### Getting Started with Your First Project

1. **Open this repository** in GitHub Codespaces or VS Code with Dev Containers
2. **Wait for the container to build** (first time takes a few minutes)
3. **Create a new folder** for your project:
   ```bash
   mkdir my-first-website
   cd my-first-website
   ```
4. **Create your first PHP file**:
   ```bash
   echo '<?php echo "Hello, World!"; ?>' > index.php
   ```
5. **View it in your browser** at `http://localhost/my-first-website/`

### Project Organization

Keep each assignment or project in its own folder:

```
/workspace
  ├── assignment1/
  ├── assignment2/
  ├── final-project/
  └── lab-exercises/
```

### Working with Databases

Create a database for your project:

```bash
mysql -u root -e "CREATE DATABASE my_project;"
```

Then connect in your PHP code:

```php
<?php
$conn = new mysqli("localhost", "root", "", "my_project");
?>
```

### Common Tasks

**Check if Apache is running:**
```bash
sudo service apache2 status
```

**Check if MariaDB is running:**
```bash
sudo service mariadb status
```

**View Apache error logs:**
```bash
sudo tail -f /var/log/apache2/error.log
```

**Access MySQL command line:**
```bash
mysql -u root
```

## For Instructors

### Customizing for Your Course

#### Modifying PHP Configuration

Edit `.devcontainer/Dockerfile` to change PHP settings. For example, to disable short tags:

```dockerfile
# In Dockerfile, modify the PHP configuration section
RUN echo 'short_open_tag = Off\n\
display_errors = On\n\
...
```

#### Adding Additional Software

Add packages to the Dockerfile:

```dockerfile
RUN apt-get update && apt-get install -y \
    apache2 \
    mariadb-server \
    php \
    # Add your packages here
    nodejs \
    npm \
    && apt-get clean
```

#### Pre-installing PHP Extensions

Modify the Dockerfile to include additional PHP extensions:

```dockerfile
RUN apt-get install -y \
    php-mysql \
    php-gd \
    # Add more extensions
    php-redis \
    php-imagick
```

### Providing Starter Code

You can include starter code by adding files to the repository:

1. Create a `starter-templates/` directory
2. Add template files students can copy
3. Update the README with instructions

### Setting Up Database Schemas

Include SQL files students can import:

```sql
-- Create file: setup.sql
CREATE DATABASE IF NOT EXISTS course_db;
USE course_db;

CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);
```

Students can then import:
```bash
mysql -u root < setup.sql
```

### Grading Student Work

When students submit their work:

1. Open their repository in a Codespace
2. The LAMP stack will start automatically
3. Navigate to their project folder in the browser
4. Test functionality and review code

## Best Practices

### For Students

- **Commit often**: Save your work frequently with git commits
- **Use meaningful file names**: `login.php` is better than `page1.php`
- **Comment your code**: Explain what your code does
- **Test in the browser**: Always check your work before submitting
- **Use semantic HTML**: Structure your pages properly

### For Instructors

- **Keep it simple**: Don't overcomplicate the setup
- **Provide examples**: Include working sample code
- **Document everything**: Clear instructions prevent confusion
- **Test thoroughly**: Verify the setup works before sharing with students

## Troubleshooting

### Container Won't Start

1. Check Docker is running
2. Try rebuilding: "Dev Containers: Rebuild Container"
3. Check for port conflicts (80, 3306)

### Changes Not Showing

1. Clear browser cache (Ctrl+Shift+R or Cmd+Shift+R)
2. Check file is in the correct directory
3. Restart Apache: `sudo service apache2 restart`

### Database Connection Fails

1. Check MariaDB is running: `sudo service mariadb status`
2. Restart MariaDB: `sudo service mariadb restart`
3. Verify connection details (host: localhost, user: root, password: empty)

### Permission Denied Errors

```bash
sudo chown -R vscode:vscode /workspace
```

## Learning Resources

### PHP
- [PHP Manual](https://www.php.net/manual/en/)
- [W3Schools PHP Tutorial](https://www.w3schools.com/php/)

### MySQL/MariaDB
- [MySQL Tutorial](https://dev.mysql.com/doc/mysql-tutorial-excerpt/8.0/en/)
- [W3Schools SQL Tutorial](https://www.w3schools.com/sql/)

### HTML & CSS
- [MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web)
- [W3Schools HTML Tutorial](https://www.w3schools.com/html/)

## Support

For issues with the container setup, please open an issue on the repository.

For course-specific questions, contact your instructor.
