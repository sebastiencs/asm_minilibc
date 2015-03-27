;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: strcmp.asm
;;  Author:   chapui_s
;;  Created:  29/07/2014 21:56:29 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

section .text

global	strcmp

strcmp:

	pushfq
	push	rsi
	push	rdi
	push	rdx

	xor	rax, rax
	cld

.LOOP	cmpsb
	jnz	.DIFF

	cmp	byte [rdi - 1], 0
	jne	.LOOP

.END	pop	rdx
	pop	rdi
	pop	rsi
	popfq
	ret

.DIFF	movzx	rax, byte [rdi - 1]
	movzx	rdx, byte [rsi - 1]
	sub	rax, rdx
	jmp	.END