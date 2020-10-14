#!/bin/bash
# 
# Wed 11 Sep 2019 08:58:38 AM CDT: Update to fix 'hashcode' in main
# should print longs rather than ints

T=0                             # global test number

((T++))
tnames[T]="start-print-quit"
read  -r -d '' input[$T] <<"ENDIN"
print
quit
ENDIN
#
read  -r -d '' output[$T] <<"ENDOUT"
Hashmap Demo
Commands:
  hashcode <key>   : prints out the numeric hash code for the given key (does not change the hash map)
  put <key> <val>  : inserts the given key/val into the hash map, overwrites existing values if present
  get <key>        : prints the value associated with the given key or NOT FOUND
  print            : shows contents of the hashmap ordered by how they appear in the table
  structure        : prints detailed structure of the hash map
  clear            : reinitializes hash map to be empty with default size
  save <file>      : writes the contents of the hash map the given file
  load <file>      : clears the current hash map and loads the one in the given file
  next_prime <int> : if <int> is prime, prints it, otherwise finds the next prime and prints it
  expand           : expands memory size of hashmap to reduce its load factor
  quit             : exit the program
HM> print
HM> quit
ENDOUT


((T++))
tnames[T]="hashcode-get-empty"
read  -r -d '' input[$T] <<"ENDIN"
print
hashcode a
hashcode A
hashcode Aa
hashcode apple
hashcode banana
get a
get Aa
get apple
get banana
quit
ENDIN
#
read  -r -d '' output[$T] <<"ENDOUT"
Hashmap Demo
Commands:
  hashcode <key>   : prints out the numeric hash code for the given key (does not change the hash map)
  put <key> <val>  : inserts the given key/val into the hash map, overwrites existing values if present
  get <key>        : prints the value associated with the given key or NOT FOUND
  print            : shows contents of the hashmap ordered by how they appear in the table
  structure        : prints detailed structure of the hash map
  clear            : reinitializes hash map to be empty with default size
  save <file>      : writes the contents of the hash map the given file
  load <file>      : clears the current hash map and loads the one in the given file
  next_prime <int> : if <int> is prime, prints it, otherwise finds the next prime and prints it
  expand           : expands memory size of hashmap to reduce its load factor
  quit             : exit the program
HM> print
HM> hashcode a
97
HM> hashcode A
65
HM> hashcode Aa
24897
HM> hashcode apple
435611005025
HM> hashcode banana
107126708920674
HM> get a
NOT FOUND
HM> get Aa
NOT FOUND
HM> get apple
NOT FOUND
HM> get banana
NOT FOUND
HM> quit
ENDOUT


((T++))
tnames[T]="get-single"
read  -r -d '' input[$T] <<"ENDIN"
print
put apple fruit
get apple
get banana
quit
ENDIN
#
read  -r -d '' output[$T] <<"ENDOUT"
Hashmap Demo
Commands:
  hashcode <key>   : prints out the numeric hash code for the given key (does not change the hash map)
  put <key> <val>  : inserts the given key/val into the hash map, overwrites existing values if present
  get <key>        : prints the value associated with the given key or NOT FOUND
  print            : shows contents of the hashmap ordered by how they appear in the table
  structure        : prints detailed structure of the hash map
  clear            : reinitializes hash map to be empty with default size
  save <file>      : writes the contents of the hash map the given file
  load <file>      : clears the current hash map and loads the one in the given file
  next_prime <int> : if <int> is prime, prints it, otherwise finds the next prime and prints it
  expand           : expands memory size of hashmap to reduce its load factor
  quit             : exit the program
HM> print
HM> put apple fruit
HM> get apple
FOUND: fruit
HM> get banana
NOT FOUND
HM> quit
ENDOUT

((T++))
tnames[T]="put3"
read  -r -d '' input[$T] <<"ENDIN"
put Kyle alive
put Kenny dead
put Stan alive
print
get Kyle
get Kenny
get Stan
get Cartman
get Token
quit
ENDIN
#
read  -r -d '' output[$T] <<"ENDOUT"
Hashmap Demo
Commands:
  hashcode <key>   : prints out the numeric hash code for the given key (does not change the hash map)
  put <key> <val>  : inserts the given key/val into the hash map, overwrites existing values if present
  get <key>        : prints the value associated with the given key or NOT FOUND
  print            : shows contents of the hashmap ordered by how they appear in the table
  structure        : prints detailed structure of the hash map
  clear            : reinitializes hash map to be empty with default size
  save <file>      : writes the contents of the hash map the given file
  load <file>      : clears the current hash map and loads the one in the given file
  next_prime <int> : if <int> is prime, prints it, otherwise finds the next prime and prints it
  expand           : expands memory size of hashmap to reduce its load factor
  quit             : exit the program
HM> put Kyle alive
HM> put Kenny dead
HM> put Stan alive
HM> print
        Kyle : alive
        Stan : alive
       Kenny : dead
HM> get Kyle
FOUND: alive
HM> get Kenny
FOUND: dead
HM> get Stan
FOUND: alive
HM> get Cartman
NOT FOUND
HM> get Token
NOT FOUND
HM> quit
ENDOUT

((T++))
tnames[T]="put-collisions"
read  -r -d '' input[$T] <<"ENDIN"
put B 1
put D 2
put N 3
print
get B
get D
get N
get C
get I
put A 4
put C 5
put I 6
put X 7
put W 8
print
get A
get B
get C
get D
get E
get I
get X
get W
get Z
quit
ENDIN
#
read  -r -d '' output[$T] <<"ENDOUT"
Hashmap Demo
Commands:
  hashcode <key>   : prints out the numeric hash code for the given key (does not change the hash map)
  put <key> <val>  : inserts the given key/val into the hash map, overwrites existing values if present
  get <key>        : prints the value associated with the given key or NOT FOUND
  print            : shows contents of the hashmap ordered by how they appear in the table
  structure        : prints detailed structure of the hash map
  clear            : reinitializes hash map to be empty with default size
  save <file>      : writes the contents of the hash map the given file
  load <file>      : clears the current hash map and loads the one in the given file
  next_prime <int> : if <int> is prime, prints it, otherwise finds the next prime and prints it
  expand           : expands memory size of hashmap to reduce its load factor
  quit             : exit the program
HM> put B 1
HM> put D 2
HM> put N 3
HM> print
           B : 1
           D : 2
           N : 3
