function [Data_audio,Fs] =Record_Audio(answer_Modo)

switch answer_Modo
    case 'Mono'
        disp([answer_Modo ' coming right up.'])
        Modo = 1;
    case 'Stereo'
        disp([answer_Modo ' coming right up.'])
        Modo = 2;
        
end
text_Caja={ 'Segundos grabación:','Frecuencia Muestreo'};
title_caja='Grabación';
num_lines = 1;
defaultans = {'15','50000'};
caja =inputdlg(text_Caja,title_caja,num_lines,defaultans);

T_record=str2num(caja{1});%duración
Fs1=str2num(caja{2});%frecuencia de muestreo

grabar1= audiorecorder(Fs1,8,1);
disp('grabando audio1');
recordblocking(grabar1,T_record);
Data_audio1 = getaudiodata(grabar1);
sound(Data_audio1,Fs1);
reproductor1 = audioplayer(Data_audio1,Fs1);
disp('reproduciendo audio1');
play(reproductor1);

data_l=length(Data_audio1);
up = transpose(linspace(0,5,data_l)); 
down=transpose(linspace(3,0,data_l));

multiply_up=dot(up,Data_audio1,2); 
multiply_down=dot(down,Data_audio1,2);


%sound(multiply_up,Fs1);
%repro_add = audioplayer(multiply_up,Fs1); %Ojo queda con la frecuencia del primero 
%disp('reproduciendo up');
%play(repro_add);


sound(multiply_down,Fs1);
repro_add = audioplayer(multiply_down,Fs1); %Ojo queda con la frecuencia del primero 
disp('reproduciendo down');
play(repro_add);

end