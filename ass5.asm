section .data
msg1 db "Enter the First name",10		;Assign 1 byte memory for every character in the string
msglen1: equ $-msg1						;Calculating the total memory required for storing the string it in lenmsg1

msg2 db "Enter the middle name",10		;Assign 1 byte memory for every character in the string
msglen2: equ $-msg2						;Calculating the total memory required for storing the string it in lenmsg2

msg3 db "Enter the Last name",10		;Assign 1 byte memory for every character in the string
msglen3: equ $-msg3						;Calculating the total memory required for storing the string it in lenmsg3

section .bss
msg4 resb 100							;Reserving 100 bytes for msg4 
msglen4 resb 1							;Reserving 1 bytes for lenmsg4 

msg5 resb 100							;Reserving 100 bytes for msg5 
msglen5 resb 1							;Reserving 1 bytes for lenmsg5 

msg6 resb 100							;Reserving 100 bytes for msg6 
	msglen6 resb 1						;Reserving 1 bytes for lenmsg6 

section .data
	global _start
		_start:
		
		%macro write 2					;%macro-function that reduces the number of lines write-name of the function
			mov eax,4					;Define Directive for Write operation in the 32 bit system
			mov ebx,1					;Define Directive for Write operation in the 32 bit system
			mov ecx,%1					;%1-function used instead of memory location during call
			mov edx,%2					;%2-function used instead of memory location during call
			int 80h						;System call
		%endmacro						;closing the macro function
		
		%macro read 2					;%macro-function that reduces the number of lines read-name of the function
			mov eax,3					;Define Directive for Read operation in the 32 bit system
			mov ebx,0					;Define Directive for Read operation in the 32 bit system
			mov ecx,%1					;%1-function used instead of memory location during call
			mov edx,%2					;%2-function used instead of memory location during call or giving memory
			int 80h						;System call
		%endmacro						;closing the macro function
		
				write msg1,msglen1		;using macro fuction by calling write label declaring msg1 & msglen1
				read msg4,100			;using macro fuction by calling read label declaring msg4 & 100-memory
				
				mov [msglen4],eax		;Copy the length of the string calculated by the eax register to memory location of lenmsg4
				
				write msg4,[msglen4]    ;using macro fuction by calling write label declaring msg4 & msglen4
				
				write msg2,msglen2		;using macro fuction by calling write label declaring msg2 & msglen2
				read msg5,100			;using macro fuction by calling read label declaring msg5 & 100-memory
				
				mov [msglen5],eax		;Copy the length of the string calculated by the eax register to memory location of lenmsg5
				
				write msg5,[msglen5]	;using macro fuction by calling write label declaring msg5 & msglen5
				
				write msg3,msglen3		;using macro fuction by calling write label declaring msg3 & msglen3
				read msg6,100			;using macro fuction by calling write label declaring msg6 & 100-memory
				
				mov [msglen6],eax		;Copy the length of the string calculated by the eax register to memory location of lenmsg6
				
				write msg6,[msglen6]	;using macro fuction by calling write label declaring msg6 & msglen6
				
mov eax,1								;Terminate code
mov ebx,0								;Terminate code
int 80h									;System call
