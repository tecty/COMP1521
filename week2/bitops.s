	.file	"bitops.c"
	.section	.rodata
.LC0:
	.string	"BitOps> "
.LC1:
	.string	"%c = %c << %d"
.LC2:
	.string	"Invalid shift"
.LC3:
	.string	"%c = %c >> %d"
.LC4:
	.string	"%c = %c & %c"
.LC5:
	.string	"%c = %c | %c"
.LC6:
	.string	"%c = ~ %c"
.LC7:
	.string	"set %c = %s"
.LC8:
	.string	"show %c"
.LC9:
	.string	"Invalid command"
	.text
	.globl	main
	.type	main, @function
main:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$1280, %rsp
	movl	%edi, -1268(%rbp)
	movq	%rsi, -1280(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	leaq	-1260(%rbp), %rdx
	movq	-1280(%rbp), %rcx
	movl	-1268(%rbp), %eax
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	processOptions
	movl	$0, -1240(%rbp)
	jmp	.L2
.L3:
	movl	-1260(%rbp), %eax
	movl	%eax, %edi
	call	makeBits
	movq	%rax, %rdx
	movl	-1240(%rbp), %eax
	cltq
	movq	%rdx, -1232(%rbp,%rax,8)
	addl	$1, -1240(%rbp)
.L2:
	cmpl	$25, -1240(%rbp)
	jle	.L3
	movl	$.LC0, %edi
	movl	$0, %eax
	call	printf
	jmp	.L4
.L28:
	movl	$0, %edi
	call	isatty
	testl	%eax, %eax
	jne	.L5
	movq	stdout(%rip), %rdx
	leaq	-512(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	fputs
.L5:
	leaq	-512(%rbp), %rax
	movq	%rax, %rdi
	call	trim
	leaq	-1244(%rbp), %rsi
	leaq	-1262(%rbp), %rcx
	leaq	-1263(%rbp), %rdx
	leaq	-512(%rbp), %rax
	movq	%rsi, %r8
	movl	$.LC1, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_sscanf
	cmpl	$3, %eax
	jne	.L6
	movzbl	-1262(%rbp), %eax
	movsbl	%al, %edx
	movzbl	-1263(%rbp), %eax
	movsbl	%al, %eax
	leaq	-1252(%rbp), %rcx
	leaq	-1256(%rbp), %rsi
	movl	$0, %r9d
	movl	$0, %r8d
	movl	%eax, %edi
	call	getArgs
	testl	%eax, %eax
	jne	.L7
	jmp	.L4
.L7:
	movl	-1244(%rbp), %eax
	testl	%eax, %eax
	jns	.L8
	movl	$.LC2, %edi
	call	puts
	jmp	.L4
.L8:
	movl	-1256(%rbp), %eax
	cltq
	movq	-1232(%rbp,%rax,8), %rdx
	movl	-1244(%rbp), %ecx
	movl	-1252(%rbp), %eax
	cltq
	movq	-1232(%rbp,%rax,8), %rax
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	leftShiftBits
	movl	-1256(%rbp), %eax
	cltq
	movq	-1232(%rbp,%rax,8), %rax
	movq	%rax, %rdi
	call	showBits
	movl	$10, %edi
	call	putchar
	jmp	.L9
.L6:
	leaq	-1244(%rbp), %rsi
	leaq	-1262(%rbp), %rcx
	leaq	-1263(%rbp), %rdx
	leaq	-512(%rbp), %rax
	movq	%rsi, %r8
	movl	$.LC3, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_sscanf
	cmpl	$3, %eax
	jne	.L10
	movzbl	-1262(%rbp), %eax
	movsbl	%al, %edx
	movzbl	-1263(%rbp), %eax
	movsbl	%al, %eax
	leaq	-1252(%rbp), %rcx
	leaq	-1256(%rbp), %rsi
	movl	$0, %r9d
	movl	$0, %r8d
	movl	%eax, %edi
	call	getArgs
	testl	%eax, %eax
	jne	.L11
	jmp	.L4
.L11:
	movl	-1244(%rbp), %eax
	testl	%eax, %eax
	jns	.L12
	movl	$.LC2, %edi
	call	puts
	jmp	.L4
.L12:
	movl	-1256(%rbp), %eax
	cltq
	movq	-1232(%rbp,%rax,8), %rdx
	movl	-1244(%rbp), %ecx
	movl	-1252(%rbp), %eax
	cltq
	movq	-1232(%rbp,%rax,8), %rax
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	rightShiftBits
	movl	-1256(%rbp), %eax
	cltq
	movq	-1232(%rbp,%rax,8), %rax
	movq	%rax, %rdi
	call	showBits
	movl	$10, %edi
	call	putchar
	jmp	.L9
.L10:
	leaq	-1261(%rbp), %rsi
	leaq	-1262(%rbp), %rcx
	leaq	-1263(%rbp), %rdx
	leaq	-512(%rbp), %rax
	movq	%rsi, %r8
	movl	$.LC4, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_sscanf
	cmpl	$3, %eax
	jne	.L13
	movzbl	-1261(%rbp), %eax
	movsbl	%al, %edi
	movzbl	-1262(%rbp), %eax
	movsbl	%al, %edx
	movzbl	-1263(%rbp), %eax
	movsbl	%al, %eax
	leaq	-1248(%rbp), %r8
	leaq	-1252(%rbp), %rcx
	leaq	-1256(%rbp), %rsi
	movq	%r8, %r9
	movl	%edi, %r8d
	movl	%eax, %edi
	call	getArgs
	testl	%eax, %eax
	jne	.L14
	jmp	.L4
.L14:
	movl	-1256(%rbp), %eax
	cltq
	movq	-1232(%rbp,%rax,8), %rdx
	movl	-1248(%rbp), %eax
	cltq
	movq	-1232(%rbp,%rax,8), %rcx
	movl	-1252(%rbp), %eax
	cltq
	movq	-1232(%rbp,%rax,8), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	andBits
	movl	-1256(%rbp), %eax
	cltq
	movq	-1232(%rbp,%rax,8), %rax
	movq	%rax, %rdi
	call	showBits
	movl	$10, %edi
	call	putchar
	jmp	.L9
.L13:
	leaq	-1261(%rbp), %rsi
	leaq	-1262(%rbp), %rcx
	leaq	-1263(%rbp), %rdx
	leaq	-512(%rbp), %rax
	movq	%rsi, %r8
	movl	$.LC5, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_sscanf
	cmpl	$3, %eax
	jne	.L15
	movzbl	-1261(%rbp), %eax
	movsbl	%al, %edi
	movzbl	-1262(%rbp), %eax
	movsbl	%al, %edx
	movzbl	-1263(%rbp), %eax
	movsbl	%al, %eax
	leaq	-1248(%rbp), %r8
	leaq	-1252(%rbp), %rcx
	leaq	-1256(%rbp), %rsi
	movq	%r8, %r9
	movl	%edi, %r8d
	movl	%eax, %edi
	call	getArgs
	testl	%eax, %eax
	jne	.L16
	jmp	.L4
.L16:
	movl	-1256(%rbp), %eax
	cltq
	movq	-1232(%rbp,%rax,8), %rdx
	movl	-1248(%rbp), %eax
	cltq
	movq	-1232(%rbp,%rax,8), %rcx
	movl	-1252(%rbp), %eax
	cltq
	movq	-1232(%rbp,%rax,8), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	orBits
	movl	-1256(%rbp), %eax
	cltq
	movq	-1232(%rbp,%rax,8), %rax
	movq	%rax, %rdi
	call	showBits
	movl	$10, %edi
	call	putchar
	jmp	.L9
.L15:
	leaq	-1262(%rbp), %rcx
	leaq	-1263(%rbp), %rdx
	leaq	-512(%rbp), %rax
	movl	$.LC6, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_sscanf
	cmpl	$2, %eax
	jne	.L17
	movzbl	-1262(%rbp), %eax
	movsbl	%al, %edx
	movzbl	-1263(%rbp), %eax
	movsbl	%al, %eax
	leaq	-1252(%rbp), %rcx
	leaq	-1256(%rbp), %rsi
	movl	$0, %r9d
	movl	$0, %r8d
	movl	%eax, %edi
	call	getArgs
	testl	%eax, %eax
	jne	.L18
	jmp	.L4
.L18:
	movl	-1256(%rbp), %eax
	cltq
	movq	-1232(%rbp,%rax,8), %rdx
	movl	-1252(%rbp), %eax
	cltq
	movq	-1232(%rbp,%rax,8), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	invertBits
	movl	-1256(%rbp), %eax
	cltq
	movq	-1232(%rbp,%rax,8), %rax
	movq	%rax, %rdi
	call	showBits
	movl	$10, %edi
	call	putchar
	jmp	.L9
.L17:
	leaq	-1024(%rbp), %rcx
	leaq	-1263(%rbp), %rdx
	leaq	-512(%rbp), %rax
	movl	$.LC7, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_sscanf
	cmpl	$2, %eax
	jne	.L19
	movzbl	-1263(%rbp), %eax
	movsbl	%al, %eax
	movl	%eax, %edi
	call	argIndex
	movl	%eax, -1256(%rbp)
	movl	-1256(%rbp), %eax
	testl	%eax, %eax
	jns	.L20
	jmp	.L4
.L20:
	leaq	-1024(%rbp), %rax
	movq	%rax, %rdi
	call	strlen
	cmpq	$1, %rax
	jne	.L21
	call	__ctype_b_loc
	movq	(%rax), %rax
	movzbl	-1024(%rbp), %edx
	movsbq	%dl, %rdx
	addq	%rdx, %rdx
	addq	%rdx, %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	andl	$512, %eax
	testl	%eax, %eax
	je	.L21
	movzbl	-1024(%rbp), %eax
	movsbl	%al, %eax
	movl	%eax, %edi
	call	argIndex
	movl	%eax, -1252(%rbp)
	movl	-1256(%rbp), %eax
	cltq
	movq	-1232(%rbp,%rax,8), %rdx
	movl	-1252(%rbp), %eax
	cltq
	movq	-1232(%rbp,%rax,8), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	setBitsFromBits
	jmp	.L9
.L21:
	movl	-1256(%rbp), %eax
	cltq
	movq	-1232(%rbp,%rax,8), %rax
	leaq	-1024(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	setBitsFromString
	jmp	.L9
.L19:
	leaq	-1263(%rbp), %rdx
	leaq	-512(%rbp), %rax
	movl	$.LC8, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_sscanf
	cmpl	$1, %eax
	jne	.L23
	movzbl	-1263(%rbp), %eax
	movsbl	%al, %eax
	movl	%eax, %edi
	call	argIndex
	movl	%eax, -1256(%rbp)
	movl	-1256(%rbp), %eax
	testl	%eax, %eax
	jns	.L24
	jmp	.L4
.L24:
	movl	-1256(%rbp), %eax
	cltq
	movq	-1232(%rbp,%rax,8), %rax
	movq	%rax, %rdi
	call	showBits
	movl	$10, %edi
	call	putchar
	jmp	.L9
.L23:
	movzbl	-512(%rbp), %eax
	cmpb	$63, %al
	jne	.L25
	movl	$0, %eax
	call	printHelp
	jmp	.L9
.L25:
	movzbl	-512(%rbp), %eax
	cmpb	$113, %al
	je	.L33
	movzbl	-512(%rbp), %eax
	testb	%al, %al
	je	.L9
	movl	$.LC9, %edi
	call	puts
.L9:
	movl	$.LC0, %edi
	movl	$0, %eax
	call	printf
.L4:
	movq	stdin(%rip), %rdx
	leaq	-512(%rbp), %rax
	movl	$500, %esi
	movq	%rax, %rdi
	call	fgets
	testq	%rax, %rax
	jne	.L28
	jmp	.L27
.L33:
	nop
.L27:
	movl	$10, %edi
	call	putchar
	movl	$0, -1236(%rbp)
	jmp	.L29
.L30:
	movl	-1236(%rbp), %eax
	cltq
	movq	-1232(%rbp,%rax,8), %rax
	movq	%rax, %rdi
	call	freeBits
	addl	$1, -1236(%rbp)
.L29:
	cmpl	$25, -1236(%rbp)
	jle	.L30
	movl	$0, %eax
	movq	-8(%rbp), %rsi
	xorq	%fs:40, %rsi
	je	.L32
	call	__stack_chk_fail
.L32:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	main, .-main
	.section	.rodata
.LC10:
	.string	"%d"
.LC11:
	.string	"%s: Need at least 8 bits\n"
	.text
	.globl	processOptions
	.type	processOptions, @function
processOptions:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movl	%edi, -20(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	cmpl	$1, -20(%rbp)
	jg	.L35
	movq	-40(%rbp), %rax
	movl	$64, (%rax)
	jmp	.L34
.L35:
	movq	-32(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movq	-40(%rbp), %rdx
	movl	$.LC10, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_sscanf
	movl	%eax, -4(%rbp)
	cmpl	$0, -4(%rbp)
	jle	.L37
	movq	-40(%rbp), %rax
	movl	(%rax), %eax
	cmpl	$7, %eax
	jg	.L34
.L37:
	movq	-32(%rbp), %rax
	movq	(%rax), %rdx
	movq	stderr(%rip), %rax
	movl	$.LC11, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf
	movl	$1, %edi
	call	exit
.L34:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	processOptions, .-processOptions
	.globl	argIndex
	.type	argIndex, @function
argIndex:
.LFB4:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, %eax
	movb	%al, -4(%rbp)
	cmpb	$96, -4(%rbp)
	jle	.L39
	cmpb	$122, -4(%rbp)
	jg	.L39
	movsbl	-4(%rbp), %eax
	subl	$97, %eax
	jmp	.L40
.L39:
	movl	$-1, %eax
.L40:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	argIndex, .-argIndex
	.section	.rodata
.LC12:
	.string	"Invalid object name: %c\n"
	.text
	.globl	getArgs
	.type	getArgs, @function
getArgs:
.LFB5:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movq	%rsi, -32(%rbp)
	movl	%edx, %eax
	movq	%rcx, -40(%rbp)
	movl	%r8d, %edx
	movq	%r9, -56(%rbp)
	movb	%dil, -20(%rbp)
	movb	%al, -24(%rbp)
	movb	%dl, -44(%rbp)
	movl	$0, -4(%rbp)
	movsbl	-20(%rbp), %eax
	movl	%eax, %edi
	call	argIndex
	movl	%eax, %edx
	movq	-32(%rbp), %rax
	movl	%edx, (%rax)
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	testl	%eax, %eax
	jns	.L42
	movsbl	-20(%rbp), %eax
	movl	%eax, %esi
	movl	$.LC12, %edi
	movl	$0, %eax
	call	printf
	addl	$1, -4(%rbp)
.L42:
	movsbl	-24(%rbp), %eax
	movl	%eax, %edi
	call	argIndex
	movl	%eax, %edx
	movq	-40(%rbp), %rax
	movl	%edx, (%rax)
	movq	-40(%rbp), %rax
	movl	(%rax), %eax
	testl	%eax, %eax
	jns	.L43
	movsbl	-24(%rbp), %eax
	movl	%eax, %esi
	movl	$.LC12, %edi
	movl	$0, %eax
	call	printf
	addl	$1, -4(%rbp)
.L43:
	cmpb	$0, -44(%rbp)
	je	.L44
	movsbl	-44(%rbp), %eax
	movl	%eax, %edi
	call	argIndex
	movl	%eax, %edx
	movq	-56(%rbp), %rax
	movl	%edx, (%rax)
	movq	-40(%rbp), %rax
	movl	(%rax), %eax
	testl	%eax, %eax
	jns	.L44
	movsbl	-44(%rbp), %eax
	movl	%eax, %esi
	movl	$.LC12, %edi
	movl	$0, %eax
	call	printf
	addl	$1, -4(%rbp)
.L44:
	cmpl	$0, -4(%rbp)
	sete	%al
	movzbl	%al, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	getArgs, .-getArgs
	.globl	trim
	.type	trim, @function
trim:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	cmpq	$0, -40(%rbp)
	je	.L57
	movq	-40(%rbp), %rax
	movq	%rax, -24(%rbp)
	jmp	.L49
.L51:
	addq	$1, -24(%rbp)
.L49:
	call	__ctype_b_loc
	movq	(%rax), %rdx
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	movsbq	%al, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	andl	$8192, %eax
	testl	%eax, %eax
	je	.L50
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L51
.L50:
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	strlen
	leaq	-1(%rax), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, -16(%rbp)
	jmp	.L52
.L54:
	subq	$1, -16(%rbp)
.L52:
	call	__ctype_b_loc
	movq	(%rax), %rdx
	movq	-16(%rbp), %rax
	movzbl	(%rax), %eax
	movsbq	%al, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	andl	$8192, %eax
	testl	%eax, %eax
	je	.L53
	movq	-16(%rbp), %rax
	cmpq	-24(%rbp), %rax
	ja	.L54
.L53:
	movq	-40(%rbp), %rax
	movq	%rax, -8(%rbp)
	jmp	.L55
.L56:
	movq	-24(%rbp), %rax
	movzbl	(%rax), %edx
	movq	-8(%rbp), %rax
	movb	%dl, (%rax)
	addq	$1, -8(%rbp)
	addq	$1, -24(%rbp)
.L55:
	movq	-24(%rbp), %rax
	cmpq	-16(%rbp), %rax
	jbe	.L56
	movq	-8(%rbp), %rax
	movb	$0, (%rax)
	jmp	.L46
.L57:
	nop
.L46:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	trim, .-trim
	.section	.rodata
	.align 8
.LC13:
	.string	"BitOps has 26 bit-string registers named (a..z)"
	.align 8
.LC14:
	.string	"You can perform various operations on those regisers"
.LC15:
	.string	"\nCommands: "
.LC16:
	.string	"X = Y << Number"
.LC17:
	.string	"X = Y >> Number"
.LC18:
	.string	"X = Y & Z"
.LC19:
	.string	"X = Y | Z"
.LC20:
	.string	"X = ~ Y"
.LC21:
	.string	"set X = Y"
.LC22:
	.string	"set X = Bit-string"
.LC23:
	.string	"show X"
	.align 8
.LC24:
	.string	"where X,Y,Z are replaced by any lower-case letter"
	.text
	.globl	printHelp
	.type	printHelp, @function
printHelp:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$.LC13, %edi
	call	puts
	movl	$.LC14, %edi
	call	puts
	movl	$.LC15, %edi
	call	puts
	movl	$.LC16, %edi
	call	puts
	movl	$.LC17, %edi
	call	puts
	movl	$.LC18, %edi
	call	puts
	movl	$.LC19, %edi
	call	puts
	movl	$.LC20, %edi
	call	puts
	movl	$.LC21, %edi
	call	puts
	movl	$.LC22, %edi
	call	puts
	movl	$.LC23, %edi
	call	puts
	movl	$.LC24, %edi
	call	puts
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	printHelp, .-printHelp
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
