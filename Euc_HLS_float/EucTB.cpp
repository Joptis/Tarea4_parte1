//#include <iomanip>
#include <math.h>
#include "specs.h"
#include "EucHW.h"
#include "EucSW.h"
#include <iostream>
#include <stdio.h>
using namespace std;

void genRandArray(array_type min, array_type max, int size, array_type *array);
int compare(res_type gold, res_type result, res_type th);




int main (){
	int errors = 0;
	int tests = 1;
	
	array_type A[M], B[M];
	res_type C_HW, C_SW;

	res_type diff;
	res_type th = 0.000001;
	res_type min = 0;
	res_type max = 100;
	cout << "Data Number: ["<< M <<"]"  << endl;
	for (int i=0; i<tests; i++){
		//genRandArray(min, max, M, A);
		//genRandArray(min, max, M, B);
		T A[8]={1,2,3,4,5,6,7,8};
		T B[8]={8,7,6,5,4,3,2,1};


		C_HW = EucHW (A, B,true);
		C_SW = EucSW (A, B,true);

		errors += compare(C_SW, C_HW,  th);
	//	cout <<"Results of A0: "<< dec << A[0] << endl;
	//	cout <<"Results of B0: "<< dec << B[0] << endl;
		printf("C_SW=%d\n",C_SW);
		printf("C_HW=%d\n",C_HW);
	cout <<"Results of C_SW: " << C_SW << endl;
	cout <<"Results of C_HW: " << C_HW << endl;


	}
	cout <<"Number of errors: " << errors << endl;
	if (errors){
		return 1;
	}


	return 0;
}


void genRandArray(array_type min, array_type max, int size, array_type *array){
    for(int i=0; i<size; i++){
        array[i] = min + static_cast <T> (rand()) / ( static_cast <array_type> (RAND_MAX/(max-min)));
    }
}

int compare(res_type gold, res_type result,  res_type th){
        int errors = 0;
        double dif = 0;
        dif = fabs((double)gold - (double)result);
                // a comparison with NaN will always be false
                if (!(dif <= (double)th)){
                        errors=1;
                }
        return errors;
}
