#include "search.h"
#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <string.h>

long Powero2(const int num);

void print_usage(){
  printf("usage: ./search_benchmark <minpow> <maxpow> <repeats>[which]\n");
  printf("which is a combination of:\n");
  printf("  a : Linear Array Search\n");
  printf("  l : Linked List Search\n");
  printf("  b : Binary Array Search\n");
  printf("  t : Binary Tree Search\n");
  printf("  (default all)\n");
}

int (*search[4])(void *, int, int) = {
  linear_array_search,
  linkedlist_search,
  binary_array_search,
  binary_tree_search,
};
void *(*setup[4])(int) = {
  make_evens_array,
  make_evens_list,
  make_evens_array,
  make_evens_tree,
};
void (*clean[4])(void *) = {
  free,
  list_free,
  free,
  bst_free,
};
int main(int argc, char *argv[]){


  if(argc<4){
    print_usage();
    return 1;
  }
  int minpow = Powero2(atoi(argv[1]));
  int maxpow = Powero2(atoi(argv[2]));
  long repeats = atoi(argv[3]);
  int input[4] = {0,0,0,0};
  printf("  LENGTH SEARCHES");
  if(argc == 4){
    for(int i = 0; i<4; i++){
   	input[i]=1;
	}
    printf("      array");
    printf("      list");
    printf("      binary");
    printf("      tree");
  }
  else{
    char *str = argv[4];
    for(int i = 0; str[i] != '\0'; i++){
      switch(str[i]){
        case 'a':
        input[0] = 1;
        printf("      array");
        break;

        case 'l':
        input[1] = 1;
        printf("      list");
        break;

        case 'b':
        input[2] = 1;
        printf("      binary");
        break;

        case 't':
        input[3] = 1;
        printf("      tree");
        break;
      }
    }
  }
  printf("\n");

  for (long len = minpow; len <= maxpow; len *= 2){
    printf("%8ld %8ld  ", len, 2*len);
    //arrays for the right and wrong ones
    long *crct = (long *)malloc(len * sizeof(long));
    long *wrong = (long *)malloc(len * sizeof(long));
    for(long i = 0; i<len/2; i++){
      crct[i*2] = i;
      crct[i*2+1] = i+(len/2);
      wrong[i*2] = i;
      wrong[i*2+1] = -1 - i - (len/2);
    }

    double time[4];
    //initializes timing array. 4 for each arg
    for(int i = 0; i<4; i++){
      time[i] = 0.0;
    }
    for(int i = 0; i<4; i++){
      clock_t start, finish;
      if(input[i]){
        void *info = setup[i](len);
        for(long x = 0; x<len; x++){
          for(int y = 0; y < repeats; y++){ //searching with correct list
            start = clock();
            search[i](info, len, crct[x]);
            finish = clock();
            time[i] += ((double)(finish - start) / CLOCKS_PER_SEC);
          }
        }
        for(long x = 0; x<len; x++){
          for(int y = 0; y<repeats; y++){
            start = clock();
            search[i](info, len, wrong[x]);
            finish = clock();
            time[i] += ((double)(finish - start) / CLOCKS_PER_SEC);
          }
        }
        clean[i](info);
        printf("%12e  ", time[i]);
      }
    }
    printf("\n");
    free(crct);
    free(wrong);
  }
  
  return 0;
}

long Powero2(const int num){
  long x = 1;
  for(int i = 0; i < num; i++){
    x = x * 2;
  }
  return x;
}
