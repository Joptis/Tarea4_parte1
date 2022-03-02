#include "EucSW.h"
#include <math.h>
#include <cmath>
#include <iostream>
#include <stdbool.h>
using namespace std;


res_type EucSW (array_type A[M], array_type B[M],bool  flag){
	array_type delta;
	res_type sumatoria = 0;
	res_type C;

	for (int dates = 0; dates < M; dates++) {
	cout <<".A_"<<dates<<"(VectorA["<<dates<<"]),"<< endl;
	}
	for (int dates = 0; dates < M; dates++) {
		cout <<".B_"<<dates<<"(VectorB["<<dates<<"]),"<< endl;
		}


	if (flag==1) {
	          loop: for (int dates = 0; dates < M; dates++) {

	              delta=(A[dates]-B[dates]);
	            // cout <<  "delta_SW = " << delta << endl;
	              sumatoria+= (res_type)(delta*delta);
	             // cout <<"Results of sumatoria_SW: "<< dec << sumatoria << endl;


	         }
			 C = sqrt((res_type)sumatoria);


   return((res_type) C );
//	 cout <<"Results of C_HW: "<< dec << C << endl;
	}
	else{
	 return((res_type)C);
}

}
