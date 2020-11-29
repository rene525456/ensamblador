%macro imprimir 2
	mov eax, 4
	mov ebx, 1
	mov ecx, %1
	mov edx, %2
	int 80h
%endmacro

section .data
	msj1 db " x "
	len1 equ $-msj1
	
	msj2 db " = "
	len2 equ $-msj2
	
	nueva_linea db 10,""
	len_nueva_linea equ $-nueva_linea

section .bss
	a rest 2
	b rest 2
	c rest 2

section .text
	global _start
	
_start:
	mov al, 3
	add al,'0'
	mov [a], al
	
	mov cx, 1;
	
principal:
	push cx
	add cx, '0'
	mov [b], cx
	imprimir a, 1
	imprimir msj1, len1
	imprimir b, 1
	imprimir msj2, len2
	imprimir nueva_linea, len_nueva_linea
	
	
	
	pop cx
	inc cx
	cmp cx, 10
	jnz principal
	
salir:
	mov eax, 1
	int 80h
