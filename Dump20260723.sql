-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: voyage_db
-- ------------------------------------------------------
-- Server version	8.0.44

CREATE DATABASE IF NOT EXISTS VOYAGE_DB;
USE VOYAGE_DB;

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
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking` (
  `BID` int NOT NULL AUTO_INCREMENT,
  `UID` int DEFAULT NULL,
  `PID` int DEFAULT NULL,
  `START_DATE` date DEFAULT NULL,
  `END_DATE` date DEFAULT NULL,
  `STATUS` varchar(20) DEFAULT 'PENDING',
  PRIMARY KEY (`BID`),
  KEY `UID` (`UID`),
  KEY `PID` (`PID`),
  CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`UID`) REFERENCES `user` (`UID`),
  CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`PID`) REFERENCES `package` (`PID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
INSERT INTO `booking` VALUES (1,2,3,'2026-07-24','2026-07-26','APPROVED'),(2,2,2,'2026-07-24','2026-07-27','REJECTED'),(3,2,2,'2026-07-24','2026-07-26','APPROVED'),(4,2,2,'2026-07-24','2026-07-26','APPROVED'),(5,2,2,'2026-07-24','2026-07-26','APPROVED'),(6,2,2,'2026-07-24','2026-07-26','REJECTED'),(7,3,5,'2026-07-24','2026-07-28','APPROVED'),(8,3,1,'2026-07-24','2026-07-26','REJECTED'),(9,5,3,'2026-07-24','2026-07-29','APPROVED'),(10,6,4,'2026-07-24','2026-07-30','REJECTED');
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `has_location`
--

