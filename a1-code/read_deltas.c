#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "deltas.h"
#include <sys/stat.h>

int *read_text_deltas(char *fname, int *len){
// Reads integers in text delta format from the file named by fname
// and returns an array of them. The first integer in the file gives
// the starting point and subsequent integers are changes from the
// previous total.
// 
// Opens the file with fopen() and scans through its contents using
// fscanf() counting how many text integers exist in it.  Then
// allocates an array of appropriate size using malloc(). Uses
// rewind() to go back to the beginning of the file then reads
// integers into the allocated array. Closes the file after reading
// all ints.  Returns a pointer to the allocated array.
// 
// The argument len is a pointer to an integer which is set to the
// length of the array that is allocated by the function.
//
// If the file cannot be opened with fopen() or if there are no
// integers in the file, sets len to -1 and returns NULL.

FILE *fn = fopen(fname, "r");
int i, count = 0;
count = *len;

if(fn == NULL){
    printf("Error reading file");
    exit(0);
}
else{
    while(!(feof(fn))){ //goes until end of file
        char c = fgetc(fn); //moves it along to get the count
        count++;
    }
    rewind(fn); //goes to beginning of file
}

int *array = malloc(count * sizeof(int)); //space for array
count = 0;

while(!(feof(fn))){
    fscanf(fn, "%d", &array[count]); //adds text to array
    count++;
}

for(i=1; i<count-1; i++){
    array[i] = array[i-1] + array[i]; 
    //printf("\n a[%d] = %d\n", i-1, array[i-1]); #test if it comes out right
}
*len = count-1;
fclose(fn);
return array;
free(array);

}

int *read_int_deltas(char *fname, int *len){
// Reads integers in binary delta format from the file named by fname
// and returns an array of them.  The first integer in the file gives
// the starting point and subsequent integers are changes from the
// previous total.
// 
// Integers in the file are in binary format so the size of the file
// in bytes indicates the quantity of integers. Uses the stat() system
// call to determine the file size in bytes which then allows an array
// of appropriate size to be allocated. DOES NOT scan through the file
// to count its size as this is not needed.
// 
// Opens the file with fopen() and uses repeated calls to fread() to
// read binary integers into the allocated array. Does delta
// computations as integers are read. Closes the file after reading
// all ints.
// 
// The argument len is a pointer to an integer which is set to
// the length of the array that is allocated by the function.
//
// If the file cannot be opened with fopen() or file is smaller than
// the size of 1 int, sets len to -1 and returns NULL.

struct stat sb;
int result = stat(fname, &sb);
if(result == -1 || sb.st_size < sizeof(int)){
    return NULL;
}
int total_bytes = sb.st_size;

FILE *fn = fopen(fname, "rb");
int byt = total_bytes/4;

int *array = malloc(byt * sizeof(int)); //Allocate for array

for(int i = 0; i<byt; i++){
    fread(&array[i], sizeof(int), 1, fn);
}
for(int p = 1; p<byt; p++){
    array[p] = array[p-1] + array[p];
}
rewind(fn);
*len = byt;
fclose(fn);
return array;
free(array);

}