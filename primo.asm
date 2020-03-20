section .data
	num db 'Ingrese el numero'
	leng1 equ $-num
	msj1 db 'Es primo!!!!!!'
	leng2 equ $-msj1
	msj2 db 'No es primo'
	leng3 equ $-msj2
section .bss
	n resb 1
section .text
	global _start
		_start:
			mov eax, 4
			mov ebx, 1
			mov ecx, num
			mov edx, leng1
			int 80h

			mov eax,3
			mov ebx,2			
			mov ecx, n
			mov edx, 10
			int 80h

			mov al,[n]
			sub al, '0'
			cmp al,2
			jz primo
			jc primo
			jmp veri
		veri:
			mov al,[n]
			sub al, '0'
			and al, 1
			jz no_primo
			jmp impar
		impar:
			mov al,[n]
			sub al, '0'
			cmp al,3
			jz primo
			jmp veri2
		veri2:
			mov al, [n]
			sub al, '0'
			cmp al,9
			jz no_primo
			jmp primo
		primo:
			mov eax, 4
			mov ebx, 1
			mov ecx, msj1
			mov edx, leng2
			int 80h
			jmp salir
		no_primo:
			mov eax, 4
			mov ebx, 1
			mov ecx, msj2
			mov edx, leng3
			int 80h
			jmp salir
		salir:
			mov eax, 1
			mov ebx, 0
			int 80
