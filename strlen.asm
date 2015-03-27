;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: strlen.asm
;;  Author:   chapui_s
;;  Created:  28/07/2014 17:55:14 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;
;;  size_t    strlen(char *str);
;;
;;  Returns the length of the null-terminated string str
;;  Scans 8 bytes at a time
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "macro.inc"

section .text

global	strlen:function

strlen:

	pushfq
	pushx	rdi, rsi, rcx, r8, r9, r10

	cld

	mov	qword [rsp - 8], rdi	; uses red zone

	mov	rax, rdi
	and	rax, 7		; s & (sizeof(qword) - 1)
	jz	.ALIGN

	mov	rcx, 8
	sub	rcx, rax	; rcx -> until alignment

	xor	rax, rax
	repne	scasb
	jz	.FOUND

.ALIGN	mov	r8, 0x8080808080808080	   ; ...10000000...
	mov	r9, 0x0101010101010101	   ; ...00000001...

.LOOP	mov	rdx, qword [rdi]	; rdx -> *s
	add	rdi, 8
	mov	r10, rdx
	not	r10			; r10 -> ~rdx

	sub	rdx, r9
	and	rdx, r10
	and	rdx, r8

	jz	.LOOP		; No 0 byte in qword

	sub	rdi, 8
	mov	rcx, 8
	xor	rax, rax

	repne	scasb

.FOUND	dec	rdi
	sub	rdi, qword [rsp - 8]
	mov	rax, rdi

	popx	rdi, rsi, rcx, r8, r9, r10
	popfq
	ret
