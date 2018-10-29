;OBJECTIVE:- USING LINEAR SEARCH FIND WHETHER A GIVEN NUMBER IS THERE IN THE SET OF ELEMENTS OR NOT
;APPROACH: COMPARE THE NUMBER TO BE SEARCHED WITH EVERY ELEMENT OF ARRAY IF NUMBER MATCHED THEN NUMBER FOUND ELSE NUMBER NOT FOUND 

DATA SEGMENT                                                     ;START OF DATA SEGMENT
	ARR DB 100 DUP(?)                                                ;INITIALIZING AN ARRAY OF SIZE 100
	MES1 DB 13,10,"ENTER THE NO OF ELEMENTS(00H-64H) : $"            ;STORING THE MESSAGE WHICH WOULD BE DISPLAYED TO USER TO ENTER NUMBER OF ELEMENTS
	MES2 DB 13,10,"ENTER THE ELEMENTS IN ASCENDING ORDER : $"        ;STORING THE MESSAGE WHICH WOULD BE DISPLAYED TO USER TO ENTER ELEMENTS
	MES3 DB 13,10,"ENTER ELEMENT YOU WANT TO SEARCH : $"             ;STORING THE MESSAGE WHICH WOULD BE DISPLAYED TO USER TO ENTER ELEMENT TO BE SEARCHED
	MES4 DB 13,10,"ELEMENT FOUND $"                                  ;STORING THE MESSAGE WHICH WOULD BE DISPLAYED TO USER ABOUT ELEMENT FOUND
	MES5 DB 13,10,"ELEMENT NOT FOUND $"                              ;STORING THE MESSAGE WHICH WOULD BE DISPLAYED TO USER ABOUT ELEMENT NOT FOUND
	NO DW ?                                                          ;A VARIABLE TO STORE THE ELEMENT TO BE SEARCHED
DATA ENDS                                                        ;DATA SEGMENT ENDS HERE
CODE SEGMENT                                ;START OF CODE SEGMENT
    ASSUME DS: DATA, CS: CODE               ;ASSOCIATING THE SEGMENT REGISTERS WITH THEIR CORRESPONDING SEGMENTS
    START:                                  ;STARTING OF THE EXECUTION OF CODE SEGMENT
        MOV AX,DATA                         ;TRANSFERING THE OFFSET ADDRESS OF DATA SEGMENT TO AX 
        MOV DS,AX                           ;TRANSFERING THE AX VALUE TO DS REGISTER IN TOTAL WE TRANSFERED THE VALUE OF DATA TO DS
    ;INPUT OF NO OF ELEMENTS IN AN ARRAY    
    NA:                                     ;TAKING INPUT OF NUMBER OF ELEMENTS IN AN ARRAY
        LEA DX,MES1  ;LOAD EFFECTIVE ADDRESS OF MES
        MOV AH,9
        INT 21H

    	MOV CX,2
    	MOV BX,0
    	INPN:
    	    SHL BL,4
    	    MOV AH,01
	        INT 21H
	        CMP AL,39H
	        JBE H
	            SUB AL,7H
	        H: SUB AL,30H
	        ADD BL,AL
	        LOOP INPN

	CMP BX,100
	JA NA
    ;INPUT OF ELEMENTS IN AN ARRAY
    LEA DX,MES2  ;LOAD EFFECTIVE ADDRESS OF MES2
    MOV AH,9
    INT 21H

    MOV NO,BX                                ;MOVING NUMBER OF ELEMENTS IN AN ARRAY TO VARIABLE NO

    LEA BX,ARR                               ;LOADING THE OFFSET OF ARR IN BX
    MOV CX,NO                                ;TAKING INPUT OF ELEMENTS OF ARRAY
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
            MOV [BX+DI],DL
    	    INC DI
            MOV DL," "
    	    MOV AH,02
    	    INT 21H
    	    LOOP INP
	; INPUT OF ELEMENT TO BE SEARCHED
	LEA DX,MES3  ;LOAD EFFECTIVE ADDRESS OF MES            ;DISPLAYING USER TO ENTER THE ELEMENT TO BE SEARCHED
	MOV AH,9
	INT 21H
                                                           ;TAKING INPUT OF THE ELEMENT TO BE SEARCHED
	MOV DL,0
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
	
	MOV CX,NO                                ;INITIALIZING CX WITH VALUE 4
        MOV SI,0                             ;INITIALIZING SI WITH VALUE 0
        
    	SEARCH:                                  ;LOOP LABEL IS DEFINED AS SEARCH
       		MOV AL, ARR[SI]                      ;MOVING THE ELEMENT OF THE ARRAY INTO AL
        	CMP AL, DL                           ;COMPARING THE NUMBER TO BE SEARCHED WITH THE ELEMENT OF ARRAY
        	JE FOUND                             ;IF NUMBER FOUND THEN THE RESULT WILL BE ZERO SO IT WILL JUMP TO FOUND
        	INC SI                               ;ELSE CONTINUE HERE AND INCREMENT SI 
        	LOOP SEARCH                          ;REPEAT SEARCH IF CX IS NOT EQUAL TO ZERO ELSE IT WILL MOVE OUT OF THE LOOP
        	
        	LEA DX,MES5                          ;LOAD EFFECTIVE ADDRESS OF MES5
		MOV AH,9
		INT 21H
		HLT                                      ;CALLING INTERRUPT TO TERMINATE
    
 	FOUND:                                       ;LOOP LABEL IS DEFINED AS FOUND
        	LEA DX,MES4                          ;LOAD EFFECTIVE ADDRESS OF MES4
        	MOV AH,9
        	INT 21H                              
		HLT                                      ;CALLING INTERRUPT TO TERMINATE
CODE ENDS                                    ;CODE SEGMENT ENDS HERE
END START                                    ;PROGRAM ENDS HERE