function [ sine_data ] = sine_table( data )
%sine_table Creates sine table based on the data being transmitted

fc = 40;    %carrier frequency
samplesPerCycle = 32;
samplesPerSecond = fc*samplesPerCycle;

%Initialize needed vectors
sine_data = zeros(60,samplesPerSecond);
sine_table0 = zeros(1,samplesPerSecond);
sine_table1 = zeros(1,samplesPerSecond);
sine_table2 = zeros(1,samplesPerSecond);

%Create sine tables for each possible bit transmission (0, 1, and 2) that
%is a second long in duration
for i = 1:samplesPerCycle*fc
    sine_table0(1,i) = sin(2*pi*i/samplesPerCycle) + 6*(i >= samplesPerSecond*0.2) * sin (2*pi*i/samplesPerCycle);
    sine_table1(1,i) = sin(2*pi*i/samplesPerCycle) + 6*(i >= samplesPerSecond*0.5) * sin (2*pi*i/samplesPerCycle);
    sine_table2(1,i) = sin(2*pi*i/samplesPerCycle) + 6*(i >= samplesPerSecond*0.8) * sin (2*pi*i/samplesPerCycle);
end

%Plot the bits 0, 1, and 2 on their carrier frequency
x = linspace(0, 1, samplesPerSecond);
figure(1)
plot(x,sine_table0);
figure(2)
plot(x,sine_table1);
figure(3)
plot(x,sine_table2);

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
end

