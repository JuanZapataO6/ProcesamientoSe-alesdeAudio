
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
defaultans = {'3','3000'};
caja =inputdlg(text_Caja,title_caja,num_lines,defaultans);

T_record=str2num(caja{1});%duración
Fs1=str2num(caja{2});%frecuencia de muestreo

grabar1= audiorecorder(Fs1,8,answer_Modo);
disp('grabando audio1');
recordblocking(grabar1,T_record);
Data_audio1 = getaudiodata(grabar1);
sound(Data_audio1,Fs1);
reproductor1 = audioplayer(Data_audio1,Fs1);
disp('reproduciendo audio1');
play(reproductor1);

pause(0.5);
Fs2=1000;
grabar2= audiorecorder(Fs2,8,answer_Modo);
disp('grabando audio2');
recordblocking(grabar2,T_record);
Data_audio2 = getaudiodata(grabar2);
sound(Data_audio2,Fs2);
reproductor2 = audioplayer(Data_audio2,Fs2);
disp('reproduciendo audio2');
play(reproductor2);
pause(0.5);

            if Fs1 ~= Fs2
                T1=(1/Fs1);
                T2=(1/Fs2);                                                                          
                samples1=0:T1:((length(Data_audio1)-1)*T1);    
                samples1(end);
                disp('muestras audio 1');
                length(samples1)
                disp('longitud audio 1');
                length(Data_audio1)
                samples2=0:T2:((length(Data_audio2)-1)*T2);
                samples2(end);
                disp('muestras audio 2');
                length(samples2)
                disp('longitud audio 2');
                length(Data_audio2)
                
             if Fs1>Fs2
                audio_intp=interp1(samples2,Data_audio2,samples1);
                disp('audio interpolado');
                length(audio_intp)
                disp('sumando las dos señales');
                add_two=audio_intp+samples1;
                length(add_two)
                sound(add_two,Fs1);
                repro_add = audioplayer(add_two,Fs1);
                disp('reproduciendo suma');
                play(repro_add);
            else
                audio_intp=interp1(samples2,Data_audio2,Data_audio1, 'spline');
                disp('X_m');
                length(audio_intp)
                disp('t1'); 
                length(samples2)
            end
            end

end

