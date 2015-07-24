%Code for Receiver of WWVB signal
%   Input is sine_data

fc = 40;    %carrier frequency
samplesPerCycle = 32;
samplesPerSecond = fc*samplesPerCycle;
samplesPerMinute = samplesPerSecond*60;
numSamples = samplesPerMinute*numMinutes;

%Cut off rand num of signals
signal = sine_data(1,randi([0, samplesPerMinute], 1):end);    
[row, col] = size(signal);
t = 1:col; %Get number of samples

%{
temp comment
figure(2)
plot(t/samplesPerSecond,signal)
title('Received time signal (cut off)')
xlabel('Seconds')
%}

%Input waveform is in the form of sin(2*pi*fc*t + phi)
%Multiply waveform by sin(2*pi*fc*t)*cos(2*pi*fc*t) 
signal = signal .* sin(2*pi*fc * t/samplesPerSecond).* cos(2*pi*fc * t/samplesPerSecond); 

%{
figure(3)
plot(t/samplesPerSecond,signal)
title('Received time signal (Multiplied by sin, cos)')
xlabel('Seconds')
%}

figure(4)
plot(t(1:samplesPerCycle), signal(1:samplesPerCycle));
title('Received time signal (Multiplied by sin, cos)')
xlabel('Seconds')

%CONFUSING FOR ME -Derek

%Decode bit
%One bit = one second = 40*32 samples (fc*samplesPerCycle)
%   This may have changed because double frequency term
test_samps = 16;
test_avgs = zeros(1, numSamples-test_samps+1);
for i = test_samps:length(signal)
    sum_range = signal( i-test_samps+1: i );        %Gets 16 samples
    intermediate_sum = sum( sum_range );            %Sums 16 samples
    running_avg = intermediate_sum / test_samps;    %Avgs 16 samples
    test_avgs(i-test_samps+1) = running_avg;
end

%Figure 5 should be a digital signal, but it is not!!
testcol = size(test_avgs);
figure(5)
plot(1:5000, test_avgs(1:5000))
disp('done');