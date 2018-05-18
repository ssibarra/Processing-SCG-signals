function detectar_picos
signal=load('b001m.mat');
%x=signal(:,1);
%y=signal(:,2);
%plot(x,y, 'r-')
figure ();
plot (signal);
%hold on
%[peak_value, peak_location] = findpeaks(signal);
%plot (peak_location, peak_value, 'c')
%[peak_value, peak_location] = findpeaks(signal,'sortstr','ascend');
end