function [ timeinfo ] = increment_time( timeinfo )
%Increments time by one minute, with wrapping

timeinfo(4) = mod(timeinfo(4) + 1,60);
timeinfo(3) = mod(timeinfo(3) + (timeinfo(4) == 0), 24);
timeinfo(2) = mod(timeinfo(2) + (timeinfo(3)== 0), 365);
timeinfo(1) = mod(timeinfo(1)+ (timeinfo(2)== 0), 100);

end
