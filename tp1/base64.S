# Contiene el codigo MIPS32 assembly con las funciones base64 encode() y base64 decode(), y las funciones y 
# estructuras de datos auxiliares para realizar los computos de encoding y decoding.
# Tambien contendra la definicion en assembly de un vector equivalente al siguiente vector C: const char* errmsg[]. 
# Dicho vector contendra los mensajes de error que las funciones antes mencionadas puedan generar, y cuyo indice es 
# el codigo de error devuelto por las mismas.

#include <mips/regdef.h>

.text
.global exceedsLineSize
.ent exceedsLineSize
exceedsLineSize:
	subu sp,sp,16
	sw gp,12(sp)
	sw $fp,8(sp)
	move $fp, sp

	li t0, 0
	lw t1, 16($fp)
	addi t1, t1, -76
	bnez t1, false
	li t0, 1
false:
	addi v0, t0, 0
	lw gp, 12($fp)
	lw $fp, 8($fp)
	j ra

.end exceedsLineSize
