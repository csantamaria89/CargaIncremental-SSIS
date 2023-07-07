--USANDO LA BASE DE DATOS MONROE
USE MONROE
GO

IF EXISTS(SELECT NAME FROM SYS.tables WHERE NAME='ACCIDENTES2')
BEGIN
	DROP TABLE ACCIDENTES2
END
GO

CREATE TABLE ACCIDENTES2(
Fecha INT,
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




-------------------------------------------
SELECT * FROM ACCIDENTES2
GO