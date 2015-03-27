;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: strlen.asm
;;  Author:   chapui_s
;;  Created:  26/07/2014 18:49:18 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

section .text

global	strlen
global	my_strlen

strlen:
my_strlen:

	push	ebp
	mov	ebp, esp

	pushfd
	push	ecx
	push	edi

	xor	eax, eax
	mov	edi, [ebp + 8]
	mov	ecx, 0xFFFFFFFF
	cld

	repne	scasb

	not	ecx
	dec	ecx
	mov	eax, ecx

	pop	edi
	pop	ecx
	popfd

	mov	esp, ebp
	pop	ebp
	ret
