section .data
	%assign SYS_EXIT 0
	%assign SYS_WRITE 4
	%assign STDIN 0
	%assign STDOUT 1
	%assign CHR_EXCL '!'
	%assign CHR_EXCL '*'
	
	mensaje: db "Hola Clase",CHR_EXCL
	tamano: equ $-mensaje

section .text
	global _start

_start:
	mov eax, 4
	mov ebx, 1
	mov ecx, mensaje
	mov edx, tamano
	int 80h

	mov eax, 1
	mov ebx, 0
	int 80h

