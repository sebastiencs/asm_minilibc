;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: memmove.asm
;;  Author:   chapui_s
;;  Created:  26/07/2014 21:31:26 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

section .text

global	memmove

memmove:

	push	ebp
	mov	ebp, esp

	pushfd
	push	ecx
	push	esi
	push	edi

	mov	esi, [ebp + 12]		; src
	mov	edi, [ebp + 8]		; dest
	mov	ecx, [ebp + 16]		; size
	cld

	cmp	esi, edi
	je	.END
	jg	.GO

.F_END	add	esi, ecx
	add	edi, ecx
	dec	esi
	dec	edi
	std

.GO	rep	movsb

.END	mov	eax, [ebp + 8]
	pop	edi
	pop	esi
	pop	ecx
	popfd
	mov	esp, ebp
	pop	ebp
	ret
