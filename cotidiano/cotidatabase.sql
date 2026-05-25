-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: cotidiano_database
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `customerID` int NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phoneNumber` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`customerID`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `email_2` (`email`),
  KEY `idx_email` (`email`),
  KEY `idx_name` (`lastName`,`firstName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Levan','Reganion','reganionLevan@gmail.com','555-0101'),(2,'Kian','Inovejas','kianInovehaj@gmail.com','555-0102'),(3,'Sheena','Muego','sheenMuego@gmail.com','555-0103'),(4,'Emily','Brown','emily.brown@email.com','555-0104'),(5,'David','Wilson','david.w@email.com','555-0105'),(6,'Sarah','Martinez','sarah.m@email.com','555-0106'),(7,'James','Garcia','james.g@email.com','555-0107'),(8,'Jennifer','Rodriguez','jennifer.r@email.com','555-0108'),(9,'Robert','Lee','robert.lee@email.com','555-0109'),(10,'Lisa','Taylor','lisa.t@email.com','555-0110'),(11,'William','Anderson','william.a@email.com','555-0111'),(12,'Maria','Thomas','maria.t@email.com','555-0112'),(13,'Richard','Jackson','richard.j@email.com','555-0113'),(14,'Patricia','White','patricia.w@email.com','555-0114'),(15,'Christopher','Harris','chris.h@email.com','555-0115'),(16,'Ayela','Reganion','ayela.dango@email.com','345-6789'),(17,'Alfonzo','Anuat','Alfonzo.anuat@email.com','345-6799');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `orderID` int NOT NULL,
  `customerID` int NOT NULL,
  `orderDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `orderStatus` varchar(50) NOT NULL DEFAULT 'Pending',
  `addressID` int NOT NULL,
  `totalAmount` decimal(10,2) NOT NULL,
  PRIMARY KEY (`orderID`),
  KEY `addressID` (`addressID`),
  KEY `idx_customer_order` (`customerID`),
  KEY `idx_order_date` (`orderDate`),
  KEY `idx_order_status` (`orderStatus`),
  CONSTRAINT `order_ibfk_1` FOREIGN KEY (`customerID`) REFERENCES `customer` (`customerID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `order_ibfk_2` FOREIGN KEY (`addressID`) REFERENCES `shipping_address` (`addressID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `order_chk_1` CHECK ((`totalAmount` >= 0)),
  CONSTRAINT `order_chk_2` CHECK ((`orderStatus` in (_utf8mb4'Pending',_utf8mb4'Processing',_utf8mb4'Shipped',_utf8mb4'Delivered',_utf8mb4'Cancelled')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (1,1,'2026-01-15 10:30:00','Delivered',1,1136.00),(2,2,'2026-01-16 14:20:00','Delivered',2,3270.00),(3,3,'2026-01-18 09:15:00','Delivered',3,636.00),(4,4,'2026-01-20 16:45:00','Processing',4,3446.00),(5,5,'2026-01-22 11:00:00','Delivered',5,1636.00),(6,1,'2026-01-25 13:30:00','Delivered',11,570.00),(7,6,'2026-01-27 10:00:00','Shipped',6,2772.00),(8,7,'2026-01-28 15:20:00','Processing',7,1186.00),(9,8,'2026-02-01 09:45:00','Pending',8,1691.00),(10,2,'2026-02-02 14:10:00','Delivered',12,1736.00),(11,9,'2026-02-03 11:30:00','Processing',9,1750.00),(12,10,'2026-02-04 16:00:00','Pending',10,2420.00);
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_item`
--

DROP TABLE IF EXISTS `order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_item` (
  `orderItemID` int NOT NULL,
  `orderID` int NOT NULL,
  `productID` int NOT NULL,
  `quantity` int NOT NULL,
  `unitPrice` decimal(10,2) NOT NULL,
  PRIMARY KEY (`orderItemID`),
  KEY `idx_order` (`orderID`),
  KEY `idx_product` (`productID`),
  CONSTRAINT `order_item_ibfk_1` FOREIGN KEY (`orderID`) REFERENCES `order` (`orderID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `order_item_ibfk_2` FOREIGN KEY (`productID`) REFERENCES `product` (`productID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `order_item_chk_1` CHECK ((`quantity` > 0)),
  CONSTRAINT `order_item_chk_2` CHECK ((`unitPrice` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_item`
--

LOCK TABLES `order_item` WRITE;
/*!40000 ALTER TABLE `order_item` DISABLE KEYS */;
INSERT INTO `order_item` VALUES (1,1,1,1,636.00),(2,1,2,1,500.00),(3,2,3,2,1000.00),(4,2,5,1,750.00),(5,2,7,1,520.00),(6,3,4,1,636.00),(7,4,9,2,580.00),(8,4,11,1,636.00),(9,4,15,1,650.00),(10,4,6,1,1000.00),(11,5,8,1,636.00),(12,5,3,1,1000.00),(13,6,7,1,570.00),(14,7,1,2,636.00),(15,7,10,1,500.00),(16,7,12,1,1000.00),(17,8,14,1,636.00),(18,8,13,1,550.00),(19,9,2,1,500.00),(20,9,4,1,636.00),(21,9,6,1,555.00),(22,10,5,1,636.00),(23,10,11,1,1100.00),(24,11,9,1,580.00),(25,11,15,1,650.00),(26,11,7,1,520.00),(27,12,8,2,460.00),(28,12,10,1,780.00),(29,12,3,1,720.00);
/*!40000 ALTER TABLE `order_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `paymentID` int NOT NULL,
  `orderID` int NOT NULL,
  `paymentMethod` varchar(50) NOT NULL,
  `paymentDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `paymentAmount` decimal(10,2) NOT NULL,
  `paymentStatus` varchar(50) NOT NULL DEFAULT 'Pending',
  PRIMARY KEY (`paymentID`),
  UNIQUE KEY `orderID` (`orderID`),
  KEY `idx_payment_status` (`paymentStatus`),
  CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`orderID`) REFERENCES `order` (`orderID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `payment_chk_1` CHECK ((`paymentAmount` >= 0)),
  CONSTRAINT `payment_chk_2` CHECK ((`paymentMethod` in (_utf8mb4'Credit Card',_utf8mb4'Debit Card',_utf8mb4'PayPal',_utf8mb4'Cash',_utf8mb4'Bank Transfer'))),
  CONSTRAINT `payment_chk_3` CHECK ((`paymentStatus` in (_utf8mb4'Pending',_utf8mb4'Completed',_utf8mb4'Failed',_utf8mb4'Refunded')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (1,1,'Credit Card','2026-01-15 10:35:00',1136.00,'Completed'),(2,2,'PayPal','2026-01-16 14:25:00',3270.00,'Completed'),(3,3,'Debit Card','2026-01-18 09:20:00',636.00,'Completed'),(4,4,'Credit Card','2026-01-20 16:50:00',3446.00,'Pending'),(5,5,'Cash','2026-01-22 11:05:00',1636.00,'Completed'),(6,6,'Credit Card','2026-01-25 13:35:00',570.00,'Completed'),(7,7,'PayPal','2026-01-27 10:05:00',2772.00,'Completed'),(8,8,'Debit Card','2026-01-28 15:25:00',1186.00,'Pending'),(9,9,'Credit Card','2026-02-01 09:50:00',1691.00,'Pending'),(10,10,'Bank Transfer','2026-02-02 14:15:00',1736.00,'Completed'),(11,11,'Credit Card','2026-02-03 11:35:00',1750.00,'Pending'),(12,12,'PayPal','2026-02-04 16:05:00',2420.00,'Pending');
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `productID` int NOT NULL,
  `productName` varchar(50) NOT NULL,
  `description` text,
  `price` decimal(10,2) NOT NULL,
  `stockQuantity` int NOT NULL DEFAULT '0',
  `size_ML` int DEFAULT '30',
  `Image_url` varchar(255) NOT NULL,
  `family` varchar(100) DEFAULT 'Cotidiano Fragrance',
  `category` enum('male','female','unisex') DEFAULT 'unisex',
  `badge` varchar(50) DEFAULT NULL,
  `notes_top` varchar(255) DEFAULT '–',
  `notes_heart` varchar(255) DEFAULT '–',
  `notes_base` varchar(255) DEFAULT '–',
  PRIMARY KEY (`productID`),
  KEY `idx_product_name` (`productName`),
  CONSTRAINT `product_chk_1` CHECK ((`price` >= 0)),
  CONSTRAINT `product_chk_2` CHECK ((`stockQuantity` >= 0)),
  CONSTRAINT `product_chk_3` CHECK ((`size_ML` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'Amor','Romantic floral scent perfect for special occasions',636.00,100,50,'https://example.com/images/amor.jpg','Cotidiano Fragrance','female',NULL,'Rose','Peony','Vanilla'),(2,'AHS','Fresh and sophisticated everyday fragrance',99.00,85,50,'https://example.com/images/ahs.jpg','Cotidiano Fragrance','unisex',NULL,'Bergamot','Jasmine','Musk'),(3,'The Wanted','Bold and confident masculine scent',636.00,120,50,'https://example.com/images/the-wanted.jpg','Cotidiano Fragrance','male',NULL,'Lemon','Cedarwood','Amber'),(4,'Urban','Citrusy floral blend ideal for daily wear',636.00,95,50,'https://example.com/images/urban.jpg','Cotidiano Fragrance','unisex',NULL,'Grapefruit','Lilac','Sandalwood'),(5,'D\'Iconic','Clean and elegant modern fragrance',636.00,150,50,'https://example.com/images/diconic.jpg','Cotidiano Fragrance','unisex',NULL,'Lavender','Iris','Vetiver'),(6,'L\'Homme','Classic masculine scent with refined notes',636.00,70,50,'https://example.com/images/lhomme.jpg','Cotidiano Fragrance','male',NULL,'Anise','Almond','Cinnamon'),(7,'Born in Roma','Intense and luxurious evening fragrance',636.00,80,50,'https://example.com/images/born-in-roma.jpg','Cotidiano Fragrance','female',NULL,'Neroli','Rose','Oud'),(8,'Hibiscus Mahajad','Tropical floral with vanilla and musk notes, perfect for summer',636.00,110,50,'https://example.com/images/hibiscus-mahajad.jpg','Cotidiano Fragrance','female',NULL,'Hibiscus','Plumeria','Vanilla'),(9,'Maharlika','Premium Filipino-inspired fragrance',636.00,60,50,'https://example.com/images/maharlika.jpg','Cotidiano Fragrance','unisex',NULL,'Citrus','Magnolia','Coconut'),(10,'Talisman','Fresh citrus and musk blend, ideal for the soft aesthetic',636.00,140,50,'https://example.com/images/talisman.jpg','Cotidiano Fragrance','unisex',NULL,'Mandarin','Peach','Musk'),(11,'Curiosity V2','Elegant powdery scent with sophisticated appeal',636.00,90,50,'https://example.com/images/curiosity-v2.jpg','Cotidiano Fragrance','female',NULL,'Peach','Tuberose','Powder'),(12,'Coco Powder','Delicate and feminine powdery fragrance',636.00,105,50,'https://example.com/images/coco-powder.jpg','Cotidiano Fragrance','female',NULL,'Coconut','Gardenia','Amber'),(13,'Pleasure','Sweet and inviting scent for any occasion',636.00,88,50,'https://example.com/images/pleasure.jpg','Cotidiano Fragrance','female',NULL,'Orange Blossom','Vanilla','Caramel'),(14,'Sun Venom','Woody vanilla with cacao and amber, best for cooler weather',636.00,125,50,'https://example.com/images/sun-venom.jpg','Cotidiano Fragrance','male',NULL,'Cacao','Vanilla','Amber'),(15,'Salty Sea','Fresh aquatic ocean-inspired scent',636.00,45,50,'https://example.com/images/salty-sea.jpg','Cotidiano Fragrance','unisex',NULL,'Sea Salt','Aquatic','Driftwood');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `reviewID` int NOT NULL,
  `customerID` int NOT NULL,
  `productID` int NOT NULL,
  `rating` int NOT NULL,
  `reviewText` text,
  `reviewDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`reviewID`),
  KEY `customerID` (`customerID`),
  KEY `idx_product_review` (`productID`),
  KEY `idx_rating` (`rating`),
  CONSTRAINT `review_ibfk_1` FOREIGN KEY (`customerID`) REFERENCES `customer` (`customerID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `review_ibfk_2` FOREIGN KEY (`productID`) REFERENCES `product` (`productID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `review_chk_1` CHECK ((`rating` between 1 and 5))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (2,1,2,4,'Nice rose fragrance, lasts all day.','2026-01-20 15:10:00'),(3,2,3,5,'Love this ocean breeze smell!','2026-01-22 10:30:00'),(4,2,5,4,'Refreshing citrus scent, good for summer.','2026-01-22 10:35:00'),(5,3,4,5,'Perfect vanilla perfume!','2026-01-25 14:00:00'),(6,5,8,4,'Beautiful cherry blossom fragrance.','2026-01-28 09:15:00'),(7,5,3,5,'Fresh and clean scent!','2026-01-28 09:20:00'),(8,1,7,5,'Rich sandalwood, very luxurious.','2026-02-01 11:00:00'),(9,6,1,4,'Lovely lavender, calming.','2026-02-02 16:30:00'),(10,7,14,3,'Nice mint scent but fades quickly.','2026-02-03 13:00:00'),(11,2,11,5,'Tropical paradise indeed! Love it!','2026-02-04 10:00:00'),(12,8,2,4,'Classic rose smell, very elegant.','2026-02-04 14:20:00'),(13,9,4,5,'Warm vanilla, perfect for winter.','2026-02-05 09:00:00'),(14,10,5,4,'Energizing citrus burst!','2026-02-05 15:45:00'),(15,4,9,5,'Deep amber woods, absolutely gorgeous!','2026-02-05 18:00:00');
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipping_address`
--

DROP TABLE IF EXISTS `shipping_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipping_address` (
  `addressID` int NOT NULL,
  `customerID` int NOT NULL,
  `addressLabel` varchar(20) DEFAULT NULL,
  `streetAddress` varchar(200) NOT NULL,
  `city` varchar(50) NOT NULL,
  `province` varchar(50) NOT NULL,
  `postalCode` varchar(10) NOT NULL,
  `isDefault` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`addressID`),
  KEY `idx_customer` (`customerID`),
  CONSTRAINT `shipping_address_ibfk_1` FOREIGN KEY (`customerID`) REFERENCES `customer` (`customerID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipping_address`
--

LOCK TABLES `shipping_address` WRITE;
/*!40000 ALTER TABLE `shipping_address` DISABLE KEYS */;
INSERT INTO `shipping_address` VALUES (1,1,'Home','123 Main St','Manila','Metro Manila','1000',1),(2,2,'Home','456 Oak Ave','Quezon City','Metro Manila','1100',1),(3,3,'Home','789 Pine Rd','Makati','Metro Manila','1200',1),(4,4,'Office','321 Elm St','Pasig','Metro Manila','1600',1),(5,5,'Home','654 Maple Dr','Taguig','Metro Manila','1630',1),(6,6,'Home','987 Cedar Ln','Mandaluyong','Metro Manila','1550',1),(7,7,'Home','147 Birch Way','San Juan','Metro Manila','1500',1),(8,8,'Home','258 Spruce Ct','Pasay','Metro Manila','1300',1),(9,9,'Office','369 Willow St','Parañaque','Metro Manila','1700',1),(10,10,'Home','741 Ash Blvd','Las Piñas','Metro Manila','1740',1),(11,1,'Office','852 Cherry Ave','Manila','Metro Manila','1001',0),(12,2,'Parents','963 Poplar Rd','Antipolo','Rizal','1870',0),(13,11,'Home','159 Walnut Dr','Caloocan','Metro Manila','1400',1),(14,12,'Home','357 Hickory Ln','Malabon','Metro Manila','1470',1),(15,13,'Home','486 Pecan Way','Navotas','Metro Manila','1485',1);
/*!40000 ALTER TABLE `shipping_address` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-24 12:20:12
