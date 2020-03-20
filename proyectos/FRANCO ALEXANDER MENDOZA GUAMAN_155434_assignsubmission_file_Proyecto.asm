%macro presentar 2
	mov eax,4
	mov ebx,1
	mov ecx,%1
	mov edx,%2
	int 80h
%endmacro

%macro asigna 2
	mov eax,3
	mov ebx,%1
	mov ecx,%2
	mov edx,10
	int 80H
%endmacro

section .data
	bienvenido db 'BIENVENIDO',10
	lenb EQU $ -bienvenido
	nomb db 'Ingrese su nombre:',10
	len equ $ -nomb
	final db 'El juego ha terminado',10
	lenf EQU $ -final
	punt db 'Numero de moviminetos:     '
	lenp EQU $ -punt
	salto db '',10
	l1 db '--------------------'
	l2 db '|   |   | |   |   | '
	l3 db 'D | | |   | |   |   '
	l4 db '| |   | |   | |   | '
	marriba db 'arriba'
	mabajo db 'abajo'
	mfrente db 'frente'
	cho db 'CHOQUE'
	lencho EQU $ -cho
	pared db '|'


section .bss
	nombre resb 10
	puntaje resb 02
	movimientos resb 02
	ir resb 1
	linea resb 1

section .text
	global _start
_start:
	presentar salto, 01
	presentar bienvenido, lenb
	presentar salto, 01
	presentar nomb, len
	asigna 1, nombre

	mov esi, 0
	mov bl, 3
	add bl, '0'
	mov [ecx], bl
	push ecx
	mov cl, 0
	add cl, '0'
	mov [puntaje], cl
	presentar puntaje, 02

juego:
	cmp esi, 20
	JZ fin
	presentar salto, 1
	call mapa
	presentar salto, 1	
	
	pop ecx
	mov bl, [ecx]
	sub bl, '0'
	cmp bl, 2
	jz borrarl2
	cmp bl, 3
	jz borrarl3
	cmp bl, 4
	jz borrarl4
	
	
	jmp mover

mover:
	add bl, '0'
	mov [ecx], bl
	push ecx
	mov cx, [puntaje]
	inc cx
	mov [puntaje], cx
	asigna 1, ir
	mov al, [ir]
	sub al , '0'
	cmp al, 8
	JZ arriba
	cmp al, 2
	JZ abajo
	cmp al, 6
	JZ frente
	
	jmp juego

arriba:
	pop ecx
	mov bl, [ecx]
	sub bl, '0'
	cmp bl, 2
	JZ choque
	cmp bl, 3
	JZ lin2
	cmp bl, 4
	JZ lin3
	jmp juego
abajo:
	pop ecx
	mov bl, [ecx]
	sub bl, '0'
	cmp bl, 2
	JZ lin3
	cmp bl, 3
	JZ lin4
	cmp bl, 4
	JZ choque
	jmp juego
frente:
	inc esi
	pop ecx
	mov bl, [ecx]
	;inc bl
	sub bl, '0'
	cmp bl, 3
	JZ lin3
	cmp bl, 2
	JZ lin2
	cmp bl, 4
	JZ lin4
	jmp juego
	
lin3:
	mov bl, 3
	add bl, '0'
	mov [ecx], bl
	push ecx
	mov al, [l3+esi]
	mov bl, [pared]
	cmp al, bl
	jz choque
	mov [l3+esi], byte 'D'
	jmp juego

lin2:
	mov bl, 2
	add bl, '0'
	mov [ecx], bl
	push ecx
	mov al, [l2+esi]
	mov bl, [pared]
	cmp al, bl
	jz choque
	mov [l2+esi], byte 'D'
	jmp juego


lin4:
	mov bl, 4
	add bl, '0'
	mov [ecx], bl
	push ecx
	mov al, [l4+esi]
	mov bl, [pared]
	cmp al, bl
	jz choque
	mov [l4+esi], byte 'D'
	jmp juego

mapa:
	presentar l1, 20
	presentar salto, 1
	presentar l2, 20
	presentar salto, 1
	presentar l3, 20
	presentar salto, 1
	presentar l4, 20
	presentar salto, 1
	presentar l1, 20
	presentar salto, 1
	ret

borrarl2:
	mov [l2+esi],byte ' '
	jmp mover
borrarl3:
	mov [l3+esi],byte ' '
	jmp mover
borrarl4:
	mov [l4+esi],byte ' '
	jmp mover

choque:
	presentar salto, 1
	presentar cho, 6 
	presentar salto, 1
	jmp fin

fin:
	presentar final, lenf
	presentar salto, 1
	presentar nombre, 10
	presentar punt, lenp
	presentar puntaje, 2
	presentar salto, 1
	mov eax, 01
	int 80H