HM> get B
FOUND: 1
HM> get D
FOUND: 2
HM> get N
FOUND: 3
HM> get C
NOT FOUND
HM> get I
NOT FOUND
HM> put A 4
HM> put C 5
HM> put I 6
HM> put X 7
HM> put W 8
HM> print
           A : 4
           B : 1
           C : 5
           W : 8
           D : 2
           N : 3
           I : 6
           X : 7
HM> get A
FOUND: 4
HM> get B
FOUND: 1
HM> get C
FOUND: 5
HM> get D
FOUND: 2
HM> get E
NOT FOUND
HM> get I
FOUND: 6
HM> get X
FOUND: 7
HM> get W
FOUND: 8
HM> get Z
NOT FOUND
HM> quit
ENDOUT

((T++))
tnames[T]="put3-structure"
read  -r -d '' input[$T] <<"ENDIN"
put B 1
put D 2
put N 3
print
get B
get D
get N
get C
get I
structure
quit
ENDIN
#
read  -r -d '' output[$T] <<"ENDOUT"
Hashmap Demo
Commands:
  hashcode <key>   : prints out the numeric hash code for the given key (does not change the hash map)
  put <key> <val>  : inserts the given key/val into the hash map, overwrites existing values if present
  get <key>        : prints the value associated with the given key or NOT FOUND
  print            : shows contents of the hashmap ordered by how they appear in the table
  structure        : prints detailed structure of the hash map
  clear            : reinitializes hash map to be empty with default size
  save <file>      : writes the contents of the hash map the given file
  load <file>      : clears the current hash map and loads the one in the given file
  next_prime <int> : if <int> is prime, prints it, otherwise finds the next prime and prints it
  expand           : expands memory size of hashmap to reduce its load factor
  quit             : exit the program
HM> put B 1
HM> put D 2
HM> put N 3
HM> print
           B : 1
           D : 2
           N : 3
HM> get B
FOUND: 1
HM> get D
FOUND: 2
HM> get N
FOUND: 3
HM> get C
NOT FOUND
HM> get I
NOT FOUND
HM> structure
item_count: 3
table_size: 5
load_factor: 0.6000
  0 : 
  1 : {(66) B : 1} 
  2 : 
  3 : {(68) D : 2} {(78) N : 3} 
  4 : 
HM> quit
ENDOUT

((T++))
tnames[T]="put-overwrite"
read  -r -d '' input[$T] <<"ENDIN"
put B 1
put D 2
put N 3
put A 4
put C 5
put I 6
put X 7
put W 8
structure
put B 11
put I 66
put A 44
put W 88
structure
get B
get D
get I
get W
get X
quit
ENDIN
#
read  -r -d '' output[$T] <<"ENDOUT"
Hashmap Demo
Commands:
  hashcode <key>   : prints out the numeric hash code for the given key (does not change the hash map)
  put <key> <val>  : inserts the given key/val into the hash map, overwrites existing values if present
  get <key>        : prints the value associated with the given key or NOT FOUND
  print            : shows contents of the hashmap ordered by how they appear in the table
  structure        : prints detailed structure of the hash map
  clear            : reinitializes hash map to be empty with default size
  save <file>      : writes the contents of the hash map the given file
  load <file>      : clears the current hash map and loads the one in the given file
  next_prime <int> : if <int> is prime, prints it, otherwise finds the next prime and prints it
  expand           : expands memory size of hashmap to reduce its load factor
  quit             : exit the program
HM> put B 1
HM> put D 2
HM> put N 3
HM> put A 4
HM> put C 5
HM> put I 6
HM> put X 7
HM> put W 8
HM> structure
item_count: 8
table_size: 5
load_factor: 1.6000
  0 : {(65) A : 4} 
  1 : {(66) B : 1} 
  2 : {(67) C : 5} {(87) W : 8} 
  3 : {(68) D : 2} {(78) N : 3} {(73) I : 6} {(88) X : 7} 
  4 : 
HM> put B 11
Overwriting previous key/val
HM> put I 66
Overwriting previous key/val
HM> put A 44
Overwriting previous key/val
HM> put W 88
Overwriting previous key/val
HM> structure
item_count: 8
table_size: 5
load_factor: 1.6000
  0 : {(65) A : 44} 
  1 : {(66) B : 11} 
  2 : {(67) C : 5} {(87) W : 88} 
  3 : {(68) D : 2} {(78) N : 3} {(73) I : 66} {(88) X : 7} 
  4 : 
HM> get B
FOUND: 11
HM> get D
FOUND: 2
HM> get I
FOUND: 66
HM> get W
FOUND: 88
HM> get X
FOUND: 7
HM> quit
ENDOUT

((T++))
tnames[T]="larger-structure"
read  -r -d '' input[$T] <<"ENDIN"
put Kyle alive
put Kenny dead
put Stan alive
print
structure
put Cartman jerk
put Timmy TIMMY!
put MrGarrison odd
put MrHat very-odd
put Butters lovable
put Chef disavowed
print
structure
quit
ENDIN
#
read  -r -d '' output[$T] <<"ENDOUT"
Hashmap Demo
Commands:
  hashcode <key>   : prints out the numeric hash code for the given key (does not change the hash map)
  put <key> <val>  : inserts the given key/val into the hash map, overwrites existing values if present
  get <key>        : prints the value associated with the given key or NOT FOUND
  print            : shows contents of the hashmap ordered by how they appear in the table
  structure        : prints detailed structure of the hash map
  clear            : reinitializes hash map to be empty with default size
  save <file>      : writes the contents of the hash map the given file
  load <file>      : clears the current hash map and loads the one in the given file
  next_prime <int> : if <int> is prime, prints it, otherwise finds the next prime and prints it
  expand           : expands memory size of hashmap to reduce its load factor
  quit             : exit the program
HM> put Kyle alive
HM> put Kenny dead
HM> put Stan alive
HM> print
        Kyle : alive
        Stan : alive
       Kenny : dead
HM> structure
item_count: 3
table_size: 5
load_factor: 0.6000
  0 : {(1701607755) Kyle : alive} 
  1 : {(1851880531) Stan : alive} 
  2 : {(521543771467) Kenny : dead} 
  3 : 
  4 : 
HM> put Cartman jerk
HM> put Timmy TIMMY!
HM> put MrGarrison odd
HM> put MrHat very-odd
HM> put Butters lovable
HM> put Chef disavowed
HM> print
        Kyle : alive
     Cartman : jerk
     Butters : lovable
        Stan : alive
       MrHat : very-odd
       Kenny : dead
  MrGarrison : odd
       Timmy : TIMMY!
        Chef : disavowed
