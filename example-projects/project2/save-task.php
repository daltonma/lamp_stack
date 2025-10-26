<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $task = htmlspecialchars($_POST['task'] ?? '');
    
    if (!empty($task)) {
        // In a real app, you'd save to database
        // For this example, we'll just display it
        echo "<!DOCTYPE html>";
        echo "<html lang='en'>";
        echo "<head>";
        echo "<meta charset='UTF-8'>";
        echo "<title>Task Saved</title>";
        echo "<style>
            body {
                font-family: Arial, sans-serif;
                max-width: 600px;
                margin: 50px auto;
                padding: 20px;
                background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
                color: white;
                text-align: center;
            }
            .success {
                background: rgba(255,255,255,0.2);
                padding: 20px;
                border-radius: 10px;
                margin: 20px 0;
            }
            a {
                color: #ffd700;
            }
        </style>";
        echo "</head>";
        echo "<body>";
        echo "<h1>Task Saved!</h1>";
        echo "<div class='success'>";
        echo "<p>Your task: <strong>" . $task . "</strong></p>";
        echo "<p><em>In a real application, this would be saved to the database.</em></p>";
        echo "</div>";
        echo "<p><a href='index.html'>← Back to Task Manager</a></p>";
        echo "</body>";
        echo "</html>";
    } else {
        header('Location: index.html');
    }
} else {
    header('Location: index.html');
}
?>
