# Contiene el codigo MIPS32 assembly con las funciones base64 encode() y base64 decode(), y las funciones y 
# estructuras de datos auxiliares para realizar los computos de encoding y decoding.
# Tambien contendra la definicion en assembly de un vector equivalente al siguiente vector C: const char* errmsg[]. 
# Dicho vector contendra los mensajes de error que las funciones antes mencionadas puedan generar, y cuyo indice es 
# el codigo de error devuelto por las mismas.

# Tp1 MIPS32 - Organizacion de Computadoras        
###########################################

#include <mips/regdef.h>
#include <sys/syscall.h>

########################################### base64_encode ########################################

# Definitions 

# ABA caller
# define BASE64_ENCODE_INFD 52
# define BASE64_ENCODE_OUTFD 48

## Stack Frame size
# define BASE64_ENCODE_SFSIZE 48

# SRA
# define BASE64_ENCODE_FP 40
# define BASE64_ENCODE_GP 36
# define BASE64_ENCODE_RA 32

# LTA
#define BASE64_ENCODE_LENGTH 28
#define BASE64_ENCODE_CHARS_IN_LINE 24
#define BASE64_ENCODE_ENCODED_OUTPUT 20
#define BASE64_ENCODE_BUFFER 16

# ABA
# define DECODE_CHARS_ARG2 8
# define DECODE_CHARS_ARG1 4
# define DECODE_CHARS_ARG0 0

    .data
    .align 2
    new_line: .asciiz "\n"    

    .text
    .align 2
    .ent base64_encode
    .globl base64_encode

base64_encode:
    .frame $fp, BASE64_ENCODE_SFSIZE, ra
    .set noreorder
    .cpload t9
    .set reorder

    subu sp, sp, BASE64_ENCODE_SFSIZE
    .cprestore BASE64_ENCODE_GP
    sw gp, BASE64_ENCODE_GP(sp)
    sw ra, BASE64_ENCODE_RA(sp)
    sw $fp, BASE64_ENCODE_FP(sp)
    move $fp, sp

    sw a0, BASE64_ENCODE_INFD($fp)
    sw a1, BASE64_ENCODE_OUTFD($fp)

    ## charsInLine = 0
    li t0, 0
    sw t0, BASE64_ENCODE_CHARS_IN_LINE($fp)

    ## length = 0
    li t0, 0
    sw t0, BASE64_ENCODE_LENGTH($fp)

    ## length = read(infd,buffer,BLOCK_SIZE_INPUT_ENCODING)
    li  v0, SYS_read
    lw a0, BASE64_ENCODE_INFD($fp)
    la a1, BASE64_ENCODE_BUFFER($fp)
    li a2, 3
    syscall
    move t0, v0
    sw t0, BASE64_ENCODE_LENGTH($fp)

    ## encodedOutput[4] = '\0'
    la t0, BASE64_ENCODE_ENCODED_OUTPUT($fp)
    li t1, 0
    sb t1, 4(t0)

loop_base64_encode:
    ## while ( length > 0 )
    lw t0, BASE64_ENCODE_LENGTH($fp)
    blez t0, base64_encode_fin_loop

    ## encode_chars(buffer,encodedOutput,length)
    la a0, BASE64_ENCODE_BUFFER($fp)
    la a1, BASE64_ENCODE_ENCODED_OUTPUT($fp)
    lw a2, BASE64_ENCODE_LENGTH($fp)
    jal encode_chars

    ## write(outfd,encodedOutput,BLOCK_SIZE_OUTPUT_ENCODING)
    li v0, SYS_write
    lw a0, BASE64_ENCODE_OUTFD($fp)
    la a1, BASE64_ENCODE_ENCODED_OUTPUT($fp)
    li a2, 4
    syscall

    ## charsInLine += BLOCK_SIZE_OUTPUT_ENCODING
    lw t0, BASE64_ENCODE_CHARS_IN_LINE($fp)
    addi t0, t0, 4
    sw t0, BASE64_ENCODE_CHARS_IN_LINE($fp)

    ## exceedsLineSize(charsInLine)
    move a0, t0
    jal exceedsLineSize
    move t0, v0

    bne t0, 1, no_new_line

    ## write(outfd,"\n",1)
    li v0, SYS_write
    lw a0, BASE64_ENCODE_OUTFD($fp)
    la a1, new_line
    li a2, 1
    syscall

    ## charsInLine = 0
    li t0, 0
    sw t0, BASE64_ENCODE_CHARS_IN_LINE($fp)

no_new_line:
    ## length = read(infd,buffer,BLOCK_SIZE_INPUT_ENCODING);
    li  v0, SYS_read
    lw a0, BASE64_ENCODE_INFD($fp)
    la a1, BASE64_ENCODE_BUFFER($fp)
    li a2, 3
    syscall
    move t0, v0
    sw t0, BASE64_ENCODE_LENGTH($fp)

    b loop_base64_encode

base64_encode_fin_loop:
    li v0, 0

fin_base64_encode:
    move sp, $fp
    lw gp, BASE64_ENCODE_GP($fp)
    lw ra, BASE64_ENCODE_RA($fp)
    lw $fp, BASE64_ENCODE_FP($fp)
    addu sp, sp, BASE64_ENCODE_SFSIZE
    j ra

.end base64_encode


####################################

	.data
	.align 0
	encoding_table_mips:   .byte 'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','0','1','2','3','4','5','6','7','8','9','+','/'
	decoding_table_mips:   .byte -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-2,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,62,-1,-1,-1,63,52,53,54,55,56,57,58,59,60,61,-1,-1,-1,-3,-1,-1,-1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,-1,-1,-1,-1,-1,-1,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	terminator_char: .byte '='

