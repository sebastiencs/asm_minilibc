;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: strpbrk.asm
;;  Author:   chapui_s
;;  Created:  13/08/2014 00:25:55 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

section .text

extern	strlen

global	strpbrk:function

strpbrk:

	pushfq
	push	rcx
	push	rsi
	push	rdi

	sub	rsp, 16
	; [rsp]      strlen(accept)
	; [rsp + 8]  *accept

	xchg	rdi, rsi
	call	strlen WRT ..plt
	test	rax, rax
	jz	.END

	inc	rax
	mov	qword [rsp], rax
	mov	qword [rsp + 8], rdi

	cld

.LOOP	xor	rax, rax
	cmp	byte [rsi], 0
	jz	.END

.SEARCH	movzx	rax, byte [rsi]
	mov	rdi, [rsp + 8]
	mov	rcx, [rsp]

	repne	scasb
	je	.FOUND

	inc	rsi
	jmp	.LOOP

.FOUND	mov	rax, rsi

.END	add	rsp, 16
	pop	rdi
	pop	rsi
	pop	rcx
	popfq
	ret
