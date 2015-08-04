clear;
data = zeros(1,60);
timeinfo = zeros(1, 4);
numMinutes = 5;     %Number of minutes of transmission, integer >=1
fc = 40;    %carrier frequency
samplesPerCycle = 32;
samplesPerSecond = fc*samplesPerCycle;
samplesPerMinute = samplesPerSecond*60;
numSamples = samplesPerMinute*numMinutes;
sine_data = zeros(1,numSamples);
sine_table0 = zeros(1,samplesPerSecond);
sine_table1 = zeros(1,samplesPerSecond);
sine_table2 = zeros(1,samplesPerSecond);
%x = 1:numSamples;     %Used for plotting

%Get Time Info from user
timeinfo(1) = input('Year? ');
timeinfo(2) = input('Day? ');
timeinfo(3) = input('Hour? ');
timeinfo(4) = input('Minute? ');

%Create sine tables for each possible bit transmission (0, 1, and 2)
for i = 1:samplesPerSecond
    sine_table0(1,i) = sin(2*pi*i/samplesPerCycle) + 6*(i >= samplesPerSecond*0.2) * sin (2*pi*i/samplesPerCycle);
    sine_table1(1,i) = sin(2*pi*i/samplesPerCycle) + 6*(i >= samplesPerSecond*0.5) * sin (2*pi*i/samplesPerCycle);
    sine_table2(1,i) = sin(2*pi*i/samplesPerCycle) + 6*(i >= samplesPerSecond*0.8) * sin (2*pi*i/samplesPerCycle);
end

for k = 1:numMinutes
    %Build Data
    [data, timeinfo] = build_data(timeinfo);
    % [time_info] = find_time(data);
    
    %Generate a matrix that has the correct sine wave for each bit being
    %transmitted for the inputted data vector 
    for j = 1:60
        switch data(j)
            case 0
                sine_data(1,(k-1)*samplesPerMinute+(j-1)*samplesPerSecond+1:(k-1)*samplesPerMinute+j*samplesPerSecond) = sine_table0;
            case 1
                sine_data(1,(k-1)*samplesPerMinute+(j-1)*samplesPerSecond+1:(k-1)*samplesPerMinute+j*samplesPerSecond) = sine_table1;
            case 2
                sine_data(1,(k-1)*samplesPerMinute+(j-1)*samplesPerSecond+1:(k-1)*samplesPerMinute+j*samplesPerSecond) = sine_table2;
        end
    end
    timeinfo = increment_time(timeinfo);
end

%Save Memory (my cpu slow)
clear k;
clear j;
clear i;
clear sine_table0;
clear sine_table1;
clear sine_table2;


%Plot the transmitted signal   
figure(1)
plot( (1:numSamples)/samplesPerSecond,sine_data );
title( 'Waveform of time signal' )
xlabel( 'Seconds' )