# Definitions exceedsLineSize

# Stack Frame size
# define EXCEEDSLINESIZE_SFSIZE 16

# SRA
# define EXCEEDSLINESIZE_FP 12
# define EXCEEDSLINESIZE_GP 8

# LTA
# define EXCEEDSLINESIZE_RET 0

# ABA
# define EXCEEDSLINESIZE_ARG0 16

	.text
	.align 2
	.globl exceedsLineSize
	.ent exceedsLineSize

exceedsLineSize:
	# Creo el stack frame para la funcion
    .frame 		$fp, EXCEEDSLINESIZE_SFSIZE, ra
    .set  		noreorder
    .cpload 	t9
    .set  		reorder
	subu 		sp,sp,EXCEEDSLINESIZE_SFSIZE
    sw 			$fp, EXCEEDSLINESIZE_FP(sp)     # Guardo fp en stack
    .cprestore 	EXCEEDSLINESIZE_GP      		# Guardo gp en stack (es como hacer sw gp, POS_GP(sp))
    move 		$fp, sp                	   		# Muevo sp a $fp

    sw 			a0, EXCEEDSLINESIZE_ARG0($fp)		# a0 <- charsInLine (lo recibi por parametro)

	li 			t0, 76
	beq 		a0,t0,true

false:
	li 			v0,0
	b 			return_value 
true: 
	li 			v0,1
	b 			return_value

return_value:
	move 		sp,$fp
	lw 			gp, EXCEEDSLINESIZE_GP(sp)
	lw 			$fp, EXCEEDSLINESIZE_FP(sp)
	addu 		sp,sp,EXCEEDSLINESIZE_SFSIZE
	j 			ra

.end exceedsLineSize


########################################### condition_3_encode_mips.S ########################################

# Definitions 

## Stack Frame size
# define ENCODE_CHARS_CONDITION_3_SFSIZE 8

# SRA
# define ENCODE_CHARS_CONDITION_3_FP 4
# define ENCODE_CHARS_CONDITION_3_GP 0

# ABA
# define ENCODE_CHARS_CONDITION_3_OUTPUT 12
# define ENCODE_CHARS_CONDITION_3_INPUT 8
    
    .text
    .align 2
    .globl condition_3_encode
    .ent condition_3_encode

condition_3_encode:
	#receta
	.frame $fp, ENCODE_CHARS_CONDITION_3_SFSIZE, ra ## $fp: registro usado como frame pointer
    .set noreorder
    .cpload t9
    .set reorder

    subu sp, sp, ENCODE_CHARS_CONDITION_3_SFSIZE
    .cprestore ENCODE_CHARS_CONDITION_3_GP
    sw gp, ENCODE_CHARS_CONDITION_3_GP(sp)  
    sw $fp, ENCODE_CHARS_CONDITION_3_FP(sp)
    move $fp, sp

	#Guardo los argumentos recibidos en el stackframe del invocante
    sw a0, ENCODE_CHARS_CONDITION_3_INPUT($fp)
    sw a1, ENCODE_CHARS_CONDITION_3_OUTPUT($fp)

    ##   output[0] = encodingTable[input[0] >> 2];
	lw t0, ENCODE_CHARS_CONDITION_3_INPUT($fp)
	lbu t1, 0(t0) #input[0]
	srl t1, t1, 2 # input[0] >> 2
	la t2, encoding_table_mips ## cargo encoding_table en t1
	addu t2, t2, t1 ## avanzo el indice input[0] >> 2 veces
	lb t3, 0(t2) # encodingTable[input[0] >> 2]

	lw t0, ENCODE_CHARS_CONDITION_3_OUTPUT($fp)
	sb t3, 0(t0)

	##output[1] = encodingTable[(input[0] & 0x03) << 4];
	lw t0, ENCODE_CHARS_CONDITION_3_INPUT($fp)
	lbu t1, 0(t0) ## input[0]
	li t2, 0x03
	and t1, t1, t2 ## input[1] & 0x03
	sll t1, t1, 4 ##input[1] & 0x03 << 4

	la t2, encoding_table_mips ## cargo encoding_table en t1
	addu t2, t2, t1 ## avanzo el indice input[1] & 0x03 << 4
	lb t3, 0(t2) # encodingTable[input[1] & 0x03 << 4]

	lw t0, ENCODE_CHARS_CONDITION_3_OUTPUT($fp)
	addu t0, t0, 1
	sb t3, 0(t0)

	## output[2] = '=';
	la t0, terminator_char
	lb t1, 0(t0) ## t1 = "="

	lw t0, ENCODE_CHARS_CONDITION_3_OUTPUT($fp)
	addu t0, t0 , 2 ##output[2]
	sb t1, 0(t0) #output[2] = '='

    ## output[3] = '=';
	lw t0, ENCODE_CHARS_CONDITION_3_OUTPUT($fp)
	addu t0, t0, 3 ##output[3]	
	sb t1, 0(t0) #output[3] = '='

fin_condition_3:	
	move 		sp,$fp
	lw 			gp, ENCODE_CHARS_CONDITION_3_GP(sp)
	lw 			$fp, ENCODE_CHARS_CONDITION_3_FP(sp)
	addu 		sp, sp, ENCODE_CHARS_CONDITION_3_SFSIZE
	j 			ra

.end condition_3_encode

########################################### condition_2_encode_mips.S ########################################

