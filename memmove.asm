;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: memmove.asm
;;  Author:   chapui_s
;;  Created:  28/07/2014 19:23:22 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

section .text

global	memmove

memmove:

	pushfq
	push	rcx
	push	rdx
	push	rsi
	push	rdi

	mov	rax, rdi
	mov	rcx, rdx
	cld

	cmp	rsi, rdi
	je	.END
	jg	.GO

.F_END	lea	rsi, [rsi + rcx - 1]
	lea	rdi, [rdi + rcx - 1]
	std

.GO	rep	movsb

.END	pop	rdi
	pop	rsi
	pop	rdx
	pop	rcx
	popfq

	ret
