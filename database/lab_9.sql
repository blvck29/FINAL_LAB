CREATE DATABASE  IF NOT EXISTS `lab_9` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `lab_9`;
-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: lab_9
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Table structure for table `curso`
--

DROP TABLE IF EXISTS `curso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `curso` (
  `idcurso` int NOT NULL,
  `codigo` varchar(6) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `idfacultad` int NOT NULL,
  `fecha_registro` datetime NOT NULL,
  `fecha_edicion` datetime NOT NULL,
  PRIMARY KEY (`idcurso`),
  KEY `fk_curso_facultad1_idx` (`idfacultad`),
  CONSTRAINT `fk_curso_facultad1` FOREIGN KEY (`idfacultad`) REFERENCES `facultad` (`idfacultad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curso`
--

LOCK TABLES `curso` WRITE;
/*!40000 ALTER TABLE `curso` DISABLE KEYS */;
/*!40000 ALTER TABLE `curso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curso_has_docente`
--

DROP TABLE IF EXISTS `curso_has_docente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `curso_has_docente` (
  `idcurso` int NOT NULL,
  `iddocente` int NOT NULL,
  PRIMARY KEY (`idcurso`,`iddocente`),
  KEY `fk_curso_has_usuario_usuario1_idx` (`iddocente`),
  KEY `fk_curso_has_usuario_curso1_idx` (`idcurso`),
  CONSTRAINT `fk_curso_has_usuario_curso1` FOREIGN KEY (`idcurso`) REFERENCES `curso` (`idcurso`),
  CONSTRAINT `fk_curso_has_usuario_usuario1` FOREIGN KEY (`iddocente`) REFERENCES `usuario` (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curso_has_docente`
--

LOCK TABLES `curso_has_docente` WRITE;
/*!40000 ALTER TABLE `curso_has_docente` DISABLE KEYS */;
/*!40000 ALTER TABLE `curso_has_docente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evaluaciones`
--

DROP TABLE IF EXISTS `evaluaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `evaluaciones` (
  `idevaluaciones` int NOT NULL,
  `nombre_estudiantes` varchar(45) NOT NULL,
  `codigo_estudiantes` varchar(45) NOT NULL,
  `correo_estudiantes` varchar(45) NOT NULL,
  `nota` int NOT NULL,
  `idcurso` int NOT NULL,
  `idsemestre` int NOT NULL,
  `fecha_registro` datetime NOT NULL,
  `fecha_edicion` datetime NOT NULL,
  PRIMARY KEY (`idevaluaciones`),
  KEY `fk_evaluaciones_curso1_idx` (`idcurso`),
  KEY `fk_evaluaciones_semestre1_idx` (`idsemestre`),
  CONSTRAINT `fk_evaluaciones_curso1` FOREIGN KEY (`idcurso`) REFERENCES `curso` (`idcurso`),
  CONSTRAINT `fk_evaluaciones_semestre1` FOREIGN KEY (`idsemestre`) REFERENCES `semestre` (`idsemestre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evaluaciones`
--

LOCK TABLES `evaluaciones` WRITE;
/*!40000 ALTER TABLE `evaluaciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `evaluaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `facultad`
--

DROP TABLE IF EXISTS `facultad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `facultad` (
  `idfacultad` int NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `iduniversidad` int NOT NULL,
  `fecha_registro` datetime NOT NULL,
  `fecha_edicion` datetime NOT NULL,
  PRIMARY KEY (`idfacultad`),
  KEY `fk_facultad_universidad_idx` (`iduniversidad`),
  CONSTRAINT `fk_facultad_universidad` FOREIGN KEY (`iduniversidad`) REFERENCES `universidad` (`iduniversidad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facultad`
--

LOCK TABLES `facultad` WRITE;
/*!40000 ALTER TABLE `facultad` DISABLE KEYS */;
/*!40000 ALTER TABLE `facultad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `facultad_has_decano`
--

DROP TABLE IF EXISTS `facultad_has_decano`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `facultad_has_decano` (
  `idfacultad` int NOT NULL,
  `iddecano` int NOT NULL,
  PRIMARY KEY (`idfacultad`,`iddecano`),
  KEY `fk_facultad_has_usuario_usuario1_idx` (`iddecano`),
  KEY `fk_facultad_has_usuario_facultad1_idx` (`idfacultad`),
  CONSTRAINT `fk_facultad_has_usuario_facultad1` FOREIGN KEY (`idfacultad`) REFERENCES `facultad` (`idfacultad`),
  CONSTRAINT `fk_facultad_has_usuario_usuario1` FOREIGN KEY (`iddecano`) REFERENCES `usuario` (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facultad_has_decano`
--

LOCK TABLES `facultad_has_decano` WRITE;
/*!40000 ALTER TABLE `facultad_has_decano` DISABLE KEYS */;
/*!40000 ALTER TABLE `facultad_has_decano` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol`
--

DROP TABLE IF EXISTS `rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rol` (
  `idrol` int NOT NULL,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`idrol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol`
--

LOCK TABLES `rol` WRITE;
/*!40000 ALTER TABLE `rol` DISABLE KEYS */;
/*!40000 ALTER TABLE `rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `semestre`
--

DROP TABLE IF EXISTS `semestre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `semestre` (
  `idsemestre` int NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `idadmistrador` int NOT NULL,
  `habilitado` tinyint NOT NULL,
  `fecha_registro` datetime NOT NULL,
  `fecha_edicion` datetime NOT NULL,
  PRIMARY KEY (`idsemestre`,`idadmistrador`),
  KEY `fk_semestre_usuario1_idx` (`idadmistrador`),
  CONSTRAINT `fk_semestre_usuario1` FOREIGN KEY (`idadmistrador`) REFERENCES `usuario` (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `semestre`
--

LOCK TABLES `semestre` WRITE;
/*!40000 ALTER TABLE `semestre` DISABLE KEYS */;
/*!40000 ALTER TABLE `semestre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `universidad`
--

DROP TABLE IF EXISTS `universidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `universidad` (
  `iduniversidad` int NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `logo_url` varchar(45) NOT NULL,
  `idadministrador` int NOT NULL,
  `fecha_registro` datetime NOT NULL,
  `fecha_edicion` datetime NOT NULL,
  PRIMARY KEY (`iduniversidad`),
  KEY `fk_universidad_usuario1_idx` (`idadministrador`),
  CONSTRAINT `fk_universidad_usuario1` FOREIGN KEY (`idadministrador`) REFERENCES `usuario` (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `universidad`
--

LOCK TABLES `universidad` WRITE;
/*!40000 ALTER TABLE `universidad` DISABLE KEYS */;
/*!40000 ALTER TABLE `universidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `universidad_has_rector`
--

DROP TABLE IF EXISTS `universidad_has_rector`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `universidad_has_rector` (
  `iduniversidad` int NOT NULL,
  `idrector` int NOT NULL,
  PRIMARY KEY (`iduniversidad`,`idrector`),
  KEY `fk_universidad_has_usuario_usuario1_idx` (`idrector`),
  KEY `fk_universidad_has_usuario_universidad1_idx` (`iduniversidad`),
  CONSTRAINT `fk_universidad_has_usuario_universidad1` FOREIGN KEY (`iduniversidad`) REFERENCES `universidad` (`iduniversidad`),
  CONSTRAINT `fk_universidad_has_usuario_usuario1` FOREIGN KEY (`idrector`) REFERENCES `usuario` (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `universidad_has_rector`
--

LOCK TABLES `universidad_has_rector` WRITE;
/*!40000 ALTER TABLE `universidad_has_rector` DISABLE KEYS */;
/*!40000 ALTER TABLE `universidad_has_rector` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `idusuario` int NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `correo` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `idrol` int NOT NULL,
  `ultimo_ingreso` datetime DEFAULT NULL,
  `cantidad_ingresos` int NOT NULL,
  `fecha_registro` datetime NOT NULL,
  `fecha_edicion` datetime NOT NULL,
  PRIMARY KEY (`idusuario`),
  KEY `fk_usuario_rol1_idx` (`idrol`),
  CONSTRAINT `fk_usuario_rol1` FOREIGN KEY (`idrol`) REFERENCES `rol` (`idrol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-22 19:23:20
