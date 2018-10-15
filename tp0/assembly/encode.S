	.file	1 "encode.c"
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
	.text
	.align	2
	.globl	encode
	.ent	encode
encode:
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
	sw	$zero,44($fp)
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
	b	$L17
$L23:
	lw	$a0,64($fp)
	addu	$a1,$fp,24
	li	$a2,3			# 0x3
	move	$a3,$zero
	la	$t9,readInput
	jal	$ra,$t9
	sw	$v0,40($fp)
	lw	$v0,40($fp)
	blez	$v0,$L21
	addu	$v0,$fp,32
	addu	$a0,$fp,24
	move	$a1,$v0
	lw	$a2,40($fp)
	la	$t9,encodeChars
	jal	$ra,$t9
	addu	$v0,$fp,32
	move	$a0,$v0
	lw	$a1,72($fp)
	lw	$a2,76($fp)
	la	$t9,write_partial
	jal	$ra,$t9
	lw	$v0,44($fp)
	addu	$v0,$v0,4
	sw	$v0,44($fp)
	lw	$a0,44($fp)
	la	$t9,exceedsLineSize
	jal	$ra,$t9
	move	$v1,$v0
	li	$v0,1			# 0x1
	bne	$v1,$v0,$L21
	sw	$zero,44($fp)
	li	$v0,10			# 0xa
	sb	$v0,32($fp)
	sb	$zero,33($fp)
	addu	$v0,$fp,32
	move	$a0,$v0
	lw	$a1,72($fp)
	lw	$a2,76($fp)
	la	$t9,write_partial
	jal	$ra,$t9
	b	$L21
$L17:
	move	$sp,$fp
	lw	$ra,56($sp)
	lw	$fp,52($sp)
	addu	$sp,$sp,64
	j	$ra
	.end	encode
	.size	encode, .-encode
	.align	2
	.globl	exceedsLineSize
	.ent	exceedsLineSize
exceedsLineSize:
	.frame	$fp,16,$ra		# vars= 0, regs= 2/0, args= 0, extra= 8
	.mask	0x50000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,16
	.cprestore 0
	sw	$fp,12($sp)
	sw	$gp,8($sp)
	move	$fp,$sp
	sw	$a0,16($fp)
	lw	$v0,16($fp)
	xori	$v0,$v0,0x4c
	sltu	$v0,$v0,1
	move	$sp,$fp
	lw	$fp,12($sp)
	addu	$sp,$sp,16
	j	$ra
	.end	exceedsLineSize
	.size	exceedsLineSize, .-exceedsLineSize
	.align	2
	.globl	encodeChars
	.ent	encodeChars
encodeChars:
	.frame	$fp,16,$ra		# vars= 0, regs= 2/0, args= 0, extra= 8
	.mask	0x50000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,16
	.cprestore 0
	sw	$fp,12($sp)
	sw	$gp,8($sp)
	move	$fp,$sp
	sw	$a0,16($fp)
	sw	$a1,20($fp)
	sw	$a2,24($fp)
	lw	$v1,24($fp)
	li	$v0,3			# 0x3
	bne	$v1,$v0,$L28
	lw	$v1,20($fp)
	lw	$v0,16($fp)
	lbu	$v0,0($v0)
	srl	$v0,$v0,2
	andi	$v0,$v0,0x00ff
	lbu	$v0,encodingTable($v0)
	sb	$v0,0($v1)
	lw	$v0,20($fp)
	addu	$a0,$v0,1
	lw	$v0,16($fp)
	lbu	$v0,0($v0)
	andi	$v0,$v0,0x3
	sll	$v1,$v0,4
	lw	$v0,16($fp)
	addu	$v0,$v0,1
	lbu	$v0,0($v0)
	srl	$v0,$v0,4
	andi	$v0,$v0,0x00ff
	addu	$v1,$v1,$v0
	la	$v0,encodingTable
	addu	$v0,$v1,$v0
	lbu	$v0,0($v0)
	sb	$v0,0($a0)
	lw	$v0,20($fp)
	addu	$a0,$v0,2
	lw	$v0,16($fp)
	addu	$v0,$v0,1
	lbu	$v0,0($v0)
	andi	$v0,$v0,0xf
	sll	$v1,$v0,2
	lw	$v0,16($fp)
	addu	$v0,$v0,2
	lbu	$v0,0($v0)
	srl	$v0,$v0,6
	andi	$v0,$v0,0x00ff
	addu	$v1,$v1,$v0
	la	$v0,encodingTable
	addu	$v0,$v1,$v0
	lbu	$v0,0($v0)
	sb	$v0,0($a0)
	lw	$v0,20($fp)
	addu	$v1,$v0,3
	lw	$v0,16($fp)
	addu	$v0,$v0,2
	lbu	$v0,0($v0)
	andi	$v0,$v0,0x3f
	lbu	$v0,encodingTable($v0)
	sb	$v0,0($v1)
	b	$L29
