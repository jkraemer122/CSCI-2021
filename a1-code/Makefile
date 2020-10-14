CFLAGS = -Wall -g -lm
CC     = gcc $(CFLAGS)
SHELL  = /bin/bash
CWD    = $(shell pwd | sed 's/.*\///g')

PROGRAMS = \
	save_deltas \
	deltas_main \
	print_graph_demo \
	graph_file \
	hash_main \

all : $(PROGRAMS)

AN=a1
zip :
	rm -f $(AN)-code.zip
	cd .. && zip "$(CWD)/$(AN)-code.zip" -r "$(CWD)"
	@echo Zip created in $(AN)-code.zip
	@if (( $$(stat -c '%s' $(AN)-code.zip) > 10*(2**20) )); then echo "WARNING: $(AN)-code.zip seems REALLY big, check there are no abnormally large test files"; du -h $(AN)-code.zip; fi


clean :
	rm -f $(PROGRAMS) *.o

# int delta problem
deltas_main.o : deltas_main.c deltas.h
	$(CC) -c $<

deltas_main : deltas_main.o read_deltas.o
	$(CC) -o $@ $^

read_deltas.o : read_deltas.c deltas.h
	$(CC) -c $<

save_deltas.o : save_deltas.c deltas.h
	$(CC) -c $<

save_deltas : save_deltas.o 
	$(CC) -o $@ $^

# print_graph
print_graph.o : print_graph.c
	$(CC) -c $<

print_graph_demo.o : print_graph_demo.c
	$(CC) -c $<

print_graph_demo : print_graph_demo.o print_graph.o
	$(CC) -o $@ $^

graph_file.o : graph_file.c
	$(CC) -c $<

graph_file : graph_file.o print_graph.o read_deltas.o
	$(CC) -o $@ $^


# hash problem
hash_main : hash_main.o hash_funcs.o
	$(CC) -o $@ $^

hash_main.o : hash_main.c hashmap.h
	$(CC) -c $<

hash_funcs.o : hash_funcs.c hashmap.h
	$(CC) -c $<


# Testing Targets
VALGRIND = valgrind --leak-check=full --show-leak-kinds=all

test : test-p1 test-p2 test-p3

test-p1 : test-p1-norm test-p1-valg

test-p1-norm : test_read_deltas
	@printf "===P1 Normal tests for read_deltas() via test_read_deltas===\n"
	./test_read_deltas
	@printf "\n"

test-p1-valg : test_read_deltas
	@printf "\n"
	@printf "===P1 Valgrind tests for read_deltas() via test_read_deltas===\n"
	@echo $(VALGRIND) ./test_read_deltas
	@$(VALGRIND) ./test_read_deltas >& test-data/p1-valgrind.tmp
	@chmod u+rx ./test_check_valgrind.sh
	@./test_check_valgrind.sh 5 'PROBLEM 1 Valgrind Memory Checks' test-data/p1-valgrind.tmp
	@printf "\n"


test_read_deltas.o : test_read_deltas.c deltas.h
	$(CC) -c $<

test_read_deltas : test_read_deltas.o read_deltas.o
	$(CC) -o $@ $^

test-p2 : test-p2a test-p2b

test-p2a : print_graph_demo graph_file save_deltas
	@printf "===TESTS for P2A===\n"
	@printf "Testing print_graph() via print_graph_demo\n"
	@chmod u+rx ./test_print_graph.sh
	./test_print_graph.sh

test-p2b : print_graph_demo graph_file save_deltas
	@printf "===TESTS for P2B===\n"
	@printf "Testing graph_file\n"
	@chmod u+rx ./test_graph_file.sh
	./test_graph_file.sh


test-p3 : hash_main
	@printf "===TESTS for P3===\n"
	@chmod u+rx ./test_hash_main.sh
	./test_hash_main.sh

clean-tests :
	rm -f test_read_deltas
	rm -f test-data/*.tmp test-data/*.tree
