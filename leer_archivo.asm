%macro escribe 2
	mov eax, 4
	mov ebx, 1
	mov ecx, %1
	mov edx, %2
	int 0x80
%endmacro

segment .data
	msg2 db "Leer desde un archivo :",0xA
	len2 equ $-msg2
	archivo db "/home/rene/proyectos/ensamblador/archivo.txt",0

segment .bss
	texto resb 30
	idarchivo resd 1

segment .text
	global _start

_start:
	mov eax, 5		; Servicios para el trabajo con archivos
				; Servicio 5: apertura (open). Los parámetros necesarios son:
	mov ebx, archivo	; EBX: la dirección de una cadena de caracteres terminada en nulo.
	mov ecx, 0	; ECX: Modo de acceso.
	mov edx, 0	; EDX: permisos al archivo, si se abre creándolo.
	int 0x80

	; Modos de acceso:
	; O-RDONLY 0: El archivo se abre sólo para leer de él.
	; O-WRONLY 1: El archivo se abre sólo para escribir en él.
	; O-RDWR 2: El archivo se abre para lectura y escritura.
	; O-CREAT 256: Crear el archivo en caso de que no exista.
	; O-APPEND 2000h: El archivo se abre sólo para escritura al final, 
	; añadiendo información.	

	test eax, eax	; instrucción de comparación realiza la operación lógica “Y” de dos operandos, 
		; pero NO afecta a ninguno de ellos, SÓLO afecta al registro de estado. Admite 
		; todos los tipos de direccionamiento excepto los dos operandos en memoria
		; TEST reg, reg
		; TEST reg, mem
		; TEST mem, reg
		; TEST reg, inmediato
		; TEST mem, inmediato 
	jz salir
	mov dword[idarchivo], eax

	escribe msg2, len2

	mov eax, 3		; Servicio 3: lectura (read). Los parámetros necesarios son:
	mov ebx, [idarchivo]	; EBX: unidad de entrada (0: entrada estándar).
	mov ecx, texto		; ECX: Puntero a un área de memoria donde se dejarán los caracteres obtenidos.
	mov edx, 13		; EDX: Número máximo de caracteres a leer.
	int 0x80

	escribe texto, 13

	mov eax, 6		; STD	POSIX	{ int close(int fd); }
	mov ebx, [idarchivo]
	mov ecx, 0
	mov edx, 0
	int 0x80

salir:
	mov eax, 1
	xor ebx, ebx
	int 0x80
