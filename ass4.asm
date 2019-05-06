Section .data
msg1 db 'Enter 1st Name',10			;Assign 1 byte memory for every character in the string 
lenmsg1: equ $-msg1					;Calculating the total memory required for storing the string it in lenmsg1

msg2 db 'Enter 2nd Name',10			;Assign 1 byte memory for every character in the string 
lenmsg2: equ $-msg2					;Calculating the total memory required for storing the string it in lenmsg2

msg3 db 'Enter 3rd Name',10			;Assign 1 byte memory for every character in the string 
lenmsg3: equ $-msg3					;Calculating the total memory required for storing the string it in lenmsg3

Section .bss
msg4 resb 100						;Reserving 100 bytes for msg4 
lenmsg4 resb 1						;Reserving 1 bytes for lenmsg4 

msg5 resb 100						;Reserving 100 bytes for msg5 
lenmsg5 resb 1						;Reserving 1 bytes for lenmsg5 

msg6 resb 100						;Reserving 100 bytes for msg6 
lenmsg6 resb 1						;Reserving 1 bytes for lenmsg6 

Section .text

	global _start
	_start:
		mov eax,4					;Define Directive for Write operation in the 32 bit system
		mov ebx,1					;Define Directive for Write operation in the 32 bit system
		mov ecx,msg1				;Copy address of msg1 in ecx register
		mov edx,lenmsg1				;Creates a loop as long as the length of the string to display the string
		int 80H						;System call

		mov eax,3					;Define Directive for Read operation in the 32 bit system
		mov ebx,0					;Define Directive for Read operation in the 32 bit system
		mov ecx,msg4				;Stores the address of the  value read from msg4 in ecx register 
		mov edx,100					;Maximum size 
		int 80H						;System call

		mov [lenmsg4],eax			;Copy the length of the string calculated by the eax register to memory location of lenmsg4

		mov eax,4					;Define Directive for Write operation in the 32 bit system
		mov ebx,1					;Define Directive for Write operation in the 32 bit system
		mov ecx,msg4				;Copy address of msg1 in ecx register
		mov edx,[lenmsg4]			;Creates a loop as long as the length of the string to display the string
		int 80H						;System call


		mov eax,4					;Define Directive for Write operation in the 32 bit system
		mov ebx,1					;Define Directive for Write operation in the 32 bit system
		mov ecx,msg2				;Copy address of msg1 in ecx register
		mov edx,lenmsg2				;Creates a loop as long as the length of the string to display the string
		int 80H						;System call

		mov eax,3					;Define Directive for Read operation in the 32 bit system
		mov ebx,0					;Define Directive for Read operation in the 32 bit system
		mov ecx,msg5				;Stores the address of the  value read from msg4 in ecx register 
		mov edx,100					;Creates the loop of 100 keystrokes 
		int 80H						;System call

		mov [lenmsg5],eax			;Copy the length of the string calculated by the eax register to memory location of lenmsg4

		mov eax,4					;Define Directive for Write operation in the 32 bit system
		mov ebx,1					;Define Directive for Write operation in the 32 bit system
		mov ecx,msg5				;Copy address of msg1 in ecx register
		mov edx,[lenmsg5]			;Creates a loop as long as the length of the string to display the string
		int 80H

		mov eax,4					;Define Directive for Write operation in the 32 bit system
		mov ebx,1					;Define Directive for Write operation in the 32 bit system
		mov ecx,msg3				;Copy address of msg1 in ecx register
		mov edx,lenmsg3				;Creates a loop as long as the length of the string to display the string
		int 80H						;System call

		mov eax,3					;Define Directive for Read operation in the 32 bit system
		mov ebx,0					;Define Directive for Read operation in the 32 bit system
		mov ecx,msg6				;Stores the address of the  value read from msg4 in ecx register 
		mov edx,100					;Maximum size of 100 keystrokes
		int 80H						;System call
	
		mov [lenmsg6],eax			;Copy the length of the string calculated by the eax register to memory location of lenmsg4

		mov eax,4					;Define Directive for Write operation in the 32 bit system
		mov ebx,1					;Define Directive for Write operation in the 32 bit system
		mov ecx,msg6				;Copy address of msg1 in ecx register
		mov edx,[lenmsg6]			;Creates a loop as long as the length of the string to display the string
		int 80H						;System call

mov eax,1							;Terminate code 
mov ebx,0							;Terminate code
int 80H								;System call
