-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: gaming_behavior
-- ------------------------------------------------------
-- Server version	8.0.36

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
-- Table structure for table `online_gaming_behavior`
--

DROP TABLE IF EXISTS `online_gaming_behavior`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `online_gaming_behavior` (
  `PlayerID` int DEFAULT NULL,
  `Age` int DEFAULT NULL,
  `Gender` varchar(10) DEFAULT NULL,
  `Location` varchar(100) DEFAULT NULL,
  `PlayTimeHours` decimal(5,2) DEFAULT NULL,
  `SessionsPerWeek` decimal(5,2) DEFAULT NULL,
  `AvgSessionDurationMinutes` decimal(5,2) DEFAULT NULL,
  `EngagementLevel` varchar(50) DEFAULT NULL,
  `GameGenre` varchar(50) DEFAULT NULL,
  `GameDifficulty` varchar(50) DEFAULT NULL,
  `PlayerLevel` decimal(5,2) DEFAULT NULL,
  `AchievementsUnlocked` decimal(5,2) DEFAULT NULL,
  `InGamePurchases` decimal(10,2) DEFAULT NULL,
  `Age_range` varchar(20) DEFAULT NULL,
  `PlayTimeHours_range` varchar(20) DEFAULT NULL,
  `SessionsPerWeek_range` varchar(20) DEFAULT NULL,
  `AvgSessionDurationMinutes_range` varchar(20) DEFAULT NULL,
  `PlayerLevel_range` varchar(20) DEFAULT NULL,
  `AchievementsUnlocked_range` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `online_gaming_behavior`
--

LOCK TABLES `online_gaming_behavior` WRITE;
/*!40000 ALTER TABLE `online_gaming_behavior` DISABLE KEYS */;
/*!40000 ALTER TABLE `online_gaming_behavior` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-11 23:44:10
