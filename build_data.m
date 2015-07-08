function [ data, timeinfo ] = build_data( data, timeinfo )
%Takes in year, day (0-364), hour (0-23), minute (0-59)
%   Returns a maxtix of 60 bits of time data

year = timeinfo(1);
day = timeinfo(2);
hour = timeinfo(3);
minute = timeinfo(4);

%Markers = 2
data(1) = 2;
data(10:10:60) = 2;

%They're zero
data(5:10:55) = 0;

%Determine the bits for the minute tens digit
data(2) = minute >= 40;
data(3) = mod(minute,40) >= 20;
data(4) = mod(minute,20) >= 10;

%Determine the bits for the minute ones digit
minuteOnes = mod(minute,10);
data(6) = minuteOnes >= 8;
data(7) = mod(minuteOnes,8) >= 4;
data(8) = mod(minuteOnes,4) >= 2;
data(9) = mod(minuteOnes,2) >= 1;

%They're zero
data(11:12) = 0;

%Determine the bits for the hour tens digit
data(13) = hour >= 20;
data(14) = mod(hour,20) >= 10;

%Determine the bits for the hour ones digit
hourOnes = mod(hour,10);
data(16) = hourOnes >= 8;
data(17) = mod(hourOnes,8) >= 4;
data(18) = mod(hourOnes,4) >= 2;
data(19) = mod(hourOnes,2) >= 1;

%They're always zero
data(21:22) = 0;

%Determine the day hundreds digit
data(23) = day >= 200;
data(24) = mod(day,200) >= 100;

%Determine the day tens digit
dayTens = mod(day,100);
data(26) = dayTens >= 80;
data(27) = mod(dayTens,80) >= 40;
data(28) = mod(dayTens,40) >= 20;
data(29) = mod(dayTens,20) >= 10;

%Determine the day ones digit
dayOnes = mod(day,10);
data(31) = dayOnes >= 8;
data(32) = mod(dayOnes,8) >= 4;
data(33) = mod(dayOnes,4) >= 2;
data(34) = mod(dayOnes,2) >= 1;

%They're always zero
data(36:39) = 0;
data(41:44) = 0;

%Determine the year tens digit
yearTens = mod(year,100);
data(46) = yearTens >= 80;
data(47) = mod(yearTens,80) >= 40;
data(48) = mod(yearTens,40) >= 20;
data(49) = mod(yearTens,20) >= 10;

%Determine the year ones digit
yearOnes = mod(yearTens,10);
data(51) = yearOnes >= 8;
data(52) = mod(yearOnes,8) >= 4;
data(53) = mod(yearOnes,4) >= 2;
data(54) = mod(yearOnes,2) >= 1;

%These are always zero
data(56:59) = 0;

%Display all of the bits
disp(data);

end

