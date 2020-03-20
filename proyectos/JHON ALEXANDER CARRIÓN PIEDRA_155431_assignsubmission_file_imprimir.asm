section .data

    
section .bss
    num resb 1
    
section .text
    global _start

_start:
    xor dx,dx ;En DX va el numero del puerto LPT (00 para LPT1 01 Para LPT2 etc...) 
    mov si, 1
    call imprimir_impresora ;Llamamos a la funcion de impresion 
    int 80H
    
imprimir_impresora: 
    pusha ;Guardamos todos los registros 
    mov ah,01h ;Funcion de inicializar impresora (DX no se cambia) 
    int 17h 
    
bucle: 
    lodsb ;Cargamos la etiqueta en si 
    or al,al;¿Llegamos al final? 
    ;je term ;Si llegamos al final entonces terminamos 
    mov ah,00h ;Funcion de escribir en impresora (AL tiene el caracter a imprimir) 
    int 17h ;¡IMPRIMIMOS! 
    loop bucle ;Hacemos un bucle de impresion hasta que no acabe la cadena de texto 
    
term: 
    popa ;Liberamos todo 
    ret ;Volvemos de la funcion
    jmp salir


metodos_impresora:
    ;escribir en impresora
    mov ah, 00H
    mov al, 43
    mov dx, 0
    int 17H
    
    mov [num], ah

    mov eax, 4
	mov ebx, 1
    mov ecx, num
	mov edx, 2
	int 80h
    ;iniciar impresora
    mov ah, 01H
    mov dx, 0
    int 17H
    ;ver estado de impresora
    mov ah, 02H
    mov dx, 0
    int 17H
    
salir: 
    mov eax, 1
    mov ebx, 0
    int 80H