	.file	1 "tp0.c"
	.section .mdebug.abi32
	.previous
	.abicalls
	.globl	encodingTable
	.rdata
	.align	2
	.type	encodingTable, @object
	.size	encodingTable, 65
encodingTable:
	.ascii	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123"
	.ascii	"456789+/\000"
	.globl	decodingTable
	.align	2
	.type	decodingTable, @object
	.size	decodingTable, 256
decodingTable:
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-2
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	62
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	63
	.byte	52
	.byte	53
	.byte	54
	.byte	55
	.byte	56
	.byte	57
	.byte	58
	.byte	59
	.byte	60
	.byte	61
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-3
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	6
	.byte	7
	.byte	8
	.byte	9
	.byte	10
	.byte	11
	.byte	12
	.byte	13
	.byte	14
	.byte	15
	.byte	16
	.byte	17
	.byte	18
	.byte	19
	.byte	20
	.byte	21
	.byte	22
	.byte	23
	.byte	24
	.byte	25
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	26
	.byte	27
	.byte	28
	.byte	29
	.byte	30
	.byte	31
	.byte	32
	.byte	33
	.byte	34
	.byte	35
	.byte	36
	.byte	37
	.byte	38
	.byte	39
	.byte	40
	.byte	41
	.byte	42
	.byte	43
	.byte	44
	.byte	45
	.byte	46
	.byte	47
	.byte	48
	.byte	49
	.byte	50
	.byte	51
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.align	2
$LC0:
	.ascii	"input\000"
	.align	2
$LC1:
	.ascii	"output\000"
	.align	2
$LC2:
	.ascii	"action\000"
	.align	2
$LC3:
	.ascii	"help\000"
	.align	2
$LC4:
	.ascii	"version\000"
	.data
	.align	2
	.type	long_options, @object
	.size	long_options, 96
long_options:
	.word	$LC0
	.word	1
	.word	0
	.word	105
	.word	$LC1
	.word	1
	.word	0
	.word	111
	.word	$LC2
	.word	1
	.word	0
	.word	97
	.word	$LC3
	.word	0
	.word	0
	.word	104
	.word	$LC4
	.word	0
	.word	0
	.word	86
	.word	0
	.word	0
	.word	0
	.word	0
	.rdata
	.align	2
$LC5:
	.ascii	"-\000"
	.align	2
$LC6:
	.ascii	"out\000"
	.align	2
$LC7:
	.ascii	"in\000"
	.align	2
$LC8:
	.ascii	"r\000"
	.align	2
$LC9:
	.ascii	"w\000"
	.text
	.align	2
	.globl	checkForPath
	.ent	checkForPath
checkForPath:
	.frame	$fp,48,$ra		# vars= 8, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,48
	.cprestore 16
	sw	$ra,40($sp)
	sw	$fp,36($sp)
	sw	$gp,32($sp)
	move	$fp,$sp
	sw	$a0,48($fp)
	sw	$a1,52($fp)
	sw	$a2,56($fp)
	sw	$a3,60($fp)
	lw	$v0,48($fp)
	bne	$v0,$zero,$L18
	li	$v0,-1			# 0xffffffffffffffff
	sw	$v0,28($fp)
	b	$L17
$L18:
	lw	$a0,48($fp)
	la	$t9,checkForInvalidCharacters
	jal	$ra,$t9
	move	$v1,$v0
	li	$v0,-1			# 0xffffffffffffffff
	bne	$v1,$v0,$L19
	li	$v0,-2			# 0xfffffffffffffffe
	sw	$v0,28($fp)
	b	$L17
$L19:
	lw	$a0,48($fp)
	la	$a1,$LC5
	la	$t9,strcmp
	jal	$ra,$t9
	bne	$v0,$zero,$L20
	lw	$a0,60($fp)
	la	$a1,$LC6
	la	$t9,strcmp
	jal	$ra,$t9
	bne	$v0,$zero,$L21
	la	$v0,__sF+88
	sw	$v0,52($fp)
