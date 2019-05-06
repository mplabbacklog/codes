section .data
menu db 10,"Choices are"									;Assign 1 byte memory for every character in the string 
	 db 10,"1.Enter the string"								;Assign 1 byte memory for every character in the string 
	 db 10,"2.Length of the string"							;Assign 1 byte memory for every character in the string 
	 db 10,"3.Reverse fo the string"						;Assign 1 byte memory for every character in the string 
	 db 10,"4.Pallindrome"									;Assign 1 byte memory for every character in the string 
	 db 10,"5.Check the number of vowel and consonants"		;Assign 1 byte memory for every character in the string 
	 db 10,"6.Exit"											;Assign 1 byte memory for every character in the string 
	 db 10,"Your choice is",10								;Assign 1 byte memory for every character in the string 
menulen: equ $-menu											;Calculating the total memory required for storing the string it in menulen

msg db 10,"Enter the String",10								;Assign 1 byte memory for every character in the string 
msglen: equ $-msg											;Calculating the total memory required for storing the string it in msglen

msg1 db 10,"Length of the string is:"						;Assign 1 byte memory for every character in the string 
msglen1: equ $-msg1											;Calculating the total memory required for storing the string it in msglen1

msg2 db 10,"Reverse of the string is:"						;Assign 1 byte memory for every character in the string 
msglen2: equ $-msg2											;Calculating the total memory required for storing the string it in msglen2

msg3 db 10,"It is a Pallindrome"							;Assign 1 byte memory for every character in the string 
msglen3: equ $-msg3											;Calculating the total memory required for storing the string it in msglen3

msg4 db 10,"It is not a Pallindrome"						;Assign 1 byte memory for every character in the string 
msglen4: equ $-msg4											;Calculating the total memory required for storing the string it in msglen4

msg5 db 10,"Number of vowels are:"							;Assign 1 byte memory for every character in the string 
msglen5: equ $-msg5											;Calculating the total memory required for storing the string it in msglen5

msg6 db 10,"Number of consonants are:"						;Assign 1 byte memory for every character in the string 
msglen6: equ $-msg6 										;Calculating the total memory required for storing the string it in msglen6

msg7 db 10,'',10											;Assign 1 byte memory for every character in the string 
msglen7: equ $-msg7											;Calculating the total memory required for storing the string it in msglen7

section .bss
choice resb 10												;Reserving 10 bytes for variable choice
string resb 10												;Reserving 10 bytes for variable string
reverse resb 10												;Reserving 10 bytes for variable reverse
len_hex resb 10												;Reserving 10 bytes for variable len_hex
len_ascii resb 10											;Reserving 16 bytes for variable len_ascii
vowel_count_ascii resb 16									;Reserving 16 bytes for variable count_ascii
vowel_count_dec resb 16 									;Reserving 16 bytes for variable vowel_count_dec
cons_count_dec resb 16										;Reserving 16 bytes for variable cons_count_dec
cons_count_ascii resb 16									;Reserving 16 bytes for variable cons_count_ascii
	

%macro write 2								;%macro-function that reduces the number of lines write-name of the function
	mov rax,1								;Define Directive for Write operation in the 64 bit system
	mov rdi,1								;Define Directive for Write operation in the 64 bit system
	mov rsi,%1								;%1-function used instead of memory location during call
	mov rdx,%2								;%2-function used instead of memory location during call
	syscall									;System Call
%endmacro									;closing the macro function
	
%macro read 2								;%macro-function that reduces the number of lines read-name of the function
	mov rax,0								;Define Directive for Read operation in the 64 bit system
	mov rdi,0								;Define Directive for Read operation in the 64 bit system
	mov rsi,%1								;%1-function used instead of memory location during call
	mov rdx,%2								;%2-function used instead of memory location during call
	syscall									;System Call
%endmacro									;closing the macro function
	
