all: socket_jaewook pyramid_jaewook

socket_jaewook: socket_jaewook
	nasm -f elf64 -o socket_jaewook.o socket_jaewook.s;ld -o socket_jaewook socket_jaewook.o

pyramid_jaewook: pyramid_jaewook
	nasm -f elf64 -o pyramid_jaewook.o pyramid_jaewook.s;ld -o pyramid_jaewook pyramid_jaewook.o

clean:
	rm *.o socket_jaewook pyramid_jaewook
