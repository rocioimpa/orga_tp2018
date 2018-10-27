# Contiene el codigo MIPS32 assembly con las funciones base64 encode() y base64 decode(), y las funciones y 
# estructuras de datos auxiliares para realizar los computos de encoding y decoding.
# Tambien contendra la definicion en assembly de un vector equivalente al siguiente vector C: const char* errmsg[]. 
# Dicho vector contendra los mensajes de error que las funciones antes mencionadas puedan generar, y cuyo indice es 
# el codigo de error devuelto por las mismas.

# Tp1 MIPS32 - Organizacion de Computadoras        
###########################################

#include <mips/regdef.h>
#include <sys/syscall.h>

# Definitions 

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

########################################### condition_1_encode.S ###########################################


# Definitions 

## Definitions encode chars

## Stack Frame size
# define ENCODE_CHARS_CONDITION_1_SFSIZE 8

# SRA
# define ENCODE_CHARS_CONDITION_1_FP 4
# define ENCODE_CHARS_CONDITION_1_GP 0

# ABA
# define ENCODE_CHARS_CONDITION_1_OUTPUT 12
# define ENCODE_CHARS_CONDITION_1_INPUT 8

	.data
	.align 0
	encoding_table_mips:   .byte 'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','0','1','2','3','4','5','6','7','8','9','+','/'
    
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
    lb t1, 0(t0) # t1 = input[0]
    srl t2, t1, 2 # input[0] >> 2
    la t3, encoding_table_mips
    addu t4, t3, t2 
    lb t5, 0(t4) ## t5 = encoding_table_mips[input[0] >> 2]
    lw t0, ENCODE_CHARS_CONDITION_1_OUTPUT($fp) ## t0 = output[]
    sw t5, 0(t0) ## guardo en el stackframe el encoding_table_mips[input >> 2]

    #output[1] = encodingTable[((input[0] & 0x03) << 4) + (input[1] >> 4)];
    lw t0, ENCODE_CHARS_CONDITION_1_INPUT($fp) #cargo la direccion del input en t0
    lb t1, 0(t0) ## t1 = input[0]
    li t2, 3 # t2 = 3
    and t1, t1, t2 # t1 = input[0] & 0x03
    
    sll t2, t0, 1 #avanzo el indice de input en 1
    lb t3, 0(t2) #t1 = input[1]
    srl t3, t3, 4 # t3 = input[1] >> 4
    addu t1, t1, t3 # t1 = (input[0] & 0x03) + (input[1] >> 4)

    la t2, encoding_table_mips
    addu t3, t2, t1
    lb t4, 0(t3) #encoding_table[input[0] & 0x03 + inpuT[1] >> 4]
    lw t0, ENCODE_CHARS_CONDITION_1_OUTPUT($fp) #t0 = output
    sll t0, t0, 1 ## output[1]
    sb t4, 0(t0)  ## guardo en el stackframe el encoding_table_mips[(input[0] & 0x03) + (input[1] >> 4)]

    #output[2] = encodingTable[((input[1] & 0x0f) << 2) + (input[2] >> 6)];
    lw t0, ENCODE_CHARS_CONDITION_1_INPUT($fp)
    sll t0, t0, 1 #avnazo el indice del input en 1
    lb t1, 0(t0) ## t1 = input[1]
    li t2, 15 ## t2 = 0x0f
    and t1, t1, t2 ## input[1] & 0x0f
    sll t1, t1, 2

    lw t0, ENCODE_CHARS_CONDITION_1_INPUT($fp)
    sll t0, 2 #avanzo el indice del input en 2
    lb t2, 0(t0) # t1 = input[2]
    srl t2, t2, 6
    addu t1, t1, t2 ## input[1] & 0x0f << 2 + input[2] >> 6

    la t2, encoding_table_mips
    addu t3, t2, t1
    lb t4, 0(t3)  #encoding_table[input[1] & 0x0f << 2 + input[2] >> 6]
    lw t0, ENCODE_CHARS_CONDITION_1_OUTPUT($fp)
    sll t0, t0, 2 #avanzo el indice del output a 2
    sb t4, 0(t0) #actualizo el stackframe

    #output[3] = encodingTable[input[2] & 0x3F];
	lw t0, ENCODE_CHARS_CONDITION_1_INPUT($fp)    
	sll t0, t0, 2 #avnazo el indice del input en 2
	lb t1, 0(t0) ## t1 = input[2]
	li t2, 0x3f ## t2 = 0x3f
	and t1, t1, t2

	la t2, encoding_table_mips
    addu t3, t2, t1
    lb t2, 0(t3)
    lw t0, ENCODE_CHARS_CONDITION_1_OUTPUT($fp)
    sll t0, t0, 3 #avanzo el indice del output a 3
    sb t2, 0(t0) #actualizo el stackframe

fin:	
	move 		sp,$fp
	lw 			gp, ENCODE_CHARS_CONDITION_1_GP(sp)
	lw 			$fp, ENCODE_CHARS_CONDITION_1_FP(sp)
	addu 		sp, sp, ENCODE_CHARS_CONDITION_1_SFSIZE
	j 			ra

.end condition_1_encode
