-- MySQL Script corrigido
-- Sun Nov 16 19:38:46 2025
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuario` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT,
  `nome_usuario` VARCHAR(100) NOT NULL,
  `email_usuario` VARCHAR(100) NOT NULL,
  `senha_usuario` VARCHAR(200) NOT NULL,
  `perfil_investidor_usuario` VARCHAR(100) NOT NULL,
  `saldo_atual_usuario` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id_usuario`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`ativo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ativo` (
  `id_ativo` INT NOT NULL AUTO_INCREMENT,
  `nome_ativo` VARCHAR(100) NOT NULL,
  `tipo_ativo` VARCHAR(100) NOT NULL,
  `ticker_ativo` VARCHAR(100) NOT NULL,
  `mercado` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_ativo`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`ordem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ordem` (
  `id_ordem` INT NOT NULL AUTO_INCREMENT,
  `tipo_ordem` VARCHAR(100) NOT NULL,
  `quantidade` INT NOT NULL,
  `preco_execucao` DECIMAL(10,2) NOT NULL,
  `data_hora` DATETIME NOT NULL,
  `usuario_id_usuario` INT NOT NULL,
  `ativo_id_ativo` INT NOT NULL,
  PRIMARY KEY (`id_ordem`),
  INDEX `fk_ordem_usuario_idx` (`usuario_id_usuario` ASC),
  INDEX `fk_ordem_ativo1_idx` (`ativo_id_ativo` ASC),
  CONSTRAINT `fk_ordem_usuario`
    FOREIGN KEY (`usuario_id_usuario`)
    REFERENCES `mydb`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ordem_ativo1`
    FOREIGN KEY (`ativo_id_ativo`)
    REFERENCES `mydb`.`ativo` (`id_ativo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`carteira`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`carteira` (
  `id_carteira` INT NOT NULL AUTO_INCREMENT,
  `quantidade_possuida` INT NOT NULL,
  `preco_medio` DECIMAL(10,2) NOT NULL,
  `valor_total` DECIMAL(10,2) NOT NULL,
  `usuario_id_usuario` INT NOT NULL,
  `ativo_id_ativo` INT NOT NULL,
  PRIMARY KEY (`id_carteira`),
  INDEX `fk_carteira_usuario1_idx` (`usuario_id_usuario` ASC),
  INDEX `fk_carteira_ativo1_idx` (`ativo_id_ativo` ASC),
  CONSTRAINT `fk_carteira_usuario1`
    FOREIGN KEY (`usuario_id_usuario`)
    REFERENCES `mydb`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_carteira_ativo1`
    FOREIGN KEY (`ativo_id_ativo`)
    REFERENCES `mydb`.`ativo` (`id_ativo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`transacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`transacao` (
  `id_transacao` INT NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(100) NOT NULL,
  `taxa_corretagem` DECIMAL(10,2) NOT NULL,
  `lucro_prejuizo` DECIMAL(10,2) NOT NULL,
  `data_hora_execucao` DATETIME NOT NULL,
  `ordem_id_ordem` INT NOT NULL,
  PRIMARY KEY (`id_transacao`),
  INDEX `fk_transacao_ordem1_idx` (`ordem_id_ordem` ASC),
  CONSTRAINT `fk_transacao_ordem1`
    FOREIGN KEY (`ordem_id_ordem`)
    REFERENCES `mydb`.`ordem` (`id_ordem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
