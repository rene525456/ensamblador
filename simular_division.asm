section .data
	ingresoa	db	10,'Ingrese dividendo: '
	len_a		equ 	$ - ingresoa
 
	ingresob	db	10,'Ingrese divisor: '
	len_b		equ	$ - ingresob

	msj_cociente	db	10,'El cociente es: '
	len_cociente	equ	$ - msj_cociente

	msj_residuo	db	10,'El residuo es: '
	len_residuo	equ	$ - msj_residuo

section .bss
	dividendo resb 1
	divisor resb 1
	cociente resb 1
	residuo resb 1

section .text
	global _start
_start:

	; Imprimimos en pantalla el mensaje 2
	mov eax, 4
	mov ebx, 1
	mov ecx, ingresoa
	mov edx, len_a
	int 80h
 
	; Obtenemos el numero 1
	mov eax, 3
	mov ebx, 0
	mov ecx, dividendo
	mov edx, 2
	int 80h
 
	; Imprimimos en pantalla el mensaje 3
	mov eax, 4
	mov ebx, 1
	mov ecx, ingresob
	mov edx, len_b
	int 80h
 
	; Obtenemos el numero 2
	mov eax, 3
	mov ebx, 0
	mov ecx, divisor
	mov edx, 2
	int 80h

	mov al, [dividendo]
	mov bl, [divisor]
	mov cx, 0
	sub al, '0'
	sub bl, '0'

;****************** proceso *************
division:
	sub al, bl
	inc cx
	cmp al,bl
	jg division
	jmp imprimir

imprimir:
	add al,'0'
	add cx,'0'
	mov [cociente], cx
	mov [residuo], al

;********* imprimir cociente **********************
	mov eax, 4
	mov ebx, 1
	mov ecx, msj_cociente
	mov edx, len_cociente
	int 80h
	
	mov eax, 4
	mov ebx, 1
	mov ecx, cociente
	mov edx, 1
	int 80h
;********* imprimir residuo **********************
	mov eax, 4
	mov ebx, 1
	mov ecx, msj_residuo
	mov edx, len_residuo
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, residuo
	mov edx, 1
	int 80h
	jmp salir

salir:
	mov eax,1
	int 80h
