-- MySQL dump 10.13  Distrib 8.0.23, for Win64 (x86_64)
--
-- Host: localhost    Database: sales
-- ------------------------------------------------------
-- Server version	8.0.23

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
  `CUS_CODE` int NOT NULL,
  `CUS_LNAME` varchar(15) NOT NULL,
  `CUS_FNAME` varchar(15) NOT NULL,
  `CUS_INITIAL` char(1) DEFAULT NULL,
  `CUS_AREACODE` char(3) NOT NULL DEFAULT '615',
  `CUS_PHONE` char(8) NOT NULL,
  `CUS_BALANCE` decimal(9,2) DEFAULT '0.00',
  PRIMARY KEY (`CUS_CODE`),
  UNIQUE KEY `CUS_UI1` (`CUS_LNAME`,`CUS_FNAME`),
  CONSTRAINT `customer_chk_1` CHECK ((`CUS_AREACODE` in (_utf8mb4'615',_utf8mb4'713',_utf8mb4'931')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1007,'Bond','James',NULL,'615','555-1234',0.00);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice` (
  `INV_NUMBER` int NOT NULL AUTO_INCREMENT,
  `CUS_CODE` int NOT NULL,
  `INV_DATE` date NOT NULL DEFAULT (curdate()),
  PRIMARY KEY (`INV_NUMBER`),
  KEY `CUS_CODE` (`CUS_CODE`),
  CONSTRAINT `invoice_ibfk_1` FOREIGN KEY (`CUS_CODE`) REFERENCES `customer` (`CUS_CODE`),
  CONSTRAINT `INV_CK1` CHECK ((`INV_DATE` > _utf8mb4'2018-01-01'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice`
--

LOCK TABLES `invoice` WRITE;
/*!40000 ALTER TABLE `invoice` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `line`
--

DROP TABLE IF EXISTS `line`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `line` (
  `INV_NUMBER` int NOT NULL,
  `LINE_NUMBER` decimal(2,0) NOT NULL,
  `P_CODE` varchar(10) NOT NULL,
  `LINE_UNITS` decimal(9,2) NOT NULL DEFAULT '0.00',
  `LINE_PRICE` decimal(9,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`INV_NUMBER`,`LINE_NUMBER`),
  UNIQUE KEY `LINE_UI1` (`INV_NUMBER`,`P_CODE`),
  KEY `P_CODE` (`P_CODE`),
  CONSTRAINT `line_ibfk_1` FOREIGN KEY (`INV_NUMBER`) REFERENCES `invoice` (`INV_NUMBER`) ON DELETE CASCADE,
  CONSTRAINT `line_ibfk_2` FOREIGN KEY (`P_CODE`) REFERENCES `product` (`P_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `line`
--

LOCK TABLES `line` WRITE;
/*!40000 ALTER TABLE `line` DISABLE KEYS */;
/*!40000 ALTER TABLE `line` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `P_CODE` varchar(10) NOT NULL,
  `P_DESCRIPT` varchar(35) NOT NULL,
  `P_INDATE` date NOT NULL,
  `P_QOH` smallint NOT NULL,
  `P_MIN` smallint NOT NULL,
  `P_PRICE` decimal(8,2) NOT NULL,
  `P_DISCOUNT` decimal(5,2) NOT NULL,
  `V_CODE` int DEFAULT NULL,
  PRIMARY KEY (`P_CODE`),
  UNIQUE KEY `P_CODE` (`P_CODE`),
  KEY `P_INDATEX` (`P_INDATE`),
  KEY `VENPRODX` (`V_CODE`,`P_CODE`),
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`V_CODE`) REFERENCES `vendor` (`V_CODE`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES ('13-Q2/P2','7.25-in. pwr. saw blade','2014-07-14',32,10,16.99,0.05,21225);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendor`
--

DROP TABLE IF EXISTS `vendor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendor` (
  `V_CODE` int NOT NULL,
  `V_NAME` varchar(35) NOT NULL,
  `V_CONTACT` varchar(25) NOT NULL,
  `V_AREACODE` char(3) NOT NULL,
  `V_PHONE` char(8) NOT NULL,
  `V_STATE` char(2) NOT NULL,
  `V_ORDER` char(1) NOT NULL,
  PRIMARY KEY (`V_CODE`),
  UNIQUE KEY `V_CODE` (`V_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendor`
--

LOCK TABLES `vendor` WRITE;
/*!40000 ALTER TABLE `vendor` DISABLE KEYS */;
INSERT INTO `vendor` VALUES (21225,'Bryson, Inc.','Smithson','615','223-3234','TN','Y'),(21226,'Superloo, Inc.','Flushing','904','215-8995','FL','N');
/*!40000 ALTER TABLE `vendor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'sales'
--

--
-- Dumping routines for database 'sales'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-10  0:21:13
