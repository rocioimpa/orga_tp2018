	.file	1 "decode.c"
	.section .mdebug.abi32
	.previous
	.abicalls
	.rdata
	.align	2
$LC0:
	.ascii	"r\000"
	.align	2
$LC1:
	.ascii	"w\000"
	.align	2
$LC2:
	.ascii	"Can't open the file %s\n\000"
	.align	2
$LC3:
	.ascii	"Can't finish decoding file %s: wrong length\n\000"
	.text
	.align	2
	.globl	decode
	.ent	decode
decode:
	.frame	$fp,64,$ra		# vars= 24, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,64
	.cprestore 16
	sw	$ra,56($sp)
	sw	$fp,52($sp)
	sw	$gp,48($sp)
	move	$fp,$sp
	sw	$a0,64($fp)
	sw	$a1,68($fp)
	sw	$a2,72($fp)
	sw	$a3,76($fp)
	sb	$zero,36($fp)
	sw	$zero,40($fp)
	lw	$v0,68($fp)
	beq	$v0,$zero,$L18
	lw	$a0,68($fp)
	la	$a1,$LC0
	la	$t9,fopen
	jal	$ra,$t9
	sw	$v0,64($fp)
$L18:
	lw	$v0,76($fp)
	beq	$v0,$zero,$L19
	lw	$a0,76($fp)
	la	$a1,$LC1
	la	$t9,fopen
	jal	$ra,$t9
	sw	$v0,72($fp)
$L19:
	lw	$v0,64($fp)
	bne	$v0,$zero,$L20
	la	$a0,__sF+176
	la	$a1,$LC2
	lw	$a2,68($fp)
	la	$t9,fprintf
	jal	$ra,$t9
	li	$a0,1			# 0x1
	la	$t9,exit
	jal	$ra,$t9
$L20:
	.set	noreorder
	nop
	.set	reorder
$L21:
	lw	$v0,64($fp)
	lhu	$v0,12($v0)
	srl	$v0,$v0,5
	andi	$v0,$v0,0x1
	beq	$v0,$zero,$L23
	b	$L22
$L23:
	lw	$a0,64($fp)
	addu	$a1,$fp,24
	li	$a2,4			# 0x4
	li	$a3,1			# 0x1
	la	$t9,readInput
	jal	$ra,$t9
	sw	$v0,44($fp)
	lw	$v1,40($fp)
	lw	$v0,44($fp)
	addu	$v0,$v1,$v0
	sw	$v0,40($fp)
	lw	$v0,44($fp)
	beq	$v0,$zero,$L24
	lw	$v0,44($fp)
	slt	$v0,$v0,4
	beq	$v0,$zero,$L24
	la	$a0,__sF+176
	la	$a1,$LC3
	lw	$a2,68($fp)
	la	$t9,fprintf
	jal	$ra,$t9
	b	$L22
$L24:
	lw	$v0,44($fp)
	blez	$v0,$L21
	addu	$v0,$fp,32
	addu	$a0,$fp,24
	move	$a1,$v0
	la	$t9,decodeChars
	jal	$ra,$t9
	addu	$v0,$fp,32
	move	$a0,$v0
	lw	$a1,72($fp)
	lw	$a2,76($fp)
	la	$t9,write_partial
	jal	$ra,$t9
	b	$L21
$L22:
	lw	$a0,72($fp)
	la	$t9,fclose
	jal	$ra,$t9
	move	$sp,$fp
	lw	$ra,56($sp)
	lw	$fp,52($sp)
	addu	$sp,$sp,64
	j	$ra
	.end	decode
	.size	decode, .-decode
	.align	2
	.globl	decodeChars
	.ent	decodeChars