# Definitions 

## Stack Frame size
# define ENCODE_CHARS_CONDITION_2_SFSIZE 8

# SRA
# define ENCODE_CHARS_CONDITION_2_FP 4
# define ENCODE_CHARS_CONDITION_2_GP 0

# ABA
# define ENCODE_CHARS_CONDITION_2_OUTPUT 12
# define ENCODE_CHARS_CONDITION_2_INPUT 8

    .text
    .align 2
    .globl condition_2_encode
    .ent condition_2_encode

condition_2_encode:
	#receta
	.frame $fp, ENCODE_CHARS_CONDITION_2_SFSIZE, ra ## $fp: registro usado como frame pointer
    .set noreorder
    .cpload t9
    .set reorder

    subu sp, sp, ENCODE_CHARS_CONDITION_2_SFSIZE
    .cprestore ENCODE_CHARS_CONDITION_2_GP
    sw gp, ENCODE_CHARS_CONDITION_2_GP(sp)  
    sw $fp, ENCODE_CHARS_CONDITION_2_FP(sp)
    move $fp, sp

    #Guardo los argumentos recibidos en el stackframe del invocante
    sw a0, ENCODE_CHARS_CONDITION_2_INPUT($fp)
    sw a1, ENCODE_CHARS_CONDITION_2_OUTPUT($fp)

    ##output[0] = encodingTable[input[0] >> 2];
	lw t0, ENCODE_CHARS_CONDITION_2_INPUT($fp)
	lbu t1, 0(t0) #input[0]
	srl t1, t1, 2 # input[0] >> 2
	la t2, encoding_table_mips ## cargo encoding_table en t1
	addu t2, t2, t1 ## avanzo el indice input[0] >> 2 veces
	lb t3, 0(t2) # encodingTable[input[0] >> 2]

	lw t0, ENCODE_CHARS_CONDITION_2_OUTPUT($fp)
	sb t3, 0(t0)

	##output[1] = encodingTable[((input[0] & 0x03) << 4) + (input[1] >> 4)];
	lw t0, ENCODE_CHARS_CONDITION_2_INPUT($fp)
	lbu t1, 0(t0) ## t1 = input[0]
	li t2, 0x03
	and t1, t1, t2 ## input[0] & 0x03
	sll t1, t1, 4 ## (input[0] & 0x03) << 4

	addu t2, t0, 1
	lbu t2, 0(t2) ## input[1]
	srl t2, t2, 4 ## input[1] >> 4

	addu t1, t1, t2 ## ((input[0] & 0x03) << 4) + (input[1] >> 4)

	la t2, encoding_table_mips ##cargo encoding_table en t2
	addu t2, t2, t1 ## avanzo el indice a ((input[0] & 0x03) << 4) + (input[1] >> 4) bytes
	lb t1, 0(t2) ## t3 = encoding_table[((input[0] & 0x03) << 4) + (input[1] >> 4)]

	lw t0, ENCODE_CHARS_CONDITION_2_OUTPUT($fp)
	addu t0, t0, 1 ## avanzo el indice del output en 1
	sb t1, 0(t0) ## guardo el valor del output[1] en el stackframe

	##output[2] = encodingTable[(input[1] & 0x0F) << 2 ];
	lw t0, ENCODE_CHARS_CONDITION_2_INPUT($fp)
	addu t0, t0, 1 ##avanzo el indice del input en 1
	lbu t1, 0(t0) ## t1 = input[1]
	li t2, 0x0F
	and t1, t1, t2 ## input[1] & 0x0F
	sll t1, t1, 2 ## (input[1] & 0x0F) << 2

	la t2, encoding_table_mips
	addu t2, t1, t2
	lb t1, 0(t2)

	lw t0, ENCODE_CHARS_CONDITION_2_OUTPUT($fp)
	addu t0, t0, 2
	sb t1, 0(t0)

	##output[3] = '=';
	la t0, terminator_char
	lb t1, 0(t0) ## t1 = "="
	lw t0, ENCODE_CHARS_CONDITION_3_OUTPUT($fp)
	addu t0, t0, 3 ##output[3]	
	sb t1, 0(t0) #output[3] = '='

fin_condition_2:	
	move 		sp,$fp
	lw 			gp, ENCODE_CHARS_CONDITION_2_GP(sp)
	lw 			$fp, ENCODE_CHARS_CONDITION_2_FP(sp)
	addu 		sp, sp, ENCODE_CHARS_CONDITION_2_SFSIZE
	j 			ra

.end condition_2_encode

########################################### condition_1_encode_m ########################################

# Definitions 

## Stack Frame size
# define ENCODE_CHARS_CONDITION_1_SFSIZE 8

# SRA
# define ENCODE_CHARS_CONDITION_1_FP 4
# define ENCODE_CHARS_CONDITION_1_GP 0

# ABA
# define ENCODE_CHARS_CONDITION_1_OUTPUT 12
# define ENCODE_CHARS_CONDITION_1_INPUT 8

    .text
    .align 2
    .globl condition_1_encode
    .ent condition_1_encode

