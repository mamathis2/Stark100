function [ bits ] = TimeToBits( year, day, hour, minute )
%Insert summary
%   
    
while(1)
    bits= zeros(1,60);
    bits(1) = 2;
    bits(5:10:55) = 0;
    bits(10:10:60) = 2;
    
    %Determine the bits for the minute tens digit
    bits(2) = minute >= 40;
    bits(3) = mod(minute,40 >= 20);
    bits(4) = mod(minute,20 >= 10);
    
    %Determine the bits for the minute ones digit
    minuteOnes = mod(minute,10);
    bits(6) = minuteOnes >= 8;
    bits(7) = mod(minuteOnes,8) >= 4;
    bits(8) = mod(minuteOnes,4) >= 2;
    bits(9) = mod(minuteOnes,2) >= 1;
    
    %They're zero
    bits(11:12) = 0;
    
    %Determine the bits for the hour tens digit
    bits(13) = hour >= 20;
    bits(14) = mod(hour,20) >= 10;
    
    %Determine the bits for the hour ones digit
    hourOnes = mod(hour,10);
    bits(16) = hourOnes >= 8;
    bits(17) = mod(hourOnes,8) >= 4;
    bits(18) = mod(hourOnes,4) >= 2;
    bits(19) = mod(hourOnes,2) >= 1;
    
    %They're always zero
    bits(21:22) = 0;
    
    %Determine the day hundreds digit
    bits(23) = day >= 200;
    bits(24) = mod(day,200) >= 100;
    
    %Determine the day tens digit
    dayTens = mod(day,100);
    bits(26) = dayTens >= 80;
    bits(27) = mod(dayTens,80) >= 40;
    bits(28) = mod(dayTens,40) >= 20;
    bits(29) = mod(dayTens,20) >= 10;
    
    %Determine the day ones digit
    dayOnes = mod(day,10);
    bits(31) = dayOnes >= 8;
    bits(32) = mod(dayOnes,8) >= 4;
    bits(33) = mod(dayOnes,4) >= 2;
    bits(34) = mod(dayOnes,2) >= 1;
    
    %They're always zero
    bits(36:39) = 0;
    bits(41:44) = 0;
    
    %Determine the year tens digit
    yearTens = mod(year,100);
    bits(46) = yearTens >= 80;
    bits(47) = mod(yearTens,80) >= 40;
    bits(48) = mod(yearTens,40) >= 20;
    bits(49) = mod(yearTens,20) >= 10;
    
    %Determine the year ones digit
    yearOnes = mod(yearTens,10);
    bits(51) = yearOnes >= 8;
    bits(52) = mod(yearOnes,8) >= 4;
    bits(53) = mod(yearOnes,4) >= 2;
    bits(54) = mod(yearOnes,2) >= 1;
    
    %These are always zero
    bits(56:59) = 0;
    
    %Display all of the bits
    disp(bits)
    
    %Wait 2 seconds
    pause(2)
    
    %Increment the minute and change the hour, day, and year as needed
    minute = mod(minute + 1,60);
    hour = mod(hour + (minute == 0), 24);
    day = mod(day + (hour == 0), 365);
    year = mod(year + (day == 0), 100);
    
end
end