$L21:
	lw	$a0,60($fp)
	la	$a1,$LC7
	la	$t9,strcmp
	jal	$ra,$t9
	bne	$v0,$zero,$L20
	la	$v0,__sF
	sw	$v0,52($fp)
$L20:
	la	$v0,$LC8
	sw	$v0,24($fp)
	lw	$a0,60($fp)
	la	$a1,$LC6
	la	$t9,strcmp
	jal	$ra,$t9
	bne	$v0,$zero,$L23
	la	$v0,$LC9
	sw	$v0,24($fp)
$L23:
	lw	$a0,48($fp)
	lw	$a1,24($fp)
	la	$t9,fopen
	jal	$ra,$t9
	sw	$v0,52($fp)
	lw	$v0,52($fp)
	bne	$v0,$zero,$L24
	li	$v0,-4			# 0xfffffffffffffffc
	sw	$v0,28($fp)
	b	$L17
$L24:
	lw	$v1,56($fp)
	lw	$v0,48($fp)
	sw	$v0,0($v1)
	sw	$zero,28($fp)
$L17:
	lw	$v0,28($fp)
	move	$sp,$fp
	lw	$ra,40($sp)
	lw	$fp,36($sp)
	addu	$sp,$sp,48
	j	$ra
	.end	checkForPath
	.size	checkForPath, .-checkForPath
	.rdata
	.align	2
$LC10:
	.ascii	"!@%^*|\000"
	.text
	.align	2
	.globl	checkForInvalidCharacters
	.ent	checkForInvalidCharacters
checkForInvalidCharacters:
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
	sw	$a0,56($fp)
	lw	$v0,$LC10
	sw	$v0,24($fp)
	lhu	$v0,$LC10+4
	sh	$v0,28($fp)
	lbu	$v0,$LC10+6
	sb	$v0,30($fp)
	sw	$zero,32($fp)
$L26:
	addu	$a0,$fp,24
	la	$t9,strlen
	jal	$ra,$t9
	lw	$v1,32($fp)
	sltu	$v0,$v1,$v0
	bne	$v0,$zero,$L29
	b	$L27
$L29:
	lw	$v1,32($fp)
	addu	$v0,$fp,24
	addu	$v0,$v0,$v1
	lb	$v0,0($v0)
	lw	$a0,56($fp)
	move	$a1,$v0
	la	$t9,strchr
	jal	$ra,$t9
	beq	$v0,$zero,$L28
	li	$v0,-1			# 0xffffffffffffffff
	sw	$v0,36($fp)
	b	$L25
$L28:
	lw	$v0,32($fp)
	addu	$v0,$v0,1
	sw	$v0,32($fp)
	b	$L26
$L27:
	sw	$zero,36($fp)
$L25:
	lw	$v0,36($fp)
	move	$sp,$fp
	lw	$ra,48($sp)
	lw	$fp,44($sp)
	addu	$sp,$sp,56
	j	$ra
	.end	checkForInvalidCharacters
	.size	checkForInvalidCharacters, .-checkForInvalidCharacters
	.rdata
	.align	2
$LC11:
	.ascii	"decode\000"
	.align	2
$LC12:
	.ascii	"encode\000"
	.text
	.align	2
	.globl	parseAction
	.ent	parseAction
parseAction:
	.frame	$fp,48,$ra		# vars= 8, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,48
	.cprestore 16
	sw	$ra,40($sp)
	sw	$fp,36($sp)
	sw	$gp,32($sp)
	move	$fp,$sp
	sw	$a0,48($fp)
	sw	$a1,52($fp)
	lw	$v0,48($fp)
	bne	$v0,$zero,$L32
	li	$v0,-1			# 0xffffffffffffffff
	sw	$v0,24($fp)
	b	$L31
