# Carga Incremental SSIS
Documentación para hacer una carga incremental en una BD de SQL Server mensual y diaria en SSIS SQL Server Integration Services

1. Relizaremos la creación de la DB que utilizaremos para el ejercicio. <b> (Ver ver archivo "Script Monroe.sql") </b>


```ruby

CREATE DATABASE MONROE
USE MONROE
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
```
<br> ver archivo "Script Monroe.sql"

<p align="center">
<img src=""  height=300>
</p>
