section .data
	bignum1 dd 15
	len_bignum1 equ $ - bignum1
	bignum2 dd 5
	

section .bss
	suma resb 1

section .text
	global _start

_start:	

;	MOV AX, 5
;	ADD AX, 4
;	ADD AX,'0'
;	MOV [suma], Al
;
	mov [suma], dword 40
	mov eax,[suma]
	
	add eax,'0'

	mov [suma], eax

	; *********************  imprimir  ****************

	mov eax, 4
	mov ebx, 1
	mov ecx, suma
	mov edx, len_bignum1
	int 80h



	mov eax,1
	int 80h
