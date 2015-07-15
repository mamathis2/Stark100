function [ sine_data ] = sine_table( data )
%sine_table Creates sine table based on the data being transmitted
%   Detailed explanation goes here
sine_data = zeros(100, 60);
sine_table0 = zeros(1,100);
sine_table1 = zeros(1,100);
sine_table2 = zeros(1,100);
%x = [1:100];
for i = 1:100
    sine_table0(i) = sin(3*pi*i/5) + 6*(i >= 20) * sin (3*pi*i/5);
    sine_table1(i) = sin(3*pi*i/5) + 6*(i >= 50) * sin (3*pi*i/5);
    sine_table2(i) = sin(3*pi*i/5) + 6*(i >= 80) * sin (3*pi*i/5);
end
%figure(1)
%plot(x,sine_table0);
%figure(2)
%plot(x,sine_table1);
%figure(3)
%plot(x,sine_table2);
for j = 1:60
    switch data(j)
        case 0
            sine_data(1:100,j) = sine_table0;
        case 1
            sine_data(1:100,j) = sine_table1;
        case 2
            sine_data(1:100,j) = sine_table2;
    end
end
    
        
                
    
end

