#include "cordic_float.h"
#include <math.h>
#include <iostream>
#include <string>

int main(){
	/*variables aux*/
	modulo x_fin=0,y_fin=0;
	modulo aux;
	fase z_fin=0;
	FILE * fd_read, *fd_write;
	char datos2file[50];
	double x_file, y_file, z_file; 
	

	fd_read = fopen("golden_data.dat","r+");
	if (fd_read==NULL){
		printf ("[ERROR] File cannot be openned\n");
		exit (1);
	}

	fd_write = fopen("dataout_hls.dat","w+");
	if (fd_write == NULL)
	{
		printf("[ERROR] Cannot create the file\n");
		exit(1);
	}

	// main loop
	while( fscanf(fd_read, "%lf\t%lf\t%lf\n", &x_file, &y_file, &z_file) != EOF )
	{
		Cordic(x_file, y_file, z_file, &x_fin, &y_fin, &z_fin);
		printf("%.10f\t %.10f\n\r",double((x_fin)),double((z_fin)));
		sprintf(datos2file,"%.10f\t%.10f\n\r",double(x_fin),double(z_fin));
		fwrite(datos2file, sizeof(char), sizeof(datos2file), fd_write);
	}
	
	// close files
	fclose(fd_read);
	fclose(fd_write);

}
