#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "constants.h"
#include "decode.h"

void decode(FILE * input, char * path, FILE * output, char * path_out){
	unsigned char buffer[BLOCK_SIZE_INPUT_DECODING];
	unsigned char decoded_output[BLOCK_SIZE_INPUT_DECODING];
	decoded_output[4] = '\0';
	int chars_read = 0, length;

    if(path) input = fopen(path, "r");

    if(path_out) output = fopen(path_out, "w");

    if (!input) {
        fprintf(stderr, "Can't open the file %s\n", path);
        exit(1);
    }

    while(!feof(input)){
        length = readInput(input, buffer,BLOCK_SIZE_INPUT_DECODING,1);
        chars_read += length;
        if (length && (length < BLOCK_SIZE_INPUT_DECODING)) {
        	fprintf(stderr, "Can't finish decoding file %s: wrong length\n", path);
        	break;
        }
        if(length > 0){
            decodeChars(buffer, decoded_output);
        	write_partial(decoded_output, output, path_out);
        } 
    }

    fclose(output);
}

int decodeChars(unsigned const char input[], unsigned char output[]){
	char decodedOutput[4] = {};
	decodedOutput[0] = decodingTable[input[0]];
	decodedOutput[1] = decodingTable[input[1]];
	decodedOutput[2] = decodingTable[input[2]];
	decodedOutput[3] = decodingTable[input[3]];

	output[0] = ((decodedOutput[0] << 2) | (decodedOutput[1] >> 4));
	if(decodedOutput[2] == EQUALS && decodedOutput[3] == EQUALS){
		output[1] = '\0';
		output[2] = '\0';
		return 1;	
	}
	output[1] = (((decodedOutput[1] & 15) << 4) | ((decodedOutput[2] >> 2) & 15));
	if(decodedOutput[3] == EQUALS){
		output[2] = '\0';
		return 2;
	}
	output[2] = (((decodedOutput[2] & 255) << 6) | ((decodedOutput[3]) & 63));
	return 3;
}

int isValid(unsigned char currentChar){
	int i = 0;
	while (i < strlen((const char*)encodingTable)){
		if((currentChar == '=')||(encodingTable[i] == currentChar)){
			return 1;
		}
		i++;
	}
	return 0;
}