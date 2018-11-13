DATA SEGMENT
    ARR DB 100 DUP(?)
    MES1 DB 13,10,"ENTER THE NO OF ELEMENTS(00H-64H) : $"
    MES2 DB 13,10,"ENTER THE ELEMENTS : $"
    MES3 DB 13,10,"ENTER ELEMENT YOU WANT TO SEARCH : $"
    MES4 DB 13,10,"ELEMENT FOUND $"
    MES5 DB 13,10, "ELEMENT NOT FOUND $"
    NO DW ?
    S DB ?
DATA ENDS
CODE SEGMENT
    ASSUME DS:DATA, CS:CODE        
    START:
        NA:
            LEA DX,MES1
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
            
            LEA DX,MES2
            MOV AH,9
            INT 21H
            
            MOV NO,BX
            
            LEA BX,ARR
            MOV CX,NO
            MOV DI,0
            
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
                
        LEA DX,MES3
        MOV AH,9
        INT 21H
        
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
            
       MOV CX,NO
       LEA BX,ARR
       MOV DI,0
       MOV S,DL
       MOV DL,S
       CALL FAR PTR LINSRCH
CODE ENDS

LIN SEGMENT
    LINSRCH PROC FAR 
        LINSEARCH:
            CMP [BX+DI],DL
            JNZ B
            LEA DX,MES4
            MOV AH,9
            INT 21H
            RET
            B:
                INC DI
                LOOP LINSEARCH
            LEA DX,MES5
            MOV AH,9
            INT 21H
            RET
            LINSRCH ENDP
LIN ENDS
END START
         
            
                 
                