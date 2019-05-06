section .data
   msg1 db 'Program to Display numbers',10		;Assign 1 byte memory for every character in the string 
   msg1len: equ $-msg1							;Calculating the total memory required for storing the string it in msg1len
   
   msg2 db '',10								;Assign 1 byte memory for every character in the string 
   msg2len: equ $-msg2							;Calculating the total memory required for storing the string it in msg2len

section .bss
num1 resb 16									;Reserving 16 bytes for variable num1 
cnt resb 4										;Reserving 4 bytes for variable cnt
mem resb 10										;Reserving 10 bytes for variable mem 
dis resb 8										;Reserving 8 bytes for variable dis 

section .text
	global _start
		_start:
			mov eax,4							;Define Directive for Write operation in the 32 bit system
			mov ebx, 1							;Define Directive for Write operation in the 32 bit system
			mov ecx, msg1						;Copy address of msg1 in ecx register
			mov edx, msg1len					;Creates a loop as long as the length of the string to display the string
			int 80H								;System call
			
			mov eax, 12345678h					;Store the hexadecimal number 12345678 in eax register
			mov ecx,08h							;Store the value of counter as 08H

			mov esi,mem							;Store the address of variable mem in esi register
			
			
		back:   rol eax, 04h					;Rotate left eax register by 4 bits
			mov dl,al							;Store value of al into independent register dl
			and dl, 0Fh							;Masking the 3 MSB bits of dl register 

			add dl,30h							;Adding the hexadecimanl value of zero to get the final answer in dl register

			mov [esi],dl						;Storing the value of dl in the memory loaction pointed by esi register
			inc esi								;Incrementing the value of esi register so that it points to the next memory location
			dec ecx								;Decrementing the counter value stored in ecx register

			jnz back							;Jump if ecx is not zero to the label: back

			mov eax,4							;Define Directive for Write operation in the 32 bit system
			mov ebx,1							;Define Directive for Write operation in the 32 bit system
			mov ecx,mem							;Copy address of mem in ecx register		
			mov edx,8							;Creates a loop as long as 8 bytes to display the string
			int 80h								;System call
			
			mov eax,4							;Define Directive for Write operation in the 32 bit system
			mov ebx,1							;Define Directive for Write operation in the 32 bit system
			mov ecx,msg2						;Copy address of msg2 in ecx register	
			mov edx,msg2len						;Creates a loop as long as the length of the string to display the string
			int 80h								;System call

mov eax,1										;Terminate code 
mov ebx,0										;Terminate code 
int 80h											;System call
