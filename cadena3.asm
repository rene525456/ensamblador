;Date: 2020-July-26
;autor:Israel Leon @LEON12699
;Tema: programa que remplaza la A-a por @ 
;
;https://gitlab.com/LEON12699/ensamblador_nasm/

;do ejecutable linux:

;nasm -f elf64 -o replace_cadena.o replace_cadena.asm 
;ld -o replace_cadena replace_cadena.o


%macro print 2  ; definición de macro con nombre imprimir y recibe dos parámetros
    mov eax,4;		<valor de subrutina para escritura en pantalla>
    mov ebx,1;		estandar para salida de datos
    mov ecx,%1;		primer valor en el macro es el mensaje que se va a imprimir, almacena en registro ecx 
    mov edx,%2;		el segundo valor que define la longitud  del mensaje a imprimir, almacena en registro edx
    int 80H;			interrupción del sitema	
%endmacro

%macro read 2  ; definición de macro con nombre imprimir y recibe dos parámetros
    mov eax,3;		valor de subrutina para escritura en pantalla
    mov ebx,2;		estandar para salida de datos
    mov ecx,%1;		primer valor en el macro es el mensaje que se va a imprimir, almacena en registro ecx 
    mov edx,%2;		el segundo valor que define la longitud  del mensaje a imprimir, almacena en registro edx
    int 80H;			interrupción del sitema	
%endmacro

	
section .data
    Input db "Ingresa cadena:",10,0
    LEN_Input equ $-Input

    RESPUESTA db "Resultado :" ,0
    LEN_RESPUESTA equ $-RESPUESTA

section .bss
    String resb 100
    le resb 3
    
section .text
    global _start        
	
_start:
    
;*********************************
;       INGRESO DE DATOS
;*******************************

    print Input,LEN_Input ; 
    read String,100             ; ingreso de cadena
    mov eax,String
    
;*****************************************+
;          Cálculo  de longitud 
;***************************************

len:                
    mov ebx, eax    ; se lleva la cadena de eax a ebx    


    nextchar:
        cmp byte[ebx], 0 ; cheque si ebx == a 0 
        jz endLen        ; salta a endlen si es asi 
        inc ebx          ; incremeneta ebx en 1        
        jmp nextchar     ; continua el ciclo

    endLen:
        sub ebx, eax    ; resta ebx =ebx-eax , da como resultado la longitud en ebx


    mov [le],ebx           ; se guarda la longitud en le

    mov    ecx, [le]    ; se almacena la longitud en le en ecx para el loop
    mov    esi, String      ; se mueve el recurso inicial al registro eString
    mov    edi, String      ; se mueve al registro edi el destino 


;*****************************************+
;           Código de cambio 
;***************************************

loop_here:
    lodsb           ;guarda el registro (byte) de esi en al y suma esi en uno
        
    cmp al,65       ;a
    jz cambia
    cmp al,97       ;A
    jnz salir

    cambia:
        mov al,64

    salir:
        stosb           ; guarda el valor de al en edi
        loop    loop_here        ; ciclo  
        cld             ; se limpian registros
        
    
    print RESPUESTA,LEN_RESPUESTA    
    print String,[le]       
    
        
mov     eax,1         ;system call number (sys_exit)
int     0x80          ;call kernel
