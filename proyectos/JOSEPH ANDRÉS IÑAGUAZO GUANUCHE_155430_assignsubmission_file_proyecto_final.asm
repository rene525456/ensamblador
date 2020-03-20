; Nombre: Joseph Andres Iñaguazo Gunuche.
; Ciclo: 6 Ciclo "B"


%macro escribir 2
	mov eax,4
	mov ebx,1
	mov ecx,%1 
	mov edx,%2
	int 80H	
%endmacro

%macro leer 2
    mov eax,3
    mov ebx,0
    mov ecx,%1 
    mov edx,%2
    int 80H 
%endmacro

section .bss
	numSeleccionPregunta resb 3
	solPregunta1 resb 10
	solPregunta2 resb 10
	solPregunta3 resb 10
	solPregunta4 resb 10
	solPregunta5 resb 10

section .data

	;lineas para la pregunta 1: BIT
	
	linea1 db 0x1b ,"[5;4f  ___________" 
	lenlinea1 equ $-linea1


	linea2 db 0x1b ,"[7;4f |___|___|___|" 
	lenlinea2 equ $-linea2

	linea3 db 0x1b ,"[6;3f1 |   |   |   |" 
	lenlinea3 equ $-linea3

	;resultado1
	result1 db 0x1b ,"[6;3f1 | B | I | T |" 
	lenresul1 equ $-result1
	
	;lineas para la pregunta 2: RAM
	
	linea4 db 0x1b ,"[5;25f    2   " 
	lenlinea4 equ $-linea4

	linea5 db 0x1b ,"[6;25f   ___" 
	lenlinea5 equ $-linea5

	linea6 db 0x1b ,"[7;25f  |   |" 
	lenlinea6 equ $-linea6

	linea7 db 0x1b ,"[8;25f  |___|" 
	lenlinea7 equ $-linea7

	linea8 db 0x1b ,"[9;25f  |   |" 
	lenlinea8 equ $-linea8

	linea9 db 0x1b ,"[10;25f  |___|" 
	lenlinea9 equ $-linea9

	linea10 db 0x1b ,"[11;25f  |   |" 
	lenlinea10 equ $-linea10

	linea11 db 0x1b ,"[12;25f  |___|" 
	lenlinea11 equ $-linea11
	
	;resultado2
	resultado2letra1 db 0x1b ,"[7;25f  | R |" 
	lenresultado2letra1 equ $-resultado2letra1
	resultado2letra2 db 0x1b ,"[9;25f  | A |" 
	lenresultado2letra2 equ $-resultado2letra2
	resultado2letra3 db 0x1b ,"[11;25f  | M |" 
	lenresultado2letra3 equ $-resultado2letra3
	
	;lineas para la pegunta 3: ASCII
	linea12 db 0x1b ,"[8;32f_______________" 
	lenlinea12 equ $-linea12

	linea13 db 0x1b ,"[9;32f   |   |   |   |" 
	lenlinea13 equ $-linea13

	linea14 db 0x1b ,"[10;32f___|___|___|___|" 
	lenlinea14 equ $-linea14

	linea15 db 0x1b ,"[9;48f 3" 
	lenlinea15 equ $-linea15
	;resultado 3
	resultado3 db 0x1b ,"[9;28f A | S | C | I | I |" 
	lenresultado3 equ $-resultado3



	;lineas para la pregunta 4: 10011
	linea16 db 0x1b ,"[5;50f  ___" 
	lenlinea16 equ $-linea16

	linea17 db 0x1b ,"[6;50f |   |" 
	lenlinea17 equ $-linea17

	linea18 db 0x1b ,"[7;50f |___|" 
	lenlinea18 equ $-linea18

	linea19 db 0x1b ,"[8;50f |   |" 
	lenlinea19 equ $-linea19

	linea20 db 0x1b ,"[9;50f |___|" 
	lenlinea20 equ $-linea20

	linea21 db 0x1b ,"[10;50f |   |" 
	lenlinea21 equ $-linea21

	linea22 db 0x1b ,"[11;50f |___|" 
	lenlinea22 equ $-linea22

	linea23 db 0x1b ,"[12;50f |   |" 
	lenlinea23 equ $-linea23

	linea24 db 0x1b ,"[13;50f |___|" 
	lenlinea24 equ $-linea24

	linea25 db 0x1b ,"[14;50f |   |" 
	lenlinea25 equ $-linea25

	linea26 db 0x1b ,"[15;50f |___|" 
	lenlinea26 equ $-linea26

	linea27 db 0x1b ,"[4;50f   4   " 
	lenlinea27 equ $-linea27


	;resultado4

	resultado4letra1 db 0x1b ,"[6;50f | 1 |" 
	lenresultado4letra1 equ $-resultado4letra1
	resultado4letra2 db 0x1b ,"[8;50f | 0 |"  
	lenresultado4letra2 equ $-resultado4letra2
	resultado4letra3 db 0x1b ,"[10;50f | 0 |" 
	lenresultado4letra3 equ $-resultado4letra3
	resultado4letra4 db 0x1b ,"[12;50f | 1 |" 
	lenresultado4letra4 equ $-resultado4letra4
	resultado4letra5 db 0x1b ,"[14;50f | 1 |" 
	lenresultado4letra5 equ $-resultado4letra5


	;impresion para la pregunta 5: SLOTS

	linea28 db 0x1b ,"[8;4f  ___________________" 
	lenlinea28 equ $-linea28

	linea29 db 0x1b ,"[9;4f |   |   |   |   |   |" 
	lenlinea29 equ $-linea29

	linea30 db 0x1b ,"[10;4f |___|___|___|___|___|" 
	lenlinea30 equ $-linea30

	linea31 db 0x1b ,"[9;3f5" 
	lenlinea31 equ $-linea31

	;resultado 5
	resultado5 db 0x1b ,"[9;4f | S | L | O | T | S |" 
	lenresultado5 equ $-resultado5


	;fin de impresiones del crucigrama
	

	mensaje1 db  0x1b ,"[25;1f Ingrese la palabra-> "
	lenMensaje1 equ $-mensaje1


	mensajeSeleccionPregunta db 0x1b ,"[31m", 0x1b, "[17;1f Preguntas: ",0x1b ,"[18;1f  1.Unidad mínima de información en informática.",0x1b ,"[19;1f  2.Memoria donde se almacenan los datos con los que está trabajando el ordenador en ese momento.",0x1b ,"[20;1f  3.Código que usan los ordenadores.",0x1b ,"[21;1f  4.Número 19 en binario.",0x1b ,"[22;1f  5.Así se llaman en inglés las ranuras de expansión.",0x1b ,"[23;1f  6.SALIR ",0x1b ,"[33m",0x1b, "[24;1f Ingrese el número de pregunta-> " 
	lenMensajeSeleccionPregunta equ  $-mensajeSeleccionPregunta

	borrarResultSeleccion db 0x1b ,"[24;32f                 "
	lenBorrarResulSeleccion equ $-borrarResultSeleccion

	borrarResultMensaje1 db 0x1b ,"[25;20f                 ",0x1b, "[37m"
	lenBorrarResultMensaje1 equ $-borrarResultMensaje1

	respuesta1 db "BIT"
	lenRespuesta1 equ $-respuesta1

	respuesta2 db "RAM"
	lenRespuesta2 equ $-respuesta2

	respuesta3 db "ASCII"
	lenRespuesta3 equ $-respuesta3

	respuesta4 db "10011"
	lenRespuesta4 equ $-respuesta4

	respuesta5 db "SLOTS"
	lenRespuesta5 equ $-respuesta5

	msg db 0x1b, "[36m", 0x1b, "[1m", "                          CRUCIGRAMA ENSAMBLADOR", 0x1b, "[37m" 
	len1 equ $-msg	

	