condition_1_encode:
	#receta
	.frame $fp, ENCODE_CHARS_CONDITION_1_SFSIZE, ra ## $fp: registro usado como frame pointer
    .set noreorder
    .cpload t9
    .set reorder

    subu sp, sp, ENCODE_CHARS_CONDITION_1_SFSIZE
    .cprestore ENCODE_CHARS_CONDITION_1_GP
    sw gp, ENCODE_CHARS_CONDITION_1_GP(sp)  
    sw $fp, ENCODE_CHARS_CONDITION_1_FP(sp)
    move $fp, sp

	#Guardo los argumentos recibidos en el stackframe del invocante
    sw a0, ENCODE_CHARS_CONDITION_1_INPUT($fp) # input[]
    sw a1, ENCODE_CHARS_CONDITION_1_OUTPUT($fp) # output[]

    # output[0] = encodingTable[input[0] >> 2];
    lw t0, ENCODE_CHARS_CONDITION_1_INPUT($fp) #cargo la direccion del input en t0
    lbu t1, 0(t0) # t1 = input[0]
    srl t1, t1, 2 # input[0] >> 2
    la t2, encoding_table_mips
    addu t2, t2, t1 
    lb t2, 0(t2) ## t5 = encoding_table_mips[input[0] >> 2]
    
    lw t0, ENCODE_CHARS_CONDITION_1_OUTPUT($fp) ## t0 = output[]
    sw t2, 0(t0) ## guardo en el stackframe el encoding_table_mips[input >> 2]

    #output[1] = encodingTable[((input[0] & 0x03) << 4) + (input[1] >> 4)];
    lw t0, ENCODE_CHARS_CONDITION_1_INPUT($fp) #cargo la direccion del input en t0
    lbu t1, 0(t0) ## t1 = input[0]
    li t2, 0x03 # t2 = 3
    and t1, t1, t2 # t1 = input[0] & 0x03
    sll t1, t1, 4 ## input[0] & 0x03 << 4
    
    addu t2, t0 ,1 #avanzo el indice de input en 1
    lbu t2, 0(t2) #t2 = input[1]
    srl t2, t2, 4 # t2 = input[1] >> 4
    addu t1, t1, t2 # t1 = (input[0] & 0x03) + (input[1] >> 4)

    la t2, encoding_table_mips
    addu t2, t2, t1
    lb t2, 0(t2) #t2 = encoding_table[input[0] & 0x03 + inpuT[1] >> 4]
    lw t0, ENCODE_CHARS_CONDITION_1_OUTPUT($fp) #t0 = output
    addu t0, t0, 1 ## output[1]
    sb t2, 0(t0)  ## guardo en el stackframe el encoding_table_mips[(input[0] & 0x03) + (input[1] >> 4)]

    #output[2] = encodingTable[((input[1] & 0x0f) << 2) + (input[2] >> 6)];
    lw t0, ENCODE_CHARS_CONDITION_1_INPUT($fp)
    addu t0, t0, 1  #avnazo el indice del input en 1
    lbu t1, 0(t0) ## t1 = input[1]
    li t2, 0x0f ## t2 = 0x0f
    and t1, t1, t2 ## input[1] & 0x0f
    sll t1, t1, 2 ## input[1] & 0x0f << 2

    lw t0, ENCODE_CHARS_CONDITION_1_INPUT($fp)
	addu t0, t0, 2 #avanzo el indice del input en 2
    lbu t2, 0(t0) # t2 = input[2]
    srl t2, t2, 6 # input[2] >> 6
    
    addu t1, t1, t2 ## input[1] & 0x0f << 2 + input[2] >> 6

    la t2, encoding_table_mips
    addu t2, t2, t1
    lb t3, 0(t2)  #t3 = encoding_table[input[1] & 0x0f << 2 + input[2] >> 6]
    lw t0, ENCODE_CHARS_CONDITION_1_OUTPUT($fp)
    addu t0, t0, 2 #avanzo el indice del output a 2
    sb t3, 0(t0) #actualizo el stackframe

    #output[3] = encodingTable[input[2] & 0x3F];
	lw t0, ENCODE_CHARS_CONDITION_1_INPUT($fp)    
	addu t0, t0, 2 #avnazo el indice del input en 2
	lbu t1, 0(t0) ## t1 = input[2]
	li t2, 0x3f ## t2 = 0x3f
	and t1, t1, t2

	la t2, encoding_table_mips
    addu t2, t2, t1
    lb t2, 0(t2) ## encoding_table[input[1] & 0x3f]
    lw t0, ENCODE_CHARS_CONDITION_1_OUTPUT($fp)
    addu t0, t0, 3 #avanzo el indice del output a 3
    sb t2, 0(t0) #actualizo el stackframe

fin_condition_1:	
	move 		sp,$fp
	lw 			gp, ENCODE_CHARS_CONDITION_1_GP(sp)
	lw 			$fp, ENCODE_CHARS_CONDITION_1_FP(sp)
	addu 		sp, sp, ENCODE_CHARS_CONDITION_1_SFSIZE
	j 			ra

.end condition_1_encode

########################################### encode_chars.mips ########################################

# Definitions 

## Stack Frame size
# define ENCODE_CHARS_SFSIZE 32

# SRA
# define ENCODE_CHARS_PADDING 28
# define ENCODE_CHARS_RA 24
# define ENCODE_CHARS_FP 20
# define ENCODE_CHARS_GP 16

# ABA caller
# define ENCODE_CHARS_LENGHT 40
# define ENCODE_CHARS_OUTPUT 36
# define ENCODE_CHARS_INPUT 32

# ABA caller
# define ENCODE_CHARS_ARG3 12
# define ENCODE_CHARS_ARG2 8
# define ENCODE_CHARS_ARG1 4
# define ENCODE_CHARS_ARG0 0


    .text
    .align 2
    .globl encode_chars
    .ent encode_chars

