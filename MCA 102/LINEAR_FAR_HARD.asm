DATA SEGMENT
    ARR DB 19H, 03H, 25H, 39H, 18H
    S DB 39H
DATA ENDS
CODE SEGMENT
    ASSUME DS:DATA, CS:CODE        
    START: MOV AX,DATA
           MOV DS,AX
             
       MOV CX,5
       LEA BX,ARR
       MOV DI,0
       MOV DL,S
       CALL FAR PTR LINSRCH
CODE ENDS

LIN SEGMENT
    LINSRCH PROC FAR 
        LINSEARCH:
            CMP [BX+DI],DL
            JE B
            
            INC DI
            LOOP LINSEARCH
            MOV BL,00H
            MOV AX,4C00H
            INT 21H
            RET
            
            B:  MOV BL,01H
                MOV AX,4C00H
                INT 21H
                RET
    LINSRCH ENDP
LIN ENDS
END START
         
            
                 
                