HM> structure
item_count: 9
table_size: 5
load_factor: 1.8000
  0 : {(1701607755) Kyle : alive} {(31069370171154755) Cartman : jerk} {(32495402392778050) Butters : lovable} 
  1 : {(1851880531) Stan : alive} {(499848344141) MrHat : very-odd} 
  2 : {(521543771467) Kenny : dead} {(8316304022500241997) MrGarrison : odd} 
  3 : {(521526929748) Timmy : TIMMY!} 
  4 : {(1717921859) Chef : disavowed} 
HM> quit
ENDOUT

((T++))
tnames[T]="put3-EOF"
read  -r -d '' input[$T] <<"ENDIN"
put Kyle alive
put Kenny dead
put Stan alive
print
get Kyle
ENDIN
#
read  -r -d '' output[$T] <<"ENDOUT"
Hashmap Demo
Commands:
  hashcode <key>   : prints out the numeric hash code for the given key (does not change the hash map)
  put <key> <val>  : inserts the given key/val into the hash map, overwrites existing values if present
  get <key>        : prints the value associated with the given key or NOT FOUND
  print            : shows contents of the hashmap ordered by how they appear in the table
  structure        : prints detailed structure of the hash map
  clear            : reinitializes hash map to be empty with default size
  save <file>      : writes the contents of the hash map the given file
  load <file>      : clears the current hash map and loads the one in the given file
  next_prime <int> : if <int> is prime, prints it, otherwise finds the next prime and prints it
  expand           : expands memory size of hashmap to reduce its load factor
  quit             : exit the program
HM> put Kyle alive
HM> put Kenny dead
HM> put Stan alive
HM> print
        Kyle : alive
        Stan : alive
       Kenny : dead
HM> get Kyle
FOUND: alive
HM> 
ENDOUT

((T++))
tnames[T]="clear-put-clear"
read  -r -d '' input[$T] <<"ENDIN"
clear
print
structure
put Kyle alive
put Kenny dead
put Stan alive
put Cartman jerk
print
structure
clear
print
structure
put Timmy TIMMY!
put MrGarrison odd
put MrHat very-odd
put Butters lovable
put Chef disavowed
print
structure
clear
print
structure
ENDIN
#
read  -r -d '' output[$T] <<"ENDOUT"
Hashmap Demo
Commands:
  hashcode <key>   : prints out the numeric hash code for the given key (does not change the hash map)
  put <key> <val>  : inserts the given key/val into the hash map, overwrites existing values if present
  get <key>        : prints the value associated with the given key or NOT FOUND
  print            : shows contents of the hashmap ordered by how they appear in the table
  structure        : prints detailed structure of the hash map
  clear            : reinitializes hash map to be empty with default size
  save <file>      : writes the contents of the hash map the given file
  load <file>      : clears the current hash map and loads the one in the given file
  next_prime <int> : if <int> is prime, prints it, otherwise finds the next prime and prints it
  expand           : expands memory size of hashmap to reduce its load factor
  quit             : exit the program
HM> clear
HM> print
HM> structure
item_count: 0
table_size: 5
load_factor: 0.0000
  0 : 
  1 : 
  2 : 
  3 : 
  4 : 
HM> put Kyle alive
HM> put Kenny dead
HM> put Stan alive
HM> put Cartman jerk
HM> print
        Kyle : alive
     Cartman : jerk
        Stan : alive
       Kenny : dead
HM> structure
item_count: 4
table_size: 5
load_factor: 0.8000
  0 : {(1701607755) Kyle : alive} {(31069370171154755) Cartman : jerk} 
  1 : {(1851880531) Stan : alive} 
  2 : {(521543771467) Kenny : dead} 
  3 : 
  4 : 
HM> clear
HM> print
HM> structure
item_count: 0
table_size: 5
load_factor: 0.0000
  0 : 
  1 : 
  2 : 
  3 : 
  4 : 
HM> put Timmy TIMMY!
HM> put MrGarrison odd
HM> put MrHat very-odd
HM> put Butters lovable
HM> put Chef disavowed
HM> print
     Butters : lovable
       MrHat : very-odd
  MrGarrison : odd
       Timmy : TIMMY!
        Chef : disavowed
HM> structure
item_count: 5
table_size: 5
load_factor: 1.0000
  0 : {(32495402392778050) Butters : lovable} 
  1 : {(499848344141) MrHat : very-odd} 
  2 : {(8316304022500241997) MrGarrison : odd} 
  3 : {(521526929748) Timmy : TIMMY!} 
  4 : {(1717921859) Chef : disavowed} 
HM> clear
HM> print
HM> structure
item_count: 0
table_size: 5
load_factor: 0.0000
  0 : 
  1 : 
  2 : 
  3 : 
  4 : 
HM> 
ENDOUT

((T++))
tnames[T]="put3-save"
read  -r -d '' input[$T] <<"ENDIN"
put A 1
put E 2
put C 3
put D 4
save test-data/put3.tmp
quit
ENDIN
#
read  -r -d '' output[$T] <<"ENDOUT"
Hashmap Demo
Commands:
  hashcode <key>   : prints out the numeric hash code for the given key (does not change the hash map)
  put <key> <val>  : inserts the given key/val into the hash map, overwrites existing values if present
  get <key>        : prints the value associated with the given key or NOT FOUND
  print            : shows contents of the hashmap ordered by how they appear in the table
  structure        : prints detailed structure of the hash map
  clear            : reinitializes hash map to be empty with default size
  save <file>      : writes the contents of the hash map the given file
  load <file>      : clears the current hash map and loads the one in the given file
  next_prime <int> : if <int> is prime, prints it, otherwise finds the next prime and prints it
  expand           : expands memory size of hashmap to reduce its load factor
  quit             : exit the program
HM> put A 1
HM> put E 2
HM> put C 3
HM> put D 4
HM> save test-data/put3.tmp
HM> quit
ENDOUT
#
tfiles[T]="test-data/put3.tmp"
read  -r -d '' tfiles_expect[$T] <<"ENDOUT"
5 4
           A : 1
           C : 3
           D : 4
           E : 2
ENDOUT

