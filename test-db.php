<?php
// Test database connection
$servername = "localhost";
$username = "root";
$password = "";

try {
    $conn = new mysqli($servername, $username, $password);
    
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }
    
    echo "<h1>Database Connection Test</h1>";
    echo "<p style='color: green;'>✓ Successfully connected to MariaDB!</p>";
    echo "<p>Server version: " . $conn->server_info . "</p>";
    
    // Show databases
    $result = $conn->query("SHOW DATABASES");
    echo "<h2>Available Databases:</h2>";
    echo "<ul>";
    while($row = $result->fetch_assoc()) {
        echo "<li>" . $row["Database"] . "</li>";
    }
    echo "</ul>";
    
    $conn->close();
} catch (Exception $e) {
    echo "<h1>Database Connection Test</h1>";
    echo "<p style='color: red;'>✗ Connection failed: " . $e->getMessage() . "</p>";
}
?>
<hr>
<p><a href="welcome.html">← Back to Welcome</a></p>
