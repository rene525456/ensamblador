
;Autor = Joel Cartuche
;Curso = 6° "B"

%macro imprimir 2
	mov eax,4
	mov ebx,1
	mov ecx,%1 
	mov edx,%2
	int 80H	
%endmacro

%macro leer 2
    mov eax,3
    mov ebx,0
    mov ecx,%1 
    mov edx,%2
    int 80H 
%endmacro


; ecx,modo de acceso
; edx, permisos
section .bss
	auxiliar resb 30
	auxiliarb resb 30
	auxiliarc resb 30


section .data
	msg db 0x1b ,"       " ; 6 espacios para contener al dato
	lenmsg equ $-msg



	salto db " ",10 
	lensalto equ $-salto




section .text
    global _start    

_start:
	
	mov ecx,9

	mov al,0
	mov [auxiliar],al

cicloI:
	push ecx
	mov ecx,9

	mov al,0
	mov [auxiliarb],al

	cicloJ:
		push ecx


		call imprimir0al9
		

	;	imprimir msg2,lenmsg2

	fincicloJ:
		mov al,[auxiliarb]
		inc al
		mov [auxiliarb],al

		pop ecx
		loop cicloJ
		
	;imprimir salto,lensalto

fincicloI:
	mov al,[auxiliar]
	inc al
	mov [auxiliar],al

	pop ecx
	loop cicloI
	

salir:
	mov eax, 1
	int 80H



imprimir0al9:
	
	mov ebx,"["
	mov [msg+1], ebx

	mov bl,[auxiliar]
	add bl,'0'
	mov [msg+2], bl


	mov ebx,";"
	mov [msg+3], ebx

	
	mov bl,[auxiliarb]
	add bl,'0'
	mov [msg+4],bl

	mov ebx,"fJ"
	mov [msg+5], ebx

	imprimir msg,lenmsg

	ret
