;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: strpbrk.asm
;;  Author:   chapui_s
;;  Created:  27/07/2014 02:46:07 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

section .text

extern	strlen

global	strpbrk

strpbrk:

	push	ebp
	mov	ebp, esp

	sub	esp, 4
	; [ebp - 4]  strlen(accept)

	pushfd
	push	ecx
	push	esi
	push	edi

	push	dword [ebp + 12]
	call	strlen
	add	esp, 4
	cmp	eax, 0
	je	.END
	inc	eax
	mov	[ebp - 4], eax

	mov	esi, [ebp + 8]
	cld

.LOOP	xor	eax, eax
	cmp	byte [esi], 0
	je	.END

.SEARCH	movzx	eax, byte [esi]
	mov	edi, [ebp + 12]
	mov	ecx, [ebp - 4]

	repne	scasb
	je	.FOUND

	inc	esi
	jmp	.LOOP

.FOUND	mov	eax, esi

.END	pop	edi
	pop	esi
	pop	ecx
	popfd
	mov	esp, ebp
	pop	ebp
	ret
