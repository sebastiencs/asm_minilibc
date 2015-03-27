;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: strchr.asm
;;  Author:   chapui_s
;;  Created:  26/07/2014 22:45:01 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

section .text

extern	strlen

global	strchr

strchr:

	push	ebp
	mov	ebp, esp

	pushfd
	push	ecx
	push	edi

	push	dword [ebp + 8]
	call	strlen
	add	esp, 4
	mov	ecx, eax
	inc	ecx

	mov	edi, [ebp + 8]
	movzx	eax, byte [ebp + 12]
	cld

	repne	scasb
	je	.FOUND

	xor	eax, eax
	jmp	.END

.FOUND	dec	edi
	mov	eax, edi

.END	pop	edi
	pop	ecx
	popfd
	mov	esp, ebp
	pop	ebp
	ret
