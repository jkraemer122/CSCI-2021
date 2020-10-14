#include <stdlib.h>
#include <stdio.h>

typedef struct {
    int poss, negs;
} pn_t;

pn_t *get_pn (int *arr, int len){
    if(arr == NULL || len < 0){
        printf("NULL");
        return NULL;
    }
    pn_t *new = malloc(sizeof(pn_t));
    new->negs = 0;
    new->poss = 0;
    for(int i = 0; i<len; i++){
        if(arr[i] < 0){
            new->negs++;
        }
        else{
            new->poss++;
        }
    }
    printf("new->poss = %d\n", new->poss);
    printf("new->negs = %d\n", new->negs);
    return new;
}

int main(){
    int arr1[5] = {3, 0, -1, 7, -4};
    pn_t *pn1 = get_pn(arr1, 5);

    int arr2[3] = {-1, -2, -4};
    pn_t *pn2 = get_pn(arr2, 3);

    int arr3 = NULL;
    pn_t *pn3 = get_pn(arr3, -1);

}