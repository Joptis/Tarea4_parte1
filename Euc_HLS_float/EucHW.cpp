#include "EucHW.h"
#include <math.h>
#include <cmath>

int EucHW (T A[M], T B[M],  float m){
	T delta, sumatoria, C;
	sumatoria=0.0;

          loop: for (int dates = 0; dates < m; dates++) {

              delta= A[dates]-B[dates];
              printf("delta= %f\n",delta);
              sumatoria+= delta*delta;
              printf("sumatoria= %f\n",sumatoria);
             
         }
		 C = sqrt(sumatoria);
		 printf("C= %f\n",C);
		 return(C);
 
}