encode_chars:
	.frame $fp, ENCODE_CHARS_SFSIZE, ra
	.set noreorder
	.cpload t9
	.set reorder

	subu sp, sp, ENCODE_CHARS_SFSIZE
	.cprestore ENCODE_CHARS_GP
	sw gp, ENCODE_CHARS_GP(sp)
	sw ra, ENCODE_CHARS_RA(sp)
	sw $fp, ENCODE_CHARS_FP(sp)
	move $fp, sp

	sw a0, ENCODE_CHARS_INPUT($fp)
	sw a1, ENCODE_CHARS_OUTPUT($fp)
	sw a2, ENCODE_CHARS_LENGHT($fp)

	lw t0, ENCODE_CHARS_LENGHT($fp)
	li t1, 3 ## t1 = 3
	bne t0, t1, encode_chars_jump_cond_2
	##condition_1_encode(input, output);
	lw a0, ENCODE_CHARS_INPUT($fp)
	lw a1, ENCODE_CHARS_OUTPUT($fp)
	jal condition_1_encode
	b fin_encode_chars

encode_chars_jump_cond_2:
	lw t0, ENCODE_CHARS_LENGHT($fp)
	li t1, 2
	bne t0, t1, encode_chars_jump_cond_3
	#condition_2_encode(input, output);
	lw a0, ENCODE_CHARS_INPUT($fp)
	lw a1, ENCODE_CHARS_OUTPUT($fp)
	jal condition_2_encode
	b fin_encode_chars

encode_chars_jump_cond_3:
	lw t0, ENCODE_CHARS_LENGHT($fp)
	li t1, 1
	bne t0, t1, fin_encode_chars
	##condition_3_encode(input, output);
	lw a0, ENCODE_CHARS_INPUT($fp)
	lw a1, ENCODE_CHARS_OUTPUT($fp)
	jal condition_3_encode

fin_encode_chars:
	li v0, 4
	move sp, $fp
	lw ra, ENCODE_CHARS_RA(sp)
	lw gp, ENCODE_CHARS_GP(sp)
	lw $fp, ENCODE_CHARS_FP(sp)
	addu sp, sp, ENCODE_CHARS_SFSIZE
	j ra

.end encode_chars

########################################### getOutput0 ########################################

# Definitions 

## Stack Frame size
# define GET_OUTPUT_0_SFSIZE 8

# SRA
# define GET_OUTPUT_0_FP 4
# define GET_OUTPUT_0_GP 0

# ABA caller
# define GET_OUTPUT_0_DECODED_OUTPUT 8

	.text
	.align 2
	.globl getOutput0
	.ent getOutput0
getOutput0:
	.frame $fp, GET_OUTPUT_0_SFSIZE, ra
	.set noreorder
	.cpload t9
	.set reorder 

	subu sp,sp, GET_OUTPUT_0_SFSIZE
	.cprestore GET_OUTPUT_0_GP
	sw gp, GET_OUTPUT_0_GP(sp)
	sw $fp, GET_OUTPUT_0_FP(sp)
	move $fp, sp

	sw a0, GET_OUTPUT_0_DECODED_OUTPUT($fp)
	lw t0, GET_OUTPUT_0_DECODED_OUTPUT($fp)

	## t1 ==> decodedOutput[0]
	lb t1, 0(t0)
	## t1 ==> decodedOutput[0] << 2
	sll t1, t1, 2

	## t2 ==> decodedOutput[1]
	lb t2, 1(t0)
	## t2 ==> decodedOutput[1] >> 4
	srl t2, t2, 4

	## t3 ==> (decodedOutput[0] << 2) | (decodedOutput[1] >> 4)
	or t3, t1, t2

fin_getOutput0:
	move v0, t3
	
	move sp, $fp
	lw gp, GET_OUTPUT_0_GP($fp)
	lw $fp, GET_OUTPUT_0_FP($fp)
	addu sp, sp, GET_OUTPUT_0_SFSIZE
	j ra

.end getOutput0

########################################### getOutput1 ########################################

# Definitions 

## Stack Frame size
# define GET_OUTPUT_1_SFSIZE 8

# SRA
# define GET_OUTPUT_1_FP 4
# define GET_OUTPUT_1_GP 0

# ABA caller
# define GET_OUTPUT_1_DECODED_OUTPUT 8

	.text
	.align 2
	.globl getOutput1
	.ent getOutput1
getOutput1:
	.frame $fp, GET_OUTPUT_1_SFSIZE, ra
	.set noreorder
	.cpload t9
	.set reorder 

	subu sp,sp, GET_OUTPUT_1_SFSIZE
	.cprestore GET_OUTPUT_1_GP
	sw gp, GET_OUTPUT_1_GP(sp)
	sw $fp, GET_OUTPUT_1_FP(sp)
	move $fp, sp

	sw a0, GET_OUTPUT_1_DECODED_OUTPUT($fp)
	lw t0, GET_OUTPUT_1_DECODED_OUTPUT($fp)

	## t1 ==> decodedOutput[1]
	lb t1, 1(t0)
	## t1 ==> decodedOutput[1] & 15
	and t1, t1, 15
	## t1 ==> (decodedOutput[1] & 15) << 4
	sll t1, t1, 4

	## t2 ==> decodedOutput[2]
	lb t2, 2(t0)
	## t2 ==> decodedOutput[2] >> 2
	srl t2, t2, 2
	## t2 ==> (decodedOutput[2] >> 2) & 15
	and t2, t2, 15
	## t3 ==> (((decodedOutput[1] & 15) << 4) | ((decodedOutput[2] >> 2) & 15))
	or t3, t1, t2

