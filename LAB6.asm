; David J Esperanza djespera@ucsc.edu 1367973
; Lab 6: Decimal to Binary, and Hex Converter
;
; Program Name: Decimal Converter
;
; Description:


	.ORIG	x3000
	LEA	  R0,MES	        ;Load Message
	PUTS		              ;Print out data in R0	
FINAL	  LEA	R0,MES1
	LD  	R4,TER1          ;This will be used to loop for enter key
	LD	  R3,TER2	         ;This will be used to loop for '-'
	LD	  R5, INT          ;Load Int = 0
	LD	  R6, FLAG         ;Load Flag = 0
	PUTS
	LOOP	GETC		         ;Input Character
	OUT
	LD	  R4,TER1
	ADD	  R2,R4,R0          ;We will test the user input to check if they hit ENTER
	BRz	  ENTER	            ;If they Did hit enter we will branch to check their flag
	LD	  R4,TER3
	ADD   R2,R4,R0          ;We will test the user input to check if they hit X
	BRz   EXIT	              ;IF the user hit x to quit
	BRp	  ASCII	            ;Branch if character holds ASCII value of Positive

                          ; We will check now if the user hit '-' or entered a number
ASCII	  ADD	R2, R3,R0     ;If the user does type the character '-' we will add 1 to Flag
	BRz	  NEGA	            ; Branch to Set Flag to 1
	LD	  R4,TER4
	ADD   R0,R4,R0          ;We calculate the actually value of the ASCII to Decimal
	LD	  R1,COUNT          ; Load the Value of 10 to perform multiplication, We will add value 10 times
	AND	  R3,R3,0
	ADD	  R3,R3,R5
DECR    ADD	R5,R5,R3      ; ADD the int to itself to perform multiplication we do this for ten times
	ADD	  R1,R1,-1          ; Decrement the counter
	BRp	  DECR	
	ADD	  R5,R0,R5          ; Int = (int * 10) + digit
	BR	  LOOP	            ; We loop back to GETC to take more input
	

NEGA	  ADD	R6, R6,1        ; We add the value of 1 to R6 to indicate Flag =1 Negative Number
	BR	  LOOP	              ; We loop back to GETC to take more input
	

ENTER	  LD	R4,TER5         ; We Check the flag to see if they typed in a negative number
	ADD	  R4,R6,R4            ; We use ther terminator value of -1 and add it 1 to see if they did
	BRz	  INVERT              ; if they did we branch to 2's compliment to invert and add one

NEXT	  AND	R4,R4,0	          ; Either Positive or negative value we will end up here.
	LEA	  R2,MASK	              ; Load the Address of Mask into R2
	ADD	  R1,R1,15              ; Load the count to 15   
CHECK	
	BRn	  FINAL	                ; Is the count <0?
	LDR	  R4,R2,0                 ; Load the Actual value of the Mask
	AND	  R0,R5,R4                ; Perform BitWise AND
	BRnp	UNO	   
	LD	  R0,ZERO
	OUT		                      ;Prints out a 0
	ADD	  R2,R2,1	              ; Increment PTR
	ADD	  R1,R1,-1               ;Decremnt the counter
	
	BR	  CHECK	                  ;Loop to check the counter

UNO	LD	R0,ONE
	OUT		                        ;Prints out a 1
	ADD	R2,R2,1	                  ;Increment MASK Pointer
	ADD	R1,R1,-1                  ;Decrement the counter
	BR	CHECK




INVERT  NOT	R5,R5               ; We invert the value in R5 to complete 1'sc
	ADD   R5,R5,1                ; We add one to complete 2'sc
	BR	  NEXT                        ; Branch to the final stages 



		
EXIT	LEA R0,MES4                   ; Load Good Bye Message
	PUTS                                ; Print to Console
	HALT	                            	; Halt the Program
	

	
	

INT	.FILL	 x0000
FLAG	.FILL	 x0000
TER1	.FILL	 xFFF6 ; -10 negative ASCII for ENTER key 'LF'
TER2	.FILL	 xFFD3 ; -45 negative ASCII for '-'
TER3    .FILL	 xFF88 ; -120 negative ASCII or 'x'
TER4	.FILL	 xFFD0 ; -48 
TER5	.FILL	 xFFFF ; -1
ZERO	.FILL	 x0030 ; 0
ONE	.FILL	 x0031 ; 1
COUNT	.FILL	 x0009 ; 9; Used for Multiplication
NC	.FILL	 x00
MES	.STRINGZ "Welcome to Davids' Conversion Proggie!\n"
MES1	.STRINGZ "\nEnter a Decimal value or hit X to quit:\n>"
MES2	.STRINGZ "\nDEBUG: THE USER HIT ENTER\n" 
MES3	.STRINGZ "\nDEBUG: CHECK CHAR '-' or DEC'0-9'\n"
MES4    .STRINGZ "\nTHANK YOU GOODBYE\n"
MES5	.STRINGZ "\n Thank You, here is the Decimal in Binary\n"
PTR .FILL	 MASK
MASK	.FILL	 x8000
	.FILL	 x4000
	.FILL	 x2000
	.FILL	 x1000
	.FILL	 x0800
	.FILL	 x0400
	.FILL	 x0200
	.FILL	 x0100
	.FILL	 x0080
	.FILL	 x0040
	.FILL	 x0020
	.FILL	 x0010
	.FILL	 x0008
	.FILL	 x0004
	.FILL	 x0002
	.FILL	 x0001
	.END
