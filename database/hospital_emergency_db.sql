-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: hospital_emergency_db
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ambulance`
--

DROP TABLE IF EXISTS `ambulance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ambulance` (
  `ambulance_id` int NOT NULL AUTO_INCREMENT,
  `vehicle_no` varchar(30) DEFAULT NULL,
  `type` varchar(60) DEFAULT NULL,
  `status` varchar(30) DEFAULT NULL,
  `hospital_id` int NOT NULL,
  `driver_name` varchar(120) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ambulance_id`),
  UNIQUE KEY `vehicle_no` (`vehicle_no`),
  KEY `hospital_id` (`hospital_id`),
  CONSTRAINT `ambulance_ibfk_1` FOREIGN KEY (`hospital_id`) REFERENCES `hospital` (`hospital_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ambulance`
--

LOCK TABLES `ambulance` WRITE;
/*!40000 ALTER TABLE `ambulance` DISABLE KEYS */;
INSERT INTO `ambulance` VALUES (1,'TEST-AMB-001','Basic Life Support','Available',1,'Test Driver A',NULL),(2,'TEST-AMB-002','Advanced Life Support','Available',2,'Test Driver B',NULL),(3,'TEST-AMB-003','Basic Life Support','On Duty',3,'Test Driver C',NULL),(4,'TEST-AMB-004','Advanced Life Support','Available',4,'Test Driver D',NULL),(5,'TEST-AMB-005','Basic Life Support','Available',5,'Test Driver E',NULL);
/*!40000 ALTER TABLE `ambulance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appointment`
--

DROP TABLE IF EXISTS `appointment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointment` (
  `appointment_id` int NOT NULL AUTO_INCREMENT,
  `patient_id` int NOT NULL,
  `doctor_id` int NOT NULL,
  `appointment_date` date DEFAULT NULL,
  `appointment_time` time DEFAULT NULL,
  `status` varchar(30) DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`appointment_id`),
  KEY `patient_id` (`patient_id`),
  KEY `doctor_id` (`doctor_id`),
  CONSTRAINT `appointment_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `appointment_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `doctor` (`doctor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment`
--

LOCK TABLES `appointment` WRITE;
/*!40000 ALTER TABLE `appointment` DISABLE KEYS */;
INSERT INTO `appointment` VALUES (1,1,1,'2026-11-03','10:00:00','Scheduled','Sample test appointment'),(2,2,2,'2026-11-04','11:00:00','Scheduled','Sample test appointment'),(3,3,3,'2026-11-05','12:00:00','Completed','Sample test appointment'),(4,4,4,'2026-11-06','13:00:00','Scheduled','Sample test appointment'),(5,5,5,'2026-11-07','14:00:00','Cancelled','Sample test appointment');
/*!40000 ALTER TABLE `appointment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `area`
--

DROP TABLE IF EXISTS `area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `area` (
  `area_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`area_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `area`
--

LOCK TABLES `area` WRITE;
/*!40000 ALTER TABLE `area` DISABLE KEYS */;
INSERT INTO `area` VALUES (1,'North Sadar Bazar','Locality','Solapur locality'),(2,'Railway Lines','Locality','Solapur locality'),(3,'Siddheshwar Peth','Locality','Solapur locality'),(4,'Samrat Chowk','Locality','Solapur locality'),(5,'Hotgi Road','Road','Solapur locality'),(6,'Duffrin Chowk','Locality','Solapur locality'),(7,'Ramwadi','Locality','Solapur locality'),(8,'Akkalkot Road','Road','Solapur locality'),(9,'Jule Solapur','Locality','Solapur locality'),(10,'Majrewadi','Locality','Solapur locality');
/*!40000 ALTER TABLE `area` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bed`
--

DROP TABLE IF EXISTS `bed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bed` (
  `bed_id` int NOT NULL AUTO_INCREMENT,
  `bed_type` varchar(50) DEFAULT NULL,
  `status` varchar(30) DEFAULT NULL,
  `room_no` varchar(20) DEFAULT NULL,
  `hospital_id` int NOT NULL,
  `department_id` int NOT NULL,
  PRIMARY KEY (`bed_id`),
  KEY `hospital_id` (`hospital_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `bed_ibfk_1` FOREIGN KEY (`hospital_id`) REFERENCES `hospital` (`hospital_id`),
  CONSTRAINT `bed_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bed`
--

LOCK TABLES `bed` WRITE;
/*!40000 ALTER TABLE `bed` DISABLE KEYS */;
INSERT INTO `bed` VALUES (1,'General','Available','G101',1,1),(2,'ICU','Occupied','I101',2,2),(3,'General','Available','G201',3,3),(4,'ICU','Available','I201',4,4),(5,'Emergency','Occupied','E101',5,5);
/*!40000 ALTER TABLE `bed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `department_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `hospital_id` int NOT NULL,
  PRIMARY KEY (`department_id`),
  KEY `hospital_id` (`hospital_id`),
  CONSTRAINT `department_ibfk_1` FOREIGN KEY (`hospital_id`) REFERENCES `hospital` (`hospital_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'Cardiology','Heart care',1),(2,'Orthopedics','Bone and joint care',1),(3,'General Medicine','General medical care',1),(4,'Emergency Medicine','Emergency treatment',1),(5,'Obstetrics and Gynaecology','Maternal and reproductive care',1),(6,'Neurology','Nervous system care',1),(7,'Neurosurgery','Surgical nervous system care',1),(8,'Anesthesiology','Anesthesia and perioperative care',1),(9,'General Surgery','General surgical care',1),(10,'Pediatrics','Child healthcare',1),(11,'Gastroenterology','Digestive system care',1),(12,'Nephrology','Kidney care',1),(13,'Urology','Urinary system care',1),(14,'Pulmonology','Respiratory care',1),(15,'Ophthalmology','Eye care',1),(16,'ENT','Ear, nose and throat care',1),(17,'Oncology','Cancer care',1),(18,'Psychiatry','Mental healthcare',1),(19,'Radiology','Medical imaging',1),(20,'Physiotherapy','Physical rehabilitation',1);
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor`
--

DROP TABLE IF EXISTS `doctor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor` (
  `doctor_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(120) NOT NULL,
  `specialization` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(120) DEFAULT NULL,
  `hospital_id` int NOT NULL,
  `department_id` int NOT NULL,
  PRIMARY KEY (`doctor_id`),
  KEY `hospital_id` (`hospital_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `doctor_ibfk_1` FOREIGN KEY (`hospital_id`) REFERENCES `hospital` (`hospital_id`),
  CONSTRAINT `doctor_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor`
--

LOCK TABLES `doctor` WRITE;
/*!40000 ALTER TABLE `doctor` DISABLE KEYS */;
INSERT INTO `doctor` VALUES (1,'Test Doctor A','General Medicine',NULL,'doctor1@example.com',1,1),(2,'Test Doctor B','Cardiology',NULL,'doctor2@example.com',2,2),(3,'Test Doctor C','Orthopedics',NULL,'doctor3@example.com',3,3),(4,'Test Doctor D','Oncology',NULL,'doctor4@example.com',4,4),(5,'Test Doctor E','Emergency Medicine',NULL,'doctor5@example.com',5,5);
/*!40000 ALTER TABLE `doctor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emergency`
--

DROP TABLE IF EXISTS `emergency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emergency` (
  `emergency_id` int NOT NULL AUTO_INCREMENT,
  `patient_id` int NOT NULL,
  `hospital_id` int NOT NULL,
  `emergency_type` varchar(100) DEFAULT NULL,
  `description` text,
  `status` varchar(30) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`emergency_id`),
  KEY `patient_id` (`patient_id`),
  KEY `hospital_id` (`hospital_id`),
  CONSTRAINT `emergency_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `emergency_ibfk_2` FOREIGN KEY (`hospital_id`) REFERENCES `hospital` (`hospital_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emergency`
--

LOCK TABLES `emergency` WRITE;
/*!40000 ALTER TABLE `emergency` DISABLE KEYS */;
INSERT INTO `emergency` VALUES (1,1,1,'Medical','Sample test case','Open','2026-11-01 16:20:40'),(2,2,2,'Injury','Sample test case','In Progress','2026-11-01 16:20:40'),(3,3,3,'Accident','Sample test case','Resolved','2026-11-01 16:20:40'),(4,4,4,'Medical','Sample test case','Open','2026-11-01 16:20:40'),(5,5,5,'Injury','Sample test case','Resolved','2026-11-01 16:20:40');
/*!40000 ALTER TABLE `emergency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emergencyservice`
--

DROP TABLE IF EXISTS `emergencyservice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emergencyservice` (
  `service_id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(100) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `contact_no` varchar(20) DEFAULT NULL,
  `hospital_id` int NOT NULL,
  PRIMARY KEY (`service_id`),
  KEY `hospital_id` (`hospital_id`),
  CONSTRAINT `emergencyservice_ibfk_1` FOREIGN KEY (`hospital_id`) REFERENCES `hospital` (`hospital_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emergencyservice`
--

LOCK TABLES `emergencyservice` WRITE;
/*!40000 ALTER TABLE `emergencyservice` DISABLE KEYS */;
INSERT INTO `emergencyservice` VALUES (1,'Municipal Clinic','Primary medical care',NULL,1),(2,'Maternity Care','Prenatal and postnatal services',NULL,1),(3,'Ambulance Service','Emergency patient transport',NULL,1),(4,'Emergency Department','Emergency assessment and treatment',NULL,1),(5,'Cancer Care','Cancer treatment services',NULL,1),(6,'Blood Bank','Blood-related services',NULL,1),(7,'Critical Care','Specialized critical care',NULL,1);
/*!40000 ALTER TABLE `emergencyservice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hospital`
--

DROP TABLE IF EXISTS `hospital`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hospital` (
  `hospital_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(120) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `total_beds` int DEFAULT '0',
  `facilities` text,
  PRIMARY KEY (`hospital_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hospital`
--

LOCK TABLES `hospital` WRITE;
/*!40000 ALTER TABLE `hospital` DISABLE KEYS */;
INSERT INTO `hospital` VALUES (1,'Civil Hospital','Civil Chowk, Solapur','02172749487','Solapur',NULL,NULL),(2,'Ashwini Sahakari Hospital','North Sadar Bazar, Solapur','02172319900','Solapur',NULL,NULL),(3,'Yashodhara Super Speciality Hospital','6158, Siddheshwar Peth, near Zilla Parishad, Solapur','02172323001','Solapur',NULL,NULL),(4,'Unique Hospital','Near Foujdar Chawadi, South Kasaba, Solapur','02172323211','Solapur',NULL,NULL),(5,'Dr. Kotnis Railway Hospital','Solapur','02172627052','Solapur',NULL,NULL),(6,'Solapur Sahakari Hospital','Solapur','02172624718','Solapur',NULL,NULL),(7,'Chh. S. M. Sahakari Hospital','Solapur','02172749432','Solapur',NULL,NULL),(8,'Vima Kamagar Hospital','Solapur','02172600560','Solapur',NULL,NULL),(9,'Siddheshwar Cancer Hospital','Solapur','02172600088','Solapur',NULL,NULL),(10,'Kumathekar Hospital','Solapur','02172300311','Solapur',NULL,NULL),(11,'Vijay Hospital','Solapur','02172318250','Solapur',NULL,NULL),(12,'Basaveshwar Hospital','Solapur','02172331405','Solapur',NULL,NULL),(13,'Mule Hospital','Solapur','02172727063','Solapur',NULL,NULL),(14,'Chidgupkar Hospital','Samrat Chowk, Solapur','02172326841','Solapur',NULL,NULL),(15,'Daffrin Hospital','Daffrin Chowk, Solapur','02172623739','Solapur',NULL,NULL),(16,'Dhanrajaji Hospital','Near Solapur Municipal Corporation','02172725822','Solapur',NULL,NULL),(17,'Krushnamai Hospital','Ramwadi, Solapur','02172727473','Solapur',NULL,NULL),(18,'Jain Hospital','Panjrapol Chowk, Solapur','02172721887','Solapur',NULL,NULL),(19,'Savskar Nursing Home','Hotgi Road, Solapur','02172601087','Solapur',NULL,NULL),(20,'Apex Hospital','Vijapur Road, Solapur','02172600603','Solapur',NULL,NULL),(21,'CNS Hospital','Degaon Road, Damani Nagar, Solapur','08806886699','Solapur',NULL,NULL),(22,'Raghoji Kidney and Multi-Specialty Hospital','Hotgi Road, Mohite Nagar, Solapur','02172602700','Solapur',NULL,NULL),(23,'Gangamai Hospital','Railway Station Road, Solapur','09975512866','Solapur',NULL,NULL),(24,'Solapur Medicity Hospital','Sakhar Peth, Solapur','02172320641','Solapur',NULL,NULL),(25,'SP Institute of Neuro Sciences','Ramwadi Road, Solapur','02172382444','Solapur',NULL,NULL),(26,'Ashwini Rural Medical College Hospital','Kumbhari, Solapur-Akkalkot Road','09767999222','Kumbhari, Solapur',NULL,NULL),(27,'Government Hospital','Civil Chowk, Solapur','02172749487','Solapur',NULL,NULL),(28,'Umbarkar Vasti Hospital','Solapur',NULL,'Solapur',NULL,NULL),(29,'Shahar Hospital','Solapur',NULL,'Solapur',NULL,NULL),(30,'Hudko Nagar Hospital','Hudko Nagar, Solapur',NULL,'Solapur',NULL,NULL);
/*!40000 ALTER TABLE `hospital` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `location` (
  `location_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(120) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `latitude` decimal(9,6) DEFAULT NULL,
  `longitude` decimal(9,6) DEFAULT NULL,
  `area_id` int NOT NULL,
  PRIMARY KEY (`location_id`),
  KEY `area_id` (`area_id`),
  CONSTRAINT `location_ibfk_1` FOREIGN KEY (`area_id`) REFERENCES `area` (`area_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
INSERT INTO `location` VALUES (1,'Civil Hospital','Civil Chowk, Solapur',NULL,NULL,2),(2,'Ashwini Sahakari Hospital','North Sadar Bazar, Solapur',NULL,NULL,1),(3,'Yashodhara Hospital','Siddheshwar Peth, Solapur',NULL,NULL,3),(4,'Unique Hospital','Solapur',NULL,NULL,4),(5,'Dr Kotnis Railway Hospital','Solapur',NULL,NULL,2),(6,'Vima Kamagar Hospital','Solapur',NULL,NULL,2),(7,'Siddheshwar Cancer Hospital','Solapur',NULL,NULL,5),(8,'Chidgupkar Hospital','Samrat Chowk, Solapur',NULL,NULL,4),(9,'Mule Hospital','Solapur',NULL,NULL,7),(10,'Umbarkar Vasti Clinic','Solapur',NULL,NULL,9),(11,'City Clinic','Solapur',NULL,NULL,2),(12,'Sugar Peth Clinic','Sugar Peth, Solapur',NULL,NULL,3),(13,'Ayurvedic Clinic','Solapur',NULL,NULL,3),(14,'Shastri Nagar Clinic','Shastri Nagar, Solapur',NULL,NULL,9),(15,'Jodbhavi Peth Clinic','Jodbhavi Peth, Solapur',NULL,NULL,3),(16,'Ravindranath Tagore Clinic','Solapur',NULL,NULL,2),(17,'Bale UPHC','Bale, Solapur',NULL,NULL,9),(18,'Soregaon UPHC','Soregaon, Solapur',NULL,NULL,9),(19,'Majrewadi UPHC','Majrewadi, Solapur',NULL,NULL,10),(20,'Jodhbhavi Peth UPHC','Jodhbhavi Peth, Solapur',NULL,NULL,3);
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient` (
  `patient_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(120) NOT NULL,
  `age` int DEFAULT NULL,
  `gender` varchar(20) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`patient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
INSERT INTO `patient` VALUES (1,'Test Patient 01',35,'Male',NULL,'Solapur'),(2,'Test Patient 02',28,'Female',NULL,'Solapur'),(3,'Test Patient 03',46,'Male',NULL,'Solapur'),(4,'Test Patient 04',24,'Female',NULL,'Solapur'),(5,'Test Patient 05',51,'Male',NULL,'Solapur'),(6,'Test Patient 06',32,'Female',NULL,'Solapur'),(7,'Test Patient 07',19,'Male',NULL,'Solapur'),(8,'Test Patient 08',42,'Female',NULL,'Solapur'),(9,'Test Patient 09',61,'Male',NULL,'Solapur'),(10,'Test Patient 10',37,'Female',NULL,'Solapur');
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-01 20:38:01
