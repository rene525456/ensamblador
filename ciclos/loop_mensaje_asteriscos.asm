section .data
		msj db '*******',10
		leng equ $-msj
section .text
		global _start

_start:
		mov ecx, 20

l1:
	mov eax, 4
	mov ebx, 1
	push ecx		;se envia la referencia de ecx a pila
	mov ecx, msj
	mov edx, leng
	int 80h
	
	pop ecx
	loop l1			; en este instante se decrementa cx en 1
	
	mov eax, 1
	int 80h
	
