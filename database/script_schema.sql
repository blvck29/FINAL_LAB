-- MySQL Workbench Forward Engineering

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
AUTO_INCREMENT = 2
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