((T++))
tnames[T]="put-many-save"
read  -r -d '' input[$T] <<"ENDIN"
put Kyle alive
put Kenny dead
put Stan alive
put Cartman jerk
put Timmy TIMMY!
put MrGarrison odd
put MrHat very-odd
put Butters lovable
put Chef disavowed
print
structure
save test-data/put-many.tmp
ENDIN
#
read  -r -d '' output[$T] <<"ENDOUT"
Hashmap Demo
Commands:
  hashcode <key>   : prints out the numeric hash code for the given key (does not change the hash map)
  put <key> <val>  : inserts the given key/val into the hash map, overwrites existing values if present
  get <key>        : prints the value associated with the given key or NOT FOUND
  print            : shows contents of the hashmap ordered by how they appear in the table
  structure        : prints detailed structure of the hash map
  clear            : reinitializes hash map to be empty with default size
  save <file>      : writes the contents of the hash map the given file
  load <file>      : clears the current hash map and loads the one in the given file
  next_prime <int> : if <int> is prime, prints it, otherwise finds the next prime and prints it
  expand           : expands memory size of hashmap to reduce its load factor
  quit             : exit the program
HM> put Kyle alive
HM> put Kenny dead
HM> put Stan alive
HM> put Cartman jerk
HM> put Timmy TIMMY!
HM> put MrGarrison odd
HM> put MrHat very-odd
HM> put Butters lovable
HM> put Chef disavowed
HM> print
        Kyle : alive
     Cartman : jerk
     Butters : lovable
        Stan : alive
       MrHat : very-odd
       Kenny : dead
  MrGarrison : odd
       Timmy : TIMMY!
        Chef : disavowed
HM> structure
item_count: 9
table_size: 5
load_factor: 1.8000
  0 : {(1701607755) Kyle : alive} {(31069370171154755) Cartman : jerk} {(32495402392778050) Butters : lovable} 
  1 : {(1851880531) Stan : alive} {(499848344141) MrHat : very-odd} 
  2 : {(521543771467) Kenny : dead} {(8316304022500241997) MrGarrison : odd} 
  3 : {(521526929748) Timmy : TIMMY!} 
  4 : {(1717921859) Chef : disavowed} 
HM> save test-data/put-many.tmp
HM> 
ENDOUT
#
tfiles[T]="test-data/put-many.tmp"
read  -r -d '' tfiles_expect[$T] <<"ENDOUT"
5 9
        Kyle : alive
     Cartman : jerk
     Butters : lovable
        Stan : alive
       MrHat : very-odd
       Kenny : dead
  MrGarrison : odd
       Timmy : TIMMY!
        Chef : disavowed
ENDOUT

((T++))
tnames[T]="save-load"
read  -r -d '' input[$T] <<"ENDIN"
put A 1
put E 2
put C 3
put D 4
save test-data/save-load.tmp
clear
print
load test-data/save-load.tmp
print
structure
get E
get R
get A
put R 5
put S 6
print structure
get R
get S
load test-data/save-load.tmp
print
structure
get R
get S
load test-data/not-there.tmp
print
quit
ENDIN
#
read  -r -d '' output[$T] <<"ENDOUT"
Hashmap Demo
Commands:
  hashcode <key>   : prints out the numeric hash code for the given key (does not change the hash map)
  put <key> <val>  : inserts the given key/val into the hash map, overwrites existing values if present
  get <key>        : prints the value associated with the given key or NOT FOUND
  print            : shows contents of the hashmap ordered by how they appear in the table
  structure        : prints detailed structure of the hash map
  clear            : reinitializes hash map to be empty with default size
  save <file>      : writes the contents of the hash map the given file
  load <file>      : clears the current hash map and loads the one in the given file
  next_prime <int> : if <int> is prime, prints it, otherwise finds the next prime and prints it
  expand           : expands memory size of hashmap to reduce its load factor
  quit             : exit the program
HM> put A 1
HM> put E 2
HM> put C 3
HM> put D 4
HM> save test-data/save-load.tmp
HM> clear
HM> print
HM> load test-data/save-load.tmp
HM> print
           A : 1
           C : 3
           D : 4
           E : 2
HM> structure
item_count: 4
table_size: 5
load_factor: 0.8000
  0 : {(65) A : 1} 
  1 : 
  2 : {(67) C : 3} 
  3 : {(68) D : 4} 
  4 : {(69) E : 2} 
HM> get E
FOUND: 2
HM> get R
NOT FOUND
HM> get A
FOUND: 1
HM> put R 5
HM> put S 6
HM> print
           A : 1
           C : 3
           R : 5
           D : 4
           S : 6
           E : 2
HM> structure
item_count: 6
table_size: 5
load_factor: 1.2000
  0 : {(65) A : 1} 
  1 : 
  2 : {(67) C : 3} {(82) R : 5} 
  3 : {(68) D : 4} {(83) S : 6} 
  4 : {(69) E : 2} 
HM> get R
FOUND: 5
HM> get S
FOUND: 6
HM> load test-data/save-load.tmp
HM> print
           A : 1
           C : 3
           D : 4
           E : 2
HM> structure
item_count: 4
table_size: 5
load_factor: 0.8000
  0 : {(65) A : 1} 
  1 : 
  2 : {(67) C : 3} 
  3 : {(68) D : 4} 
  4 : {(69) E : 2} 
HM> get R
NOT FOUND
HM> get S
NOT FOUND
HM> load test-data/not-there.tmp
ERROR: could not open file 'test-data/not-there.tmp'
load failed
HM> print
           A : 1
           C : 3
           D : 4
           E : 2
HM> quit
ENDOUT
#
tfiles[T]="test-data/save-load.tmp"
read  -r -d '' tfiles_expect[$T] <<"ENDOUT"
5 4
           A : 1
           C : 3
           D : 4
           E : 2
ENDOUT


((T++))
tnames[T]="prime-expand"
read  -r -d '' input[$T] <<"ENDIN"
next_prime 5
next_prime 6
next_prime 10
next_prime 25
next_prime 1024
put A 1
put B 2
put C 3
put D 4
put E 5
put F 6
put G 7
print
structure
expand
print
structure
expand
print
structure
clear
put Kyle alive
put Kenny dead
put Stan alive
put Cartman jerk
put Timmy TIMMY!
put MrGarrison odd
put MrHat very-odd
put Butters lovable
put Chef disavowed
print
structure
expand
print 
structure
put Token dude
put Wendy gal
put Jimmy crutches
put Damien evil
put Santa bad
put Jesus good
put Marvin starvin
print
structure
expand
print
structure
expand
print
structure
ENDIN
#
read  -r -d '' output[$T] <<"ENDOUT"
Hashmap Demo
Commands:
  hashcode <key>   : prints out the numeric hash code for the given key (does not change the hash map)
  put <key> <val>  : inserts the given key/val into the hash map, overwrites existing values if present
  get <key>        : prints the value associated with the given key or NOT FOUND
  print            : shows contents of the hashmap ordered by how they appear in the table
  structure        : prints detailed structure of the hash map
  clear            : reinitializes hash map to be empty with default size
  save <file>      : writes the contents of the hash map the given file
  load <file>      : clears the current hash map and loads the one in the given file
  next_prime <int> : if <int> is prime, prints it, otherwise finds the next prime and prints it
  expand           : expands memory size of hashmap to reduce its load factor
  quit             : exit the program
