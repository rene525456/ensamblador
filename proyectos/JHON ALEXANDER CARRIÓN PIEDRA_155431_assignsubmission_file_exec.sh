if [ $# -eq 1 ]
then
    echo "Compilado y ejecutado"
    nasm -f elf $1.asm;ld -m elf_i386 -s -o $1 $1.o
    sync && ./$1
else
    echo "Error"
    echo "Error"
fi
