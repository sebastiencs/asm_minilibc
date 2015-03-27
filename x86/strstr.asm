;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: strstr.asm
;;  Author:   chapui_s
;;  Created:  27/07/2014 02:17:12 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

section .text

extern	strlen

global	strstr

strstr:

	push	ebp
	mov	ebp, esp

	sub	esp, 4
	; [ebp - 4] strlen(needle)

	push   ebx
	push   ecx
	push   edx
	push   esi
	push   edi

	mov	esi, [ebp + 8]

	push	dword [ebp + 12]
	call	strlen
	add	esp, 4
	cmp	dword eax, 0
	je	.NOT

	mov	dword [ebp - 4], eax

	push	dword [ebp + 8]
	call	strlen
	add	esp, 4
	cmp	dword eax, 0
	je	.NULL

	mov	ebx, eax
	dec	esi
	add	ebx, esi	; ebx -> ptr sur fin de chaine

.L1	xor	eax, eax
	cmp	esi, ebx
	je	.RET

	inc	esi
	mov	edx, esi
	mov	edi, [ebp + 12]
	mov	ecx, [ebp - 4]

.L2	mov	al, byte [edx]
	cmp	al, [edi]
	jne	.L1

	inc	edx
	inc	edi
	dec	ecx
	jnz	.L2

	mov	eax, esi
	jmp	.RET

.NOT	mov	eax, [ebp + 8]
	jmp	.RET

.NULL	xor	eax, eax

.RET	pop	edi
	pop	esi
	pop	edx
	pop	ecx
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret
