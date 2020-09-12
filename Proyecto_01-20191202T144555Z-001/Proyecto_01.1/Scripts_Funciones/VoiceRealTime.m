function  [Data_audio,Fs] =RecordFile(answer_Modo)
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
defaultans = {'5','44100'};
caja =inputdlg(text_Caja,title_caja,num_lines,defaultans);
T_record=str2num(caja{1});%duración
Fs=str2num(caja{2});%frecuencia de muestreo
recorder = audiorecorder(Fs, 24, Modo);
disp('Start speaking.')
recorder.record();
while recorder.isrecording()
    pause(0.1);
    Data_audio=recorder.getaudiodata();
    plot(recorder.getaudiodata());
    drawnow();
end
disp('End of Recording.');end
