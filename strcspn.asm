;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: strcspn.asm
;;  Author:   chapui_s
;;  Created:  29/07/2014 22:23:57 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

section .text

extern	strlen

global	strcspn:function

strcspn:

	pushfq
	push	rbx
	push	rcx
	push	rsi
	push	rdi

	sub	rsp, 16
	; [rsp + 8]	*s
	; [rsp]		strlen(reject)

	xchg	 rdi, rsi
	call	 strlen WRT ..plt
	inc	 rax
	mov	 [rsp], rax

	xor	 rax, rax
	mov	 rbx, rsi
	mov	 [rsp + 8], rdi
	cld

.LOOP	cmp	byte [rsi], 0
	je	.END

	movzx	rax, byte [rsi]
	mov	rdi, [rsp + 8]
	mov	rcx, [rsp]

	repne	scasb
	je	.END

	inc	rsi
	jmp	.LOOP

.END	sub	rsi, rbx
	mov	rax, rsi

	add	rsp, 16
	pop	rdi
	pop	rsi
	pop	rcx
	pop	rbx
	popfq
	ret