%% Procesamiento de señal SCG
%
% Algoritmo 2:
% En el presente algoritmo se presentan los avances realizados semana a
% semana, guiados por el profesor Juan Pablo Tello Portillo, en la implementació de un código que procese señales SCG. 
%
function filtro_cauer
clear all, close all, clc
load('b006m.mat');
figure(1)
subplot(2,1,1)
tam_val=length(val);
tam=tam_val/4;
plot(val)
xlim([0 tam])
title('Señal original')

%% Obtencin datos y espectro de potencia
inS=normalizar(val);
Fs=5000;
df=fft(inS, tam_val);
figure(2);
fr=(0:tam_val-1)*(Fs/tam_val);
subplot(221)
plot(fr,abs(df))
title('FFT')
xlim([0 30])

y=fftshift(df);
fshift=(-tam_val/2:tam_val/2-1)*(Fs/tam_val);
subplot(222)
plot(fshift,abs(y).^2/tam_val)
title('FFT shift')
xlim([15 30])

%% Pasabajas
Wp=30/2500;
Ws=70/2500;
[N,Wne]=ellipord(Wp,Ws,3,60);
[b,a]=ellip(N,3,60,Wne);
data=filter(b,a,inS);
figure(1)
subplot(2,1,2)
plot(data)
xlim([0 tam])
title('Señal con filtro pasabajas')

%% Potencia filtro 
df2=fft(data, tam_val);
figure(2);
fr=(0:tam_val-1)*(Fs/tam_val);
subplot(223)
plot(fr,abs(df2))
title('FFT filtro')
xlim([0 30])

y2=fftshift(df2);
fshift=(-tam_val/2:tam_val/2-1)*(Fs/tam_val);
subplot(224)
plot(fshift,abs(y2).^2/tam_val)
title('FFT shift filtro')
xlim([15 30])

%% PSNR y MSE
[peakSnr, snr] = psnr(data, inS);
fprintf ('\n El valor del PSNR es %0.4f', peakSnr);
fprintf ('\n El valor SNR es %0.4f', snr);

error = immse(data, inS);
fprintf ('\n El error MSE es %0.4f', error);

% Valores MSE y PSNR obtenidos al aplicar las formulas 
fprintf ('\n Valores sacados con las formulas: ')
ldata = length(data);
MSE = 0;

for n=1:ldata  
    MSE = MSE + (inS(1,n) - data(1,n))^2;
end

MSE = MSE/ldata;
maximum = max(abs(inS(:)));
Psnr = 10*log10(maximum^2/MSE);
fprintf ('\n El error MSE es %0.4f', MSE);
fprintf ('\n El valor del PSNR es %0.4f', Psnr);

end

%% Funciones
function sign=normalizar(val)
maximo=max(abs(val));
n=length(val);
sign=zeros(1,n);
for i=1:1:n
sign(i)=val(i)/maximo;
end
end