HM> next_prime 5
5
HM> next_prime 6
7
HM> next_prime 10
11
HM> next_prime 25
29
HM> next_prime 1024
1031
HM> put A 1
HM> put B 2
HM> put C 3
HM> put D 4
HM> put E 5
HM> put F 6
HM> put G 7
HM> print
           A : 1
           F : 6
           B : 2
           G : 7
           C : 3
           D : 4
           E : 5
HM> structure
item_count: 7
table_size: 5
load_factor: 1.4000
  0 : {(65) A : 1} {(70) F : 6} 
  1 : {(66) B : 2} {(71) G : 7} 
  2 : {(67) C : 3} 
  3 : {(68) D : 4} 
  4 : {(69) E : 5} 
HM> expand
HM> print
           B : 2
           C : 3
           D : 4
           E : 5
           F : 6
           G : 7
           A : 1
HM> structure
item_count: 7
table_size: 11
load_factor: 0.6364
  0 : {(66) B : 2} 
  1 : {(67) C : 3} 
  2 : {(68) D : 4} 
  3 : {(69) E : 5} 
  4 : {(70) F : 6} 
  5 : {(71) G : 7} 
  6 : 
  7 : 
  8 : 
  9 : 
 10 : {(65) A : 1} 
HM> expand
HM> print
           E : 5
           F : 6
           G : 7
           A : 1
           B : 2
           C : 3
           D : 4
HM> structure
item_count: 7
table_size: 23
load_factor: 0.3043
  0 : {(69) E : 5} 
  1 : {(70) F : 6} 
  2 : {(71) G : 7} 
  3 : 
  4 : 
  5 : 
  6 : 
  7 : 
  8 : 
  9 : 
 10 : 
 11 : 
 12 : 
 13 : 
 14 : 
 15 : 
 16 : 
 17 : 
 18 : 
 19 : {(65) A : 1} 
 20 : {(66) B : 2} 
 21 : {(67) C : 3} 
 22 : {(68) D : 4} 
HM> clear
HM> put Kyle alive
HM> put Kenny dead
HM> put Stan alive
HM> put Cartman jerk
HM> put Timmy TIMMY!
HM> put MrGarrison odd
HM> put MrHat very-odd
HM> put Butters lovable
HM> put Chef disavowed
HM> print
        Kyle : alive
     Cartman : jerk
     Butters : lovable
        Stan : alive
       MrHat : very-odd
       Kenny : dead
  MrGarrison : odd
       Timmy : TIMMY!
        Chef : disavowed
HM> structure
item_count: 9
table_size: 5
load_factor: 1.8000
  0 : {(1701607755) Kyle : alive} {(31069370171154755) Cartman : jerk} {(32495402392778050) Butters : lovable} 
  1 : {(1851880531) Stan : alive} {(499848344141) MrHat : very-odd} 
  2 : {(521543771467) Kenny : dead} {(8316304022500241997) MrGarrison : odd} 
  3 : {(521526929748) Timmy : TIMMY!} 
  4 : {(1717921859) Chef : disavowed} 
HM> expand
HM> print
     Cartman : jerk
     Butters : lovable
       Timmy : TIMMY!
        Kyle : alive
       MrHat : very-odd
       Kenny : dead
        Chef : disavowed
        Stan : alive
  MrGarrison : odd
HM> structure
item_count: 9
table_size: 11
load_factor: 0.8182
  0 : {(31069370171154755) Cartman : jerk} {(32495402392778050) Butters : lovable} {(521526929748) Timmy : TIMMY!} 
  1 : {(1701607755) Kyle : alive} 
  2 : 
  3 : {(499848344141) MrHat : very-odd} 
  4 : {(521543771467) Kenny : dead} 
  5 : {(1717921859) Chef : disavowed} 
  6 : {(1851880531) Stan : alive} 
  7 : 
  8 : 
  9 : {(8316304022500241997) MrGarrison : odd} 
 10 : 
HM> put Token dude
HM> put Wendy gal
HM> put Jimmy crutches
HM> put Damien evil
HM> put Santa bad
HM> put Jesus good
HM> put Marvin starvin
HM> print
     Cartman : jerk
     Butters : lovable
       Timmy : TIMMY!
       Santa : bad
        Kyle : alive
       Jimmy : crutches
       MrHat : very-odd
      Damien : evil
       Kenny : dead
       Token : dude
       Jesus : good
        Chef : disavowed
        Stan : alive
      Marvin : starvin
  MrGarrison : odd
       Wendy : gal
HM> structure
item_count: 16
table_size: 11
load_factor: 1.4545
  0 : {(31069370171154755) Cartman : jerk} {(32495402392778050) Butters : lovable} {(521526929748) Timmy : TIMMY!} {(418565218643) Santa : bad} 
  1 : {(1701607755) Kyle : alive} {(521526929738) Jimmy : crutches} 
  2 : 
  3 : {(499848344141) MrHat : very-odd} {(121381839528260) Damien : evil} 
  4 : {(521543771467) Kenny : dead} {(474147942228) Token : dude} {(495891735882) Jesus : good} 
  5 : {(1717921859) Chef : disavowed} 
  6 : {(1851880531) Stan : alive} {(121399237828941) Marvin : starvin} 
  7 : 
  8 : 
  9 : {(8316304022500241997) MrGarrison : odd} 
 10 : {(521375999319) Wendy : gal} 
HM> expand
HM> print
       Timmy : TIMMY!
       Santa : bad
      Marvin : starvin
      Damien : evil
       Wendy : gal
     Cartman : jerk
       Jimmy : crutches
       Kenny : dead
       Jesus : good
        Chef : disavowed
       MrHat : very-odd
     Butters : lovable
        Stan : alive
  MrGarrison : odd
        Kyle : alive
       Token : dude
