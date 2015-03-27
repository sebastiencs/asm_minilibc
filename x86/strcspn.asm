;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: strcspn.asm
;;  Author:   chapui_s
;;  Created:  28/07/2014 15:16:33 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

section .text

extern	strlen

global	strcspn

strcspn:

	push	ebp
	mov	ebp, esp

	sub	esp, 4
	; [ebp - 4] strlen(reject)

	pushfd
	push	ecx
	push	esi
	push	edi

	push	dword [ebp + 12]
	call	strlen
	add	esp, 4
	inc	eax
	mov	[ebp - 4], eax

	xor	eax, eax
	mov	esi, [ebp + 8]
	mov	ebx, esi
	cld

.LOOP	cmp	byte [esi], 0
	je	.END

	movzx	eax, byte [esi]
	mov	edi, [ebp + 12]
	mov	ecx, [ebp - 4]

	repne	scasb
	je	.END

	inc	esi
	jmp	.LOOP

.END	sub	esi, ebx
	mov	eax, esi

	pop	edi
	pop	esi
	pop	ecx
	popfd

	mov	esp, ebp
	pop	ebp
	ret
