;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: strstr.asm
;;  Author:   chapui_s
;;  Created:  28/07/2014 18:20:45 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

section .text

extern	strlen

global	strstr:function

strstr:

	pushfq
	push	rbp
	push	rbx
	push	rcx
	push	rdx
	push	rsi
	push	rdi

	sub	rsp, 8
	; [rsp] strlen(needle)

	xchg	rdi, rsi
	call	strlen WRT ..plt
	test	rax, rax
	cmovz	rax, rsi
	jz	.RET

	mov	qword [rsp], rax

	xchg	rdi, rsi
	call	strlen WRT ..plt
	test	rax, rax
	jz	.RET

	lea	rbx, [rax + rdi - 1]	; rbx -> ptr sur fin de haystack
	lea	rdx, [rdi - 1]		; rdx -> heystack
	mov	rbp, rsi	  	; rbp -> needle
	cld

.L1	xor	rax, rax
	cmp	rdx, rbx
	je	.RET

	inc	rdx
	mov	rdi, rdx
	mov	rsi, rbp
	mov	rcx, qword [rsp]

.L2	repe	cmpsb
	jne	.L1

	mov	rax, rdx

.RET	add	rsp, 8
	pop	rdi
	pop	rsi
	pop	rdx
	pop	rcx
	pop	rbx
	pop	rbp
	popfq
	ret
