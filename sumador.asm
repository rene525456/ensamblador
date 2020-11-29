;Omar Alexis Sanmrtin Tapia
;Lunes 24 de Agosto del 2020
;Evaluacion 3 Ensamblador

;TEMA 3
;Escriba un programa utilizando el ensamblador del MIPS R2000, que realice la
;suma de los cuadrados de una serie de números introducidos por el teclado
;Nota: 1 + 4 + 9 + 16 + ... + n
;Se debe utilizar comparaciones, pilas, saltos o loop

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
    texto1 db 'Ingrese tamaño de serie',10
    len1 equ $-texto1

    texto2 db 'Introducir numero',10
    len2 equ $-texto2

    texto3 db 'El resultado de la Suma de los Cuadrados de la serie es : ',10
    len3 equ $-texto3

    texto4 db 'Cuadrado =  : ',10
    len4 equ $-texto4

    sep db '**********************************',10
    lensep equ $-sep

    line db 10
    len_line equ $ - line

section .bss
    suma resb 2  
    n resb 1
    numero resb 1
 
section .text
	global _start

_start:
    escritura texto1,len1
    
    lectura n,2
    mov ecx,0
    mov cl,[n]
    sub cl,'0'

    push ecx
    escritura sep,lensep
    pop ecx

    mov ax,0
    mov [suma],ax
    
operacion:
    push ecx
    escritura texto2,len2
    
    lectura numero,2
    mov eax,0
    mov ebx,0

    mov ax,[numero]
    sub ax,'0'
    mul ax
    
    mov bx,[suma]
    add ax,bx
    mov [suma],ax

    pop ecx
    loop operacion

imprimir:
    escritura texto3,len3

    mov ax,[suma]
    aam
    add al,'0'
    add ah,'0'
    mov [suma+0],ah
    mov [suma+1],al

    escritura suma,2

    escritura line,len_line

salir:
    mov eax,1
	int 80h