$L28:
	lw	$v1,24($fp)
	li	$v0,2			# 0x2
	bne	$v1,$v0,$L30
	lw	$v1,20($fp)
	lw	$v0,16($fp)
	lbu	$v0,0($v0)
	srl	$v0,$v0,2
	andi	$v0,$v0,0x00ff
	lbu	$v0,encodingTable($v0)
	sb	$v0,0($v1)
	lw	$v0,20($fp)
	addu	$a0,$v0,1
	lw	$v0,16($fp)
	lbu	$v0,0($v0)
	andi	$v0,$v0,0x3
	sll	$v1,$v0,4
	lw	$v0,16($fp)
	addu	$v0,$v0,1
	lbu	$v0,0($v0)
	srl	$v0,$v0,4
	andi	$v0,$v0,0x00ff
	addu	$v1,$v1,$v0
	la	$v0,encodingTable
	addu	$v0,$v1,$v0
	lbu	$v0,0($v0)
	sb	$v0,0($a0)
	lw	$v0,20($fp)
	addu	$v1,$v0,2
	lw	$v0,16($fp)
	addu	$v0,$v0,1
	lbu	$v0,0($v0)
	andi	$v0,$v0,0xf
	sll	$v0,$v0,2
	lbu	$v0,encodingTable($v0)
	sb	$v0,0($v1)
	lw	$v0,20($fp)
	addu	$v1,$v0,3
	li	$v0,61			# 0x3d
	sb	$v0,0($v1)
	b	$L29
$L30:
	lw	$v1,24($fp)
	li	$v0,1			# 0x1
	bne	$v1,$v0,$L29
	lw	$v1,20($fp)
	lw	$v0,16($fp)
	lbu	$v0,0($v0)
	srl	$v0,$v0,2
	andi	$v0,$v0,0x00ff
	lbu	$v0,encodingTable($v0)
	sb	$v0,0($v1)
	lw	$v0,20($fp)
	addu	$v1,$v0,1
	lw	$v0,16($fp)
	lbu	$v0,0($v0)
	andi	$v0,$v0,0x3
	sll	$v0,$v0,4
	lbu	$v0,encodingTable($v0)
	sb	$v0,0($v1)
	lw	$v0,20($fp)
	addu	$v1,$v0,2
	li	$v0,61			# 0x3d
	sb	$v0,0($v1)
	lw	$v0,20($fp)
	addu	$v1,$v0,3
	li	$v0,61			# 0x3d
	sb	$v0,0($v1)
$L29:
	li	$v0,4			# 0x4
	move	$sp,$fp
	lw	$fp,12($sp)
	addu	$sp,$sp,16
	j	$ra
	.end	encodeChars
	.size	encodeChars, .-encodeChars
	.ident	"GCC: (GNU) 3.3.3 (NetBSD nb3 20040520)"
