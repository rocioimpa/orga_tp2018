# Contiene el codigo MIPS32 assembly con las funciones base64 encode() y base64 decode(), y las funciones y 
# estructuras de datos auxiliares para realizar los computos de encoding y decoding.
# Tambien contendra la definicion en assembly de un vector equivalente al siguiente vector C: const char* errmsg[]. 
# Dicho vector contendra los mensajes de error que las funciones antes mencionadas puedan generar, y cuyo indice es 
# el codigo de error devuelto por las mismas.

# Tp1 MIPS32 - Organizacion de Computadoras        
###########################################

#include <mips/regdef.h>
#include <sys/syscall.h>

####################################

# Definitions base64_encode

# Stack Frame size 
# define BASE64_ENCODE_SFSIZE 44

# SRA
# define BASE64_ENCODE_RA 32 
# define BASE64_ENCODE_FP 28 
# define BASE64_ENCODE_GP 24 

# LTA
# define BASE64_ENCODE_BUF_SIZE_IN 20
# define BASE64_ENCODE_BUF_SIZE_OUT 16
# define BASE64_ENCODE_BUF_IN 12 
# define BASE64_ENCODE_BUF_OUT 8 
# define BASE64_ENCODE_CIL 4
# define BASE64_ENCODE_LEN 0 

# ABA
# BASE64_ENCODE_ARG0 40
# BASE64_ENCODE_ARG1 44

	.text
	.align 2
	.globl base64_encode
	.ent base64_encode

base64_encode:
	.frame 		$fp, BASE64_ENCODE_SFSIZE, ra
	.set 		noreorder
	.cpload 	t9
	.set 		reorder
	subu 		sp, sp, BASE64_ENCODE_SFSIZE
	sw			ra, BASE64_ENCODE_RA(sp)
	sw 			$fp, BASE64_ENCODE_FP(sp)
	.cprestore	BASE64_ENCODE_GP
	move 		$fp, sp

	sw 			a0, BASE64_ENCODE_ARG0($fp) 	#a0 <- input
	sw 			a1, BASE64_ENCODE_ARG1($fp)		#a1 <- output

	li 			t0,0
	sw			t0,BASE64_ENCODE_CIL($fp) #charsInLine = 0

	li 			t0,3
	sw			t0,BASE64_ENCODE_BUF_SIZE_IN

	li 			t0,4
	sw 			t0,BASE64_ENCODE_BUF_SIZE_OUT

read: 
	addiu 		t0, $fp, BASE64_ENCODE_BUF_IN

	li 			v0, SYS_read
	lw 			a0, BASE64_ENCODE_ARG0($fp)
	move 		a1, t0
	lw 			a2, BASE64_ENCODE_BUF_SIZE_IN($fp)
	syscall

	sw 			v0, BASE64_ENCODE_LEN($fp)
	lw 			t0, BASE64_ENCODE_BUF_IN($fp)

	bgtz		v0, while_loop
	b 			end_while



####################################

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
