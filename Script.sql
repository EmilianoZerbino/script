-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Usuario` (
  `id` INT NOT NULL,
  `dni` VARCHAR(8) NOT NULL,
  `nombres` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `fechNac` DATE NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `dni_UNIQUE` (`dni` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Institucion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Institucion` (
  `id` INT NULL,
  `nombre` VARCHAR(250) NOT NULL,
  `url_logo` VARCHAR(250) NOT NULL,
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Especialidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Especialidad` (
  `id` INT NULL,
  `titulo` VARCHAR(45) NOT NULL,
  `institucion_id` INT NOT NULL,
  PRIMARY KEY (`id`, `institucion_id`),
  INDEX `fk_Especialidad_institucion1_idx` (`institucion_id` ASC) VISIBLE,
  CONSTRAINT `fk_Especialidad_institucion1`
    FOREIGN KEY (`institucion_id`)
    REFERENCES `mydb`.`Institucion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Estado_academico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Estado_academico` (
  `id` INT NOT NULL,
  `estado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `estado_UNIQUE` (`estado` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Acerca_de`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Acerca_de` (
  `id` INT NULL,
  `acerca_de` VARCHAR(600) NOT NULL,
  `Usuario_id` INT NOT NULL,
  PRIMARY KEY (`id`, `Usuario_id`),
  INDEX `fk_acerca_de_Usuario1_idx` (`Usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_acerca_de_Usuario1`
    FOREIGN KEY (`Usuario_id`)
    REFERENCES `mydb`.`Usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`encabezado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`encabezado` (
  `id` INT NULL,
  `url_perfil` VARCHAR(250) NOT NULL,
  `url_fondo` VARCHAR(250) NOT NULL,
  `Usuario_id` INT NOT NULL,
  PRIMARY KEY (`id`, `Usuario_id`),
  INDEX `fk_encabezado_Usuario1_idx` (`Usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_encabezado_Usuario1`
    FOREIGN KEY (`Usuario_id`)
    REFERENCES `mydb`.`Usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Formacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Formacion` (
  `Usuario_id` INT NOT NULL,
  `Especialidad_id` INT NOT NULL,
  `fecha_inicio` DATE NOT NULL,
  `fecha_fin` DATE NULL,
  `estado_academico_id` INT NOT NULL,
  PRIMARY KEY (`Usuario_id`, `Especialidad_id`, `estado_academico_id`),
  INDEX `fk_Usuario_has_Especialidad_Especialidad1_idx` (`Especialidad_id` ASC) VISIBLE,
  INDEX `fk_Usuario_has_Especialidad_Usuario_idx` (`Usuario_id` ASC) VISIBLE,
  INDEX `fk_formacion_estado_academico1_idx` (`estado_academico_id` ASC) VISIBLE,
  CONSTRAINT `fk_Usuario_has_Especialidad_Usuario`
    FOREIGN KEY (`Usuario_id`)
    REFERENCES `mydb`.`Usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_has_Especialidad_Especialidad1`
    FOREIGN KEY (`Especialidad_id`)
    REFERENCES `mydb`.`Especialidad` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_formacion_estado_academico1`
    FOREIGN KEY (`estado_academico_id`)
    REFERENCES `mydb`.`Estado_academico` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Trabajo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Trabajo` (
  `Usuario_id` INT NOT NULL,
  `institucion_id` INT NOT NULL,
  `funcion` VARCHAR(100) NOT NULL,
  `fecha_inicio` DATE NOT NULL,
  `fecha_fin` DATE NULL,
  PRIMARY KEY (`Usuario_id`, `institucion_id`),
  INDEX `fk_Usuario_has_institucion_institucion1_idx` (`institucion_id` ASC) VISIBLE,
  INDEX `fk_Usuario_has_institucion_Usuario1_idx` (`Usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_Usuario_has_institucion_Usuario1`
    FOREIGN KEY (`Usuario_id`)
    REFERENCES `mydb`.`Usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_has_institucion_institucion1`
    FOREIGN KEY (`institucion_id`)
    REFERENCES `mydb`.`Institucion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Tecnologia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Tecnologia` (
  `id` INT NULL,
  `nombre` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Tecnologia_Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Tecnologia_Usuario` (
  `tecnologia_id` INT NOT NULL,
  `Usuario_id` INT NOT NULL,
  `nivel` INT NOT NULL,
  PRIMARY KEY (`tecnologia_id`, `Usuario_id`),
  INDEX `fk_tecnologia_has_Usuario_Usuario1_idx` (`Usuario_id` ASC) VISIBLE,
  INDEX `fk_tecnologia_has_Usuario_tecnologia1_idx` (`tecnologia_id` ASC) VISIBLE,
  CONSTRAINT `fk_tecnologia_has_Usuario_tecnologia1`
    FOREIGN KEY (`tecnologia_id`)
    REFERENCES `mydb`.`Tecnologia` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tecnologia_has_Usuario_Usuario1`
    FOREIGN KEY (`Usuario_id`)
    REFERENCES `mydb`.`Usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Skill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Skill` (
  `id` INT NULL,
  `nombre` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Usuario_Skill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Usuario_Skill` (
  `Usuario_id` INT NOT NULL,
  `Skill_id` INT NOT NULL,
  `nivel` INT NULL,
  PRIMARY KEY (`Usuario_id`, `Skill_id`),
  INDEX `fk_Usuario_has_Skill_Skill1_idx` (`Skill_id` ASC) VISIBLE,
  INDEX `fk_Usuario_has_Skill_Usuario1_idx` (`Usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_Usuario_has_Skill_Usuario1`
    FOREIGN KEY (`Usuario_id`)
    REFERENCES `mydb`.`Usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_has_Skill_Skill1`
    FOREIGN KEY (`Skill_id`)
    REFERENCES `mydb`.`Skill` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Proyectos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Proyectos` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(50) NULL,
  `url_logo` VARCHAR(250) NULL,
  `url_proyecto` VARCHAR(250) NULL,
  `Usuario_id` INT NOT NULL,
  PRIMARY KEY (`id`, `Usuario_id`),
  INDEX `fk_Proyectos_Usuario1_idx` (`Usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_Proyectos_Usuario1`
    FOREIGN KEY (`Usuario_id`)
    REFERENCES `mydb`.`Usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Contactos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Contactos` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(50) NULL,
  `url_logo` VARCHAR(250) NULL,
  `url_contacto` VARCHAR(250) NULL,
  `Usuario_id` INT NOT NULL,
  PRIMARY KEY (`id`, `Usuario_id`),
  INDEX `fk_Contactos_Usuario1_idx` (`Usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_Contactos_Usuario1`
    FOREIGN KEY (`Usuario_id`)
    REFERENCES `mydb`.`Usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
