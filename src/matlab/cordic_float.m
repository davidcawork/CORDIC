%% Practica de CORDIC - MATLAB - Coma flotante

% En mi caso tengo que trabajar con el modo de vectorizacion del algoritmo

function [x_fin,y_fin,z_fin] = cordic_float(x, y, z, n_iteraciones)

    % -- Vars aux --
    % Sistema de coordenadas circular 
    m = 1; 
    
    % Calculo previo de alpha
    angulos_totales = atan(2.^-(0:n_iteraciones-1));
    
    % Calculo previo de factor de compensación
    K = 1;
    for j=0:1:n_iteraciones
        K = K * (sqrt(1+2^(-2*j)));
    end
    
    % Pre-procesado cuadrante
    if ( sign(x) < 0 )
        if ( sign(y) > 0 )
            % 2o cuadrante
            x_cor = y; 
            y_cor = -1*x;
            z_cor = z + pi/2;
        else
            %3er cuadrante
            x_cor = -1*y; 
            y_cor = x;
            z_cor = z - pi/2;
        end    
    else
        x_cor = x; 
        y_cor = y;
        z_cor = z;
    end

    % Main loop
    for i = (0:n_iteraciones-1)
        sigma = ((-1)*sign(y_cor));
        x_fin = x_cor - (m * sigma * 2^(-i) * y_cor);
        y_fin = y_cor + (sigma * 2^(-i) * x_cor);
        z_fin = z_cor - (sigma * angulos_totales(i + 1));
        
        % Shift
        x_cor = x_fin; 
        y_cor = y_fin; 
        z_cor = z_fin;
        
    end
      
    %Ajustamos con el factor de compesación
    y_fin = y_fin/K;
    x_fin = x_fin/K;
    z_fin = z_fin;
end