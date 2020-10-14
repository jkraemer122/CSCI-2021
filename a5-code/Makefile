CFLAGS = -Wall -Werror -g -Og
CC     = gcc $(CFLAGS)
SHELL  = /bin/bash
CWD    = $(shell pwd | sed 's/.*\///g')

PROGRAMS = \
	el_malloc.o \
	el_demo \
	patchsym \

all : $(PROGRAMS)

clean :
	rm -f $(PROGRAMS) *.o vgcore.* a.out

AN=a5
zip :
	rm -f $(AN)-code.zip
	cd .. && zip "$(CWD)/$(AN)-code.zip" -r "$(CWD)"
	@echo Zip created in $(AN)-code.zip
	@if (( $$(stat -c '%s' $(AN)-code.zip) > 10*(2**20) )); then echo "WARNING: $(AN)-code.zip seems REALLY big, check there are no abnormally large test files"; du -h $(AN)-code.zip; fi

el_malloc.o : el_malloc.c el_malloc.h
	$(CC) -c $<

el_demo : el_demo.c el_malloc.o
	$(CC) -o $@ $^

patchsym : patchsym.c
	$(CC) -o $@ $^

# TESTING TARGETS
test: test-p1 test-p2

test-p1: el_malloc.o
	@chmod u+x ./test_el_malloc.sh
	./test_el_malloc.sh

test-p2: patchsym
	@chmod u+x ./test_patchsym.sh
	./test_patchsym.sh

clean-tests : clean
	rm -f test-data/*

