#ifndef TP0_ENCODE_H
#define TP0_ENCODE_H

#endif //TP0_ENCODE_H

unsigned char* encode(FILE*,char*);
int readInput(FILE*, unsigned char*);
int encodeChars(unsigned const char[], unsigned char[], int);
int exceedsLineSize(int);
void addNewLine(unsigned char*, int);