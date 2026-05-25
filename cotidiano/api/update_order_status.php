<?php
require "config.php";

$data    = json_decode(file_get_contents("php://input"), true);
$orderID = (int)$data["orderID"];
$status  = $conn->real_escape_string($data["status"]);

$conn->query("UPDATE `order` SET orderStatus='$status' WHERE orderID=$orderID");

echo json_encode(["message" => "Status updated."]);
$conn->close();
?>