<?php
$host = 'db';
$user = 'root';
$pass = 'password';
$db = 'test_db';

$conn = new mysqli($host, $user, $pass, $db);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Create table if not exists
$conn->query("CREATE TABLE IF NOT EXISTS test_table (id INT AUTO_INCREMENT PRIMARY KEY, data VARCHAR(255) NOT NULL)");

// Insert a new record
$conn->query("INSERT INTO test_table (data) VALUES ('Sample data')");

// Read records
$result = $conn->query("SELECT * FROM test_table");

echo "<h1>Data from test_table:</h1>";
while ($row = $result->fetch_assoc()) {
    echo "<p>ID: " . $row['id'] . " - Data: " . $row['data'] . "</p>";
}

$conn->close();
?>
