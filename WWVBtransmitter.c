#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>


int numMinutes = 1;
int data[60];
int timeinfo[4];
int fc = 40;
int samplesPerCycle = 32;
int samplesPerSecond = fc * samplesPerCycle;
int samplesPerMinute = samplesPerSecond * 60;
int numSamples = samplesPerMinute*numMinutes;
int year, day, hour, minute;
int i, j, k;
float pi = 3.141592654;

void build_data(int *data, int *timeinfo) {
	int year = timeinfo[0];
	int day = timeinfo[1];
	int hour = timeinfo[2];
	int minute = timeinfo[3];

	//Markers
	data[0] = 2;
	for(int i = 9; i <= 59; i += 10) {
		data[i] = 2;
	}

	//Always zero
	data[10] = 0;
	data[11] = 0;
	data[20] = 0;
	data[21] = 0;
	data[55] = 0;
	data[56] = 0;
	data[57] = 0;
	data[58] = 0;
	for(int i = 4; i <= 54; i += 10) {
		data[i] = 0;
	}
	for(int i = 35; i <= 43; i += 1) {
		if (i != 39) {
			data[i] = 0;
		} 
	}

	//Determine the bits for the minute tens digit
	data[1] = minute >= 40;
	data[2] = (minute % 40) >= 20;
	data[3] = (minute % 20) >= 10;

	//Determine the bits of the minute ones digit
	int minuteOnes = minute % 10;
	data[5] = minuteOnes >= 8;
	data[6] = (minuteOnes % 8) >= 4;
	data[7] = (minuteOnes % 4) >= 2;
	data[8] = (minuteOnes % 2) >= 1;
	
	//Determine the bits for the hour tens digit
	data[12] = hour >= 20;
	data[13] = (hour % 20) >= 10;
	
	//Determine the bits for the hour ones digit
	int hourOnes = hour % 10;
	data[15] = hourOnes >= 8;
	data[16] = (hourOnes % 8) >= 4;
	data[17] = (hourOnes % 4) >= 2;
	data[18] = (hourOnes % 2) >= 1;
	
	//Determine the day hundreds digit
	data[22] = day >= 200;
	data[23] = (day % 200) >= 100;
	
	//Determine the day tens digit
	int dayTens = day % 100;
	data[25] = dayTens >= 80;
	data[26] = (dayTens % 80) >= 40;
	data[27] = (dayTens % 40) >= 20;
	data[28] = (dayTens % 20) >= 10;
	
	//Determine the day ones digit
	int dayOnes = day % 10;
	data[30] = dayOnes >= 8;
	data[31] = (dayOnes % 8) >= 4;
	data[32] = (dayOnes % 4) >= 2;
	data[33] = (dayOnes % 2) >= 1;
	
	//Determine the year tens digit
	int yearTens = year % 100;
	data[45] = yearTens >= 80;
	data[46] = (yearTens % 80) >= 40;
	data[47] = (yearTens % 40) >= 20;
	data[48] = (yearTens % 20) >= 10;
	
	//Determine the year ones digit
	int yearOnes = yearTens % 10;
	data[50] = yearOnes >= 8;
	data[51] = (yearOnes % 8) >= 4;
	data[52] = (yearOnes % 4) >= 2;
	data[53] = (yearOnes % 2) >= 1;
	
	//Display data
	for(int i = 0; i < 60; i = i+10) {
		printf("%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\n", data[i], data[i+1], data[i+2], data[i+3], data[i+4], data[i+5], data[i+6], data[i+7], data[i+8], data[i+9]);
	}
	
}
void increment_time(int *timeinfo);
int main () {

    printf("Enter the year: ");
    scanf("%d", &year);
    printf("You entered %d \n", year);
    timeinfo[0] = year;

    printf("Enter the day: ");
    scanf("%d", &day);
    printf("You entered %d \n", day);
    timeinfo[1] = day;

    printf("Enter the hour: ");
    scanf("%d", &hour);
    printf("You entered %d \n", hour);
    timeinfo[2] = hour;

    printf("Enter the minute: ");
    scanf("%d", &minute);
    printf("You entered %d \n", minute);
    timeinfo[3] = minute;

    for (k = 0; k < numMinutes; k += 1) {
        build_data(data, timeinfo);
    }
    
}

void increment_time(int *timeinfo) {
    timeinfo[4] = (timeinfo[4] + 1) % 60;   //Minutes
    timeinfo[3] = (timeinfo[3] + (timeinfo[4] == 0)) % 24;  //Hours
    timeinfo[2] = (timeinfo[2] + ((timeinfo[3] == 0) && (timeinfo[4] == 0)) ) % 365;//Days
    timeinfo[1] = (timeinfo[1] + ((timeinfo[2] == 0) && (timeinfo[3] == 0) && (timeinfo[4] == 0)) ) % 100; //Years
}




/*
sine_data = zeros(1,numSamples);
sine_table0 = zeros(1,samplesPerSecond);
sine_table1 = zeros(1,samplesPerSecond);
sine_table2 = zeros(1,samplesPerSecond);
%x = 1:numSamples;     %Used for plotting

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

%Plot the transmitted signal   
figure(1)
plot( (1:numSamples)/samplesPerSecond,sine_data );
title( 'Waveform of time signal' )
xlabel( 'Seconds' )
*/
