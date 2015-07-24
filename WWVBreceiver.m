%Code for Receiver of WWVB signal
%   Input is sine_data

fc = 40;    %carrier frequency
samplesPerCycle = 32;
samplesPerSecond = fc*samplesPerCycle;
samplesPerMinute = samplesPerSecond*60;
numSamples = samplesPerMinute*numMinutes;

%Cut off rand num of signals
%signal = sine_data(1,randi([0, samplesPerMinute], 1):end);
%Doesn't cut of any of the time signal -MARK
signal = sine_data(1,1:end);
[~, col] = size(signal);
t = 1:col; %Get number of samples


figure(2)
plot(t/samplesPerSecond,signal)
title('Received time signal (not cut off)')
xlabel('Seconds')


%Input waveform is in the form of sin(2*pi*fc*t + phi)
%Multiply waveform by sin(2*pi*fc*t) AND(instead of .*) cos(2*pi*fc*t)
%                                        ^ -MARK
signalCos = signal .* cos(2*pi*fc * t/samplesPerSecond);
signalSin = signal .* sin(2*pi*fc * t/samplesPerSecond);


figure(3)
plot(t/samplesPerSecond,signalCos)
title('Received time signal (Multiplied by cos)')
xlabel('Seconds')

%lol the title should be 'one cycle of the received time signal multiplied
%by sin'
%-MARK
figure(4)
plot(t(1:samplesPerCycle), signalSin(1:samplesPerCycle));
title('Received time signal (Multiplied by sin)') %
xlabel('Seconds')

%CONFUSING FOR ME -Derek

%Decode bit
%One bit = one second = 40*32 samples (fc*samplesPerCycle)
%   This may have changed because double frequency term
%   It did change because of the double frequency term. Nice :) -MARK
test_samps = 16;

%test_avgs length is only equal to this when the received time signal is
%not cut off -MARK
test_avgs = zeros(1, numSamples-test_samps+1);
for i = test_samps:length(signal)
    sum_range = signalSin( i-test_samps+1: i );        %Gets 16 samples
    intermediate_sum = sum( sum_range );            %Sums 16 samples
    running_avg = intermediate_sum / test_samps;    %Avgs 16 samples
    test_avgs(i-test_samps+1) = running_avg;
end

%Figure 5 should be a digital signal, but it is not!!
%Actually, it is!! I also multiplied by two to get the original digital
%signal :)
testcol = size(test_avgs);
figure(5)
plot((1:testcol(2))/samplesPerSecond, 2*test_avgs(1,1:end))
title('Original digital signal (not cut off)');
xlabel('Seconds');


%This is the code that generates the digital signal no matter what the
%phase is
signal = sine_data(1,randi([0, samplesPerMinute], 1):end);
[row, col] = size(signal);
t = 1:col; %Get number of samples


figure(6)
plot(t/samplesPerSecond,signal)
title('Received time signal (cut off)')
xlabel('Seconds')


%Input waveform is in the form of sin(2*pi*fc*t + phi)
%Multiply waveform by sin(2*pi*fc*t) and cos(2*pi*fc*t)

signalCos = signal .* cos(2*pi*fc * t/samplesPerSecond);
signalSin = signal .* sin(2*pi*fc * t/samplesPerSecond);

figure(7)
plot(t/samplesPerSecond,signalCos)
title('Received time signal (Cut off)(Multiplied by cos)')
xlabel('Seconds')

figure(8)
plot(t/samplesPerSecond, signalSin);
title('Received time signal (Cut off)(Multiplied by sin)')
xlabel('Seconds')


%Decode bit 
%One bit = one second = 40*32 samples (fc*samplesPerCycle)
%Decode the bit of the signalSin function
test_samps = 16;

%I changed numSamples to lenth(signalSin) because numSamples is for two
%minutes worth of samples, not the cut off version
test_avgs_sin = zeros(1, length(signalSin)-test_samps+1);
for i = test_samps:length(signalSin)
    sum_range = signalSin( i-test_samps+1: i );     %Gets 16 samples
    intermediate_sum = sum( sum_range );            %Sums 16 samples
    running_avg = intermediate_sum / test_samps;    %Avgs 16 samples
    test_avgs_sin(i-test_samps+1) = running_avg;
end
%Figure 9 is the average of the signalSin function
testcol = size(test_avgs_sin);
figure(9)
plot((1:testcol(2))/samplesPerSecond, test_avgs_sin(1,1:end))
title('Average of the received signal multiplied by sine')

%Decode the bit of the signalCos function
%Also changed numSamples to length(signalCos) again
test_avgs_cos = zeros(1, length(signalCos)-test_samps+1);
for i = test_samps:length(signalCos)
    sum_range = signalCos( i-test_samps+1: i );     %Gets 16 samples
    intermediate_sum = sum( sum_range );            %Sums 16 samples
    running_avg = intermediate_sum / test_samps;    %Avgs 16 samples
    test_avgs_cos(i-test_samps+1) = running_avg;
end
%Figure 10 is the average of the signalCos function
testcol = size(test_avgs_cos);
figure(10)
plot((1:testcol(2))/samplesPerSecond, test_avgs_cos(1,1:end))
title('Average of the received signal multiplied by cosine')

%The digital signal is 2 times the magnitude of the average sine and cosine
%funtions
finalSignal = 2*sqrt(test_avgs_sin.^2 + test_avgs_cos.^2);
figure(11)
plot((1:testcol(2))/samplesPerSecond, finalSignal)
title('Original digital signal (cut off)');
xlabel('Seconds');
disp('done');
