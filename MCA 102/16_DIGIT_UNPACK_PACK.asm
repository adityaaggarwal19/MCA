;OBJECTIVE:- TO CONVERT 16 DIGITS UNPACKED BCD INTO PACKED BCD 
;APPROACH: USING SHIFT LEFT AND RIGHT INSTRUCTIONS FOR CONVERTING INTO PACKED BCD 
DATA SEGMENT                                                        ;DATA SEGMENT STARTS
    UNPACK DB 1H,2H,3H,4H,5H,6H,7H,8H,8H,7H,6H,5H,4H,3H,2H,1H       ;INITIALIZING THE BYTE ARRAY WITH HARD CODED VALUES I.E. 16 DIGITS
    PACK DB 8 DUP(?)                                                ;RESERVING 8 BYTE SPACE FOR PACKED NUMBER
DATA ENDS                                                           ;DATA SEGMENT ENDS HERE
CODE SEGMENT                                                        ;CODE SEGMENT STARTS
    ASSUME DS:DATA, CS: CODE                                        ;ASSOCIATING THE SEGMENT REGISTERS WITH THEIR CORRESPONDING SEGMENTS
    START:                                                          ;STARTING OF THE EXECUTION OF CODE SEGMENT
        MOV AX,DATA                                                 ;TRANSFERING THE OFFSET ADDRESS OF DATA SEGMENT TO AX 
        MOV DS,AX                                                   ;TRANSFERING THE AX VALUE TO DS REGISTER IN TOTAL WE TRANSFERED THE VALUE OF DATA TO DS
        MOV DX,8                                                    ;INITIALIZING DX WITH COUNT 8
        MOV SI,0                                                    ;INITIALIZING SI WITH 0
        MOV CL,4                                                    ;INITIALZING CL WITH VALUE 4
        MOV DI,0                                                    ;INITIALIZING DI WITH VALUE 0
        LEA BX,UNPACK                                               ;STORING OFFSET OF UNPACK ARRAY INTO BX
                                                                    ;DOING UNPACK TO PACK WORD BY WORD SO MOVING A WORD INTO AX
    CONV:                                                           ;LOOP LABEL IS DEFINED AS CONV
        MOV AX,WORD PTR BX[SI]                                      ;STORING THE ELEMENT OF UNPACK INTO AX
        SHL AL,CL                                                   ;SHIFTING LEFT AL WITH 4 BITS
        SHR AX,CL                                                   ;SHIFTING RIGHT AX WITH 4 BITS
        MOV PACK[DI], AL                                            ;STORING THE RESULT OF PACK INTO PACK ARRAY
        ADD SI,2                                                    ;ADDING 2 TO SI
        INC DI                                                      ;INCREMENTING DI BY 1
        DEC DX
		JNE CONV                                                   ;REPEAT CONV IF CX IS NOT EQUAL TO ZERO ELSE IT WILL MOVE OUT OF THE LOOP
CODE ENDS                                                           ;CODE SEGMENT ENDS HERE
END START                                                           ;PROGRAM ENDS 