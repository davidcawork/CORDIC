%% Practica de CORDIC - MATLAB - Coma fija

% En mi caso tengo que trabajar con el modo de vectorizacion del algoritmo

function [x_fin,y_fin,z_fin] = cordic_fixed(x, y, z, n_iteraciones, num_bit, redondeo)
   
    % Pre-procesado cuadrante
    if ( sign(x) < 0 )
        if ( sign(y) > 0 )
            x_cor = fi(y, 1, num_bit, num_bit - 2, 'RoundingMethod', redondeo);
            y_cor = fi((-1)*x, 1, num_bit, num_bit - 2, 'RoundingMethod', redondeo);
            z_cor = fi(z + pi/2, 1, num_bit, num_bit - 3, 'RoundingMethod', redondeo);
        else
            x_cor = fi((-1)*y, 1, num_bit, num_bit - 2, 'RoundingMethod', redondeo); 
            y_cor = fi(x, 1, num_bit, num_bit - 2, 'RoundingMethod', redondeo);
            z_cor = fi(z - pi/2, 1, num_bit, num_bit - 3, 'RoundingMethod', redondeo);
        end
    else
        x_cor = fi(x, 1, num_bit, num_bit - 2, 'RoundingMethod', redondeo); 
        y_cor = fi(y, 1, num_bit, num_bit - 2, 'RoundingMethod', redondeo);
        z_cor = fi(z, 1, num_bit, num_bit - 3, 'RoundingMethod', redondeo);
    end
    
    
    
    m = fi(1, 0, 1, 0); 
    K_m_t = 1;
    angulos_totales = fi(atan(2.^-(0:n_iteraciones-1)), 1, num_bit, num_bit - 3, 'RoundingMethod', redondeo);
    
    % Main loop :)
    for i = (0:n_iteraciones-1)

        sigma = fi((-1)*sign(y_cor), 1, 2, 0);
        fi(2^(-i), 1, num_bit, num_bit - 2, 'RoundingMethod', redondeo);

        x_fin = fi(x_cor - (m * sigma * fi(2^(-i), 1, num_bit, num_bit - 2, 'RoundingMethod', redondeo) * y_cor),1, num_bit, num_bit - 2, 'RoundingMethod', redondeo);
        y_fin = fi(y_cor + (sigma * fi(2^(-i), 1, num_bit, num_bit - 2, 'RoundingMethod', redondeo) * x_cor), 1, num_bit, num_bit - 2, 'RoundingMethod', redondeo);
        z_fin = fi(z_cor - (sigma * angulos_totales(i + 1)), 1, num_bit, num_bit - 3, 'RoundingMethod', redondeo);
        

        potencia=fi(2^(-2*i), 1, num_bit, num_bit - 2, 'RoundingMethod', redondeo); 
        
        K_m = fi(sqrt(1+(m* (sigma^2) *potencia)), 1, num_bit, num_bit - 2, 'RoundingMethod', redondeo);
        K_m_t = fi(K_m_t * K_m, 1, num_bit, num_bit - 2, 'RoundingMethod', redondeo);

        x_cor = x_fin; 
        y_cor = y_fin; 
        z_cor = z_fin;
        
    end
    
    % Ajustamos con el factor de compesación
    x_fin = fi((1/K_m_t) * x_fin,1, num_bit, num_bit - 2, 'RoundingMethod', redondeo);
    y_fin = fi((1/K_m_t) * y_fin,1, num_bit, num_bit - 2, 'RoundingMethod', redondeo);
    z_fin = z_fin;
    
end