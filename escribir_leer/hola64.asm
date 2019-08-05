SECTION .data
	msg:      db "Hello, world,", 0
	fmt:      db "%s", 10, 0

SECTION .text
        extern printf
        global _start
_start:

        mov esi, msg    ; 64-bit Direccion comienzo de la cadena
        mov edi, fmt    ; Formato de la cadena
        mov eax, 0      ; printf is varargs,  EAX cuenta

                        ;el numero de argumentos no enteros pasados
        call printf

        mov ebx, 0      ; normal-exit code
        mov eax, 1      ; process-termination service
        int 0x80        ; linux kernel service
