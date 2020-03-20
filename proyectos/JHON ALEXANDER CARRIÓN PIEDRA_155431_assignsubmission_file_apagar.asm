%macro escribir 2
    mov eax, 4
    mov ebx, 2
    mov ecx, %1
    mov edx, %2
    int 80H
%endmacro
%macro leer 2
    mov eax, 3
    mov ebx, 2        
    mov ecx, %1 
    mov edx, %2     
    int 80h 
%endmacro
section .data
    mensaje1 db 10, '--Apagar el Equipo--', 10
    len1 equ $-mensaje1
    
    mensaje3 db 10,'2. cancelar', 10
    len3 equ $-mensaje3 
    
    mensaje4 db 10,'1. apagar', 10
    len4 equ $-mensaje4
    
    mensaje5 db 'Apagando el Equipo...', 10
    len5 equ $-mensaje5
    
    mensajeO db 10, 'Opcion Erronea', 10
    lenO equ $-mensajeO
    
    mensajeS db 10, 'Seleccion: '
    lenS equ $-mensajeS  
    
    msgcancelar db 10, 'Ejecución Cancelada', 10
    lencancel equ $-msgcancelar
    
section .bss
    seleccion: resb 3
    
section .text
    global _start
    
_start:
    ;presento mensaje de Calculadora
    escribir mensaje1, len1
    
    ;Presento opciones
    ;apagar
    escribir mensaje4, len4
    ;cancelar
    escribir mensaje3, len3
    
    ;Obtener seleccion ingresada
    mov ebx, 0
	mov ecx, seleccion
	mov edx, 2
	mov eax, 3
	int 80h
    
    mov ah, [seleccion]; movemos la seleccio a ah
    sub ah, '0'; Convierte la cadena en #
    
    ; se realiza comparacion con cmp
    
    cmp ah,1
    je apagar
    
    cmp ah,2
    je cancelar
    
    ;opcion invalida
    escribir mensajeO, lenO
    
    jmp salir
    
apagar:
    escribir mensaje5, len5
    mov  al, 0x58        ; %al  # 2 bytes: b0 58
    mov  ebx, 0xfee1dead ; %ebx # 5 bytes: bb ad de e1 fe
    mov  ecx, 0x28121969 ; %ecx # 5 bytes: b9 69 19 12 28
    mov  edx, 0x4321fedc ; %edx # 5 bytes: ba dc fe 21 43
    int 80H
    jmp salir
    
cancelar:
    escribir msgcancelar, lencancel
    jmp salir

salir:
    mov eax, 1
    int 80h

    
