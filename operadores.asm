; macro es a palabra reservada, 
; escribir es el nombre del marcor, 
; número de parámetro que recibirá el macro 
%macro escribir 2
	mov eax, 4
	mov ebx, 1
	mov ecx, %1
	mov edx, %2
	int 0x80
%endmacro

section .data
	suma db 'La suma de 5+6 es:',0xA,0xD
	len_suma equ $ - suma

	resta db 0xA,0xD,'La resta de 6-5 es:',0xA,0xD
	len_resta equ $ - resta
	
	incremento db 0xA,0xD,'El incremento de eax es:',0xA,0xD
	len_incremento equ $ - incremento
	
	decremento db 0xA,0xD,'El decremento de eax es:',0xA,0xD
	len_decremento equ $ - decremento

section .bss
	res resb 1

section .text
	global _start

_start:
	;***************suma********
	escribir suma, len_suma

	mov eax,5
	mov ebx,3
	add eax,ebx
	add eax,'0'
	mov [res],eax

	escribir res, 3

	; **********************resta******************

	escribir resta, len_resta

	mov eax,5
	mov ebx,3
	sub eax,ebx
	add eax,'0'
	mov [res],eax
	
	escribir res, 3

	; **********************incremento******************
	
	escribir incremento, len_incremento

	mov eax,5
	inc eax
	add eax,'0'
	mov [res],eax

	escribir res, 1

	; **********************decremento******************

	escribir decremento, len_decremento

	mov eax,5
	dec eax
	add eax,'0'
	mov [res],eax

	escribir res, 1

	mov eax,1
	int 80h
