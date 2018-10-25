;OBJECTIVE:- TO ADD THE ELEMENTS OF A DOUBLE WORD ARRAY WORD BY WORD
;APPROACH: ADDING WORD BY WORD THE ELEMENTS USING AX AND DX REGISTER USING A LOOP TO GET FOR ALL THE ELEMENTS 

DATA SEGMENT                                                      ;START OF DATA SEGMENT
    ARRAY DD 00110010H,00020000H,00030003H,00400004H,00050001H    ;INITIALIZING THE DOUBLE WORD ARRAY WITH HARD CODED VALUES
    SUM DD ?                                                      ;INITIALIZING THE SUM VARIABLE FOR STORING RESULT
DATA ENDS                                                         ;DATA SEGMENT ENDS HERE
CODE SEGMENT                                                      ;START OF CODE SEGMENT
    ASSUME DS: DATA, CS: CODE                                     ;ASSOCIATING THE SEGMENT REGISTERS WITH THEIR CORRESPONDING SEGMENTS
    START:                                                        ;STARTING OF THE EXECUTION OF CODE SEGMENT
        MOV AX, DATA                                              ;TRANSFERING THE OFFSET ADDRESS OF DATA SEGMENT TO AX 
        MOV DS, AX                                                ;TRANSFERING THE AX VALUE TO DS REGISTER IN TOTAL WE TRANSFERED THE VALUE OF DATA TO DS
        MOV AX,0000H                                              ;INITIALIZING THE AX WITH 0H VALUE
        MOV DX,0000H                                              ;INITIALIZING DX WITH 0H VALUE
        MOV BX,ARRAY                                              ;STORING THE OFFSET OF ARRAY IN BX REGISTER
        MOV SI,0                                                  ;INITIALIZING THE VALUE OF SI WITH 0
        MOV CX,5                                                  ;INITIALIZING THE VALUE OF CX WITH 5 BECAUSE 5 DOUBLE WORDS (ELEMENTS) IN ARRAY SO 5 TIMES LOOP WILL RUN
        
    SUMS:                                                         ;LOOP LABEL IS DEFINED AS SUMS
        ADD AX, BX[SI]                                            ;ADDING THE 1ST WORD VALUE OF ELEMENT IN ARRAY IN AX                                           ;ADDING THE 2ND BYTE VALUE OF ELEMENT IN ARRAY IN AH
        ADC DX, BX[SI+2]                                          ;ADDING THE 2ND WORD VALUE OF ELEMENT IN ARRAY IN DX      
        ADD SI,4                                                  ;INCREMENTING THE SI BY 4 BECAUSE OF DOUBLE WORD
        LOOP SUMS                                                 ;REPEAT SUMS IF CX IS NOT EQUAL TO ZERO ELSE IT WILL MOVE OUT OF THE LOOP
        MOV SUM, AX                                               ;STORING THE 1ST WORD OF RESULT IN SUM FROM AX
        MOV SUM+2, DX                                             ;STORING THE 2ND WORD OF RESULT IN SUM FROM DX     
CODE ENDS                                                         ;CODE SEGMENT ENDS HERE
END START                                                         ;PROGRAM ENDS 