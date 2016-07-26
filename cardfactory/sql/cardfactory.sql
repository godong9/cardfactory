-- MySQL Script generated by MySQL Workbench
-- 07/26/16 16:33:07
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema cardfactory
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema cardfactory
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cardfactory` DEFAULT CHARACTER SET utf8 ;
USE `cardfactory` ;

-- -----------------------------------------------------
-- Table `cardfactory`.`card_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cardfactory`.`card_type` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `defaultHtml` TEXT NULL DEFAULT NULL,
  `thumbnailHtml` TEXT NULL DEFAULT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `cardfactory`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cardfactory`.`user` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nickname` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `password` VARCHAR(256) NULL DEFAULT NULL,
  `updatedDate` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `createdDate` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nickname_UNIQUE` (`nickname` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `cardfactory`.`card`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cardfactory`.`card` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `html` TEXT NULL DEFAULT NULL,
  `hitsCount` INT(11) NULL DEFAULT NULL,
  `likesCount` INT(11) NULL DEFAULT NULL,
  `updatedDate` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `createdDate` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `userId` INT(11) NULL DEFAULT NULL,
  `cardTypeId` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `userId_idx` (`userId` ASC),
  INDEX `cardTypeId_idx` (`cardTypeId` ASC),
  CONSTRAINT `cardTypeId`
    FOREIGN KEY (`cardTypeId`)
    REFERENCES `cardfactory`.`card_type` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `userId`
    FOREIGN KEY (`userId`)
    REFERENCES `cardfactory`.`user` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
