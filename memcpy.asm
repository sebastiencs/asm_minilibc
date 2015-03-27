;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Filename: memcpy.asm
;;  Author:   chapui_s
;;  Created:  28/07/2014 17:55:14 (+08:00 UTC)
;;  Updated:
;;  URL:      https://github.com/sebastiencs/
;;
;;
;;  void      *memcpy(void *dest, const void *src, size_t n)
;;
;;  Copies n bytes from src to dest
;;  Uses ARX instructions and prefetch data to perform fast operation
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "macro.inc"

%define SMALL_SIZE	(0x40)

section .text

global	memcpy:function

memcpy:
	pushfq
	pushx	rdi, rsi, rdx, rcx, r8, r9, r10, r11

.BEGIN:

	mov	r8, rdi		; save dest

	cld

	cmp	rdx, SMALL_SIZE
	jae	.DO_ALIGN

.SMALL:

.1	test	rdx, 0b00000001
	jz	.2

	movsb

.2	test	rdx, 0b00000010
	jz	.4

	movsw

.4	test	rdx, 0b00000100
	jz	.8

	movsd

.8	test	rdx, 0b00001000
	jz	.16

	movsq

.16	and	rdx, 0b11110000
	jz	.END

.16L	movsq
	movsq

	sub	rdx, 0x10
	jnz	.16L

.END	mov	rax, r8
	popx	rdi, rsi, rdx, rcx, r8, r9, r10, r11
	popfq
	ret

.DO_ALIGN:			; align on 16 bytes
	test	rdi, 0x1
	jz	.EVEN
	dec	rdx
	movsb

.EVEN	mov	rax, rdi
	and	rax, 0x1F	; dest & (32 - 1)
	jz	.ALIGN

	mov	rcx, 0x20	; align on 32 bytes
	sub	rcx, rax	; rcx -> bytes until align
	sub	rdx, rcx	; n -= bytes until align

	not	rcx
	inc	rcx
	lea	rax, [rel .ALIGN]
	add	rcx, rax

	jmp	rcx

	movsw
	movsw
	movsw
	movsw
	movsw
	movsw
	movsw
	movsw
	movsw
	movsw
	movsw
	movsw
	movsw
	movsw
	movsw
	movsw

.ALIGN:
.LESS_THAN_1K:

	cmp	rdx, 0x200
	jae	.512_MORE

	mov	rcx, rdx
	shr	rcx, 0x06	; nb loops for 64 bytes
	jz	.SMALL

.LOOP64:

	prefetchnta	[rsi + 0x00]	; load addr in cache line
	prefetchnta	[rsi + 0x20]	; load addr in cache line

	mov	rax,  [rsi + 0x00]
	mov	r9,  [rsi + 0x08]
	mov	r10, [rsi + 0x10]
	mov	r11, [rsi + 0x18]
	mov	[rdi + 0x00], rax
	mov	[rdi + 0x08], r9
	mov	[rdi + 0x10], r10
	mov	[rdi + 0x18], r11

	mov	rax,  [rsi + 0x20]
	mov	r9,  [rsi + 0x28]
	mov	r10, [rsi + 0x30]
	mov	r11, [rsi + 0x38]
	mov	[rdi + 0x20], rax
	mov	[rdi + 0x28], r9
	mov	[rdi + 0x30], r10
	mov	[rdi + 0x38], r11

	lea	rsi, [rsi + 0x40]
	lea	rdi, [rdi + 0x40]

	dec	rcx
	jnz	.LOOP64

.END_LOOP64:

	and	rdx, (0x40 - 1)		; bytes left ?
	jnz	.SMALL

	mov	rax, r8
	popx	rdi, rsi, rdx, rcx, r8, r9, r10, r11
	popfq
	ret

.512_MORE:

.PREFETCH_DATA:

	; unrolled loop

	mov	rax, [rsi +  0x00]	; load addr in cache line
	mov	rax, [rsi +  0x40]	; load addr in next cache line
	mov	rax, [rsi +  0x80]	; load addr in next cache line
	mov	rax, [rsi +  0xC0]	; load addr in next cache line
	mov	rax, [rsi + 0x100]	; load addr in next cache line
	mov	rax, [rsi + 0x140]	; load addr in next cache line
	mov	rax, [rsi + 0x180]	; load addr in next cache line
	mov	rax, [rsi + 0x1C0]	; load addr in next cache line

	mov	rax, 4

.COPY_FROM_CACHE:		; ARX Instructions

	vmovdqu	ymm0, [rsi + 0x00]	; unaligned
	vmovdqu	ymm1, [rsi + 0x20]
	vmovdqu	ymm2, [rsi + 0x40]
	vmovdqu	ymm3, [rsi + 0x60]

	vmovdqa	[rdi + 0x00], ymm0	; aligned
	vmovdqa	[rdi + 0x20], ymm1
	vmovdqa	[rdi + 0x40], ymm2
	vmovdqa	[rdi + 0x60], ymm3

	lea	rsi, [rsi + 0x80]
	lea	rdi, [rdi + 0x80]

	dec	rax
	jnz	.COPY_FROM_CACHE

	lea	rdx, [rdx - 0x200]
	cmp	rdx, 0x200
	jae	.PREFETCH_DATA

	emms
	sfence

	test	rdx, rdx
	jnz	.LESS_THAN_1K

	mov	rax, r8
	popx	rdi, rsi, rdx, rcx, r8, r9, r10, r11
	popfq
	ret
