function  [Data_Audio,Fs,path]  = Open_File()
[archivo,ruta]=uigetfile('*.*','Cargar Audio');
if archivo==0
    return;
else
    path=strcat(ruta,archivo);
    [Data_Audio, Fs] = audioread(path);
    %reproductor = audioplayer(Data_Audio,Fs);
    %sound(Data_Audio,Fs);
end

end 