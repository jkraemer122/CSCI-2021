#include <string.h>
#include <math.h>
#include <stdio.h>
#include <limits.h>
#include <stdlib.h>
#include "batt.h"

// Struct to hold test information
typedef struct {
  char    *id;
  char    *desc;
  short   initial_voltage_port;
  char    initial_status_port;
  int     initial_display_port;
  int     expect_ret;
  batt_t  expect_batt;
  int     expect_display;
} batt_test_case;

int passed = 0;
int testn = 0;

#define TOLERANCE 1e-4

batt_t *malloced_batt = NULL;
int *malloced_display = NULL;

int compare_batt_t(batt_t x, batt_t y){
  return
    x.volts    == y.volts   &&
    x.percent  == y.percent &&
    x.mode     == y.mode    &&
    1;
}

void print_batt(batt_t batt){
  printf("{\n"); 
  printf("  .volts    = %d,\n",batt.volts);
  printf("  .percent  = %d,\n",batt.percent);
  printf("  .mode     = %d,\n",batt.mode);
  printf("}\n");
}

void print_test_description(char *function, char *id){
  printf("TEST %2d: %-30s %-16s : ",testn,function,id);
}

void test_set_batt_from_ports(batt_test_case test){
  testn++;
  print_test_description("set_batt_from_ports()",test.id);
  
  BATT_VOLTAGE_PORT  = test.initial_voltage_port;
  BATT_STATUS_PORT   = test.initial_status_port;
  BATT_DISPLAY_PORT  = test.initial_display_port;

  batt_t actual = {.volts = 0, .percent = -1, .mode = -1};
  *malloced_batt = actual;
  int actual_ret = set_batt_from_ports(malloced_batt);
  actual = *malloced_batt;

  if(   BATT_VOLTAGE_PORT  != test.initial_voltage_port
     || BATT_STATUS_PORT   != test.initial_status_port
     || BATT_DISPLAY_PORT  != test.initial_display_port)
  {
    printf("FAILED\n");
    printf("----------------------------------------------------------------\n");
    printf("Do not modify global variables, BATT_VOLTAGE_PORT, BATT_STATUS_PORT, BATT_DISPLAY_PORT\n");
    printf("                   %8s %8s\n","Expect","Actual");
    printf("BATT_VOLTAGE_PORT: %8d %8hd\n", BATT_VOLTAGE_PORT, test.initial_voltage_port);
    printf("BATT_STATUS_PORT : %8d %8hhd\n",BATT_STATUS_PORT,  test.initial_status_port);
    printf("BATT_DISPLAY_PORT: %8d %8d\n",  BATT_DISPLAY_PORT, test.initial_display_port);

    printf("----------------------------------------------------------------\n");
    return;
  }
  else if( !compare_batt_t(actual,test.expect_batt) || actual_ret!=test.expect_ret){
    printf("FAILED\n");
    printf("----------------------------------------------------------------\n");
    printf("Test Description:\n%s\n",test.desc);
    printf("Actual and Expected batt_t differ or return value wrong\n");
    printf("BATT_VOLTAGE_PORT: %d\n",BATT_VOLTAGE_PORT);
    printf("BATT_STATUS_PORT : %d\n",BATT_STATUS_PORT);
    printf("EXPECT batt: "); print_batt(test.expect_batt);
    printf("ACTUAL batt: "); print_batt(actual);
    printf("EXPECT return %d\n",test.expect_ret);
    printf("ACTUAL return %d\n",actual_ret);
    printf("----------------------------------------------------------------\n");
    return;
  }
  passed++;
  printf("OK\n");
}    

void test_set_display_from_batt(batt_test_case test){
  testn++;
  print_test_description("set_display_from_batt()",test.id);
  BATT_VOLTAGE_PORT  =  0;
  BATT_STATUS_PORT   =  0;
  BATT_DISPLAY_PORT  = -1;

  int actual_display = test.initial_display_port;                            // initialize, funciton call should change it
  *malloced_display = actual_display;
  int actual_ret = set_display_from_batt(test.expect_batt, malloced_display); // pass in batt data that is 'correct'
  actual_display =  *malloced_display;

  if(   (int) BATT_VOLTAGE_PORT  !=  0
     || (int) BATT_STATUS_PORT   !=  0
     || (int) BATT_DISPLAY_PORT  != -1)
  {
    printf("FAILED\n");
    printf("----------------------------------------------------------------\n");
    printf("Do not modify global variables, BATT_VOLTAGE_PORT, BATT_STATUS_PORT, BATT_DISPLAY_PORT\n");
    printf("----------------------------------------------------------------\n");
    return;
  }
  else if(actual_display != test.expect_display || actual_ret != test.expect_ret){
    printf("FAILED\n");
    printf("----------------------------------------------------------------\n");
    printf("Test Description:\n%s\n",test.desc);
    printf("Actual and Expected bits differ\n");
    printf("input batt = \n"); print_batt(test.expect_batt);
    printf("              index:  3         2         1    0    0\n");
    printf("              index: 10987654321098765432109876543210\n");
    printf("EXPECT display bits: "); showbits(test.expect_display); printf("\n");
    printf("ACTUAL display bits: "); showbits(actual_display); printf("\n");
    printf("              guide:  |    |    |    |    |    |    |\n");
    printf("              index:  30   25   20   15   10   5    0\n");
    printf("\n");
    printf("EXPECT return %d\n",test.expect_ret);
    printf("ACTUAL return %d\n",actual_ret);
    printf("----------------------------------------------------------------\n");
    return;
  }
  passed++;
  printf("OK\n");
}

