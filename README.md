# Carga Incremental SSIS
Documentación para hacer una carga incremental en una BD de SQL Server mensual y diaria en SSIS SQL Server Integration Services

* Relizaremos la creación de la DB que utilizaremos para el ejercicio. <b> (Ver archivo **`"Script Monroe.sql"`**) </b>

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
* Creamos el proyecto de Integration Services en Visual Studio.

<b>1.</b> A continuación crearemos una variable denominada **`Periodo`** la cual definiará la estructura del nombre de los archivos de excel. La idea es que esta variable pueda identificar el patron de año y mes como se ilustra en la siguiente imágen:

<p align="center">
<img src="https://github.com/csantamaria89/CargaIncremental-SSIS/blob/main/assets/Imagen1.png"  height=150>
</p>

Creamos la variable mencionada anteriormente:

<p align="center">
<img src="https://github.com/csantamaria89/CargaIncremental-SSIS/blob/main/assets/Imagen2.png"  height=150>
</p>
