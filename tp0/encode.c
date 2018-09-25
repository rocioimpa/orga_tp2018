#include <stdlib.h>
#include <stdio.h>
#include "encode.h"
#include "constants.h"


void encode(FILE*input,char*path,FILE * output, char * path_out) {
    unsigned char buffer[BLOCK_SIZE_INPUT_ENCODING];
    unsigned char encodedOutput[BLOCK_SIZE_INPUT_DECODING];
    int length;
    int charsInLine = 0;

    if(path) input = fopen(path, "r");

    if(path_out) output = fopen(path_out, "w");

    if (!input) {
        fprintf(stderr, "Can't open the file %s\n", path);
        exit(1);
    }

    while (!feof(input)) {

        length = readInput(input, buffer,BLOCK_SIZE_INPUT_ENCODING,0);
        
        if (length > 0) {
            encodeChars(buffer, encodedOutput, length);
            write_partial(encodedOutput, output, path_out);
            charsInLine += 4;
            if(exceedsLineSize(charsInLine) == 1){
                charsInLine = 0;
                encodedOutput[0] = '\n';
                encodedOutput[1] = '\0';
                write_partial(encodedOutput, output, path_out);
            }
        }    


    }
}

int exceedsLineSize(int charsInLine) {
    return (charsInLine == 76) ? 1:0;
}

void encodeChars(unsigned const char input[], unsigned char output[], int length) {
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
}
