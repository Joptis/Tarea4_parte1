# High-Level Synthesis en FGPA Nexys-4DDR
----

<a href="https://img.shields.io/badge/License-undefined-brightgreen"><img src="https://img.shields.io/badge/License-MIT-brightgreen"></a>

## Tabla de contenidos
- [Description](#descripcion)
- [Installation](#installacion)
- [C�mo usar](#como-usar)
- [Contribuci�n](#contribucion)
- [Test Instructions](#resultados-obtenidos)
- [Informaci�n de Contacto](#informacion-de-contacto)

### Descripci�n
Cosa del cole. El formato de este readme fue realizado mediante la ayuda del generador escrito por Kfields91, presente en el repositorio que se encuentra [aqu�](https://github.com/Kfields91/README-Generator)

### Requisitos

Para ejecutar el c�digo presente en este repositorio, se requiere previamente instalar los siguientes programas:

- Vitis HLS (Opcional): Herramienta que compila el c�digo de alto nivel y lo exporta a un bloque IP para su uso en Vivado. Si bien no es un requisito tenerlo instalado, ya que el repositorio posee el archivo exportado por Vitis HLS, es recomendable si se busca verificar el funcionamiento o en su defecto entender de mejor manera el c�digo.

- Vivado: Herramienta para realizar la s�ntesis e implementaci�n de los c�digos escritos en lenguaje SystemVerilog a la tarjeta FPGA a utilizar.

- Matlab: Herramienta utilizada para la implementaci�n de la interfaz que establece la comunicaci�n UART con la tarjeta, lo cual incluye envio y recibo de datos, a la vez de ejecutar las operaciones vectoriales. Se requiere instalar la versi�n R2019b o superior. No se garantiza el funcionamiento en versiones m�s antiguas.

La versi�n utilizada para Vitis HLS y Vivado corresponde al build 2021.1.

IMPORTANTE: Es posible que hasta la fecha Vitis HLS tenga problemas para exportar a Bloque IP debido a un problema denominado "New Year's bug". Para solucionarlo, se deben seguir los pasos estipulados [aqu�](https://support.xilinx.com/s/article/76960?language=en_US).


### Instalaci�n

1. Clonar el repositorio a un directorio de su elecci�n. Se puede realizar, por ejemplo, con el siguiente comando en terminal linux:

```
git clone https://github.com/Joptis/Tarea4_parte1
```

2. Crear un projecto de vivado desde 0

3. Indicar el directorio de la ubicaci�n del archivo .zip que contiene el bloque IP. Para ello, una vez abierto IP Catalog, clic derecha dentro de la interfaz y seleccionar "Add Repository"
### C�mo usar
Imagenes para draft

![ScreenShot](/Fotos/New_project.PNG)
 
 


### Contribuci�n
Si buscas contribuir al repositorio o para realizar consultas del codigo

### Resultados obtenidos

(imagenes dummy y resultados de texto para los resultados)

- Resultados simulaci�n
```

Number of errors: 0
INFO: [SIM 211-1] CSim done with 0 errors.
INFO: [SIM 211-3] *************** CSIM finish ***************
INFO: [HLS 200-111] Finished Command csim_design CPU user time: 6 seconds. CPU system time: 0 seconds. Elapsed time: 6.53 seconds; current allocated memory: 117.766 MB.
Finished C simulation.
```

- Resultado s�ntesis

```
INFO: [VHDL 208-304] Generating VHDL RTL for EucHW.
INFO: [VLOG 209-307] Generating Verilog RTL for EucHW.
INFO: [HLS 200-790] **** Loop Constraint Status: All loop constraints were satisfied.
INFO: [HLS 200-789] **** Estimated Fmax: 140.95 MHz
INFO: [HLS 200-111] Finished Command csynth_design CPU user time: 872 seconds. CPU system time: 6 seconds. Elapsed time: 1084.14 seconds; current allocated memory: 607.312 MB.
INFO: [HLS 200-112] Total CPU user time: 874 seconds. Total CPU system time: 7 seconds. Total elapsed time: 1086.05 seconds; peak allocated memory: 1008.943 MB.
Finished C synthesis.

```
-Resultado Exportaci�n bloque IP

```
INFO: [Common 17-206] Exiting Vivado at Tue Mar 22 15:39:15 2022...
INFO: [HLS 200-802] Generated output file Euc_res.zip
INFO: [HLS 200-111] Finished Command export_design CPU user time: 345 seconds. CPU system time: 5 seconds. Elapsed time: 881.63 seconds; current allocated memory: 211.783 MB.
Finished Export RTL/Implementation.
```

### Informacion de contacto
[Github Profile](https://github.com/Joptis)
           jose.cayo.14@sansano.usm.cl

