<?php
require "config.php";

$data       = json_decode(file_get_contents("php://input"), true);
$customerID = intval($data["customerID"] ?? 0);
$items      = $data["items"]            ?? [];
$total      = floatval($data["total"]   ?? 0);
$address    = $data["shippingAddress"]  ?? [];

if (!$customerID || empty($items) || $total <= 0 || empty($address)) {
    http_response_code(400);
    echo json_encode(["error" => "Invalid order data"]);
    exit;
}

$conn->begin_transaction();

try {
    $street   = $conn->real_escape_string($address["street"]   ?? "");
    $city     = $conn->real_escape_string($address["city"]     ?? "");
    $province = $conn->real_escape_string($address["province"] ?? "");
    $zip      = $conn->real_escape_string($address["zip"]      ?? "");

    $addressID = ($conn->query("SELECT MAX(addressID) as m FROM shipping_address")->fetch_assoc()["m"] ?? 0) + 1;
    $conn->query("INSERT INTO shipping_address (addressID, customerID, streetAddress, city, province, postalCode)
                  VALUES ($addressID, $customerID, '$street', '$city', '$province', '$zip')");

    $orderID = ($conn->query("SELECT MAX(orderID) as m FROM `order`")->fetch_assoc()["m"] ?? 0) + 1;
    $conn->query("INSERT INTO `order` (orderID, customerID, orderStatus, addressID, totalAmount)
                  VALUES ($orderID, $customerID, 'Pending', $addressID, $total)");

    $itemIDCounter = ($conn->query("SELECT MAX(orderItemID) as m FROM order_item")->fetch_assoc()["m"] ?? 0) + 1;

    foreach ($items as $item) {
        $productID = intval($item["id"]);
        $quantity  = intval($item["quantity"]);
        $unitPrice = floatval($item["price"]);

        // Check stock before inserting
        $stockRow = $conn->query("SELECT stockQuantity FROM product WHERE productID = $productID")->fetch_assoc();
        if (!$stockRow || $stockRow["stockQuantity"] < $quantity) {
            throw new Exception("Insufficient stock for product ID $productID");
        }

        $conn->query("INSERT INTO order_item (orderItemID, orderID, productID, quantity, unitPrice)
                      VALUES ($itemIDCounter, $orderID, $productID, $quantity, $unitPrice)");

        $conn->query("UPDATE product SET stockQuantity = stockQuantity - $quantity WHERE productID = $productID");

        $itemIDCounter++;
    }

    $conn->commit();
    http_response_code(201);
    echo json_encode(["success" => true, "orderID" => $orderID, "message" => "Order placed successfully"]);

} catch (Exception $e) {
    $conn->rollback();
    http_response_code(500);
    echo json_encode(["error" => "Failed to create order: " . $e->getMessage()]);
}

$conn->close();
?>