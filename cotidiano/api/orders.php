<?php
require "config.php";

$customerID = isset($_GET['customerID']) ? intval($_GET['customerID']) : 0;

if ($customerID) {
    // Get orders for specific customer
    $result = $conn->query("
        SELECT o.orderID, o.orderDate, o.orderStatus, o.totalAmount,
               c.firstName, c.lastName, c.phoneNumber,
               sa.streetAddress, sa.city, sa.province, sa.postalCode
        FROM `order` o
        JOIN customer c ON o.customerID = c.customerID
        JOIN shipping_address sa ON o.addressID = sa.addressID
        WHERE o.customerID = $customerID
        ORDER BY o.orderDate DESC
    ");
} else {
    // Get ALL orders (admin dashboard)
    $result = $conn->query("
        SELECT o.orderID, o.orderDate, o.orderStatus, o.totalAmount,
               c.firstName, c.lastName, c.phoneNumber,
               sa.streetAddress, sa.city, sa.province, sa.postalCode
        FROM `order` o
        JOIN customer c ON o.customerID = c.customerID
        JOIN shipping_address sa ON o.addressID = sa.addressID
        ORDER BY o.orderDate DESC
    ");
}

$orders = [];
while ($row = $result->fetch_assoc()) {
    $orderID = $row['orderID'];

    // Get items for this order
    $items_result = $conn->query("
        SELECT oi.quantity, oi.unitPrice, p.productName
        FROM order_item oi
        JOIN product p ON oi.productID = p.productID
        WHERE oi.orderID = $orderID
    ");

    $items = [];
    while ($item = $items_result->fetch_assoc()) {
        $items[] = [
            "productName" => $item['productName'],
            "quantity"    => intval($item['quantity']),
            "unitPrice"   => floatval($item['unitPrice']),
            // Also add camelCase versions for compatibility
            "name"        => $item['productName'],
            "price"       => floatval($item['unitPrice'])
        ];
    }

    $orders[] = [
        // Admin format (snake_case/original field names)
        "orderID"     => $orderID,
        "orderDate"   => $row['orderDate'],
        "orderStatus" => $row['orderStatus'],
        "totalAmount" => floatval($row['totalAmount']),
        "customer"    => $row['firstName'] . " " . $row['lastName'],
        "address"     => $row['streetAddress'] . ", " . $row['city'] . ", " . $row['province'],
        "items"       => $items,
        
        // Account format (camelCase)
        "orderId"         => $orderID,
        "date"            => $row['orderDate'],
        "status"          => $row['orderStatus'],
        "total"           => floatval($row['totalAmount']),
        "shippingAddress" => [
            "street"   => $row['streetAddress'],
            "city"     => $row['city'],
            "province" => $row['province'],
            "zip"      => $row['postalCode'],
            "phone"    => $row['phoneNumber'] ?? ""
        ]
    ];
}

echo json_encode($orders);
$conn->close();
?>