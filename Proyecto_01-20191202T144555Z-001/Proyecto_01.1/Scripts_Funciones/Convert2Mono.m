function Audio_Convert=Convert2Mono(Original)
Audio_Convert=DataAsignament; 
Audio_Convert.Audio=Original.Audio;
Audio_Convert.Fs=Original.Fs;
Audio_Convert.Audio1=Original.Audio1;
Audio_Convert.Fs1=Original.Fs1;
Audio_Convert.Audio2=Original.Audio2;
Audio_Convert.Fs2=Original.Fs2;
[m, n] = size(Original.Audio) %gives dimensions of array where n is the number of stereo channels
disp("Convert to Mono")
if n == 2
    Audio_Convert.Audio = Original.Audio(:, 1) + Original.Audio(:, 2); %sum(y, 2) also accomplishes this
    disp("Convert to Mono1")
    peakAmp = max(abs(Audio_Convert.Audio));
    disp("Convert to Mono2")
    Audio_Convert.Audio = Audio_Convert.Audio/peakAmp;
    %  check the L/R channels for orig. peak Amplitudes
    peakL = max(abs(Original.Audio(:, 1)));
    peakR = max(abs(Original.Audio(:, 2)));
    maxPeak = max([peakL peakR]);
    %apply x's original peak amplitude to the normalized mono mixdown
    Audio_Convert.Audio = Audio_Convert.Audio*maxPeak;    
else
    Audio_Convert.Audio = Original.Audio; %it is stereo so we will return it as is (e.g., for additional processing)
end


end