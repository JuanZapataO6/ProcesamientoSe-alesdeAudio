
function Data_audio =VerifyFrequency(Data)
    Data_audio=DataAsignament;
    Data_audio.Audio=Data.Audio;
    Data_audio.Fs=Data.Fs;
    Data_audio.Audio1=Data.Audio1;
    Data_audio.Fs1=Data.Fs1;
    Data_audio.Audio2=Data.Audio2;
    Data_audio.Fs2=Data.Fs2;
    
    
    if Data.Fs1==Data.Fs2  % Sin de igual frecuencia
        
        T1=(1/Data.Fs1); %periodo señal 1
        T2=(1/Data.Fs2); %periodo señal 2
        
        samples1=0:T1:((length(Data.Audio1)-1)*T1);  %muestras señal 1
        samples1(end);
        t_samples1=transpose(samples1); %transponemos el vector
        disp('muestras audio 1');
        length(t_samples1);
        size(t_samples1);
        
        
        samples2=0:T2:((length(Data.Audio2)-1)*T2); %muestras señal 2
        samples2(end);
        t_samples2=transpose(samples2); %transponemos el vector
        disp('muestras audio 2');
        length(t_samples2);
        size(t_samples2);
        
        if t_samples1>t_samples2
            salvadora=zeros(length(Data.Audio1));
            Data_audio.Audio1=interp1(t_samples2,Data.Audio2,salvadora);
            
        end
        

    end
    
    if Data.Fs1 ~= Data.Fs2  %si las frecuencias son diferentes
        
        
        
        T1=(1/Data.Fs1); %periodo señal 1
        T2=(1/Data.Fs2); %periodo señal 2
        
        samples1=0:T1:((length(Data.Audio1)-1)*T1);  %muestras señal 1
        samples1(end);
        t_samples1=transpose(samples1); %transponemos el vector
        disp('muestras audio 1');
        length(t_samples1);
        size(t_samples1);
        
        
        samples2=0:T2:((length(Data.Audio2)-1)*T2); %muestras señal 2
        samples2(end);
        t_samples2=transpose(samples2); %transponemos el vector
        disp('muestras audio 2');
        length(t_samples2);
        size(t_samples2);
        
        
        
        if Data.Fs1>Data.Fs2 % Si la frecuencia 1 es mayor a la frecuencia 2
            
            Data_audio.Audio2=interp1(t_samples2,Data.Audio2,t_samples1); %Interpolacion de audio 2
            %despliego el valor
            disp('audio interpolado_1');
            size(Data_audio.Audio);
            
            %Sumo el audio 1 con la interpolacion
%             disp('sumando las dos señales');
%             add_two=audio_intp+Data_audio1;
%             disp('tamaño audio suma');
%             size(add_two)
%             
%             %multiplico el audio 1 con la interpolacion
%             disp('multiplicando las dos señales');
%             multiply_two=dot(audio_intp,Data_audio1,2);
%             size(multiply_two)
%             

            
        else % Si la frecuencia 2 es mayor a la frecuencia 1
              Data_audio.Audio1=interp1(t_samples1,Data.Audio1,t_samples2); %Interpolacion de audio 1 
              
              %despliego el valor
              disp('audio interpolado_2');
              length(Data_audio.Audio);
              size(Data_audio.Audio);
            
%             %sumo el audio 2 con la interpolacion
%             disp('sumando las dos señales');
%             add_two=audio_intp+Data_audio2;
%             size(add_two)
%             
%             %multiplico el audio 2 con la interpolacion
%             disp('multiplicando las dos señales');
%             multiply_two=dot(audio_intp,Data_audio1,2);
%             size(multiply_two)
%             
%             %funcion de reproduccion suma
%             sound(add_two,Fs2); %Ojo queda con la frecuencia del segundo
%             repro_add = audioplayer(add_two,Fs2);
%             disp('reproduciendo suma');
%             play(repro_add);
            
            
        end
    end
    
end

