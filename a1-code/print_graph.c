#include <stdio.h>
#include <math.h>

void print_graph(int *data, int len, int max_height){
// Prints a graph of the values in data which is an array of integers
// that has len elements. The max_height argument is the height in
// character rows that the maximum number data[] should be.  A sample
// graph is as follows:
//
// length: 50
// min: 13
// max: 996
// range: 983
// max_height: 10
// units_per_height: 98.30
//      +----+----+----+----+----+----+----+----+----+----
// 996 |                X                                 
// 897 |       X        X X            X                  
// 799 |  X    X X   X  X X    X       X                X 
// 701 |  XX   X X   X  XXX    X      XX   XXX    X   X XX
// 602 |  XX   X X  XX  XXX X  X      XX  XXXX    XX  X XX
// 504 |  XX   XXX  XX  XXX XX X      XXX XXXX XX XX  X XX
// 406 |  XX X XXX XXXX XXX XX X  XXX XXX XXXXXXXXXX  X XX
// 307 | XXX X XXX XXXXXXXXXXX X XXXX XXXXXXXXXXXXXXX X XX
// 209 | XXX XXXXXXXXXXXXXXXXX XXXXXX XXXXXXXXXXXXXXXXX XX
// 111 | XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
//  13 |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
//      +----+----+----+----+----+----+----+----+----+----
//      0    5    10   15   20   25   30   35   40   45   


int i, max, min;

max = data[0];
min = data[0];

for(i=1; i<len; i++){
    if(data[i] > max){
        max = data[i];
    }
    else if(data[i] < min){
        min = data[i];
    }
    else{
        continue;
    }
}
int range = max - min;
float uph = (float)range/(float)max_height;

printf("Length: %d\n", len);
printf("min: %d\n", min);
printf("max: %d\n", max);
printf("range: %d\n", range);
printf("max_height: %d\n", max_height);
printf("units_per_height: %0.2f\n", uph);

printf("\n%6s", " +");
for(i=1; i<len; i++){
    if(i % 5 == 0){
        printf("%s", "+");
    }
    else{
        printf("-");
    }
}
int level;
if(max<100 && max > 9){ //bunch of test cases for formatting
    printf("\n%d  |", max);
}
else{
    printf("\n%d |", max);
}
for(i=0; i<len; i++){
    if(data[i] >= max){
        printf("X");
    }
    else{
        printf(" ");
    }
}
for(max_height >= 0; max_height--;){ //for loop doesn't really do much but it works
    level = min + max_height * uph;
    if(level < 100 && level > 9){
        printf("\n%d  |", level);
    }
    else if( level < 10 && level > 0){
        printf("\n%d   |", level);
    }
    else{
        printf("\n%d |", level);
    }
    for(i=0; i<len; i++){
        if(data[i] >= level){
            printf("X");
        }
        else{
            printf(" ");
        }
    }

}
printf("\n%6s", "+");
for(i=1; i<len; i++){
    if(i % 5 == 0){
        printf("%s", "+");
    }
    else{
        printf("-");
    }
}
printf("\n%6d", 0);
for(i=1; i<len; i++){
    if(i % 5 == 0){
        printf("%5d", i);
    }
    else{
        continue;
    }
}

}