;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: strcasecmp.asm
;;  Author:   chapui_s
;;  Created:  27/07/2014 01:10:37 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

section .text

global	strcasecmp

strcasecmp:

	push	ebp
	mov	ebp, esp

	pushfd
	push	edx
	push	esi
	push	edi

	xor	eax, eax
	xor	edx, edx
	mov	esi, [ebp + 8]
	mov	edi, [ebp + 12]
	cld

.LOOP	cmpsb
	jnz	.DIFF

	cmp	byte [esi - 1], 0
	jne	.LOOP
	jmp	.END

.DIFF	movzx	edx, byte [esi - 1]
	jmp	.CASE
.YES	movzx	eax, byte [esi - 1]
	sub	al, byte [edi - 1]
	cbw
	cwde

.END	pop	edi
	pop	esi
	pop	edx
	popfd

	mov	esp, ebp
	pop	ebp
	ret


.CASE	cmp	dl, 'z'
	jg	.YES

	cmp	dl, 'a'
	jl	.TO_UP

	sub	dl, 32
	cmp	dl, byte [edi - 1]
	je	.LOOP
	jmp	.YES

.TO_UP	cmp	dl, 'Z'
	jg	.YES

	cmp	dl, 'A'
	jl	.YES

	add	dl, 32
	cmp	dl, byte [edi - 1]
	je	.LOOP
	jmp	.YES
