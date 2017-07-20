CC=gcc
CFLAGS=-std=c99 -g

objects=main.o
libDir=../lib
libs=CLogger

main : $(objects)
	$(CC) -o textManip $(CFLAGS) main.o -L. -lCLogger


.PHONY : clean
clean : 
	rm textManip $(objects)
