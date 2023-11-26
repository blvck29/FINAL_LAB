
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema lab_9
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema lab_9
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `lab_9` DEFAULT CHARACTER SET utf8mb3 ;
USE `lab_9` ;

-- -----------------------------------------------------
-- Table `lab_9`.`rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lab_9`.`rol` (
  `idrol` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idrol`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `lab_9`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lab_9`.`usuario` (
  `idusuario` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  `password` VARCHAR(64) NOT NULL,
  `idrol` INT NOT NULL,
  `ultimo_ingreso` DATETIME NULL DEFAULT NULL,
  `cantidad_ingresos` INT NOT NULL,
  `fecha_registro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_edicion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idusuario`),
  INDEX `fk_usuario_rol1_idx` (`idrol` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_rol1`
    FOREIGN KEY (`idrol`)
    REFERENCES `lab_9`.`rol` (`idrol`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `lab_9`.`universidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lab_9`.`universidad` (
  `iduniversidad` INT NOT NULL,
  `nombre` VARCHAR(80) NOT NULL,
  `logo_url` VARCHAR(45) NOT NULL DEFAULT '#',
  `idadministrador` INT NOT NULL,
  `fecha_registro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_edicion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`iduniversidad`),
  INDEX `fk_universidad_usuario1_idx` (`idadministrador` ASC) VISIBLE,
  CONSTRAINT `fk_universidad_usuario1`
    FOREIGN KEY (`idadministrador`)
    REFERENCES `lab_9`.`usuario` (`idusuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `lab_9`.`facultad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lab_9`.`facultad` (
  `idfacultad` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `iduniversidad` INT NOT NULL,
  `fecha_registro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_edicion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idfacultad`),
  INDEX `fk_facultad_universidad_idx` (`iduniversidad` ASC) VISIBLE,
  CONSTRAINT `fk_facultad_universidad`
    FOREIGN KEY (`iduniversidad`)
    REFERENCES `lab_9`.`universidad` (`iduniversidad`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `lab_9`.`curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lab_9`.`curso` (
  `idcurso` INT NOT NULL,
  `codigo` VARCHAR(6) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `idfacultad` INT NOT NULL,
  `fecha_registro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_edicion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idcurso`),
  INDEX `fk_curso_facultad1_idx` (`idfacultad` ASC) VISIBLE,
  CONSTRAINT `fk_curso_facultad1`
    FOREIGN KEY (`idfacultad`)
    REFERENCES `lab_9`.`facultad` (`idfacultad`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `lab_9`.`curso_has_docente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lab_9`.`curso_has_docente` (
  `idcurso` INT NOT NULL,
  `iddocente` INT NOT NULL,
  PRIMARY KEY (`idcurso`, `iddocente`),
  INDEX `fk_curso_has_usuario_usuario1_idx` (`iddocente` ASC) VISIBLE,
  INDEX `fk_curso_has_usuario_curso1_idx` (`idcurso` ASC) VISIBLE,
  CONSTRAINT `fk_curso_has_usuario_curso1`
    FOREIGN KEY (`idcurso`)
    REFERENCES `lab_9`.`curso` (`idcurso`),
  CONSTRAINT `fk_curso_has_usuario_usuario1`
    FOREIGN KEY (`iddocente`)
    REFERENCES `lab_9`.`usuario` (`idusuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `lab_9`.`semestre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lab_9`.`semestre` (
  `idsemestre` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `idadmistrador` INT NOT NULL,
  `habilitado` TINYINT NOT NULL,
  `fecha_registro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_edicion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idsemestre`, `idadmistrador`),
  INDEX `fk_semestre_usuario1_idx` (`idadmistrador` ASC) VISIBLE,
  CONSTRAINT `fk_semestre_usuario1`
    FOREIGN KEY (`idadmistrador`)
    REFERENCES `lab_9`.`usuario` (`idusuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `lab_9`.`evaluaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lab_9`.`evaluaciones` (
  `idevaluaciones` INT NOT NULL AUTO_INCREMENT,
  `nombre_estudiantes` VARCHAR(45) NOT NULL,
  `codigo_estudiantes` VARCHAR(45) NOT NULL,
  `correo_estudiantes` VARCHAR(45) NOT NULL,
  `nota` INT NOT NULL,
  `idcurso` INT NOT NULL,
  `idsemestre` INT NOT NULL,
  `fecha_registro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_edicion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idevaluaciones`),
  INDEX `fk_evaluaciones_curso1_idx` (`idcurso` ASC) VISIBLE,
  INDEX `fk_evaluaciones_semestre1_idx` (`idsemestre` ASC) VISIBLE,
  CONSTRAINT `fk_evaluaciones_curso1`
    FOREIGN KEY (`idcurso`)
    REFERENCES `lab_9`.`curso` (`idcurso`),
  CONSTRAINT `fk_evaluaciones_semestre1`
    FOREIGN KEY (`idsemestre`)
    REFERENCES `lab_9`.`semestre` (`idsemestre`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `lab_9`.`facultad_has_decano`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lab_9`.`facultad_has_decano` (
  `idfacultad` INT NOT NULL,
  `iddecano` INT NOT NULL,
  PRIMARY KEY (`idfacultad`, `iddecano`),
  INDEX `fk_facultad_has_usuario_usuario1_idx` (`iddecano` ASC) VISIBLE,
  INDEX `fk_facultad_has_usuario_facultad1_idx` (`idfacultad` ASC) VISIBLE,
  CONSTRAINT `fk_facultad_has_usuario_facultad1`
    FOREIGN KEY (`idfacultad`)
    REFERENCES `lab_9`.`facultad` (`idfacultad`),
  CONSTRAINT `fk_facultad_has_usuario_usuario1`
    FOREIGN KEY (`iddecano`)
    REFERENCES `lab_9`.`usuario` (`idusuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `lab_9`.`universidad_has_rector`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lab_9`.`universidad_has_rector` (
  `iduniversidad` INT NOT NULL,
  `idrector` INT NOT NULL,
  PRIMARY KEY (`iduniversidad`, `idrector`),
  INDEX `fk_universidad_has_usuario_usuario1_idx` (`idrector` ASC) VISIBLE,
  INDEX `fk_universidad_has_usuario_universidad1_idx` (`iduniversidad` ASC) VISIBLE,
  CONSTRAINT `fk_universidad_has_usuario_universidad1`
    FOREIGN KEY (`iduniversidad`)
    REFERENCES `lab_9`.`universidad` (`iduniversidad`),
  CONSTRAINT `fk_universidad_has_usuario_usuario1`
    FOREIGN KEY (`idrector`)
    REFERENCES `lab_9`.`usuario` (`idusuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- -----------------------------------------------------
-- Datos: Tabla rol
-- -----------------------------------------------------
INSERT INTO `lab_9`.`rol` (`idrol`, `nombre`) VALUES ('1', 'Administrador');
INSERT INTO `lab_9`.`rol` (`idrol`, `nombre`) VALUES ('2', 'Rector');
INSERT INTO `lab_9`.`rol` (`idrol`, `nombre`) VALUES ('3', 'Decano');
INSERT INTO `lab_9`.`rol` (`idrol`, `nombre`) VALUES ('4', 'Docente');

-- -----------------------------------------------------
-- Datos: Tabla usuario
-- -----------------------------------------------------
INSERT INTO `lab_9`.`usuario` (`idusuario`, `nombre`, `correo`, `password`, `idrol`, `cantidad_ingresos`) 
VALUES ('1', 'Administrador', 'admin@pucp.edu.pe', 'acceso123', '1', '0');
INSERT INTO `lab_9`.`usuario` (`idusuario`, `nombre`, `correo`, `password`, `idrol`, `cantidad_ingresos`) 
VALUES ('2', 'Carlos Garatea', 'rector@pucp.edu.pe', 'acceso123', '2', '0');
INSERT INTO `lab_9`.`usuario` (`idusuario`, `nombre`, `correo`, `password`, `idrol`, `cantidad_ingresos`) 
VALUES ('3', 'Francisco Rumiche', 'decano.ciencias@pucp.edu.pe', 'acceso123', '3', '0');
INSERT INTO `lab_9`.`usuario` (`idusuario`, `nombre`, `correo`, `password`, `idrol`, `cantidad_ingresos`) 
VALUES ('4', 'Manuel Yarlequé', 'yarleque@pucp.edu.pe', 'acceso123', '4', '0');
INSERT INTO `lab_9`.`usuario` (`idusuario`, `nombre`, `correo`, `password`, `idrol`, `cantidad_ingresos`) 
VALUES ('5', 'Stuardo Lucho', 'lucho@pucp.edu.pe', 'acceso123', '4', '0');
INSERT INTO `lab_9`.`usuario` (`idusuario`, `nombre`, `correo`, `password`, `idrol`, `cantidad_ingresos`) 
VALUES ('6', 'Jorge Benavides', 'jo.benas@pucp.edu.pe', 'acceso123', '4', '0');
INSERT INTO `lab_9`.`usuario` (`idusuario`, `nombre`, `correo`, `password`, `idrol`, `cantidad_ingresos`) 
VALUES ('7', 'Epifanio Jorge', 'e.jorge@pucp.edu.pe', 'acceso123', '4', '0');
INSERT INTO `lab_9`.`usuario` (`idusuario`, `nombre`, `correo`, `password`, `idrol`, `cantidad_ingresos`) 
VALUES ('8', 'Juan Huapaya', 'juan.h@pucp.edu.pe', 'acceso123', '4', '0');
INSERT INTO `lab_9`.`usuario` (`idusuario`, `nombre`, `correo`, `password`, `idrol`, `cantidad_ingresos`) 
VALUES ('9', 'Juan Jave', 'juan.jave@pucp.edu.pe', 'acceso123', '4', '0');
INSERT INTO `lab_9`.`usuario` (`idusuario`, `nombre`, `correo`, `password`, `idrol`, `cantidad_ingresos`) 
VALUES ('10', 'Stefano Romero', 'st.romero@pucp.edu.pe', 'acceso123', '4', '0');
INSERT INTO `lab_9`.`usuario` (`idusuario`, `nombre`, `correo`, `password`, `idrol`, `cantidad_ingresos`) 
VALUES ('11', 'César Santivañez', 'cesar.santi@pucp.edu.pe', 'acceso123', '4', '0');
INSERT INTO `lab_9`.`usuario` (`idusuario`, `nombre`, `correo`, `password`, `idrol`, `cantidad_ingresos`) 
VALUES ('12', 'Gumercino Bartra', 'gumer@pucp.edu.pe', 'acceso123', '4', '0');
INSERT INTO `lab_9`.`usuario` (`idusuario`, `nombre`, `correo`, `password`, `idrol`, `cantidad_ingresos`) 
VALUES ('13', 'Nicola Tesla', 'nicola@pucp.edu.pe', 'acceso123', '4', '0');
INSERT INTO `lab_9`.`usuario` (`idusuario`, `nombre`, `correo`, `password`, `idrol`, `cantidad_ingresos`) 
VALUES ('14', 'Robert Oppenheimer', 'robert@pucp.edu.pe', 'acceso123', '4', '0');
INSERT INTO `lab_9`.`usuario` (`idusuario`, `nombre`, `correo`, `password`, `idrol`, `cantidad_ingresos`) 
VALUES ('15', 'Fernando Barreto', 'fernando@pucp.edu.pe', 'acceso123', '4', '0');
INSERT INTO `lab_9`.`usuario` (`idusuario`, `nombre`, `correo`, `password`, `idrol`, `cantidad_ingresos`)
VALUES ('16', 'Walter White', 'ww@pucp.edu.pe', 'acceso123', '4', '0');

-- -----------------------------------------------------
-- Datos: Tabla universidad
-- -----------------------------------------------------
INSERT INTO `lab_9`.`universidad` (`iduniversidad`, `nombre`, `logo_url`, `idadministrador`) VALUES ('1', 'Pontificia Universidad Católica del Perú (PUCP)', 'resources/images/logo_pucp.jpg', '1');


-- -----------------------------------------------------
-- Datos: Tabla semestre
-- -----------------------------------------------------
INSERT INTO `lab_9`.`semestre` (`idsemestre`, `nombre`, `idadmistrador`, `habilitado`) VALUES ('1', '2022-1', '1', '0');
INSERT INTO `lab_9`.`semestre` (`idsemestre`, `nombre`, `idadmistrador`, `habilitado`) VALUES ('2', '2022-2', '1', '0');
INSERT INTO `lab_9`.`semestre` (`idsemestre`, `nombre`, `idadmistrador`, `habilitado`) VALUES ('3', '2023-0', '1', '0');
INSERT INTO `lab_9`.`semestre` (`idsemestre`, `nombre`, `idadmistrador`, `habilitado`) VALUES ('4', '2023-1', '1', '0');
INSERT INTO `lab_9`.`semestre` (`idsemestre`, `nombre`, `idadmistrador`, `habilitado`) VALUES ('5', '2023-2', '1', '1');


-- -----------------------------------------------------
-- Datos: Tabla facultades
-- -----------------------------------------------------
INSERT INTO `lab_9`.`facultad` (`idfacultad`, `nombre`, `iduniversidad`) VALUES ('1', 'Ciencias e Ingeniería', '1');

-- -----------------------------------------------------
-- Datos: Tabla cursos
-- -----------------------------------------------------
INSERT INTO `lab_9`.`curso` (`idcurso`, `codigo`, `nombre`, `idfacultad`) 
VALUES ('1', '1IEE07', 'Teoria de Campos Electromagnéticos', '1');
INSERT INTO `lab_9`.`curso` (`idcurso`, `codigo`, `nombre`, `idfacultad`) 
VALUES ('2', 'TEL132', 'Propagación y Radiación Electromagnética', '1');
INSERT INTO `lab_9`.`curso` (`idcurso`, `codigo`, `nombre`, `idfacultad`) 
VALUES ('3', 'TEL133', 'Teoria de Comunicaciones 1', '1');
INSERT INTO `lab_9`.`curso` (`idcurso`, `codigo`, `nombre`, `idfacultad`) 
VALUES ('4', 'TEL136', 'Teoria de Comunicaciones 2', '1');
INSERT INTO `lab_9`.`curso` (`idcurso`, `codigo`, `nombre`, `idfacultad`) 
VALUES ('5', '1IEE06', 'Arquitectura de Computadoras', '1');
INSERT INTO `lab_9`.`curso` (`idcurso`, `codigo`, `nombre`, `idfacultad`) 
VALUES ('6', 'TEL134', 'Ciberseguridad y Hacking Ético', '1');
INSERT INTO `lab_9`.`curso` (`idcurso`, `codigo`, `nombre`, `idfacultad`) 
VALUES ('7', 'INF238', 'Redes de Computadoras', '1');
INSERT INTO `lab_9`.`curso` (`idcurso`, `codigo`, `nombre`, `idfacultad`) 
VALUES ('8', 'TEL225', 'Protocolos de Enrutamiento', '1');
INSERT INTO `lab_9`.`curso` (`idcurso`, `codigo`, `nombre`, `idfacultad`) 
VALUES ('9', 'TEL223', 'Ingeniería de Tráfico en Telecomunicaciones', '1');
INSERT INTO `lab_9`.`curso` (`idcurso`, `codigo`, `nombre`, `idfacultad`) 
VALUES ('10', 'IEE352', 'Procesamiento Digital de Señales', '1');
INSERT INTO `lab_9`.`curso` (`idcurso`, `codigo`, `nombre`, `idfacultad`) 
VALUES ('11', 'TEL137', 'Gestión de Servicios De TICs', '1');
INSERT INTO `lab_9`.`curso` (`idcurso`, `codigo`, `nombre`, `idfacultad`) 
VALUES ('12', 'TEL140', 'Telemática Forense', '1');

-- -----------------------------------------------------
-- Datos: Tabla rol
-- -----------------------------------------------------



-- -----------------------------------------------------
-- Datos: Tabla rol
-- -----------------------------------------------------
