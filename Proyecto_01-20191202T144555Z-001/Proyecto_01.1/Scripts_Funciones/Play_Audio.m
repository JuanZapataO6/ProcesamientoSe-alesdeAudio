function [Player,Data_1]= Play_Audio(Data,Signal)
    Data_1=DataAsignament;
    Data_1.Fs1=Data.Fs1;
    Data_1.Audio1=Data.Audio1;
    Data_1.Fs2=Data.Fs2;
    Data_1.Audio2=Data.Audio2
    switch Signal
        case 'Signal One'
            disp("Siganl One");
            Data_1.Fs=Data.Fs1;
            Data_1.Audio=Data.Audio1;
        case 'Signal Two'
            disp("Siganl Two");
            Data_1.Fs=Data.Fs2;
            Data_1.Audio=Data.Audio2;
    end
    Player = audioplayer(Data_1.Audio,Data.Fs);
    
end

            