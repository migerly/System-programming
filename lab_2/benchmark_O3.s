	.file	"benchmark.c"
	.intel_syntax noprefix
	.text
	.p2align 4
	.globl	initialize
	.type	initialize, @function
initialize:
.LFB39:
	.cfi_startproc
	endbr64
	mov	rcx, rdi
	test	rsi, rsi
	je	.L1
	lea	rax, -1[rsi]
	cmp	rax, 2
	jbe	.L6
	mov	rdx, rsi
	movdqa	xmm1, XMMWORD PTR .LC0[rip]
	movdqa	xmm5, XMMWORD PTR .LC1[rip]
	mov	rax, rdi
	shr	rdx, 2
	movdqa	xmm4, XMMWORD PTR .LC2[rip]
	movdqa	xmm3, XMMWORD PTR .LC3[rip]
	sal	rdx, 4
	add	rdx, rdi
	.p2align 4,,10
	.p2align 3
.L4:
	movdqa	xmm0, xmm1
	add	rax, 16
	paddq	xmm1, xmm5
	movdqa	xmm2, xmm0
	paddq	xmm2, xmm4
	shufps	xmm0, xmm2, 136
	paddd	xmm0, xmm3
	movups	XMMWORD PTR -16[rax], xmm0
	cmp	rax, rdx
	jne	.L4
	test	sil, 3
	je	.L1
	mov	rax, rsi
	and	rax, -4
.L3:
	lea	edx, 1[rax]
	lea	rdi, 0[0+rax*4]
	mov	DWORD PTR [rcx+rax*4], edx
	lea	rdx, 1[rax]
	cmp	rdx, rsi
	jnb	.L1
	add	edx, 1
	add	rax, 2
	mov	DWORD PTR 4[rcx+rdi], edx
	cmp	rax, rsi
	jnb	.L1
	add	eax, 1
	mov	DWORD PTR 8[rcx+rdi], eax
.L1:
	ret
.L6:
	xor	eax, eax
	jmp	.L3
	.cfi_endproc
.LFE39:
	.size	initialize, .-initialize
	.p2align 4
	.globl	transform
	.type	transform, @function
transform:
.LFB40:
	.cfi_startproc
	endbr64
	mov	rcx, rsi
	test	rsi, rsi
	je	.L15
	lea	rax, -1[rsi]
	cmp	rax, 2
	jbe	.L20
	mov	rdx, rsi
	movdqa	xmm3, XMMWORD PTR .LC4[rip]
	mov	rax, rdi
	shr	rdx, 2
	sal	rdx, 4
	add	rdx, rdi
	.p2align 4,,10
	.p2align 3
.L18:
	movdqu	xmm1, XMMWORD PTR [rax]
	add	rax, 16
	movdqa	xmm2, xmm1
	pslld	xmm2, 2
	paddd	xmm2, xmm1
	movdqa	xmm0, xmm2
	pslld	xmm0, 6
	psubd	xmm0, xmm2
	pslld	xmm0, 2
	paddd	xmm0, xmm1
	movdqa	xmm2, xmm0
	pslld	xmm2, 5
	paddd	xmm0, xmm2
	pslld	xmm0, 3
	paddd	xmm0, xmm1
	movdqa	xmm1, xmm0
	pslld	xmm1, 2
	paddd	xmm0, xmm1
	paddd	xmm0, xmm3
	movdqa	xmm1, xmm0
	psrld	xmm1, 13
	pxor	xmm0, xmm1
	movups	XMMWORD PTR -16[rax], xmm0
	cmp	rdx, rax
	jne	.L18
	test	cl, 3
	je	.L15
	mov	rdx, rcx
	and	rdx, -4
.L17:
	lea	rsi, 0[0+rdx*4]
	lea	r8, [rdi+rsi]
	imul	eax, DWORD PTR [r8], 1664525
	add	eax, 1013904223
	mov	r9d, eax
	shr	r9d, 13
	xor	eax, r9d
	mov	DWORD PTR [r8], eax
	lea	rax, 1[rdx]
	cmp	rax, rcx
	jnb	.L15
	lea	r9, 4[rdi+rsi]
	add	rdx, 2
	imul	eax, DWORD PTR [r9], 1664525
	add	eax, 1013904223
	mov	r8d, eax
	shr	r8d, 13
	xor	eax, r8d
	mov	DWORD PTR [r9], eax
	cmp	rdx, rcx
	jnb	.L15
	lea	rdx, 8[rdi+rsi]
	imul	eax, DWORD PTR [rdx], 1664525
	add	eax, 1013904223
	mov	ecx, eax
	shr	ecx, 13
	xor	eax, ecx
	mov	DWORD PTR [rdx], eax
