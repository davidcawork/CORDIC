%% Practica de CORDIC - MATLAB - Como flotante 

% Función para generar el golden data

function dataset = generateCORDIC_dataset_vec(n_len, n_iteraciones)
    
    % Vamos a generar el dataset
    vec_rng = zeros(n_len, 6);
    
    % Generamos los vectores aleatorios
    vec_rng(:,1:3) = rand(n_len, 3);
    
    % Precalculamos la K
    K = 1;
    for j=0:1:n_iteraciones
        K = K * (sqrt(1+2^(-2*j)));
    end
    
    % Precalculamos los valores esperados
    for i=1:n_len
        
        % x
        vec_rng(i,4) = K * sqrt(vec_rng(i,1).^2 + vec_rng(i,2).^2);
    
        % y 
        vec_rng(i,5) = 0;
    
        % z
        vec_rng(i,6) = vec_rng(i,3) + atan(vec_rng(i,2)/vec_rng(i,1));
        
    end
    
    % Hacemos el return 
    dataset = vec_rng;
end