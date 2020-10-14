CFLAGS = -Wall -Werror -g 
CC     = gcc $(CFLAGS)
SHELL  = /bin/bash
CWD    = $(shell pwd | sed 's/.*\///g')

PROGRAMS = \
	batt_main \



all : $(PROGRAMS)

clean :
	rm -f $(PROGRAMS) hybrid_main *.o

AN=a3
zip :
	rm -f $(AN)-code.zip
	cd .. && zip "$(CWD)/$(AN)-code.zip" -r "$(CWD)"
	@echo Zip created in $(AN)-code.zip
	@if (( $$(stat -c '%s' $(AN)-code.zip) > 10*(2**20) )); then echo "WARNING: $(AN)-code.zip seems REALLY big, check there are no abnormally large test files"; du -h $(AN)-code.zip; fi

# battery problem
batt_main : batt_main.o batt_sim.o batt_update_asm.o 
	$(CC) -o $@ $^

batt_main.o : batt_main.c batt.h
	$(CC) -c $<

batt_sim.o : batt_sim.c batt.h
	$(CC) -c $<

# required assembly implementation
batt_update_asm.o : batt_update_asm.s batt.h
	$(CC) -c $<

# C version of functions
batt_update.o : batt_update.c batt.h
	$(CC) -c $<

# main which uses both assmebly and C update functions for incremental
# testing
hybrid_main : batt_main.o batt_sim.o batt_update_asm.o batt_update.o
	$(CC) -o $@ $^

################################################################################
# Testing Targets
VALGRIND = valgrind --leak-check=full --show-leak-kinds=all

test: test-p1

test-p1: test-p1a test-p1b

test-p1a: test_batt_update
	@chmod u+rx test_batt_update.sh
	./test_batt_update.sh ./test_batt_update

test-p1b : batt_main
	@chmod u+rx test_batt_main.sh
	./test_batt_main.sh ./batt_main

test_batt_update : test_batt_update.o batt_sim.o batt_update_asm.o
	$(CC) -o $@ $^

clean-tests : clean
	rm -f test-data/*.tmp test_batt_update test_hybrid

# hybrid test program
test_hybrid : test_batt_update.o batt_sim.o batt_update_asm.o batt_update.o
	$(CC) -o $@ $^

# test hybrid for incremental work
test-hybrid : test_hybrid hybrid_main
	@printf "===TESTS for Hybrid===\n"
	@printf "Running binary tests for hybrid\n"
	@chmod u+rx test_batt_update.sh
	./test_batt_update.sh ./test_hybrid
	@printf "\n"
	@printf "Running shell tests for hybrid_main\n"
	./test_batt_main.sh ./hybrid_main
