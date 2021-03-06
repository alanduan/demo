all: boot.img

boot.img: boot.bin
	dd if=/dev/zero of=boot.img bs=512 count=2880
	dd if=boot.bin of=boot.img conv=notrunc

boot.bin: $(name).asm
	nasm $(name).asm -f bin -o boot.bin
