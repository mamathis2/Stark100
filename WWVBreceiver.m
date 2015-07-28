%Code for Receiver of WWVB signal
%   Input is sine_data of a random starting point
%   Output is a digital signal

fc = 40;    %carrier frequency
samplesPerCycle = 32;
samplesPerSecond = fc*samplesPerCycle;
samplesPerMinute = samplesPerSecond*60;
numSamples = samplesPerMinute*numMinutes;

%Cut off rand num of signals
signal = sine_data(1,randi([0, samplesPerMinute], 1):end);
[~, col] = size(signal);
t = 1:col; %Get number of samples

figure(2)
plot(t/samplesPerSecond,signal)
title('Received time signal (cut off)')
xlabel('Seconds')

%Input waveform is in the form of sin(2*pi*fc*t + phi)
%Multiply waveform by sin(2*pi*fc*t) and cos(2*pi*fc*t)
signalCos = signal .* cos(2*pi*fc * t/samplesPerSecond);
signalSin = signal .* sin(2*pi*fc * t/samplesPerSecond);

%DECODE DATA
%One bit = one second = 40*16 samples (fc*samplesPerCycle/2) (double freq
%term)

newSamplesPerCycle = 16;

%Decode the signalSin function
avgs_sin = zeros(1, length(signalSin)-newSamplesPerCycle+1);
for i = newSamplesPerCycle:length(signalSin)
    %Averages last 16 samples from signal * sin and stores them in array
    avgs_sin(i-newSamplesPerCycle+1) = sum( signalSin(i-newSamplesPerCycle+1:i) ) / newSamplesPerCycle;   
end

%Decode the signalCos function
avgs_cos = zeros(1, length(signalCos)-newSamplesPerCycle+1);
for i = newSamplesPerCycle:length(signalCos)
    %Averages last 16 samples from signal * cos and stores them in array
    avgs_cos(i-newSamplesPerCycle+1) = sum( signalCos( i-newSamplesPerCycle+1: i ) ) / newSamplesPerCycle;    
end

%The digital signal is 2 times the magnitude of the average sine and cosine
%funtions
finalDigitalSignal = 2*sqrt(avgs_sin.^2 + avgs_cos.^2);

figure(3)
plot(t/samplesPerSecond, finalDigitalSignal)
title('Original digital signal (cut off)');
xlabel('Seconds');
