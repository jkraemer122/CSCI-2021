#include "matvec.h"
#include <stdlib.h>

int optimized_matrix_trans_mult_vec(matrix_t mat, vector_t vec, vector_t res){
  if(mat.cols != vec.len){
    printf("mat.cols (%ld) != vec.len (%ld)", mat.cols, vec.len);
    return 1; 
  }
  if(mat.rows != res.len){
    printf("mat.cols (%ld) != res.len (%ld)", mat.rows, res.len);
    return 1;
  }

  int prods[mat.cols]; // array to store values, allocated beforehand

  for(int p = 0; p<mat.cols; p++){
    prods[p] = 0; //sets array to 0 to be sure
  }
  for(int j = 0; j<mat.rows; j++){
    int vect1 = VGET(vec, j);
    int i;                                // accesses the vector value one time
    for(i = 0; i < mat.cols; i+=4){ // goes over every column by 4
      prods[i] += MGET(mat, j, i) * vect1;  //gets column value and
      prods[i+1] = MGET(mat, j, i+1) * vect1;//multiplies by vector
      prods[i+2] = MGET(mat, j, i+2) * vect1;//then adds to array
      prods[i+3] = MGET(mat, j, i+3) * vect1;
    }
    for(; i < mat.cols; i++){
      prods[i] += MGET(mat, j, i) * vect1;
    }
  }
  for(int k = 0; k<mat.cols; k++){
    VSET(res, k, prods[k]); //sets array value into the vector
  }
  return 0;

}
