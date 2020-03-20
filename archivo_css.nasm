;;;;;;; csv.asm ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Convert a comma-separated file to a something-else separated file.
;
; Started:	31-May-2001
; Updated:	 1-Jun-2001
;
; Copyright (c) 2001 G. Adam Stanislav
; All rights reserved.
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include	'system.inc'

%define	BUFSIZE	2048

section	.data
fd.in	dd	stdin
fd.out	dd	stdout
usg	db	'Usage: csv [-t<delim>] [-c<comma>] [-p] [-o <outfile>] [-i <infile>]', 0Ah
usglen	equ	usg
iemsg	db	"csv: Can't open input file", 0Ah
iemlen	equ	iemsg
oemsg	db	"csv: Can't create output file", 0Ah
oemlen	equ	oemsg

section .bss
ibuffer	resb	BUFSIZE
obuffer	resb	BUFSIZE

section	.text
align 4
ierr:
	push	dword iemlen
	push	dword iemsg
	push	dword stderr
	sys.write
	push	dword 1		; return failure
	sys.exit

align 4
oerr:
	push	dword oemlen
	push	dword oemsg
	push	dword stderr
	sys.write
	push	dword 2
	sys.exit

align 4
usage:
	push	dword usglen
	push	dword usg
	push	dword stderr
	sys.write
	push	dword 3
	sys.exit

align 4
global	_start
_start:
	add	esp, byte 8	; discard argc and argv[0]
	mov	edx, (',' << 8) | 9

.arg:
	pop	ecx
	or	ecx, ecx
	je	near .init		; no more arguments

	; ECX contains the pointer to an argument
	cmp	byte [ecx], '-'
	jne	usage

	inc	ecx
	mov	ax, [ecx]

.o:
	cmp	al, 'o'
	jne	.i

	; Make sure we are not asked for the output file twice
	cmp	dword [fd.out], stdout
	jne	usage

	; Find the path to output file - it is either at [ECX+1],
	; i.e., -ofile --
	; or in the next argument,
	; i.e., -o file

	inc	ecx
	or	ah, ah
	jne	.openoutput
	pop	ecx
	jecxz	usage

.openoutput:
	push	dword 420	; file mode (644 octal)
	push	dword 0200h | 0400h | 01h
	; O_CREAT | O_TRUNC | O_WRONLY
	push	ecx
	sys.open
	jc	near oerr

	add	esp, byte 12
	mov	[fd.out], eax
	jmp	short .arg

.i:
	cmp	al, 'i'
	jne	.p

	; Make sure we are not asked twice
	cmp	dword [fd.in], stdin
	jne	near usage

	; Find the path to the input file
	inc	ecx
	or	ah, ah
	jne	.openinput
	pop	ecx
	or	ecx, ecx
	je near usage

.openinput:
	push	dword 0		; O_RDONLY
	push	ecx
	sys.open
	jc	near ierr		; open failed

	add	esp, byte 8
	mov	[fd.in], eax
	jmp	.arg

.p:
	cmp	al, 'p'
	jne	.t
	or	ah, ah
	jne	near usage
	or	edx, 1 << 31
	jmp	.arg

.t:
	cmp	al, 't'		; redefine output delimiter
	jne	.c
	or	ah, ah
	je	near usage
	mov	dl, ah
	jmp	.arg

.c:
	cmp	al, 'c'
	jne	near usage
	or	ah, ah
	je	near usage
	mov	dh, ah
	jmp	.arg

align 4
.init:
	sub	eax, eax
	sub	ebx, ebx
	sub	ecx, ecx
	mov	edi, obuffer

	; See if we are to preserve the first line
	or	edx, edx
	js	.loop

.firstline:
	; get rid of the first line
	call	getchar
	cmp	al, 0Ah
	jne	.firstline

.loop:
	; read a byte from stdin
	call	getchar

	; is it a comma (or whatever the user asked for)?
	cmp	al, dh
	jne	.quote

	; Replace the comma with a tab (or whatever the user wants)
	mov	al, dl

.put:
	call	putchar
	jmp	short .loop

.quote:
	cmp	al, '"'
	jne	.put

	; Print everything until you get another quote or EOL. If it
	; is a quote, skip it. If it is EOL, print it.
.qloop:
	call	getchar
	cmp	al, '"'
	je	.loop

	cmp	al, 0Ah
	je	.put

	call	putchar
	jmp	short .qloop

align 4
getchar:
	or	ebx, ebx
	jne	.fetch

	call	read

.fetch:
	lodsb
	dec	ebx
	ret

read:
	jecxz	.read
	call	write

.read:
	push	dword BUFSIZE
	mov	esi, ibuffer
	push	esi
	push	dword [fd.in]
	sys.read
	add	esp, byte 12
	mov	ebx, eax
	or	eax, eax
	je	.done
	sub	eax, eax
	ret

align 4
.done:
	call	write		; flush output buffer

	; close files
	push	dword [fd.in]
	sys.close

	push	dword [fd.out]
	sys.close

	; return success
	push	dword 0
	sys.exit

align 4
putchar:
	stosb
	inc	ecx
	cmp	ecx, BUFSIZE
	je	write
	ret

align 4
write:
	jecxz	.ret	; nothing to write
	sub	edi, ecx	; start of buffer
	push	ecx
	push	edi
	push	dword [fd.out]
	sys.write
	add	esp, byte 12
	sub	eax, eax
	sub	ecx, ecx	; buffer is empty now
.ret:
	ret
