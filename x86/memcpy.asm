;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: memcpy.asm
;;  Author:   chapui_s
;;  Created:  26/07/2014 22:44:52 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

section .text

extern	memmove

global	memcpy

memcpy:

	push	ebp
	mov	ebp, esp

	sub	esp, 8
	; [ebp - 4]  end_src
	; [ebp - 8]  end_dest

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

	mov	dword [ebp - 4], esi
	mov	dword [ebp - 8], edi
	dec	ecx
	add	dword [ebp - 4], ecx
	add	dword [ebp - 8], ecx
	inc	ecx

	cmp	esi, edi
	jl	.SRC_L

	cmp	esi, dword [ebp - 8]
	jle	.MOVE

	jmp	.GO

.SRC_L	cmp	dword [ebp - 4], edi
	jge	.MOVE

.GO	rep	movsb

.END	mov	eax, [ebp + 8]
	jmp	.EXIT

.MOVE	push	dword [ebp + 16]
	push	dword [ebp + 12]
	push	dword [ebp + 8]
	call	memmove
	add	esp, 12

.EXIT	pop	edi
	pop	esi
	pop	ecx
	popfd
	mov	esp, ebp
	pop	ebp
	ret
