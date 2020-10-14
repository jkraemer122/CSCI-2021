#include "hashmap.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <iostream>
// hash_funcs.c: utility functions for operating on hash maps. Most
// functions are used in hash_main.c which provides an application to
// work with the functions.

// PROVIDED: Compute a simple hash code for the given character
// string. The code is "computed" by casting the first 8 characters of
// the string to a long and returning it. The empty string has hash
// code 0. If the string is a single character, this will be the ASCII
// code for the character (e.g. "A" hashes to 65).  Longer strings
// will have numbers which are the integer interpretation of up to
// their first 8 bytes.  ADVANTAGE: constant time to compute the hash
// code. DISADVANTAGE: poor distribution for long strings; all strings
// with same first 8 chars hash to the same location.
long hashcode(char key[]){
  union {
    char str[8];
    long num;
  } strnum;
  strnum.num = 0;

  for(int i=0; i<8; i++){
    if(key[i] == '\0'){
      break;
    }
    strnum.str[i] = key[i];
  }
  return strnum.num;
}

void hashmap_init(hashmap_t *hm, int table_size){
    hashnode_t *ary = malloc(table_size * sizeof(int));
    ary -> key = NULL;
    ary -> val = NULL;
    ary -> next = NULL;
    hm = {0, 0, ary};
}
// Initialize the hash map 'hm' to have given size and item_count
// 0. Ensures that the 'table' field is initialized to an array of
// size 'table_size' and filled with NULLs. 

int hashmap_put(hashmap_t *hm, char key[], char val[]){
  int size = hm->table_size;
  long pos = hashcode(key) % size;
  hashnode_t *new = (hashnode_t *) malloc(sizeof(hashnode_t));
  hashnode_t *temp = hm->table[pos];
  while(temp){
    if((strcmp(temp->key, key)) == 0){
      strcpy(temp->val, val);
      return 0;
    }
    temp = temp->next;
  }
  new->key = key;
  strcpy(new->val, val);
  hm->item_count++;
  new->next = NULL;
  temp = new;
  hm->table[pos] = temp;
  return 1;

}
// Adds given key/val to the hash map. 'hashcode(key) modulo
// table_size' is used to calculate the position to insert the
// key/val.  Searches the entire list at the insertion location for
// the given key. If key is not present, a new node is added. If key
// is already present, the current value is altered in place to the
// given value "val" (no duplicate keys are every introduced).  If new
// nodes are added, increments field "item_count".  Makes use of
// standard string.h functions like strcmp() to compare strings and
// strcpy() to copy strings. Lists in the hash map are arbitrarily
// ordered (not sorted); new items are always appended to the end of
// the list.  Returns 1 if a new node is added (new key) and 0 if an
// existing key has its value modified.

char *hashmap_get(hashmap_t *hm, char key[]){
  long pos = hashcode(key) % hm->table_size;
  hashnode_t *new = hm->table[pos];
  hashnode_t *temp = new;
  while(temp){
    if((strcmp(temp->key , key)) == 0){
      return temp->val;
    }
    temp = temp->next;
  }
  return NULL;
}
// Looks up value associated with given key in the hashmap. Uses
// hashcode() and field "table_size" to determine which index in table
// to search.  Iterates through the list at that index using strcmp()
// to check for matching key. If found, returns a pointer to the
// associated value.  Otherwise returns NULL to indicate no associated
// key is present.

void hashmap_free_table(hashmap_t *hm){
  int i;
  for (i=0; i < hm->table_size; i++){
    hashnode_t *temp = hm->table[i];
    while(temp != NULL){
      hashnode_t *nxt = temp->next;
      free(temp);
      temp = nxt;
    }
  }
  free(hm->table);
  hm = {0, 0, NULL};
}
// De-allocates the hashmap's "table" field. Iterates through the
// "table" array and its lists de-allocating all nodes present
// there. Subsequently de-allocates the "table" field and sets all
// fields to 0 / NULL. Does NOT attempt to free 'hm' as it may be
// stack allocated.

