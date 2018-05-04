function detectar_picos
signal=load('datos.csv', '-ascii');
x=signal(:,1);
y=signal(:,2);
plot(x,y, 'r-')
hold on
[peak_value, peak_location] = findpeaks(signal);
plot (peak_location, peak_value, 'c')
[peak_value, peak_location] = findpeaks(signal,'sortstr','ascend');

end