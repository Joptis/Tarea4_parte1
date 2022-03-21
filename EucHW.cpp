/***************************************************
* Nombre del modulo: EucHW.cpp
*
* Modulo creado para la asignatura IPD432
* Dise�o Avanzado de Sistemas Digitales
* del departamento de Electr�nica de la Universidad
* T�cnica Federico Santa Mar�a. El uso o copia
* por parte de terceros esta prohibida, salvo por fines educativos
* o por evaluaci�n del c�digo
*
* Escrito por Reiner L�pez y Jos� Cayo
*
*
* Descripci�n del m�dulo:
* Contiene la implementaci�n de la distancia Euclidiana, realizada
* a 2 vectores de una dimension, ambos de una longitud de M elementos.
* Mediante la definicion 'T' y 'T2', es posible modificar el tipo de variable
* de los vectores de entrada y resultado Euclidiano, respectivamente, las cuales
* se encuentran en la cabecera 'specs.h'
* En contraste con su contraparte de SW, �ste posee pragmas HLS, es decir, contiene la
* funci�n a implementar como Bloque IP en Vivado. Estos pragman facilitan y/o permiten una sintesis
* factible del bloque
***************************************************/


#include "EucHW.h"
#include <math.h>
#include <cmath>
#include <iostream>
#include <stdbool.h>
#include  <stdio.h>
using namespace std;


/**************************************************
* Nombre    		:  EucHW
* return                : void
* args                  : A[M] (Vector A de M elementos), B[M] (Vector B de M elementos)
* Creada por		: Reiner L�pez
* Descripcion		: Realiza el c�lculo de la distancia euclidiana entre los vectores A y B.
* Cabe recordar que la distancia Euclidiana para este caso en particular est� dado por:
*
* 					D_euc=(sum((A-B)^2))^(1/2)
*
* Adicionalmente, se generan textos de salida para ayudar en la instanciaci�n del m�dulo IP generado,
* concretamente a la conexi�n de los elementos de los vectores
**************************************************/

void EucHW (T2 A[M], T2 B[M],T *C){

/* Pragmas para los arreglos, en caso concreto los Vectores A y B.
 * Tienen como funci�n tener la misma "arquitectura" de acceso a los datos de cada vector
 * (Sistema SIPO (Singular input Parallel Output))
 * */
#pragma HLS ARRAY_PARTITION variable=A complete  // Cada elemento tiene asociada una conexi�n
#pragma HLS ARRAY_PARTITION variable=B complete  // Cada elemento tiene asociada una conexion

	/*Variable que almacena la diferencia del 'dates-esimo' elemento de A y B*/
	T delta;
	/*Variable que almacena los resultados de los deltas*/
	T sumatoria = 0;

	/* loop que realiza el c�lculo euclidiano*/
	          loop: for (int dates = 0; dates < M; dates++) {
	        	  /*Pragma que permite segmentar el loop, y asi salvar recursos a cambio de una
	        	   * mayor latencia. Se intenta con solo el pragma unroll, pero supera el l�mite de
	        	   * recursos disponibles de la Nexys*/
 	 	 	 	 	 #pragma HLS pipeline
	        	  	  delta=(T)(A[dates]-B[dates]);
	              	  sumatoria+= (T)(delta*delta);

	          	  }
	          /* Retorno la raiz de la suma de todos los deltas (D_euc)*/
			 *C = sqrt((T)sumatoria);

}

