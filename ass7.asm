section .data
msg db "Enter How many numbers you want to enter",10   ;Assign 1 byte memory for every character in the string 
msglen: equ $-msg                                      ;Calculating the total memory required for storing the string it in msglen

msg1 db "Enter the 64 bit number",10                   ;Assign 1 byte memory for every character in the string
msglen1: equ $-msg1                                    ;Calculating the total memory required for storing the string it in msglen1

msg2 db '',10										   ;Assign 1 byte memory for every character in the string
msglen2: equ $-msg2 								   ;Calculating the total memory required for storing the string it in msglen2

section .bss
var1 resb 2                                            ;Reserving 2 bytes for variable var1
var2 resb 17                                           ;Reserving 17 bytes for variable var2 
var3 resq 1                                            ;Reserving 1 quad for variable var3  resq-reserve quad i.e 8 bytes
mem resb 1                                             ;Reserving 1 bytes for variable mem  

section .text 
	global _start
		_start:
			mov rax,1                                  ;Define Directive for Write operation in the 64 bit system
			mov rdi,1                                  ;Define Directive for Write operation in the 64 bit system
			mov rsi,msg                                ;Copy address of msg1 in rsi register
			mov rdx,msglen                             ;Creates a loop as long as the length of the string to display the string
			syscall                                    ;System call

			mov rax, 00h                               ;Define Directive for Read operation in the 64 bit system
			mov rdi, 00h                               ;Define Directive for Read operation in the 64 bit system
			mov rsi, var1                              ;Stores the address of the  value read from var1 in rsi register
			mov rdx, 2                                 ;Maximum size
			syscall                                    ;System call

			cmp byte[var1],39h						;Comparing byte of var1 with 39h to know the hexadecimal value
			jng z									;if it is not greater than 39h it will jump to z label
			sub byte[var1],07h						;substracting 07 from var1
		 z:											;label declared z
			sub byte[var1],30h						;substracting 30h from var1
			
		up:											;label declared up
			mov rax,01h								;Define Directive for Write operation in the 64 bit system
			mov rdi,01h								;Define Directive for Write operation in the 64 bit system
			mov rsi,msg1							;Copy address of msg1 in rsi register
			mov rdx,msglen1							;Creates a loop as long as the length of the string to display the string
			syscall									;System call

			mov rax,00h								;Define Directive for Read operation in the 64 bit system
			mov rdi,00h								;Define Directive for Write operation in the 64 bit system
			mov rsi,var2							;Stores the address of the value read from var2 in rsi register
			mov rdx,17								;Maximum size of 100 keystrokes
			syscall									;System call

			dec al									;Decrementing al register by 1 to delete the ENTER keystroke
			mov rsi,var2							;Moving var2 in rsi register
			mov ch,al								;Using independent counter register
			mov cl,04								;Storing 4 in cl register for shifting 

			xor rbx,rbx

		y:											;label declared y
			shl rbx,cl							    ;Shifting left contents of rbx register by 4 
			mov al,[rsi]							;Moving contents of rsi register in al register i.e var2
			
			cmp al,39h								;Comparing contents of al register with 39h for hexa value
			jng x									;If it is not greater than 39 jump to x label
			sub al,07h								;Substract 07 from hexa value of al register
			 
		x:											;label declared x
			sub al,30h								;substracting 30h from hexa value al register
			
			add bl,al								;Add al value with bl register
			inc rsi									;Increment rsi register
			dec ch									;Decrement ch register
			jnz y									;If it is not zero jump to y label

			;mov rbx,[var3]
			add [var3],rbx							;add contents of var3 with rbx
			dec byte[var1]							;Decrement 1 byte of var1
			jnz up									;If it is not zero jump to up label

			xor rbx,rbx
			mov rbx,[var3]							;Storing the contents in rbx register
			mov rsi,var2							;moving var2 in rsi register
			mov ch,16								;Storing 16 in ch register
			mov cl,04h								;Storing 4 in cl register for shifting 

		up1:										;Label declared up1
			rol rbx,cl								;Rotate left contents of rbx by 4
			mov al,bl								;Move bl in al register
			and al,0fh								;non masking between contents of al with 0fh
			cmp al,09h								;Comparing value of al register with 09h
			jng sk									;Jump to sk label if not greater than 09h
			add al,07h								;Add al register value with 07h

		sk:											;sk label declared
			add al,30h								;add value in al register with 30
			mov [rsi],al							;Move contents of al in rsi register
			inc rsi									;Increment rsi register
			dec ch									;Decrement ch register
			jnz up1									;Jump if not equal to zero to up1

			mov rax,01h								;Define Directive for Write operation in the 64 bit system
			mov rdi,01h								;Define Directive for Write operation in the 64 bit system
			mov rsi,var2							;Copy address of msg2 in rsi register
			mov rdx,16								;Maximum size
			syscall									;System call
			
			mov rax,01								;Define Directive for Write operation in the 64 bit system
			mov rdi,01								;Define Directive for Write operation in the 64 bit system
			mov rsi,msg2							;Copy address of msg2 in rsi register
			mov rdx,msglen2							;Creates a loop as long as the length of the string to display the string
			syscall									;System call

mov rax,60											;Terminate code
mov rdi,00											;Terminate code
syscall												;System call

			
