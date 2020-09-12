function Audio_Convert=Rebuild2Stereo(Original_Audio)
Audio_Convert=DataAsignament
Audio_Convert.Audio=Original_Audio.Audio;
Audio_Convert.Fs=Original_Audio.Fs;
Audio_Convert.Audio1=Original_Audio.Audio1;
Audio_Convert.Fs1=Original_Audio.Fs1;
Audio_Convert.Audio2=Original_Audio.Audio2;
Audio_Convert.Fs2=Original_Audio.Fs2;

estOriginal_Audio=size(Original_Audio.Audio); %encuentra tamaño de matriz Original_Audio
Original_Audiolo=estOriginal_Audio(1); %encuentra total de datos de Original_Audio
Original_Audioini=1; %tiempo de inicio para Original_Audio dado que matlab cuenta desde 1
%Original_Audiot=Original_Audioini:Original_Audioini+Original_Audiolo-1; %para tiempo de Original_Audio
Audio_Convert.Audio=zeros(Original_Audiolo,estOriginal_Audio(2)); %señal de salida con tamaño de vector de entrada
%char mander;%bandera de Prueba
if estOriginal_Audio(2) == 1 % si tiene solo una columna
    for i=Original_Audioini:Original_Audiolo
        Audio_Convert.Audio(i,1)=Original_Audio.Audio1(i);
    end
    for i=Original_Audioini:Original_Audiolo
        Audio_Convert.Audio(i,2)=Original_Audio.Audio2(i);
    end
    %mander='A'
else 
if estOriginal_Audio(2) == 2 % si tiene dos columnas 
      for i=Original_Audioini:Original_Audiolo
        Audio_Convert.Audio(i,1)=(Original_Audio.Audio(i,1)+Original_Audio.Audio(i,2));%sumar por que no se sabe en que columna esta el audio
      end
    for i=Original_Audioini:Original_Audiolo
        Audio_Convert.Audio(i,2)=(Original_Audio.Audio(i,1)+Original_Audio.Audio(i,2));
    end
    %mander='B'
else
    Audio_Convert = Original_Audio.Audio; %it is stereo so we will return it as is (e.g., for additional processing)
end
end