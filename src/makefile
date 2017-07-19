CC=gcc
CFLAGS=-std=c99 -g

objects=main.o

main : $(objects)
	$(CC) -o textManip $(CFLAGS) main.c


.PHONY : clean
clean : 
	rm textManip $(objects)
