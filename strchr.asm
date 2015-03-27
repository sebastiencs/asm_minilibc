;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: strchr.asm
;;  Author:   chapui_s
;;  Created:  29/07/2014 22:19:16 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

section .text

extern	strlen

global	strchr:function

strchr:

	pushfq
	push	rcx
	push	rdi

	call	strlen WRT ..plt
	lea	rcx, [rax + 1]

	mov	rax, rsi
	cld

	repne	scasb
	je	.FOUND

	xor	rax, rax
	jmp	.END

.FOUND	lea	rax, [rdi - 1]

.END	pop	rdi
	pop	rcx
	popfq
	ret
