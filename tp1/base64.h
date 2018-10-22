#ifndef TP0_BASE64_H
#define TP0_BASE64_H

int base64_encode(int infd, int outfd);
int base64_decode(int infd, int outfd);
int encodeChars(unsigned const char[], unsigned char[], int);
int exceedsLineSize(int);
void decode(FILE*,char*, FILE *, char *);
int decodeChars(unsigned const char[], unsigned char[]);
extern const char* errmsg[];

#endif //TP0_BASE64_H
