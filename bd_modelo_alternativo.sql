-- MySQL Script generated by MySQL Workbench
-- Thu Dec 10 16:57:10 2020
-- Model: New Model    Version: 1.0
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
-- Table `mydb`.`endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`endereco` (
  `idendereço` INT NOT NULL AUTO_INCREMENT,
  `bairro` VARCHAR(100) NULL,
  `rua` VARCHAR(255) NULL,
  `complemento` VARCHAR(255) NULL,
  `numero` INT NULL,
  `cep` VARCHAR(100) NULL,
  PRIMARY KEY (`idendereço`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuario` (
  `idusuario` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `username` VARCHAR(20) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `telefone` VARCHAR(60) NULL,
  `datanascimento` DATE NOT NULL,
  `endereco_idendereço` INT NOT NULL,
  PRIMARY KEY (`idusuario`),
  INDEX `fk_usuario_endereco1_idx` (`endereco_idendereço` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_endereco1`
    FOREIGN KEY (`endereco_idendereço`)
    REFERENCES `mydb`.`endereco` (`idendereço`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`categoria` (
  `idcategoria` INT NOT NULL,
  `descricao` VARCHAR(255) NULL,
  PRIMARY KEY (`idcategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`data_evento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`data_evento` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `data_hora_fim` DATETIME NOT NULL,
  `data_hora_inicio` DATETIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`evento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`evento` (
  `idevento` INT NOT NULL AUTO_INCREMENT,
  `dataevento` DATE NOT NULL,
  `descricao` LONGTEXT NULL,
  `nomeevento` VARCHAR(100) NOT NULL,
  `precoevento` DOUBLE NOT NULL,
  `maxpessoas` BIGINT NOT NULL,
  `foto` BLOB NULL,
  `endereco_idendereço` INT NOT NULL,
  `categoria` VARCHAR(80) NULL,
  `categoria_idcategoria` INT NOT NULL,
  `data_evento_id` INT NOT NULL,
  PRIMARY KEY (`idevento`),
  INDEX `fk_evento_endereco1_idx` (`endereco_idendereço` ASC) VISIBLE,
  INDEX `fk_evento_categoria1_idx` (`categoria_idcategoria` ASC) VISIBLE,
  INDEX `fk_evento_data_evento1_idx` (`data_evento_id` ASC) VISIBLE,
  CONSTRAINT `fk_evento_endereco1`
    FOREIGN KEY (`endereco_idendereço`)
    REFERENCES `mydb`.`endereco` (`idendereço`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_evento_categoria1`
    FOREIGN KEY (`categoria_idcategoria`)
    REFERENCES `mydb`.`categoria` (`idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_evento_data_evento1`
    FOREIGN KEY (`data_evento_id`)
    REFERENCES `mydb`.`data_evento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`compra` (
  `quantidadeingresso` TINYINT NOT NULL,
  `idcompra` INT NOT NULL AUTO_INCREMENT,
  `evento_idevento` INT NOT NULL,
  `usuario_idusuario` INT NOT NULL,
  `datacompra` DATE NOT NULL,
  PRIMARY KEY (`idcompra`),
  INDEX `fk_compra_evento_idx` (`evento_idevento` ASC) VISIBLE,
  INDEX `fk_compra_usuario1_idx` (`usuario_idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_compra_evento`
    FOREIGN KEY (`evento_idevento`)
    REFERENCES `mydb`.`evento` (`idevento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_compra_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `mydb`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`perfil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`perfil` (
  `idperfil` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idperfil`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`usuario_perfis`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuario_perfis` (
  `usuario_idusuario` INT NOT NULL,
  `perfil_idperfil` INT NOT NULL,
  INDEX `fk_usuario_perfis_usuario1_idx` (`usuario_idusuario` ASC) VISIBLE,
  INDEX `fk_usuario_perfis_perfil1_idx` (`perfil_idperfil` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_perfis_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `mydb`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_perfis_perfil1`
    FOREIGN KEY (`perfil_idperfil`)
    REFERENCES `mydb`.`perfil` (`idperfil`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`historico_compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`historico_compra` (
  `compra_idcompra` INT NOT NULL,
  `usuario_idusuario` INT NOT NULL,
  INDEX `fk_historico_compra_compra1_idx` (`compra_idcompra` ASC) VISIBLE,
  INDEX `fk_historico_compra_usuario1_idx` (`usuario_idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_historico_compra_compra1`
    FOREIGN KEY (`compra_idcompra`)
    REFERENCES `mydb`.`compra` (`idcompra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_historico_compra_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `mydb`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
