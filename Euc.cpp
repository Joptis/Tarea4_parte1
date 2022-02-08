#include <stdlib.h>     /* abs */
#include <math.h>
#include <cmath>
#define N = 64
int Euc_res(char in_vec1[64], char in_vec2[64])
{
	#pragma HLS INTERFACE m_axi port=in_vec1 bundle=gmem0
 	#pragma HLS INTERFACE m_axi port=in_vec2 bundle=gmem1
	#pragma HLS INTERFACE m_axi port=Euc_res bundle=gmem0
	char abs_res[64];
	char abs_pow[64];
	//abs_res= abs(in_vec1-in_vec2);
	int i;
	int sumatoria=0;
	int raiz=0;
	int Euc_out;
	#pragma HLS array_partition complete variable=abs_pow


	//#pragma HLS interface axis depth=64 port=in_vec1
	//#pragma HLS interface axis depth=64 port=in_vec2
	//#pragma HLS interface axis depth=64 port=Euc_out

	//#pragma HLS pipeline

	int delta;
	for (i=0;i<64;i++)
	{
		//abs_pow[i]= pow(in_vec1[i]-in_vec2[i],2);
		#pragma HLS PIPELINE II=1
		delta= in_vec1[i]-in_vec2[i];
		sumatoria+= delta*delta;
	}


	Euc_out= sqrt(sumatoria);
	return((int)(Euc_out));
}

