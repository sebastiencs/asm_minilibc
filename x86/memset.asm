;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: memset.asm
;;  Author:   chapui_s
;;  Created:  26/07/2014 19:17:48 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

section .text

global	memset

memset:

	push	ebp
	mov	ebp, esp

	pushfd
	push	ecx
	push	edi

	mov	edi, [ebp + 8]
	mov	eax, [ebp + 12]
	mov	ecx, [ebp + 16]
	cld

	repne	stosb

	mov	eax, [ebp + 8]

	pop	edi
	pop	ecx
	popfd
	mov	esp, ebp
	pop	ebp
	ret
