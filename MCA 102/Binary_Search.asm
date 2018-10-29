;OBJECTIVE:- TO IMPLEMENT BINARY SEARCH
;APPROACH: COMPARING THE MIDDLE ELEMENT OF THE ARRAY
          ;IF IT IS EQUAL TO ELEMENT TO BE SEARCHED THEN ELEMENT FOUND
          ;ELSE IF IT IS GREATER THAN ELEMENT TO BE SEARCHED THEN WE RECURSE TO THE LEFT SIDE PORTION OF THE MIDDLE ELEMENT OF THE ARRAY
          ;IF IT IS SMALLER THAN THE ELEMENT TO BE SEARCHED THEN WE RECURSE TO THE RIGHT SIDE OF THE MIDDLE ELEMENT
          ;IF THE STARTING IS GREATER THAN LAST INDEX OF THE ARRAY THEN WE PRINT ELEMENT NOT FOUND
          
      
DATA SEGMENT                                                      ;DATA SEGMENT STARTS
ARR DB 100 DUP(?)                                                 ;ARRAY OF SIZE 100 IS DECLARED
MES1 DB 13,10,"ENTER THE NO OF ELEMENTS(00H-64H) : $"             ;MESSAGE DISPLAYED TO USER ABOUT ENTERING NUMBER OF ELEMENTS IN AN ARRAY
MES2 DB 13,10,"ENTER THE ELEMENTS IN ASCENDING ORDER : $"         ;MESSAGE DISPLAYED TO USER ABOUT ENTERING THE ELEMENTS IN AN ARRAY
MES3 DB 13,10,"ENTER ELEMENT YOU WANT TO SEARCH : $"              ;ELEMENT TO BE SEARCHED MESSAGE
MES4 DB 13,10,"ELEMENT FOUND $"                                   ;ELEMENT FOUND MESSAGE
MES5 DB 13,10,"ELEMENT NOT FOUND $"                               ;ELEMENT NOT FOUND MESSAGE
NO DW ?                                                           ;A VARIABLE TO GET THE NUMBER OF ELEMENTS IN AN ARRAY
DATA ENDS                                                         ;DATA SEGMENT ENDS HERE
CODE SEGMENT                                                      ;CODE SEGMENT STARTS HERE
    ASSUME: DS:DATA, CS: CODE                                     ;ASSIGNING ADDRESSES
    START: MOV AX, DATA                                           ;MOVING DATA SEGMENT ADDRESS TO DS
    MOV DS,AX

                                                                  ;TAKING INPUT OF NUMBER OF ELEMENTS IN AN ARRAY
NA:
	LEA DX,MES1  ;LOAD EFFECTIVE ADDRESS OF MES
	MOV AH,9                                                      ;CALLING INTERRUPT FOR INPUT
	INT 21H
                                                                  ;CX=2 FOR 2 DIGIT NUMBER
	MOV CX,2
	MOV BX,0
	INPN:
    		SHL BL,4
    		MOV AH,01
    		INT 21H
    		CMP AL,39H                                            ;REDUCING THAT ASCII VALUE OF NUMBER TO DIGIT
    		JBE H
        	SUB AL,7H
        	H: SUB AL,30H
    		ADD BL,AL
  		LOOP INPN

	CMP BX,100                                                    ;COMPARING WHETHER USER ENTERED THE NUMBER LESS THAN 100 IN DECIMAL OR NOT I.E. LESS THAN 64 IN HEXADECIMAL
	JA NA

	LEA DX,MES2  ;LOAD EFFECTIVE ADDRESS OF MES                   ;DISPLAYING MESSAGE TO USER TO ENTER THE ELEMENTS OF THE ARRAY
	MOV AH,9
	INT 21H

	MOV NO,BX                                                     ;MOVING THE NUMBER OF ELEMENTS VALUE TO NO VAR

	LEA BX,ARR                                                    ;TAKING INPUT OF THE NUMBER OF ELEMENTS 
	MOV CX,NO                                                     ;INITIALIZING COUNTER WITH NUMBER OF ELEMENTS
	MOV DI,0
	;INPUT OF ARRAY
	INP:
	        MOV DL,0
    		MOV AH,01
    		INT 21H
    		CMP AL,39H
    		JBE L
    		SUB AL,7H
    		L: SUB AL,30H
    		ADD DL,AL
    		SHL DL,4
    		MOV AH,01
    		INT 21H
    		CMP AL,39H
    		JBE L2
    	        SUB AL,7H
       		L2: SUB AL,30H
    		ADD DL,AL
    		MOV [BX+DI],DL                                        ;STORING THE ELEMENT INPUT AT THE INDEX OF THE ARRAY
    		INC DI
    		MOV DL," "					      ;DISPLAYING USER THE SPACE 
    		MOV AH,02
    		INT 21H
    		LOOP INP

	LEA DX,MES3  ;LOAD EFFECTIVE ADDRESS OF MES                   ;DISPLAYING MESSAGE TO USER TO INPUT THE ELEMENT TO BE SEARCHED
	MOV AH,9
	INT 21H

	MOV DL,0                                                      ;TAKING INPUT OF ELEMENT TO BE SEARCHED
	MOV CX,2
	INPS:
    		SHL DL,4
    		MOV AH,01
    		INT 21H
    		CMP AL,39H
    		JBE I
        	SUB AL,7H
        	I: SUB AL,30H
    		ADD DL,AL
    		LOOP INPS
	DEC NO
	MOV SP,NO
	MOV BP,0
	LEA BX,ARR
	MOV DI,SP
	MOV CL,DL
	BINSEARCH:
	    SHR DI,1
	    CMP BP,SP
	    JA NF
	    CMP CL,[BX+DI]                                           ;COMPARING ELEMENT TO BE SEARCHED WITH THE ELEMENT AT AN INDEX OF ARRAY
	    JE E                                                     ;IF THE ELEMENT IS EQUAL THEN JUMP TO LABEL E AND DISPLAY FOUND
	    JA ABOVE                                                 ;IF THE ELEMENT IS GREATER THEN JUMP TO ABOVE LABEL AND PERFORM FURTHER OPERATION
	    JB BELOW                                                 ;IF THE ELEMENT IS SMALLER THEN JUMP TO BELOW LABEL AND PERFORM FURTHER OPERATION
	    ABOVE:                                                   ;FOR CHANGING THE START INDEX AND LAST INDEX OF ARRAY
        	INC DI
        	MOV BP,DI
        	ADD DI,SP
        	JMP BINSEARCH
    	BELOW:                                                   ;FOR CHANGING THE START INDEX AND LAST INDEX OF ARRAY
        	DEC DI
        	MOV SP,DI
       	 	ADD DI,BP
        	JMP BINSEARCH
    	E:                                                       ;FOR DISPLAYING MESSAGE TO USER ABOUT THE ELEMENT FOUND
        	LEA DX,MES4  ;LOAD EFFECTIVE ADDRESS OF MES
        	MOV AH,9
        	INT 21H
        	HLT 
	    NF:                                                      ;FOR DISPLAYING MESSAGE TO USER ABOUT THE ELEMENT NOT FOUND
    		LEA DX,MES5  ;LOAD EFFECTIVE ADDRESS OF MES
    		MOV AH,9
    		INT 21H
		    HLT
CODE ENDS                                                        ;CODE SEGMENT ENDS HERE
END START                                                        ;PROGRAM ENDS HERE