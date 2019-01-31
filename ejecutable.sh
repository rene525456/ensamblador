if [ $# -eq 1 ]
then 
	echo "Compilando y ejecutando"
	nasm -f elf64 $1.asm; ld -m -s -o $1 $1.o
	echo "Ejecutando........"
	./$1
else
	echo ".............."
	echo "ERROR"
fi
