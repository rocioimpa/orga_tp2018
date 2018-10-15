#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include "constants.h"
#include "base64.h"

int base64_encode(int infd, int outfd){
	printf("File descriptor input is : %d\n", infd);
	printf("File descriptor output is : %d\n", outfd);
	ssize_t aa = write(outfd,"test",4);
	return 0;
}

int base64_decode(int infd, int outfd){
	printf("File descriptor input is : %d\n", infd);
	printf("File descriptor output is : %d\n", outfd);
	return 0;
}

void decode(FILE * input, char * path, FILE * output, char * path_out){
	unsigned char buffer[BLOCK_SIZE_INPUT_DECODING+1];
	unsigned char decoded_output[BLOCK_SIZE_INPUT_DECODING+1];
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

void encode(FILE*input,char*path,FILE * output, char * path_out) {
    unsigned char buffer[BLOCK_SIZE_INPUT_ENCODING+1];
    unsigned char encodedOutput[BLOCK_SIZE_OUTPUT_ENCODING];
    encodedOutput[4] = '\0';
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

int readInput(FILE* input, unsigned char* buff, int buffSize, int decode) {
    int i;
    int currentChar;
    for (i = 0; i < buffSize; ++i) {
        currentChar = fgetc(input);

        if (!ferror(input)) {
            if (currentChar != EOF) {
                if(!decode) buff[i] = currentChar;
                else{
                    if (currentChar == '\n') {
                        i--;
                        continue;
                    }
                    if(isValid(currentChar)==0){
                        fprintf(stderr, "Unable to decode: invalid character. Program will terminate.\n");
                        exit(1);                        
                    }
                    buff[i] = currentChar;
                }
            } else {
                return i;
            }
        } else {
            fprintf(stderr, "An error occurred when reading input.");
            exit(1);
        }
    }
    buff[buffSize] = '\0';
    return buffSize;
}

void write_partial(unsigned char* processedOutput, FILE* output, char* path) {

    if (output != NULL) {
        while (*processedOutput != '\0'){
            if (!(fprintf(output,"%c",*processedOutput))) {
                printf("%c\n", *processedOutput);
                fprintf(stderr, "Error when writing output to file %s\n", path);
                exit(1);
            }
            ++processedOutput;
        }
    } else {
        fprintf(stderr, "Unable to open or create output file %s\n", path);
        exit(1);
    }
}