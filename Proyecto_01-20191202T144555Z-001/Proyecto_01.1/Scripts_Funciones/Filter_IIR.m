%-------------------------------------------------
%Function for evaluate the IIR with a_k b_k 
%The vectors a_k and b_k Data.Audio start on Zero
%-------------------------------------------------
function Data=Filter_IIR(DataIn,a,b,Signal)

    Data=DataAsignament;
    Data.Audio1=DataIn.Audio1;
    Data.Fs1=DataIn.Fs1;    
    Data.Audio2=DataIn.Audio2;
    Data.Fs2=DataIn.Fs2;
    
    switch Signal
        case 'Signal One'
            Data.Audio=DataIn.Audio1
            Data.Fs=DataIn.Fs1;
        case 'Signal Two'
            Data.Audio=DataIn.Audio2
            Data.Fs=DataIn.Fs2;
    end
    
x=Data.Audio;
a_k=a;
b_k=b;

Data_FR=zeros(1,(length(x)));
Data_IRR=zeros(1,(length(x)));
y_aux=zeros(1,(length(b_k)));
y_n_aux=zeros(1,(length(b_k)-1));
l_x=(length(x)-1);


for n=0:l_x  %% Respuesta forzada vector 
    
    for j=0:(length(b_k)-1)
            ind1= n-j;
            if ind1<0 
                x_n=0;
            else 
               x_n=x(ind1+1);
            end
        y_aux(j+1)=b_k(j+1)*x_n;
    end
    
y_f=sum(y_aux);
Data_FR(n+1)=y_f;


    for k=1 : (length(a_k)-1)  %% Respuesta natural 
            ind2= n-k;
            if ind2<0 
                y_nk=0;
            else 
                y_nk=Data_IRR(ind2+1);
            end
            
            y_n_aux(k)=a_k(k+1)*y_nk;
    end
y=Data_FR(n+1)-sum(y_n_aux);
Data_IRR(n+1)=y;

end
Data.Audio=(Data_IRR)';

end

