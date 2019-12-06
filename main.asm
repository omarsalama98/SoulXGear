                                    ; GATHER ALL FILES PROCS HERE
                                    ; AND EXPORT TO THEM ALL VARIABLES THEY NEED
                            ; ENTRY SCREEN EXPORTS AND IMPORTS
EXTRN ENTRY_SCREEN:FAR
;---------------------------------------------------------------------------------------------------------------------------------
                                ; USERNAME EXPORTS AND IMPORTS
EXTRN USERNAME:FAR
PUBLIC PLAYER1_NAME, USER_NAME_ENTER_MES, USER_NAME_ENTER_KEY
;--------------------------------------------------------------------------------------------------------------------------------

                            ; MAIN MENU EXPORTS AND IMPORTS
EXTRN MAIN_MENU:FAR
PUBLIC MAIN_MENU_START_GAME_COLOR, MAIN_MENU_CHAT_COLOR, MAIN_MENU_QUIT_COLOR, MAIN_MENU_CURRENT_STAT
;--------------------------------------------------------------------------------------------------------------------------------

                                    .MODEL LARGE
                                    .STACK 512
                                    
                                    .DATA
                            ; USER NAME DATA
PLAYER1_NAME        DB      16 DUP('$')
PLAYER2_NAME        DB      'Player 2$'         ; for now till phase 2
USER_NAME_ENTER_MES DB      'Please Enter Your Name:$'
USER_NAME_ENTER_KEY DB      'Press Enter Key To Continue$'
;-----------------------------------------------------------------------------------------------------------------------------
                            ; MAIN MENU DATA
MAIN_MENU_START_GAME_COLOR        DB          ?
MAIN_MENU_CHAT_COLOR              DB          ?
MAIN_MENU_QUIT_COLOR              DB          ?
MAIN_MENU_CURRENT_STAT			  DB		  0		; WHICH OPTION HAS FOCUS NOW 0->START GAME, 1->CHAT, 2->QUIT
ESC_RETURN_TO_MAIN_MENU			  DB		  'Press Esc To Return To Main Menu$'
;------------------------------------------------------------------------------------------------------------------------------

                                    .CODE
MAIN    PROC    FAR
        MOV AX, @DATA
        MOV DS, AX

        CALL ENTRY_SCREEN       ; DISPLAY ENTRY SCREEN

        CALL USERNAME           ; GET USERNAME

RETURN_TO_MAIN_MENU:            ; DISPLAY MAIN MENU
        CALL MAIN_MENU

        MOV AL, MAIN_MENU_CURRENT_STAT
        CMP AL, 0
        JE START_GAME                 ; CHECK WHICH OPTION USER PICKED
        CMP AL, 1
        JE START_CHAT
        JMP QUIT_GAME

START_GAME:
        CALL MAIN_GAME                  ; START MAIN GAME AND WHEN DONE RETURN TO MAIN MENU
        JMP RETURN_TO_MAIN_MENU

START_CHAT:
        CALL CHAT_SCREEN                ; OPEN CHAT SCREEN AND WHEN DONE RETURN TO MAIN MENU
        JMP RETURN_TO_MAIN_MENU

QUIT_GAME:      ; EXIT WITH ERROR LEVEL 0
        ; BUT FIRST CLEAR SCREEN JUST TO LOOK COOL
        MOV AX, 4F02H
	MOV BX, 105H			
	INT 10H

        MOV AX, 4C00H
        INT 21H
MAIN    ENDP

;-----------------------------------------------------------------------------------------------------------------------------------------

MAIN_GAME       PROC    NEAR    ; JUST EMPTY BODY TILL INTEGRATE FULL GAME
                RET
MAIN_GAME       ENDP

CHAT_SCREEN     PROC    NEAR    ; EMPTY SCREEN TILL PHASE 2 TO IMPLEMENT CHAT
        ; Activate Video mode TO CLEAR SCREEN
		MOV AX, 4F02H
		MOV BX, 105H
		INT 10H

		MOV AH, 9		
		LEA DX, ESC_RETURN_TO_MAIN_MENU		; FIRST DISPLAY THE RETURN TO MAIN MENU MESSAGE
		INT 21H
											
	CHAT_WAITING_FOR_ESC:					; WAIT FOR USER TO PRESS ESC AND THEN GO TO MAIN MENU
		MOV AH, 0
		INT 16H
		CMP AH, 01H
		JNE CHAT_WAITING_FOR_ESC

        RET
CHAT_SCREEN     ENDP

;-----------------------------------------------------------------------------------------------------------------------------------------
END     MAIN