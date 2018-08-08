function filtro_chebyshev
clear all, close all, clc
load('b001m.mat');
figure(3)
subplot(3,1,1)
plot(val)
title('Señal original')

%% Filtro pasa altas con Cheby1
figure(1)
[c,d]=cheby1(9,0.5,0.6);
freqz(c,d);
dataOut=filter(c,d,val);
figure(3)
subplot(3,1,2)
plot(dataOut)
title('Señal confiltro pasaaltas')
%% Pasabajas
figure(2)
[b,a]=cheby1(6,10,0.6);
freqz(b,a);
data=filter(b,a,val);
figure(3)
subplot(3,1,3)
plot(data)
title('Señal con filtro pasabajas')
end