#include "EucSW.h"
#include <math.h>
#include <cmath>
#include <iostream>
#include <stdbool.h>
using namespace std;


T EucSW (T A[M], T B[M],bool  flag){
	T delta, sumatoria = 0, C;


	if (flag==1) {
	          loop: for (int dates = 0; dates < M; dates++) {

	              delta=(T)(A[dates]-B[dates]);
	             cout <<  "delta_SW = " << delta << endl;
	              sumatoria+= (T)(delta*delta);
	              cout <<"Results of sumatoria_SW: "<< dec << sumatoria << endl;


	         }
			 C = sqrt((T)sumatoria);
		//	 cout <<"Results of C_SW: "<< dec << C << endl;

   return((T) C );
//	 cout <<"Results of C_HW: "<< dec << C << endl;
	}
	else{
	 return((T)C);
}

}
