;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: memset.asm
;;  Author:   chapui_s
;;  Created:  29/07/2014 21:30:23 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

section .text

global	memset

memset:

	pushfq
	push	rcx
	push	rdi

	push	rdi

	mov	rax, rsi
	mov	rcx, rdx
	cld

	repne	stosb

	pop	rax

	pop	rdi
	pop	rcx
	popfq
	ret
