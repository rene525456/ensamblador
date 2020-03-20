	section .data
		asterisco db '*'
		;leng equ $-asterisco
		nueva_linea db 10,'',10
		;len_nueva equ $-nueva_linea
section .text
		global _start

_start:
		mov ecx, 20
		mov ebx, 20
l1:
	;mov eax, 4
	;mov ebx, 1
	push ecx		;se envia la referencia de ecx a pila
	mov ebx, ecx
	push ebx
	call imprimir_enter
	;mov ecx, asterisco
	;mov edx, leng
	;int 80h
	
	pop ebx
	mov ecx, ebx
	push ebx
	
l2:
	push ecx		;se envia la referencia de ecx a pila
	call imprimir_asterisco
	pop ecx
	loop l2
	;***************************************
	pop ecx
	pop ebx
	;mov ecx, ebx
	loop l1			; en este instante se decrementa cx en 1
	
	mov eax, 1
	int 80h

imprimir_asterisco:
	mov eax, 4
	mov ebx, 1
	mov ecx, asterisco
	mov edx, 1
	int 80h
	ret
	
imprimir_enter:
	mov eax, 4
	mov ebx, 1
	mov ecx, nueva_linea
	mov edx, 1
	int 80h
	ret