decodeChars:
	.frame	$fp,32,$ra		# vars= 16, regs= 2/0, args= 0, extra= 8
	.mask	0x50000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,32
	.cprestore 0
	sw	$fp,28($sp)
	sw	$gp,24($sp)
	move	$fp,$sp
	sw	$a0,32($fp)
	sw	$a1,36($fp)
	sw	$zero,8($fp)
	lw	$v0,32($fp)
	lbu	$v0,0($v0)
	lbu	$v0,decodingTable($v0)
	sb	$v0,8($fp)
	lw	$v0,32($fp)
	addu	$v0,$v0,1
	lbu	$v0,0($v0)
	lbu	$v0,decodingTable($v0)
	sb	$v0,9($fp)
	lw	$v0,32($fp)
	addu	$v0,$v0,2
	lbu	$v0,0($v0)
	lbu	$v0,decodingTable($v0)
	sb	$v0,10($fp)
	lw	$v0,32($fp)
	addu	$v0,$v0,3
	lbu	$v0,0($v0)
	lbu	$v0,decodingTable($v0)
	sb	$v0,11($fp)
	lw	$a0,36($fp)
	lb	$v0,8($fp)
	sll	$v1,$v0,2
	lb	$v0,9($fp)
	sra	$v0,$v0,4
	or	$v0,$v1,$v0
	sb	$v0,0($a0)
	lb	$v1,10($fp)
	li	$v0,-3			# 0xfffffffffffffffd
	bne	$v1,$v0,$L27
	lb	$v1,11($fp)
	li	$v0,-3			# 0xfffffffffffffffd
	bne	$v1,$v0,$L27
	lw	$v0,36($fp)
	addu	$v0,$v0,1
	sb	$zero,0($v0)
	lw	$v0,36($fp)
	addu	$v0,$v0,2
	sb	$zero,0($v0)
	li	$v0,1			# 0x1
	sw	$v0,16($fp)
	b	$L26
$L27:
	lw	$v0,36($fp)
	addu	$a0,$v0,1
	lbu	$v0,9($fp)
	andi	$v0,$v0,0xf
	sll	$v1,$v0,4
	lb	$v0,10($fp)
	sra	$v0,$v0,2
	andi	$v0,$v0,0xf
	or	$v0,$v1,$v0
	sb	$v0,0($a0)
	lb	$v1,11($fp)
	li	$v0,-3			# 0xfffffffffffffffd
	bne	$v1,$v0,$L28
	lw	$v0,36($fp)
	addu	$v0,$v0,2
	sb	$zero,0($v0)
	li	$v0,2			# 0x2
	sw	$v0,16($fp)
	b	$L26
$L28:
	lw	$v0,36($fp)
	addu	$a0,$v0,2
	lb	$v0,10($fp)
	andi	$v0,$v0,0xff
	sll	$v1,$v0,6
	lbu	$v0,11($fp)
	andi	$v0,$v0,0x3f
	or	$v0,$v1,$v0
	sb	$v0,0($a0)
	li	$v0,3			# 0x3
	sw	$v0,16($fp)
$L26:
	lw	$v0,16($fp)
	move	$sp,$fp
	lw	$fp,28($sp)
	addu	$sp,$sp,32
	j	$ra
	.end	decodeChars
	.size	decodeChars, .-decodeChars
	.align	2
	.globl	isValid
	.ent	isValid
isValid:
	.frame	$fp,56,$ra		# vars= 16, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,56
	.cprestore 16
	sw	$ra,48($sp)
	sw	$fp,44($sp)
	sw	$gp,40($sp)
	move	$fp,$sp
	move	$v0,$a0
	sb	$v0,24($fp)
	sw	$zero,28($fp)
$L30:
	la	$a0,encodingTable
	la	$t9,strlen
	jal	$ra,$t9
	lw	$v1,28($fp)
	sltu	$v0,$v1,$v0
	bne	$v0,$zero,$L32
	b	$L31
$L32:
	lbu	$v1,24($fp)
	li	$v0,61			# 0x3d
	beq	$v1,$v0,$L34
	lw	$v1,28($fp)
	la	$v0,encodingTable
	addu	$v0,$v1,$v0
	lbu	$v1,0($v0)
	lbu	$v0,24($fp)
	beq	$v1,$v0,$L34
	b	$L33
$L34:
	li	$v0,1			# 0x1
	sw	$v0,32($fp)
	b	$L29
$L33:
	lw	$v0,28($fp)
	addu	$v0,$v0,1
	sw	$v0,28($fp)
	b	$L30
$L31:
	sw	$zero,32($fp)
$L29:
	lw	$v0,32($fp)
	move	$sp,$fp
	lw	$ra,48($sp)
	lw	$fp,44($sp)
	addu	$sp,$sp,56
	j	$ra
	.end	isValid
	.size	isValid, .-isValid
	.ident	"GCC: (GNU) 3.3.3 (NetBSD nb3 20040520)"
