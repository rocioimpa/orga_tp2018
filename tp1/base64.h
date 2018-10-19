#ifndef TP0_BASE64_H
#define TP0_BASE64_H

int base64_encode(int infd, int outfd);
int base64_decode(int infd, int outfd);
extern const char* errmsg[];

int encodeChars(unsigned const char[], unsigned char[], int);
int exceedsLineSize(int);
void decode(FILE*,char*, FILE *, char *);
int decodeChars(unsigned const char[], unsigned char[]);
int readInput(FILE*, unsigned char*,int,int);
void write_partial(unsigned char* processedOutput, FILE* output, char* path);
int isValid(unsigned char currentChar);

#endif //TP0_BASE64_H
