-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema db_control_notas
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db_control_notas
-- -----------------------------------------------------
CREATE DATABASE `control_actividad` ;


-- -----------------------------------------------------
-- Table `control_actividad`.`rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `control_actividad`.`rol` (
  `id_rol` BIGINT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(100) NOT NULL,
  `estado` INT NOT NULL,
  `fecha_commit` DATE NOT NULL,
  `hora_commit` TIME NOT NULL,
  PRIMARY KEY (`id_rol`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `control_actividad`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `control_actividad`.`usuario` (
  `id_usuario` BIGINT NOT NULL AUTO_INCREMENT,
  `nombre_completo` VARCHAR(150) NOT NULL,
  `user` VARCHAR(45) NOT NULL,
  `password` VARCHAR(150) NOT NULL,
  `estado` INT NOT NULL,
  `fecha_commit` DATE NOT NULL,
  `hora_commit` TIME NOT NULL,
  `id_rol` BIGINT NOT NULL,
  PRIMARY KEY (`id_usuario`),
  INDEX `fk_usuario_rol1_idx` (`id_rol` ASC) ,
  CONSTRAINT `fk_usuario_rol1`
    FOREIGN KEY (`id_rol`)
    REFERENCES `control_actividad`.`rol` (`id_rol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `control_actividad`.`grado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `control_actividad`.`grado` (
  `id_grado` BIGINT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(150) NOT NULL,
  `estado` INT NOT NULL DEFAULT 1,
  `fecha_commit` DATE NOT NULL,
  `hora_commit` TIME NOT NULL,
  `id_usuario` BIGINT NOT NULL,
  `id_grado_anterior` BIGINT NULL,
  `id_grado_siguiente` BIGINT NULL,
  PRIMARY KEY (`id_grado`),
  INDEX `fk_grado_usuario1_idx` (`id_usuario` ASC) ,
  INDEX `fk_grado_grado1_idx` (`id_grado_anterior` ASC) ,
  INDEX `fk_grado_grado2_idx` (`id_grado_siguiente` ASC) ,
  CONSTRAINT `fk_grado_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `control_actividad`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_grado_grado1`
    FOREIGN KEY (`id_grado_anterior`)
    REFERENCES `control_actividad`.`grado` (`id_grado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_grado_grado2`
    FOREIGN KEY (`id_grado_siguiente`)
    REFERENCES `control_actividad`.`grado` (`id_grado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `control_actividad`.`seccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `control_actividad`.`seccion` (
  `id_seccion` BIGINT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(150) NOT NULL,
  `estado` INT NOT NULL DEFAULT 1,
  `fecha_commit` DATE NOT NULL,
  `hora_commit` TIME NOT NULL,
  `id_grado` BIGINT NOT NULL,
  `id_usuario` BIGINT NOT NULL,
  PRIMARY KEY (`id_seccion`),
  INDEX `fk_seccion_grado_idx` (`id_grado` ASC) ,
  INDEX `fk_seccion_usuario1_idx` (`id_usuario` ASC) ,
  CONSTRAINT `fk_seccion_grado`
    FOREIGN KEY (`id_grado`)
    REFERENCES `control_actividad`.`grado` (`id_grado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_seccion_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `control_actividad`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `control_actividad`.`alumno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `control_actividad`.`alumno` (
  `id_alumno` BIGINT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(150) NOT NULL,
  `apellido` VARCHAR(150) NOT NULL,
  `direccion` VARCHAR(150) NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `codigo_alumno` VARCHAR(45) NOT NULL,
  `estado` INT NOT NULL DEFAULT 1 COMMENT '1=activo\n0=inactivo',
  `fecha_commit` DATE NOT NULL,
  `hora_commit` TIME NOT NULL,
  `id_seccion` BIGINT NULL COMMENT 'permite null, porque se puede salir del grado y seccion',
  `observacion_expediente` VARCHAR(150) NULL COMMENT 'se usa para poner una observacion del expediente del alumno',
  `id_usuario` BIGINT NOT NULL,
  `estado_expediente` INT NULL COMMENT '1 = completo\n0 = incompleto',
  PRIMARY KEY (`id_alumno`),
  INDEX `fk_alumno_seccion1_idx` (`id_seccion` ASC) ,
  INDEX `fk_alumno_usuario1_idx` (`id_usuario` ASC) ,
  CONSTRAINT `fk_alumno_seccion1`
    FOREIGN KEY (`id_seccion`)
    REFERENCES `control_actividad`.`seccion` (`id_seccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_alumno_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `control_actividad`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `control_actividad`.`materia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `control_actividad`.`materia` (
  `id_materia` BIGINT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(150) NOT NULL,
  `estado` INT NOT NULL DEFAULT 1,
  `fecha_commit` DATE NOT NULL,
  `hora_commit` TIME NOT NULL,
  `id_grado` BIGINT NOT NULL,
  `id_usuario` BIGINT NOT NULL,
  PRIMARY KEY (`id_materia`),
  INDEX `fk_materia_grado1_idx` (`id_grado` ASC) ,
  INDEX `fk_materia_usuario1_idx` (`id_usuario` ASC) ,
  CONSTRAINT `fk_materia_grado1`
    FOREIGN KEY (`id_grado`)
    REFERENCES `control_actividad`.`grado` (`id_grado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_materia_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `control_actividad`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;