$L32:
	lw	$a0,48($fp)
	la	$a1,$LC11
	la	$t9,strcmp
	jal	$ra,$t9
	bne	$v0,$zero,$L33
	lw	$a0,48($fp)
	la	$a1,$LC12
	la	$t9,strcmp
	jal	$ra,$t9
	bne	$v0,$zero,$L33
	li	$v0,-6			# 0xfffffffffffffffa
	sw	$v0,24($fp)
	b	$L31
$L33:
	lw	$v1,52($fp)
	lw	$v0,48($fp)
	sw	$v0,0($v1)
	sw	$zero,24($fp)
$L31:
	lw	$v0,24($fp)
	move	$sp,$fp
	lw	$ra,40($sp)
	lw	$fp,36($sp)
	addu	$sp,$sp,48
	j	$ra
	.end	parseAction
	.size	parseAction, .-parseAction
	.rdata
	.align	2
$LC13:
	.ascii	"hVo:i:a:\000"
	.align	2
$LC14:
	.ascii	"No arguments provided for option -%c .\n\000"
	.align	2
$LC15:
	.ascii	"Unknown option `-%c'.\n\000"
	.align	2
$LC16:
	.ascii	"Unknown option `\\x%x'.\n\000"
	.text
	.align	2
	.globl	getParams
	.ent	getParams
getParams:
	.frame	$fp,88,$ra		# vars= 40, regs= 3/0, args= 24, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,88
	.cprestore 24
	sw	$ra,80($sp)
	sw	$fp,76($sp)
	sw	$gp,72($sp)
	move	$fp,$sp
	sw	$a0,88($fp)
	sw	$a1,92($fp)
	sw	$a2,96($fp)
	la	$v0,__sF+88
	sw	$v0,40($fp)
	sw	$zero,48($fp)
	la	$v0,__sF
	sw	$v0,44($fp)
	sw	$zero,52($fp)
	la	$v0,$LC12
	sw	$v0,56($fp)
$L35:
	sw	$zero,16($sp)
	lw	$a0,92($fp)
	lw	$a1,96($fp)
	la	$a2,$LC13
	la	$a3,long_options
	la	$t9,getopt_long
	jal	$ra,$t9
	sw	$v0,32($fp)
	lw	$v1,32($fp)
	li	$v0,-1			# 0xffffffffffffffff
	bne	$v1,$v0,$L37
	b	$L36
$L37:
	lw	$v0,32($fp)
	addu	$v0,$v0,-63
	sw	$v0,64($fp)
	lw	$v1,64($fp)
	sltu	$v0,$v1,49
	beq	$v0,$zero,$L50
	lw	$v0,64($fp)
	sll	$v1,$v0,2
	la	$v0,$L51
	addu	$v0,$v1,$v0
	lw	$v0,0($v0)
	.cpadd	$v0
	j	$v0
	.rdata
	.align	2
$L51:
	.gpword	$L44
	.gpword	$L50
	.gpword	$L50
	.gpword	$L50
	.gpword	$L50
	.gpword	$L50
	.gpword	$L50
	.gpword	$L50
	.gpword	$L50
	.gpword	$L50
	.gpword	$L50
	.gpword	$L50
	.gpword	$L50
	.gpword	$L50
	.gpword	$L50
	.gpword	$L50
	.gpword	$L50
	.gpword	$L50
	.gpword	$L50
	.gpword	$L50
	.gpword	$L50
	.gpword	$L50
	.gpword	$L50
	.gpword	$L42
	.gpword	$L50
	.gpword	$L50
	.gpword	$L50
	.gpword	$L50
	.gpword	$L50
	.gpword	$L50
	.gpword	$L50
	.gpword	$L50
	.gpword	$L50
	.gpword	$L50
	.gpword	$L41
	.gpword	$L50
	.gpword	$L50
	.gpword	$L50
	.gpword	$L50
	.gpword	$L50
	.gpword	$L50
	.gpword	$L43
	.gpword	$L40
	.gpword	$L50
	.gpword	$L50
	.gpword	$L50
	.gpword	$L50
	.gpword	$L50
	.gpword	$L39
	.text
