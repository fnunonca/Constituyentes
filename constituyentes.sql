#creacion de la base de datos bdconstituyentes
CREATE DATABASE constituyentes;
#usar o seleccionar la base de datos
USE constituyentes;
#borrar la base de datos en caso de hacer modificaciones grandes que incluyen borrar tablas
#DROP DATABASE constituyentes;
###################################### CREACION DE LAS TABLAS  ############################################
#creacion de la tabla persona
DROP TABLE IF EXISTS persona;
CREATE TABLE persona(
	idPersona VARCHAR(10)NOT NULL PRIMARY KEY,
	dni VARCHAR(10) NOT NULL,
    nombre VARCHAR(50)NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    genero VARCHAR(20),
    foto VARCHAR(50000),
    direccionActual VARCHAR(50) NOT NULL,
	nroCelular VARCHAR(50),
	correo VARCHAR(50) NOT NULL,
    contraseña VARCHAR(50) NOT NULL,
    tipoUsuario varchar(50) NOT NULL,
    descripcion VARCHAR(1000),
    estado VARCHAR(20)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

#creacion de la tabla capacitaciones
DROP TABLE IF EXISTS capacitaciones;
CREATE TABLE capacitaciones(
	idcapacitacion int auto_increment primary key,
	idCapacitado VARCHAR(10) NOT NULL,
    nombreCapacitacion VARCHAR(100)NOT NULL,
    nombreInstitucion VARCHAR(100) NOT NULL,
    fechainicio DATE NOT NULL,
    fechaFin DATE NOT NULL,
    foreign key(idCapacitado) references persona(idPersona) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

#creacion de la tabla experienciaLaboral
DROP TABLE IF EXISTS experienciaLaboral;
CREATE TABLE experienciaLaboral(
	idExpLaboral int auto_increment primary key,
	idTrabajo VARCHAR(10) NOT NULL,
    nombreInstitucion VARCHAR(100)NOT NULL,
    cargo VARCHAR(100) NOT NULL,
    fechainicio DATE NOT NULL,
    fechaFin DATE NOT NULL,
    foreign key(idTrabajo) references persona(idPersona) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=latin1;
#creacion de la tabla estudiante
DROP TABLE IF EXISTS estudiante;
CREATE TABLE estudiante(
	idEstudiante VARCHAR(10) NOT NULL PRIMARY KEY,
    semestreAcademico VARCHAR(50) NOT NULL,
    fechaIngreso DATE NOT NULL,
    curricula VARCHAR(50) NOT NULL,
	foreign key(idEstudiante) references persona(idPersona) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

#creacion de la tabla egresado
DROP TABLE IF EXISTS egresado;
CREATE TABLE egresado(
	idEgresado VARCHAR(10) NOT NULL PRIMARY KEY,
    fechaGraduacion DATE NOT NULL,
    lugarTrabajo VARCHAR(50) NOT NULL,
    foreign key(idEgresado) references persona(idPersona) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

#creacion de la tabla profesor
DROP TABLE IF EXISTS profesor;
CREATE TABLE profesor(
	idProfesor VARCHAR(10) NOT NULL PRIMARY KEY,
    especialidad VARCHAR(50)NOT NULL,
	departamento VARCHAR(50) NOT NULL,
	universidad VARCHAR(100) NOT NULL,
    foreign key(idProfesor) references persona(idPersona) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

#creacion de la tabla estudiosPostgrado
DROP TABLE IF EXISTS estudiosPostgrado;
CREATE TABLE estudiosPostgrado(
	idEstudio int auto_increment primary key,
	idEgresado VARCHAR(10),
	idProfesor VARCHAR(10),
    estudioPostgrado VARCHAR(100)NOT NULL,
    nombreUniversidad VARCHAR(100) NOT NULL,
	nombrePostgrado VARCHAR(100) NOT NULL,
    fechainicio DATE NOT NULL,
    fechaFin DATE NOT NULL,
    foreign key(idEgresado) references egresado(idEgresado) ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key(idProfesor) references profesor(idProfesor) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

#creacion de la tabla administrador
DROP TABLE IF EXISTS administrador;
CREATE TABLE administrador(
	idAdministrador VARCHAR(10) NOT NULL PRIMARY KEY,
    puesto VARCHAR(50)NOT NULL,
    foreign key(idAdministrador) references persona(idPersona) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

#creacion de la tabla empleador
DROP TABLE IF EXISTS empleador;
CREATE TABLE empleador(
	idEmpleador VARCHAR(10) NOT NULL PRIMARY KEY,
    nombreEmpresa VARCHAR(50)NOT NULL,
	direccionActualEmpresa VARCHAR(50) NOT NULL,
    empresaRuc VARCHAR(50) NOT NULL,
    foreign key(idEmpleador) references persona(idPersona) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=latin1;


###################################### METODOSPARA LA TABLA PERSONA############################################
# sp_InsertarPersona
DROP PROCEDURE IF EXISTS sp_InsertarPersona;
DELIMITER $$
CREATE PROCEDURE sp_InsertarPersona(
IN	  _idPersona VARCHAR(10),
IN	  _dni VARCHAR(10),
IN    _nombre VARCHAR(50),
IN    _apellidos VARCHAR(50),
IN    _genero VARCHAR(20),
IN    _foto VARCHAR(5000),
IN    _direccionActual VARCHAR(50),
IN	  _nroCelular VARCHAR(50),
IN	  _correo VARCHAR(50),
IN    _contraseña VARCHAR(50),
IN    _tipoUsuario varchar(50),
IN	  _descripcion VARCHAR(1000),
IN    _estado VARCHAR(20)
)
BEGIN
INSERT INTO persona (idPersona,dni,nombre,apellidos,genero,foto,direccionActual,nroCelular,correo,contraseña,tipoUsuario,descripcion,estado)
	VALUES(_idPersona,_dni,_nombre,_apellidos,_genero,_foto,_direccionActual,_nroCelular,_correo,_contraseña,_tipoUsuario,_descripcion,_estado);
END$$
DELIMITER ;

# sp_ModificarPersona
DROP PROCEDURE IF EXISTS sp_ModificarPersona;
DELIMITER $$
CREATE PROCEDURE sp_ModificarPersona(
IN	  _idPersona VARCHAR(10),
IN	  _dni VARCHAR(10),
IN    _nombre VARCHAR(50),
IN    _apellidos VARCHAR(50),
IN    _genero VARCHAR(20),
IN    _foto VARCHAR(5000),
IN    _direccionActual VARCHAR(50),
IN	  _nroCelular VARCHAR(50),
IN	  _correo VARCHAR(50),
IN    _contraseña VARCHAR(50),
IN    _tipoUsuario varchar(50),
IN    _descripcion varchar(1000),
IN    _estado VARCHAR(20)
)
BEGIN
	UPDATE persona
    SET 
		dni=_dni,
		nombre=_nombre,
        apellidos=_apellidos,
        genero=_genero,
        foto=_foto,
        direccionActual=_direccionActual,
        nroCelular=_nroCelular,
        correo=_correo,
        contraseña=_contraseña,
        tipoUsuario=_tipoUsuario,
        descripcion=_descripcion,
        estado=_estado
	WHERE
		idPersona=_idPersona;
END$$
DELIMITER ;
# sp_ListarPersona
DROP PROCEDURE IF EXISTS  sp_ListarPersona;
DELIMITER $$
CREATE PROCEDURE sp_ListarPersona()
BEGIN
    SELECT *FROM persona;
END$$
DELIMITER ;
# sp_EliminarPersona
DROP PROCEDURE IF EXISTS sp_EliminarPersona;
DELIMITER $$
CREATE PROCEDURE sp_EliminarPersona(
IN  _idPersona 		VARCHAR(11)
)
BEGIN
    DELETE FROM persona 
    WHERE
		_idPersona=_idPersona;
END$$
DELIMITER ;

# sp_ListarPorGeneroPersona
DROP PROCEDURE IF EXISTS  sp_ListarPorGeneroPersona;
DELIMITER $$
CREATE PROCEDURE sp_ListarPorGeneroPersona(
IN  _genero 		VARCHAR(20)
)
BEGIN 
	SELECT * FROM persona
    WHERE
		genero=_genero;
END$$
DELIMITER ;

# sp_BuscarDNI
DROP PROCEDURE IF EXISTS  sp_BuscarDNI;
DELIMITER $$
CREATE PROCEDURE sp_BuscarDNI(
IN  _dni 		VARCHAR(10)
)
BEGIN 
	SELECT * FROM persona
    WHERE
		dni=_dni;
END$$
DELIMITER ;
###################################### METODOSPARA LA TABLA ESTUDIANTE############################################
# sp_InsertarEstudiante
DROP PROCEDURE IF EXISTS sp_InsertarEstudiante;
DELIMITER $$
CREATE PROCEDURE sp_InsertarEstudiante(
IN    _idEstudiante VARCHAR(10),
IN    _semestreAcademico VARCHAR(50),
IN    _fechaIngreso DATE,
IN    _curricula VARCHAR(50)
)
BEGIN
INSERT INTO estudiante (idEstudiante, semestreAcademico, fechaIngreso, curricula)
    VALUES (_idEstudiante, _semestreAcademico, _fechaIngreso, _curricula);
END$$
DELIMITER ;

# sp_ModificarEstudiante
DROP PROCEDURE IF EXISTS sp_ModificarEstudiante;
DELIMITER $$
CREATE PROCEDURE sp_ModificarEstudiante(
IN    _idEstudiante VARCHAR(10),
IN    _semestreAcademico VARCHAR(50),
IN    _fechaIngreso DATE,
IN    _curricula VARCHAR(50)
)
BEGIN
    UPDATE estudiante
    SET 
        semestreAcademico = _semestreAcademico,
        fechaIngreso = _fechaIngreso,
        curricula = _curricula
    WHERE
        idEstudiante = _idEstudiante;
END$$
DELIMITER ;

# sp_ListarEstudiante
DROP PROCEDURE IF EXISTS sp_ListarEstudiante;
DELIMITER $$
CREATE PROCEDURE sp_ListarEstudiante()
BEGIN
    SELECT * FROM estudiante;
END$$
DELIMITER ;

# sp_EliminarEstudiante
DROP PROCEDURE IF EXISTS sp_EliminarEstudiante;
DELIMITER $$
CREATE PROCEDURE sp_EliminarEstudiante(
IN    _idEstudiante VARCHAR(10)
)
BEGIN
    DELETE FROM estudiante 
    WHERE
        idEstudiante = _idEstudiante;
END$$
DELIMITER ;

#sp_ListarPorSemestre
DROP PROCEDURE IF EXISTS sp_ListarPorSemestre;
DELIMITER $$
CREATE PROCEDURE sp_ListarPorSemestre(
    IN  _semestreAcademico VARCHAR(50)
)
BEGIN
    SELECT *
    FROM estudiante
    WHERE semestreAcademico = _semestreAcademico;
END$$
DELIMITER ;

# sp_ListarPorFechaIngreso
DROP PROCEDURE IF EXISTS sp_ListarPorFechaIngreso;
DELIMITER $$
CREATE PROCEDURE sp_ListarPorFechaIngreso(
    IN  _fechaIngreso DATE
)
BEGIN
    SELECT *
    FROM estudiante
    WHERE fechaIngreso = _fechaIngreso;
END$$
DELIMITER ;

# sp_ListarPorCurricula
DROP PROCEDURE IF EXISTS sp_ListarPorCurricula;
DELIMITER $$
CREATE PROCEDURE sp_ListarPorCurricula(
    IN  _curricula VARCHAR(50)
)
BEGIN
    SELECT *
    FROM estudiante
    WHERE curricula = _curricula;
END$$
DELIMITER ;


###################################### METODOSPARA LA TABLA EGRESADOS############################################
# sp_InsertarEgresado
DROP PROCEDURE IF EXISTS sp_InsertarEgresado;
DELIMITER $$
CREATE PROCEDURE sp_InsertarEgresado(
IN    _idEgresado VARCHAR(10),
IN    _fechaGraduacion DATE,
IN    _lugarTrabajo VARCHAR(50)
)
BEGIN
INSERT INTO egresado (idEgresado, fechaGraduacion, lugarTrabajo)
    VALUES (_idEgresado, _fechaGraduacion, _lugarTrabajo);
END$$
DELIMITER ;

# sp_ModificarEgresado
DROP PROCEDURE IF EXISTS sp_ModificarEgresado;
DELIMITER $$
CREATE PROCEDURE sp_ModificarEgresado(
IN    _idEgresado VARCHAR(10),
IN    _fechaGraduacion DATE,
IN    _lugarTrabajo VARCHAR(50)
)
BEGIN
    UPDATE egresado
    SET 
        fechaGraduacion = _fechaGraduacion,
        lugarTrabajo = _lugarTrabajo
    WHERE
        idEgresado = _idEgresado;
END$$
DELIMITER ;

# sp_ListarEgresado
DROP PROCEDURE IF EXISTS sp_ListarEgresado;
DELIMITER $$
CREATE PROCEDURE sp_ListarEgresado()
BEGIN
    SELECT * FROM egresado;
END$$
DELIMITER ;

# sp_EliminarEgresado
DROP PROCEDURE IF EXISTS sp_EliminarEgresado;
DELIMITER $$
CREATE PROCEDURE sp_EliminarEgresado(
IN    _idEgresado VARCHAR(10)
)
BEGIN
    DELETE FROM egresado 
    WHERE
        idEgresado = _idEgresado;
END$$
DELIMITER ;

# sp_ListarPorFechaGraduacion
DROP PROCEDURE IF EXISTS sp_ListarPorFechaGraduacion;
DELIMITER $$
CREATE PROCEDURE sp_ListarPorFechaGraduacion(
    IN  _fechaGraduacion DATE
)
BEGIN
    SELECT *
    FROM egresado
    WHERE fechaGraduacion = _fechaGraduacion;
END$$
DELIMITER ;

# sp_ListarPorLugarTrabajo
DROP PROCEDURE IF EXISTS sp_ListarPorLugarTrabajo;
DELIMITER $$
CREATE PROCEDURE sp_ListarPorLugarTrabajo(
    IN  _lugarTrabajo VARCHAR(50)
)
BEGIN
    SELECT *
    FROM egresado
    WHERE lugarTrabajo = _lugarTrabajo;
END$$
DELIMITER ;



###################################### METODOSPARA LA TABLA PROFESOR############################################

# sp_InsertarProfesor
DROP PROCEDURE IF EXISTS sp_InsertarProfesor;
DELIMITER $$
CREATE PROCEDURE sp_InsertarProfesor(
IN    _idProfesor VARCHAR(10),
IN    _especialidad VARCHAR(50),
IN    _departamento VARCHAR(50),
IN    _universidad VARCHAR(100)
)
BEGIN
INSERT INTO profesor (idProfesor, especialidad, departamento,universidad)
    VALUES (_idProfesor, _especialidad, _departamento,_universidad);
END$$
DELIMITER ;

# sp_ModificarProfesor
DROP PROCEDURE IF EXISTS sp_ModificarProfesor;
DELIMITER $$
CREATE PROCEDURE sp_ModificarProfesor(
IN    _idProfesor VARCHAR(10),
IN    _especialidad VARCHAR(50),
IN    _departamento VARCHAR(50),
IN    _universidad VARCHAR(100)
)
BEGIN
    UPDATE profesor
    SET 
        especialidad = _especialidad,
        departamento = _departamento,
        universidad=_universidad
    WHERE
        idProfesor = _idProfesor;
END$$
DELIMITER ;

# sp_ListarProfesor
DROP PROCEDURE IF EXISTS sp_ListarProfesor;
DELIMITER $$
CREATE PROCEDURE sp_ListarProfesor()
BEGIN
    SELECT * FROM profesor;
END$$
DELIMITER ;

# sp_EliminarProfesor
DROP PROCEDURE IF EXISTS sp_EliminarProfesor;
DELIMITER $$
CREATE PROCEDURE sp_EliminarProfesor(
IN    _idProfesor VARCHAR(10)
)
BEGIN
    DELETE FROM profesor 
    WHERE
        idProfesor = _idProfesor;
END$$
DELIMITER ;

# sp_ListarPorEspecialidad
DROP PROCEDURE IF EXISTS sp_ListarPorEspecialidad;
DELIMITER $$
CREATE PROCEDURE sp_ListarPorEspecialidad(
    IN  _especialidad VARCHAR(50)
)
BEGIN
    SELECT *
    FROM profesor
    WHERE especialidad = _especialidad;
END$$
DELIMITER ;

# sp_ListarPorDepartamento
DROP PROCEDURE IF EXISTS sp_ListarPorDepartamento;
DELIMITER $$
CREATE PROCEDURE sp_ListarPorDepartamento(
    IN  _departamento VARCHAR(50)
)
BEGIN
    SELECT *
    FROM profesor
    WHERE departamento = _departamento;
END$$
DELIMITER ;



###################################### METODOSPARA LA TABLA ADMINISTRADOR############################################
# sp_InsertarAdministrador
DROP PROCEDURE IF EXISTS sp_InsertarAdministrador;
DELIMITER $$
CREATE PROCEDURE sp_InsertarAdministrador(
IN    _idAdministrador VARCHAR(10),
IN    _puesto VARCHAR(50)
)
BEGIN
INSERT INTO administrador (idAdministrador, puesto)
    VALUES (_idAdministrador, _puesto);
END$$
DELIMITER ;

# sp_ModificarAdministrador
DROP PROCEDURE IF EXISTS sp_ModificarAdministrador;
DELIMITER $$
CREATE PROCEDURE sp_ModificarAdministrador(
IN    _idAdministrador VARCHAR(10),
IN    _puesto VARCHAR(50)
)
BEGIN
    UPDATE administrador
    SET 
        puesto = _puesto
    WHERE
        idAdministrador = _idAdministrador;
END$$
DELIMITER ;

# sp_ListarAdministrador
DROP PROCEDURE IF EXISTS sp_ListarAdministrador;
DELIMITER $$
CREATE PROCEDURE sp_ListarAdministrador()
BEGIN
    SELECT * FROM administrador;
END$$
DELIMITER ;

# sp_EliminarAdministrador
DROP PROCEDURE IF EXISTS sp_EliminarAdministrador;
DELIMITER $$
CREATE PROCEDURE sp_EliminarAdministrador(
IN    _idAdministrador VARCHAR(10)
)
BEGIN
    DELETE FROM administrador 
    WHERE
        idAdministrador = _idAdministrador;
END$$
DELIMITER ;

# sp_ListarPorPuesto
DROP PROCEDURE IF EXISTS sp_ListarPorPuesto;
DELIMITER $$
CREATE PROCEDURE sp_ListarPorPuesto(
    IN  _puesto VARCHAR(50)
)
BEGIN
    SELECT *
    FROM administrador
    WHERE puesto = _puesto;
END$$
DELIMITER ;


###################################### METODOS PARA LA TABLA EMPLEADOR############################################
# sp_InsertarEmpleador
DROP PROCEDURE IF EXISTS sp_InsertarEmpleador;
DELIMITER $$
CREATE PROCEDURE sp_InsertarEmpleador(
IN    _idEmpleador VARCHAR(10),
IN    _nombreEmpresa VARCHAR(50),
IN    _direccionActualEmpresa VARCHAR(50),
IN    _empresaRuc VARCHAR(50)
)
BEGIN
INSERT INTO empleador (idEmpleador, nombreEmpresa, direccionActualEmpresa, empresaRuc)
    VALUES (_idEmpleador, _nombreEmpresa, _direccionActualEmpresa, _empresaRuc);
END$$
DELIMITER ;

# sp_ModificarEmpleador
DROP PROCEDURE IF EXISTS sp_ModificarEmpleador;
DELIMITER $$
CREATE PROCEDURE sp_ModificarEmpleador(
IN    _idEmpleador VARCHAR(10),
IN    _nombreEmpresa VARCHAR(50),
IN    _direccionActualEmpresa VARCHAR(50),
IN    _empresaRuc VARCHAR(50)
)
BEGIN
    UPDATE empleador
    SET 
        nombreEmpresa = _nombreEmpresa,
        direccionActualEmpresa = _direccionActualEmpresa,
        empresaRuc = _empresaRuc
    WHERE
        idEmpleador = _idEmpleador;
END$$
DELIMITER ;

# sp_ListarEmpleador
DROP PROCEDURE IF EXISTS sp_ListarEmpleador;
DELIMITER $$
CREATE PROCEDURE sp_ListarEmpleador()
BEGIN
    SELECT * FROM empleador;
END$$
DELIMITER ;

# sp_EliminarEmpleador
DROP PROCEDURE IF EXISTS sp_EliminarEmpleador;
DELIMITER $$
CREATE PROCEDURE sp_EliminarEmpleador(
IN    _idEmpleador VARCHAR(10)
)
BEGIN
    DELETE FROM empleador 
    WHERE
        idEmpleador = _idEmpleador;
END$$
DELIMITER ;

# sp_ListarPorNombreEmpresa
DROP PROCEDURE IF EXISTS sp_ListarPorNombreEmpresa;
DELIMITER $$
CREATE PROCEDURE sp_ListarPorNombreEmpresa(
    IN  _nombreEmpresa VARCHAR(50)
)
BEGIN
    SELECT *
    FROM empleador
    WHERE nombreEmpresa = _nombreEmpresa;
END$$
DELIMITER ;

# sp_ListarEmpresas
DROP PROCEDURE IF EXISTS sp_ListarEmpresas;
DELIMITER $$
CREATE PROCEDURE sp_ListarEmpresas()
BEGIN
    SELECT nombreEmpresa
    FROM empleador;
END$$
DELIMITER ;



###################################### METODOS PARA LA TABLA CAPACITACIONES############################################
# sp_InsertarCapacitacion
DROP PROCEDURE IF EXISTS sp_InsertarCapacitacion;
DELIMITER $$
CREATE PROCEDURE sp_InsertarCapacitacion(
    IN  _idCapacitado VARCHAR(10),
    IN  _nombreCapacitacion VARCHAR(100),
    IN  _nombreInstitucion VARCHAR(100),
    IN  _fechainicio DATE,
    IN  _fechaFin DATE
)
BEGIN
    INSERT INTO capacitaciones (idCapacitado, nombreCapacitacion, nombreInstitucion, fechainicio, fechaFin)
    VALUES (_idCapacitado, _nombreCapacitacion, _nombreInstitucion, _fechainicio, _fechaFin);
END$$
DELIMITER ;

# sp_ModificarCapacitacion
DROP PROCEDURE IF EXISTS sp_ModificarCapacitacion;
DELIMITER $$
CREATE PROCEDURE sp_ModificarCapacitacion(
    IN  _idCapacitado VARCHAR(10),
    IN  _nombreCapacitacion VARCHAR(100),
    IN  _nombreInstitucion VARCHAR(100),
    IN  _fechainicio DATE,
    IN  _fechaFin DATE
)
BEGIN
    UPDATE capacitaciones
    SET
        nombreCapacitacion = _nombreCapacitacion,
        nombreInstitucion = _nombreInstitucion,
        fechainicio = _fechainicio,
        fechaFin = _fechaFin
    WHERE
        idCapacitado = _idCapacitado;
END$$
DELIMITER ;

# sp_ListarCapacitaciones
DROP PROCEDURE IF EXISTS sp_ListarCapacitaciones;
DELIMITER $$
CREATE PROCEDURE sp_ListarCapacitaciones()
BEGIN
    SELECT * FROM capacitaciones;
END$$
DELIMITER ;

# sp_EliminarCapacitacion
DROP PROCEDURE IF EXISTS sp_EliminarCapacitacion;
DELIMITER $$
CREATE PROCEDURE sp_EliminarCapacitacion(
    IN  _idCapacitado VARCHAR(10)
)
BEGIN
    DELETE FROM capacitaciones
    WHERE
        idCapacitado = _idCapacitado;
END$$
DELIMITER ;

###################################### METODOS PARA LA TABLA ESTUDIOS POSTGRADO############################################
# sp_InsertarEstudioPostgrado
DROP PROCEDURE IF EXISTS sp_InsertarEstudioPostgrado;
DELIMITER $$
CREATE PROCEDURE sp_InsertarEstudioPostgrado(
    IN  _idEgresado VARCHAR(10),
    IN  _idProfesor VARCHAR(10),
    IN  _estudioPostgrado VARCHAR(100),
    IN  _nombreUniversidad VARCHAR(100),
    IN  _nombrePostgrado VARCHAR(100),
    IN  _fechainicio DATE,
    IN  _fechaFin DATE
)
BEGIN
    INSERT INTO estudiosPostgrado (idEgresado, idProfesor, estudioPostgrado, nombreUniversidad, nombrePostgrado, fechainicio, fechaFin)
    VALUES (_idEgresado, _idProfesor, _estudioPostgrado, _nombreUniversidad, _nombrePostgrado, _fechainicio, _fechaFin);
END$$
DELIMITER ;

# sp_ModificarEstudioPostgrado
DROP PROCEDURE IF EXISTS sp_ModificarEstudioPostgrado;
DELIMITER $$
CREATE PROCEDURE sp_ModificarEstudioPostgrado(
    IN  _idEstudio INT,
    IN  _idEgresado VARCHAR(10),
    IN  _idProfesor VARCHAR(10),
    IN  _estudioPostgrado VARCHAR(100),
    IN  _nombreUniversidad VARCHAR(100),
    IN  _nombrePostgrado VARCHAR(100),
    IN  _fechainicio DATE,
    IN  _fechaFin DATE
)
BEGIN
    UPDATE estudiosPostgrado
    SET
        idEgresado = _idEgresado,
        idProfesor = _idProfesor,
        estudioPostgrado = _estudioPostgrado,
        nombreUniversidad = _nombreUniversidad,
        nombrePostgrado = _nombrePostgrado,
        fechainicio = _fechainicio,
        fechaFin = _fechaFin
    WHERE
        idEstudio = _idEstudio;
END$$
DELIMITER ;

# sp_ListarEstudiosPostgrado
DROP PROCEDURE IF EXISTS sp_ListarEstudiosPostgrado;
DELIMITER $$
CREATE PROCEDURE sp_ListarEstudiosPostgrado()
BEGIN
    SELECT * FROM estudiosPostgrado;
END$$
DELIMITER ;

# sp_EliminarEstudioPostgrado
DROP PROCEDURE IF EXISTS sp_EliminarEstudioPostgrado;
DELIMITER $$
CREATE PROCEDURE sp_EliminarEstudioPostgrado(
    IN  _idEstudio INT
)
BEGIN
    DELETE FROM estudiosPostgrado
    WHERE
        idEstudio = _idEstudio;
END$$
DELIMITER ;

###################################### METODOS O CONSULTAS EN 2 TABLAS O MAS############################################
#sp_InsertarExperienciaLaboral
DROP PROCEDURE IF EXISTS sp_InsertarExperienciaLaboral;
DELIMITER $$
CREATE PROCEDURE sp_InsertarExperienciaLaboral(
    IN _idTrabajo VARCHAR(10),
    IN _nombreInstitucion VARCHAR(100),
    IN _cargo VARCHAR(100),
    IN _fechainicio DATE,
    IN _fechaFin DATE
)
BEGIN
    INSERT INTO experienciaLaboral (idTrabajo, nombreInstitucion, cargo, fechainicio, fechaFin)
    VALUES (_idTrabajo, _nombreInstitucion, _cargo, _fechainicio, _fechaFin);
END$$
DELIMITER ;

#sp_ModificarExperienciaLaboral
DROP PROCEDURE IF EXISTS sp_ModificarExperienciaLaboral;
DELIMITER $$
CREATE PROCEDURE sp_ModificarExperienciaLaboral(
    IN _idExpLaboral INT,
    IN _idTrabajo VARCHAR(10),
    IN _nombreInstitucion VARCHAR(100),
    IN _cargo VARCHAR(100),
    IN _fechainicio DATE,
    IN _fechaFin DATE
)
BEGIN
    UPDATE experienciaLaboral
    SET 
        idTrabajo = _idTrabajo,
        nombreInstitucion = _nombreInstitucion,
        cargo = _cargo,
        fechainicio = _fechainicio,
        fechaFin = _fechaFin
    WHERE
        idExpLaboral = _idExpLaboral;
END$$
DELIMITER ;

#sp_ListarExperienciasLaborales
DROP PROCEDURE IF EXISTS sp_ListarExperienciasLaborales;
DELIMITER $$
CREATE PROCEDURE sp_ListarExperienciasLaborales()
BEGIN
    SELECT * FROM experienciaLaboral;
END$$
DELIMITER ;

#sp_EliminarExperienciaLaboral
DROP PROCEDURE IF EXISTS sp_EliminarExperienciaLaboral;
DELIMITER $$
CREATE PROCEDURE sp_EliminarExperienciaLaboral(
    IN _idExpLaboral INT
)
BEGIN
    DELETE FROM experienciaLaboral
    WHERE idExpLaboral = _idExpLaboral;
END$$
DELIMITER ;



###################################### METODOS O CONSULTAS EN 2 TABLAS O MAS############################################
# sp_BuscarPersonaPorSemestreEstudiante este metodo muestra los datos deuna persona por el semestre academico
DROP PROCEDURE IF EXISTS sp_BuscarPersonaPorSemestreEstudiante;
DELIMITER $$
CREATE PROCEDURE sp_BuscarPersonaPorSemestreEstudiante(
    IN  _semestreAcademico VARCHAR(50)
)
BEGIN
    SELECT p.dni, p.nombre, p.apellidos, p.genero, p.foto, p.direccionActual, p.nroCelular, p.correo, p.contraseña, p.tipoUsuario, p.descripcion, p.estado
    FROM persona p
    INNER JOIN estudiante e ON p.idPersona = e.idEstudiante
    WHERE e.semestreAcademico = _semestreAcademico;
END$$
DELIMITER ;

# sp_BuscarPersonaPorFechaIngresoEstudiante este metdoo devuleve los datos de la persona que es estudiante por fecha de ingreso
DROP PROCEDURE IF EXISTS sp_BuscarPersonaPorFechaIngresoEstudiante;
DELIMITER $$
CREATE PROCEDURE sp_BuscarPersonaPorFechaIngresoEstudiante(
    IN  _fechaIngreso DATE
)
BEGIN
    SELECT p.dni, p.nombre, p.apellidos, p.genero, p.foto, p.direccionActual, p.nroCelular, p.correo, p.contraseña, p.tipoUsuario, p.descripcion, p.estado
    FROM persona p
    INNER JOIN estudiante e ON p.idPersona = e.idEstudiante
    WHERE e.fechaIngreso = _fechaIngreso;
END$$
DELIMITER ;


# sp_BuscarPorNombreEmpresa este metodo busca a las persona que trabajan en una empresa 
DROP PROCEDURE IF EXISTS sp_BuscarPorNombreEmpresa;
DELIMITER $$
CREATE PROCEDURE sp_BuscarPorNombreEmpresa(
    IN  _nombreEmpresa VARCHAR(50)
)
BEGIN
    SELECT p.dni, p.nombre, p.apellidos, p.genero, p.foto, p.direccionActual, p.nroCelular, p.correo, p.contraseña, p.tipoUsuario, p.descripcion, p.estado
    FROM persona p
    INNER JOIN empleador e ON p.idPersona = e.idEmpleador
    WHERE e.nombreEmpresa = _nombreEmpresa;
END$$
DELIMITER ;

# sp_BuscarEstudiantePorGenero este metodo muestra los datos del estudiante segun su genero
DROP PROCEDURE IF EXISTS sp_BuscarEstudiantePorGenero;
DELIMITER $$
CREATE PROCEDURE sp_BuscarEstudiantePorGenero(
    IN  _genero VARCHAR(20)
)
BEGIN
    SELECT e.semestreAcademico, e.fechaIngreso, e.curricula
    FROM estudiante e
    INNER JOIN persona p ON e.idEstudiante = p.idPersona
    WHERE p.genero = _genero;
END$$
DELIMITER ;

# sp_BuscarPersonaPorFechaGraduacion este metodo muestra los datos de la persona egresada por fecha de Graduacion
DROP PROCEDURE IF EXISTS sp_BuscarPersonaPorFechaGraduacion;
DELIMITER $$
CREATE PROCEDURE sp_BuscarPersonaPorFechaGraduacion(
    IN  _fechaGraduacion DATE
)
BEGIN
    SELECT p.dni, p.nombre, p.apellidos, p.genero, p.foto, p.direccionActual, p.nroCelular, p.correo, p.contraseña, p.tipoUsuario, p.descripcion, p.estado
    FROM persona p
    INNER JOIN egresado e ON p.idPersona = e.idEgresado
    WHERE e.fechaGraduacion = _fechaGraduacion;
END$$
DELIMITER ;

# sp_BuscarPersonaPorLugarTrabajo
DROP PROCEDURE IF EXISTS sp_BuscarPersonaPorLugarTrabajo;
DELIMITER $$
CREATE PROCEDURE sp_BuscarPersonaPorLugarTrabajo(
    IN  _lugarTrabajo VARCHAR(50)
)
BEGIN
    SELECT p.dni, p.nombre, p.apellidos, p.genero, p.foto, p.direccionActual, p.nroCelular, p.correo, p.contraseña, p.tipoUsuario, p.descripcion, p.estado
    FROM persona p
    INNER JOIN egresado e ON p.idPersona = e.idEgresado
    WHERE e.lugarTrabajo = _lugarTrabajo;
END$$
DELIMITER ;

# sp_BuscarPersonaPorEspecialidad este metodo muestra los datos del docente segun su especialidad
DROP PROCEDURE IF EXISTS sp_BuscarPersonaPorEspecialidad;
DELIMITER $$
CREATE PROCEDURE sp_BuscarPersonaPorEspecialidad(
    IN  _especialidad VARCHAR(50)
)
BEGIN
    SELECT p.dni, p.nombre, p.apellidos, p.genero, p.foto, p.direccionActual, p.nroCelular, p.correo, p.contraseña, p.tipoUsuario, p.descripcion, p.estado
    FROM persona p
    INNER JOIN profesor pr ON p.idPersona = pr.idProfesor
    WHERE pr.especialidad = _especialidad;
END$$
DELIMITER ;

# sp_BuscarPersonaPorDepartamento muestra los datos del docente segun el departamento
DROP PROCEDURE IF EXISTS sp_BuscarPersonaPorDepartamento;
DELIMITER $$
CREATE PROCEDURE sp_BuscarPersonaPorDepartamento(
    IN  _departamento VARCHAR(50)
)
BEGIN
    SELECT p.dni, p.nombre, p.apellidos, p.genero, p.foto, p.direccionActual, p.nroCelular, p.correo, p.contraseña, p.tipoUsuario, p.descripcion, p.estado
    FROM persona p
    INNER JOIN profesor pr ON p.idPersona = pr.idProfesor
    WHERE pr.departamento = _departamento;
END$$
DELIMITER ;

# sp_BuscarPersonaPorUniversidad muestra los datos del docente segun la universidad
DROP PROCEDURE IF EXISTS sp_BuscarPersonaPorUniversidad;
DELIMITER $$
CREATE PROCEDURE sp_BuscarPersonaPorUniversidad(
    IN  _universidad VARCHAR(100)
)
BEGIN
    SELECT p.dni, p.nombre, p.apellidos, p.genero, p.foto, p.direccionActual, p.nroCelular, p.correo, p.contraseña, p.tipoUsuario, p.descripcion, p.estado
    FROM persona p
    INNER JOIN profesor pr ON p.idPersona = pr.idProfesor
    WHERE pr.universidad = _universidad;
END$$
DELIMITER ;

# sp_BuscarPersonaPorNombrePostgrado realiza una operacion entre 3 tablas(persona, profesor y estudioPostgrado) para mostrar los datos de la persona segun el NombrePostgrado
DROP PROCEDURE IF EXISTS sp_BuscarPersonaPorNombrePostgrado;
DELIMITER $$
CREATE PROCEDURE sp_BuscarPersonaPorNombrePostgrado(
    IN  _nombrePostgrado VARCHAR(100)
)
BEGIN
    SELECT p.dni, p.nombre, p.apellidos, p.genero, p.foto, p.direccionActual, p.nroCelular, p.correo, p.contraseña, p.tipoUsuario, p.descripcion, p.estado
    FROM persona p
    INNER JOIN profesor pr ON p.idPersona = pr.idProfesor
    INNER JOIN estudiosPostgrado ep ON pr.idProfesor = ep.idProfesor
    WHERE ep.nombrePostgrado = _nombrePostgrado;
END$$
DELIMITER ;

# sp_BuscarPersonaYProfesorPorNombrePostgrado muestra los datos de persona y profesor en una sola tabla
DROP PROCEDURE IF EXISTS sp_BuscarPersonaYProfesorPorNombrePostgrado;
DELIMITER $$
CREATE PROCEDURE sp_BuscarPersonaYProfesorPorNombrePostgrado(
    IN  _nombrePostgrado VARCHAR(100)
)
BEGIN
    SELECT p.dni, p.nombre, p.apellidos, p.genero, p.foto, p.direccionActual, p.nroCelular, p.correo, p.contraseña, p.tipoUsuario, p.descripcion, p.estado,
           pr.especialidad, pr.departamento
    FROM persona p
    INNER JOIN profesor pr ON p.idPersona = pr.idProfesor
    INNER JOIN estudiosPostgrado ep ON pr.idProfesor = ep.idProfesor
    WHERE ep.nombrePostgrado = _nombrePostgrado;
END$$
DELIMITER ;

# sp_BuscarPersonaPorNombrePostgradoEgresado  realiza una operacion entre 3 tablas(persona, egresado y estudioPostgrado) para mostrar los datos de la persona segun el NombrePostgrado
DROP PROCEDURE IF EXISTS sp_BuscarPersonaPorNombrePostgradoEgresado;
DELIMITER $$
CREATE PROCEDURE sp_BuscarPersonaPorNombrePostgradoEgresado(
    IN  _nombrePostgrado VARCHAR(100)
)
BEGIN
    SELECT p.dni, p.nombre, p.apellidos, p.genero, p.foto, p.direccionActual, p.nroCelular, p.correo, p.contraseña, p.tipoUsuario, p.descripcion, p.estado
    FROM persona p
    INNER JOIN egresado e ON p.idPersona = e.idEgresado
    INNER JOIN estudiosPostgrado ep ON e.idEgresado = ep.idEgresado
    WHERE ep.nombrePostgrado = _nombrePostgrado;
END$$
DELIMITER ;

# sp_BuscarPersonaYEgresadoPorNombrePostgrado muestra los datos de persona y egresao en una sola tabla
DROP PROCEDURE IF EXISTS sp_BuscarPersonaYEgresadoPorNombrePostgrado;
DELIMITER $$
CREATE PROCEDURE sp_BuscarPersonaYEgresadoPorNombrePostgrado(
    IN  _nombrePostgrado VARCHAR(100)
)
BEGIN
    SELECT p.dni, p.nombre, p.apellidos, p.genero, p.foto, p.direccionActual, p.nroCelular, p.correo, p.contraseña, p.tipoUsuario, p.descripcion, p.estado,
           e.fechaGraduacion, e.lugarTrabajo
    FROM persona p
    INNER JOIN egresado e ON p.idPersona = e.idEgresado
    INNER JOIN estudiosPostgrado ep ON e.idEgresado = ep.idEgresado
    WHERE ep.nombrePostgrado = _nombrePostgrado;
END$$
DELIMITER ;
#sp_BuscarPersonaPorAnioGraduacion busca persona por año de graduacion
DROP PROCEDURE IF EXISTS sp_BuscarPersonaPorAnioGraduacion;
DELIMITER $$
CREATE PROCEDURE sp_BuscarPersonaPorAnioGraduacion(
    IN  _anioGraduacion INT
)
BEGIN
    SELECT p.dni, p.nombre, p.apellidos, p.genero, p.foto, p.direccionActual, p.nroCelular, p.correo, p.contraseña, p.tipoUsuario, p.descripcion, p.estado
    FROM persona p
    INNER JOIN egresado e ON p.idPersona = e.idEgresado
    WHERE YEAR(e.fechaGraduacion) = _anioGraduacion;
END$$
DELIMITER ;
#sp_MostrarCapacitacionesConEstudiante devuelve las capacitaciones que el estudiante realizo
DROP PROCEDURE IF EXISTS sp_MostrarCapacitaciones;
DELIMITER $$
CREATE PROCEDURE sp_MostrarCapacitaciones(
    IN  _idCapacitado VARCHAR(10)
)
BEGIN
    SELECT idCapacitado, nombreCapacitacion, nombreInstitucion, fechainicio, fechaFin
    FROM capacitaciones
    WHERE idCapacitado = _idCapacitado;
END$$
DELIMITER ;
# sp_MostrarExperienciaLaboralEstudiante muestra la experiencia laboral del estudiante
DROP PROCEDURE IF EXISTS sp_MostrarExperienciaLaboralEstudiante;
DELIMITER $$
CREATE PROCEDURE sp_MostrarExperienciaLaboralEstudiante(
    IN _idEstudiante VARCHAR(10)
)
BEGIN
    SELECT el.idExpLaboral, el.nombreInstitucion, el.cargo, el.fechainicio, el.fechaFin
    FROM experienciaLaboral el
    INNER JOIN persona p ON el.idTrabajo = p.idPersona
    INNER JOIN estudiante e ON p.idPersona = e.idEstudiante
    WHERE e.idEstudiante = _idEstudiante;
END$$
DELIMITER ;

#sp_MostrarExperienciaLaboralEgresado 
DROP PROCEDURE IF EXISTS sp_MostrarExperienciaLaboralEgresado;
DELIMITER $$
CREATE PROCEDURE sp_MostrarExperienciaLaboralEgresado(
    IN _idEgresado VARCHAR(10)
)
BEGIN
    SELECT el.idExpLaboral, el.nombreInstitucion, el.cargo, el.fechainicio, el.fechaFin
    FROM experienciaLaboral el
    INNER JOIN persona p ON el.idTrabajo = p.idPersona
    INNER JOIN egresado e ON p.idPersona = e.idEgresado
    WHERE e.idEgresado = _idEgresado;
END$$
DELIMITER ;

#sp_MostrarExperienciaLaboralProfesor
DROP PROCEDURE IF EXISTS sp_MostrarExperienciaLaboralProfesor;
DELIMITER $$
CREATE PROCEDURE sp_MostrarExperienciaLaboralProfesor(
    IN _idProfesor VARCHAR(10)
)
BEGIN
    SELECT el.idExpLaboral, el.nombreInstitucion, el.cargo, el.fechainicio, el.fechaFin
    FROM experienciaLaboral el
    INNER JOIN persona p ON el.idTrabajo = p.idPersona
    INNER JOIN profesor pr ON p.idPersona = pr.idProfesor
    WHERE pr.idProfesor = _idProfesor;
END$$
DELIMITER ;
#sp_MostrarCapacitacionesPorEgresado
DROP PROCEDURE IF EXISTS sp_MostrarCapacitacionesPorEgresado;
DELIMITER $$
CREATE PROCEDURE sp_MostrarCapacitacionesPorEgresado(
    IN _idEgresado VARCHAR(10)
)
BEGIN
    SELECT c.idCapacitado, c.nombreCapacitacion, c.nombreInstitucion, c.fechainicio, c.fechaFin
    FROM capacitaciones c
    INNER JOIN persona p ON c.idCapacitado = p.idPersona
    INNER JOIN egresado e ON p.idPersona = e.idEgresado
    WHERE e.idEgresado = _idEgresado;
END$$
DELIMITER ;
#sp_MostrarExperienciaLaboralPorEgresado
DROP PROCEDURE IF EXISTS sp_MostrarExperienciaLaboralPorEgresado;
DELIMITER $$
CREATE PROCEDURE sp_MostrarExperienciaLaboralPorEgresado(
    IN _idEgresado VARCHAR(10)
)
BEGIN
    SELECT el.idExpLaboral, el.nombreInstitucion, el.cargo, el.fechainicio, el.fechaFin
    FROM experienciaLaboral el
    INNER JOIN persona p ON el.idTrabajo = p.idPersona
    INNER JOIN egresado e ON p.idPersona = e.idEgresado
    WHERE e.idEgresado = _idEgresado;
END$$
DELIMITER ;

#sp_MostrarCapacitacionesPorProfesor
DROP PROCEDURE IF EXISTS sp_MostrarCapacitacionesPorProfesor;
DELIMITER $$
CREATE PROCEDURE sp_MostrarCapacitacionesPorProfesor(
    IN _idProfesor VARCHAR(10)
)
BEGIN
    SELECT c.idCapacitado, c.nombreCapacitacion, c.nombreInstitucion, c.fechainicio, c.fechaFin
    FROM capacitaciones c
    INNER JOIN persona p ON c.idCapacitado = p.idPersona
    INNER JOIN profesor pr ON p.idPersona = pr.idProfesor
    WHERE pr.idProfesor = _idProfesor;
END$$
DELIMITER ;

#sp_MostrarExperienciaLaboralPorProfesor
DROP PROCEDURE IF EXISTS sp_MostrarExperienciaLaboralPorProfesor;
DELIMITER $$
CREATE PROCEDURE sp_MostrarExperienciaLaboralPorProfesor(
    IN _idProfesor VARCHAR(10)
)
BEGIN
    SELECT el.idExpLaboral, el.nombreInstitucion, el.cargo, el.fechainicio, el.fechaFin
    FROM experienciaLaboral el
    INNER JOIN persona p ON el.idTrabajo = p.idPersona
    INNER JOIN profesor pr ON p.idPersona = pr.idProfesor
    WHERE pr.idProfesor = _idProfesor;
END$$
DELIMITER ;


###################################### PRUEBA DE LOS METODOS############################################
#12/07/23
CALL sp_InsertarPersona('P002', '87654321', 'María', 'López', 'Femenino', 'imagen.jpg', 'Avenida 456', '123456789', 'maria.lopez@example.com', 'pass123', 'estudiante','descripcion ejemlo 01','activo');
CALL sp_InsertarPersona('P003', '98765432', 'Ana', 'González', 'Femenino', 'imagen.jpg', 'Calle Principal 789', '456789123', 'ana.gonzalez@example.com', 'password', 'empleador','descripcion ejemlo 02','activo');
CALL sp_InsertarPersona('P004', '11111111', 'Carlos', 'García', 'Masculino', NULL, 'Avenida 456', '987654321', 'carlos.garcia@example.com', 'contraseña123', 'egresado','descripcion ejemlo 03','activo');
CALL sp_InsertarPersona('P005', '22222222', 'Laura', 'Martínez', 'Femenino', 'foto.jpg', 'Calle 789', '123456789', 'laura.martinez@example.com', 'pass123', 'egresado','descripcion ejemlo 04','activo');
CALL sp_InsertarPersona('P006', '33333333', 'Pedro', 'López', 'Masculino', NULL, 'Avenida Principal 123', '987654321', 'pedro.lopez@example.com', 'password123', 'profesor','descripcion ejemlo 05','activo');
CALL sp_InsertarPersona('P007', '44444444', 'Sofía', 'Hernández', 'Femenino', 'foto.jpg', 'Calle Secundaria 456', '123456789', 'sofia.hernandez@example.com', 'pass123', 'Empleador','descripcion ejemlo 06','activo');
CALL sp_InsertarEstudiante('P002', '2023A', '2023-09-01', 'Curriculum.pdf');
CALL sp_InsertarEgresado('P005', '2022-05-15', 'Compañía XYZ');
CALL sp_InsertarEgresado('P004', '2022-06-18', 'Compañía RTS');
CALL sp_InsertarProfesor('P006', 'Matemáticas', 'Departamento de Ciencias','UNSAAC');
CALL sp_InsertarEmpleador('P003', 'Empresa ABC', 'Avenida Principal 789', '12345678901');
CALL sp_InsertarEmpleador('P007', 'Empresa XYZ', 'Calle de ejemplo 02', '32345678901');
CALL sp_InsertarAdministrador('P007', 'Gerente de Operaciones');

CALL sp_InsertarCapacitacion('P002', 'Taller de Marketing Digital', 'Instituto XYZ', '2023-07-01', '2023-07-02');
CALL sp_InsertarEstudioPostgrado(null, 'P006', 'Maestría en Administración de Empresas', 'Universidad ABC', 'MBA', '2021-01-01', '2023-12-31');
CALL sp_InsertarEstudioPostgrado('P004', null, 'Maestría en Tratamiento de reiduos', 'Universidad ejemplo', 'CALL', '2021-01-01', '2023-12-31');

call sp_ModificarPersona('P003', '98765432', 'Ana', 'González', 'Femenino', NULL, 'Calle Principal 789', '456789123', 'ana.gonzalez@example.com', 'password', 'empleador','descripcion ejemlo 02','activo');
Call sp_ModificarEstudiante('P002', '2023A', '2023-09-01', '2018');
call sp_ListarPersona;
CALL sp_ListarEstudiante;
CALL sp_ListarEgresado;
CALL sp_ListarProfesor;
CALL sp_ListarAdministrador;
CALL sp_ListarEmpleador;
Call sp_ListarEstudiosPostgrado;
call sp_ListarCapacitaciones;
#12/07/23
CALL sp_ListarPorGeneroPersona('Masculino');
CALL sp_BuscarDNI('87654321');
CALL sp_ListarPorSemestre('2023A');
CALL sp_ListarPorFechaIngreso('2023-09-01');
CALL sp_ListarPorCurricula('Curriculum.pdf');
CALL sp_ListarPorFechaGraduacion('2022-05-15');
CALL sp_ListarPorLugarTrabajo('Compañía XYZ');
CALL sp_ListarPorEspecialidad('Matemáticas');
CALL sp_ListarPorDepartamento('Departamento de Ciencias');
CALL sp_ListarPorPuesto('Gerente de Operaciones');
CALL sp_ListarPorNombreEmpresa('Empresa ABC');
CALL sp_ListarEmpresas();

#16/07/23
CALL sp_BuscarPersonaPorFechaIngresoEstudiante('2023-09-01');
CALL sp_BuscarPorNombreEmpresa('Empresa XYZ');
CALL sp_BuscarEstudiantePorGenero('Masculino');
CALL sp_BuscarPersonaPorFechaGraduacion('2022-05-15');
CALL sp_BuscarPersonaPorLugarTrabajo('Compañía XYZ');
CALL sp_BuscarPersonaPorEspecialidad('Matemáticas');
CALL sp_BuscarPersonaPorDepartamento('Departamento de Ciencias');
CALL sp_BuscarPersonaPorUniversidad('UNSAAC');
CALL sp_BuscarPersonaPorNombrePostgrado('MBA');
CALL sp_BuscarPersonaYProfesorPorNombrePostgrado('MBA');
CALL sp_BuscarPersonaPorNombrePostgradoEgresado('CALL');
CALL sp_BuscarPersonaYEgresadoPorNombrePostgrado('CALL');
CALL sp_BuscarPersonaPorAnioGraduacion(2022);
 #prueba end to end rendimineto perfomance generar 10000  datos, investigar sobre generar datos aleatorios

#19/07/23
CALL sp_InsertarPersona('P008', '55555555', 'Juan', 'Gómez', 'Masculino', 'foto.jpg', 'Avenida Principal 123', '987654321', 'juan.gomez@example.com', 'password', 'Normal', 'descripcion ejemplo 07','activo');
CALL sp_InsertarPersona('P009', '66666666', 'Luis', 'Ramírez', 'Masculino', NULL, 'Calle 789', '123456789', 'luis.ramirez@example.com', 'pass123', 'Normal', 'descripcion ejemplo 08','activo');
CALL sp_InsertarPersona('P010', '77777777', 'María', 'Gutiérrez', 'Femenino', 'imagen.jpg', 'Avenida 456', '123456789', 'maria.gutierrez@example.com', 'pass123', 'Admin', 'descripcion ejemplo 09','activo');
CALL sp_InsertarPersona('P011', '88888888', 'Ana', 'Martínez', 'Femenino', NULL, 'Calle Principal 789', '456789123', 'ana.martinez@example.com', 'password', 'Normal', 'descripcion ejemplo 10','activo');
CALL sp_InsertarPersona('P012', '99999999', 'Pedro', 'López', 'Masculino', NULL, 'Avenida Principal 123', '987654321', 'pedro.lopez@example.com', 'password123', 'Normal', 'descripcion ejemplo 11','activo');
CALL sp_InsertarPersona('P013', '10101010', 'Carlos', 'García', 'Masculino', NULL, 'Avenida 456', '987654321', 'carlos.garcia@example.com', 'contraseña123', 'Normal', 'descripcion ejemplo 12','activo');
CALL sp_InsertarPersona('P014', '11111111', 'Laura', 'Martínez', 'Femenino', 'foto.jpg', 'Calle 789', '123456789', 'laura.martinez@example.com', 'pass123', 'Normal', 'descripcion ejemplo 13','activo');
CALL sp_InsertarPersona('P015', '12121212', 'José', 'Pérez', 'Masculino', NULL, 'Avenida Principal 123', '987654321', 'jose.perez@example.com', 'password123', 'Admin', 'descripcion ejemplo 14','activo');
CALL sp_InsertarPersona('P016', '13131313', 'María', 'López', 'Femenino', 'imagen.jpg', 'Avenida 456', '123456789', 'maria.lopez@example.com', 'pass123', 'Admin', 'descripcion ejemplo 15','activo');
CALL sp_InsertarPersona('P017', '14141414', 'Alejandro', 'González', 'Masculino', NULL, 'Calle Principal 789', '456789123', 'alejandro.gonzalez@example.com', 'password', 'Normal', 'descripcion ejemplo 16','activo');
CALL sp_InsertarPersona('P018', '15151515', 'Gabriela', 'Sánchez', 'Femenino', 'imagen.jpg', 'Calle Secundaria 456', '123456789', 'gabriela.sanchez@example.com', 'pass123', 'Normal', 'descripcion ejemplo 17','activo');
CALL sp_InsertarPersona('P019', '16161616', 'Fernando', 'Hernández', 'Masculino', 'foto.jpg', 'Avenida Principal 123', '987654321', 'fernando.hernandez@example.com', 'password', 'Admin', 'descripcion ejemplo 18','activo');
CALL sp_InsertarPersona('P020', '17171717', 'Isabel', 'Ramírez', 'Femenino', NULL, 'Calle 789', '123456789', 'isabel.ramirez@example.com', 'pass123', 'Normal', 'descripcion ejemplo 19','activo');
CALL sp_InsertarPersona('P021', '18181818', 'Diego', 'Gómez', 'Masculino', NULL, 'Avenida Principal 123', '987654321', 'diego.gomez@example.com', 'password123', 'Normal', 'descripcion ejemplo 20','activo');
CALL sp_InsertarPersona('P022', '19191919', 'Lucía', 'Martínez', 'Femenino', 'foto.jpg', 'Avenida 456', '123456789', 'lucia.martinez@example.com', 'pass123', 'Normal', 'descripcion ejemplo 21','activo');
CALL sp_InsertarPersona('P023', '20202020', 'Miguel', 'López', 'Masculino', NULL, 'Calle Principal 789', '456789123', 'miguel.lopez@example.com', 'password', 'Admin', 'descripcion ejemplo 22','activo');
CALL sp_InsertarPersona('P024', '21212121', 'Andrea', 'González', 'Femenino', 'imagen.jpg', 'Avenida 456', '123456789', 'andrea.gonzalez@example.com', 'pass123', 'Admin', 'descripcion ejemplo 23','activo');
CALL sp_InsertarPersona('P025', '22222222', 'Martín', 'Pérez', 'Masculino', NULL, 'Avenida Principal 123', '987654321', 'martin.perez@example.com', 'password123', 'Normal', 'descripcion ejemplo 24','activo');
CALL sp_InsertarPersona('P026', '23232323', 'Sara', 'López', 'Femenino', 'imagen.jpg', 'Calle 789', '123456789', 'sara.lopez@example.com', 'pass123', 'Normal', 'descripcion ejemplo 25','activo');
CALL sp_InsertarPersona('P027', '24242424', 'Javier', 'Gutiérrez', 'Masculino', NULL, 'Avenida Principal 123', '987654321', 'javier.gutierrez@example.com', 'password', 'Admin', 'descripcion ejemplo 26','activo');
CALL sp_InsertarEstudiante('P008', '2023B', '2023-09-01', '2022');
CALL sp_InsertarEstudiante('P009', '2024A', '2024-09-01', '2022');
CALL sp_InsertarEstudiante('P010', '2024B', '2024-09-01', '2022');
CALL sp_InsertarEstudiante('P011', '2025A', '2025-09-01', '2022');
CALL sp_InsertarEgresado('P012', '2023-06-30', 'Compañía ABC');
CALL sp_InsertarEgresado('P013', '2024-05-20', 'Empresa XYZ');
CALL sp_InsertarEgresado('P014', '2025-07-10', 'Compañía 123');
CALL sp_InsertarEgresado('P015', '2026-04-25', 'Empresa ABCD');
CALL sp_InsertarProfesor('P016', 'Física', 'Departamento de Ciencias', 'UNSA');
CALL sp_InsertarProfesor('P017', 'Química', 'Departamento de Ciencias', 'UNSAAC');
CALL sp_InsertarProfesor('P018', 'Biología', 'Departamento de Ciencias', 'UTEA');
CALL sp_InsertarProfesor('P019', 'Informática', 'Departamento de Ciencias', 'Andina');
CALL sp_InsertarEmpleador('P020', 'Empresa XYZ', 'Calle Secundaria 456', '98765432109');
CALL sp_InsertarEmpleador('P021', 'Compañía 123', 'Avenida Comercial 789', '23456789012');
CALL sp_InsertarEmpleador('P022', 'Empresa ABCD', 'Calle Principal 123', '34567890123');
CALL sp_InsertarEmpleador('P023', 'Compañía XYZ', 'Avenida Secundaria 456', '45678901234');
CALL sp_InsertarAdministrador('P024', 'principal');
CALL sp_InsertarAdministrador('P025', 'secunadario');
CALL sp_InsertarCapacitacion('P026', 'Taller de Ventas', 'Instituto ABC', '2023-08-15', '2023-08-16');
CALL sp_InsertarCapacitacion('P022', 'Curso de Liderazgo', 'Instituto XYZ', '2023-09-10', '2023-09-12');
CALL sp_InsertarCapacitacion('P027', 'Taller de Comunicación Efectiva', 'Instituto XYZ', '2023-10-20', '2023-10-21');
CALL sp_InsertarCapacitacion('P008', 'Curso de Negociación', 'Instituto 123', '2023-11-05', '2023-11-06');
CALL sp_InsertarCapacitacion('P011', 'Taller de Gestión de Proyectos', 'Instituto XYZ', '2024-02-18', '2024-02-19');
CALL sp_InsertarEstudioPostgrado(null, 'P006', 'Doctorado en Ingeniería Industrial', 'Universidad XYZ', 'PhD', '2022-03-01', '2026-02-28');
CALL sp_InsertarEstudioPostgrado(null, 'P018', 'Maestría en Educación', 'Universidad 123', 'MEd', '2021-09-15', '2023-05-30');
CALL sp_InsertarEstudioPostgrado('P004', null, 'Maestría en Finanzas', 'Universidad XYZ', 'MSc', '2020-06-20', '2022-12-31');
CALL sp_InsertarEstudioPostgrado('P014', null, 'Doctorado en Ciencias de la Computación', 'Universidad ABC', 'PhD', '2023-01-10', '2027-12-20');

#21/07
CALL sp_InsertarExperienciaLaboral('P002', 'Empresa XYZ', 'Analista de Marketing', '2022-01-15', '2023-06-30');
CALL sp_InsertarExperienciaLaboral('P003', 'Compañía ABC', 'Analista Financiero', '2021-03-10', '2022-12-31');
CALL sp_InsertarExperienciaLaboral('P004', 'Empresa XYZ', 'Ingeniero de Software', '2020-07-15', '2023-01-20');
CALL sp_InsertarExperienciaLaboral('P005', 'Consultora ABC', 'Consultor de Negocios', '2019-04-01', '2021-11-30');
CALL sp_InsertarExperienciaLaboral('P007', 'Compañía ABC', 'Gerente de Ventas', '2020-01-05', '2022-07-30');
CALL sp_InsertarExperienciaLaboral('P006', 'Empresa XYZ', 'Analista de Recursos Humanos', '2022-02-20', '2023-12-15');
CALL sp_ListarExperienciasLaborales();

CALL sp_InsertarCapacitacion('P026', 'Taller de Lteria', 'Instituto ABC', '2023-08-15', '2023-08-16');
CALL sp_MostrarCapacitaciones('P002');
CALL sp_MostrarExperienciaLaboralEstudiante('P002');
CALL sp_MostrarExperienciaLaboralEgresado('P004');
CALL sp_MostrarExperienciaLaboralProfesor('P006');
CALL sp_MostrarCapacitacionesPorEgresado('P012');
CALL sp_MostrarExperienciaLaboralPorEgresado('P007');
CALL sp_MostrarCapacitacionesPorProfesor('P006');
CALL sp_MostrarExperienciaLaboralPorProfesor('P006');






