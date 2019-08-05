section .data	
	mensaje1 db "Ingrese numero1: "
	len1 equ $-mensaje1
	mensaje2 db "Ingrese numero2: "
	len2 equ $-mensaje2
	resultado db "Suma: "
	len_r equ $-resultado
	espacio db "", 0xa
	len_esp equ $-espacio
	
	uno db "1"
	
section .bss
	suma resb 2
	numero1 resb 2
	numero2 resb 2
	
section .text
	global _start

_start:
	; ************** ingreso de los número
	mov eax,4
	mov ebx,1
	mov ecx,mensaje1
	mov edx,len1
	int 80h

	mov eax,3
	mov ebx,2
	mov ecx,numero1
	mov edx,10
	int 80h
	
	mov eax,4
	mov ebx,1
	mov ecx,mensaje2
	mov edx,len2
	int 80h

	mov eax,3
	mov ebx,2
	mov ecx,numero2
	mov edx,10
	int 80h

	;******************pro
	mov ax,[numero1]
	mov bx,[numero2]
	sub ax,'00'
	sub bx,'00'
	add ah,bh
	cmp ah,9
	jg acarreo
	jmp Sinacarreo
	
	acarreo:
	mov ax,[numero1]
	sub ax,'00'
	sub ah,5
	sub bh,5
	add ah,bh
	add al,bl
	add al,1
	add ax,'00'
	mov [suma],ax
	mov eax,4
	mov ebx,1
	mov ecx,resultado
	mov edx,len_r
	int 80h
	
	mov eax,4
	mov ebx,1
	mov ecx,suma
	mov edx,2
	int 80h
	jmp salir
	
	
	Sinacarreo:
	add al,bl
	add ax,'00'
	mov [suma],ax
	mov eax,4
	mov ebx,1
	mov ecx,resultado
	mov edx,len_r
	int 80h
	
	mov eax,4
	mov ebx,1
	mov ecx,suma
	mov edx,2
	int 80h
	jmp salir
	
	
	salir:	
	mov eax,4
	mov ebx,1
	mov ecx, espacio
	mov edx, len_esp
	int 80h
		
	mov eax,1
	mov ebx,0
	int 80h