$L39:
	addu	$v0,$fp,40
	addu	$v0,$v0,8
	lw	$a0,optarg
	lw	$a1,40($fp)
	move	$a2,$v0
	la	$a3,$LC6
	la	$t9,checkForPath
	jal	$ra,$t9
	move	$a0,$v0
	la	$t9,validate
	jal	$ra,$t9
	b	$L35
$L40:
	addu	$v0,$fp,40
	addu	$v0,$v0,12
	lw	$a0,optarg
	lw	$a1,44($fp)
	move	$a2,$v0
	la	$a3,$LC7
	la	$t9,checkForPath
	jal	$ra,$t9
	move	$a0,$v0
	la	$t9,validate
	jal	$ra,$t9
	b	$L35
$L41:
	addu	$v0,$fp,40
	addu	$v0,$v0,16
	lw	$a0,optarg
	move	$a1,$v0
	la	$t9,parseAction
	jal	$ra,$t9
	move	$a0,$v0
	la	$t9,validate
	jal	$ra,$t9
	b	$L35
$L42:
	la	$t9,showVersion
	jal	$ra,$t9
	move	$a0,$zero
	la	$t9,exit
	jal	$ra,$t9
$L43:
	la	$t9,showHelp
	jal	$ra,$t9
	move	$a0,$zero
	la	$t9,exit
	jal	$ra,$t9
$L44:
	lw	$v1,optopt
	li	$v0,111			# 0x6f
	beq	$v1,$v0,$L46
	lw	$v1,optopt
	li	$v0,105			# 0x69
	beq	$v1,$v0,$L46
	lw	$v1,optopt
	li	$v0,97			# 0x61
	beq	$v1,$v0,$L46
	b	$L45
$L46:
	la	$a0,__sF+176
	la	$a1,$LC14
	lw	$a2,optopt
	la	$t9,fprintf
	jal	$ra,$t9
	b	$L50
$L45:
	lw	$v1,_ctype_
	lw	$v0,optopt
	addu	$v0,$v1,$v0
	addu	$v0,$v0,1
	lbu	$v0,0($v0)
	andi	$v0,$v0,0x97
	beq	$v0,$zero,$L48
	la	$a0,__sF+176
	la	$a1,$LC15
	lw	$a2,optopt
	la	$t9,fprintf
	jal	$ra,$t9
	b	$L50
$L48:
	la	$a0,__sF+176
	la	$a1,$LC16
	lw	$a2,optopt
	la	$t9,fprintf
	jal	$ra,$t9
$L50:
	la	$t9,showHelp
	jal	$ra,$t9
	li	$a0,1			# 0x1
	la	$t9,exit
	jal	$ra,$t9
$L36:
	la	$v0,__sF
	bne	$v0,$zero,$L52
	la	$t9,showHelp
	jal	$ra,$t9
	li	$a0,1			# 0x1
	la	$t9,exit
	jal	$ra,$t9
$L52:
	lw	$v0,40($fp)
	lw	$v1,88($fp)
	sw	$v0,0($v1)
	lw	$v0,44($fp)
	lw	$v1,88($fp)
	sw	$v0,4($v1)
	lw	$v0,48($fp)
	lw	$v1,88($fp)
	sw	$v0,8($v1)
	lw	$v0,52($fp)
	lw	$v1,88($fp)
	sw	$v0,12($v1)
	lw	$v0,56($fp)
	lw	$v1,88($fp)
	sw	$v0,16($v1)
	lw	$v0,88($fp)
	move	$sp,$fp
	lw	$ra,80($sp)
	lw	$fp,76($sp)
	addu	$sp,$sp,88
	j	$ra
	.end	getParams
	.size	getParams, .-getParams
	.align	2
	.globl	validate
	.ent	validate
