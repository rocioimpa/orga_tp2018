#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include "constants.h"
#include "base64.h"


/*int base64_encode(int infd, int outfd){
    unsigned char buffer[BLOCK_SIZE_INPUT_ENCODING];
    unsigned char encodedOutput[BLOCK_SIZE_OUTPUT_ENCODING];
    int charsInLine = 0;
    int length = read(infd,buffer,BLOCK_SIZE_INPUT_ENCODING);
    encodedOutput[4] = '\0';

    while ( length > 0) {
        encode_chars(buffer,encodedOutput,length);
        write(outfd,encodedOutput,BLOCK_SIZE_OUTPUT_ENCODING);
        charsInLine += BLOCK_SIZE_OUTPUT_ENCODING;

        if (exceedsLineSize(charsInLine) == 1) {
            write(outfd,"\n",1);
            charsInLine = 0;
	    }

        length = read(infd,buffer,BLOCK_SIZE_INPUT_ENCODING);
    }

	return 0; 
}*/


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


/*void condition_2_encode(unsigned const char input[], unsigned char output[]){
    output[0] = encodingTable[input[0] >> 2];
    output[1] = encodingTable[((input[0] & 0x03) << 4) + (input[1] >> 4)];
    output[2] = encodingTable[(input[1] & 0x0F) << 2 ];
    output[3] = '=';
}*/


/*
void condition_3_encode(unsigned const char input[], unsigned char output[]){
    output[0] = encodingTable[input[0] >> 2];
    output[1] = encodingTable[(input[0] & 0x03) << 4];
    output[2] = '=';
    output[3] = '=';
}
*/

/*
int encode_chars(unsigned const char input[], unsigned char output[], int length) {
    if (length == 3) {
    	condition_1_encode(input, output);
    } else if (length == 2) {
    	condition_2_encode(input, output);
    } else if (length == 1) {
    	condition_3_encode(input, output);
    }
    return 4;
}
*/

/*
int base64_decode(int infd, int outfd) {
	unsigned char buffer[BLOCK_SIZE_INPUT_DECODING];
	unsigned char decoded_output[BLOCK_SIZE_OUTPUT_DECODING];
	int charsDecoded = 0;
	int charsInLine = 0;
	int length = 0;

	length = read(infd,buffer,BLOCK_SIZE_INPUT_DECODING);

	while ( length > 0 ) {
		if((charsDecoded = decode_chars(buffer,decoded_output)) < 0){
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
*/

/*void getDecodedOutput(char decodedOutput[], unsigned const char input[], unsigned char output[]){
	decodedOutput[0] = decodingTable[input[0]];
	decodedOutput[1] = decodingTable[input[1]];
	decodedOutput[2] = decodingTable[input[2]];
	decodedOutput[3] = decodingTable[input[3]];
}*/

/*char getOutput0(char decodedOutput[]){
	return ((decodedOutput[0] << 2) | (decodedOutput[1] >> 4));
}*/

/*char getOutput1(char decodedOutput[]){
	return (((decodedOutput[1] & 15) << 4) | ((decodedOutput[2] >> 2) & 15));
}*/

/*char getOutput2(char decodedOutput[]){
	return (((decodedOutput[2] & 255) << 6) | ((decodedOutput[3]) & 63));
}*/

/*int addZerosToOutput(char output[], int n){
	if(n==1){
		output[2] = '\0';
		return 2;
	}
	output[1] = '\0';
	output[2] = '\0';
	return 1;
}*/

/*
int decode_chars(unsigned const char input[], unsigned char output[]){
	char decodedOutput[4] = {};
	getDecodedOutput(decodedOutput,input,output);

	output[0] = getOutput0(decodedOutput);
	if(decodedOutput[2] == EQUALS && decodedOutput[3] == EQUALS){
		return addZerosToOutput(output,2);
	}
	output[1] = getOutput1(decodedOutput);
	if(decodedOutput[3] == EQUALS){
		return addZerosToOutput(output,1);
	}
	output[2] = getOutput2(decodedOutput);
	return 3;
}
*/
