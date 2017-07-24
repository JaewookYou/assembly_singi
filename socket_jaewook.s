
global _start

section .data
	addr dw 2
	     db 05h, 39h
	     db 0dh, 7ch, 4bh, 14h
	len  db 16
	lf   db 0x0a


section .text

_start:
	mov rax, 41
	mov rdi, 2
	mov rsi, 1
	mov rdx, 0
	syscall ; socket

	mov rdi, rax
	mov rax, 42
	mov rsi, addr
	mov rdx, 16
	syscall ; connect

	sub rsp, 0x40
	mov rax, 45
	mov rsi, rsp
	mov rdi, 3
	mov rdx, 0x40
	mov r10, 0
	mov r8, addr
	mov r9, len
	syscall ;recv_from

	mov r13, rax ; buf len
	mov r14, rsi ; buf

	mov rax, 1
	mov rdi, 1
	mov rsi, r14
	mov rdx, r13
	syscall ; print buf

	mov rax, 1
	mov rdi, 1
	mov rsi, lf
	mov rdx, 1
	syscall ; print linefeed

	sub r13, 2
	;r13=buf len
	;r14=buf
	;r12=end fo buf
	;r10=tmp
	mov r12, r14
	add r12, r13 ; end of buf

	loop1:
		mov al, [r14] ; 00bf
		mov ah, al ; bfbf 
		mov al, [r12] ; bfen
		mov [r14], al ; save end to buf
		;movzx r10, ax
		shr ax, 8
		mov [r12], al
		inc r14
		dec r12
		cmp r12, r14
		jl out
		jmp loop1
	out:

	inc r13
	mov rax, 44
	mov rdi, 3
	mov rsi, rsp
	mov rdx, r13
	mov r10, 0
	mov r8, addr
	mov r9, r13
	syscall ; send

	mov rbp, rsp
	add rbp, r13
	mov al, 0x0a
	mov [rbp], al

	sub rsp, 0x40

	mov rax, 45
	mov rdi, 3
	mov rsi, rsp
	mov rdx, 0x40
	mov r10, 0
	mov r8, addr
	mov r9, len
	syscall

	mov rax, 1
	mov rdi, 1
	mov rsi, rsp
	mov rdx, 3
	syscall

	call _plf

	add rsp, 0x40

	inc r13

	mov rax, 1
	mov rdi, 1
	mov rsi, rsp
	mov rdx, r13
	syscall ; print buf

	call _plf
e:
	mov rax, 60
	mov rdi, 0
	syscall

_plf:
	mov rax, 1
	mov rdi, 1
	mov rsi, lf
	mov rdx, 1
	syscall
	ret
