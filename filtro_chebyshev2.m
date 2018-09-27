%% Procesamiento de señal SCG
%
% Algoritmo 2:
% En el presente algoritmo se presentan los avances realizados semana a
% semana, guiados por el profesor Juan Pablo Tello Portillo, en la implementació de un código que procese señales SCG. 
%
function filtro_chebyshev2
clear all, close all, clc
load('b002m.mat');
figure(3)
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
figure(4);
fr=(0:tam_val-1)*(Fs/tam_val);
plot(fr,abs(df))
title('FFT')
xlim([0 30])
%frec=1.4e-7;
figure(5);
y=fftshift(df);
fshift=(-tam_val/2:tam_val/2-1)*(Fs/tam_val);
plot(fshift,abs(y).^2/tam_val)
title('FFT shift')
xlim([15 30])

%% Filtro pasa altas con Cheby1
%%figure(1)
%%[c,d]=cheby1(9,0.5,0.6);
%%freqz(c,d);
%%dataOut=filter(c,d,inS);
%%figure(3)
%%subplot(3,1,2)
%%plot(dataOut)
%%xlim([0 tam])
%%title('Seal confiltro pasaaltas')

%% Pasabajas
Wp=30/2500;
Ws=70/2500;
[n,Wn]=buttord(Wp,Ws,3,60);
[b,a]=butter(n,Wn);
data=filter(b,a,inS);
figure(3)
subplot(2,1,2)
plot(data)
xlim([0 tam])
title('Señal con filtro pasabajas')

%% Potencia filtro 
df2=fft(data, tam_val);
figure(6);
fr=(0:tam_val-1)*(Fs/tam_val);
plot(fr,abs(df2))
title('FFT filtro')
xlim([0 30])
%frec=1.4e-7;
figure(7);
y2=fftshift(df2);
fshift=(-tam_val/2:tam_val/2-1)*(Fs/tam_val);
plot(fshift,abs(y2).^2/tam_val)
title('FFT shift filtro')
xlim([15 30])

%% PSNR y MSE
[peakSnr, snr] = psnr(data, inS);
fprintf ('\n El valor del pico SNR es %0.4f', peakSnr);
fprintf ('\n El valor SNR es %0.4f', snr);

error = immse(data, inS);
fprintf ('\n El error MSE es %0.4f', error);
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