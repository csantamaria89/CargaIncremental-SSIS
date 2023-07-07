--USANDO LA BASE DE DATOS MASTER
USE master
GO

--CREANDO LA BASE DE DATOS MONROE
IF EXISTS(SELECT NAME FROM SYS.databases WHERE NAME='MONROE')
BEGIN
	DROP DATABASE MONROE
END
GO

CREATE DATABASE MONROE
GO

USE MONROE
GO

CREATE TABLE ACCIDENTES(
Periodo INT,
NumeroRegistro INT,
Semana VARCHAR(MAX),
Colision VARCHAR(MAX),
TipoLesion VARCHAR(MAX),
FactorPrimario VARCHAR(MAX),
ReporteLocasion VARCHAR(MAX),
Latitud VARCHAR(MAX),
Longitud VARCHAR(MAX)
)
GO

-------------------------------------
SELECT * FROM ACCIDENTES
order by periodo desc
GO


select * from ACCIDENTES
order by Periodo