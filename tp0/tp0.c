#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <unistd.h>
#include <getopt.h>
#include <memory.h>
#include "encode.h"
#include "constants.h"

typedef struct receivedParameters {
    FILE* output;
    FILE* input;
    char* path_to_output;
    char* path_to_input;
    char* action;
} parameters_t;

const unsigned char encodingTable[]={"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"};

static struct option long_options[] =
        {
                {"input",required_argument,NULL,'i'},
                {"output",required_argument,NULL,'o'},
                {"action",required_argument,NULL,'a'},
                {"help",no_argument,NULL,'h'},
                {"version",no_argument,NULL,'V'},
                {NULL, 0, NULL, 0}
        };

void showVersion(void);
void showHelp();
void showError(int);
void validate(int);
void process(parameters_t);
parameters_t getParams(int, char **);
int checkForInvalidCharacters(char*);
int parseAction(char*,char **);
int checkForPath(char*,FILE*,char**,char*);
void writeOutput(unsigned char *processedOutput,FILE*,char*);

int checkForPath(char* path, FILE* file, char** path_to_save, char* type){
    if (path == NULL) return ERR_EMPTY;

    if(checkForInvalidCharacters(path) == -1) return ERR_INVALID_CHARS;

    if (strcmp(path, "-") == 0){
        if(strcmp(type,"out")==0) file = stdout;
        else file = stdin;
    }

    char* mode = "r";
    if (strcmp(type,"out")==0) mode = "w";
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
    receivedParameters.action = "decode";

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
    if(strcmp(parameters.action,"encode")==0) {
        writeOutput(encode(parameters.input,parameters.path_to_input),parameters.output,parameters.path_to_output);
    }
}

void writeOutput(unsigned char* processedOutput,FILE* output,char* path) {

    output = fopen(path, "w");

    if (output != NULL) {
        while (*processedOutput != '\0'){
            if (!(fprintf(output,"%c",*processedOutput))) {
                fprintf(stderr, "Error when writing output to file %s\n", path);
                exit(1);
            }
            ++processedOutput;
        }
        fclose(output);
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
