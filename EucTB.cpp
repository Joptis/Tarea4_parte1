/***************************************************
* Nombre del modulo: EucTB.cpp
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
* Contiene el testbench para comprobar el funcionamiento del c�digo de alto nivel
* antes de su exportaci�n a Vivado. Las prueba es exitosa cuando la salida de EucHW.cpp es igual
* a la salida de EucSW.cpp, aunque es posible ajustar el grado de tolerancia de las pruebas.
***************************************************/

/*Secci�n de includes*/
#include <math.h>
#include "specs.h"
#include "EucHW.h"
#include "EucSW.h"
#include <iostream>
#include <cstdlib>
#include <ctime>
using namespace std;

/* Prototipos de funci�n*/
void genRandArray(T min, T max, int size, T *array);
int compare(T gold, T result, T th);

/**************************************************
* Nombre    		:  main
* return                : int
* args                  : None
* Creada por		: Reiner L�pez
* Descripcion		: Realiza el llamado de las dem�s funciones para realizar
* la verificaci�n funcional del codigo con y sin pragmas. Tambien realiza un cierto
* n�mero de tests en base al valor de la variable 'tests'
**************************************************/


int main (){

	/*N�mero de tests que presenta errores*/
	int errors = 0;
	/*Indica el n�mero de tests a realizar*/
	int tests = 5;
	
	/*Entradas y salidas para realizar la comparaci�n entre ambas funciones*/
	T A[M], B[M];
	T C_HW, C_SW;

	//T diff; //Diferencia,
	T th = 0.000001; //Tolerancia de error
	T min = 0;  //Limite inferior de los numeros generados para A y B
	T max = 100; // �dem, con la diferencia de ser un l�mite superior

	/*Longitud de mis vectores*/
	cout << "Data Number: ["<< M <<"]"  << endl;

	/*Ciclo para ejecutar los tests*/
	for (int i=0; i<tests; i++){

		/* Genero mis vectores, ambos bajo distinta semilla*/
		genRandArray(min, max, M, A);
		genRandArray(min, max, M, B);
	//	T A[8]={1,2,3,4,5,6,7,8};
	//	T B[8]={8,7,6,5,4,3,2,1};

		/*Ejecuto ambos vectores*/
		EucHW (A, B,&C_HW);
		EucSW (A, B,&C_SW);

		/*Comparo los resultados y verificar si el test es aceptado*/
		errors += compare(C_SW, C_HW,  th);

		/*Impresi�n de resultados (Debug)*/
		cout <<"Results of C_SW: "<< dec << C_SW << endl;
		cout <<"Results of C_HW: "<< dec << C_HW << endl;
	}

	/*Impresion de n�mero de errores (debug)*/
	cout <<"Number of errors: " << errors << endl;

	/*La prueba ser� un �xito si no se detecta ning�n error*/
	if (errors){
		return 1;
	}
	return 0;
}

/**************************************************
* Nombre    		:  	genRandArray
* return            : 	void
* args              : 	min (valor m�nimo generado)
* 						max (Valor m�ximo generado)
* 						size (Tama�o del arreglo)
* 						array (Direcci�n del arreglo)
* Creada por		: Reiner L�pez
* Descripci�n		: Realiza la generaci�n de valores aleatorios entre 'min'
* y 'max' al arreglo 'array', con una dimension 'size'. El tipo de variable de los valores
* que el arreglo contiene se encuentra dado por la definici�n 'T', presente en specs.h
**************************************************/
void genRandArray(T min, T max, int size, T *array){

	for(int i=0; i<size; i++){
		/*Generaci�n del valor aleatorio, con �nfasis en equiprobabilidad*/
        array[i] = min + static_cast <T> (rand()) / ( static_cast <T> (RAND_MAX/(max-min)));
    }
}

/**************************************************
* Nombre    		:  	compare
* return            : 	int
* args              : 	gold (Est�ndar de oro)
* 						max (resultado)
* 						th (tolerancia)
* Creada por		: Reiner L�pez
* Descripci�n		: Compara el resultado de hardware, dado por 'result', con el resultado
* de software, dado por 'gold'. En caso de superar el valor de tolerancia 'th', se devuelve un valor de
* error de 1, en caso contrario se devuelve un 0.
**************************************************/
int compare(T gold, T result,  T th){
        int errors = 0;
        double dif = 0;
        /*Diferencia absoluta*/
        dif = fabs((double)gold - (double)result);
                /*Si se supera la tolerancia se tira error
        		*Una comparacion con NaN siempre ser� falso */
                if (!(dif <= (double)th)){
                        errors=1;
                }
        return errors;
}
