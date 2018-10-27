#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include "constants.h"
#include "base64.h"

int base64_encode(int infd, int outfd){
    unsigned char buffer[BLOCK_SIZE_INPUT_ENCODING];
    unsigned char encodedOutput[BLOCK_SIZE_OUTPUT_ENCODING];
    int charsInLine = 0;
    int length = read(infd,buffer,BLOCK_SIZE_INPUT_ENCODING);
    encodedOutput[4] = '\0';

    while ( length > 0) {
        encodeChars(buffer,encodedOutput,length);
        write(outfd,encodedOutput,BLOCK_SIZE_OUTPUT_ENCODING);
        charsInLine += BLOCK_SIZE_OUTPUT_ENCODING;

        if (exceedsLineSize(charsInLine) == 1) {
            write(outfd,"\n",1);
            charsInLine = 0;
	    }

        length = read(infd,buffer,BLOCK_SIZE_INPUT_ENCODING);
    }

	return 0; 
}

/*
int exceedsLineSize(int charsInLine) {
    return (charsInLine == 76) ? 1:0;
}
*/

/*
void condition_1_encode(unsigned const char input[], unsigned char output[]){
    output[0] = encodingTable[input[0] >> 2];
    output[1] = encodingTable[((input[0] & 0x03) << 4) + (input[1] >> 4)];
    output[2] = encodingTable[((input[1] & 0x0f) << 2) + (input[2] >> 6)];
    output[3] = encodingTable[input[2] & 0x3F];
}
*/

/*
void condition_2_encode(unsigned const char input[], unsigned char output[]){
    output[0] = encodingTable[input[0] >> 2];
    output[1] = encodingTable[((input[0] & 0x03) << 4) + (input[1] >> 4)];
    output[2] = encodingTable[(input[1] & 0x0F) << 2 ];
    output[3] = '=';
}
*/

/*
void condition_3_encode(unsigned const char input[], unsigned char output[]){
    output[0] = encodingTable[input[0] >> 2];
    output[1] = encodingTable[(input[0] & 0x03) << 4];
    output[2] = '=';
    output[3] = '=';
}
*/

int encodeChars(unsigned const char input[], unsigned char output[], int length) {
    if (length == 3) {
    	condition_1_encode(input, output);
    } else if (length == 2) {
    	condition_2_encode(input, output);
    } else if (length == 1) {
    	condition_3_encode(input, output);
    }
    return 4;
}

int base64_decode(int infd, int outfd) {
	unsigned char buffer[BLOCK_SIZE_INPUT_DECODING];
	unsigned char decoded_output[BLOCK_SIZE_OUTPUT_DECODING];
	int charsDecoded = 0;
	int charsInLine = 0;
	int length = 0;

	length = read(infd,buffer,BLOCK_SIZE_INPUT_DECODING);

	while ( length > 0 ) {
		if((charsDecoded = decodeChars(buffer,decoded_output)) < 0){
			fprintf(stderr,"Error decoding characters");
			return -1;
		}

		write(outfd, decoded_output, charsDecoded);
		charsInLine += BLOCK_SIZE_INPUT_DECODING;
		
		if (exceedsLineSize(charsInLine) == 1) {
			length = read(infd,buffer,1);
			charsInLine = 0;
		} 

		length = read(infd,buffer,BLOCK_SIZE_INPUT_DECODING);
	}

	return 0;
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
