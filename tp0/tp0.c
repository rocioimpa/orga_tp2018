#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <unistd.h>
#include <getopt.h>
#include <memory.h>
#include "encode.h"
#include "decode.h"
#include "constants.h"

typedef struct receivedParameters {
    FILE* output;
    FILE* input;
    char* path_to_output;
    char* path_to_input;
    char* action;
} parameters_t;

const unsigned char encodingTable[]={"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"};
const char decodingTable[]={
                                    -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-2,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
                                    -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,62,-1,-1,-1,63,52,53,
                                    54,55,56,57,58,59,60,61,-1,-1,-1,-3,-1,-1,-1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9,
                                    10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,-1,-1,-1,-1,-1,-1,26,27,28,
                                    29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,-1,-1,
                                    -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
                                    -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
                                    -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
                                    -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
                                    -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
                                    -1,-1,-1,-1,-1,-1
                                };

static struct option long_options[] =
        {
                {"input",required_argument,NULL,'i'},
                {"output",required_argument,NULL,'o'},
                {"action",required_argument,NULL,'a'},
                {"help",no_argument,NULL,'h'},
                {"version",no_argument,NULL,'V'},
                {NULL, 0, NULL, 0}
        };

void process(parameters_t);
parameters_t getParams(int, char **);

int checkForPath(char* path, FILE* file, char** path_to_save, char* type){
    if (path == NULL) return ERR_EMPTY;

    if(checkForInvalidCharacters(path) == -1) return ERR_INVALID_CHARS;

    if (strcmp(path, "-") == 0){
        if (strcmp(type,"out") == 0) file = stdout;
        if (strcmp(type,"in") == 0) file = stdin;
    }

    char* mode = "r";
    if (strcmp(type,"out") ==0 ) mode = "w";
    if (!(file = fopen(path, mode))) return ERR_INVALID_FILE_PATH;

    *path_to_save = path;
    return 0;
}

int checkForInvalidCharacters(char* path){
    char invalidChars[] = "!@%^*|";
    int i;
    for (i = 0; i < strlen(invalidChars); ++i) {
        if (strchr(path, invalidChars[i]) != NULL) {
            return -1;
        }
    }
    return 0;
}

int parseAction(char* action, char **actionToSave){
    if (action == NULL) return ERR_EMPTY;
    if (strcmp(action, "decode") == 0 && (strcmp(action, "encode") == 0)) return ERR_INVALID_ACTION_TYPE;

    *actionToSave = action;

    return 0;
};

parameters_t getParams(int argc, char **argv){

    int ch;
    parameters_t receivedParameters;

    //defaults
    receivedParameters.output = stdout;
    receivedParameters.path_to_output = NULL;
    receivedParameters.input = stdin;
    receivedParameters.path_to_input = NULL;
    receivedParameters.action = "encode";

    // loop over all of the options
    while ((ch = getopt_long(argc, argv, "hVo:i:a:", long_options, NULL)) != -1) {
        switch (ch){
            case 'o':
                validate(checkForPath(optarg, receivedParameters.output, &receivedParameters.path_to_output,"out"));
                break;
            case 'i':
                validate(checkForPath(optarg, receivedParameters.input, &receivedParameters.path_to_input,"in"));
                break;
            case 'a':
                validate(parseAction(optarg,&receivedParameters.action));
                break;
            case 'V':
                showVersion();
                exit(0);
                break;
            case 'h':
                showHelp();
                exit(0);
                break;
            case '?':
                if (optopt == 'o' || optopt == 'i' || optopt == 'a') {
                    fprintf (stderr, "No arguments provided for option -%c .\n", optopt);
                } else if (isprint (optopt)) {
                    fprintf (stderr, "Unknown option `-%c'.\n", optopt);
                } else {
                    fprintf (stderr, "Unknown option `\\x%x'.\n", optopt);
                }
            default:
                showHelp();
                exit(1);
        }
    }

    if(!(stdin)) {
    	showHelp();
    	exit(1);
    }

    return receivedParameters;

}

void validate(int result){
    if (result < 0){
        showError(result);
        exit(1);
    }
}

void showHelp(){
    printf("%s\n", "TP0 Organizacion de computadoras - HELP");
    printf("%s\n", "Usage: ");
    printf("%s\n", "tp0 -h   Displays help and usage of the application");
    printf("%s\n", "tp0 -V   Displays version of the application");
    printf("%s\n", "tp0 Options:");
    printf("%s\n", "-i --input      Set the location of the input file");
    printf("%s\n", "-o --output     Set the location of the output file");
    printf("%s\n", "-a --action     Program action: encode (default) or decode");
    printf("%s\n", "Examples: ");
    printf("%s\n", "  tp0 -a encode -i ~/input -o ~/output");
    printf("%s\n", "  tp0 -a decode");
}

void showVersion(){
    printf("%s\n", "TP0 Organizacion de computadoras - VERSION: 1.0");
}

void showError(int errorCode) {
    if (errorCode == ERR_EMPTY) {
        fprintf(stderr, "%s\n", "Parameter is empty. Type 'tp0 -h' for help. Program terminated");
    }
    if (errorCode == ERR_INVALID_CHARS) {
        fprintf(stderr, "%s\n", "Argument has invalid characters. Type 'tp0 -h' for help. Program terminated");
    }
    if (errorCode == ERR_INVALID_FORMAT) {
        fprintf(stderr, "%s\n", "Invalid arguments. Type 'tp0 -h' for help. Program terminated");
    }
    if (errorCode == ERR_INVALID_FILE_PATH) {
        fprintf(stderr, "%s\n", "File path is invalid. Type 'tp0 -h' for help. Program terminated");
    }
    if (errorCode == ERR_INVALID_PARAMETER) {
        fprintf(stderr, "%s\n", "Parameter input is invalid. Type 'tp0 -h' for help. Program terminated");
    }
    if (errorCode == ERR_INVALID_ACTION_TYPE) {
        fprintf(stderr, "%s\n", "Action is invalid. Type 'tp0 -h' for help. Program terminated");
    }
}

void process(parameters_t parameters){
    if(strcmp(parameters.action,"encode") == 0) {
        encode(parameters.input,parameters.path_to_input,parameters.output,parameters.path_to_output);
    }
    if(strcmp(parameters.action, "decode") == 0) {
        decode(parameters.input, parameters.path_to_input, parameters.output, parameters.path_to_output);
    }
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

int main(int argc, char *argv[]){
    int result = 0;
    parameters_t receivedParameters = getParams(argc, argv);
    process(receivedParameters);
    return result;
}
