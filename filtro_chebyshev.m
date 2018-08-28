function filtro_chebyshev
clear all, close all, clc
load('b020m.mat');
figure(3)
subplot(3,1,1)
tam_val=length(val);
tam=tam_val/4;
%plot(val)
xlim([0 tam])
title('Señal original')

%% Obtencin datos
inS=normalizar(val);
Fs=1/tam_val;
nfft=1024;
df=fft(inS, nfft);
df=df(1:nfft/2);
mdf=abs(df).^2;
f=(0:nfft/2-1)*Fs/nfft;
figure(4);
%plot(f,mdf);
title('Espectro de potencia');
xlabel('Frecuencia (Hz)');
ylabel('Potencia');

%% Filtro pasa altas con Cheby1
figure(1)
[c,d]=cheby1(9,0.5,0.6);
freqz(c,d);
dataOut=filter(c,d,inS);
figure(3)
subplot(3,1,2)
%plot(dataOut)
xlim([0 tam])
title('Seal confiltro pasaaltas')

%% Pasabajas
figure(2)
[b,a]=cheby1(6,10,0.6);
freqz(b,a);
data=filter(b,a,dataOut);
figure(3)
subplot(3,1,3)
%plot(data)
xlim([0 tam])
title('Seal con filtro pasaaltas y luego pasabajas')

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