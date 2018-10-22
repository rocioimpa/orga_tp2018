#ifndef TP0_CONSTANTS_H
#define TP0_CONSTANTS_H

	#define ERR_EMPTY -1
	#define ERR_INVALID_CHARS -2
	#define ERR_INVALID_FORMAT -3
	#define ERR_INVALID_FILE_PATH -4
	#define ERR_INVALID_PARAMETER -5
	#define ERR_INVALID_ACTION_TYPE -6

	#define BLOCK_SIZE_INPUT_ENCODING 3
	#define BLOCK_SIZE_INPUT_DECODING 4
	#define BLOCK_SIZE_OUTPUT_ENCODING 4
	#define BLOCK_SIZE_OUTPUT_DECODING 3
	#define INVALID_CHAR -1
	#define WHITESPACE -2
	#define EQUALS -3

	extern const unsigned char encodingTable[];
	extern const char decodingTable[];

	void showVersion(void);
	void showHelp();
	void showError(int);
	void validate(int);
	int checkForInvalidCharacters(char*);
	int parseAction(char*,char **);
	int checkForPath(char*,FILE*,char**,char*);

#endif //TP0_CONSTANTS_H
