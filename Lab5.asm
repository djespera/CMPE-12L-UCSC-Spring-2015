; David J Esperanza djespera@ucsc.edu 1367973
; TA-Steven
; LAB5: Intro into LC-3 Programming Enviroment
; Program Name:
;	Hello World Program in Assembly
;
; Description:
;  	Classic Hello World Program	
; 	Implements Loop To Print out 5 Times
;	Halts at the End to stop program.
;
; Options:
;	No Options Requried
; 
; Operand:
;	No Operands Requried
;
;


       .ORIG	x3000 	                   ;this sets where the following code will start in memory
	AND	R1,R0, 0
       LD	R1, COUNT
LOOP
       LEA	R0,HELLO	      ; LOAD
       PUTS			
	ADD     R1, R1, -1            ; Register Contains Counter value of x0005 Decrements Each Time it Loops
       BRp      LOOP 
       Trap	x25                   ;This halts the program
	
COUNT    .FILL	x0005                 ; Initialize Variable Counter with the value of x0005
HELLO .STRINGZ "HELLO WORLD MY NAME IS DAVID! \n"	
      .END
