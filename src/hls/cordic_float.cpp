#include "cordic_float.h"

void Cordic(modulo x, modulo y, fase z, modulo * x_out, modulo * y_out, fase * z_out)
{
	/* vars aux*/
	modulo x_prev = 0, y_prev = 0, x_i = 0, y_i = 0, x_less = 0, y_less = 0;
	fase z_prev = 0, z_i = 0;
	modulo K_m_t = 1;
	double raiz = 0;
	int signo = 0;

	/* Pre-procesado*/
	if( x < 0 && y > 0 )
	{
		/*2o*/
		x_prev = y;
		y_prev = (-1)*x;
		z_prev = z + PI2;
	}
	else if( x < 0 && y < 0 )
	{
		/*3er*/
		x_prev = (-1)*y;
		y_prev = x;
		z_prev = z - PI2;
	}
	else
	{
		/*1 - 4 quad*/
		x_prev = x;
		y_prev = y;
		z_prev = z;
	}
    
    cordic:for (int i = 0; i < K; i++)
    {
		
		if(y_prev < 0)
			signo = 1;
		else if (y_prev > 0)
			signo = -1;
		else
			signo = 0;

		
		x_less=x_prev>>(i);
		y_less=y_prev>>(i);
		x_i = x_prev - ((signo)*y_less);
		y_i = y_prev + ((signo)*x_less);
		z_i = z_prev - ((signo)*angulos[i]);
		x_prev = x_i;
		y_prev = y_i;
		z_prev = z_i;

		raiz = sqrt(double(1 + (m * (signo^2) * 2^(-2*i))));
		K_m_t = K_m_t * (modulo)raiz;
    }
      
    /*Factor de compensación de K*/
    *x_out = x_i/K_m_t; 
    *y_out = y_i/K_m_t;
    *z_out = z_i;
}
