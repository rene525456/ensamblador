;                                             UNIVERSIDAD NACIONAL DE LOJA
;                                            CARRERA DE INGENIERÍA EN SISTEMAS
;  TEMA: Eliminación de carpetas a travez del servicio 40
;  OBJETIVO: El presente archivo contiene un programa que se encarga de eliminar una carpeta existente en cualquier ubicación con la
;  ayuda del servicio 40 y el permiso de acceso 0x1ff eqivalente al permiso 777

%macro imprimir 2
	mov eax,4
	mov ebx,1
	mov ecx,%1 
	mov edx,%2
	int 80H	
%endmacro


section .data
	mensaje db "La carpeta se elimino", 10
	len equ $ -mensaje
	path db "/home/camila/Documentos/Ensamblador/Practicas/borrar", 0
	
section .bss
	;contenido del archivo
	texto resb 30
	;REcatar texto de archivo
	idarchivo resd 1

section .text
	global _start

_start:
	;Todos estos datos los encontramos en la documentación de Int 80H
	mov eax, 40		;Es el servicio para abrir el archivo
	mov ebx, path 	;Dirección del archivo
	mov ecx, 0x1ff		;Permiso de acceso =777; octal
	mov edx, 0		;Modo de acceso del archivo
	int 80H

	test eax, eax ;comprueba el estado y si hay un error simplemete modifica 
	;las banderas, no modifica los registros
		jz salir

	;******Guardar el archivo y su id***********
	mov dword [idarchivo], eax
	;Leer el archivo
	mov eax, 3
	mov ebx, [idarchivo]
	mov ecx, texto
	mov edx, 30
	int 80H



	imprimir mensaje, len



	;***CErrar el arvhivo****
	mov eax, 6		;servicio para cerrar el archivo
	mov ebx, [idarchivo]
	mov ecx, 0 
	mov edx, 0
	int 80H

salir:
	mov eax, 1
	mov ebx, 0
	int 80H

	mov eax, 1
	mov ebx, 0
	int 80H