validate:
	.frame	$fp,40,$ra		# vars= 0, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,40
	.cprestore 16
	sw	$ra,32($sp)
	sw	$fp,28($sp)
	sw	$gp,24($sp)
	move	$fp,$sp
	sw	$a0,40($fp)
	lw	$v0,40($fp)
	bgez	$v0,$L53
	lw	$a0,40($fp)
	la	$t9,showError
	jal	$ra,$t9
	li	$a0,1			# 0x1
	la	$t9,exit
	jal	$ra,$t9
$L53:
	move	$sp,$fp
	lw	$ra,32($sp)
	lw	$fp,28($sp)
	addu	$sp,$sp,40
	j	$ra
	.end	validate
	.size	validate, .-validate
	.rdata
	.align	2
$LC17:
	.ascii	"%s\n\000"
	.align	2
$LC18:
	.ascii	"TP0 Organizacion de computadoras - HELP\000"
	.align	2
$LC19:
	.ascii	"Usage: \000"
	.align	2
$LC20:
	.ascii	"tp0 -h   Displays help and usage of the application\000"
	.align	2
$LC21:
	.ascii	"tp0 -V   Displays version of the application\000"
	.align	2
$LC22:
	.ascii	"tp0 Options:\000"
	.align	2
$LC23:
	.ascii	"-i --input      Set the location of the input file\000"
	.align	2
$LC24:
	.ascii	"-o --output     Set the location of the output file\000"
	.align	2
$LC25:
	.ascii	"-a --action     Program action: encode (default) or deco"
	.ascii	"de\000"
	.align	2
$LC26:
	.ascii	"Examples: \000"
	.align	2
$LC27:
	.ascii	"  tp0 -a encode -i ~/input -o ~/output\000"
	.align	2
$LC28:
	.ascii	"  tp0 -a decode\000"
	.text
	.align	2
	.globl	showHelp
	.ent	showHelp
showHelp:
	.frame	$fp,40,$ra		# vars= 0, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,40
	.cprestore 16
	sw	$ra,32($sp)
	sw	$fp,28($sp)
	sw	$gp,24($sp)
	move	$fp,$sp
	la	$a0,$LC17
	la	$a1,$LC18
	la	$t9,printf
	jal	$ra,$t9
	la	$a0,$LC17
	la	$a1,$LC19
	la	$t9,printf
	jal	$ra,$t9
	la	$a0,$LC17
	la	$a1,$LC20
	la	$t9,printf
	jal	$ra,$t9
	la	$a0,$LC17
	la	$a1,$LC21
	la	$t9,printf
	jal	$ra,$t9
	la	$a0,$LC17
	la	$a1,$LC22
	la	$t9,printf
	jal	$ra,$t9
	la	$a0,$LC17
	la	$a1,$LC23
	la	$t9,printf
	jal	$ra,$t9
	la	$a0,$LC17
	la	$a1,$LC24
	la	$t9,printf
	jal	$ra,$t9
	la	$a0,$LC17
	la	$a1,$LC25
	la	$t9,printf
	jal	$ra,$t9
	la	$a0,$LC17
	la	$a1,$LC26
	la	$t9,printf
	jal	$ra,$t9
	la	$a0,$LC17
	la	$a1,$LC27
	la	$t9,printf
	jal	$ra,$t9
	la	$a0,$LC17
	la	$a1,$LC28
	la	$t9,printf
	jal	$ra,$t9
	move	$sp,$fp
	lw	$ra,32($sp)
	lw	$fp,28($sp)
	addu	$sp,$sp,40
	j	$ra
	.end	showHelp
	.size	showHelp, .-showHelp
	.rdata
	.align	2
$LC29:
	.ascii	"TP0 Organizacion de computadoras - VERSION: 1.0\000"
	.text
	.align	2
	.globl	showVersion
	.ent	showVersion
