# Carga Incremental mensual SSIS
Documentación para hacer una carga incremental mensual en una BD de SQL Server mensual y diaria en SSIS SQL Server Integration Services

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
<img src="https://github.com/csantamaria89/CargaIncremental-SSIS/blob/main/assets/Imagen2.png"  height=450>
</p>

Al hacer click en el punto 4(de la imágen anterior) **`...`** se definirá una expresión para obtener el año y el mes. 
En este caso emplearemos la siguiente expresión para obtener el año actual: ```YEAR(GETDATE()) ```

<p align="center">
<img src="https://github.com/csantamaria89/CargaIncremental-SSIS/blob/main/assets/Imagen3.png"  height=450>
</p>

Del mismo modo podemos obtener el mes: ```MONTH(GETDATE()) ```. Ahora lo que se debe hacer es concatenar el año con el mes para obtener el patrón AAAAMM.
Para lo cual es necesrio conocer las variables en SSIS:
<p align="center">
<img src="https://github.com/csantamaria89/CargaIncremental-SSIS/blob/main/assets/Imagen4.png"  height=450>
</p>

```(DT_I4) ( (DT_WSTR, 4)YEAR( GETDATE() ) + RIGHT("0" + (DT_WSTR, 2)MONTH( GETDATE() ), 2))```

Procedemos a probar la expresión:

<p align="center">
<img src="https://github.com/csantamaria89/CargaIncremental-SSIS/blob/main/assets/Imagen5.png"  height=150>
</p>

En este punto, seleccionamos del Tool Box "Excute SQL task" el cual denominamos -> Limpiar mes en curso. Se configura con la conexión al servidor y DB en este caso MASTER. También el SQL Statement, el cual tiene la siguiente consulta: ```DELETE FROM ACCIDENTES WHERE PERIODO = ?```. finalmente en la parte de Parameter Maping agregamos la variable que creamos "Periodo" y en Paarameter Name colocamos 0. Puedes guiarte de la siguiente imagen:

<p align="center">
<img src="https://github.com/csantamaria89/CargaIncremental-SSIS/blob/main/assets/Imagen6.png"  height=500>
</p>

Ahora agregaremos un Box de Data Flow Task, el cual llamaremos Carga Data Accidente y configuraremos el origen en este caso un archivo de Excel en el Data Flow:

<p align="center">
<img src="https://github.com/csantamaria89/CargaIncremental-SSIS/blob/main/assets/Imagen7.png"  height=500>
</p>
<p align="center">
<img src="https://github.com/csantamaria89/CargaIncremental-SSIS/blob/main/assets/Imagen8.png"  height=500>
</p>
<p align="center">
<img src="https://github.com/csantamaria89/CargaIncremental-SSIS/blob/main/assets/Imagen9.png"  height=500>
</p>
<p align="center">
<img src="https://github.com/csantamaria89/CargaIncremental-SSIS/blob/main/assets/Imagen10.png"  height=500>
</p>

Agregamos al Data Flow un Box de Data Convertion, podemos compararlo con la DB que creamos al inicio para dejar los mismos tipos de variables:
<p align="center">
<img src="https://github.com/csantamaria89/CargaIncremental-SSIS/blob/main/assets/Imagen11.png"  height=450>
</p>

Agregamos al Data Flow un Box de Derived Column para agregar los datos de la variable PERIODO en la DB:
<p align="center">
<img src="https://github.com/csantamaria89/CargaIncremental-SSIS/blob/main/assets/Imagen12.png"  height=450>
</p>
Agregamos el destino que sería la tabla Accidentes dentro de la DB MONROE:

<p align="center">
<img src="https://github.com/csantamaria89/CargaIncremental-SSIS/blob/main/assets/Imagen13.png"  height=450>
</p>
<p align="center">
<img src="https://github.com/csantamaria89/CargaIncremental-SSIS/blob/main/assets/Imagen14.png"  height=450>
</p>

Hasta este punto podríamos ejecutar el proyecto y cargaria el archivo de Excel para el mes 07. Nos falta crear una variable para que el nombre del archivo sea dinámico y pueda leer el nombre del archivo a medida que van cambiando los meses. En esta variable se especifica la ruta donde se almacenarán los archivos:

<p align="center">
<img src="https://github.com/csantamaria89/CargaIncremental-SSIS/blob/main/assets/Imagen15.png"  height=200>
</p>

En las propiedades del Excel vamos a definir la expresión para hacer dinámico el nombre del archivo.

<p align="center">
<img src="https://github.com/csantamaria89/CargaIncremental-SSIS/blob/main/assets/Imagen16.png"  height=50>
</p>

<p align="center">
<img src="https://github.com/csantamaria89/CargaIncremental-SSIS/blob/main/assets/Imagen17.png"  height=450>
</p>

```@[User::Ruta]+"DataAccidente_"+ (DT_WSTR, 6) @[User::Periodo]+".xlsx"```

Finalmente podemos configurar un Breakpoint de tipo Post Execute para limpiar la tabla de Accidentes y poder validar que efectivamente la ejecución del proyecto funciona.

<p align="center">
<img src="https://github.com/csantamaria89/CargaIncremental-SSIS/blob/main/assets/Imagen18.png"  height=300>
</p>

# Carga Incremental diaria SSIS

Creación de variables:

<b>Periodo:</b> AAAAMM ```(DT_I4) LEFT( (DT_WSTR, 8) @[User::Fecha], 6 )```

<b>Fecha:</b> AAAAMMDD ```(DT_WSTR, 4)YEAR( GETDATE()  ) + RIGHT( "0" + (DT_WSTR, 2)  MONTH( GETDATE() ) , 2 ) + RIGHT( "0" + (DT_WSTR, 2)  DAY( GETDATE() ) , 2 ))```

<b>Ruta:</b> Ruta donde se almacenarán los archivos

<p align="center">
<img src="https://github.com/csantamaria89/CargaIncremental-SSIS/blob/main/assets/Imagen19.png"  height=100>
</p>

Cargamos la siguiente DB: Ver Script ```Script+-+Carga+incremental+Diaria.sql```

```Ruby
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
```
<b>Execute SQLTask </b>

<p align="center">
<img src="https://github.com/csantamaria89/CargaIncremental-SSIS/blob/main/assets/Imagen20.png"  height=100>
</p>