DROP TABLE IF EXISTS `has_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `has_location` (
  `HLID` int NOT NULL AUTO_INCREMENT,
  `PID` int DEFAULT NULL,
  `LID` int DEFAULT NULL,
  PRIMARY KEY (`HLID`),
  KEY `PID` (`PID`),
  KEY `LID` (`LID`),
  CONSTRAINT `has_location_ibfk_1` FOREIGN KEY (`PID`) REFERENCES `package` (`PID`),
  CONSTRAINT `has_location_ibfk_2` FOREIGN KEY (`LID`) REFERENCES `location` (`LID`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `has_location`
--

LOCK TABLES `has_location` WRITE;
/*!40000 ALTER TABLE `has_location` DISABLE KEYS */;
INSERT INTO `has_location` VALUES (10,1,115),(11,1,116),(12,1,117),(13,1,118),(14,1,119),(15,2,125),(16,2,126),(17,2,127),(18,2,128),(19,2,129),(20,3,100),(21,3,101),(22,3,102),(23,3,103),(24,3,104),(25,4,120),(26,4,121),(27,4,122),(28,4,123),(29,4,124),(30,5,110),(31,5,111),(32,5,112),(33,5,113),(34,5,114),(35,6,105),(36,6,106),(37,6,107),(38,6,108),(39,6,109);
/*!40000 ALTER TABLE `has_location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image`
--

DROP TABLE IF EXISTS `image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `image` (
  `IMG_ID` int NOT NULL AUTO_INCREMENT,
  `URL` varchar(100) DEFAULT NULL,
  `LID` int DEFAULT NULL,
  PRIMARY KEY (`IMG_ID`),
  KEY `LID` (`LID`),
  CONSTRAINT `image_ibfk_1` FOREIGN KEY (`LID`) REFERENCES `location` (`LID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image`
--

LOCK TABLES `image` WRITE;
/*!40000 ALTER TABLE `image` DISABLE KEYS */;
/*!40000 ALTER TABLE `image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `location` (
  `LID` int NOT NULL AUTO_INCREMENT,
  `LNAME` varchar(50) NOT NULL,
  `ADDRESS` varchar(100) NOT NULL,
  `DESCRIPTION` varchar(500) DEFAULT NULL,
  `CITY_NAME` varchar(30) DEFAULT NULL,
  `IMAGE_PATH` varchar(150) DEFAULT NULL,
  `PID` int DEFAULT NULL,
  PRIMARY KEY (`LID`),
  KEY `PID` (`PID`),
  CONSTRAINT `location_ibfk_1` FOREIGN KEY (`PID`) REFERENCES `package` (`PID`)
) ENGINE=InnoDB AUTO_INCREMENT=130 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
INSERT INTO `location` VALUES (100,'Abbey Falls','Coorg, Karnataka','Abbey Falls is one of the most famous waterfalls in Coorg. Surrounded by coffee plantations and spice estates, the waterfall cascades from a height of about 70 feet, creating a spectacular sight.','Coorg','images/c1k.jpg',3),(101,'Rajas Seat','Coorg, Karnataka','Rajas Seat is a beautiful garden and viewpoint that was once the favorite relaxation spot of Kodagu kings. It offers stunning views of valleys, green hills, and mesmerizing sunsets.','Coorg','images/c2k.jpg',3),(102,'Nagarhole National Park','Coorg, Karnataka','Nagarhole National Park is one of India\'s premier wildlife reserves. It is home to elephants, tigers, leopards, deer, and hundreds of bird species, making it a favorite destination for wildlife safaris.','Coorg','images/c3k.jpg',3),(103,'Mandalpatti View Point','Coorg, Karnataka','Mandalpatti is a scenic hilltop viewpoint famous for its panoramic views of the Western Ghats.','Coorg','images/c4k.jpg',3),(104,'Madikeri Fort','Coorg, Karnataka','Madikeri Fort is a historic fort built in the 17th century.','Coorg','images/c5k.jpg',3),(105,'Stone Chariot','Hampi, Karnataka','The Stone Chariot is the most recognizable monument of Hampi.','Hampi','images/h1k.jpg',6),(106,'Lotus Mahal','Hampi, Karnataka','Lotus Mahal is a beautiful palace known for its lotus-shaped architecture.','Hampi','images/h2k.jpeg',6),(107,'Elephant Stables','Hampi, Karnataka','The Elephant Stables once housed the royal elephants of the Vijayanagara Empire.','Hampi','images/h3k.jpg',6),(108,'Royal Enclosure','Hampi, Karnataka','The Royal Enclosure was the administrative center of the Vijayanagara Empire.','Hampi','images/h4k.jpg',6),(109,'Tungabhadra River','Hampi, Karnataka','The Tungabhadra River flows through Hampi and offers beautiful views.','Hampi','images/h5k.jpg',6),(110,'Fort Kochi','Kochi, Kerala','Historic seaside area famous for colonial architecture.','Kochi','images/k1k.jpg',5),(111,'Mattancherry Palace','Kochi, Kerala','Also known as the Dutch Palace.','Kochi','images/k2k.jpg',5),(112,'Marine Drive','Kochi, Kerala','Popular waterfront promenade.','Kochi','images/k3k.jpg',5),(113,'Jew Town and Paradesi Synagogue','Kochi, Kerala','Historic neighborhood and synagogue.','Kochi','images/k4k.jpg',5),(114,'Cherai Beach','Kochi, Kerala','Beautiful beach with golden sand.','Kochi','images/k5k.jpg',5),(115,'Eravikulam National Park','Munnar, Kerala','National park famous for the Nilgiri Tahr.','Munnar','images/m1k.jpg',1),(116,'Mattupetty Dam','Munnar, Kerala','Scenic reservoir surrounded by hills.','Munnar','images/m2k.jpg',1),(117,'Tea Museum','Munnar, Kerala','Museum showcasing tea cultivation history.','Munnar','images/m3k.jpeg',1),(118,'Top Station','Munnar, Kerala','Highest viewpoint in Munnar.','Munnar','images/m4k.jpg',1),(119,'Attukad Waterfalls','Munnar, Kerala','Beautiful waterfall surrounded by forests.','Munnar','images/m5k.jpg',1),(120,'Mysuru Palace','Mysore, Karnataka','Magnificent royal palace.','Mysore','images/a1m.jpg',4),(121,'Brindavan Gardens','Mysore, Karnataka','Beautifully landscaped gardens.','Mysore','images/a2m.jpg',4),(122,'St. Philomenas Church','Mysore, Karnataka','Neo-Gothic church.','Mysore','images/a3m.jpg',4),(123,'Railway Museum','Mysore, Karnataka','Museum showcasing Indian Railway history.','Mysore','images/a4m.jpg',4),(124,'Karanji Lake','Mysore, Karnataka','Freshwater lake with bird sanctuary.','Mysore','images/a5m.jpg',4),(125,'Dudhsagar Falls','Goa, India','One of India\'s tallest waterfalls.','Goa','images/b1g.jpg',2),(126,'Candolim Beach','Goa, India','Popular beach with water sports.','Goa','images/b2g.jpg',2),(127,'Baga Beach','Goa, India','Famous beach with nightlife.','Goa','images/b3g.jpg',2),(128,'Basilica of Bom Jesus','Goa, India','UNESCO World Heritage Site.','Goa','images/b4g.jpg',2),(129,'Arambol Sweet Water Lake','Goa, India','Freshwater lake near Arambol Beach.','Goa','images/b5g.jpg',2);
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `package`
--

DROP TABLE IF EXISTS `package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `package` (
  `PID` int NOT NULL AUTO_INCREMENT,
  `PNAME` varchar(50) NOT NULL,
  `PRICE` double DEFAULT NULL,
  `NO_OF_DAYS` int DEFAULT NULL,
  PRIMARY KEY (`PID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package`
--

LOCK TABLES `package` WRITE;
/*!40000 ALTER TABLE `package` DISABLE KEYS */;
INSERT INTO `package` VALUES (1,'Altitude Adjustment',7000,5),(2,'Beach Bliss',9500,4),(3,'Coffee & Clouds',10000,7),(4,'Royal Reverie',6000,3),(5,'Coastal Charms',8000,6),(6,'Historic Heritage',5000,5);
/*!40000 ALTER TABLE `package` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `PAY_ID` int NOT NULL AUTO_INCREMENT,
  `PAY_MODE` varchar(30) DEFAULT NULL,
  `UID` int DEFAULT NULL,
  `PID` int DEFAULT NULL,
  `AMOUNT` double DEFAULT NULL,
  `TOTAL_AMT` double DEFAULT NULL,
  PRIMARY KEY (`PAY_ID`),
  KEY `PID` (`PID`),
  CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`PID`) REFERENCES `package` (`PID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (1,'UPI',3,5,8000,9440),(2,'UPI',5,3,10000,11800),(3,'UPI',3,5,8000,9440);
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `UID` int NOT NULL AUTO_INCREMENT,
  `UNAME` varchar(30) NOT NULL,
  `PHNO` varchar(30) NOT NULL,
  `EMAIL` varchar(100) NOT NULL,
  `PASSWORD` varchar(40) NOT NULL,
  PRIMARY KEY (`UID`),
  UNIQUE KEY `PHNO` (`PHNO`),
  UNIQUE KEY `EMAIL` (`EMAIL`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'veeresh','6666666666','veeru@gmail.com','v123'),(2,'ram','1234512345','ram@gmail.com','123'),(3,'sam','1234123412','sam@gmail.com','1234'),(5,'rahul','1231231231','rahul@gmail.com','1234'),(6,'punith s','9986592581','punith@gmail.com','123');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-23 14:30:21
