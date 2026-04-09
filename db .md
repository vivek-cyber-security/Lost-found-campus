<?php
/**
 * db.php — Database Connection
 * Lost & Found Campus System
 * --------------------------------
 * Include this file in any PHP page that needs DB access.
 * Uses MySQLi (procedural style for simplicity).
 */

define('DB_HOST', 'localhost');
define('DB_USER', 'root');        // Change if needed
define('DB_PASS', '');            // Change if needed
define('DB_NAME', 'lost_found_campus');

// Create connection
$conn = mysqli_connect(DB_HOST, DB_USER, DB_PASS, DB_NAME);

// Check connection
if (!$conn) {
    die('<div style="font-family:Poppins,sans-serif;padding:30px;color:red;">
        <h2>Database Connection Failed</h2>
        <p>' . mysqli_connect_error() . '</p>
        <p>Please check your XAMPP MySQL is running and db credentials in <strong>db.php</strong>.</p>
    </div>');
}

// Set charset to UTF-8
mysqli_set_charset($conn, 'utf8');
?>