section .text
	global _start
		_start:

	again: write menu,menulen				;again label is declared and write label of macro is declared
		   read choice,2					;using macro fuction by calling read label declaring choice & 2-memory
			  
		   cmp byte[choice],'1'				;Comparing choice with ascii value of 1 
		   je a								;Jump if equal label a
			  
		   cmp byte[choice],'2'				;Comparing choice with ascii value of 2 
		   je b								;Jump if equal label b
			  
		   cmp byte[choice],'3'				;Comparing choice with ascii value of 3 
		   je c								;Jump if equal label c
			  
		   cmp byte[choice],'4'				;Comparing choice with ascii value of 4 
	       je d								;Jump if equal label d
			  
	       cmp byte[choice],'5'				;Comparing choice with ascii value of 5 
		   je e								;Jump if equal label e

		   cmp byte[choice],'6'				;Comparing choice with ascii value of 6 
		   je exit							;Jump if equal label exit
			  
		a: call enter						;label a is declared and enter label is call
		   jmp again						;Jump to again label
		
		b: call enter						;label b is declared and enter label is call
		   call len							;label len is called
		   write msg7,msglen7				;using macro fuction by calling write label declaring msg7 & msglen7
		   jmp again						;Jump to again label
		   
	    c: call enter						;label c is declared and enter label is call
	       call len							;label len is called
	       call rev							;label rev is called
	       write msg7,msglen7				;using macro fuction by calling write label declaring msg7 & msglen7
	       jmp again						;Jump to again label
	       
	    d: call enter						;label d is declared and enter label is call
	       call len							;label len is called
	       call rev							;label rev is called
	       call pall						;label pall is called
	       write msg7,msglen7				;using macro fuction by calling write label declaring msg7 & msglen7
	       jmp again						;Jump to again label
	       
	 exit: mov rax,60						;Terminate code
	       mov rdi,00						;Terminate code
	       syscall							;System call

	    e: call enter						;label e is declared and enter label is call
	       call len							;label len is called
	       call rev							;label rev is called
	       call vow							;label vow is called
	       write msg7,msglen7				;using macro fuction by calling write label declaring msg7 & msglen7
	       jmp again						;Jump to again label
	    	  
;-------------------------------------------------------------------------
    enter: write msg,msglen					;using macro fuction by calling write label declaring msg & msglen
		   read string,10					;using macro fuction by calling read label declaring string & 10-size
	       dec rax							;Decrementing rax for ENTER keystroke
           mov [len_hex],rax				;moving contents of rax in [len_hex]
		   add rax,30h						;add value of rax with 30
		   mov[len_ascii],rax				;move the ascci value in [len_ascii]
		   ret								;Return to original position from where it was called
				
	  len: write msg1,msglen1				;using macro fuction by calling write label declaring msg1 & msglen1
		   write len_ascii,10				;using macro fuction by calling write label declaring len_ascii & 10-size
		   ret								;Return to original position from where it was called
;--------------------------------------------------------------------------			 
	  rev: mov rcx,00						;Move rcx register 00
		   mov rdi,reverse					;move contents of reverse in rdi register
		   mov rsi,string					;move contents of string in rsi register
	       mov cl,[len_hex]					;Move value of len_hex in cl
		   dec cl							;Decrement cl register
		   add rsi,rcx						;Add both the register
		   inc cl							;Increment cl register to come on original position
			 
	   up: mov al,[rsi]						;Move contents of rsi in al register
    	   mov [rdi],al						;Move contents of al in rdi register
    	   dec rsi							;Decrement rsi register to move character in other register
    	   inc rdi							;Increment rdi register to save reverse charcter
    	   loop up							;Continue the loop until all the character doesnot get reverse
    	   write msg2,msglen2				;using macro fuction by calling write label declaring msg2 & msglen2
    	   write reverse,10					;using macro fuction by calling write label declaring reverse & 10-memory
    	   ret								;Return to original position from where it was called
