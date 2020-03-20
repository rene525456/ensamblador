;UNL
;Sandro Michael Córdova Carrión
;6to "B"
;Funcionamiento: El sistema limpia la pantalla y coloca el puntero en la posicion 0,0, a continuación 
;el sistema solicita al usuario un número en donde acorde al número ingresado la posición del puntero
;cambiara, el rango de los números están entre 1-3, si un valor es ajeno a estos el sistema no realiza 
;ninguna acción
;El Objetivo del sistema es poder aprender interrupciones del codigo ANSI las mismas que ayudan en la 
;modificación de la pantalla y sus diferentes componentes.
;Jueves 29 de agosto del 2019
%macro imprimir 2
	mov eax, 4
	mov ebx, 1
	mov ecx, %1
	mov edx, %2
	int 80H
%endmacro
%macro solicitar 1 
	mov eax, 3
	mov ebx, 2
	mov ecx, %1
	mov edx, 2
	int 80H
%endmacro
section .data
    ;comando db 0x1b,"[50;56f","HOLAAA",0xA,0x1b,"[20;20m"
    comando db 0x1b,"[1J",0x1b,"[00;00f"
    len_comando equ $-comando

    comandoTexto db 0x1b,"[1;1f","###"
    len_comando_texto equ $-comandoTexto

    comandoCaso2 db 0x1b,"[1;20f","###"
    len_c2 equ $-comandoCaso2

    comandoCaso3 db 0x1b,"[1;40f","###"
    len_c3 equ $-comandoCaso3

    comandoLineaInicial4 db 0x1b,"[2;1f", 0xA
    len_comandoLineaInicial4 equ $-comandoLineaInicial4

    comandoLineaInicial5 db 0x1b,"[3;1f"
    len_comandoLineaInicial5 equ $-comandoLineaInicial5
    
    mensaje db "Ingrese un número",10
    len_mensaje equ $-mensaje
section .bss
   numero resb 10
section .text
    global _start
_start:
	imprimir comando, len_comando
	;jmp for2
for2:

	;imprimir mensaje, len_mensaje
	mov eax, 3
	mov ebx, 2
	mov ecx, numero
	mov edx, 1
	int 80H

	mov al, [numero]
	sub al, '0'

	cmp al, 1
	jz caso1
	cmp al, 2
	jz caso2
	cmp al, 3
	jz caso3
	cmp al, 4
	jz caso4
	cmp al, 5
	jz caso5

	jmp for2

caso1:
	 imprimir comando, len_comando
	 imprimir comandoTexto, len_comando_texto
	 imprimir comandoLineaInicial4, len_comandoLineaInicial4
	 jmp for2
caso2:
	 imprimir comando, len_comando
	 imprimir comandoCaso2, len_c2
	 imprimir comandoLineaInicial4, len_comandoLineaInicial4
	 ;imprimir comandoLineaInicial, len_comandoLineaInicial
	 jmp for2
caso3:
	 imprimir comando, len_comando
	 imprimir comandoCaso3, len_c3
	 imprimir comandoLineaInicial4, len_comandoLineaInicial4
	 ;imprimir comandoLineaInicial, len_comandoLineaInicial
	 jmp for2
caso4:
	 imprimir comandoLineaInicial4, len_comandoLineaInicial4
	 jmp for2
caso5:
	 imprimir comandoLineaInicial5, len_comandoLineaInicial5
	 jmp for2
salir:
	mov eax, 1
	int 80h