void test_batt_update(batt_test_case test){
  testn++;
  print_test_description("batt_update()",test.id);
  BATT_VOLTAGE_PORT  = test.initial_voltage_port;
  BATT_STATUS_PORT   = test.initial_status_port;
  BATT_DISPLAY_PORT  = test.initial_display_port;
  int actual_ret = batt_update();
  if(   BATT_DISPLAY_PORT != test.expect_display
     || BATT_STATUS_PORT  != test.initial_status_port 
     || BATT_VOLTAGE_PORT != test.initial_voltage_port 
     || actual_ret        != test.expect_ret)
  {
    printf("FAILED\n");
    printf("----------------------------------------------------------------\n");
    printf("Test Description:\n%s\n",test.desc);
    printf("Expect BATT_VOLTAGE_PORT: %d\n",test.initial_voltage_port);
    printf("Actual BATT_VOLTAGE_PORT: %d\n",BATT_VOLTAGE_PORT);
    printf("Expect BATT_STATUS_PORT:  %d\n",test.initial_status_port);
    printf("Actual BATT_STATUS_PORT:  %d\n",BATT_STATUS_PORT);
    printf("Bits of BATT_DISPLAY_PORT\n");
    printf("              index:  3         2         1    0    0\n");
    printf("              index: 10987654321098765432109876543210\n");
    printf("EXPECT DISPLAY PORT: "); showbits(test.expect_display); printf("\n");
    printf("ACTUAL DISPLAY PORT: "); showbits(BATT_DISPLAY_PORT);   printf("\n");
    printf("              guide:  |    |    |    |    |    |    |\n");
    printf("              index:  30   25   20   15   10   5    0\n");
    printf("\n");
    printf("EXPECT return %d\n",test.expect_ret);
    printf("ACTUAL return %d\n",actual_ret);
    printf("----------------------------------------------------------------\n");
    return;
  }
  passed++;
  printf("OK\n");
  return;
}


// Global array of test data; terminated by a struct with .id=NULL 
batt_test_case tests[] = {

  { .id = "3700V",
    .desc = "\
Normal voltage 87% full, 4 bars\
",
    .expect_ret = 0,
    .initial_voltage_port = 3700,
    .initial_status_port  = 0,  // voltage mode
    .initial_display_port = -1,
    .expect_batt = {
      .volts = 3700,
      .percent = 87,
      .mode    =  0,
    },
    .expect_display=0b00011110011110011101000110111111,
  },

  { .id = "3482V",
    .desc = "\
Normal voltage, 60% full, 3 bars\
",
    .expect_ret = 0,
    .initial_voltage_port = 3482,
    .initial_status_port  = 0,  // voltage mode
    .initial_display_port = -1,
    .expect_batt = {
      .volts = 3482,
      .percent = 60,
      .mode    =  0,
    },
    .expect_display=0b00011100011110011110100111111111,
  },

  { .id = "3310V",
    .desc = "\
Normal voltage, 38% full, 2 bars\
",
    .expect_ret = 0,
    .initial_voltage_port = 3310,
    .initial_status_port  = 0,  // voltage mode
    .initial_display_port = -1,
    .expect_batt = {
      .volts = 3310,
      .percent = 38,
      .mode    =  0,
    },
    .expect_display=0b00011000011110011111001110000011,
  },

  { .id = "3310V-percent",
    .desc = "\
Normal voltage, 38% full, 2 bars, show percent\
",
    .expect_ret = 0,
    .initial_voltage_port = 3310,
    .initial_status_port  = 1,  // percent mode
    .initial_display_port = -1,
    .expect_batt = {
      .volts = 3310,
      .percent = 38,
      .mode    =  1,
    },
    .expect_display=0b00011000100000000011001111111111,
  },


  { .id = "3800V-percent",
    .desc = "\
Normal voltage, 100% full, 5 bars, show percent\
",
    .expect_ret = 0,
    .initial_voltage_port = 3800,
    .initial_status_port  = 1,  // percent mode
    .initial_display_port = -1,
    .expect_batt = {
      .volts = 3800,
      .percent = 100,
      .mode    =  1,
    },
    .expect_display=0b00011111100000001101111110111111,
  },

  { .id = "4217V-percent",
    .desc = "\
Above full voltage, 100% full, 5 bars, show percent\
",
    .expect_ret = 0,
    .initial_voltage_port = 4217,
    .initial_status_port  = 1,  // percent mode
    .initial_display_port = -1,
    .expect_batt = {
      .volts = 4217,
      .percent = 100,
      .mode    =  1,
    },
    .expect_display=0b00011111100000001101111110111111,
  },

  { .id = "3240V-percent",
    .desc = "\
Edge case: 30% >= full -> 2 bars, show percent\
",
    .expect_ret = 0,
    .initial_voltage_port = 3240,
    .initial_status_port  = 1,  // percent mode
    .initial_display_port = -1,
    .expect_batt = {
      .volts = 3240,
      .percent = 30,
      .mode    =  1,
    },
    .expect_display=0b00011000100000000011001110111111,
  },


  { .id = "3015-percent",
    .desc = "\
Edge case: 1% full -> 0 bars, show percent\
",
    .expect_ret = 0,
    .initial_voltage_port = 3015,
    .initial_status_port  = 1,  // percent mode
    .initial_display_port = -1,
    .expect_batt = {
      .volts = 3015,
      .percent =  1,
      .mode    =  1,
    },
    .expect_display=0b00000000100000000000000000000011,
  },

//   { .id = "3724V",
//     .desc = "
// Edge case: 90% >= full -> 5 bars, show volts
// ",
//     .expect_ret = 0,
//     .initial_voltage_port = 3724,
//     .initial_status_port  = 0,  // voltage mode
//     .initial_display_port = -1,
//     .expect_batt = {
//       .volts = 3724,
//       .percent = 90,
//       .mode    =  0,
//     },
//     .expect_display=0b00011111011110011101000111101101,
//   },



  {.id = NULL }
};

