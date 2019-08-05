section .data
	mul_pos db 'La multiplicación de 2*2 es:',0xA,0xD
	len1 equ $ - mul_pos

	mul_neg db 0xA,0xD,'La multiplicación de -2*-2 es:',0xA,0xD
	len2 equ $ - mul_neg
	
	div_pos db 0xA,0xD,'La división de 4/2 es:',0xA,0xD
	len3 equ $ - div_pos
	
	div_neg db 0xA,0xD,'La división de -4/-2 es:',0xA,0xD
	len4 equ $ - div_pos

section .bss
	res resd 4

section .text
	global _start

_start:
	;***************mul posi********
	mov eax, 4
	mov ebx, 1
	mov ecx, mul_pos
	mov edx, len1
	int 80h

	mov eax,5
	mov ebx,2
	mul ebx
	add eax,'0'
	mov [res],eax

	mov eax, 4
	mov ebx, 1
	mov ecx, res
	mov edx, 1
	int 80h

	; **********************resta******************

	mov eax, 4
	mov ebx, 1
	mov ecx, mul_neg
	mov edx, len1
	int 80h

	mov eax,5
	mov ebx,3
	sub eax,ebx
	add eax,'0'
	mov [res],eax

	mov eax, 4
	mov ebx, 1
	mov ecx, res
	mov edx, 3
	int 80h

	; **********************incremento******************

	mov eax, 4
	mov ebx, 1
	mov ecx, div_pos
	mov edx, len3
	int 80h

	mov eax,5
	inc eax
	add eax,'0'
	mov [res],eax

	mov eax, 4
	mov ebx, 1
	mov ecx, res
	mov edx, 1
	int 80h


	; **********************decremento******************

	mov eax, 4
	mov ebx, 1
	mov ecx, div_neg
	mov edx, len4
	int 80h

	mov eax,5
	dec eax
	add eax,'0'
	mov [res],eax

	mov eax, 4
	mov ebx, 1
	mov ecx, res
	mov edx, 1
	int 80h


	mov eax,1
	int 80h

	
