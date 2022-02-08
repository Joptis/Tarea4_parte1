#include <stdlib.h>     /* abs */
#include <math.h>
#include <cmath>
#include <stdio.h>
int Euc_res(char in_vec1[8], char in_vec2[8]);

int main ()
{
	char datos1[8]={1,2,3,4,5,6,7,8};
	char datos2[8]={8,7,6,5,4,3,2,1};
	int salida;

	salida=Euc_res(datos1,datos2);

	/*for(int i =0;i<8;i++)
	{
		printf("")
	}*/

	printf("Salida/resultado euclidiano = %d", salida);
	return(0);
}
