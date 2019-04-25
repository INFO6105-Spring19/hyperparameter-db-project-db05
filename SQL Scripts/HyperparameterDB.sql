-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema hyperparameter_project
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema hyperparameter_project
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hyperparameter_project` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `hyperparameter_project` ;

-- -----------------------------------------------------
-- Table `hyperparameter_project`.`algo_h20`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hyperparameter_project`.`algo_h20` (
  `algo_id` VARCHAR(10) NOT NULL,
  `algo_name` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`algo_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `hyperparameter_project`.`dataset`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hyperparameter_project`.`dataset` (
  `id` VARCHAR(10) NOT NULL,
  `dataset_name` VARCHAR(100) NULL DEFAULT NULL,
  `dataset_type` VARCHAR(100) NULL DEFAULT NULL,
  `tot_col` INT(11) NULL DEFAULT NULL,
  `tot_row` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `hyperparameter_project`.`data_des`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hyperparameter_project`.`data_des` (
  `id` VARCHAR(10) NOT NULL,
  `dataset_id` VARCHAR(50) NULL DEFAULT NULL,
  `col_name` VARCHAR(100) NULL DEFAULT NULL,
  `col_type` VARCHAR(100) NULL DEFAULT NULL,
  `tot_row` INT(11) NULL DEFAULT NULL,
  `info_type` ENUM('1', '0') NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `datades_dataset_id_idx` (`dataset_id` ASC) VISIBLE,
  CONSTRAINT `datades_dataset_id`
    FOREIGN KEY (`dataset_id`)
    REFERENCES `hyperparameter_project`.`dataset` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `hyperparameter_project`.`models`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hyperparameter_project`.`models` (
  `id` VARCHAR(10) NOT NULL,
  `dataset_id` VARCHAR(10) NULL DEFAULT NULL,
  `model_id` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `dataset_id` (`dataset_id` ASC) VISIBLE,
  CONSTRAINT `models_ibfk_1`
    FOREIGN KEY (`dataset_id`)
    REFERENCES `hyperparameter_project`.`dataset` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `hyperparameter_project`.`deeplearning_hyperparameters`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hyperparameter_project`.`deeplearning_hyperparameters` (
  `id` INT(11) NOT NULL,
  `model_id` VARCHAR(50) NULL DEFAULT NULL,
  `algo_id` VARCHAR(20) NULL DEFAULT NULL,
  `balance_classes` TEXT NULL DEFAULT NULL,
  `class_sampling_factors` TEXT NULL DEFAULT NULL,
  `max_after_balance_size` INT(11) NULL DEFAULT NULL,
  `activation` TEXT NULL DEFAULT NULL,
  `hidden` TEXT NULL DEFAULT NULL,
  `epochs` INT(11) NULL DEFAULT NULL,
  `train_samples_per_iteration` INT(11) NULL DEFAULT NULL,
  `target_ratio_comm_to_comp` INT(11) NULL DEFAULT NULL,
  `seed` DOUBLE NULL DEFAULT NULL,
  `adaptive_rate` TEXT NULL DEFAULT NULL,
  `rho` DOUBLE NULL DEFAULT NULL,
  `epsilon` INT(11) NULL DEFAULT NULL,
  `rate` INT(11) NULL DEFAULT NULL,
  `rate_annealing` INT(11) NULL DEFAULT NULL,
  `rate_decay` INT(11) NULL DEFAULT NULL,
  `momentum_start` INT(11) NULL DEFAULT NULL,
  `momentum_ramp` INT(11) NULL DEFAULT NULL,
  `momentum_stable` INT(11) NULL DEFAULT NULL,
  `nesterov_accelerated_gradient` TEXT NULL DEFAULT NULL,
  `input_dropout_ratio` INT(11) NULL DEFAULT NULL,
  `hidden_dropout_ratios` TEXT NULL DEFAULT NULL,
  `l1` INT(11) NULL DEFAULT NULL,
  `l2` INT(11) NULL DEFAULT NULL,
  `max_w2` BIGINT(20) NULL DEFAULT NULL,
  `initial_weight_distribution` TEXT NULL DEFAULT NULL,
  `initial_weight_scale` INT(11) NULL DEFAULT NULL,
  `initial_weights` TEXT NULL DEFAULT NULL,
  `initial_biases` TEXT NULL DEFAULT NULL,
  `loss` TEXT NULL DEFAULT NULL,
  `distribution` TEXT NULL DEFAULT NULL,
  `tweedie_power` INT(11) NULL DEFAULT NULL,
  `quantile_alpha` DOUBLE NULL DEFAULT NULL,
  `score_interval` INT(11) NULL DEFAULT NULL,
  `score_training_samples` INT(11) NULL DEFAULT NULL,
  `score_validation_samples` INT(11) NULL DEFAULT NULL,
  `runtime` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `deep_algo_id_idx` (`algo_id` ASC) VISIBLE,
  INDEX `deep_model_id_idx` (`model_id` ASC) VISIBLE,
  CONSTRAINT `deep_algo_id`
    FOREIGN KEY (`algo_id`)
    REFERENCES `hyperparameter_project`.`algo_h20` (`algo_id`),
  CONSTRAINT `deep_model_id`
    FOREIGN KEY (`model_id`)
    REFERENCES `hyperparameter_project`.`models` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `hyperparameter_project`.`drf_hyperpatameters`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hyperparameter_project`.`drf_hyperpatameters` (
  `id` INT(11) NOT NULL,
  `model_id` VARCHAR(255) NULL DEFAULT NULL,
  `algo_id` VARCHAR(10) NULL DEFAULT NULL,
  `mtries` INT(11) NULL DEFAULT NULL,
  `categorical_encoding` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `drf_hyperparameter_FK_model_id_idx` (`model_id` ASC) VISIBLE,
  INDEX `drf_hyperparameter_algo_id` (`algo_id` ASC) VISIBLE,
  CONSTRAINT `drf_hyperparameter_algo_id`
    FOREIGN KEY (`algo_id`)
    REFERENCES `hyperparameter_project`.`algo_h20` (`algo_id`),
  CONSTRAINT `drf_hyperparameter_model_id`
    FOREIGN KEY (`model_id`)
    REFERENCES `hyperparameter_project`.`models` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `hyperparameter_project`.`gbm_hyperparameters`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hyperparameter_project`.`gbm_hyperparameters` (
  `model_id` VARCHAR(50) NULL DEFAULT NULL,
  `learn_rate` DOUBLE NULL DEFAULT NULL,
  `learn_rate_annealing` DOUBLE NULL DEFAULT NULL,
  `col_sample_rate` DOUBLE NULL DEFAULT NULL,
  `max_abs_leafnode_pred` DOUBLE NULL DEFAULT NULL,
  `pred_noise_bandwidth` DOUBLE NULL DEFAULT NULL,
  `distribution` TEXT NULL DEFAULT NULL,
  `tweedie_power` DOUBLE NULL DEFAULT NULL,
  `quantile_alpha` DOUBLE NULL DEFAULT NULL,
  `huber_alpha` DOUBLE NULL DEFAULT NULL,
  `categorical_encoding` TEXT NULL DEFAULT NULL,
  `algo_id` VARCHAR(20) NULL DEFAULT '1',
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `runtime` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `gbm_hyperparameter_FK_model_id_idx` (`model_id` ASC) VISIBLE,
  INDEX `gbm_hyperparameter_FK_algo_id_idx` (`algo_id` ASC) VISIBLE,
  CONSTRAINT `gbm_algo_id`
    FOREIGN KEY (`algo_id`)
    REFERENCES `hyperparameter_project`.`algo_h20` (`algo_id`),
  CONSTRAINT `gbm_model_id`
    FOREIGN KEY (`model_id`)
    REFERENCES `hyperparameter_project`.`models` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 28
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `hyperparameter_project`.`glm_hyperparameters`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hyperparameter_project`.`glm_hyperparameters` (
  `id` INT(11) NOT NULL,
  `model_id` VARCHAR(50) NULL DEFAULT NULL,
  `runtime` INT(11) NULL DEFAULT NULL,
  `algo_id` VARCHAR(20) NULL DEFAULT NULL,
  `seed` DOUBLE NULL DEFAULT NULL,
  `tweedie_variance_power` INT(11) NULL DEFAULT NULL,
  `alpha` JSON NULL DEFAULT NULL,
  `lambda` TEXT NULL DEFAULT NULL,
  `missing_values_handling` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `glm_algo_id_idx` (`algo_id` ASC) VISIBLE,
  INDEX `glm_model_id_idx` (`model_id` ASC) VISIBLE,
  CONSTRAINT `glm_algo_id`
    FOREIGN KEY (`algo_id`)
    REFERENCES `hyperparameter_project`.`algo_h20` (`algo_id`),
  CONSTRAINT `glm_model_id`
    FOREIGN KEY (`model_id`)
    REFERENCES `hyperparameter_project`.`models` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `hyperparameter_project`.`hyperparameters`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hyperparameter_project`.`hyperparameters` (
  `id` INT(11) NOT NULL,
  `model_id` VARCHAR(50) NULL DEFAULT NULL,
  `algo_id` VARCHAR(20) NULL DEFAULT NULL,
  `runtime` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `hyperparameters_algo_id_idx` (`algo_id` ASC) VISIBLE,
  INDEX `hyperparameters_model_id_idx` (`model_id` ASC) VISIBLE,
  CONSTRAINT `hyperparameter_algo_id`
    FOREIGN KEY (`algo_id`)
    REFERENCES `hyperparameter_project`.`algo_h20` (`algo_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `hyperparameter_project`.`model_metrics`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hyperparameter_project`.`model_metrics` (
  `id` VARCHAR(10) NOT NULL,
  `algo_id` VARCHAR(100) NULL DEFAULT NULL,
  `run_time` VARCHAR(100) NULL DEFAULT NULL,
  `model_id` VARCHAR(255) NULL DEFAULT NULL,
  `mse` FLOAT NULL DEFAULT NULL,
  `rmse` FLOAT NULL DEFAULT NULL,
  `mae` FLOAT NULL DEFAULT NULL,
  `rmsle` FLOAT NULL DEFAULT NULL,
  `mean_residue_deviance` FLOAT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `model_id` (`model_id` ASC) VISIBLE,
  INDEX `algo_id` (`algo_id` ASC) VISIBLE,
  CONSTRAINT `model_metrics_ibfk_1`
    FOREIGN KEY (`model_id`)
    REFERENCES `hyperparameter_project`.`models` (`id`),
  CONSTRAINT `model_metrics_ibfk_2`
    FOREIGN KEY (`algo_id`)
    REFERENCES `hyperparameter_project`.`algo_h20` (`algo_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `hyperparameter_project`.`stakedensemble_hyperparameter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hyperparameter_project`.`stakedensemble_hyperparameter` (
  `id` VARCHAR(10) NOT NULL,
  `model_id` VARCHAR(255) NULL DEFAULT NULL,
  `algo_id` VARCHAR(100) NULL DEFAULT NULL,
  `seed` FLOAT NULL DEFAULT NULL,
  `keep_cross_validation_models` FLOAT NULL DEFAULT NULL,
  `keep_cross_validation_predictions` FLOAT NULL DEFAULT NULL,
  `keep_cross_validation_fold_assignment` FLOAT NULL DEFAULT NULL,
  `fold_column` FLOAT NULL DEFAULT NULL,
  `response_column` FLOAT NULL DEFAULT NULL,
  `ignored_columns` FLOAT NULL DEFAULT NULL,
  `ignore_const_cols` FLOAT NULL DEFAULT NULL,
  `score_each_iteration` FLOAT NULL DEFAULT NULL,
  `offset_column` FLOAT NULL DEFAULT NULL,
  `weights_column` FLOAT NULL DEFAULT NULL,
  `theta` FLOAT NULL DEFAULT NULL,
  `solver` FLOAT NULL DEFAULT NULL,
  `alpha` FLOAT NULL DEFAULT NULL,
  `lambda` FLOAT NULL DEFAULT NULL,
  `standardize` FLOAT NULL DEFAULT NULL,
  `missing_values_handling` FLOAT NULL DEFAULT NULL,
  `compute_p_values` FLOAT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `model_id` (`model_id` ASC) VISIBLE,
  INDEX `algo_id` (`algo_id` ASC) VISIBLE,
  CONSTRAINT `stakedensemble_hyperparameter_ibfk_1`
    FOREIGN KEY (`model_id`)
    REFERENCES `hyperparameter_project`.`models` (`id`),
  CONSTRAINT `stakedensemble_hyperparameter_ibfk_2`
    FOREIGN KEY (`algo_id`)
    REFERENCES `hyperparameter_project`.`algo_h20` (`algo_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `hyperparameter_project` ;

-- -----------------------------------------------------
-- Placeholder table for view `hyperparameter_project`.`deeplearning`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hyperparameter_project`.`deeplearning` (`model_id` INT, `runtime` INT);

-- -----------------------------------------------------
-- Placeholder table for view `hyperparameter_project`.`drf`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hyperparameter_project`.`drf` (`model_id` INT, `runtime` INT);

-- -----------------------------------------------------
-- Placeholder table for view `hyperparameter_project`.`gbm`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hyperparameter_project`.`gbm` (`model_id` INT, `runtime` INT);

-- -----------------------------------------------------
-- Placeholder table for view `hyperparameter_project`.`gbm_model_with_different_hyperparameters`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hyperparameter_project`.`gbm_model_with_different_hyperparameters` (`Hyperparameter_models` INT, `learn_rate` INT);

-- -----------------------------------------------------
-- Placeholder table for view `hyperparameter_project`.`glm`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hyperparameter_project`.`glm` (`model_id` INT, `runtime` INT);

-- -----------------------------------------------------
-- Placeholder table for view `hyperparameter_project`.`number_of_models_per_algorithm`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hyperparameter_project`.`number_of_models_per_algorithm` (`Algorithm` INT, `Number of models` INT);

-- -----------------------------------------------------
-- procedure models_based_on_runtime
-- -----------------------------------------------------

DELIMITER $$
USE `hyperparameter_project`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `models_based_on_runtime`(in runtime int)
BEGIN
select h.model_id as Hyperparameter_models 
from hyperparameters h
where h.runtime like concat('%',runtime ,'%')
;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure number_of_models_based_on_runtime
-- -----------------------------------------------------

DELIMITER $$
USE `hyperparameter_project`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `number_of_models_based_on_runtime`(in runtime int)
BEGIN
select count(h.model_id) as Total_Hyperparameter_models 
from hyperparameters h
where h.runtime like concat('%',runtime,'%')
;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure number_of_models_per_algorithm
-- -----------------------------------------------------

DELIMITER $$
USE `hyperparameter_project`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `number_of_models_per_algorithm`(in algorithm varchar(20))
BEGIN
select  a.algo_name, count(h.model_id)
from hyperparameters h
inner join algo_h20 a on
h.algo_id = a.algo_id
where a.algo_name like concat('%',algorithm ,'%')
group by h.algo_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `hyperparameter_project`.`deeplearning`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hyperparameter_project`.`deeplearning`;
USE `hyperparameter_project`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `hyperparameter_project`.`deeplearning` AS select `hyperparameter_project`.`hyperparameters`.`model_id` AS `model_id`,`hyperparameter_project`.`hyperparameters`.`runtime` AS `runtime` from `hyperparameter_project`.`hyperparameters` where (`hyperparameter_project`.`hyperparameters`.`model_id` like 'deeplearning%');

-- -----------------------------------------------------
-- View `hyperparameter_project`.`drf`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hyperparameter_project`.`drf`;
USE `hyperparameter_project`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `hyperparameter_project`.`drf` AS select `hyperparameter_project`.`hyperparameters`.`model_id` AS `model_id`,`hyperparameter_project`.`hyperparameters`.`runtime` AS `runtime` from `hyperparameter_project`.`hyperparameters` where (`hyperparameter_project`.`hyperparameters`.`model_id` like 'drf%');

-- -----------------------------------------------------
-- View `hyperparameter_project`.`gbm`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hyperparameter_project`.`gbm`;
USE `hyperparameter_project`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `hyperparameter_project`.`gbm` AS select `hyperparameter_project`.`hyperparameters`.`model_id` AS `model_id`,`hyperparameter_project`.`hyperparameters`.`runtime` AS `runtime` from `hyperparameter_project`.`hyperparameters` where (`hyperparameter_project`.`hyperparameters`.`model_id` like 'GBM%');

-- -----------------------------------------------------
-- View `hyperparameter_project`.`gbm_model_with_different_hyperparameters`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hyperparameter_project`.`gbm_model_with_different_hyperparameters`;
USE `hyperparameter_project`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `hyperparameter_project`.`gbm_model_with_different_hyperparameters` AS select `hyperparameter_project`.`gbm_hyperparameters`.`model_id` AS `Hyperparameter_models`,`hyperparameter_project`.`gbm_hyperparameters`.`learn_rate` AS `learn_rate` from `hyperparameter_project`.`gbm_hyperparameters` group by `hyperparameter_project`.`gbm_hyperparameters`.`learn_rate`;

-- -----------------------------------------------------
-- View `hyperparameter_project`.`glm`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hyperparameter_project`.`glm`;
USE `hyperparameter_project`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `hyperparameter_project`.`glm` AS select `hyperparameter_project`.`hyperparameters`.`model_id` AS `model_id`,`hyperparameter_project`.`hyperparameters`.`runtime` AS `runtime` from `hyperparameter_project`.`hyperparameters` where (`hyperparameter_project`.`hyperparameters`.`model_id` like 'GLM%');

-- -----------------------------------------------------
-- View `hyperparameter_project`.`number_of_models_per_algorithm`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hyperparameter_project`.`number_of_models_per_algorithm`;
USE `hyperparameter_project`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `hyperparameter_project`.`number_of_models_per_algorithm` AS select `a`.`algo_name` AS `Algorithm`,count(`h`.`model_id`) AS `Number of models` from (`hyperparameter_project`.`hyperparameters` `h` join `hyperparameter_project`.`algo_h20` `a`) where (`h`.`algo_id` = `a`.`algo_id`) group by `h`.`algo_id`;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
