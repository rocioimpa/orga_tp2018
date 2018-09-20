CC := gcc
CFLAGS := -g -Wall

tp0: tp0.c encode.o decode.o
	$(CC) $(CFLAGS) $(OBJS) $^ -o $@ -lm

encode: encode.c
	$(CC) $(CFLAGS) $(OBJS) $^ -o $@

decode: decode.c
	$(CC) $(CFLAGS) $(OBJS) $^ -o $@

clean:
	rm -f tp0 *.o core *.asm

.PHONY: clean
