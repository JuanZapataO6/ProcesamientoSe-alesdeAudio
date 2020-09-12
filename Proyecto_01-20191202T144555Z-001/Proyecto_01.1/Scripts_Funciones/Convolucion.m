%-------------------------------------------------
%Function for evaluate the FIR with H_n 
%The vector H and Data.Audio statr on Zero
%-------------------------------------------------

function Data =FIR_Convolution(DataIn,H,Signal)
    
    Data=DataAsignament;
    Data.Audio1=DataIn.Audio1;
    Data.Fs1=DataIn.Fs1;    
    Data.Audio2=DataIn.Audio2;
    Data.Fs2=DataIn.Fs2;
    switch Signal
        case 'Signal One'
            disp("Siganl One");
            Data.Audio=DataIn.Audio1
            disp("Data");
            Data.Audio(5)
            %Data.Fs=DataIn.Fs1;
%             app.Fs1=app.Fs;
        case 'Signal Two'
            disp("Siganl Two");
            Data.Audio=DataIn.Audio2
            %Data.Fs=DataIn.Fs2;
    end
    x_lon=length(Data.Audio);
    h_lon=length(H);
    y_lon=x_lon+h_lon-1;
    Data_FIR=zeros(1,(y_lon+1));
    i=0;
    for  n=0:(y_lon-1)
        i=i+1;  
        temp=0; 
        for k= 0: (x_lon-1)
            %kx=k-nxi+1; %ajuste del indice de x(n) para evitar salir rango de Matlab
            ind= n-k
            if ind<0 || ind>(h_lon-1)
                h_temp=0;
            else 
                h_temp=H(ind+1);
            end
            ind_2=k+1;
            temp=temp+Data.Audio(ind_2)*h_temp;
            %end
        end
    Data_FIR(i)=temp;
    end 
    Data.Audio=Data_FIR
end