showVersion:
	.frame	$fp,40,$ra		# vars= 0, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,40
	.cprestore 16
	sw	$ra,32($sp)
	sw	$fp,28($sp)
	sw	$gp,24($sp)
	move	$fp,$sp
	la	$a0,$LC17
	la	$a1,$LC29
	la	$t9,printf
	jal	$ra,$t9
	move	$sp,$fp
	lw	$ra,32($sp)
	lw	$fp,28($sp)
	addu	$sp,$sp,40
	j	$ra
	.end	showVersion
	.size	showVersion, .-showVersion
	.rdata
	.align	2
$LC30:
	.ascii	"Parameter is empty. Type 'tp0 -h' for help. Program term"
	.ascii	"inated\000"
	.align	2
$LC31:
	.ascii	"Argument has invalid characters. Type 'tp0 -h' for help."
	.ascii	" Program terminated\000"
	.align	2
$LC32:
	.ascii	"Invalid arguments. Type 'tp0 -h' for help. Program termi"
	.ascii	"nated\000"
	.align	2
$LC33:
	.ascii	"File path is invalid. Type 'tp0 -h' for help. Program te"
	.ascii	"rminated\000"
	.align	2
$LC34:
	.ascii	"Parameter input is invalid. Type 'tp0 -h' for help. Prog"
	.ascii	"ram terminated\000"
	.align	2
$LC35:
	.ascii	"Action is invalid. Type 'tp0 -h' for help. Program termi"
	.ascii	"nated\000"
	.text
	.align	2
	.globl	showError
	.ent	showError
showError:
	.frame	$fp,40,$ra		# vars= 0, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,40
	.cprestore 16
	sw	$ra,32($sp)
	sw	$fp,28($sp)
	sw	$gp,24($sp)
	move	$fp,$sp
	sw	$a0,40($fp)
	lw	$v1,40($fp)
	li	$v0,-1			# 0xffffffffffffffff
	bne	$v1,$v0,$L58
	la	$a0,__sF+176
	la	$a1,$LC17
	la	$a2,$LC30
	la	$t9,fprintf
	jal	$ra,$t9
$L58:
	lw	$v1,40($fp)
	li	$v0,-2			# 0xfffffffffffffffe
	bne	$v1,$v0,$L59
	la	$a0,__sF+176
	la	$a1,$LC17
	la	$a2,$LC31
	la	$t9,fprintf
	jal	$ra,$t9
$L59:
	lw	$v1,40($fp)
	li	$v0,-3			# 0xfffffffffffffffd
	bne	$v1,$v0,$L60
	la	$a0,__sF+176
	la	$a1,$LC17
	la	$a2,$LC32
	la	$t9,fprintf
	jal	$ra,$t9
$L60:
	lw	$v1,40($fp)
	li	$v0,-4			# 0xfffffffffffffffc
	bne	$v1,$v0,$L61
	la	$a0,__sF+176
	la	$a1,$LC17
	la	$a2,$LC33
	la	$t9,fprintf
	jal	$ra,$t9
$L61:
	lw	$v1,40($fp)
	li	$v0,-5			# 0xfffffffffffffffb
	bne	$v1,$v0,$L62
	la	$a0,__sF+176
	la	$a1,$LC17
	la	$a2,$LC34
	la	$t9,fprintf
	jal	$ra,$t9
$L62:
	lw	$v1,40($fp)
	li	$v0,-6			# 0xfffffffffffffffa
	bne	$v1,$v0,$L57
	la	$a0,__sF+176
	la	$a1,$LC17
	la	$a2,$LC35
	la	$t9,fprintf
	jal	$ra,$t9
$L57:
	move	$sp,$fp
	lw	$ra,32($sp)
	lw	$fp,28($sp)
	addu	$sp,$sp,40
	j	$ra
	.end	showError
	.size	showError, .-showError
	.align	2
	.globl	process
	.ent	process
