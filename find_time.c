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