fin_getOutput1:
	move v0, t3
	
	move sp, $fp
	lw gp, GET_OUTPUT_1_GP($fp)
	lw $fp, GET_OUTPUT_1_FP($fp)
	addu sp, sp, GET_OUTPUT_1_SFSIZE
	j ra

.end getOutput1

########################################### getOutput2 ########################################

# Definitions 

## Stack Frame size
# define GET_OUTPUT_2_SFSIZE 8

# SRA
# define GET_OUTPUT_2_FP 4
# define GET_OUTPUT_2_GP 0

# ABA caller
# define GET_OUTPUT_2_DECODED_OUTPUT 8

	.text
	.align 2
	.globl getOutput2
	.ent getOutput2
getOutput2:
	.frame $fp, GET_OUTPUT_2_SFSIZE, ra
	.set noreorder
	.cpload t9
	.set reorder 

	subu sp,sp, GET_OUTPUT_2_SFSIZE
	.cprestore GET_OUTPUT_2_GP
	sw gp, GET_OUTPUT_2_GP(sp)
	sw $fp, GET_OUTPUT_2_FP(sp)
	move $fp, sp

	sw a0, GET_OUTPUT_2_DECODED_OUTPUT($fp)
	lw t0, GET_OUTPUT_2_DECODED_OUTPUT($fp)

	## t1 ==> decodedOutput[2]
	lb t1, 2(t0)
	## t1 ==> decodedOutput[2] & 255
	and t1, t1, 255
	## t1 ==> (decodedOutput[2] & 255) << 6
	sll t1, t1, 6

	## t2 ==> decodedOutput[3]
	lb t2, 3(t0)
	## t2 ==> decodedOutput[3] >> 63
	and t2, t2, 63

	## t3 ==> ((decodedOutput[2] & 255) << 6) | ((decodedOutput[3]) & 63)
	or t3, t1, t2

fin_getOutput2:
	move v0, t3
	
	move sp, $fp
	lw gp, GET_OUTPUT_2_GP($fp)
	lw $fp, GET_OUTPUT_2_FP($fp)
	addu sp, sp, GET_OUTPUT_2_SFSIZE
	j ra

.end getOutput2


########################################### addZerosToOutput ########################################

# Definitions 

## Stack Frame size
# define ADD_ZEROS_TO_OUTPUT_SFSIZE 8

# SRA
# define ADD_ZEROS_TO_OUTPUT_FP 4
# define ADD_ZEROS_TO_OUTPUT_GP 0

# ABA caller
# define ADD_ZEROS_TO_OUTPUT_OUTPUT 8
# define ADD_ZEROS_TO_OUTPUT_N 12

	.text
	.align 2
	.globl addZerosToOutput
	.ent addZerosToOutput
addZerosToOutput:
	.frame $fp, ADD_ZEROS_TO_OUTPUT_SFSIZE, ra
	.set noreorder
	.cpload t9
	.set reorder 

	subu sp,sp, GET_OUTPUT_2_SFSIZE
	.cprestore ADD_ZEROS_TO_OUTPUT_GP
	sw gp, ADD_ZEROS_TO_OUTPUT_GP(sp)
	sw $fp, ADD_ZEROS_TO_OUTPUT_FP(sp)
	move $fp, sp

	sw a0, ADD_ZEROS_TO_OUTPUT_OUTPUT($fp)
	sw a1, ADD_ZEROS_TO_OUTPUT_N($fp)

	## t0 ==> &output
	lw t0, ADD_ZEROS_TO_OUTPUT_OUTPUT($fp)
	##t1 ==> n
	lw t1, ADD_ZEROS_TO_OUTPUT_N($fp)

	## t2 ==> 0
	li t2, 0

	beq t1, 1, size_1

size_2:
	## output[1] = '\0';
	sb t2, 1(t0)
	## output[2] = '\0';
	sb t2, 2(t0)
	li v0, 1
	b fin_addZerosToOutput

size_1:
	## output[2] = '\0';
	sb t2, 2(t0)
	li v0, 2
	b fin_addZerosToOutput 

fin_addZerosToOutput:
	move sp, $fp
	lw gp, ADD_ZEROS_TO_OUTPUT_GP($fp)
	lw $fp, ADD_ZEROS_TO_OUTPUT_FP($fp)
	addu sp, sp, ADD_ZEROS_TO_OUTPUT_SFSIZE
	j ra

.end addZerosToOutput


########################################### getDecodedOutput ########################################

# Definitions 

## Stack Frame size
# define GET_DECODED_OUTPUT_SFSIZE 8

# SRA
# define GET_DECODED_OUTPUT_FP 4
# define GET_DECODED_OUTPUT_GP 0

# ABA caller
# define GET_DECODED_OUTPUT_DECODED_OUTPUT 8
# define GET_DECODED_OUTPUT_INPUT 12
# define GET_DECODED_OUTPUT_OUTPUT 16

	.text
	.align 2
	.globl getDecodedOutput
	.ent getDecodedOutput
