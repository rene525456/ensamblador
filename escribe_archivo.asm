%macro escribe 2
	mov eax, 4
	mov ebx, 1
	mov ecx, %1
	mov edx, %2
	int 0x80
%endmacro

segment .data
	msg2 db "Escribe en un archivo :",0xA
	len2 equ $-msg2
	archivo db "/home/rene/Desktop/ensamblador/archivo.txt",0

segment .bss
	texto resb 30
	idarchivo resd 1

segment .text

leetecla:
	mov eax, 3
	mov ebx, 0
	mov edx, 10	
	int 80H
	ret

	global _start

_start:
	mov eax, 8		; Servicios para el trabajo con archivos

	mov ebx, archivo	; EBX: la dirección de una cadena de caracteres terminada en nulo.
;	mov ecx, 1		; ECX: Modo de acceso.
	mov edx, 777h		; EDX: permisos al archivo, si se abre creándolo.
	int 0x80


	test eax, eax		
	jz salir
	mov dword[idarchivo], eax

	escribe msg2, len2

	mov ecx, texto
	call leetecla

	mov eax, 4
	mov ebx, [idarchivo]
	mov ecx, texto
	mov edx, 10
	int 0x80


salir:
	mov eax, 1
	xor ebx, ebx
	int 0x80
