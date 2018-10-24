;OBJECTIVE:- TO CONVERT A 16 DIGIT PACKED BCD INTO 16 DIGIT UNPACKED BCD  AND ITS ASCII VALUE
;APPROACH: USING SHIFT INSTRUCTIONS FOR CONVERTING INTO UNPACKED AND THEN BY ADD INSTRUCTION ADDING 30H TO CONVERT INTO ASCII VALUE 

DATA SEGMENT                                           ;START OF DATA SEGMENT
    PACK   DB 03H,19H,25H,18H,97H,11H,05H,09H          ;INITIALIZING THE BYTE ARRAY WITH HARD CODED VALUES I.E. 16 DIGITS
    UNPACK DB 32 DUP(?)                                ;RESERVING 32 BYTES SPACE FOR PACKED NUMBER
    ASCII  DB 32 DUP(?)                                ;RESERVING 32 BYTES SPACE FOR ASCII VALUE
DATA ENDS                                              ;DETA SEGMENT ENDS HERE
CODE SEGMENT                                           ;START OF CODE SEGMENT
    ASSUME DS: DATA, CS:CODE                           ;ASSOCIATING THE SEGMENT REGISTERS WITH THEIR CORRESPONDING SEGMENTS
    START:                                             ;STARTING OF THE EXECUTION OF CODE SEGMENT
        MOV AX, DATA                                   ;TRANSFERING THE OFFSET ADDRESS OF DATA SEGMENT TO AX
        MOV DS, AX                                     ;TRANSFERING THE AX VALUE TO DS REGISTER IN TOTAL WE TRANSFERED THE VALUE OF DATA TO DS
        MOV DX,8                                       ;INITIALIZING DX WITH COUNT 8
        MOV CL,4                                       ;INITIALIZING CL WITH 4
        MOV SI,0                                       ;INITIALIZING SI WITH 0
        MOV DI,0                                       ;INITIALIZING DI WITH 0
    
    CONV:                                              ;LOOP LABEL IS DEFINED AS CONV
        MOV AX,0                                       ;INITIALIZING AX WITH 0
        MOV AL,PACK[SI]                                ;STORING THE 1 BYTE ELEMENT OF PACK INTO AL
        SHL AX, CL                                     ;SHIFT LEFT AX WITH 4 BITS
        SHR AL,CL                                      ;SHIFT RIGHT AX WITH 4 BITS
        MOV UNPACK[DI],AL                              ;STORING THE RESULT OF LOWER ORDER IN LOWER ORDER UNPACK
        MOV ASCII[DI],AL                               ;STORE AL IN LOWER ASCII
        ADD ASCII[DI],30H                              ;STORE ASCII VALUE OF LOWER IN LOWER ORDER ASCII
        MOV UNPACK[DI+1],AH                            ;STORE RESULT OF HIGHER ORDER IN HIGHER ORDER UNPACK
        MOV ASCII[DI+1],AH                             ;STORE AH IN HIGHER ORDER ASCII
        ADD ASCII[DI+1],30H                            ;STORE ASCII VALUE OF HIGHER ORDER IN HIGHER ORDER ASCII
        INC SI                                         ;INCREMENT SI
        ADD DI,2                                       ;INCREMENT DI BY 2
        DEC DX                                         ;DECREMENT THE VALUE OF DX BY 1
        JNE CONV                                       ;REPEAT CONV IF CX IS NOT EQUAL TO ZERO ELSE IT WILL MOVE OUT OF THE LOOP
CODE ENDS                                              ;CODE SEGMENT ENDS HERE
END START                                              ;PROGRAM ENDS