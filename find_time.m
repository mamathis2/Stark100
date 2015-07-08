function [ timeInfo ] = find_time( data )
%find_time  It finds the time
%   Detailed explanation goes here

%Initialize timeInfo
timeInfo = zeros(1,4);

%Define hundreds, tens, and ones matrices
hundreds = [200 100];
tens = [80 40 20 10];
ones = [8 4 2 1];

%Determine year using the dot product
yearTens = dot(tens, data(46:49));
yearOnes = dot(ones, data(51,54));
year = yearTens + yearOnes;

%Determine day
dayHundreds = dot(hundreds, data(23,34));
dayTens = dot(tens, data(26:29));
dayOnes = dot(ones, data(31,34));
day = dayHundreds + dayTens + dayOnes;

%Determine hour
hourTens = dot(tens, data(11:14));
hourOnes = dot(ones, data(16,19));
hour = hourTens + hourOnes;

%Determine minute
minuteTens = [40 20 10] * data(2,4)';
minuteOnes = dot(ones, data(6,9));
minute = minuteTens + minuteOnes;

%Fill time info with values
timeInfo(1:4) = [year day hour minute];

end

