function filtro_butterworth
clear all, close all, clc
load('b002m.mat');
figure ();
subplot(3,1,1);
plot (val);
title ('Señal original');

%% Pasa Altas Butterworth
%fc = 0.1
%fs = 0.5
%W = fc/(Fs/2);
%[b,a]= butter(6,W, 'HIGH');
%hfvt= fvtool(b,a, 'Analysis','freq'); 
%nSignHP=filter(b,a,val);


%% Pasa Bajas Butterworth
fc = 100
fs = 90
W = fc/(Fs/2);
[b,a]= butter(6,W, 'low');
hfvt= fvtool(b,a, 'Analysis','freq'); 
nSignLP=filter(b,a,val);
subplot(3,1,3);
plot(nSignLP);
title('Señal con filtro pasa bajas Butterworth');

end