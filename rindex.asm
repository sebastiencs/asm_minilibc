;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: rindex.asm
;;  Author:   chapui_s
;;  Created:  29/07/2014 21:46:59 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

section .text

extern	strlen

global	rindex:function

rindex:

	pushfq
	push	rcx
	push	rdi

	call	strlen WRT ..plt
	lea	rdi, [rdi + rax]
	lea	rcx, [rax + 1]

	mov	rax, rsi
	std

	repne	scasb
	je	.FOUND

	xor	rax, rax
	jmp	.END

.FOUND	lea	rax, [rdi + 1]

.END	pop	rdi
	pop	rcx
	popfq
	ret
