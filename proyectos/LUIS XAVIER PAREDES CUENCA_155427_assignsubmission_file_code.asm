%macro write 2
    mov eax, 4
	mov ebx, 1
	mov ecx, %1
	mov edx, %2
	int 80H
%endmacro

section .data
    msg db 10, 'Programa que cambia los permisos de un archivo', 10
    len EQU $ - msg
    msg2 db 10, 'Permiso Cambiado', 10
    len2 EQU $ - msg2
    msg3 db 10, 'Permiso Denegado!!!', 10
    len3 EQU $ - msg3
    msg4 db 10, 'Texto Leido:', 10
    len4 EQU $ - msg4
    msg5 db 10, 'Ingrese un texto de menos de 30 caracteres', 10
    len5 EQU $ - msg5
    msg6 db 10, 'Archivo Escrito', 10
    len6 EQU $ - msg6
    opt db 10, 'Escoga una opción', 10
    lenOpt EQU $ - opt
    opt1 db 10, '1 -> chmod 777', 10
    lenOpt1 EQU $ - opt1
    opt2 db 10, '2 -> chmod 775', 10
    lenOpt2 EQU $ - opt2
    opt3 db 10, '3 -> chmod 760', 10
    lenOpt3 EQU $ - opt3
    opt4 db 10, '4 -> chmod 644', 10
    lenOpt4 EQU $ - opt4
    opt5 db 10, '5 -> chmod 640', 10
    lenOpt5 EQU $ - opt5
    opt6 db 10, '6 -> chmod 600', 10
    lenOpt6 EQU $ - opt6
    opt7 db 10, '7 -> chmod 700', 10
    lenOpt7 EQU $ - opt7
    pathRead db '/home/alex/Asemblerprojects/chmod/archivo.txt', 0
    lenPath EQU $ - pathRead

section .bss
    option resb 1
    text resb 30
    txt2Write resb 30
    idFileRead resd 1

section .text
    global _start

_start:
    write msg, len
    write opt, lenOpt
    write opt1, lenOpt1
    write opt2, lenOpt2
    write opt3, lenOpt3
    write opt4, lenOpt4
    write opt5, lenOpt5
    write opt6, lenOpt6
    write opt7, lenOpt7

    mov ebx, 0
	  mov ecx, option
	  mov edx, 2
	  mov eax, 3
	  int 80h

    mov ah, [option]; movemos la seleccio a ah
    sub ah, '0'; Convierte la cadena en #

    cmp ah, 1
    je permission777

    cmp ah, 2
    je permission775

    cmp ah, 3
    je permission760

    cmp ah, 4
    je permission644

    cmp ah, 5
    je permission640

    cmp ah, 6
    je permission600

    cmp ah, 7
    je permission700

operations:
    ; ##################################### READ ################################################################
    ;*****   apertura del archivo
    mov eax, 5      ;servicio para abrir el archivo
    mov ebx, pathRead   ;servicio de direccion del archivo
    mov ecx, 0      ; modo de acceso, read only = 0
    mov edx, 0      ; permisos del archivo
    int 80H        ; igual al int 80H

    ; ** verificamos si el path es correcto o si existe
    test eax, eax
    jz denied

    ; **** archivo sin porblemas(excepciones) ****
    mov dword [idFileRead], eax  ; respaldo el id del archivo

    mov eax, 3
    mov ebx, [idFileRead]      ; entrada estandar. (0,1,2 ) => entrada por teclado
    mov ecx, text
    mov edx, 30
    int 80H

    write msg4, len4
    write text, 30

    ; ##################################### START WRITE ###########################################################################
    write msg5, len5

    mov eax, 3
    mov ebx, 2      ; entrada estandar. (0,1,2 ) => entrada por teclado
    mov ecx, txt2Write
    mov edx, 30
    int 80H

    ;*****   apertura del archivo
    mov eax, 8          ;servicio para crear y escribir en archivo
    mov ebx, pathRead   ;servicio de direccion del archivo
    mov ecx, 2          ; modo de acceso, write and read = 2
    mov edx, 0x1FF      ;permisos
    int 80H            ; igaul al int 80H

    ; ** verificamos si el path es correcto o si existe
    test eax, eax   ; test es un and sin modificar sus operandos, solo modifica  banderas
    jz denied

    ; **** archivo sin porblemas(excepciones) ****
    mov dword [idFileRead], eax  ; respaldo el id del archivo

    mov eax, 4
    mov ebx, [idFileRead]      ; entrada estandar
    mov ecx, txt2Write
    mov edx, 25
    int 80H

    ;*****   cerrar del archivo ***********************
    mov eax, 6              ;servicio para cerrar el archivo
    mov ebx, [idFileRead];servicio de direccion del archivo
    mov ecx, 0              ; no se necesita modo de acceso
    mov edx, 0              ; no se necesita permisos
    int 80H                ; igaul al int 80H

    write msg6, len6

    ; ##################################### END WRITE ###########################################################################

    jmp exit

denied:
    write msg3, len3
    jmp exit

; ##################################### START CHMOD ################################################################

permission777:
    mov eax, 15           ;servicio para chmod
    mov ebx, pathRead     ;servicio de direccion del directorio
    mov ecx, 0x1FF
    mov edx, 0x1FF
    int 80H              ; igaul al int 80H

    write msg2, len2

    jmp operations

permission775:
    mov eax, 15           ;servicio para chmod
    mov ebx, pathRead     ;servicio de direccion del directorio
    mov ecx, 0x1FD
    mov edx, 0x1FD
    int 80H              ; igaul al int 80H

    write msg2, len2

    jmp operations

permission760:
    mov eax, 15           ;servicio para chmod
    mov ebx, pathRead     ;servicio de direccion del directorio
    mov ecx, 0x1F0
    mov edx, 0x1F0
    int 80H              ; igaul al int 80H

    write msg2, len2

    jmp operations

permission644:
    mov eax, 15           ;servicio para chmod
    mov ebx, pathRead     ;servicio de direccion del directorio
    mov ecx, 0x1A4
    mov edx, 0x1A4
    int 80H              ; igaul al int 80H

    write msg2, len2

    jmp operations

permission640:
    mov eax, 15           ;servicio para chmod
    mov ebx, pathRead     ;servicio de direccion del directorio
    mov ecx, 0x1A0
    mov edx, 0x1A0
    int 80H              ; igaul al int 80H

    write msg2, len2

    jmp operations

permission600:
    mov eax, 15           ;servicio para chmod
    mov ebx, pathRead     ;servicio de direccion del directorio
    mov ecx, 0x180
    mov edx, 0x180
    int 80H              ; igaul al int 80H

    write msg2, len2

    jmp operations

permission700:
    mov eax, 15           ;servicio para chmod
    mov ebx, pathRead     ;servicio de direccion del directorio
    mov ecx, 0x1C0
    mov edx, 0x1C0
    int 80H              ; igaul al int 80H

    write msg2, len2

    jmp operations

; ##################################### END CHMOD ################################################################

exit:
    mov eax, 1
    mov ebx, 0
    int 80H
