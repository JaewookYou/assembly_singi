global _start
section .data
	lf db 0x0a ;line feed
	star db 0x2a ; star
section .text
_start:
	mov rbp, rsp
	add rbp, 16
	mov r10, [rbp]
	mov ax, [r10]
	movzx r10, ax; get argu
	cmp r10, 0
	je end ; if arg==0 exit
	cmp r10, 0x39
	jg end
	cmp r10, 0x31
	je one
	mov r12, 0x30
	loop2:
		inc r12
		mov r13, 0x30
		loop3:
			inc r13
			call _pstar
			cmp r13, r12
			jl loop3
		call _plf
		cmp r12, r10
		jl loop2	; Phase 1
	loop4:
		dec r12
		mov r13, r12
		loop5:
			dec r13
			call _pstar
			cmp r13, 0x30
			jg loop5
		call _plf
		cmp r12, 0x31
		jg loop4	; Phase2
	end:
		mov rax, 60
		syscall
	one:
		call _pstar
		call _plf
		jmp end
	

_plf:
	mov rax, 1
	mov rdi, 1
	mov rsi, lf
	mov rdx, 1
	syscall
	ret
_pstar:
	mov rax, 1
	mov rdi, 1
	mov rsi, star
	mov rdx, 4
	syscall
	ret
