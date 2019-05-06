Section .data
msg1 db 'Program of Addition',10 		;Define Message 1
lenmsg1: equ $-msg1 		  			;Reserve Length of message 1

msg2 db 'Enter the 1st no',10    		;Define Message 2
lenmsg2: equ $-msg2              	 	;Reserve Length of message 2

msg3 db 'Enter the 2nd no',10    		;Define Message 3
lenmsg3: equ $-msg3               		;Reserve Length of message 3

msg4 db 'The result is',10      		;Define Message 4
lenmsg4: equ $-msg4             		;Reserve Length of message 4

msg5 db '',10                    		;Define Message 5
lenmsg5: equ $-msg5              		;Reserve Length of message 5

Section .bss
a resb 3			 					;Reserve 2 bytes for variable a
b resb 3			 					;Reserve 2 bytes for variable b
res resb 3 			 					;Reserve 2 bytes for variable result

Section .text

	global _start
	_start:
		mov eax,4						;define directive for write operation
		mov ebx,1						;define directive for write operation
		mov ecx,msg1    				;Move value of msg1 in ecx register
		mov edx,lenmsg1 				;Move length of msg1 to edx register
		int 80H							;system call for 32 bit

		mov eax,4						;define directive for write operation
		mov ebx,1						;define directive for write operation
		mov ecx,msg2 					;Move value of msg2 in ecx register
		mov edx,lenmsg2 				;Move length of msg2 to edx register
		int 80H							;system call for 32 bit

		mov eax,3						;define directive for read operation
		mov ebx,0						;define directive for read operation
		mov ecx,a						;storing value of a in ecx register	
		mov edx,3       				;moving allocated memory of a in edx register
		int 80H							;system call for 32 bit

		mov eax,4						;define directive for write operation
		mov ebx,1						;define directive for write operation
		mov ecx,msg3					;Move value of msg3 in ecx register
		mov edx,lenmsg3 				;Move length of msg3 to edx register
		int 80H							;system call for 32 bit

		mov eax,3						;define directive for read operation
		mov ebx,0						;define directive for read operation
		mov ecx,b						;storing value of b in ecx register
		mov edx,3						;moving allocated memory of b in edx register
		int 80H							;system call for 32 bit

		mov al,[a]						;contents of a is directly stored in al register
		mov bl,[b]						;contents of b is directly stored in bl register

		sub al,'0'						;subtracting ascii value of 0 from al register
		sub bl,'0'						;subtracting ascii value of 0 from bl register
		
		add al,bl						;adding contents of bl regsiter to al register
		add al,'0'						;adding ascii value of 0 to al register
		mov [res],al					;moving value of al register directly to res 

		mov eax,4						;define directive for write operation
		mov ebx,1						;define directive for write operation
		mov ecx,msg4    				;Move value of msg4 in ecx register
		mov edx,lenmsg4 				;Move length of msg4 to edx register
		int 80H							;system call for 32 bit

		mov eax,4						;define directive for write operation
		mov ebx,1						;define directive for write operation
		mov ecx,res						;Move value of res in ecx register
		mov edx,2						;moving allocated memory of res in edx register
		int 80H							;system call for 32 bit

		mov eax,4						;define directive for write operation
		mov ebx,1						;define directive for write operation
		mov ecx,msg5					;Move value of msg5 in ecx register
		mov edx,lenmsg5 				;Move length of msg5 to edx register
		int 80H							;system call for 32 bit

mov eax,1  								;moviing directive of terminating the code in eax register
mov ebx,0								;moviing directive of terminating the code in ebx register
int 80H									;system call for 32 bit



		




