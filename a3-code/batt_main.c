// batt_sim.c: DO NOT MODIFY
//
// Battery meter simulator main program and supporting functions. Read
// voltage sensor value and mode (volts or percent) from the command
// line and show the results of running functions from batt_update.c
// on the screen.

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "batt.h"

#define VOLTAGE_FLAG 0
#define PERCENT_FLAG 1

int main(int argc, char **argv){

  if(argc < 3){                 
    printf("usage: %s {voltage_val} {V | P}\n",argv[0]);
    printf("  arg1 voltage_val: integer, units of 0.001 volts \n");
    printf("  arg2 V or P: Voltage or Percent display\n");
    return 0;
  }
  BATT_VOLTAGE_PORT = atoi(argv[1]);
  printf("BATT_VOLTAGE_PORT set to: %u\n", BATT_VOLTAGE_PORT);

  // unsigned int batt_max = 1000 * 128;
  // if(BATT_VOLTAGE_PORT > batt_max){
  //   printf("Voltage value %u exceeds max %u\n",BATT_VOLTAGE_PORT,batt_max);
  //   return 1;
  // }

  if(argv[2][0]=='V' || argv[2][0]=='v'){
    BATT_STATUS_PORT |= VOLTAGE_FLAG;
  }
  else if(argv[2][0]=='P' || argv[2][0]=='p'){
    BATT_STATUS_PORT |= PERCENT_FLAG;
  }
  else{
    printf("Unknown display mode: '%s'\n",argv[2]);
    printf("Should be 'V' or 'P'\n");
    return 1;
  }

  batt_t batt = {.volts=-100, .percent=-1, .mode=-1};
  int result = set_batt_from_ports(&batt);
  printf("set_batt_from_ports(&batt );\n");

  printf("batt is {\n"); 
  printf("  .volts   = %d\n", batt.volts);
  printf("  .percent = %d\n", batt.percent);
  printf("  .mode    = %d\n", batt.mode);
  printf("}\n");

  // int quo = batt.volts / 1000;
  // int rem = batt.volts % 1000;
  // printf("Simulated volts is: %d.%d V\n",quo,rem);

  if(result != 0){
    printf("set_batt_from_ports() returned non-zero: %d\n",result);
    return 1;
  }

  printf("\nChecking results for display bits\n");
  
  int display = 0;
  result = set_display_from_batt(batt, &display);
  printf("set_display_from_batt(batt, &display);\n");

  printf("\ndisplay is:\n");
  printf("        3         2         1         0\n");
  printf("index: 10987654321098765432109876543210\n");
  printf("bits:  "); showbits(display); printf("\n");
  printf("guide:  |    |    |    |    |    |    |\n");
  printf("index:  30        20        10        0\n");

  if(result != 0){
    printf("set_display_from_batt() returned non-zero: %d\n",result);
    return 1;
  }

  printf("\nRunning batt_update()\n");

  batt_update();

  printf("\nBATT_DISPLAY_PORT is:\n");
  printf("index:  3         2         1    0    0\n");
  printf("index: 10987654321098765432109876543210\n");
  printf("bits:  "); showbits(BATT_DISPLAY_PORT); printf("\n");
  printf("guide:  |    |    |    |    |    |    |\n");
  printf("index:  30        20        10        0\n");


  printf("\nBattery Meter Display:\n");
  print_batt_display();

  return 0;
}
