function Data=RebuildAudio(DataIn)
Data=DataAsignament
text_Caja={ 'Segundos grabación:','Frecuencia Muestreo'};
title_caja='Grabación';
num_lines = 1;
defaultans = {'5','44100'};
caja =inputdlg(text_Caja,title_caja,num_lines,defaultans);

T_record=str2num(caja{1});%duración
Fs1=str2num(caja{2});%frecuencia de muestreo

grabar1= audiorecorder(Fs1,8,1);
disp('grabando audio1');
recordblocking(grabar1,T_record);
Data_audio1 = getaudiodata(grabar1);
%sound(Data_audio1,Fs1)
%reproductor1 = audioplayer(Data_audio1,Fs1);
disp('reproduciendo audio1');
%play(reproductor1);

% while reproductor1.isplaying()
%     disp('reproduciendo')
% enda

Fs2=Fs1;
disp('grabando audio2');
grabar2= audiorecorder(Fs2,8,1);

recordblocking(grabar2,T_record);
Data_audio2 = getaudiodata(grabar2);
%sound(Data_audio2,Fs2)
%reproductor2 = audioplayer(Data_audio2,Fs2);
disp('reproduciendo audio2');
%play(reproductor2);
pause(0.5);

Data(:,1)=Data_audio1;
Data(:,2)=Data_audio2;
size(Data)
reproductor3 = audioplayer(Data,Fs2);
disp('reproduciendo audio3');
play(reproductor3);

end 