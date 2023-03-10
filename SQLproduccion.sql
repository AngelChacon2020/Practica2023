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
CREATE SCHEMA IF NOT EXISTS `db_control_notas` ;
USE `db_control_notas` ;

-- -----------------------------------------------------
-- Table `db_control_notas`.`rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_control_notas`.`rol` (
  `id_rol` BIGINT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(100) NOT NULL,
  `estado` INT NOT NULL,
  `fecha_commit` DATE NOT NULL,
  `hora_commit` TIME NOT NULL,
  PRIMARY KEY (`id_rol`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_control_notas`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_control_notas`.`usuario` (
  `id_usuario` BIGINT NOT NULL AUTO_INCREMENT,
  `nombre_completo` VARCHAR(150) NOT NULL,
  `user` VARCHAR(45) NOT NULL,
  `password` VARCHAR(150) NOT NULL,
  `estado` INT NOT NULL,
  `fecha_commit` DATE NOT NULL,
  `hora_commit` TIME NOT NULL,
  `id_rol` BIGINT NOT NULL,
  PRIMARY KEY (`id_usuario`),
  INDEX `fk_usuario_rol1_idx` (`id_rol` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_rol1`
    FOREIGN KEY (`id_rol`)
    REFERENCES `db_control_notas`.`rol` (`id_rol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_control_notas`.`grado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_control_notas`.`grado` (
  `id_grado` BIGINT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(150) NOT NULL,
  `estado` INT NOT NULL DEFAULT 1,
  `fecha_commit` DATE NOT NULL,
  `hora_commit` TIME NOT NULL,
  `id_usuario` BIGINT NOT NULL,
  `id_grado_anterior` BIGINT NULL,
  `id_grado_siguiente` BIGINT NULL,
  PRIMARY KEY (`id_grado`),
  INDEX `fk_grado_usuario1_idx` (`id_usuario` ASC) VISIBLE,
  INDEX `fk_grado_grado1_idx` (`id_grado_anterior` ASC) VISIBLE,
  INDEX `fk_grado_grado2_idx` (`id_grado_siguiente` ASC) VISIBLE,
  CONSTRAINT `fk_grado_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `db_control_notas`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_grado_grado1`
    FOREIGN KEY (`id_grado_anterior`)
    REFERENCES `db_control_notas`.`grado` (`id_grado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_grado_grado2`
    FOREIGN KEY (`id_grado_siguiente`)
    REFERENCES `db_control_notas`.`grado` (`id_grado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_control_notas`.`seccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_control_notas`.`seccion` (
  `id_seccion` BIGINT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(150) NOT NULL,
  `estado` INT NOT NULL DEFAULT 1,
  `fecha_commit` DATE NOT NULL,
  `hora_commit` TIME NOT NULL,
  `id_grado` BIGINT NOT NULL,
  `id_usuario` BIGINT NOT NULL,
  PRIMARY KEY (`id_seccion`),
  INDEX `fk_seccion_grado_idx` (`id_grado` ASC) VISIBLE,
  INDEX `fk_seccion_usuario1_idx` (`id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_seccion_grado`
    FOREIGN KEY (`id_grado`)
    REFERENCES `db_control_notas`.`grado` (`id_grado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_seccion_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `db_control_notas`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_control_notas`.`alumno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_control_notas`.`alumno` (
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
  INDEX `fk_alumno_seccion1_idx` (`id_seccion` ASC) VISIBLE,
  INDEX `fk_alumno_usuario1_idx` (`id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_alumno_seccion1`
    FOREIGN KEY (`id_seccion`)
    REFERENCES `db_control_notas`.`seccion` (`id_seccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_alumno_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `db_control_notas`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_control_notas`.`materia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_control_notas`.`materia` (
  `id_materia` BIGINT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(150) NOT NULL,
  `estado` INT NOT NULL DEFAULT 1,
  `fecha_commit` DATE NOT NULL,
  `hora_commit` TIME NOT NULL,
  `id_grado` BIGINT NOT NULL,
  `id_usuario` BIGINT NOT NULL,
  PRIMARY KEY (`id_materia`),
  INDEX `fk_materia_grado1_idx` (`id_grado` ASC) VISIBLE,
  INDEX `fk_materia_usuario1_idx` (`id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_materia_grado1`
    FOREIGN KEY (`id_grado`)
    REFERENCES `db_control_notas`.`grado` (`id_grado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_materia_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `db_control_notas`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_control_notas`.`ciclo_escolar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_control_notas`.`ciclo_escolar` (
  `id_ciclo_escolar` BIGINT NOT NULL AUTO_INCREMENT,
  `anio` INT NOT NULL,
  `estado` INT NOT NULL COMMENT '0 = eliminado\n1 = aperturado\n2 = cerrado/finalizado',
  `fecha_apertura` DATE NULL,
  `fecha_cierre` DATE NULL,
  `dias_base_asistencia` INT NOT NULL COMMENT 'dias base para control de asistencia de alumnos, generalmete son 200 dias',
  `id_usuario` BIGINT NOT NULL,
  PRIMARY KEY (`id_ciclo_escolar`),
  INDEX `fk_ciclo_escolar_usuario1_idx` (`id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_ciclo_escolar_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `db_control_notas`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_control_notas`.`bimestre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_control_notas`.`bimestre` (
  `id_bimestre` BIGINT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(150) NOT NULL,
  `puntos_base` DOUBLE(16,2) NOT NULL COMMENT 'punteo total del bimestre, siempre son 100 pts',
  `estado` INT NOT NULL DEFAULT 1 COMMENT '0 = eliminado\n1 = aperturado\n2 = cerrado/finalizado',
  `fecha_commit` DATE NOT NULL,
  `hora_commit` TIME NOT NULL,
  `id_ciclo_escolar` BIGINT NOT NULL,
  `id_usuario` BIGINT NOT NULL,
  PRIMARY KEY (`id_bimestre`),
  INDEX `fk_bimestre_ciclo_escolar1_idx` (`id_ciclo_escolar` ASC) VISIBLE,
  INDEX `fk_bimestre_usuario1_idx` (`id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_bimestre_ciclo_escolar1`
    FOREIGN KEY (`id_ciclo_escolar`)
    REFERENCES `db_control_notas`.`ciclo_escolar` (`id_ciclo_escolar`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bimestre_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `db_control_notas`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_control_notas`.`plan_trabajo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_control_notas`.`plan_trabajo` (
  `id_plan_trabajo` BIGINT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(150) NOT NULL,
  `id_bimestre` BIGINT NOT NULL,
  `id_grado` BIGINT NOT NULL,
  `estado` INT NOT NULL DEFAULT 1,
  `fecha_commit` DATE NOT NULL,
  `hora_commit` TIME NOT NULL,
  `id_usuario` BIGINT NOT NULL,
  PRIMARY KEY (`id_plan_trabajo`),
  INDEX `fk_plan_trabajo_bimestre1_idx` (`id_bimestre` ASC) VISIBLE,
  INDEX `fk_plan_trabajo_grado1_idx` (`id_grado` ASC) VISIBLE,
  INDEX `fk_plan_trabajo_usuario1_idx` (`id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_plan_trabajo_bimestre1`
    FOREIGN KEY (`id_bimestre`)
    REFERENCES `db_control_notas`.`bimestre` (`id_bimestre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_plan_trabajo_grado1`
    FOREIGN KEY (`id_grado`)
    REFERENCES `db_control_notas`.`grado` (`id_grado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_plan_trabajo_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `db_control_notas`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_control_notas`.`actividad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_control_notas`.`actividad` (
  `id_actividad` BIGINT NOT NULL AUTO_INCREMENT,
  `descripcion_actividad` VARCHAR(255) NOT NULL,
  `valor_actividad` DOUBLE(16,2) NOT NULL COMMENT 'el valor de la actividad puede cambiar',
  `id_materia` BIGINT NOT NULL,
  `id_plan_trabajo` BIGINT NOT NULL,
  `id_usuario` BIGINT NOT NULL,
  `estado` INT NOT NULL COMMENT '0 = inactivo\n1 = activo',
  PRIMARY KEY (`id_actividad`),
  INDEX `fk_detalle_plan_trabajo_materia1_idx` (`id_materia` ASC) VISIBLE,
  INDEX `fk_detalle_plan_trabajo_plan_trabajo1_idx` (`id_plan_trabajo` ASC) VISIBLE,
  INDEX `fk_actividad_usuario1_idx` (`id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_detalle_plan_trabajo_materia1`
    FOREIGN KEY (`id_materia`)
    REFERENCES `db_control_notas`.`materia` (`id_materia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_plan_trabajo_plan_trabajo1`
    FOREIGN KEY (`id_plan_trabajo`)
    REFERENCES `db_control_notas`.`plan_trabajo` (`id_plan_trabajo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_actividad_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `db_control_notas`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_control_notas`.`tipo_evaluacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_control_notas`.`tipo_evaluacion` (
  `id_tipo_evaluacion` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NOT NULL COMMENT '- laboratorio\n- examen',
  PRIMARY KEY (`id_tipo_evaluacion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_control_notas`.`evaluacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_control_notas`.`evaluacion` (
  `id_evaluacion` BIGINT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(100) NULL,
  `fecha` DATE NOT NULL,
  `ponderacion` DOUBLE(16,2) NOT NULL COMMENT 'aqui se debe ingresar la cantidad de puntos que vale',
  `id_tipo_evaluacion` INT NOT NULL,
  `id_materia` BIGINT NOT NULL,
  `estado` INT NOT NULL COMMENT '1 = activa\n0 = eliminada',
  `fecha_commit` DATE NOT NULL,
  `hora_commit` TIME NOT NULL,
  `id_usuario` BIGINT NOT NULL,
  `id_bimestre` BIGINT NOT NULL,
  PRIMARY KEY (`id_evaluacion`),
  INDEX `fk_evaluacion_tipo_evaluacion1_idx` (`id_tipo_evaluacion` ASC) VISIBLE,
  INDEX `fk_evaluacion_materia1_idx` (`id_materia` ASC) VISIBLE,
  INDEX `fk_evaluacion_usuario1_idx` (`id_usuario` ASC) VISIBLE,
  INDEX `fk_evaluacion_bimestre1_idx` (`id_bimestre` ASC) VISIBLE,
  CONSTRAINT `fk_evaluacion_tipo_evaluacion1`
    FOREIGN KEY (`id_tipo_evaluacion`)
    REFERENCES `db_control_notas`.`tipo_evaluacion` (`id_tipo_evaluacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_evaluacion_materia1`
    FOREIGN KEY (`id_materia`)
    REFERENCES `db_control_notas`.`materia` (`id_materia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_evaluacion_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `db_control_notas`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_evaluacion_bimestre1`
    FOREIGN KEY (`id_bimestre`)
    REFERENCES `db_control_notas`.`bimestre` (`id_bimestre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_control_notas`.`detalle_calificacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_control_notas`.`detalle_calificacion` (
  `id_detalle_calificacion` BIGINT NOT NULL AUTO_INCREMENT,
  `puntos_obtenidos` DOUBLE(16,2) NOT NULL,
  `id_alumno` BIGINT NOT NULL,
  `id_evaluacion` BIGINT NULL COMMENT 'puede ser null, porque la calificacion puede ser una actividad',
  `fecha_calificacion` DATE NULL COMMENT 'la fecha que se realizo la calificacion',
  `id_usuario` BIGINT NOT NULL,
  `id_bimestre` BIGINT NOT NULL,
  PRIMARY KEY (`id_detalle_calificacion`),
  INDEX `fk_detalle_calificacion_alumno1_idx` (`id_alumno` ASC) VISIBLE,
  INDEX `fk_detalle_calificacion_evaluacion1_idx` (`id_evaluacion` ASC) VISIBLE,
  INDEX `fk_detalle_calificacion_usuario1_idx` (`id_usuario` ASC) VISIBLE,
  INDEX `fk_detalle_calificacion_bimestre1_idx` (`id_bimestre` ASC) VISIBLE,
  CONSTRAINT `fk_detalle_calificacion_alumno1`
    FOREIGN KEY (`id_alumno`)
    REFERENCES `db_control_notas`.`alumno` (`id_alumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_calificacion_evaluacion1`
    FOREIGN KEY (`id_evaluacion`)
    REFERENCES `db_control_notas`.`evaluacion` (`id_evaluacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_calificacion_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `db_control_notas`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_calificacion_bimestre1`
    FOREIGN KEY (`id_bimestre`)
    REFERENCES `db_control_notas`.`bimestre` (`id_bimestre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_control_notas`.`institucion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_control_notas`.`institucion` (
  `id_institucion` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(255) NOT NULL,
  `direccion` VARCHAR(150) NULL,
  `codigo` VARCHAR(100) NOT NULL,
  `estado` INT NOT NULL DEFAULT 1 COMMENT '1 = abierta\n2 = cerreda',
  `fecha_commit` DATE NOT NULL,
  `hora_commit` TIME NOT NULL,
  `nombre_director` VARCHAR(150) NOT NULL,
  `correo` VARCHAR(150) NULL,
  `telefono` VARCHAR(100) NULL,
  `nivel` VARCHAR(100) NULL COMMENT 'basico',
  `sector` VARCHAR(100) NULL,
  `jornada` VARCHAR(100) NULL,
  PRIMARY KEY (`id_institucion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_control_notas`.`libro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_control_notas`.`libro` (
  `id_libro` BIGINT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(150) NOT NULL,
  `descripcion` VARCHAR(255) NOT NULL,
  `estado` INT NOT NULL DEFAULT 1,
  `fecha_commit` DATE NOT NULL,
  `hora_commit` TIME NOT NULL,
  `disponibilidad` INT NOT NULL COMMENT '1 = libro disponible\n2 = no disponible',
  `id_usuario` BIGINT NOT NULL,
  PRIMARY KEY (`id_libro`),
  INDEX `fk_libro_usuario1_idx` (`id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_libro_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `db_control_notas`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_control_notas`.`detalle_lectura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_control_notas`.`detalle_lectura` (
  `id_detalle_lectura` BIGINT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  `tipo_operacion` INT NOT NULL COMMENT '1 = entrega de libro\n2 = paginas leidas\n3 = libro terminado de leer',
  `paginas_leidas` INT NOT NULL,
  `id_libro` BIGINT NOT NULL,
  `id_alumno` BIGINT NOT NULL,
  `id_bimestre` BIGINT NOT NULL,
  PRIMARY KEY (`id_detalle_lectura`),
  INDEX `fk_detalle_lectura_libro1_idx` (`id_libro` ASC) VISIBLE,
  INDEX `fk_detalle_lectura_alumno1_idx` (`id_alumno` ASC) VISIBLE,
  INDEX `fk_detalle_lectura_bimestre1_idx` (`id_bimestre` ASC) VISIBLE,
  CONSTRAINT `fk_detalle_lectura_libro1`
    FOREIGN KEY (`id_libro`)
    REFERENCES `db_control_notas`.`libro` (`id_libro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_lectura_alumno1`
    FOREIGN KEY (`id_alumno`)
    REFERENCES `db_control_notas`.`alumno` (`id_alumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_lectura_bimestre1`
    FOREIGN KEY (`id_bimestre`)
    REFERENCES `db_control_notas`.`bimestre` (`id_bimestre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_control_notas`.`listado_asistencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_control_notas`.`listado_asistencia` (
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
  INDEX `fk_listado_asistencia_seccion1_idx` (`id_seccion` ASC) VISIBLE,
  INDEX `fk_listado_asistencia_usuario1_idx` (`id_usuario` ASC) VISIBLE,
  INDEX `fk_listado_asistencia_bimestre1_idx` (`id_bimestre` ASC) VISIBLE,
  CONSTRAINT `fk_listado_asistencia_seccion1`
    FOREIGN KEY (`id_seccion`)
    REFERENCES `db_control_notas`.`seccion` (`id_seccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_listado_asistencia_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `db_control_notas`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_listado_asistencia_bimestre1`
    FOREIGN KEY (`id_bimestre`)
    REFERENCES `db_control_notas`.`bimestre` (`id_bimestre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_control_notas`.`detalle_listado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_control_notas`.`detalle_listado` (
  `id_detalle_listado` BIGINT NOT NULL,
  `temperatura` DOUBLE(16,2) NULL,
  `observacion` VARCHAR(255) NULL COMMENT 'alguna observacion de manera individual al alumno',
  `id_alumno` BIGINT NOT NULL,
  `id_listado_asistencia` BIGINT NOT NULL,
  `id_bimestre` BIGINT NOT NULL,
  `motivo` VARCHAR(45) NULL COMMENT 'Marcar motivo: \n\nA = Asistencia\nF = Falt??\nP = Permiso',
  PRIMARY KEY (`id_detalle_listado`),
  INDEX `fk_detalle_listado_alumno1_idx` (`id_alumno` ASC) VISIBLE,
  INDEX `fk_detalle_listado_listado_asistencia1_idx` (`id_listado_asistencia` ASC) VISIBLE,
  INDEX `fk_detalle_listado_bimestre1_idx` (`id_bimestre` ASC) VISIBLE,
  CONSTRAINT `fk_detalle_listado_alumno1`
    FOREIGN KEY (`id_alumno`)
    REFERENCES `db_control_notas`.`alumno` (`id_alumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_listado_listado_asistencia1`
    FOREIGN KEY (`id_listado_asistencia`)
    REFERENCES `db_control_notas`.`listado_asistencia` (`id_listado_asistencia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_listado_bimestre1`
    FOREIGN KEY (`id_bimestre`)
    REFERENCES `db_control_notas`.`bimestre` (`id_bimestre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_control_notas`.`documento_expediente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_control_notas`.`documento_expediente` (
  `id_documento_expediente` BIGINT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(255) NULL,
  `estado` INT NOT NULL DEFAULT 1,
  `fecha_commit` DATE NOT NULL,
  `hora_commit` TIME NOT NULL,
  `id_usuario` BIGINT NOT NULL,
  PRIMARY KEY (`id_documento_expediente`),
  INDEX `fk_documento_expediente_usuario1_idx` (`id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_documento_expediente_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `db_control_notas`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_control_notas`.`detalle_expediente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_control_notas`.`detalle_expediente` (
  `id_detalle_expediente` BIGINT NOT NULL AUTO_INCREMENT,
  `estado` INT NOT NULL COMMENT '1 = si se tiene\n0 = no se tiene',
  `id_documento_expediente` BIGINT NOT NULL,
  `id_alumno` BIGINT NOT NULL,
  PRIMARY KEY (`id_detalle_expediente`),
  INDEX `fk_detalle_expediente_documento_expediente1_idx` (`id_documento_expediente` ASC) VISIBLE,
  INDEX `fk_detalle_expediente_alumno1_idx` (`id_alumno` ASC) VISIBLE,
  CONSTRAINT `fk_detalle_expediente_documento_expediente1`
    FOREIGN KEY (`id_documento_expediente`)
    REFERENCES `db_control_notas`.`documento_expediente` (`id_documento_expediente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_expediente_alumno1`
    FOREIGN KEY (`id_alumno`)
    REFERENCES `db_control_notas`.`alumno` (`id_alumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_control_notas`.`nota`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_control_notas`.`nota` (
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
  INDEX `fk_nota_alumno1_idx` (`id_alumno` ASC) VISIBLE,
  INDEX `fk_nota_seccion1_idx` (`id_seccion` ASC) VISIBLE,
  INDEX `fk_nota_usuario1_idx` (`id_usuario` ASC) VISIBLE,
  INDEX `fk_nota_ciclo_escolar1_idx` (`id_ciclo_escolar` ASC) VISIBLE,
  CONSTRAINT `fk_nota_alumno1`
    FOREIGN KEY (`id_alumno`)
    REFERENCES `db_control_notas`.`alumno` (`id_alumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_nota_seccion1`
    FOREIGN KEY (`id_seccion`)
    REFERENCES `db_control_notas`.`seccion` (`id_seccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_nota_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `db_control_notas`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_nota_ciclo_escolar1`
    FOREIGN KEY (`id_ciclo_escolar`)
    REFERENCES `db_control_notas`.`ciclo_escolar` (`id_ciclo_escolar`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_control_notas`.`detalle_nota`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_control_notas`.`detalle_nota` (
  `id_detalle_nota` BIGINT NOT NULL AUTO_INCREMENT,
  `tipo_nota` INT NOT NULL COMMENT 'para determinar si es nota de un bimestre o nota final de a??o\n\n1 = bimestre\n2 = promedio final',
  `valor_nota` DOUBLE(16,2) NOT NULL,
  `id_materia` BIGINT NOT NULL,
  `id_bimestre` BIGINT NULL COMMENT 'permite null, porque puede ser nota de final de a??o (promedio final)',
  `id_nota` BIGINT NOT NULL,
  `id_usuario` BIGINT NOT NULL,
  PRIMARY KEY (`id_detalle_nota`),
  INDEX `fk_detalle_nota_materia1_idx` (`id_materia` ASC) VISIBLE,
  INDEX `fk_detalle_nota_bimestre1_idx` (`id_bimestre` ASC) VISIBLE,
  INDEX `fk_detalle_nota_nota1_idx` (`id_nota` ASC) VISIBLE,
  INDEX `fk_detalle_nota_usuario1_idx` (`id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_detalle_nota_materia1`
    FOREIGN KEY (`id_materia`)
    REFERENCES `db_control_notas`.`materia` (`id_materia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_nota_bimestre1`
    FOREIGN KEY (`id_bimestre`)
    REFERENCES `db_control_notas`.`bimestre` (`id_bimestre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_nota_nota1`
    FOREIGN KEY (`id_nota`)
    REFERENCES `db_control_notas`.`nota` (`id_nota`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_nota_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `db_control_notas`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_control_notas`.`control_actitudinal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_control_notas`.`control_actitudinal` (
  `id_control_actitudinal` BIGINT NOT NULL AUTO_INCREMENT,
  `id_materia` BIGINT NOT NULL,
  `id_alumno` BIGINT NOT NULL,
  `descripcion` VARCHAR(150) NOT NULL,
  `puntos_restados` DOUBLE(16,2) NOT NULL COMMENT 'cantidad de puntos que se agregan',
  `puntos_sumados` DOUBLE(16,2) NOT NULL COMMENT 'cantidad de puntos que se quitan',
  `puntos_actuales` DOUBLE(16,2) NOT NULL,
  `fecha` DATE NOT NULL,
  `fecha_commit` DATE NOT NULL,
  `hora_commit` TIME NOT NULL,
  `id_usuario` BIGINT NOT NULL,
  `id_bimestre` BIGINT NOT NULL,
  PRIMARY KEY (`id_control_actitudinal`),
  INDEX `fk_control_actitudinal_materia1_idx` (`id_materia` ASC) VISIBLE,
  INDEX `fk_control_actitudinal_alumno1_idx` (`id_alumno` ASC) VISIBLE,
  INDEX `fk_control_actitudinal_usuario1_idx` (`id_usuario` ASC) VISIBLE,
  INDEX `fk_control_actitudinal_bimestre1_idx` (`id_bimestre` ASC) VISIBLE,
  CONSTRAINT `fk_control_actitudinal_materia1`
    FOREIGN KEY (`id_materia`)
    REFERENCES `db_control_notas`.`materia` (`id_materia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_control_actitudinal_alumno1`
    FOREIGN KEY (`id_alumno`)
    REFERENCES `db_control_notas`.`alumno` (`id_alumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_control_actitudinal_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `db_control_notas`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_control_actitudinal_bimestre1`
    FOREIGN KEY (`id_bimestre`)
    REFERENCES `db_control_notas`.`bimestre` (`id_bimestre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_control_notas`.`asignacion_materia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_control_notas`.`asignacion_materia` (
  `id_asignacion_materia` BIGINT NOT NULL AUTO_INCREMENT,
  `id_usuario` BIGINT NOT NULL,
  `id_materia` BIGINT NOT NULL,
  `estado` INT NOT NULL COMMENT '1 = registrado\n0 = eliminado',
  PRIMARY KEY (`id_asignacion_materia`),
  INDEX `fk_asignacion_materia_usuario1_idx` (`id_usuario` ASC) VISIBLE,
  INDEX `fk_asignacion_materia_materia1_idx` (`id_materia` ASC) VISIBLE,
  CONSTRAINT `fk_asignacion_materia_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `db_control_notas`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_asignacion_materia_materia1`
    FOREIGN KEY (`id_materia`)
    REFERENCES `db_control_notas`.`materia` (`id_materia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
