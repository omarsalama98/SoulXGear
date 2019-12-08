                                    ; GATHER ALL FILES PROCS HERE
                                    ; AND EXPORT TO THEM ALL VARIABLES THEY NEED
                            ; ENTRY SCREEN EXPORTS AND IMPORTS
EXTRN ENTRY_SCREEN:FAR
;---------------------------------------------------------------------------------------------------------------------------------
                                ; USERNAME EXPORTS AND IMPORTS
EXTRN USERNAME:FAR
EXTRN LOAD_USER_NAME:FAR
PUBLIC PLAYER1_NAME, USER_NAME_ENTER_MES, USER_NAME_ENTER_KEY, HP_BAR_PLAYER1_NAME
;--------------------------------------------------------------------------------------------------------------------------------

                            ; MAIN MENU EXPORTS AND IMPORTS
EXTRN MAIN_MENU:FAR
PUBLIC MAIN_MENU_START_GAME_COLOR, MAIN_MENU_CHAT_COLOR, MAIN_MENU_QUIT_COLOR, MAIN_MENU_CURRENT_STAT
;--------------------------------------------------------------------------------------------------------------------------------
                            ; HP_BAR EXPORTS AND IMPORTS
EXTRN HP_BAR_FUNCTION:FAR
EXTRN P1_HEADSHOT:FAR
PUBLIC PLAYER1_HP, PLAYER2_HP, GAME_OVER
;--------------------------------------------------------------------------------------------------------------------------------
; MAIN GAME EXPORTS AND IMPORTS
;EXTRN PLAY_MAIN_GAME:FAR
;PUBLIC startXY, endY, startXY2, endY2, orientate, stance, P1_stance, P2_stance, Emsa7, origin_p1, origin_p2, JUMP_COUNTER_UP1, JUMP_COUNTER_DN1, JUMP_COUNTER_UP2, JUMP_COUNTER_DN2, FLAGS, IN_KEY
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
                                ; HP BAR DATA
MAX_HP                  EQU         20
NAMES_DISTANCE          EQU         90
HP_BAR_PLAYERS_NAMES       DB          5 DUP (' ')
HP_BAR_PLAYER1_NAME        DB          15 DUP (' ')
                           DB          NAMES_DISTANCE DUP(' ')
                           DB          'Player 2'
                           DB          '$'
PLAYER1_HP                 DW          MAX_HP
PLAYER2_HP                 DW          MAX_HP
GAME_OVER                  DW          0               ; 0->NOT OVER, 1->PLAYER1 WON, 2->PLAYER2 WON

;------------------------------------------------------------------------------------------------------------------------------
                                ; CONTROL DATA
; startXY     	DW  START_Y, START_X_1
; endY        	DW  ?
; startXY2    	DW  START_Y, START_X_2  
; endY2       	DW  ? 
; orientate   	DW  1
; stance      	DW  0		;0-> stands & 1->crouch --> FOR DRAWING 
; P1_stance      	DW  0		;0-> stands & 1->crouch 2->JUMP --> FOR GAME LOGIC
; P2_stance      	DW  0		;0-> stands & 1->crouch 2->JUMP --> FOR GAME LOGIC
; Emsa7			DW  0		;Variable to clear player   

; ;			 Y    X
; origin_p1 DW START_Y, START_X_1
; origin_p2 DW START_Y, START_X_2

; JUMP_COUNTER_UP1 		DW 0
; JUMP_COUNTER_DN1 		DW 0
; JUMP_COUNTER_UP2 		DW 0
; JUMP_COUNTER_DN2 		DW 0

; FLAGS 					DW ?			;NOT USED NOW
; IN_KEY 					DB ?
;------------------------------------------------------------------------------------------------------------------------

                                    .CODE
MAIN    PROC    FAR
        MOV AX, @DATA
        MOV DS, AX

        CALL ENTRY_SCREEN       ; DISPLAY ENTRY SCREEN

        CALL USERNAME           ; GET USERNAME

        CALL LOAD_USER_NAME

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

                MOV AX, 4F02H
	        MOV BX, 105H 
	        INT 10H

                MOV AH, 9
                LEA DX, HP_BAR_PLAYERS_NAMES       ; DISPLAY PLAYERS NAMES FIRST
                INT 21H

                CALL HP_BAR_FUNCTION

main_loop:
                ;CALL PLAY_MAIN_GAME
                jmp main_loop

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