getDecodedOutput:
	.frame $fp, GET_DECODED_OUTPUT_SFSIZE, ra
	.set noreorder
	.cpload t9
	.set reorder 

	subu sp,sp, GET_DECODED_OUTPUT_SFSIZE
	.cprestore GET_DECODED_OUTPUT_GP
	sw gp, GET_DECODED_OUTPUT_GP(sp)
	sw $fp, GET_DECODED_OUTPUT_FP(sp)
	move $fp, sp

	sw a0, GET_DECODED_OUTPUT_DECODED_OUTPUT($fp)
	sw a1, GET_DECODED_OUTPUT_INPUT($fp)
	sw a2, GET_DECODED_OUTPUT_OUTPUT($fp)

	## t0 ==> decodingTable
	la t0, decoding_table_mips
	## t1 ==> decodedOutput
	lw t1, GET_DECODED_OUTPUT_DECODED_OUTPUT($fp)
	## t2 ==> input
	lw t2, GET_DECODED_OUTPUT_INPUT($fp)
	## t3 ==> output
	lw t3, GET_DECODED_OUTPUT_OUTPUT($fp)

	## t4 ==> i
	li t4, 0

loop_getDecodedOutput:
	## t6 ==> input + i
	addu t6, t2, t4
	## t5 ==> input[i]
	lb t5, 0(t6)
	## t5 ==> decodingTable + input[i]
	addu t5, t0, t5
	## t5 ==> decodingTable[input[i]]
	lb t5, 0(t5)
	## t7 ==> decodedOutput[i]
	addu t7, t1, t4
	## decodedOutput[i] = decodingTable[input[i]]
	sb t5, 0(t7)
	## i++
	addi t4, t4, 1
	blt t4,4, loop_getDecodedOutput


fin_getDecodedOutput:
	move sp, $fp
	lw gp, GET_DECODED_OUTPUT_GP($fp)
	lw $fp, GET_DECODED_OUTPUT_FP($fp)
	addu sp, sp, GET_DECODED_OUTPUT_SFSIZE
	j ra

.end getDecodedOutput

########################################### decode_chars ########################################

# Definitions 

# ABA caller
# define DECODE_CHARS_OUTPUT 44
# define DECODE_CHARS_INPUT 40


## Stack Frame size
# define DECODE_CHARS_SFSIZE 40

# SRA
# define PADDING 36 
# define DECODE_CHARS_FP 32
# define DECODE_CHARS_GP 28
# define DECODE_CHARS_RA 24

# LTA
#define DECODE_CHARS_PADDING 20
#define DECODE_CHARS_DECODED_OUTPUT 16

# ABA
# define DECODE_CHARS_ARG3 12
# define DECODE_CHARS_ARG2 8
# define DECODE_CHARS_ARG1 4
# define DECODE_CHARS_ARG0 0	
	.data
	.align 2
	decoded_chars_array: .byte 0:4
	equals: .byte -3

	.text
	.align 2
	.ent decode_chars
	.globl decode_chars

decode_chars:
	.frame $fp, DECODE_CHARS_SFSIZE, ra
	.set noreorder
	.cpload t9
	.set reorder

	subu sp, sp, DECODE_CHARS_SFSIZE
	.cprestore DECODE_CHARS_GP
	sw gp, DECODE_CHARS_GP(sp)
	sw ra, DECODE_CHARS_RA(sp)
	sw $fp, DECODE_CHARS_FP(sp)
	move $fp, sp

	sw a0, DECODE_CHARS_INPUT($fp)
	sw a1, DECODE_CHARS_OUTPUT($fp)

	la t0, decoded_chars_array
	sw t0, DECODE_CHARS_DECODED_OUTPUT($fp)#guardo el array en el stackframe

	lw a0, DECODE_CHARS_DECODED_OUTPUT($fp)
	lw a1, DECODE_CHARS_INPUT($fp)
	lw a2, DECODE_CHARS_OUTPUT($fp)
	jal getDecodedOutput

	lw a0, DECODE_CHARS_DECODED_OUTPUT($fp)
	jal getOutput0

	move t1, v0
	lw t0, DECODE_CHARS_OUTPUT($fp)
	sb t1, 0(t0)

decode_chars_frist_if:
	lw t0, DECODE_CHARS_DECODED_OUTPUT($fp)
	addu t0, t0, 2
	lb t0, 0(t0)
	la t1, equals
	lb t1, 0(t1)
	bne t0, t1, decode_chars_second_if

	lw t0, DECODE_CHARS_DECODED_OUTPUT($fp)
	addu t0, t0, 3
	lb t0, 0(t0)
	la t1, equals
	lb t1, 0(t1)
	bne t0, t1, decode_chars_second_if

	lw a0, DECODE_CHARS_OUTPUT($fp)
	li a1, 2
	jal addZerosToOutput
	b fin_decode_chars

decode_chars_second_if:
	lw a0, DECODE_CHARS_DECODED_OUTPUT($fp)
	jal getOutput1

	move t0, v0
	lw t1, DECODE_CHARS_OUTPUT($fp)
	addu t1, t1, 1
	sb t0, 0(t1)

	lw t0, DECODE_CHARS_DECODED_OUTPUT($fp)
	addu t0, t0, 3
	lb t0, 0(t0)
	la t1, equals
	lb t1, 0(t1)
	bne t1, t0, decode_chars_default_exit

	lw a0, DECODE_CHARS_OUTPUT($fp)
	li a1, 1
	jal addZerosToOutput
	b fin_decode_chars

decode_chars_default_exit:
	
	lw a0, DECODE_CHARS_DECODED_OUTPUT($fp)
	jal getOutput2

	move t0, v0
	lw t1, DECODE_CHARS_OUTPUT($fp)
	addu t1, t1, 2
	sb t0, 0(t1)
	li v0, 3

fin_decode_chars:
	move sp, $fp
	lw gp, DECODE_CHARS_GP(sp)
	lw ra, DECODE_CHARS_RA(sp)
	lw $fp, DECODE_CHARS_FP(sp)
	addu sp, sp, DECODE_CHARS_SFSIZE
	j ra

