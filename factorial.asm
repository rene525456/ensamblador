;Cristian Eduardo Medina Morocho
;24/08/2020
%macro escritura 2
    mov eax, 4
    mov ebx, 1
    mov ecx,%1
    mov edx,%2
    int 80h
%endmacro

%macro lectura 2
    mov eax,3
    mov ebx,0
    mov ecx,%1
    mov edx,%2
    int 80h
%endmacro


section .data
    texto1 db 'Ingrese numero',10
    len1 equ $-texto1

    texto2 db 'Factorial: ',10
    len2 equ $-texto2


    line db 10
    len_line equ $ - line


section .bss
    n resb 1
    respuesta resb 2
 
section .text
	global _start

_start:
    escritura texto1,len1
    lectura n,2
    mov ecx,0
    mov cl,[n]
    sub cl,'0'
    mov ax,1
factor:
    push ecx
    mul cx
    pop ecx
    loop factor

    aam
    add al,'0'
    add ah,'0'
    mov [respuesta+0],ah
    mov [respuesta+1],al

    escritura texto2, len2
    escritura respuesta,2
    escritura line,len_line

salir:
    mov eax,1
	int 80h