clear;
data = zeros(1,60);
timeinfo = zeros(1, 4);
numMinutes = 1;     %Number of minutes of transmission, integer >=1
fc = 40;    %carrier frequency
samplesPerCycle = 32;
samplesPerSecond = fc*samplesPerCycle;
samplesPerMinute = samplesPerSecond*60;
sine_data = zeros(60,samplesPerSecond);
sine_table0 = zeros(1,samplesPerSecond);
sine_table1 = zeros(1,samplesPerSecond);
sine_table2 = zeros(1,samplesPerSecond);
x = 1:samplesPerSecond;     %Used for plotting

%Get Time Info from user
timeinfo(1) = input('Year? ');
timeinfo(2) = input('Day? ');
timeinfo(3) = input('Hour? ');
timeinfo(4) = input('Minute? ');

%Create sine tables for each possible bit transmission (0, 1, and 2)
for i = 1:samplesPerCycle*fc
    sine_table0(1,i) = sin(2*pi*i/samplesPerCycle) + 6*(i >= samplesPerSecond*0.2) * sin (2*pi*i/samplesPerCycle);
    sine_table1(1,i) = sin(2*pi*i/samplesPerCycle) + 6*(i >= samplesPerSecond*0.5) * sin (2*pi*i/samplesPerCycle);
    sine_table2(1,i) = sin(2*pi*i/samplesPerCycle) + 6*(i >= samplesPerSecond*0.8) * sin (2*pi*i/samplesPerCycle);
end

figure(1)
hold on

for k = 1:numMinutes
    %Build Data
    [data, timeinfo] = build_data(timeinfo);
    % [time_info] = find_time(data);
    
    %Generate a matrix that has the correct sine wave for each bit being
    %transmitted for the inputted data vector 
    for j = 1:60
        switch data(j)
            case 0
                sine_data(j,1:samplesPerSecond) = sine_table0;
            case 1
                sine_data(j,1:samplesPerSecond) = sine_table1;
            case 2
                sine_data(j,1:samplesPerSecond) = sine_table2;
        end
    end    
    
    %Plot the concatenated waveforms
    for l = 1:60
       plot( (x + ((l-1) * samplesPerSecond) + ((k-1) * samplesPerMinute))/samplesPerSecond,...
            sine_data(l,1:samplesPerSecond));
    end
    
    increment_time(timeinfo);
    
title('Waveform of time signal')
xlabel('Seconds')
end