.end decode_chars

########################################### base64_decode ########################################

# Definitions 

# ABA caller
# define BASE64_DECODE_INFD 60
# define BASE64_DECODE_OUTFD 56

## Stack Frame size
# define BASE64_DECODE_SFSIZE 56

# SRA
# define BASE64_DECODE_PADDING_2 52
# define BASE64_DECODE_FP 48
# define BASE64_DECODE_GP 44
# define BASE64_DECODE_RA 40

# LTA
#define BASE64_DECODE_PADDING_1 36
#define BASE64_DECODE_BUFFER 32
#define BASE64_DECODE_DECODED_OUTPUT 28
#define BASE64_DECODE_CHARS_DECODED 24
#define BASE64_DECODE_CHARS_IN_LINE 20
#define BASE64_DECODE_LENGTH 16

# ABA
# define DECODE_CHARS_ARG3 12
# define DECODE_CHARS_ARG2 8
# define DECODE_CHARS_ARG1 4
# define DECODE_CHARS_ARG0 0    
    .data
    .align 2
    base64_decode_buffer: .byte 0:4
    base64_decode_decoded_output: .byte 0:3
    base64_decode_block_size_input_decoding: .word  4

    .text
    .align 2
    .ent base64_decode
    .globl base64_decode

base64_decode:
    .frame $fp, BASE64_DECODE_SFSIZE, ra
    .set noreorder
    .cpload t9
    .set reorder

    subu sp, sp, BASE64_DECODE_SFSIZE
    .cprestore BASE64_DECODE_GP
    sw gp, BASE64_DECODE_GP(sp)
    sw ra, BASE64_DECODE_RA(sp)
    sw $fp, BASE64_DECODE_FP(sp)
    move $fp, sp

    sw a0, BASE64_DECODE_INFD($fp)
    sw a1, BASE64_DECODE_OUTFD($fp)

    la t0, base64_decode_buffer
    sw t0, BASE64_DECODE_BUFFER($fp)

    la t0, base64_decode_decoded_output
    sw t0, BASE64_DECODE_DECODED_OUTPUT($fp)

    ## charsDecoded = 0
    li t0,0
    sw t0, BASE64_DECODE_CHARS_DECODED($fp)

    ## charsInLine = 0
    li t0, 0
    sw t0, BASE64_DECODE_CHARS_IN_LINE($fp)

    ## length = 0
    li t0, 0
    sw t0, BASE64_DECODE_LENGTH($fp)

    ## length = read(infd,buffer,BLOCK_SIZE_INPUT_DECODING)
	li 	v0, SYS_read
    lw a0, BASE64_DECODE_INFD($fp)
    lw a1, BASE64_DECODE_BUFFER($fp)
    la a2, base64_decode_block_size_input_decoding
    lw a2, 0(a2)
    syscall
    move t0, v0
    sw t0, BASE64_DECODE_LENGTH($fp)

loop_base64_decode:
	lw t0, BASE64_DECODE_LENGTH($fp)
	blez t0, base64_decode_fin_loop

    ## charsDecoded = decode_chars(buffer,decoded_output)
    lw a0, BASE64_DECODE_BUFFER($fp)
    lw a1, BASE64_DECODE_DECODED_OUTPUT($fp)
    jal decode_chars
    move t0, v0
    sw t0, BASE64_DECODE_CHARS_DECODED($fp)
    
    lw t0, BASE64_DECODE_CHARS_DECODED($fp)
    blez t0, base64_decode_error

    li v0, SYS_write
    lw a0, BASE64_DECODE_OUTFD($fp)
    lw a1, BASE64_DECODE_DECODED_OUTPUT($fp)
    lw a2, BASE64_DECODE_CHARS_DECODED($fp)
    syscall

	la t0, base64_decode_block_size_input_decoding    
	lw t0, 0(t0)
	lw t1, BASE64_DECODE_CHARS_IN_LINE($fp)
	addu t1, t1, t0
	sw t1, BASE64_DECODE_CHARS_IN_LINE($fp)

	lw a0, BASE64_DECODE_CHARS_IN_LINE($fp)
	jal exceedsLineSize
	move t0, v0
	li t1, 1
	bne t0, t1, base64_decode_no_read_if

	li v0, SYS_read
	lw a0, BASE64_DECODE_INFD($fp)
	lw a1, BASE64_DECODE_BUFFER($fp)
	li a2, 1
	syscall

	move t0, v0
	sw t0, BASE64_DECODE_LENGTH($fp)
	li t0, 0
	sw t0, BASE64_DECODE_CHARS_IN_LINE($fp)

base64_decode_no_read_if:
	li v0, SYS_read
	lw a0, BASE64_DECODE_INFD($fp)
	lw a1, BASE64_DECODE_BUFFER($fp)
	la a2, base64_decode_block_size_input_decoding 
	lw a2, 0(a2)
	syscall

	move t0, v0
	sw t0, BASE64_DECODE_LENGTH($fp)
	b loop_base64_decode

base64_decode_error:
	li v0, -1
	b fin_base64_decode

base64_decode_fin_loop:
	li v0, 0

fin_base64_decode:
    move sp, $fp
    lw gp, BASE64_DECODE_GP($fp)
    lw ra, BASE64_DECODE_RA($fp)
    lw $fp, BASE64_DECODE_FP($fp)
    addu sp, sp, BASE64_DECODE_SFSIZE
    j ra

.end base64_decode
