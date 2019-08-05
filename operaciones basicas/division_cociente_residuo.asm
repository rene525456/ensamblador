; realiza la división de dós número de un sólo dígito
; verifica si la división es para cero
; verifica si el divisor es mayor que el dividendo

section .data 
	msj1 db "el resultado cociente: ",0xA,0xD
	len1 equ $-msj1 
	
	msj2 db 0xA,"el resltado residuo: ",0xA,0xD
	len2 equ $-msj2

	msj3 db 0xA,"No divisble: dividendo mayor a divisor ",0xA,0xD
	len3 equ $-msj3

	msj4 db 0xA,"No divisible división para cero ",0xA,0xD
	len4 equ $-msj4	

section .bss
	resultado_Al resb 1 
	resultado_Ah resb 1

section .text
	global _start
_start:

	mov al, 8
	mov bl, 3

	cmp bl,0
	jz noDivisibleCero

	cmp bl,al
	jg noDivisibleMenor

	jmp division

noDivisibleCero:
	mov eax, 4
	mov ebx, 1
	mov ecx, msj4
	mov edx, len4
	int 80h
	jmp salir

noDivisibleMenor:
	mov eax, 4
	mov ebx, 1
	mov ecx, msj3
	mov edx, len3
	int 80h
	jmp salir

division:
	div bl   ;dividiendo al = al / bl
	add eax, '0'
	add ah, '0' 
	mov[resultado_Al], al
	mov[resultado_Ah], ah
	
;****** mensaje msj1	
	mov eax, 4
	mov ebx, 1
	mov ecx, msj1
	mov edx, len1
	int 80h

; ***** resltado de al
	mov eax, 4
	mov ebx, 1
	mov ecx, resultado_Al
	mov edx, 1
	int 80h 

;****** mensaje msj2	
	mov eax, 4
	mov ebx, 1
	mov ecx, msj2
	mov edx, len2
	int 80h

; ***** resltado de ah
	mov eax, 4
	mov ebx, 1
	mov ecx, resultado_Ah
	mov edx, 1
	int 80h 
	jmp salir

salir:
	mov eax, 1
	mov ebx, 1
	int 80h
