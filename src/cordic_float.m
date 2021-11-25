%% Practica de CORDIC - MATLAB - Como flotante
clc
clear variables
close all

% En mi caso tengo que trabajar con el modo de vectorizacion del algoritmo

%% Vars globales

n_iteraciones = 40;
angulos_totales = atan(2.^-(0:n_iteraciones-1));
a_zero = 10^-6;

% Sistema de coordenadas circulares
m = 1;


% Mi vector de entrada [x,y,z]
v_ini = [2, 3, 30*pi/180];


%%  CORDIC  %%

% Vectores aux
v_i = v_ini;
v_i_1 = zeros(1,3);

%% Pre-procesado

% Segundo y tercer cuadrante

for i=0:1:n_iteraciones - 1
    
    % Sigma
    sigma = -sign(v_i(2));
    
    % Microrotacion
    v_i_1(1) = v_i(1) -m * sigma * 2^(-i) * v_i(2);
    v_i_1(2) = v_i(2) +sigma * 2^(-i) * v_i(1);
    v_i_1(3) = v_i(3) -sigma * angulos_totales(1+i);
    
    % Actualizamos vectores
    v_i = v_i_1;
    
    if abs(v_i_1(2)) <= a_zero
        break
    end   
end

%% Post-procesado

% Segundo y tercer cuadrante

% Precalculamos la K
K = 1;
for j=0:1:i
    K = K * (sqrt(1+2^(-2*j)));
end

% Desescalamos
v_i_1 = [v_i(1)/K, v_i(2)/K, v_i(3)];


%% Mi vector de salida esperado
v_fin = [sqrt((v_ini(1)^2 + v_ini(2)^2)), 0 , v_ini(3) + atan(v_ini(2)/v_ini(1))];
  

