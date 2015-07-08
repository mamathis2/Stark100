clear;
data = zeros(1,60);
timeinfo = zeros(1, 4);

%Get Time Info from user
timeinfo(1) = input('Year? ');
timeinfo(2) = input('Day? ');
timeinfo(3) = input('Hour? ');
timeinfo(4) = input('Minute? ');

%Build Data
build_data(data, timeinfo);
% [time_info] = find_time(data);

%increment_time(timeinfo);

%Sine Table



