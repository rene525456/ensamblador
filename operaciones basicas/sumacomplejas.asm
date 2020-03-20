%macro escribir 2
     mov	eax,4
     mov	ebx,1
     mov	ecx,%1
     mov	edx,%2
     int	0x80
%endmacro

section	.data
     msg db 'La suma es:',0xa
     len equ $ - msg
     num1 db '077'
     num2 db '097'
     sum db '     '

section	.text
     global _start

_start:
     mov esi, 2  	;pointing to the rightmost digit
     mov ecx, 3  	;num of digits
     clc	;apaga el bit correspondiente a la bandera de acarreo, o sea, lo pone en cero.

add_loop:  
     mov al, [num1 + esi] ;Lleva a cabo la suma de dos operandos y suma uno al resultado en caso de 
     	      ;que la bandera CF esté activada, esto es, en caso de que exista acarreo.
     adc al, [num2 + esi] ;la operación que realiza es: AL = ( AH + BL ) + CF
	      ;acarrea un bit al siguiente paso de la instrucción
	      ;adc suma el contenido de la bandera CF (0/1) al primer operando y despues
	      ;suma el 2do operando al 1ro
     aaa	      ;Convierte el número almacenado en AL a BCD desempaquetado. La idea es 
	      ;aplicarlo después de sumar BCDs no empaquetados. Esta instrucción mira 
	      ;los 4 bits más bajos de AL: si es mayor que 9 o AF (Flag Auxiliar) es 
	      ;igual a 1, suma 6 a AL, 1 a AH, hace AF=CF=1, y los cuatro bits más 
	      ;significativos de AL los deja a 0. ¿Lo qué?

	;BCD es un código numérico y puede utilizarse en operaciones aritméticas. La suma es la
	;más importante de estas operaciones, ya que las otras tres operaciones (sustracción,
	;multiplicación y división) se pueden llevar a cabo utilizando la suma. Para sumar dos números en BCD:
	;Paso 1. Sumar los dos números BCD utilizando las reglas de la suma binaria
	;Paso 2. Si una suma de 4 bits es igual o menor que 9, es un número BCD válido.
	;Paso 3. Si una suma de 4 bits es mayor que 9, o si genera un acarreo en el grupo de 4 bits,
	;el resultado no es válido. En este caso, se suma 6 (0110) al grupo de 4 bits para saltar así
	;los seis estados no válidos y pasar al código 8421. Si se genera un acarreo se suma un 6, al
	;grupo de 4 bits siguiente.

     pushf
     or al, 30h     ;AAS -- ASCII Adjust AL after Subtraction
     popf
     mov [sum + esi], al
     dec esi
     loop add_loop
		
     escribir msg, len
     escribir sum, 3
		
     mov eax,1
     int 0x80
