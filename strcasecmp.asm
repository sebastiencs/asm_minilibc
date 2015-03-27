;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: strcasecmp.asm
;;  Author:   chapui_s
;;  Created:  29/07/2014 22:13:27 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

section .text

global	strcasecmp

strcasecmp:

	pushfq
	push	rdx
	push	rsi
	push	rdi

	xor	rax, rax
	cld

.LOOP	cmpsb
	jnz	.DIFF

	cmp	byte [rdi - 1], 0
	jne	.LOOP

.END	pop	rdi
	pop	rsi
	pop	rdx
	popfq
	ret

.DIFF	movzx	rdx, byte [rdi - 1]
	jmp	.CASE
.YES	movzx	rax, byte [rdi - 1]
	sub	al, byte [rsi - 1]
	cbw
	cwde
	cdqe
	jmp	.END

.CASE	cmp	rdx, 'z'
	jg	.YES

	cmp	rdx, 'a'
	jl	.TO_UP

	sub	rdx, 32
	cmp	dl, byte [rsi - 1]
	je	.LOOP
	jmp	.YES

.TO_UP	cmp	rdx, 'Z'
	jg	.YES

	cmp	rdx, 'A'
	jl	.YES

	add	rdx, 32
	cmp	dl, byte [rsi - 1]
	je	.LOOP
	jmp	.YES
