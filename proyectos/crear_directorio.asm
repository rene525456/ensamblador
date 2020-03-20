%macro escribir 2
	mov eax, 4
	mov ebx, 1
	mov ecx, %1
	mov edx, %2
	int 0x80
%endmacro

section .data
    msj3 db 10, 'Carpeta Creada con exito', 10
    len3 EQU $ - msj3

    pathcreate db '/home/rene/Escritorio/xxxxx_prueba', 0
    lenpathcreate EQU $ - pathcreate

section .text
    global _start

_start:
    ;********************************* crear la carpeta *********************************

    mov eax, 39           ;servicio para crear directorio
    mov ebx, pathcreate   ;servicio de direccion del directorio
    mov ecx, 0x1FF        ;permisos de 777 octal, de lectura, escritura y ejecución
    int 0x80              ; igual al int 80H

    escribir msj3, len3 ; mensaje de que se creo la carpeta

salir:
    mov eax, 1
    mov ebx, 0
    int 80H