process:
	.frame	$fp,40,$ra		# vars= 0, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,40
	.cprestore 16
	sw	$ra,32($sp)
	sw	$fp,28($sp)
	sw	$gp,24($sp)
	move	$fp,$sp
	sw	$a0,40($fp)
	sw	$a1,44($fp)
	sw	$a2,48($fp)
	sw	$a3,52($fp)
	lw	$a0,56($fp)
	la	$a1,$LC12
	la	$t9,strcmp
	jal	$ra,$t9
	bne	$v0,$zero,$L65
	lw	$a0,44($fp)
	lw	$a1,52($fp)
	lw	$a2,40($fp)
	lw	$a3,48($fp)
	la	$t9,encode
	jal	$ra,$t9
$L65:
	lw	$a0,56($fp)
	la	$a1,$LC11
	la	$t9,strcmp
	jal	$ra,$t9
	bne	$v0,$zero,$L64
	lw	$a0,44($fp)
	lw	$a1,52($fp)
	lw	$a2,40($fp)
	lw	$a3,48($fp)
	la	$t9,decode
	jal	$ra,$t9
$L64:
	move	$sp,$fp
	lw	$ra,32($sp)
	lw	$fp,28($sp)
	addu	$sp,$sp,40
	j	$ra
	.end	process
	.size	process, .-process
	.rdata
	.align	2
$LC36:
	.ascii	"Unable to decode: invalid character. Program will termin"
	.ascii	"ate.\n\000"
	.align	2
$LC37:
	.ascii	"An error occurred when reading input.\000"
	.text
	.align	2
	.globl	readInput
	.ent	readInput
readInput:
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
	sw	$a0,56($fp)
	sw	$a1,60($fp)
	sw	$a2,64($fp)
	sw	$a3,68($fp)
	sw	$zero,24($fp)
$L68:
	lw	$v0,24($fp)
	lw	$v1,64($fp)
	slt	$v0,$v0,$v1
	bne	$v0,$zero,$L71
	b	$L69
$L71:
	lw	$a0,56($fp)
	la	$t9,fgetc
	jal	$ra,$t9
	sw	$v0,28($fp)
	lw	$v0,56($fp)
	lhu	$v0,12($v0)
	srl	$v0,$v0,6
	andi	$v0,$v0,0x1
	bne	$v0,$zero,$L72
	lw	$v1,28($fp)
	li	$v0,-1			# 0xffffffffffffffff
	beq	$v1,$v0,$L73
	lw	$v0,68($fp)
	bne	$v0,$zero,$L74
	lw	$v1,60($fp)
	lw	$v0,24($fp)
	addu	$v1,$v1,$v0
	lbu	$v0,28($fp)
	sb	$v0,0($v1)
	b	$L70
$L74:
	lw	$v1,28($fp)
	li	$v0,10			# 0xa
	bne	$v1,$v0,$L76
	lw	$v0,24($fp)
	addu	$v0,$v0,-1
	sw	$v0,24($fp)
	b	$L70
$L76:
	lbu	$v0,28($fp)
	move	$a0,$v0
	la	$t9,isValid
	jal	$ra,$t9
	bne	$v0,$zero,$L77
	la	$a0,__sF+176
	la	$a1,$LC36
	la	$t9,fprintf
	jal	$ra,$t9
	li	$a0,1			# 0x1
	la	$t9,exit
	jal	$ra,$t9
$L77:
	lw	$v1,60($fp)
	lw	$v0,24($fp)
	addu	$v1,$v1,$v0
	lbu	$v0,28($fp)
	sb	$v0,0($v1)
	b	$L70
$L73:
	lw	$v0,24($fp)
	sw	$v0,32($fp)
	b	$L67
$L72:
	la	$a0,__sF+176
	la	$a1,$LC37
	la	$t9,fprintf
	jal	$ra,$t9
	li	$a0,1			# 0x1
	la	$t9,exit
	jal	$ra,$t9
$L70:
	lw	$v0,24($fp)
	addu	$v0,$v0,1
	sw	$v0,24($fp)
	b	$L68
