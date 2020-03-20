section .data
	msj db 10, 'Item: '
	len_msj equ $ - msj

section .bss
	item resb 1

section .text
	global _start:

_start:
	mov cx, 10

ciclo:
	cmp cx, 0
	jz salir

	dec cx	
	jnz imprimir_mensaje
	

imprimir_mensaje:
	mov eax, 4
	mov ebx, 1
	push cx
	add cx, '0'
	mov [item], cx 
	mov ecx, msj
	mov edx, len_msj
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, item
	mov edx, 1
	int 80h

	pop cx
	jmp ciclo

salir:
	mov eax, 1
	int 80h