section .text
    global _start    

_start:

	escribir msg, len1

	;impresion lineas para la pregunta 1
	escribir linea1,lenlinea1
	escribir linea3,lenlinea3
	escribir linea2,lenlinea2

	; impresion lineas para la pregunta 2
	escribir linea4,lenlinea4
	escribir linea5,lenlinea5
	escribir linea6,lenlinea6
	escribir linea7,lenlinea7
	escribir linea8,lenlinea8
	escribir linea9,lenlinea9
	escribir linea10,lenlinea10
	escribir linea11,lenlinea11

	;impresion lineas para la pregunta 3
	escribir linea12,lenlinea12
	escribir linea13,lenlinea13
	escribir linea14,lenlinea14
	escribir linea15,lenlinea15

	;impresion lineas para la pregunta 4
	escribir linea16,lenlinea16
	escribir linea17,lenlinea17
	escribir linea18,lenlinea18
	escribir linea19,lenlinea19
	escribir linea20,lenlinea20
	escribir linea21,lenlinea21
	escribir linea22,lenlinea22
	escribir linea23,lenlinea23
	escribir linea24,lenlinea24
	escribir linea25,lenlinea25
	escribir linea26,lenlinea26
	escribir linea27,lenlinea27

	;impresion lineas para la pregunta 5
	escribir linea28,lenlinea28
	escribir linea29,lenlinea29
	escribir linea30,lenlinea30
	escribir linea31,lenlinea31

	