HM> structure
item_count: 16
table_size: 23
load_factor: 0.6957
  0 : 
  1 : 
  2 : {(521526929748) Timmy : TIMMY!} {(418565218643) Santa : bad} {(121399237828941) Marvin : starvin} 
  3 : 
  4 : 
  5 : 
  6 : 
  7 : 
  8 : 
  9 : {(121381839528260) Damien : evil} 
 10 : 
 11 : 
 12 : {(521375999319) Wendy : gal} 
 13 : {(31069370171154755) Cartman : jerk} 
 14 : 
 15 : {(521526929738) Jimmy : crutches} 
 16 : 
 17 : {(521543771467) Kenny : dead} {(495891735882) Jesus : good} {(1717921859) Chef : disavowed} 
 18 : {(499848344141) MrHat : very-odd} 
 19 : {(32495402392778050) Butters : lovable} {(1851880531) Stan : alive} {(8316304022500241997) MrGarrison : odd} 
 20 : {(1701607755) Kyle : alive} 
 21 : 
 22 : {(474147942228) Token : dude} 
HM> expand
HM> print
       Jimmy : crutches
       Timmy : TIMMY!
        Kyle : alive
     Butters : lovable
     Cartman : jerk
        Stan : alive
       Wendy : gal
       Jesus : good
      Damien : evil
  MrGarrison : odd
       Kenny : dead
      Marvin : starvin
       Santa : bad
        Chef : disavowed
       MrHat : very-odd
       Token : dude
HM> structure
item_count: 16
table_size: 47
load_factor: 0.3404
  0 : {(521526929738) Jimmy : crutches} 
  1 : 
  2 : 
  3 : 
  4 : 
  5 : 
  6 : 
  7 : 
  8 : 
  9 : 
 10 : {(521526929748) Timmy : TIMMY!} 
 11 : 
 12 : 
 13 : 
 14 : 
 15 : {(1701607755) Kyle : alive} 
 16 : 
 17 : 
 18 : 
 19 : {(32495402392778050) Butters : lovable} 
 20 : {(31069370171154755) Cartman : jerk} {(1851880531) Stan : alive} 
 21 : 
 22 : 
 23 : {(521375999319) Wendy : gal} {(495891735882) Jesus : good} 
 24 : {(121381839528260) Damien : evil} 
 25 : 
 26 : {(8316304022500241997) MrGarrison : odd} 
 27 : 
 28 : 
 29 : 
 30 : 
 31 : {(521543771467) Kenny : dead} 
 32 : 
 33 : 
 34 : 
 35 : {(121399237828941) Marvin : starvin} 
 36 : 
 37 : 
 38 : 
 39 : 
 40 : {(418565218643) Santa : bad} 
 41 : 
 42 : 
 43 : {(1717921859) Chef : disavowed} 
 44 : {(499848344141) MrHat : very-odd} 
 45 : {(474147942228) Token : dude} 
 46 : 
HM> 
ENDOUT


((T++))
tnames[T]="stress"
read  -r -d '' input[$T] <<"ENDIN"
put Kyle alive
put Kenny dead
put Stan alive
put Cartman jerk
put Timmy TIMMY!
put MrGarrison odd
put MrHat very-odd
put Butters lovable
put Chef disavowed
structure
expand
structure
save test-data/stress1.tmp
put Token dude
put Wendy gal
put Jimmy crutches
put Damien evil
put Santa bad
put Jesus good
put Marvin starvin
put Kenny ALIVE
put MrHat MrStick
structure
expand
expand
structure
save test-data/stress2.tmp
load test-data/stress1.tmp
structure
get Santa
get Marvin
get Cartman
get MrHat
put Syndney Portier
put Robert Smith
expand
expand
expand
structure
get Cartman
get Robert
save test-data/stress3.tmp
load test-data/stress2.tmp
print
structure
get MrGarrison
get MrHat
get Kenny
get Santa
get Wendy
get Marvin
get Sydney
put Kenny dead
load test-data/stress3.tmp
get Kenny
structure
expand
structure
quit
ENDIN
#
read  -r -d '' output[$T] <<"ENDOUT"
Hashmap Demo
Commands:
  hashcode <key>   : prints out the numeric hash code for the given key (does not change the hash map)
  put <key> <val>  : inserts the given key/val into the hash map, overwrites existing values if present
  get <key>        : prints the value associated with the given key or NOT FOUND
  print            : shows contents of the hashmap ordered by how they appear in the table
  structure        : prints detailed structure of the hash map
  clear            : reinitializes hash map to be empty with default size
  save <file>      : writes the contents of the hash map the given file
  load <file>      : clears the current hash map and loads the one in the given file
  next_prime <int> : if <int> is prime, prints it, otherwise finds the next prime and prints it
  expand           : expands memory size of hashmap to reduce its load factor
  quit             : exit the program
HM> put Kyle alive
HM> put Kenny dead
HM> put Stan alive
HM> put Cartman jerk
HM> put Timmy TIMMY!
HM> put MrGarrison odd
HM> put MrHat very-odd
HM> put Butters lovable
HM> put Chef disavowed
HM> structure
item_count: 9
table_size: 5
load_factor: 1.8000
  0 : {(1701607755) Kyle : alive} {(31069370171154755) Cartman : jerk} {(32495402392778050) Butters : lovable} 
  1 : {(1851880531) Stan : alive} {(499848344141) MrHat : very-odd} 
  2 : {(521543771467) Kenny : dead} {(8316304022500241997) MrGarrison : odd} 
  3 : {(521526929748) Timmy : TIMMY!} 
  4 : {(1717921859) Chef : disavowed} 
HM> expand
HM> structure
item_count: 9
table_size: 11
load_factor: 0.8182
  0 : {(31069370171154755) Cartman : jerk} {(32495402392778050) Butters : lovable} {(521526929748) Timmy : TIMMY!} 
  1 : {(1701607755) Kyle : alive} 
  2 : 
  3 : {(499848344141) MrHat : very-odd} 
  4 : {(521543771467) Kenny : dead} 
  5 : {(1717921859) Chef : disavowed} 
  6 : {(1851880531) Stan : alive} 
  7 : 
  8 : 
  9 : {(8316304022500241997) MrGarrison : odd} 
 10 : 
