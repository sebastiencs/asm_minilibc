;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: strcmp.asm
;;  Author:   chapui_s
;;  Created:  26/07/2014 23:07:36 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

section .text

global	strcmp

strcmp:

	push	ebp
	mov	ebp, esp

	pushfd
	push	esi
	push	edi

	xor	eax, eax
	mov	esi, [ebp + 8]
	mov	edi, [ebp + 12]
	cld

.LOOP	cmpsb
	jnz	.DIFF

	cmp	byte [esi - 1], 0
	jne	.LOOP
	jmp	.END

.DIFF	movzx	eax, byte [esi - 1]
	sub	al, byte [edi - 1]
	cbw
	cwde

.END	pop	edi
	pop	esi
	popfd

	mov	esp, ebp
	pop	ebp
	ret