menu:

	;imprimimos el mensaje ingresar 
	escribir mensajeSeleccionPregunta,lenMensajeSeleccionPregunta

	;guardamos el resultado del mensaje
	leer numSeleccionPregunta,3


	escribir borrarResultSeleccion,lenBorrarResulSeleccion
	
	mov al,[numSeleccionPregunta] ;enviamos a "al" el numero ingresado
	sub al,'0' ;transformamos el caracter que recibimos a un numero

	cmp al,1
	jz pregunta1

	cmp al,2
	jz pregunta2

	cmp al,3
	jz pregunta3

	cmp al,4
	jz pregunta4

	cmp al,5
	jz pregunta5

	cmp al,6
	jz salir

	jmp menu

salir:
	mov eax, 1
	int 80H


pregunta1:

	escribir mensaje1,lenMensaje1 ; imprimimos el mensaje de la pregunta 1
	leer solPregunta1,10 ; recojemos el mensaje del usuario
	escribir borrarResultMensaje1, lenBorrarResultMensaje1

	mov ecx,lenRespuesta1
	cicloloop1:
		push ecx
		dec ecx
		mov al,[solPregunta1+ecx] ;movemos la letra ingresada del usuario en al
		mov bl,[respuesta1+ecx] ;movemos la letra de la respuesta correcta a bl
		cmp al,bl
		jne menu

		pop ecx
		loop cicloloop1
	jmp llenarResultado1
	

pregunta2:

	escribir mensaje1,lenMensaje1 ; imprimimos el mensaje de la pregunta 1
	leer solPregunta2,10 ; recojemos el mensaje del usuario
	escribir borrarResultMensaje1, lenBorrarResultMensaje1

	mov ecx,lenRespuesta2	
	cicloloop2:
		push ecx
		dec ecx
		mov al,[solPregunta2+ecx] ;movemos la letra ingresada del usuario en al
		mov bl,[respuesta2+ecx] ;movemos la letra de la respuesta correcta a bl
		cmp al,bl
		jne menu

		pop ecx
		loop cicloloop2
	jmp llenarResultado2
	

pregunta3:

	escribir mensaje1,lenMensaje1 ; imprimimos el mensaje de la pregunta 1
	leer solPregunta3,10 ; recojemos el mensaje del usuario
	escribir borrarResultMensaje1, lenBorrarResultMensaje1

	mov ecx,lenRespuesta3
	cicloloop3:
		push ecx
		dec ecx
		mov al,[solPregunta3+ecx] ;movemos la letra ingresada del usuario en al
		mov bl,[respuesta3+ecx] ;movemos la letra de la respuesta correcta a bl
		cmp al,bl
		jne menu

		pop ecx
		loop cicloloop3
	jmp llenarResultado3


pregunta4:

	escribir mensaje1,lenMensaje1 ; imprimimos el mensaje de la pregunta 1
	leer solPregunta4,10 ; recojemos el mensaje del usuario
	escribir borrarResultMensaje1, lenBorrarResultMensaje1

	mov ecx,lenRespuesta4
	cicloloop4:
		push ecx
		dec ecx
		mov al,[solPregunta4+ecx] ;movemos la letra ingresada del usuario en al
		mov bl,[respuesta4+ecx] ;movemos la letra de la respuesta correcta a bl
		cmp al,bl
		jne menu

		pop ecx
		loop cicloloop4
	jmp llenarResultado4



pregunta5:

	escribir mensaje1,lenMensaje1 ; imprimimos el mensaje de la pregunta 1
	leer solPregunta5,10 ; recojemos el mensaje del usuario
	escribir borrarResultMensaje1, lenBorrarResultMensaje1

	mov ecx,lenRespuesta5
	cicloloop5:
		push ecx
		dec ecx
		mov al,[solPregunta5+ecx] ;movemos la letra ingresada del usuario en al
		mov bl,[respuesta5+ecx] ;movemos la letra de la respuesta correcta a bl
		cmp al,bl
		jne menu

		pop ecx
		loop cicloloop5
	jmp llenarResultado5


llenarResultado1:
	escribir result1,lenresul1
	jmp menu

llenarResultado2:
	escribir resultado2letra1,lenresultado2letra1
	escribir resultado2letra2,lenresultado2letra2
	escribir resultado2letra3,lenresultado2letra3

	jmp menu

llenarResultado3:
	escribir resultado3,lenresultado3
	
	jmp menu

llenarResultado4:
	escribir resultado4letra1,lenresultado4letra1
	escribir resultado4letra2,lenresultado4letra2
	escribir resultado4letra3,lenresultado4letra3
	escribir resultado4letra4,lenresultado4letra4
	escribir resultado4letra5,lenresultado4letra5
	
	jmp menu

llenarResultado5:
	escribir resultado5,lenresultado5
	jmp menu