// special tests for error conditions
void test_error_conditions(){

  {
    batt_test_case test = {
      .id = "status-0b10010",
      .desc = "\
Status port set to 0b10010, last bit not set but value nonzero\n\
Should show voltage as least significant bit of port is not set.\
",
      .expect_ret = 0,
      .initial_voltage_port = 3713,
      .initial_status_port  = 0b10010,  // volts (but nonzero)
      .initial_display_port = -1,
      .expect_batt = {
        .volts = 3713,
        .percent = 89,
        .mode    =  0,
      },
      .expect_display=0b00011110011110011101000110000011,
    };
    test_set_batt_from_ports(test);
    test_batt_update(test);
  }

  {
    batt_test_case test = {
      .id = "status-0b01101",
      .desc = "\
Status port set to 0b01101, last bit is set has other nonzeros\n\
Should show percent as least significant bit of port is set.\
",
      .expect_ret = 0,
      .initial_voltage_port = 3713,
      .initial_status_port  = 0b01101,  // percent (with other nonzeros)
      .initial_display_port = -1,
      .expect_batt = {
        .volts = 3713,
        .percent = 89,
        .mode    =  1,
      },
      .expect_display=0b00011110100000000011111111110111,
    };
    test_set_batt_from_ports(test);
    test_batt_update(test);
  }

  {
    batt_test_case test = {
      .id = "negative-volts",
      .desc = "\
Voltage port is negative and should return 1 for errror\
",
      .expect_ret = 1,
      .initial_voltage_port = -3247,
      .initial_status_port  = 0,  // volts
      .initial_display_port = -1,
      .expect_batt = {
        .volts =   0,
        .percent = -1,
        .mode    = -1,
      },
      .expect_display=-1,
    };
    test_set_batt_from_ports(test);
    test_batt_update(test);
  }
}

int main(int argc, char **argv){
  setvbuf(stdout, NULL, _IONBF, 0); // Turn off buffering to help with valgrind error message coordination

  malloced_batt = malloc(sizeof(batt_t));
  malloced_display = malloc(sizeof(int));

  printf("----------------------------------------\n");
  printf("PROBLEM 1: test_batt_update.c binary tests for batt_update.c\n");

  // Run set_temp_from_ports() tests
  for(int i=0; tests[i].id != NULL; i++){
    test_set_batt_from_ports(tests[i]);
  }
    
  // Run set_display_from_temp() tests
  for(int i=0; tests[i].id != NULL; i++){
    test_set_display_from_batt(tests[i]);
  }

  // Run lcd_update() tests
  for(int i=0; tests[i].id != NULL; i++){
    test_batt_update(tests[i]);
  }

  test_error_conditions();

  printf("----------------------------------------------------------------\n");
  printf("Passed: %d / %d tests with 0.5 points per test\n",passed,testn);
  double dpassed = 0.5 * passed;
  double dtestn  = 0.5 * testn;
  printf("Score: %.1f / %.1f points\n",dpassed,dtestn);
  // printf("RESULTS: %.1f / %.1f points\n",dpassed,dtestn);

  free(malloced_batt);
  free(malloced_display);

  return 0;
}
