;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: strncmp.asm
;;  Author:   chapui_s
;;  Created:  27/07/2014 01:02:57 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

section .text

global	strncmp

strncmp:

	push	ebp
	mov	ebp, esp

	pushfd
	push	ecx
	push	esi
	push	edi

	xor	eax, eax
	mov	esi, [ebp + 8]
	mov	edi, [ebp + 12]
	mov	ecx, [ebp + 16]
	cld

.LOOP	jecxz	.END
	dec	ecx
	cmpsb
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
	pop	ecx
	popfd

	mov	esp, ebp
	pop	ebp
	ret
