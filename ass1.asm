section .data
	msg1 db 'Hello World',10	;Assign 1 byte memory for every character in the string 
	msg1len: equ $-msg1		    ;Calculating the total memory required for storing the string in msg1len

section .text
	global _start			
	_start:
		mov rax,1				;Define Directive for Write operation in the 64 bit system
		mov rdi,1				;Define Directive for Write operation in the 64 bit system
		mov rsi,msg1			;Copy address of msg1 in source index register
		mov rdx,msg1len			;Creates a loop as long as the length of the string to display the string
		syscall					;System Call

mov rax,60						;Terminate code directive
xor rdi,rdi						;Terminate code directive
syscall							;System call


