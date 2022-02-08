#include <stdlib.h>     /* abs */
#include <math.h>
#include <cmath>
#define N = 8
int Euc_res(char in_vec1[8], char in_vec2[8])
{
	#pragma HLS INTERFACE ap_memory port=in_vec1
 	#pragma HLS INTERFACE ap_memory port=in_vec2
	#pragma HLS INTERFACE ap_memory port=return
	char abs_res[8];
	char abs_pow[8];
	//abs_res= abs(in_vec1-in_vec2);
	int i;
	int sumatoria=0;
	int raiz=0;
	int Euc_out;


	//#pragma HLS array_partition complete variable=abs_pow
	#pragma HLS array_partition variable=in_vec1 complete
	#pragma HLS array_partition variable=in_vec2 complete


	//#pragma HLS interface axis depth=8 port=in_vec1
	//#pragma HLS interface axis depth=8 port=in_vec2
	//#pragma HLS interface axis depth=8 port=Euc_out

	//#pragma HLS pipeline

	int delta;
	for (i=0;i<8;i++)
	{
		//abs_pow[i]= pow(in_vec1[i]-in_vec2[i],2);
		#pragma HLS PIPELINE II=1
		delta= in_vec1[i]-in_vec2[i];
		sumatoria+= delta*delta;
	}


	Euc_out= sqrt(sumatoria);
	return((int)(Euc_out));
}

