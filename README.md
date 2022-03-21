# High-Level Synthesis en FGPA Nexys-4DDR
----

<a href="https://img.shields.io/badge/License-undefined-brightgreen"><img src="https://img.shields.io/badge/License-MIT-brightgreen"></a>

## Tabla de contenidos
- [Description](#descripcion)
- [Installation](#installacion)
- [Cómo usar](#como-usar)
- [Contribución](#contribucion)
- [Test Instructions](#resultados-obtenidos)
- [Información de Contacto](#informacion-de-contacto)

### Descripción
Cosa del cole. El formato de este readme fue realizado mediante la ayuda del generador escrito por Kfields91, presente en el repositorio que se encuentra [aquí](https://github.com/Kfields91/README-Generator)

### Requisitos

Para ejecutar el código presente en este repositorio, se requiere previamente instalar los siguientes programas:

- Vitis HLS (Opcional): Herramienta que compila el código de alto nivel y lo exporta a un bloque IP para su uso en Vivado. Si bien no es un requisito tenerlo instalado, ya que el repositorio posee el archivo exportado por Vitis HLS, es recomendable si se busca verificar el funcionamiento o en su defecto entender de mejor manera el código.

- Vivado: Herramienta para realizar la síntesis e implementación de los códigos escritos en lenguaje SystemVerilog a la tarjeta FPGA a utilizar.

- Matlab: Herramienta utilizada para la implementación de la interfaz que establece la comunicación UART con la tarjeta, lo cual incluye envio y recibo de datos, a la vez de ejecutar las operaciones vectoriales. Se requiere instalar la versión R2019b o superior. No se garantiza el funcionamiento en versiones más antiguas.

La versión utilizada para Vitis HLS y Vivado corresponde al build 2021.1.

IMPORTANTE: Es posible que hasta la fecha Vitis HLS tenga problemas para exportar a Bloque IP debido a un problema denominado "New Year's bug". Para solucionarlo, se deben seguir los pasos estipulados [aquí](https://support.xilinx.com/s/article/76960?language=en_US).


### Instalación

1. Clonar el repositorio a un directorio de su elección. Se puede realizar, por ejemplo, con el siguiente comando en terminal linux:

```
git clone https://github.com/Joptis/Tarea4_parte1
```
### Cómo usar
Imagenes para draft

![ScreenShot](/Fotos/New_project.PNG)
 
 


### Contribución
Si buscas contribuir al repositorio o para realizar consultas del codigo

### Resultados obtenidos
Para probar el cÃ³digo debes

### Informacion de contacto
[Github Profile](https://github.com/Joptis)
           jose.cayo.14@sansano.usm.cl

