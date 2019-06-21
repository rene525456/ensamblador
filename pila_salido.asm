section	.data
   msj1 db 'hola clase 0',13, 10
   len equ $-msj1
   msj2 db 'hola clase 1',13, 10
   len equ $-msj2


section	.text
   global _start        ;must be declared for using gcc
	
_start:	                ;tell linker entry point

   mov eax, 4
   mov ebx, 1
   push ecx
   mov ecx, hello        
   mov edx, len        
   int 0x80
   pop ecx
   mov eax,1             ;system call number (sys_exit)
   int 0x80              ;call kernel
