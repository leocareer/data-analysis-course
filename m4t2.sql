-- MySQL dump 10.13  Distrib 8.0.36, for macos14 (arm64)
--
-- Host: localhost    Database: m4t2
-- ------------------------------------------------------
-- Server version	8.0.37

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
-- Table structure for table `bbdd_union_nenes`
--

DROP TABLE IF EXISTS `bbdd_union_nenes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bbdd_union_nenes` (
  `NOM` text,
  `VEGADES` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bbdd_union_nenes`
--

LOCK TABLES `bbdd_union_nenes` WRITE;
/*!40000 ALTER TABLE `bbdd_union_nenes` DISABLE KEYS */;
INSERT INTO `bbdd_union_nenes` VALUES ('JULIA',469),('EMMA',442),('MARTINA',439),('LUCIA',380),('MIA',379),('ONA',363),('SOFIA',356),('LAIA',345),('ABRIL',323),('MARIA',322),('kai',200);
/*!40000 ALTER TABLE `bbdd_union_nenes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bbdd_union_nens`
--

DROP TABLE IF EXISTS `bbdd_union_nens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bbdd_union_nens` (
  `NOM` text,
  `VEGADES` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bbdd_union_nens`
--

LOCK TABLES `bbdd_union_nens` WRITE;
/*!40000 ALTER TABLE `bbdd_union_nens` DISABLE KEYS */;
INSERT INTO `bbdd_union_nens` VALUES ('MARC',479),('JAN',449),('NIL',432),('POL',430),('LEO',421),('ALEX',398),('MARTI',385),('PAU',359),('BIEL',354),('LUCAS',334),('kai',200);
/*!40000 ALTER TABLE `bbdd_union_nens` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-12 17:17:33
