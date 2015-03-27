;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: rindex.asm
;;  Author:   chapui_s
;;  Created:  27/07/2014 01:59:49 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

section .text

extern	strlen

global	rindex

rindex:

	push	ebp
	mov	ebp, esp

	pushfd
	push	ecx
	push	edi

	push	dword [ebp + 8]
	call	strlen
	add	esp, 4
	mov	ecx, eax

	mov	edi, [ebp + 8]
	add	edi, ecx
	add	ecx, 2
	movzx	eax, byte [ebp + 12]
	std

	repne	scasb
	je	.FOUND

	xor	eax, eax
	jmp	.END

.FOUND	inc	edi
	mov	eax, edi

.END	pop	edi
	pop	ecx
	popfd
	mov	esp, ebp
	pop	ebp
	ret