;---------------------------------------------------------------------------
	 pall: mov rcx,0						;Move 0 value to rcx register
           mov cl,[len_hex]					;Stored len_hex value in cl register
    	   mov rsi,string					;Stored string in rsi register
           mov rdi,reverse					;Move reverse in rdi register

      up1: mov al,[rsi]						;Move contents of rsi in al register
           cmp byte al,[rdi]				;Compare byte of al register with rdi
           jne dup							;Jump not equal to dup label
           inc rsi							;Increment rsi to compare string
           inc rdi							;Increment rdi register
           loop up1							;Continue to loop up1 til the all characters are compared
           write msg3,msglen3				;using macro fuction by calling write label declaring msg3 & msglen3
           jmp down							;Jump down label
                
      dup: write msg4,msglen4				;using macro fuction by calling write label declaring msg4 & msglen4

     down:ret								;Return to original position from where it was called
;------------------------------------------------------------------------------
	  vow: mov rdi, 0h						;Move 0 to rdi register to make independent register
	       mov [vowel_count_dec], rdi		
	       mov rsi, string					;Move the string in rsi register
	       mov rcx, [len_hex]				;Move the len_hex in rcx register
	       mov rax, 0h						;Make rax independent register
	       mov rbx, 0h						;Make rbx independent register

vowel_check: cmp byte[rsi], 'a'				;Comparing [rsi] with charachter a 
			 je vowel_found					;Jump if equal to label vowel found
			 cmp byte[rsi], 'e'				;Comparing [rsi] with charachter e
			 je vowel_found					;Jump if equal to label vowel found
			 cmp byte[rsi], 'i'				;Comparing [rsi] with charachter i
			 je vowel_found					;Jump if equal to label vowel found
			 cmp byte[rsi], 'o'				;Comparing [rsi] with charachter o
			 je vowel_found					;Jump if equal to label vowel found
			 cmp byte[rsi], 'u'				;Comparing [rsi] with charachter u
			 je vowel_found
			 
			 cmp byte[rsi], 'a'				;Comparing [rsi] with charachter a
			 jb next_char					;Jump to label next_char
			 cmp byte[rsi], 'z'				;Comparing [rsi] with charachter z
			 jg next_char					;Jump if greater to label next_char
			 inc rbx						;Increment rbx
			 jmp next_char					;Jump to label next_char
					
vowel_found: inc rax						;Incrementing the rax register if get the vowel in it

  next_char: inc rsi						;Increnting rsi register for the numbber of consonants present
		     loop vowel_check				;Complete the loop until all the characters are not checked in vowel_check label
		
		      mov [cons_count_dec], rbx		;Moving rbx register value [cons_count_dec]
		 	  mov [vowel_count_dec], rax	;Moving rax register value [vowel_count_dec]
		
	          mov rax, [vowel_count_dec]	;Moving [vowel_count_dec] in rax register
		      mov rsi, vowel_count_ascii	;Again storing vowel_count_ascii in rsi register
		      call dec_ascii				;Caliing dec_ascii label
		
	          mov rax, [cons_count_dec]		
		  	  mov rsi, cons_count_ascii
		      call dec_ascii				;Calling dec_ascii label	
		
		      write msg5, msglen5			;using macro fuction by calling write label declaring msg5 & msglen5			
		      write vowel_count_ascii, 16	;using macro fuction by calling write label declaring msg4 & 16-memory
   	          write msg6, msglen6			;using macro fuction by calling write label declaring msg6 & msglen6
		      write cons_count_ascii, 16	;using macro fuction by calling write label declaring cons_count_ascii & 16-memory
		
   dec_ascii: mov ch, 16					;Storing 16 in ch register
		      mov cl, 04h					;Moving 4 in cl register
				   
	     up2: rol rax, cl					;Rotating rax register by 4
	          mov bl, al					;Moving al in bl register
		      and bl, 0fh					;Non masking bl register with 0fh
			  cmp bl, 09h					;Comparing contents of bl with 09h
		      jng add30						;If jump not greater than 09 add 30
		      add bl, 07h					;Add bl register with 07
	
	  add30: add bl, 30h					;Adding bl register with 30h
		     mov [rsi], bl					;Moving the bl register in rsi register
		     inc rsi						;Incrementing rsi register
		     dec ch							;Decrementing ch register
		     jnz up2						;If it is not zero than jump to up2 label
	         ret							;Return to original position from where it was calleds
