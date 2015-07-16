function [ sine_data ] = sine_table( data )
%sine_table Creates sine table based on the data being transmitted

fc = 40;    %carrier frequency
samplesPerCycle = 32;
samplesPerSecond = fc*samplesPerCycle;

sine_data = zeros(samplesPerSecond, 60);
sine_table0 = zeros(1,samplesPerSecond);
sine_table1 = zeros(1,samplesPerSecond);
sine_table2 = zeros(1,samplesPerSecond);
x = 1:samplesPerSecond;

%100 = 1 second
for i = 1:samplesPerCycle*fc
    %each sine_table has one wavelengths worth of samples
    sine_table0(i) = sin(2*pi*i/samplesPerCycle) + 6*(i >= samplesPerSecond*0.2) * sin (2*pi*i/samplesPerCycle);
    sine_table1(i) = sin(2*pi*i/samplesPerCycle) + 6*(i >= samplesPerSecond*0.5) * sin (2*pi*i/samplesPerCycle);
    sine_table2(i) = sin(2*pi*i/samplesPerCycle) + 6*(i >= samplesPerSecond*0.8) * sin (2*pi*i/samplesPerCycle);
end

figure(1)
plot(x,sine_table0);
figure(2)
plot(x,sine_table1);
figure(3)
plot(x,sine_table2);

for j = 1:60
    switch data(j)
        case 0
            sine_data(1:samplesPerSecond,j) = sine_table0;
        case 1
            sine_data(1:samplesPerSecond,j) = sine_table1;
        case 2
            sine_data(1:samplesPerSecond,j) = sine_table2;
    end
end    
end

