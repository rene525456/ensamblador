%macro escribe 2
	mov eax, 4
	mov ebx, 1
	mov ecx, %1
	mov edx, %2
	int 0x80
%endmacro

segment .data
	nueva_linea db 10,""
	archivo db "/home/rene/proyectos/ensamblador/arreglo.txt",0
	respuesta db "          "

segment .bss
	texto resb 10
	idarchivo resd 1
	aux resb 1
	contador resb 1

segment .text
	global _start

_start:
	
leer_archivo:
	mov eax, 5						
	mov ebx, archivo	
	mov ecx, 0		
	mov edx, 0		
	int 0x80
	test eax, eax		
	jz salir

	mov dword[idarchivo], eax

	mov eax, 3		
	mov ebx, [idarchivo]	
	mov ecx, texto		
	mov edx, 13		
	int 0x80


	mov esi, 9
	mov ecx, 10


item:
	push esi
	push ecx
	mov al, [texto + esi]
	mov [respuesta + esi], al
	mov [aux], al

subitem:
	push esi
	push ecx

	mov al, [texto + esi]
	
	cmp al, [aux]
	jz sumar

	mov [respuesta + esi], al
	pop ecx
	pop esi
	dec esi
	loop subitem

	escribe respuesta, 10
	escribe nueva_linea, 1

	pop ecx
	pop esi
	dec esi
	loop item
;	escribe respuesta, 10

sumar:
	inc ecx


salir:
	mov eax, 1
	xor ebx, ebx
	int 0x80
