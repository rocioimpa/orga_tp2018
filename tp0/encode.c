#include <stdlib.h>
#include <stdio.h>
#include "encode.h"
#include "constants.h"


unsigned char* encode(FILE*input,char*path) {
    unsigned char buffer[BLOCK_SIZE_INPUT_ENCODING];
    unsigned char* encodedOutput = malloc(BLOCK_SIZE_OUTPUT * sizeof(char));
    int length;
    int encodedChars = 0;
    int amountOfNewLines = 0;

    if(path) input = fopen(path, "r");

    if (!input) {
        fprintf(stderr, "Can't open the file %s\n", path);
        exit(1);
    }

    while (!feof(input)) {
        if (encodedChars + 4 >= sizeof(encodedOutput)) {
            encodedOutput = realloc(encodedOutput, BLOCK_SIZE_OUTPUT * ((encodedChars / BLOCK_SIZE_OUTPUT) + 1) * sizeof(char));
        }

        length = readInput(input, buffer,BLOCK_SIZE_INPUT_ENCODING);
        
	if (length > 0) {
            encodedChars += encodeChars(buffer, encodedOutput + encodedChars, length);
            amountOfNewLines += 4;
            if(exceedsLineSize(amountOfNewLines) == 1){
                amountOfNewLines = 0;
                encodedOutput[encodedChars] = '\n';
                encodedChars++;
            }
        }    
	
	if (amountOfNewLines != 0) {
        encodedOutput[encodedChars] = '\n';
    	}

    }
    return encodedOutput;
}

int exceedsLineSize(int amountOfNewLines) {
    return (amountOfNewLines == 76) ? 1:0;
}

int encodeChars(unsigned const char input[], unsigned char output[], int length) {
    if (length == 3) {
        output[0] = encodingTable[input[0] >> 2];
        output[1] = encodingTable[((input[0] & 0x03) << 4) + (input[1] >> 4)];
        output[2] = encodingTable[((input[1] & 0x0f) << 2) + (input[2] >> 6)];
        output[3] = encodingTable[input[2] & 0x3F];
    } else if (length == 2) {
        output[0] = encodingTable[input[0] >> 2];
        output[1] = encodingTable[((input[0] & 0x03) << 4) + (input[1] >> 4)];
        output[2] = encodingTable[(input[1] & 0x0F) << 2 ];
        output[3] = '=';
    } else if (length == 1) {
        output[0] = encodingTable[input[0] >> 2];
        output[1] = encodingTable[(input[0] & 0x03) << 4];
        output[2] = '=';
        output[3] = '=';
    }
    return 4;
}
