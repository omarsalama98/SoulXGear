                                                ; EXPORT MY SELF
PUBLIC USERNAME
PUBLIC LOAD_USER_NAME
					; VARIABLE WHICH ARE DECLARED IN MAIN PROGRAM
					EXTRN PLAYER1_NAME:BYTE
					EXTRN USER_NAME_ENTER_MES:BYTE
					EXTRN USER_NAME_ENTER_KEY:BYTE
                    EXTRN HP_BAR_PLAYER1_NAME:BYTE
;---------------------------------------------------------------------------------------------------	
                                                .MODEL SMALL

                                                .CODE

USERNAME    PROC       FAR

        ; CLEAN INPUT BUFFER SO THAT PREVIOUS ENTERY PRESSED IN ENTRY SCREEN DOESN'T AFFECT THIS
		PUSH ES
		MOV AX, 0000H
		MOV ES, AX
		MOV ES:[041AH], 041EH
		MOV ES:[041CH], 041EH				; Clears keyboard buffer
		POP		ES

        ; Activate Video mode
		MOV AX, 4F02H
		MOV BX, 105H			; FIRST ACTIVATE VIDEO MODE TO CLEAR SCREEN TO DRAW ON CLEAN GROUND
		INT 10H

        ; Activate TEXT mode
		MOV AX, 0003H
        MOV BX, 0
		INT 13H

        ; FIRST DISPLAY ENTER YOUR NAME
        ;DISPLAY MESSAGE
        MOV AH, 9
        LEA DX, USER_NAME_ENTER_MES
        INT 21H

        ; SECOND DISPLAY PRESS ENTER TO CONTINUE
        ; MOVE CURSOR TO RIGHT LOCATION
        MOV AH, 2
        MOV DL, 0
        MOV DH, 2
        INT 10H
        ; DISPLAY MESSAGE
        MOV AH, 9
        LEA DX, USER_NAME_ENTER_KEY
        INT 21H

        ; MOVE CURSOR TO RIGHT LOCATION
        MOV AH, 2
        MOV DL, 0
        MOV DH, 1
        INT 10H

        MOV SI, 0
USER_NAME_LOOP:     ; GET USER INPUT
        MOV AH, 0
        INT 16H

        ; CHECK IF PRESSED ENTER AND AT LEAST 1 CHARACTER WAS ENTERED THEN MOVE TO MAIN MENU
        CMP AH, 1CH
        JNE USER_NAME_CHECK
        CMP SI, 0
        JE USER_NAME_LOOP
        ; HERE EXIT USER NAME ENTRY SCREEN
        JMP GO_TO_MAIN_MENU

USER_NAME_CHECK:
        CMP SI, 15
        JE USER_NAME_LOOP
        ; MAKE SURE IT IS A LETTER
        CMP AL, 41H
        JB USER_NAME_LOOP
        CMP AL, 7AH
        JA USER_NAME_LOOP
        CMP AL, 5BH
        JB VALID_LETTER
        CMP AL, 60H
        JA VALID_LETTER
        JMP USER_NAME_LOOP

VALID_LETTER:
        LEA BX, PLAYER1_NAME    ; LOAD VALUE INTO MEMORY
        MOV [BX][SI], AL

        MOV AH, 2                      ; SHOW IT ON SCREEN
        MOV DL, AL
        INT 21H

        INC SI              ; INCREMENT VARIABLE
        JMP USER_NAME_LOOP  ; GET NEXT CHARACTER

GO_TO_MAIN_MENU:
; GO TO MAIN MENU

        RET
USERNAME    ENDP

LOAD_USER_NAME  PROC    FAR

        LEA DI, HP_BAR_PLAYER1_NAME
        LEA SI, PLAYER1_NAME

        MOV CX, 16
        LOAD_NAME:
                MOV AL, [SI]
                MOV [DI], AL
                INC DI
                INC SI
                LOOP LOAD_NAME
        
        LEA DI, HP_BAR_PLAYER1_NAME
        MOV CX, 16
        LOAD_NAME_2:
                MOV AL, [DI]
                CMP AL, '$'
                JNE OK_LETTER
                MOV AL, ' '
                MOV [DI], AL
                OK_LETTER:
                        INC DI 
                        LOOP LOAD_NAME_2

        RET
LOAD_USER_NAME  ENDP

END