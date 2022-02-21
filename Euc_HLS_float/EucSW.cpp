#include "EucSW.h"
#include <math.h>
#include <cmath>


int EucSW (T A[M], T B[M],  float m){
	T delta, sumatoria, C;
	sumatoria=0.0;


	          loop: for (int dates = 0; dates < m; dates++) {

	              delta=(T)(A[dates]-B[dates]);
	              printf("delta= %f\n",delta);
	              sumatoria+= (T)(delta*delta);
	              printf("sumatoria= %f\n",sumatoria);

	         }
			 C = sqrt((float)sumatoria);
			 printf("C= %f\n",C);
			 return(C);

    
}