HM> save test-data/stress1.tmp
HM> put Token dude
HM> put Wendy gal
HM> put Jimmy crutches
HM> put Damien evil
HM> put Santa bad
HM> put Jesus good
HM> put Marvin starvin
HM> put Kenny ALIVE
Overwriting previous key/val
HM> put MrHat MrStick
Overwriting previous key/val
HM> structure
item_count: 16
table_size: 11
load_factor: 1.4545
  0 : {(31069370171154755) Cartman : jerk} {(32495402392778050) Butters : lovable} {(521526929748) Timmy : TIMMY!} {(418565218643) Santa : bad} 
  1 : {(1701607755) Kyle : alive} {(521526929738) Jimmy : crutches} 
  2 : 
  3 : {(499848344141) MrHat : MrStick} {(121381839528260) Damien : evil} 
  4 : {(521543771467) Kenny : ALIVE} {(474147942228) Token : dude} {(495891735882) Jesus : good} 
  5 : {(1717921859) Chef : disavowed} 
  6 : {(1851880531) Stan : alive} {(121399237828941) Marvin : starvin} 
  7 : 
  8 : 
  9 : {(8316304022500241997) MrGarrison : odd} 
 10 : {(521375999319) Wendy : gal} 
HM> expand
HM> expand
HM> structure
item_count: 16
table_size: 47
load_factor: 0.3404
  0 : {(521526929738) Jimmy : crutches} 
  1 : 
  2 : 
  3 : 
  4 : 
  5 : 
  6 : 
  7 : 
  8 : 
  9 : 
 10 : {(521526929748) Timmy : TIMMY!} 
 11 : 
 12 : 
 13 : 
 14 : 
 15 : {(1701607755) Kyle : alive} 
 16 : 
 17 : 
 18 : 
 19 : {(32495402392778050) Butters : lovable} 
 20 : {(31069370171154755) Cartman : jerk} {(1851880531) Stan : alive} 
 21 : 
 22 : 
 23 : {(521375999319) Wendy : gal} {(495891735882) Jesus : good} 
 24 : {(121381839528260) Damien : evil} 
 25 : 
 26 : {(8316304022500241997) MrGarrison : odd} 
 27 : 
 28 : 
 29 : 
 30 : 
 31 : {(521543771467) Kenny : ALIVE} 
 32 : 
 33 : 
 34 : 
 35 : {(121399237828941) Marvin : starvin} 
 36 : 
 37 : 
 38 : 
 39 : 
 40 : {(418565218643) Santa : bad} 
 41 : 
 42 : 
 43 : {(1717921859) Chef : disavowed} 
 44 : {(499848344141) MrHat : MrStick} 
 45 : {(474147942228) Token : dude} 
 46 : 
HM> save test-data/stress2.tmp
HM> load test-data/stress1.tmp
HM> structure
item_count: 9
table_size: 11
load_factor: 0.8182
  0 : {(31069370171154755) Cartman : jerk} {(32495402392778050) Butters : lovable} {(521526929748) Timmy : TIMMY!} 
  1 : {(1701607755) Kyle : alive} 
  2 : 
  3 : {(499848344141) MrHat : very-odd} 
  4 : {(521543771467) Kenny : dead} 
  5 : {(1717921859) Chef : disavowed} 
  6 : {(1851880531) Stan : alive} 
  7 : 
  8 : 
  9 : {(8316304022500241997) MrGarrison : odd} 
 10 : 
HM> get Santa
NOT FOUND
HM> get Marvin
NOT FOUND
HM> get Cartman
FOUND: jerk
HM> get MrHat
FOUND: very-odd
HM> put Syndney Portier
HM> put Robert Smith
HM> expand
HM> expand
HM> expand
HM> structure
item_count: 11
table_size: 97
load_factor: 0.1134
  0 : 
  1 : 
  2 : 
  3 : {(521543771467) Kenny : dead} 
  4 : 
  5 : 
  6 : {(521526929748) Timmy : TIMMY!} 
  7 : 
  8 : 
  9 : 
 10 : 
 11 : 
 12 : 
 13 : 
 14 : 
 15 : {(32495402392778050) Butters : lovable} 
 16 : 
 17 : 
 18 : 
 19 : 
 20 : 
 21 : 
 22 : 
 23 : 
 24 : 
 25 : 
 26 : 
 27 : 
 28 : 
 29 : 
 30 : 
 31 : 
 32 : 
 33 : {(8316304022500241997) MrGarrison : odd} 
 34 : 
 35 : 
 36 : 
 37 : 
 38 : 
 39 : 
 40 : 
 41 : 
 42 : 
 43 : 
 44 : 
 45 : 
 46 : 
 47 : 
 48 : 
 49 : 
 50 : 
 51 : 
 52 : 
 53 : 
 54 : 
 55 : {(128034676043602) Robert : Smith} 
 56 : 
 57 : 
 58 : 
 59 : 
 60 : 
 61 : {(1717921859) Chef : disavowed} 
 62 : 
 63 : {(31069370171154755) Cartman : jerk} 
 64 : 
 65 : 
 66 : 
 67 : 
 68 : 
 69 : 
 70 : 
 71 : 
 72 : 
 73 : 
 74 : {(34169996987758931) Syndney : Portier} 
 75 : 
 76 : 
 77 : {(499848344141) MrHat : very-odd} 
 78 : 
 79 : 
 80 : 
 81 : 
 82 : 
 83 : 
 84 : {(1851880531) Stan : alive} 
 85 : 
 86 : 
 87 : 
 88 : 
 89 : 
 90 : 
 91 : 
 92 : 
 93 : 
 94 : 
 95 : 
 96 : {(1701607755) Kyle : alive} 
HM> get Cartman
FOUND: jerk
HM> get Robert
FOUND: Smith
HM> save test-data/stress3.tmp
HM> load test-data/stress2.tmp
HM> print
       Jimmy : crutches
       Timmy : TIMMY!
        Kyle : alive
     Butters : lovable
     Cartman : jerk
        Stan : alive
       Wendy : gal
       Jesus : good
      Damien : evil
  MrGarrison : odd
       Kenny : ALIVE
      Marvin : starvin
       Santa : bad
        Chef : disavowed
       MrHat : MrStick
       Token : dude
