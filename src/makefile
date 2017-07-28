CC=gcc
CFLAGS=-std=c99 -g -Wall

objects=main.o
libDir=../lib
libs=CLogger

main : $(objects)
	$(CC) -o textManip $(CFLAGS) -L. -lCLogger main.c

.PHONY : clean
clean : 
	rm textManip $(objects)
