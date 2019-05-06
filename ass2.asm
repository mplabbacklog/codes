section .data
	msg1 db 'Hello World',10	;Assign 1 byte memory for every character in the string 
	msg1len: equ $-msg1			;Calculating the total memory required for storing the string it in msg1len

section .text
	global _start
	_start:
		mov eax,4				;Define Directive for Write operation in the 32 bit system
		mov ebx,1				;Define Directive for Write operation in the 32 bit system
		mov ecx,msg1			;Copy address of msg1 in ecx register
		mov edx,msg1len			;Creates a loop as long as the length of the string to display the string
		int 80H					;System Call

mov eax,1						;Terminate code directive
mov ebx,0						;Terminate code directive
int 80H							;System Call

