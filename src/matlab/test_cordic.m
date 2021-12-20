close all
clear all
clc

%% Pruebas
num_min_bit = 2;
num_max_bit = 25;
num_iter_min = 2; 
i = 25; 


%Cargar dataset
datos = load("golden_data.dat");

for num_bit = num_min_bit:num_max_bit
    for k = num_iter_min:1:i  
        
        
        %CORDIC
        [x,y,z] = cordic_float(datos(:,1),datos(:,2),datos(:,3),k);
        [x_fp, y_fp, z_fp] = cordic_fixed(datos(:,1),datos(:,2),datos(:,3),k,num_bit);
        

        Error_p = (abs(z_fp - z)./abs(z))*100;
        Error_i = (abs(z_fp - z)./abs(z));
        
        E_cuadratico(k+1-num_iter_min,num_bit) = sqrt(sum((Error_i.double).^2)/size(Error_p,2))*100;
        E_Max(k+1-num_iter_min,num_bit) = abs(max(Error_p(num_bit)));
        Error_p_x = (abs(x_fp - x)./abs(x))*100;
        
        Error_i_x = (abs(x_fp - x)./abs(x));
        E_cuadratico_x(k+1-num_iter_min,num_bit) = sqrt(sum((Error_i_x.double).^2)/size(Error_p_x,2))*100;
        E_Max_x(k+1-num_iter_min,num_bit) = abs(max(Error_p_x(num_bit)));
    end
end


%% PLOT

for j = num_iter_min:1:i
   nombre(j+1-num_iter_min,:) = sprintf('%s',strcat('n=',int2str(j)));
end

figure();
for iter =  num_iter_min:1:K 
    subplot(2,1,2);
    hold on
    xlim([num_min_bit num_max_bit])
    plot(E_cuadratico(iter+1-num_iter_min, :),'-','linewidth',1)
    xlabel("Num bits")
    grid on;
    hold off
    title('Error cuadratico medio - Zn');
    subplot(2,1,1);
    hold on
    xlim([num_min_bit num_max_bit])
    plot(E_cuadratico_x(iter+1-num_iter_min,:),'-','linewidth',1)
    xlabel("Num bits")
    grid on;
    hold off
    title('Error cuadratico medio - Xn');
end
subplot(2,1,1);
legend(nombre, 'location','northeast');
subplot(2,1,2);
legend(nombre, 'location','northeast');

figure();
for iter =  num_iter_min:1:K 
    subplot(2,1,2);
    hold on
    xlim([num_min_bit num_max_bit])
    plot(E_Max(iter+1-num_iter_min, :),'-','linewidth',1)
    xlabel("Num bits")
    hold off
    grid on;
    title('Error Maximo - Zn');
    subplot(2,1,1);
    hold on
    xlim([num_min_bit num_max_bit])
    plot(E_Max_x(iter+1-num_iter_min,:),'-','linewidth',1)
    xlabel("Num bits")
    hold off
    grid on;
    title('Error máximo - Xn');
end
subplot(2,1,1);
legend(nombre, 'location','northeast');
subplot(2,1,2);
legend(nombre, 'location','northeast');


figure();
subplot(2,1,2);
hold on
xlim([num_min_bit num_max_bit])
plot(E_cuadratico(20, :),'-','linewidth',1)
xlabel("Num bits")
grid on;
hold off
title('Error cuadratico medio - Zn');
subplot(2,1,1);
hold on
xlim([num_min_bit num_max_bit])
plot(E_cuadratico_x(20,:),'-','linewidth',1)
xlabel("Num bits")
grid on;
hold off
title('Error cuadratico medio - Xn');

figure();
subplot(2,1,2);
hold on
xlim([num_min_bit num_max_bit])
plot(E_Max(19, :),'-','linewidth',1)
xlabel("Num bits")
grid on;
hold off
title('Error fase - Zn');
subplot(2,1,1);
hold on
xlim([num_min_bit num_max_bit])
plot(E_Max_x(19,:),'-','linewidth',1)
xlabel("Num bits")
grid on;
hold off
title('Error Maximo - Xn');
