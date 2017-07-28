#include "main.h"

int main(int argc, const char * argv[]){
	openCLogger();

	FILE *input = fopen(argv[1], "r");
	if(input== NULL){
		clogger("File not found...\n");
		return 0;
	}

	char * temp = malloc(sizeof(char)*64);
	strcat(temp, "Found file: ");
	strcat(temp, argv[1]);
	clogger(temp);
	clogger("Beginning analysis of document...");
	free(temp);

	int counter = 0;

	

	closeCLogger();
	return 1;
}