$L69:
	lw	$v0,64($fp)
	sw	$v0,32($fp)
$L67:
	lw	$v0,32($fp)
	move	$sp,$fp
	lw	$ra,48($sp)
	lw	$fp,44($sp)
	addu	$sp,$sp,56
	j	$ra
	.end	readInput
	.size	readInput, .-readInput
	.rdata
	.align	2
$LC38:
	.ascii	"%c\000"
	.align	2
$LC39:
	.ascii	"%c\n\000"
	.align	2
$LC40:
	.ascii	"Error when writing output to file %s\n\000"
	.align	2
$LC41:
	.ascii	"Unable to open or create output file %s\n\000"
	.text
	.align	2
	.globl	write_partial
	.ent	write_partial
write_partial:
	.frame	$fp,40,$ra		# vars= 0, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,40
	.cprestore 16
	sw	$ra,32($sp)
	sw	$fp,28($sp)
	sw	$gp,24($sp)
	move	$fp,$sp
	sw	$a0,40($fp)
	sw	$a1,44($fp)
	sw	$a2,48($fp)
	lw	$v0,44($fp)
	beq	$v0,$zero,$L81
$L82:
	lw	$v0,40($fp)
	lbu	$v0,0($v0)
	bne	$v0,$zero,$L84
	b	$L80
$L84:
	lw	$v0,40($fp)
	lbu	$v0,0($v0)
	lw	$a0,44($fp)
	la	$a1,$LC38
	move	$a2,$v0
	la	$t9,fprintf
	jal	$ra,$t9
	bne	$v0,$zero,$L85
	lw	$v0,40($fp)
	lbu	$v0,0($v0)
	la	$a0,$LC39
	move	$a1,$v0
	la	$t9,printf
	jal	$ra,$t9
	la	$a0,__sF+176
	la	$a1,$LC40
	lw	$a2,48($fp)
	la	$t9,fprintf
	jal	$ra,$t9
	li	$a0,1			# 0x1
	la	$t9,exit
	jal	$ra,$t9
$L85:
	lw	$v0,40($fp)
	addu	$v0,$v0,1
	sw	$v0,40($fp)
	b	$L82
$L81:
	la	$a0,__sF+176
	la	$a1,$LC41
	lw	$a2,48($fp)
	la	$t9,fprintf
	jal	$ra,$t9
	li	$a0,1			# 0x1
	la	$t9,exit
	jal	$ra,$t9
$L80:
	move	$sp,$fp
	lw	$ra,32($sp)
	lw	$fp,28($sp)
	addu	$sp,$sp,40
	j	$ra
	.end	write_partial
	.size	write_partial, .-write_partial
	.align	2
	.globl	main
	.ent	main
main:
	.frame	$fp,80,$ra		# vars= 32, regs= 3/0, args= 24, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,80
	.cprestore 24
	sw	$ra,72($sp)
	sw	$fp,68($sp)
	sw	$gp,64($sp)
	move	$fp,$sp
	sw	$a0,80($fp)
	sw	$a1,84($fp)
	sw	$zero,32($fp)
	addu	$v0,$fp,40
	move	$a0,$v0
	lw	$a1,80($fp)
	lw	$a2,84($fp)
	la	$t9,getParams
	jal	$ra,$t9
	lw	$v0,56($fp)
	sw	$v0,16($sp)
	lw	$a0,40($fp)
	lw	$a1,44($fp)
	lw	$a2,48($fp)
	lw	$a3,52($fp)
	la	$t9,process
	jal	$ra,$t9
	lw	$v0,32($fp)
	move	$sp,$fp
	lw	$ra,72($sp)
	lw	$fp,68($sp)
	addu	$sp,$sp,80
	j	$ra
	.end	main
	.size	main, .-main
	.ident	"GCC: (GNU) 3.3.3 (NetBSD nb3 20040520)"
