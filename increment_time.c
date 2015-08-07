void increment_time(int *timeinfo) {
	timeinfo[4] = (timeinfo[4] + 1) % 60;	//Minutes
	timeinfo[3] = (timeinfo[3] + (timeinfo[4] == 0)) % 24;	//Hours
	timeinfo[2] = (timeinfo[2] + ((timeinfo[3] == 0) && (timeinfo[4] == 0)) ) % 365;//Days
	timeinfo[1] = (timeinfo[1] + ((timeinfo[2] == 0) && (timeinfo[3] == 0) && (timeinfo[4] == 0)) ) % 100; //Years
}