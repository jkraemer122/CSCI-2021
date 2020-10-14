#!/bin/bash
T=0                             # global test number

((T++))
tnames[T]="3591V"
input[T]="3591 V"
desc[T]="Standard voltage with 4 bars"
read  -r -d '' output[$T] <<"ENDOUT"
BATT_VOLTAGE_PORT set to: 3591
set_batt_from_ports(&batt );
batt is {
  .volts   = 3591
  .percent = 73
  .mode    = 0
}

Checking results for display bits
set_display_from_batt(batt, &display);

display is:
        3         2         1         0
index: 10987654321098765432109876543210
bits:  00011110011110011111101101110111
guide:  |    |    |    |    |    |    |
index:  30        20        10        0

Running batt_update()

BATT_DISPLAY_PORT is:
index:  3         2         1    0    0
index: 10987654321098765432109876543210
bits:  00011110011110011111101101110111
guide:  |    |    |    |    |    |    |
index:  30        20        10        0

Battery Meter Display:
+-^^^-+  ####   ####  ####     
|     |     #   #     #  #     
|#####|     #   #     #  #     
|#####|  ####   ####  ####  V  
|#####|     #      #     #     
|#####|     #      #     #     
+-----+  #### o ####  ####     
ENDOUT

((T++))
tnames[T]="2900V-0-perc"
input[T]="2900 P"
desc[T]="Low voltage (2900V) which should read as 0 percent and 0 bars"
read  -r -d '' output[$T] <<"ENDOUT"
BATT_VOLTAGE_PORT set to: 2900
set_batt_from_ports(&batt );
batt is {
  .volts   = 2900
  .percent = 0
  .mode    = 1
}

Checking results for display bits
set_display_from_batt(batt, &display);

display is:
        3         2         1         0
index: 10987654321098765432109876543210
bits:  00000000100000000000000000111111
guide:  |    |    |    |    |    |    |
index:  30        20        10        0

Running batt_update()

BATT_DISPLAY_PORT is:
index:  3         2         1    0    0
index: 10987654321098765432109876543210
bits:  00000000100000000000000000111111
guide:  |    |    |    |    |    |    |
index:  30        20        10        0

Battery Meter Display:
+-^^^-+               ####     
|     |               #  #     
|     |               #  #     
|     |               #  #     
|     |               #  #  %  
|     |               #  #     
+-----+               ####     
ENDOUT

((T++))
tnames[T]="3246V-30-percent"
input[T]="3246 P"
desc[T]="Standard voltage, shows 30% with 2 bars"
read  -r -d '' output[$T] <<"ENDOUT"
BATT_VOLTAGE_PORT set to: 3246
set_batt_from_ports(&batt );
batt is {
  .volts   = 3246
  .percent = 30
  .mode    = 1
}

Checking results for display bits
set_display_from_batt(batt, &display);

display is:
        3         2         1         0
index: 10987654321098765432109876543210
bits:  00011000100000000011001110111111
guide:  |    |    |    |    |    |    |
index:  30        20        10        0

Running batt_update()

BATT_DISPLAY_PORT is:
index:  3         2         1    0    0
index: 10987654321098765432109876543210
bits:  00011000100000000011001110111111
guide:  |    |    |    |    |    |    |
index:  30        20        10        0

Battery Meter Display:
+-^^^-+         ####  ####     
|     |            #  #  #     
|     |            #  #  #     
|     |         ####  #  #     
|#####|            #  #  #  %  
|#####|            #  #  #     
+-----+         ####  ####     
ENDOUT


((T++))
tnames[T]="3986V-round"
input[T]="3986 V"
desc[T]="Fully charged, rounds to 3.99V on display, 5 bars"
read  -r -d '' output[$T] <<"ENDOUT"
BATT_VOLTAGE_PORT set to: 3986
set_batt_from_ports(&batt );
batt is {
  .volts   = 3986
  .percent = 100
  .mode    = 0
}

Checking results for display bits
set_display_from_batt(batt, &display);

display is:
        3         2         1         0
index: 10987654321098765432109876543210
bits:  00011111011110011111101111110111
guide:  |    |    |    |    |    |    |
index:  30        20        10        0

Running batt_update()

BATT_DISPLAY_PORT is:
index:  3         2         1    0    0
index: 10987654321098765432109876543210
bits:  00011111011110011111101111110111
guide:  |    |    |    |    |    |    |
index:  30        20        10        0

Battery Meter Display:
+-^^^-+  ####   ####  ####     
|#####|     #   #  #  #  #     
|#####|     #   #  #  #  #     
|#####|  ####   ####  ####  V  
|#####|     #      #     #     
|#####|     #      #     #     
+-----+  #### o ####  ####     
ENDOUT


((T++))
tnames[T]="3143V-percent"
input[T]="3143 p"
desc[T]="Standard range wiht 17% left, 1 bar"
read  -r -d '' output[$T] <<"ENDOUT"
BATT_VOLTAGE_PORT set to: 3143
set_batt_from_ports(&batt );
batt is {
  .volts   = 3143
  .percent = 17
  .mode    = 1
}

Checking results for display bits
set_display_from_batt(batt, &display);

display is:
        3         2         1         0
index: 10987654321098765432109876543210
bits:  00010000100000000000000110100011
guide:  |    |    |    |    |    |    |
index:  30        20        10        0

Running batt_update()

BATT_DISPLAY_PORT is:
index:  3         2         1    0    0
index: 10987654321098765432109876543210
bits:  00010000100000000000000110100011
guide:  |    |    |    |    |    |    |
index:  30        20        10        0

Battery Meter Display:
+-^^^-+            #  ####     
|     |            #     #     
|     |            #     #     
|     |            #     #     
|     |            #     #  %  
|#####|            #     #     
+-----+            #     #     
ENDOUT
