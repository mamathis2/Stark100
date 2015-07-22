signal = sine_data(1,randi([0,samplesPerMinute],1):end);
[row, col] = size(signal);
t = 1:col;
figure(2)
plot(t/samplesPerSecond,signal)
title('Received time signal')
xlabel('Seconds')
