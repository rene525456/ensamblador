;Algoritmo de una Calculadora
section .data
		suma db '1. Suma',0xA,0xD
		len_suma equ $-suma
		resta db '2. Resta',0xA,0xD
		len_resta equ $-resta
		multiplicacion db '3. Multiplicacion',0xA,0xD
		len_multiplicacion equ $-multiplicacion
		division db '4. Division',0xA,0xD
		len_division equ $-division
		
		msj_opcion db 'Ingrese Opcion',0xA,0xD
		len_opcion equ $-msj_opcion
		
		numero_1 db 'Ingrese Primer Numero',0xA,0xD
		len_numero1 equ $-numero_1
		numero_2 db 'Ingrese Segundo Numero',0xA,0xD
		len_numero2 equ $-numero_2
		
		respuesta db 'El Resultado es: ',0xA,0xD
		len_respuesta equ $-respuesta
		
		seguir db 'Desea Seguir 1 0 2: ',0xA,0xD
		len_seguir equ $-seguir
		
section .bss
		numero1 resb 5
		numero2 resb 5
		resultado resb 5
		opcion resb 5
section .text
		global _start
		
_start:

	jmp menu
	
menu:
	mov eax, 4
	mov ebx,1
	mov ecx, suma
	mov edx, len_suma
	int 80h
	
	mov eax, 4
	mov ebx,1
	mov ecx, resta
	mov edx, len_resta
	int 80h
	
	mov eax, 4
	mov ebx,1
	mov ecx, multiplicacion
	mov edx, len_multiplicacion
	int 80h
	
	mov eax, 4
	mov ebx,1
	mov ecx, division
	mov edx, len_division
	int 80h
	
	jmp Opcion

Opcion:
	mov eax, 4
	mov ebx, 1
	mov ecx, msj_opcion
	mov edx, len_opcion
	int 80h
	
	mov eax, 3
	mov ebx, 2
	mov ecx, opcion
	mov edx, 2
	int 80h
	
	jmp ingresar_numero_1

ingresar_numero_1:
	mov eax, 4
	mov ebx, 1
	mov ecx, numero_1
	mov edx, len_numero1
	int 80h
	
	mov eax, 3
	mov ebx, 2
	mov ecx, numero1
	mov edx, 5
	int 80h
	
	jmp ingresar_numero_2
	
ingresar_numero_2:
	mov eax, 4
	mov ebx, 1
	mov ecx, numero_2
	mov edx, len_numero2
	int 80h
	
	mov eax, 3
	mov ebx, 2
	mov ecx, numero2
	mov edx, 5
	int 80h
	
	jmp proceso

proceso:
	mov cl, [opcion]
	sub cl, '0'
	
	cmp cl, 1
	jz Suma
	
	cmp cl, 2
	jz Resta
	
	cmp cl, 3
	jz Multiplicacion
	
	cmp cl, 4
	jz Division
	
	jmp Salir

Suma:
	mov al, [numero1]
	sub al,'0'
	mov bl, [numero2]
	sub bl,'0'
	add al, bl
	jmp Imprimir_Resultado
	
Resta:
	mov al, [numero1]
	sub al,'0'
	mov bl, [numero2]
	sub bl,'0'
	sub al,bl
	jmp Imprimir_Resultado

Multiplicacion:
	mov al, [numero1]
	sub al,'0'
	mov bl, [numero2]
	sub bl,'0'
	mul bl
	jmp Imprimir_Resultado
	
Division:
	mov al, [numero1]
	sub al,'0'
	mov bl, [numero2]
	sub bl, '0'
	cmp al, bl
	jg comparacion_1
	
	jmp Salir
	
	
comparacion_1:
	cmp bl, 0
	jg comparacion_2
	jmp Salir
	
comparacion_2:
	div bl
	jmp Imprimir_Resultado
	
Imprimir_Resultado:
	add al, '0'
	mov [resultado], al
	mov eax, 4
	mov ebx, 1
	mov ecx, respuesta
	mov edx, len_respuesta
	int 80h
	mov eax, 4
	mov ebx, 1
	mov ecx, resultado
	mov edx, 5
	int 80h
	jmp Seguir
	
Seguir:
	mov eax, 4
	mov ebx, 1
	mov ecx, seguir
	mov edx, len_seguir
	int 80h
	mov eax, 3
	mov ebx, 2
	mov ecx, opcion
	mov edx, 2
	int 80h
	mov cl, [opcion]
	sub cl,'0'
	cmp cl, 1
	jz Opcion
	
	cmp cl, 2
	jz Salir

Salir:
	mov eax, 1
	int 0x80