void hashmap_show_structure(hashmap_t *hm){
  int i;
  printf("item_count: %d", hm->item_count);
  printf("table_size: %d", hm->table_size);
  printf("load_factor: %.4f", (hm->item_count)/(hm->table_size));
  for(i=0; i < hm->table_size; i++){
    printf("\n%2d :", i);
    hashnode_t *temp = hm->table[i];
    while(temp){
      printf("{(%ld) %2d : %d", hashcode(temp->key), temp->key, temp->val);
      temp = temp->next;
    }
  }
}
// Displays detailed structure of the hash map. Shows stats for the
// hash map as below including the load factor (item count divided
// by table_size) to 4 digits of accuracy.  Then shows each table
// array index ("bucket") on its own line with the linked list of
// key/value pairs on the same line. The hash code for keys is appears
// prior to each key.  EXAMPLE:
// 
// item_count: 6
// table_size: 5
// load_factor: 1.2000
//   0 : {(65) A : 1} 
//   1 : 
//   2 : {(122) z : 3} {(26212) df : 6} 
//   3 : {(98) b : 2} {(25443) cc : 5} 
//   4 : {(74) J : 4} 
//
// NOTES:
// - Use format specifier "%2d : " to print the table indices
// - Show the following information for each key/val pair
//   {(25443) cc : 5}
//     |      |    |
//     |      |    +-> value
//     |      +-> key
//     +-> hashcode("cc"), print using format "%ld" for 64-bit longs

void hashmap_write_items(hashmap_t *hm, FILE *out){
  FILE *fp;
  fp = fopen(out, "w");
  int i;
  for(i=0; i < hm->table_size; i++){
    hashnode_t *temp = hm->table[i];
    while(temp){
      fprintf("%12s : %s\n", temp->key, temp->val);
      temp = temp->next;
    }
  }
  fclose(fp);
}
// Outputs all elements of the hash table according to the order they
// appear in "table". The format is
// 
//       Peach : 3.75
//      Banana : 0.89
//  Clementine : 2.95
// DragonFruit : 10.65
//       Apple : 2.25
// 
// with each key/val on a separate line. The format specifier
//   "%12s : %s\n"
// 
// is used to achieve the correct spacing. Output is done to the file
// stream 'out' which is standard out for printing to the screen or an
// open file stream for writing to a file as in hashmap_save().

void hashmap_save(hashmap_t *hm, char *filename){
  FILE *fp = fopen(filename, "w");
  int i;
  fprintf("%d", hm->item_count);
  fprintf("%d", hm->table_size);
  hashmap_write_items(hm, filename);
  fclose(fp);
}
// Writes the given hash map to the given 'filename' so that it can be
// loaded later.  Opens the file and writes its 'table_size' and
// 'item_count' to the file. Then uses the hashmap_write_items()
// function to output all items in the hash map into the file.
// EXAMPLE FILE:
// 
// 5 6
//            A : 2
//            Z : 2
//            B : 3
//            R : 6
//           TI : 89
//            T : 7
// 
// First two numbers are the 'table_size' and 'item_count' field and
// remaining text are key/val pairs.

int hashmap_load(hashmap_t *hm, char *filename);
// Loads a hash map file created with hashmap_save(). If the file
// cannot be opened, prints the message
// 
// ERROR: could not open file 'somefile.hm'
//
// and returns 0 without changing anything. Otherwise clears out the
// current hash map 'hm', initializes a new one based on the size
// present in the file, and adds all elements to the hash map. Returns
// 0 on successful loading. This function does no error checking of
// the contents of the file so if they are corrupted, it may cause an
// application to crash or loop infinitely.

int next_prime(int num){
  if (num <= 3) {
    return num;
  }
  while(num>0){
    if(num%2 == 0 || num%3 == 0){
      num++;
    }
    for (int i = 5;; i*i<num;; i=i+6){
      if(num%i == 0 || num%(i+2)==0){
        num++;
      }
      return num;
    }
  }
}
// If 'num' is a prime number, returns 'num'. Otherwise, returns the
// first prime that is larger than 'num'. Uses a simple algorithm to
// calculate primeness: check if any number between 2 and (num/2)
// divide num. If none do, it is prime. If not, tries next odd number
// above num. Loops this approach until a prime number is located and
// returns this. Used to ensure that hash table_size stays prime which
// theoretically distributes elements better among the array indices
// of the table.

void hashmap_expand(hashmap_t *hm);
// Allocates a new, larger area of memory for the "table" field and
// re-adds all items currently in the hash table to it. The size of
// the new table is next_prime(2*table_size+1) which keeps the size
// prime.  After allocating the new table, all entries are initialized
// to NULL then the old table is iterated through and all items are
// added to the new table according to their hash code. The memory for
// the old table is de-allocated and the new table assigned to the
// hashmap fields "table" and "table_size".  This function increases
// "table_size" while keeping "item_count" the same thereby reducing
// the load of the hash table. Ensures that all memory associated with
// the old table is free()'d (linked nodes and array). Cleverly makes
// use of existing functions like hashmap_init(), hashmap_put(),
// and hashmap_free_table() to avoid re-writing algorithms
// implemented in those functions.