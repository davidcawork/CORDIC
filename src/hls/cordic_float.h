#include <ap_fixed.h>
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#define PI 3.14159265358979323846

const int Tam_total = 18;
const int K = 20;
const int m = 1;
typedef ap_fixed<Tam_total, 2, AP_RND_CONV, AP_SAT> modulo;
typedef ap_fixed<Tam_total, 3, AP_RND_CONV,AP_SAT> fase;
const modulo PI2 = PI/2;

const fase angulos[20]={0.785398163397448,0.463647609000806,0.244978663126864,0.124354994546761,
	                   0.0624188099959574,0.0312398334302683,0.0156237286204768,0.00781234106010111,
	                   0.00390623013196697,0.00195312251647882,0.000976562189559320,
	                   0.000488281211194898,0.000244140620149362,0.000122070311893670,
	                   6.10351561742088e-05,3.05175781155261e-05,1.52587890613158e-05,
	                   7.62939453110197e-06,3.81469726560650e-06,1.90734863281019e-06};

void Cordic(modulo x, modulo y, fase z, modulo * x_out, modulo * y_out, fase * z_out);
