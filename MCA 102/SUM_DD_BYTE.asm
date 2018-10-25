;OBJECTIVE:- TO ADD THE ELEMENTS OF A DOUBLE WORD ARRAY BYTE BY BYTE
;APPROACH: ADDING BYTE BY BYTE THE ELEMENTS USING AX AND DX REGISTER USING A LOOP TO GET FOR ALL THE ELEMENTS 

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
        ADD AL, BX[SI]                                            ;ADDING THE 1ST BYTE VALUE OF ELEMENT IN ARRAY IN AL 
        ADC AH, BX[SI+1]                                          ;ADDING THE 2ND BYTE VALUE OF ELEMENT IN ARRAY IN AH
        ADC DL, BX[SI+2]                                          ;ADDING THE 3RD BYTE VALUE OF ELEMENT IN ARRAY IN DL
        ADC DH, BX[SI+3]                                          ;ADDING THE 4TH BYTE VALUE OF ELEMENT IN ARRAY IN DH        
        ADD SI,4                                                  ;INCREMENTING THE SI BY 4 BECAUSE OF DOUBLE WORD
        LOOP SUMS                                                 ;REPEAT SUMS IF CX IS NOT EQUAL TO ZERO ELSE IT WILL MOVE OUT OF THE LOOP
        MOV SUM, AL                                               ;STORING THE 1ST BYTE OF RESULT IN SUM FROM AL
        MOV SUM+1, AH                                             ;STORING THE 2ND BYTE OF RESULT IN SUM FROM AH
        MOV SUM+2, DL                                             ;STORING THE 3RD BYTE OF RESULT IN SUM FROM DL
        MOV SUM+3, DH                                             ;STORING THE 4TH BYTE OF RESULT IN SUM FROM DH
CODE ENDS                                                         ;CODE SEGMENT ENDS HERE
END START                                                         ;PROGRAM ENDS 