-- -----------------------------------------------------
-- Table `control_actividad`.`bimestre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `control_actividad`.`bimestre` (
  `id_bimestre` BIGINT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(150) NOT NULL,
  `puntos_base` DOUBLE(16,2) NOT NULL COMMENT 'punteo total del bimestre, siempre son 100 pts',
  `estado` INT NOT NULL DEFAULT 1 COMMENT '0 = eliminado\n1 = aperturado\n2 = cerrado/finalizado',
  `fecha_commit` DATE NOT NULL,
  `hora_commit` TIME NOT NULL,
  `id_ciclo_escolar` BIGINT NOT NULL,
  `id_usuario` BIGINT NOT NULL,
  PRIMARY KEY (`id_bimestre`),
  INDEX `fk_bimestre_ciclo_escolar1_idx` (`id_ciclo_escolar` ASC) ,
  INDEX `fk_bimestre_usuario1_idx` (`id_usuario` ASC) ,
  CONSTRAINT `fk_bimestre_ciclo_escolar1`
    FOREIGN KEY (`id_ciclo_escolar`)
    REFERENCES `control_actividad`.`ciclo_escolar` (`id_ciclo_escolar`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bimestre_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `control_actividad`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `control_actividad`.`plan_trabajo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `control_actividad`.`plan_trabajo` (
  `id_plan_trabajo` BIGINT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(150) NOT NULL,
  `id_bimestre` BIGINT NOT NULL,
  `id_grado` BIGINT NOT NULL,
  `estado` INT NOT NULL DEFAULT 1,
  `fecha_commit` DATE NOT NULL,
  `hora_commit` TIME NOT NULL,
  `id_usuario` BIGINT NOT NULL,
  PRIMARY KEY (`id_plan_trabajo`),
  INDEX `fk_plan_trabajo_bimestre1_idx` (`id_bimestre` ASC) ,
  INDEX `fk_plan_trabajo_grado1_idx` (`id_grado` ASC) ,
  INDEX `fk_plan_trabajo_usuario1_idx` (`id_usuario` ASC) ,
  CONSTRAINT `fk_plan_trabajo_bimestre1`
    FOREIGN KEY (`id_bimestre`)
    REFERENCES `control_actividad`.`bimestre` (`id_bimestre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_plan_trabajo_grado1`
    FOREIGN KEY (`id_grado`)
    REFERENCES `control_actividad`.`grado` (`id_grado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_plan_trabajo_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `control_actividad`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `control_actividad`.`actividad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `control_actividad`.`actividad` (
  `id_actividad` BIGINT NOT NULL AUTO_INCREMENT,
  `descripcion_actividad` VARCHAR(255) NOT NULL,
  `valor_actividad` DOUBLE(16,2) NOT NULL COMMENT 'el valor de la actividad puede cambiar',
  `id_materia` BIGINT NOT NULL,
  `id_plan_trabajo` BIGINT NOT NULL,
  `id_usuario` BIGINT NOT NULL,
  `estado` INT NOT NULL COMMENT '0 = inactivo\n1 = activo',
  PRIMARY KEY (`id_actividad`),
  INDEX `fk_detalle_plan_trabajo_materia1_idx` (`id_materia` ASC) ,
  INDEX `fk_detalle_plan_trabajo_plan_trabajo1_idx` (`id_plan_trabajo` ASC) ,
  INDEX `fk_actividad_usuario1_idx` (`id_usuario` ASC) ,
  CONSTRAINT `fk_detalle_plan_trabajo_materia1`
    FOREIGN KEY (`id_materia`)
    REFERENCES `control_actividad`.`materia` (`id_materia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_plan_trabajo_plan_trabajo1`
    FOREIGN KEY (`id_plan_trabajo`)
    REFERENCES `control_actividad`.`plan_trabajo` (`id_plan_trabajo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_actividad_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `control_actividad`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;







-- -----------------------------------------------------
-- Table `control_actividad`.`detalle_calificacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `control_actividad`.`detalle_calificacion` (
  `id_detalle_calificacion` BIGINT NOT NULL AUTO_INCREMENT,
  `puntos_obtenidos` DOUBLE(16,2) NOT NULL,
  `id_alumno` BIGINT NOT NULL,
  `id_evaluacion` BIGINT NULL COMMENT 'puede ser null, porque la calificacion puede ser una actividad',
  `fecha_calificacion` DATE NULL COMMENT 'la fecha que se realizo la calificacion',
  `id_usuario` BIGINT NOT NULL,
  `id_bimestre` BIGINT NOT NULL,
  PRIMARY KEY (`id_detalle_calificacion`),
  INDEX `fk_detalle_calificacion_alumno1_idx` (`id_alumno` ASC) ,
  INDEX `fk_detalle_calificacion_evaluacion1_idx` (`id_evaluacion` ASC) ,
  INDEX `fk_detalle_calificacion_usuario1_idx` (`id_usuario` ASC) ,
  INDEX `fk_detalle_calificacion_bimestre1_idx` (`id_bimestre` ASC) ,
  CONSTRAINT `fk_detalle_calificacion_alumno1`
    FOREIGN KEY (`id_alumno`)
    REFERENCES `control_actividad`.`alumno` (`id_alumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_calificacion_evaluacion1`
    FOREIGN KEY (`id_evaluacion`)
    REFERENCES `control_actividad`.`evaluacion` (`id_evaluacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_calificacion_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `control_actividad`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_calificacion_bimestre1`
    FOREIGN KEY (`id_bimestre`)
    REFERENCES `control_actividad`.`bimestre` (`id_bimestre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;







-- -----------------------------------------------------
-- Table `control_actividad`.`listado_asistencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `control_actividad`.`listado_asistencia` (
  `id_listado_asistencia` BIGINT NOT NULL AUTO_INCREMENT,
  `observacion` VARCHAR(255) NULL,
  `fecha` DATE NULL,
  `id_seccion` BIGINT NOT NULL,
  `estado` INT NOT NULL DEFAULT 1,
  `fecha_commit` DATE NOT NULL,
  `hora_commit` TIME NOT NULL,
  `id_usuario` BIGINT NOT NULL,
  `id_bimestre` BIGINT NOT NULL,
  `tipo` INT NOT NULL COMMENT '1 = ASISTENCIA\n2 = OTRO',
  PRIMARY KEY (`id_listado_asistencia`),
  INDEX `fk_listado_asistencia_seccion1_idx` (`id_seccion` ASC) ,
  INDEX `fk_listado_asistencia_usuario1_idx` (`id_usuario` ASC) ,
  INDEX `fk_listado_asistencia_bimestre1_idx` (`id_bimestre` ASC) ,
  CONSTRAINT `fk_listado_asistencia_seccion1`
    FOREIGN KEY (`id_seccion`)
    REFERENCES `control_actividad`.`seccion` (`id_seccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_listado_asistencia_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `control_actividad`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_listado_asistencia_bimestre1`
    FOREIGN KEY (`id_bimestre`)
    REFERENCES `control_actividad`.`bimestre` (`id_bimestre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;








-- -----------------------------------------------------
-- Table `control_actividad`.`nota`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `control_actividad`.`nota` (
  `id_nota` BIGINT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(255) NULL,
  `id_alumno` BIGINT NOT NULL,
  `id_seccion` BIGINT NOT NULL,
  `id_usuario` BIGINT NOT NULL,
  `id_ciclo_escolar` BIGINT NOT NULL,
  `prime_informe` VARCHAR(150) NULL,
  `fecha_primer_informe` DATE NULL,
  `segundo_informe` VARCHAR(150) NULL,
  `fecha_segundo_informe` DATE NULL,
  `tercer_informe` VARCHAR(150) NULL,
  `fecha_tercer_informe` DATE NULL,
  `cuarto_informe` VARCHAR(150) NULL,
  `fecha_cuarto_informe` DATE NULL,
  PRIMARY KEY (`id_nota`),
  INDEX `fk_nota_alumno1_idx` (`id_alumno` ASC) ,
  INDEX `fk_nota_seccion1_idx` (`id_seccion` ASC) ,
  INDEX `fk_nota_usuario1_idx` (`id_usuario` ASC) ,
  INDEX `fk_nota_ciclo_escolar1_idx` (`id_ciclo_escolar` ASC) ,
  CONSTRAINT `fk_nota_alumno1`
    FOREIGN KEY (`id_alumno`)
    REFERENCES `control_actividad`.`alumno` (`id_alumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_nota_seccion1`
    FOREIGN KEY (`id_seccion`)
    REFERENCES `control_actividad`.`seccion` (`id_seccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_nota_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `control_actividad`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_nota_ciclo_escolar1`
    FOREIGN KEY (`id_ciclo_escolar`)
    REFERENCES `control_actividad`.`ciclo_escolar` (`id_ciclo_escolar`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `control_actividad`.`detalle_nota`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `control_actividad`.`detalle_nota` (
  `id_detalle_nota` BIGINT NOT NULL AUTO_INCREMENT,
  `tipo_nota` INT NOT NULL COMMENT 'para determinar si es nota de un bimestre o nota final de año\n\n1 = bimestre\n2 = promedio final',
  `valor_nota` DOUBLE(16,2) NOT NULL,
  `id_materia` BIGINT NOT NULL,
  `id_bimestre` BIGINT NULL COMMENT 'permite null, porque puede ser nota de final de año (promedio final)',
  `id_nota` BIGINT NOT NULL,
  `id_usuario` BIGINT NOT NULL,
  PRIMARY KEY (`id_detalle_nota`),
  INDEX `fk_detalle_nota_materia1_idx` (`id_materia` ASC) ,
  INDEX `fk_detalle_nota_bimestre1_idx` (`id_bimestre` ASC) ,
  INDEX `fk_detalle_nota_nota1_idx` (`id_nota` ASC) ,
  INDEX `fk_detalle_nota_usuario1_idx` (`id_usuario` ASC) ,
  CONSTRAINT `fk_detalle_nota_materia1`
    FOREIGN KEY (`id_materia`)
    REFERENCES `control_actividad`.`materia` (`id_materia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_nota_bimestre1`
    FOREIGN KEY (`id_bimestre`)
    REFERENCES `control_actividad`.`bimestre` (`id_bimestre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_nota_nota1`
    FOREIGN KEY (`id_nota`)
    REFERENCES `control_actividad`.`nota` (`id_nota`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_nota_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `control_actividad`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;






SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
