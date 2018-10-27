#ifndef TP0_BASE64_H
#define TP0_BASE64_H

int base64_encode(int infd, int outfd);
int base64_decode(int infd, int outfd);
int encode_chars(unsigned const char[], unsigned char[], int);
void condition_1_encode(unsigned const char[], unsigned char[]);
void condition_2_encode(unsigned const char[], unsigned char[]);
void condition_3_encode(unsigned const char[], unsigned char[]);
int exceedsLineSize(int);
void decode(FILE*,char*, FILE *, char *);
int decodeChars(unsigned const char[], unsigned char[]);
void getDecodedOutput(char[], unsigned const char[], unsigned char[]);
char getOutput0(char[]);
char getOutput1(char[]);
char getOutput2(char[]);
int addZerosToOutput(char[], int);
extern const char* errmsg[];

#endif //TP0_BASE64_H
