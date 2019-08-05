; define permite definir constantes numéricas, de caracter y de cadena
section .data

	%define SYS_EXIT 0
	%define SYS_WRITE 4
	%define STDIN 0
	%define STDOUT 1
	%define EOL 0xA
	%define CHR_EXCL '*'
	%define mensaje 'Hola Clase'

	mensaje db mensaje, CHR_EXCL, CHR_EXCL, CHR_EXCL, EOL, EOL
	tamano equ $-mEnsaje

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
