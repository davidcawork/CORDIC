%% Practica de CORDIC - MATLAB
function golden_dataset( len, filename)

    %Abrimos el fichero 
    fid = fopen(filename,'w');
    
    
    for i = 1:1:len
        
        % El signo no puede caer en cero justo jaja
        signo = randi([-1,1],1,1);
        if signo == 0
            signo = 1;
        end
        
        x = signo*rand(1);
        signo = randi([-1,1],1,1);
        if signo == 0
            signo = 1;
        end
        
        y = signo*rand(1);
        z = 0;
        
        mod = sqrt(x^2+y^2);
        fase = atan(y/x);
        
        if(x < 0 && y > 0) 
         fase = fase + pi;
        end
        
        if(x < 0 && y < 0) 
         fase = fase - pi;
        end
        
        fprintf(fid,'%.16f\t%.16f\t%.16f\t%.16f\t%.16f\t%.16f\n',x,y,z, mod,0,fase);
    end
    
    %Cerramos el fichero
    fclose(fid);
    
    
end                                                
