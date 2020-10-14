#include <string.h>
#include <math.h>
#include <stdio.h>
#include <limits.h>
#include <stdlib.h>
#include "batt.h"

int set_batt_from_ports(batt_t *batt){
    int prct;
    if (BATT_VOLTAGE_PORT < 0){
        printf("Sensor error\n");
        return 1;
    }
    batt->volts = BATT_VOLTAGE_PORT;
    if(BATT_VOLTAGE_PORT >= 3800){
        batt->percent = 100;
        batt->mode = BATT_STATUS_PORT;
        return 0;
    }
    prct = BATT_VOLTAGE_PORT - 3000;
    int div = 8;
    int bp = 0;
    while(prct >= div){
        prct = prct - 8;
        bp++;
    }
    batt->percent = bp;
    batt->mode = BATT_STATUS_PORT;
    return 0;
}

int set_display_from_batt(batt_t batt, int *display){
    if(batt.mode != 0 || batt.mode != 1){
        printf("Error in battery\n");
        return 1;
    }
    int mask[10] = {0b0111111, 0b0000110, 0b1011011, 0b1001111,
                    0b1100110, 0b1101101, 0b1111101, 0b0000111,
                    0b1111111, 0b1101111};
    int prcnt = 0b10;
    int vlt = 0b01;
    int lvl[5] = {0b00000, 0b10000, 0b11000, 0b11100, 0b11110, 0b11111};
    int blank = 0b0000000;
    int state = 0;
    int i = 0;
    int temp = batt.percent;
    while(temp>5){
        state = state|lvl[i]<<24;
        temp = temp - 20;
        i++;
    }
    int temp_hndr = mask[(batt.volts / 10) % 10];
    int temp_tnths = mask[(batt.volts / 100) % 10];
    int temp_ones = mask[(batt.volts / 1000) % 10];
    int prcnt_hndr = mask[(batt.percent / 100) % 10];
    int prcnt_ten = mask[(batt.percent / 10) % 10];
    int prct_one = mask[batt.percent % 10];

    if(batt.mode){
        state = state|prcnt<<22;
        
    }

}