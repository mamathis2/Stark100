//Code for Receiver of WWVB signal
//   Input is sine_data of a random starting point
//   Output is a digital signal
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

const int fc = 40;    //carrier frequency
const int samplesPerCycle = 32;
const int samplesPerSecond = fc*samplesPerCycle;
const int samplesPerMinute = samplesPerSecond*60;
const int numMinutes = 1;
const int numSamples = samplesPerMinute*numMinutes;


void find_time(int *data, int *timeinfo) {
	//Given the received data, this finds the year, day, hour and minute
	
	//Determine the year
	int yearTens = 80*data[45] + 40*data[46] + 20*data[47] + 10*data[48];
	int yearOnes = 8*data[50] + 4*data[51] + 2*data[52] + data[53];
	int year = yearTens + yearOnes;
	
	//Determine the day
	int dayHundreds = 200*data[22] + 100*data[23];
	int dayTens = 80*data[25] + 40*data[26] + 20*data[27] + 10*data[28];
	int dayOnes = 8*data[30] + 4*data[31] + 2*data[32] + data[33];
	int day = dayHundreds + dayTens + dayOnes;
	
	//Determine the hour
	int hourTens = 80*data[10] + 40*data[11] + 20*data[12] + 10*data[13];
	int hourOnes = 8*data[15] + 4*data[16] + 2*data[17] + data[18];
	int hour = hourTens + hourOnes;
	
	//Determine the minute
	int minuteTens = 40*data[1] + 20*data[2] + 10*data[3];
	int minuteOnes = 8*data[5] + 4*data[6] + 2*data[7] + data[8];
	int minute = minuteTens + minuteOnes;
	
	timeinfo[0] = year;
	timeinfo[1] = day;
	timeinfo[2] = hour;
	timeinfo[3] = minute;
}	



int main(int argc, char *argv[]){
    //First argument is name of program
    //Second argument is file name with data (sine data)
    
    char* filename = argv[1];
    //TODO get data
    
    int16_t sine_data;
    double signalCos[sine_data.length];
    double signalSin[sine_data.length];
    
    for (int i = 0; i<sine_data.length()-1; i++){
        signalCos[i] = sine_data[i] * cos(2*pi*fc * t/samplesPerSecond);
    }
    for (int i = 0; i<sine_data.length()-1; i++){
        signalSin[i] = sine_data[i] * sin(2*pi*fc * t/samplesPerSecond);
    }
    
    double avgs_sin[signalSin.length-16];
    for (int i = 0; i<signalSin.length-16-1;i++){
        //Averages last 16 samples from signal * sin and stores them in array
        double sum = 0;
        for (int j = 0; j<16; j++){
            sum = sum + signalSin[i+j];
        }
        avgs_sin[i] = sum / 16.0;
    }
    
    double avgs_cos[signalCos.length-16];
    for (int i = 0; i<signalCos.length-16-1;i++){
        //Averages last 16 samples from signal * sin and stores them in array
        double sum = 0;
        for (int j = 0; j<16; j++){
            sum = sum + signalCos[i+j];
        }
        avgs_cos[i] = sum / 16.0;
    }
    
    double finalDigitalSignal[signalCos.length];
    for (int i = 0; i<signalCos.length;i++){
        finalDigitalSignal = 2.0*sqrt( (avgs_sin[i]*avgs_sin[i]) + (avgs_cos[i]*avgs_cos[i]) );
    }
    
    int data_received[60];
    for (int i = 0; i<numMinutes; i=i+fc*samplesPerCycle){
        
        double sum1 = 0;
        double sum2 = 0;
        double sum3 = 0;
        double sum4 = 0;
        
        for (int j1 = 0; j1<fc*samplesPerCycle*0.2; j1++){
            sum1 = sum1 + finalDigitalSignal[i+j1]/(fc*samplesPerCycle*0.2);
        }
        for (int j2 = fc*samplesPerCycle*0.2; j2<fc*samplesPerCycle*0.5; j2++){
            sum2 = sum2 + finalDigitalSignal[i+j2]/(fc*samplesPerCycle*(0.5-0.2));
        }
        for (int j3 = fc*samplesPerCycle*0.5; j3<fc*samplesPerCycle*0.8; j3++){
            sum3 = sum3 + finalDigitalSignal[i+j3]/(fc*samplesPerCycle*(0.8-0.5));
        }
        for (int j4 = fc*samplesPerCycle*0.8; j4<fc*samplesPerCycle*1.0; j4++){
            sum4 = sum4 + finalDigitalSignal[i+j4]/(fc*samplesPerCycle*(1.0-0.8));
        }
        
        if (sum2 > 3.5 && sum3 > 3.5 && sum4 > 3.5){
            data_received[ i/fc*samplesPerCycle ] = 0;
        }
        else if (sum3 > 3.5 && sum4 > 3.5){
            data_received[ i/fc*samplesPerCycle ] = 1;
        }
        else if (sum4 > 3.5){
            data_received[ i/fc*samplesPerCycle ] = 2;
        }
        else{
            //Error
            data_received[ i/fc*samplesPerCycle ] = -1;
        }
    }
    
    //Call find_time.m on each complete minute
    for( int i = 0; i < data_received.length; i = i + 60 ){
        int data_minute[60];
        int timeinfo[4];
        for (int j = 0; j<60; j++){
            data_minute[j] = data_received[i+j];
        }
        find_time(data_minute, timeinfo);
        printf("%d, %d, %d, %d", timeinfo[0], timeinfo[1], timeinfo[2], timeinfo[3]);
    }
    
}



