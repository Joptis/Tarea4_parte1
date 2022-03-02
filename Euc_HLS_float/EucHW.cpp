#include "EucHW.h"
#include <math.h>
#include <cmath>
#include <iostream>
#include <stdbool.h>
#include  <stdio.h>
using namespace std;




res_type EucHW (array_type A[M], array_type B[M], bool  flag){
//	#pragma HLS INTERFACE ap_memory port=return
	//int dimm = M;
    //#pragma HLS ARRAY_PARTITION variable=A complete
	//#pragma HLS ARRAY_PARTITION variable=B complete
	#pragma HLS ARRAY_PARTITION variable=A  dim=1
    #pragma HLS ARRAY_PARTITION variable=B  dim=1
	array_type delta;
	res_type sumatoria = 0;
	res_type C=0;

	if (flag==1) {
          loop: for (int dates = 0; dates < M; dates++) {
      //    #pragma HLS LOOP_TRIPCOUNT max=1024
			 #pragma HLS UNROLL factor 16
	 //      #pragma HLS UNROLL  factor=16
	 //       #pragma HLS pipeline  enable_flush rewind
		//	#pragma HLS pipeline
              delta= A[dates]-B[dates];

           //  cout <<"Results of delta_HW: "<< dec << delta << endl;
              sumatoria+= (delta*delta);
           //   cout <<"Results of sumatoria_HW: "<< dec << sumatoria << endl;
          }
          C = sqrt(sumatoria);
         return(C);
	//	 cout <<"Results of C_HW: "<< dec << C << endl;
	}
    else{
		 return(C);
	}
 
}