HM> structure
item_count: 16
table_size: 47
load_factor: 0.3404
  0 : {(521526929738) Jimmy : crutches} 
  1 : 
  2 : 
  3 : 
  4 : 
  5 : 
  6 : 
  7 : 
  8 : 
  9 : 
 10 : {(521526929748) Timmy : TIMMY!} 
 11 : 
 12 : 
 13 : 
 14 : 
 15 : {(1701607755) Kyle : alive} 
 16 : 
 17 : 
 18 : 
 19 : {(32495402392778050) Butters : lovable} 
 20 : {(31069370171154755) Cartman : jerk} {(1851880531) Stan : alive} 
 21 : 
 22 : 
 23 : {(521375999319) Wendy : gal} {(495891735882) Jesus : good} 
 24 : {(121381839528260) Damien : evil} 
 25 : 
 26 : {(8316304022500241997) MrGarrison : odd} 
 27 : 
 28 : 
 29 : 
 30 : 
 31 : {(521543771467) Kenny : ALIVE} 
 32 : 
 33 : 
 34 : 
 35 : {(121399237828941) Marvin : starvin} 
 36 : 
 37 : 
 38 : 
 39 : 
 40 : {(418565218643) Santa : bad} 
 41 : 
 42 : 
 43 : {(1717921859) Chef : disavowed} 
 44 : {(499848344141) MrHat : MrStick} 
 45 : {(474147942228) Token : dude} 
 46 : 
HM> get MrGarrison
FOUND: odd
HM> get MrHat
FOUND: MrStick
HM> get Kenny
FOUND: ALIVE
HM> get Santa
FOUND: bad
HM> get Wendy
FOUND: gal
HM> get Marvin
FOUND: starvin
HM> get Sydney
NOT FOUND
HM> put Kenny dead
Overwriting previous key/val
HM> load test-data/stress3.tmp
HM> get Kenny
FOUND: dead
HM> structure
item_count: 11
table_size: 97
load_factor: 0.1134
  0 : 
  1 : 
  2 : 
  3 : {(521543771467) Kenny : dead} 
  4 : 
  5 : 
  6 : {(521526929748) Timmy : TIMMY!} 
  7 : 
  8 : 
  9 : 
 10 : 
 11 : 
 12 : 
 13 : 
 14 : 
 15 : {(32495402392778050) Butters : lovable} 
 16 : 
 17 : 
 18 : 
 19 : 
 20 : 
 21 : 
 22 : 
 23 : 
 24 : 
 25 : 
 26 : 
 27 : 
 28 : 
 29 : 
 30 : 
 31 : 
 32 : 
 33 : {(8316304022500241997) MrGarrison : odd} 
 34 : 
 35 : 
 36 : 
 37 : 
 38 : 
 39 : 
 40 : 
 41 : 
 42 : 
 43 : 
 44 : 
 45 : 
 46 : 
 47 : 
 48 : 
 49 : 
 50 : 
 51 : 
 52 : 
 53 : 
 54 : 
 55 : {(128034676043602) Robert : Smith} 
 56 : 
 57 : 
 58 : 
 59 : 
 60 : 
 61 : {(1717921859) Chef : disavowed} 
 62 : 
 63 : {(31069370171154755) Cartman : jerk} 
 64 : 
 65 : 
 66 : 
 67 : 
 68 : 
 69 : 
 70 : 
 71 : 
 72 : 
 73 : 
 74 : {(34169996987758931) Syndney : Portier} 
 75 : 
 76 : 
 77 : {(499848344141) MrHat : very-odd} 
 78 : 
 79 : 
 80 : 
 81 : 
 82 : 
 83 : 
 84 : {(1851880531) Stan : alive} 
 85 : 
 86 : 
 87 : 
 88 : 
 89 : 
 90 : 
 91 : 
 92 : 
 93 : 
 94 : 
 95 : 
 96 : {(1701607755) Kyle : alive} 
HM> expand
HM> structure
item_count: 11
table_size: 197
load_factor: 0.0558
  0 : 
  1 : 
  2 : 
  3 : {(521543771467) Kenny : dead} 
  4 : 
  5 : 
  6 : 
  7 : 
  8 : 
  9 : 
 10 : 
 11 : {(521526929748) Timmy : TIMMY!} 
 12 : 
 13 : 
 14 : 
 15 : 
 16 : 
 17 : 
 18 : 
 19 : 
 20 : 
 21 : 
 22 : 
 23 : 
 24 : 
 25 : 
 26 : 
 27 : 
 28 : 
 29 : 
 30 : 
 31 : 
 32 : 
 33 : 
 34 : 
 35 : 
 36 : 
 37 : 
 38 : 
 39 : 
 40 : 
 41 : 
 42 : 
 43 : 
 44 : 
 45 : 
 46 : 
 47 : 
 48 : 
 49 : 
 50 : 
 51 : 
 52 : 
 53 : 
 54 : 
 55 : 
 56 : 
 57 : 
 58 : {(499848344141) MrHat : very-odd} 
 59 : {(128034676043602) Robert : Smith} 
 60 : 
 61 : 
 62 : 
 63 : 
 64 : 
 65 : 
 66 : 
 67 : 
 68 : 
 69 : 
 70 : 
 71 : 
 72 : 
 73 : 
 74 : 
 75 : 
 76 : 
 77 : {(34169996987758931) Syndney : Portier} 
 78 : 
 79 : 
 80 : 
 81 : 
 82 : {(8316304022500241997) MrGarrison : odd} 
 83 : 
 84 : 
 85 : 
 86 : 
 87 : 
 88 : 
 89 : 
 90 : 
 91 : 
 92 : {(32495402392778050) Butters : lovable} 
 93 : 
 94 : 
 95 : 
 96 : 
 97 : 
 98 : 
 99 : 
100 : 
101 : 
102 : 
103 : 
104 : {(1717921859) Chef : disavowed} 
105 : 
106 : 
107 : 
108 : 
109 : 
110 : 
111 : 
112 : 
113 : 
114 : 
115 : 
116 : 
117 : 
118 : 
119 : 
120 : 
121 : 
122 : 
123 : 
124 : 
125 : 
126 : 
127 : 
128 : 
129 : 
130 : 
131 : 
132 : 
133 : 
134 : 
135 : 
136 : 
137 : 
138 : 
139 : 
140 : 
141 : 
142 : 
143 : 
144 : 
145 : 
146 : 
147 : 
148 : 
149 : 
150 : 
151 : 
152 : 
153 : 
154 : 
155 : {(1851880531) Stan : alive} 
156 : 
157 : 
158 : 
159 : 
160 : 
161 : {(1701607755) Kyle : alive} 
162 : 
163 : 
164 : 
165 : 
166 : 
167 : 
168 : {(31069370171154755) Cartman : jerk} 
169 : 
170 : 
171 : 
172 : 
173 : 
174 : 
175 : 
176 : 
177 : 
178 : 
179 : 
180 : 
181 : 
182 : 
183 : 
184 : 
185 : 
186 : 
187 : 
188 : 
189 : 
190 : 
191 : 
192 : 
193 : 
194 : 
195 : 
196 : 
HM> quit
ENDOUT