.L15:
	ret
.L20:
	xor	edx, edx
	jmp	.L17
	.cfi_endproc
.LFE40:
	.size	transform, .-transform
	.p2align 4
	.globl	run_workload
	.type	run_workload, @function
run_workload:
.LFB41:
	.cfi_startproc
	endbr64
	test	edx, edx
	je	.L36
	push	rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	mov	r11d, edx
	mov	rbx, rsi
	xor	r10d, r10d
	.p2align 4,,10
	.p2align 3
.L30:
	mov	rsi, rbx
	add	r10d, 1
	call	transform
	cmp	r11d, r10d
	jne	.L30
	pop	rbx
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L36:
	.cfi_restore 3
	ret
	.cfi_endproc
.LFE41:
	.size	run_workload, .-run_workload
	.p2align 4
	.globl	checksum
	.type	checksum, @function
checksum:
.LFB42:
	.cfi_startproc
	endbr64
	mov	rcx, rdi
	test	rsi, rsi
	je	.L45
	lea	rax, -1[rsi]
	cmp	rax, 2
	jbe	.L46
	mov	rdx, rsi
	pxor	xmm1, xmm1
	pxor	xmm2, xmm2
	mov	rax, rdi
	shr	rdx, 2
	sal	rdx, 4
	add	rdx, rdi
	.p2align 4,,10
	.p2align 3
.L42:
	movdqu	xmm0, XMMWORD PTR [rax]
	add	rax, 16
	movdqa	xmm3, xmm0
	punpckhdq	xmm0, xmm2
	punpckldq	xmm3, xmm2
	paddq	xmm0, xmm3
	paddq	xmm1, xmm0
	cmp	rax, rdx
	jne	.L42
	movdqa	xmm0, xmm1
	psrldq	xmm0, 8
	paddq	xmm1, xmm0
	movq	rax, xmm1
	test	sil, 3
	je	.L39
	mov	rdx, rsi
	and	rdx, -4
.L41:
	mov	r8d, DWORD PTR [rcx+rdx*4]
	lea	rdi, 0[0+rdx*4]
	add	rax, r8
	lea	r8, 1[rdx]
	cmp	r8, rsi
	jnb	.L39
	mov	r8d, DWORD PTR 4[rcx+rdi]
	add	rdx, 2
	add	rax, r8
	cmp	rdx, rsi
	jnb	.L39
	mov	edx, DWORD PTR 8[rcx+rdi]
	add	rax, rdx
	ret
	.p2align 4,,10
	.p2align 3
.L45:
	xor	eax, eax
.L39:
	ret
.L46:
	xor	edx, edx
	xor	eax, eax
	jmp	.L41
	.cfi_endproc
.LFE42:
	.size	checksum, .-checksum
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC5:
	.string	"malloc"
.LC6:
	.string	"Checksum: %llu\n"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB7:
	.section	.text.startup,"ax",@progbits
.LHOTB7:
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB43:
	.cfi_startproc
	endbr64
	push	rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	mov	edi, 4194304
	call	malloc@PLT
	test	rax, rax
	je	.L54
	mov	rbx, rax
	mov	rdi, rax
	mov	esi, 1048576
	call	initialize
	mov	edx, 1000
	mov	rdi, rbx
	call	run_workload
	mov	esi, 1048576
	call	checksum
	lea	rsi, .LC6[rip]
	mov	edi, 2
	mov	rdx, rax
	xor	eax, eax
	call	__printf_chk@PLT
	mov	rdi, rbx
	call	free@PLT
	xor	eax, eax
.L51:
	pop	rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.type	main.cold, @function
main.cold:
.LFSB43:
.L54:
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	lea	rdi, .LC5[rip]
	call	perror@PLT
	mov	eax, 1
	jmp	.L51
	.cfi_endproc
.LFE43:
	.section	.text.startup
	.size	main, .-main
	.section	.text.unlikely
	.size	main.cold, .-main.cold
.LCOLDE7:
	.section	.text.startup
.LHOTE7:
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC0:
	.quad	0
	.quad	1
	.align 16
.LC1:
	.quad	4
	.quad	4
	.align 16
.LC2:
	.quad	2
	.quad	2
	.align 16
.LC3:
	.long	1
	.long	1
	.long	1
	.long	1
	.align 16
.LC4:
	.long	1013904223
	.long	1013904223
	.long	1013904223
	.long	1013904223
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
