include macros.inc
.MODEL COMPACT
.386
.STACK 256
.DATA
;-------------------------------------------------------------------STATIC CONFIGURATIONS------------------------------------------------
;SCREEN DIMENSIONS 1024X768
SCREEN_MAX_X 			EQU 1024
SCREEN_MAX_Y 			EQU 768
ScreenEndCol    		EQU 1024
ScreenEndRow    		EQU 768 

;BODY DIMENSIONS
eyewidth          		EQU 5                     
torsowidth        		EQU 25                    
gazmawidth        		EQU 50                                                               
reglwidth         		EQU 22
armgamboowidth    		EQU 90        ;Widths are generally the length of the body parts   
armwidth          		EQU 80        ;But they were called this way as everything was sideways
armwidthpunch     		EQU 150
armwidthpunchfo2  		EQU 90        ;zawwed hena 3shan el punch fo2 bas elly tetzabbat    
neckwidth         		EQU 15                 
headwidth         		EQU 40
fingerwidth       		EQU 3 
boxwidth          		EQU 22
	
precisionTorso  		EQU 8
precisionTorso2 		EQU 2 
eyeheight       		EQU 5          
nosgazmaheight  		EQU 10
kickreglheight  		EQU 150 
reglheight      		EQU 100 
torsoheight     		EQU 70
armheight       		EQU 10        
neckheight      		EQU 12         
headheight      		EQU 45
knucklesheight  		EQU 4
	
;GAME COLORS	
GroundClr   			EQU 14
BackGndClr  			EQU 3 
			
;BODY COLORS			                                       
			                                                 
p1gazmaClr    EQU 6                       
p1ReglClr     EQU 1                           
p1TorsoClr    EQU 4                           
p1armClr      EQU 7                           
p1SkinClr     EQU 7                     
p1HairClr     EQU 9                                
FPEyeClr      EQU 5                     
SPEyeClr      EQU 14
HeartsClr     EQU 12

p2gazmaClr    EQU 0 
p2ReglClr     EQU 1 
p2TorsoClr    EQU 12 
p2armClr      EQU 6 
p2SkinClr     EQU 6 
p2HairClr     EQU 9 
;------------------------------------------------------------Serial----------------------------------------------------------------------
;CONSTANTS
	ESC_KEY 			EQU 01H
	Enter_Key   		EQU 13
	WindMid     		EQU WindHeight/2
	WindWidth   		EQU 80
	WindHeight  		EQU 25

	CLR_ATTR_SEND 		EQU 1FH
	CLR_ATTR_RECEIVE	EQU 4FH
;------------------------------------------------------------HP----------------------------------------------------------------------
SCREEN_WIDTH            EQU         1024
SCREEN_HEIGHT           EQU         768
MAX_HP_PROV             EQU         20
HALF_HP                 EQU         MAX_HP_PROV/2
QUARTER_HP              EQU         MAX_HP_PROV/4
NAMES_DISTANCE          EQU         90
HP_BAR_START_ROW        EQU         SCREEN_HEIGHT / 45
HP_BAR_END_ROW          EQU         SCREEN_HEIGHT / 30
HP_BAR_COLOR_GREEN      EQU         2
HP_BAR_COLOR_YELLOW     EQU         14
HP_BAR_COLOR_RED        EQU         4
HP_BACK_COL             EQU         0
BAR_WIDTH               EQU         10
HP_BARS_END_LINE        EQU         HP_BAR_END_ROW + 5
HP_PLAYER1_START_COL    EQU         5
HP_PLAYER2_START_COL    EQU         (SCREEN_WIDTH - 5 - BAR_WIDTH)

;--------------------------------DETERMINANTS OF LEVELS-------------------------------------------------------------------------------------
DMG_LEGSHOT_L1			EQU			1
DMG_BODYSHOT_L1			EQU			2
DMG_HEADSHOT_L1			EQU			3


DMG_LEGSHOT_L2			EQU			2
DMG_BODYSHOT_L2			EQU			3
DMG_HEADSHOT_L2			EQU			4

TIME_LEVEL1				EQU			60
TIME_LEVEL2				EQU			30

MAX_HP_LEVEL1			EQU			20
MAX_HP_LEVEL2			EQU			15
;------------------------------------------------------------------------------------------------------------------------------------

;COLORS:
; blue:1      
; green:2     
; LightBlue:3
; red:4       
; purple:5    
; orange:6
; white:7   
; Grey:8      
; blueGamed:9
; lightGreen:10   
; Labany:11              
; Yellow:14


;KEYS 					SCAN CODES
ESC_KEY 				EQU 01H
W_KEY 					EQU 11H
A_KEY 					EQU 1EH
S_KEY 					EQU 1FH
D_KEY 					EQU 20H
SPACE_KEY 				EQU 39H
UP_KEY 					EQU 48H
RIGHT_KEY 				EQU 4DH
DOWN_KEY 				EQU 50H
LEFT_KEY 				EQU 4BH
I_KEY 					EQU 17H
O_KEY 					EQU 18H
P_KEY 					EQU 19H
V_KEY 					EQU 2FH
B_KEY 					EQU 30H
N_KEY 					EQU 31H
L_KEY 					EQU 26H
Q_KEY 					EQU 10H



;PLAYERS ENUMS
player1  				EQU 1
player2  				EQU 2

;SPACING CONFIGURATIONS
PLAYERS_DISTANCE 		EQU 180			;THE DISTANCE BETWEEN THE ORIGIN OF ANY PLAYER AND THE MAXIMUM POINT HE CAN GO CLOSE TO THE OTHER PLAYER
MAX_LEFT 				EQU 30
MAX_RIGHT 				EQU SCREEN_MAX_X - 40

;JUMP CONFIGURATION
RUN_STEP 				EQU 30
RISE_STEP 				EQU 20			;NOTE!: ITS VALUE HAS TO BE DIVISIBLE BY 'JUMP_STEPS' VALUE
FALL_STEP 				EQU 20			;NOTE!: ITS VALUE HAS TO BE DIVISIBLE BY 'JUMP_STEPS' VALUE
JUMP_STEPS 				EQU 200
JUMP_DELAY				EQU 20
;ACTIONS
STNDS 					EQU 0
CRCH 					EQU 1
JMPS 					EQU 2
PUNCH					EQU 3
PUNCH_UP				EQU 4
KICKS					EQU 5
DEF						EQU 6

;START POSITIONS
START_Y 				EQU 600	;BOTH PLAYERS
START_X_1 				EQU 150 	;PLAYER1
START_X_2 				EQU 750 ;PLAYER2

;PUNCH DELAY
PNCH_DELAY				EQU 20

;MAX CLEAR DISTANCE
MAX_CLEAR_DISTANCE 		EQU 120

;DISTANCE BETWEEN THE 2 PLAYERS ORIGIN TO MAKE COLLISION
COLLISION_DIST			EQU PLAYERS_DISTANCE


;PLAYERS ORIGIN POINT COORDINATES {SET; GET;}
P1_X 					EQU word ptr[origin_p1][2]
P1_Y 					EQU word ptr[origin_p1][0]

P2_X 					EQU word ptr[origin_p2][2]
P2_Y 					EQU word ptr[origin_p2][0]


;GROUND CONSTANTS
GroundStart     		EQU 601          ;Rows
GroundHeight    		EQU 50

;HEARTS constants
HeartsStart     		EQU 100          ;Rows
HeartsHeight    		EQU 20
P1HEARTS_X				EQU 50
P1HEARTS_Y				EQU 100

P2HEARTS_X				EQU 974
P2HEARTS_Y				EQU 100

;---------------------------------------------------------END STATIC CONFIGURATIONS---------------------------------------------------------


;---------------------------------------------------------------GAME VARIABLES--------------------------------------------------------------
;						Y   X
startXY     			DW  START_Y, START_X_1
endY        			DW  ?
startXY2    			DW  START_Y, START_X_2  
endY2       			DW  ? 
orientate   			DW  1
stance      			DW  0		;0-> stands & 1->crouch --> FOR DRAWING 
P1_stance      			DW  0		;0-> stands & 1->crouch 2->JUMP --> FOR GAME LOGIC
P2_stance      			DW  0		;0-> stands & 1->crouch 2->JUMP --> FOR GAME LOGIC
Emsa7					DW  0		;Variable to clear player   

;			 					Y    X
origin_p1 				DW START_Y, START_X_1
origin_p2 				DW START_Y, START_X_2

JUMP_COUNTER_UP1 		DW 0
JUMP_COUNTER_DN1 		DW 0
JUMP_COUNTER_UP2 		DW 0
JUMP_COUNTER_DN2 		DW 0

FLAGS 					DW ?			;NOT USED NOW
IN_KEY 					DB ?

;GROUND  VARIABLES
GroundXY 				DW  601,0
GroundEnd				DW  ?


;HEART VARIABLES
P1HeartsXY    			DW  P1HEARTS_Y ,P1HEARTS_X
P1HeartsEnd   			DW  ? 
P1HeartsLeft  			DW  2
			
P2HeartsXY    			DW  P2HEARTS_Y ,P2HEARTS_X
P2HeartsEnd   			DW  ?
P2HeartsLeft  			DW  1
EMSA7HEARTS				DW	0
			
P1P2Hearts    			DW  1

DMG_LEGSHOT             DW         ?
DMG_BODYSHOT            DW         ?
DMG_HEADSHOT            DW         ?
LEVEL					DB		   ?
TIME 					DB		   ?
TIME_DISPLAY			DB		   ' ', ' ', ' ', '$'
PREV_TIME				DB		   ?
;---------------------------------------------------------------END GAME VARIABLES--------------------------------------------------------------
;------------------------------------------------------------Serial----------------------------------------------------------------------
;VARIABLES
	EXIT_MES 			DB 'Press Any Key To Return To Main Menu','$'
	PRESSED_KEY			DB ?
	PRESSED_KEY_SC		DB ? ;PRESSED KEY SCANCODE
	RECEIVED_KEY 		DB ?
	CURSOR_SEND_Y		DB  1
	CURSOR_SEND_X       DB  0
	
	CURSOR_RECEIVE_Y	DB  13
	CURSOR_RECEIVE_X   	DB  0
	
	p1startx   			DB  0 
	p1starty    		DB  1
             
	p2startx    		DB  0 
	p2starty    		DB  (WindMid + 1)  
	WAITING_FOR_USER	DB	'Waiting For Other Player To Enter His/Her Username!$'
;--------------------------------------------------------------Main Game Data--------------------------------------------------------------------

                            ; USER NAME DATA
PLAYER1_NAME        DB      16 DUP('$')
PLAYER2_NAME        DB      16 DUP('$')         ; for now till phase 2
USER_NAME_ENTER_MES DB      'Please Enter Your Name:$'
USER_NAME_ENTER_KEY DB      'Press Enter Key To Continue$'
LEVEL1_CHOICE		DB		'Press 1 For Level 1$'
LEVEL2_CHOICE		DB		'Press 2 For Level 2$'
;-----------------------------------------------------------------------------------------------------------------------------
                            ; MAIN MENU DATA
MAIN_MENU_START_GAME_COLOR        DB          ?
MAIN_MENU_CHAT_COLOR              DB          ?
MAIN_MENU_QUIT_COLOR              DB          ?
MAIN_MENU_CURRENT_STAT			  DB		  0		; WHICH OPTION HAS FOCUS NOW 0->START GAME, 1->CHAT, 2->QUIT
ESC_RETURN_TO_MAIN_MENU			  DB		  'Press Esc To Return To Main Menu$'
;------------------------------------------------------------------------------------------------------------------------------
                                ; HP BAR DATA
NAMES_DISTANCE          EQU         90
MAX_HP                     DW         ?
CLEAR_FIRST_LINE           DB         128 DUP(' ')
                           DB         '$'
HP_BAR_PLAYERS_NAMES       DB          5 DUP (' ')
HP_BAR_PLAYER1_NAME        DB          15 DUP (' ')
                           DB          NAMES_DISTANCE DUP(' ')
HP_BAR_PLAYER2_NAME        DB          15 DUP (' ')
                           DB          '$'
PLAYER1_HP                 DW          ?
PLAYER2_HP                 DW          ?
PLAYER1_HEARTS             DW          3
PLAYER2_HEARTS             DW          3
GAME_OVER                  DW          0               ; 0->NOT OVER, 1->PLAYER1 WON, 2->PLAYER2 WON
PLAYER1_WON_MES            DB         100 DUP('$')
PLAYER2_WON_MES            DB         100 DUP('$')
END_GAME_MES               DB          'Press Enter Key To Return To Main Menu$'
DRAW_MES				   DB		   'Game Was A Draw!$'
;-----------------------------------------------------------------------------GAME CODE------------------------------------------------------------------
.CODE
MAIN PROC NEAR
	MOV AX, @DATA
	MOV DS, AX	
    MOV ES, AX

    CALL ENTRY_SCREEN       ; DISPLAY ENTRY SCREEN

    CALL USERNAME           ; GET USERNAME

	CALL UART_init

	CALL SEND_USERNAME

	CALL LOAD_USER_NAME

RETURN_TO_MAIN_MENU:            ; DISPLAY MAIN MENU
        CALL MAIN_MENU

        MOV AL, MAIN_MENU_CURRENT_STAT
        CMP AL, 0
        JE START_GAME                 ; CHECK WHICH OPTION USER PICKED
        CMP AL, 1
        JE START_CHAT
        JMP QUIT_GAME


START_CHAT:
		MOV AL, 1
		MOV CURSOR_SEND_Y, AL
		MOV AL, 0
		MOV CURSOR_SEND_X, AL
	
		MOV AL, 13
		MOV CURSOR_RECEIVE_Y, AL
		MOV AL, 0
		MOV CURSOR_RECEIVE_X, AL
	
		MOV AL, 0
		MOV p1startx, AL
		MOV AL, 1
		MOV p1starty, AL

		MOV AL, 0
		MOV p2startx, AL
		MOV AL,  (WindMid + 1)
		MOV p2starty, AL

        CALL CHAT                ; OPEN CHAT SCREEN AND WHEN DONE RETURN TO MAIN MENU
        JMP RETURN_TO_MAIN_MENU

;-----------------------------------------------------------------------------SET VIDEO MODE--------------------------------------------------------------
START_GAME:

	CALL SET_LEVEL

    MOV AX, 4F02H
	MOV BX, 105H 
	INT 10H
	; mov al, 13h
	; mov ah, 0
	; int 10h
;--------------------------------------------------------------------------END SET VIDEO MODE--------------------------------------------------------------

	MOV AL, LEVEL
	CMP AL, 2
	JE MAIN_LEVEL2
	; LEVEL 1 PICKED
	MOV AX, DMG_LEGSHOT_L1
	MOV DMG_LEGSHOT, AX
	MOV AX, DMG_BODYSHOT_L1
	MOV DMG_BODYSHOT, AX
	MOV AX, DMG_HEADSHOT_L1
	MOV DMG_HEADSHOT, AX
	JMP MAIN_LEVEL_SET

MAIN_LEVEL2:
	; LEVEL 2 PICKED
	MOV AX, DMG_LEGSHOT_L2
	MOV DMG_LEGSHOT, AX
	MOV AX, DMG_BODYSHOT_L2
	MOV DMG_BODYSHOT, AX
	MOV AX, DMG_HEADSHOT_L2
	MOV DMG_HEADSHOT, AX

MAIN_LEVEL_SET:

    MOV P1_X, START_X_1
    MOV P1_Y, START_Y

    MOV P2_X, START_X_2
    MOV P2_Y, START_Y

    MOV JUMP_COUNTER_UP1, 0
    MOV JUMP_COUNTER_DN1, 0
    MOV JUMP_COUNTER_UP2, 0
    MOV JUMP_COUNTER_DN2, 0
    
    MOV P1_stance, STNDS
    MOV P2_stance, STNDS 
    
    
;-------------------------------------------------------------------------- LOAD ENVIROMENT---------------------------------------------------------------
	LEA BX, GroundXY
    MOV AX, 601
    MOV [BX], AX
    INC BX
    INC BX
    MOV AX, 0
    MOV [BX], AX
    
    call Background

    ; CLEAR FIRST LINE
    MOV AH, 9
    LEA DX, CLEAR_FIRST_LINE
    INT 21H

    ; MOVE CURSOR TO GOOD POSITION AGAIN
    MOV AH, 2
    MOV DX, 0
    INT 10H

    MOV AH, 9
    LEA DX, HP_BAR_PLAYERS_NAMES       ; DISPLAY PLAYERS NAMES FIRST
    INT 21H

    MOV AX, MAX_HP
    MOV PLAYER1_HP, AX
    MOV PLAYER2_HP, AX
    MOV AX, 0
    MOV GAME_OVER, AX

    CALL HP_BAR_FUNCTION

    MOV BX, 3
    MOV PLAYER1_HEARTS, BX
    MOV PLAYER2_HEARTS, BX

    DRAW_P1_HEARTS PLAYER1_HEARTS
	DRAW_P2_HEARTS PLAYER2_HEARTS

;--------------------------------------------------------------------------END LOAD ENVIROMENT--------------------------------------------------------------
	
;-----------------------------------------------------------------------------INTIALIZE PLAYERS------------------------------------------------------------
	DRAW_P1 origin_p1, STNDS
	DRAW_P2 origin_p2, STNDS
;----------------------------------------------------------------------------END INITIALIZE PLAYERS---------------------------------------------------------
	

;-----------------------------------------------------------------------------MAIN LOOP--------------------------------------------------------------------
	
	CALL INIT_TIME

	MAIN_LOOP: 

		CALL DRAW_TIME

		MOV AL, TIME
		CMP AL, 0
		JE TIME_OUT

		MOV BX, 0
		MOV AH, 2
		MOV DX, 0040H
		INT 10H


;-----------------------------------------------------------------------------REPLACE PLAYER 1--------------------------------------------------------------
		;REPLACE PLAYERS IF THEY WERE JUMPING
		REPLACE_P1:
			 CMP P1_stance, JMPS
			 JNZ  REPLACE_P2

			MOV_UP_P1:
				CMP JUMP_COUNTER_UP1, JUMP_STEPS / RISE_STEP
				JAE MOV_DN_P1
					INC JUMP_COUNTER_UP1
					CALL CLR_P1
					MOV AX, RISE_STEP
					SUB P1_Y, AX
					DRAW_P1 origin_p1, STNDS
					JMP REPLACE_P2

			MOV_DN_P1:
				CMP JUMP_COUNTER_DN1, 0
				JNZ MOV_DN_1_COMP
					MOV CX, JUMP_DELAY
					DELAY_LOOP7:call delay;
					LOOP DELAY_LOOP7
				MOV_DN_1_COMP:
				CMP JUMP_COUNTER_DN1, JUMP_STEPS / FALL_STEP
				JAE REP_END_P1
					INC JUMP_COUNTER_DN1
					CALL CLR_P1
					ADD P1_Y, FALL_STEP
					DRAW_P1 origin_p1, STNDS
					JMP REPLACE_P2
			REP_END_P1:
				MOV P1_stance, STNDS
				MOV JUMP_COUNTER_UP1, 0
				MOV JUMP_COUNTER_DN1, 0
;---------------------------------------------------------------------------END REPLACE PLAYER 1------------------------------------------------


;-----------------------------------------------------------------------------REPLACE PLAYER 2----------------------------------------------------									
		 REPLACE_P2:
				CMP P2_stance, JMPS
				JNZ  GET_KEY
				
			MOV_UP_P2:
				CMP JUMP_COUNTER_UP2, JUMP_STEPS / RISE_STEP
				JAE MOV_DN_P2
					INC JUMP_COUNTER_UP2
					CALL CLR_P2
					MOV AX, RISE_STEP
					SUB P2_Y, AX
					DRAW_P2 origin_p2, STNDS
					JMP GET_KEY

			MOV_DN_P2:
			CMP JUMP_COUNTER_DN2, 0
			JNZ MOV_DN_2_COMP
				MOV CX, JUMP_DELAY
				DELAY_LOOP8:call delay;
				LOOP DELAY_LOOP8
				
				MOV_DN_2_COMP:
				CMP JUMP_COUNTER_DN2, JUMP_STEPS / FALL_STEP
				JAE REP_END_P2
					INC JUMP_COUNTER_DN2
					CALL CLR_P2
					ADD P2_Y, FALL_STEP
					DRAW_P2 origin_p2, STNDS
					JMP GET_KEY
			REP_END_P2:
				MOV P2_stance, STNDS
				MOV JUMP_COUNTER_UP2, 0
				MOV JUMP_COUNTER_DN2, 0
;-----------------------------------------------------------------------------END REPLACE PLAYER ------------------------------------------------------------


	
;---------------------------------------------------------------------------------GET KEY--------------------------------------------------------------------			
		GET_KEY:
			CALL GET_KEY_PRESSED
			JNZ CLR_BUFFER				;If zero flag is 1(jz = true) -> nothing is pressed else -> a key is pressed
			JMP  MAIN_LOOP_END
			;NOW AX = VALUE OF THE KEY
		CLR_BUFFER:
			MOV IN_KEY, AH
			CALL CLEARKEYBOARDBUFFER	;Here a key is red from the keyboard buffer and put in AX then we clear the keyboard buffer
;---------------------------------------------------------------------------------END GET KEY----------------------------------------------------------------


;------------------------------------------------------------------------------CHECK PLAYER 1 INPUTS----------------------------------------------------------		
			
		;MOVE PLAYER 1 RIGHT
		CHECK_P1_R:
			CMP IN_KEY, D_KEY
			JNE CHECK_P1_L
				P1_MOV_RIGHT:
				MOV AX, P2_X
				SUB AX, PLAYERS_DISTANCE
				CMP P1_X, AX
				JGE MAIN_LOOP_END
					CALL CLR_P1		
					ADD P1_X, RUN_STEP
					DRAW_P1 origin_p1, P1_stance
					JMP MAIN_LOOP_END
					
		;MOVE PLAYER 1 LEFT
		CHECK_P1_L:		
			CMP IN_KEY, A_KEY
			JNE CHECK_P1_DN
				P1_MOV_LEFT:
				CMP P1_X, MAX_LEFT
				JBE DRAW_P1_AGAIN
					CALL CLR_P1
					MOV AX, RUN_STEP
					SUB P1_X, AX
					DRAW_P1 origin_p1, P1_stance
					JMP MAIN_LOOP_END
					
					
		DRAW_P1_AGAIN:								;REDRAWS PLAYER WHEN HE IS AT THE LEFT CORNER (THIS FIXES A BUG WHEN KICKS HAPPEN)
			DRAW_P1 origin_p1, P1_stance
			JMP MAIN_LOOP_END
		
		
		
		;PLAYER 1 CROUCH
		CHECK_P1_DN:			
			CMP IN_KEY, S_KEY
			JNE CHECK_P1_UP
				CMP P1_stance, JMPS
				JNE CRCH_P1
					CALL CLR_P1	
					MOV P1_Y, START_Y ; ADJUST THE PLAYERS Y COORDINATE THEN CROUCH
					MOV JUMP_COUNTER_UP1, 0
					MOV JUMP_COUNTER_DN1, 0
				;CROUCH
				CRCH_P1:
				CALL CLR_P1	
				MOV P1_stance, CRCH
				DRAW_P1 origin_p1, P1_stance
				JMP MAIN_LOOP_END	
				
		;PLAYER 1 JUMP OR STANDS(IF HE WAS CROUCHING)
		CHECK_P1_UP:
			CMP IN_KEY, W_KEY
			JNE CHECK_P1_ATCKUP
				CMP P1_stance, CRCH
				JNE P1_JUMP_BEGIN
				;P1_UP:
					CALL CLR_P1	
					MOV P1_stance, STNDS
					DRAW_P1 origin_p1, P1_stance
					JMP MAIN_LOOP_END

				P1_JUMP_BEGIN:
					CMP P1_stance, JMPS
					JE MAIN_LOOP_END
						MOV JUMP_COUNTER_UP1, 1
					P1_JUMP:
						CALL CLR_P1
						MOV AX, RISE_STEP
						SUB P1_Y, AX
						MOV P1_stance, JMPS
						DRAW_P1 origin_p1, P1_stance					
		;PLAYER1 ATTACK UP
		CHECK_P1_ATCKUP:
			CMP IN_KEY, V_KEY
			JNE CHECK_P1_ATCKFRNT
				CMP P1_stance, CRCH		;If the player is crouching or jumping do not attack
				JE MAIN_LOOP_END
				CMP P1_stance, JMPS
				JE MAIN_LOOP_END
					CALL CLR_P1
					MOV P1_stance, PUNCH_UP	;IMPORTANT FOR THE CLEAR FUNCTION
					DRAW_P1 origin_p1, P1_stance
					MOV CX, PNCH_DELAY
					DELAY_LOOP1:call delay;
					LOOP DELAY_LOOP1
					CALL CLR_P1
					MOV P1_stance, STNDS
					DRAW_P1 origin_p1, P1_stance
					JMP P1_PNCH_UP			;GO CHECK FOR COLLISION

		;PLAYER1 ATTACK FRONT
		CHECK_P1_ATCKFRNT:
			CMP IN_KEY, B_KEY
			JNE CHECK_P1_ATCKDN
				CMP P1_stance, CRCH		;If the player is crouching or jumping do not attack
				JE MAIN_LOOP_END
				CMP P1_stance, JMPS
				JE MAIN_LOOP_END
					CALL CLR_P1
					MOV P1_stance, PUNCH	;IMPORTANT FOR THE CLEAR FUNCTION
					DRAW_P1 origin_p1, P1_stance
					MOV CX, PNCH_DELAY
					DELAY_LOOP2:call delay;
					LOOP DELAY_LOOP2
					CALL CLR_P1
					MOV P1_stance, STNDS
					DRAW_P1 origin_p1, STNDS
					JMP P1_PNCH_FRNT			;GO CHECK FOR COLLISION
		;PLAYER1 ATTACK DOWN
		CHECK_P1_ATCKDN:
			CMP IN_KEY, N_KEY
			JNE CHECK_P1_DEF
				CMP P1_stance, CRCH		;If the player is crouching or jumping do not attack
				JE MAIN_LOOP_END
				CMP P1_stance, JMPS
				JE MAIN_LOOP_END ;IF P1 IS JUMPING NOTHING HAPPENS
					CALL CLR_P1
					MOV P1_stance, KICKS	;IMPORTANT FOR THE CLEAR FUNCTION
					DRAW_P1 origin_p1, P1_stance
					MOV CX, PNCH_DELAY
					DELAY_LOOP3:call delay;
					LOOP DELAY_LOOP3
					CALL CLR_P1
					MOV P1_stance, STNDS
					DRAW_P1 origin_p1, P1_stance
					JMP P1_KICK			;GO CHECK FOR COLLISION
										
		CHECK_P1_DEF:
			CMP IN_KEY, Q_KEY
			JNE CHECK_P2_R
				CMP P1_stance, CRCH		;If the player is crouching or jumping do not do defense 
				JE MAIN_LOOP_END
				CMP P1_stance, JMPS
				JE MAIN_LOOP_END
					CALL CLR_P1
					MOV P1_stance, DEF	;IMPORTANT FOR THE CLEAR FUNCTION
					DRAW_P1 origin_p1, P1_stance
					JMP MAIN_LOOP_END
					
;--------------------------------------------------------------------------END CHECK PLAYER 1 INPUTS-------------------------------------------------------------

	
;---------------------------------------------------------------------------CHECK PLAYER 2 INPUTS----------------------------------------------------------------
		;Move player 2 right
		CHECK_P2_R:
			CMP IN_KEY, RIGHT_KEY
			JNE CHECK_P2_L
				P2_MOV_RIGHT:
				CMP P2_X, MAX_RIGHT
				JAE DRAW_P2_AGAIN
					CALL CLR_P2
					ADD P2_X, RUN_STEP
					DRAW_P2 origin_p2, P2_stance
					JMP MAIN_LOOP_END
		
		DRAW_P2_AGAIN:								;REDRAWS PLAYER WHEN HE IS AT THE LEFT CORNER (THIS FIXES A BUG WHEN KICKS HAPPEN)
			DRAW_P2 origin_p2, P2_stance
			JMP MAIN_LOOP_END

		
		;MOVE PLAYER 2 LEFT
		CHECK_P2_L:		
			CMP IN_KEY, LEFT_KEY
			JNE CHECK_P2_DN
				P2_MOV_LEFT:
				MOV AX, P1_X
				ADD AX, PLAYERS_DISTANCE
				CMP P2_X, AX
				JBE MAIN_LOOP_END
					CALL CLR_P2
					MOV AX, RUN_STEP					
					SUB P2_X, AX
					DRAW_P2 origin_p2, P2_stance
					JMP MAIN_LOOP_END

		;PLAYER 2 CROUCH
		CHECK_P2_DN:			
			CMP IN_KEY, DOWN_KEY
			JNE CHECK_P2_UP
				CMP P2_stance, JMPS
				JNE CRCH_P2
					CALL CLR_P2	
					MOV P2_Y, START_Y ; ADJUST THE PLAYERS Y COORDINATE THEN CROUCH
					MOV JUMP_COUNTER_UP2, 0
					MOV JUMP_COUNTER_DN2, 0
				;CROUCH
				CRCH_P2:
				CALL CLR_P2
				MOV P2_stance, CRCH		
				DRAW_P2 origin_p2, P2_stance
				JMP MAIN_LOOP_END			
				
		;PLAYER 2 JUMP OR STANDS(IF HE WAS CROUCHING)
		CHECK_P2_UP:
			CMP IN_KEY, UP_KEY
			JNE CHECK_P2_ATCKUP
				CMP P2_stance, CRCH
				JNE P2_JUMP_BEGIN
				
				;P2_UP:
					CALL CLR_P2	
					MOV P2_stance, STNDS
					DRAW_P2 origin_p2, P2_stance
					JMP MAIN_LOOP_END
					
				P2_JUMP_BEGIN:
					CMP P2_stance, JMPS
					JE MAIN_LOOP_END
						MOV JUMP_COUNTER_UP2, 1
						
					P2_JUMP:
						CALL CLR_P2
						MOV AX, RISE_STEP
						SUB P2_Y, AX
						MOV P2_stance, JMPS
						DRAW_P2 origin_p2, P2_stance
						
		;PLAYER2 ATTACK UP
		CHECK_P2_ATCKUP:
			CMP IN_KEY, I_KEY
			JNE CHECK_P2_ATCKFRNT
				CMP P2_stance, CRCH		;If the player is crouching or jumping do not attack
				JE MAIN_LOOP_END
				CMP P2_stance, JMPS
				JE MAIN_LOOP_END
					CALL CLR_P2
					MOV P2_stance, PUNCH_UP	;IMPORTANT FOR THE CLEAR FUNCTION
					DRAW_P2 origin_p2, P2_stance
					MOV CX, PNCH_DELAY
					DELAY_LOOP4:call delay;
					LOOP DELAY_LOOP4
					CALL CLR_P2
					MOV P2_stance, STNDS	
					DRAW_P2 origin_p2, P2_stance
					JMP P2_PNCH_UP			;GO CHECK FOR COLLISION
					
		;PLAYER2 ATTACK FRONT
		CHECK_P2_ATCKFRNT:
			CMP IN_KEY, O_KEY
			JNE CHECK_P2_ATCKDN
				CMP P2_stance, CRCH		;If the player is crouching or jumping do not attack
				JE MAIN_LOOP_END
				CMP P2_stance, JMPS
				JE MAIN_LOOP_END
					CALL CLR_P2
					MOV P2_stance, PUNCH	;IMPORTANT FOR THE CLEAR FUNCTION
					DRAW_P2 origin_p2, P2_stance
					MOV CX, PNCH_DELAY
					DELAY_LOOP5:call delay;
					LOOP DELAY_LOOP5
					CALL CLR_P2
					MOV P2_stance, STNDS	
					DRAW_P2 origin_p2, p2_stance
					JMP P2_PNCH_FRNT			;GO CHECK FOR COLLISION
					
		;PLAYER2 ATTACK DOWN
		CHECK_P2_ATCKDN:
			CMP IN_KEY, P_KEY
			JNE CHECK_P2_DEF
				CMP P2_stance, CRCH		;If the player is crouching or jumping do not attack
				JE MAIN_LOOP_END
				CMP P2_stance, JMPS
				JE MAIN_LOOP_END
					CALL CLR_P2
					MOV P2_stance, KICKS	;IMPORTANT FOR THE CLEAR FUNCTION
					DRAW_P2 origin_p2, P2_stance
					MOV CX, PNCH_DELAY
					DELAY_LOOP6:call delay;
					LOOP DELAY_LOOP6
					CALL CLR_P2
					MOV P2_stance, STNDS	
					DRAW_P2 origin_p2, P2_stance
					JMP P2_KICK		;GO CHECK FOR COLLISION
					
		CHECK_P2_DEF:
			CMP IN_KEY, L_KEY
			JNE CHECK_ESC
				CMP P2_stance, CRCH		;If the player is crouching or jumping do not do defense 
				JE MAIN_LOOP_END
				CMP P2_stance, JMPS
				JE MAIN_LOOP_END
					CALL CLR_P2
					MOV P2_stance, DEF	;IMPORTANT FOR THE CLEAR FUNCTION
					DRAW_P2 origin_p2, P2_stance
					JMP MAIN_LOOP_END
		
;---------------------------------------------------------------------------END CHECK PLAYER 2 INPUTS---------------------------------------------------

;---------------------------------------------------------------------------START P1 COLLISION LOGIC----------------------------------------------------

		P1_PNCH_UP:
			MOV AX, P1_X
			ADD AX, COLLISION_DIST		;IF THE DISTANCE BETWEEN THE 2 PLAYERS IS NOT SUFFICIENT FOR COLLISION NOTHING HAPPENS
			CMP AX, P2_X
			JNE MAIN_LOOP_END
			
				CMP P2_stance, DEF	;IF PLAYER 2 IS DEFENDING --> MOVE BACKWARD WITH NO DAMAGE
				JNE CHK_HEADSHOT_FRM_P1_PNCHUP
					JMP P2_MOV_RIGHT
					JMP MAIN_LOOP_END
					
				CHK_HEADSHOT_FRM_P1_PNCHUP:	
				CMP P2_stance, STNDS	;IF PLAYER 2 IS STANDING --> HEADSHOT
				JNE CHK_BDYSHOT_FRM_P1_PNCHUP
					CALL P2_HEADSHOT
					JMP P2_MOV_RIGHT
					JMP MAIN_LOOP_END
					
				CHK_BDYSHOT_FRM_P1_PNCHUP:
				CMP P2_stance, JMPS		;IF PLAYER 2 IS JUMPING --> BODYSHOT
				JNE MAIN_LOOP_END
					CALL P2_BODYSHOT
					JMP P2_MOV_RIGHT
					JMP MAIN_LOOP_END	;ELSE IF PLAYER 2 IS CROUCHING -> NOTHING HAPPENS
		P1_PNCH_FRNT:
			MOV AX, P1_X
			ADD AX, COLLISION_DIST		;IF THE DISTANCE BETWEEN THE 2 PLAYERS IS NOT SUFFICIENT FOR COLLISION NOTHING HAPPENS
			CMP AX, P2_X
			JNE DRAW_P2_AGAIN 		;MAIN_LOOP_END REPLACING THIS WITH DRAW_P2_AGAIN ->  THIS FIXES A BUG WHEN THE PLAYER IS KICKED PART OF HIM IS CLEARED
			
				CMP P2_stance, DEF	;IF PLAYER 2 IS DEFENDING --> MOVE BACKWARD WITH NO DAMAGE
				JNE CHK_BDYSHOT_FRM_P1_FRNTPNCH
					JMP P2_MOV_RIGHT
					JMP MAIN_LOOP_END
			
				CHK_BDYSHOT_FRM_P1_FRNTPNCH:
				CMP P2_stance, STNDS	;IF PLAYER 2 IS STANDING --> BODYSHOT
				JNE CHK_LEGSHOT_FRM_P1_FRNTPNCH
					CALL P2_BODYSHOT
					JMP P2_MOV_RIGHT
					JMP MAIN_LOOP_END
					
				CHK_LEGSHOT_FRM_P1_FRNTPNCH:
				CMP P2_stance, JMPS		;IF PLAYER 2 IS JUMPING --> LEGSHOT
				JNE DRAW_P2_AGAIN		;MAIN_LOOP_END REPLACING THIS WITH DRAW_P2_AGAIN ->  THIS FIXES A BUG WHEN THE PLAYER IS KICKED PART OF HIM IS CLEARED
					CALL P2_LEGSHOT
					JMP P2_MOV_RIGHT
					JMP MAIN_LOOP_END	;ELSE IF PLAYER 2 IS CROUCHING -> NOTHING HAPPENS
		
		P1_KICK:
			MOV AX, P1_X
			ADD AX, COLLISION_DIST		;IF THE DISTANCE BETWEEN THE 2 PLAYERS IS NOT SUFFICIENT FOR COLLISION NOTHING HAPPENS
			CMP AX, P2_X
			JNE DRAW_P2_AGAIN 		;MAIN_LOOP_END REPLACING THIS WITH DRAW_P2_AGAIN ->  THIS FIXES A BUG WHEN THE PLAYER IS KICKED PART OF HIM IS CLEARED
			
				CMP P2_stance, DEF		;IF PLAYYER 2 IS DEFENDING --> THE KICK WILL MAKE A DAMAGE
				JNE CHK_LEGSHOT_FRM_P1_KICKPNCH
					JMP LEGSHOT_FRM_P1_KICKPNCH
					
				CHK_LEGSHOT_FRM_P1_KICKPNCH:
				CMP P2_stance, STNDS	;IF PLAYER 2 IS STANDING --> LEGSHOT
				JNE CHK_HEADSHOT_FRM_P1_KICKPNCH
					LEGSHOT_FRM_P1_KICKPNCH:
					CALL P2_LEGSHOT
					JMP P2_MOV_RIGHT
					JMP MAIN_LOOP_END
					
				CHK_HEADSHOT_FRM_P1_KICKPNCH:
					CMP P2_stance, CRCH		;IF PLAYER 2 IS CROUCHING --> HEADSHOT
					JNE MAIN_LOOP_END
						CALL P2_HEADSHOT
						JMP P2_MOV_RIGHT
						JMP MAIN_LOOP_END	;ELSE IF PLAYER 2 IS JUMPING -> NOTHING HAPPENS
;-----------------------------------------------------------------------------END P1 COLLISION LOGIC----------------------------------------------------

;-----------------------------------------------------------------------------START P2 COLLISION LOGIC--------------------------------------------------
		P2_PNCH_UP:
			MOV AX, P2_X
			SUB AX, COLLISION_DIST		;IF THE DISTANCE BETWEEN THE 2 PLAYERS IS NOT SUFFICIENT FOR COLLISION NOTHING HAPPENS
			CMP AX, P1_X
			JNE MAIN_LOOP_END
				
				CMP P1_stance, DEF	;IF PLAYER 2 IS DEFENDING --> MOVE BACKWARD WITH NO DAMAGE
				JNE CHK_HEADSHOT_FRM_P2_PNCHUP
					JMP P1_MOV_LEFT
					JMP MAIN_LOOP_END
					
				CHK_HEADSHOT_FRM_P2_PNCHUP:	
				CMP P1_stance, STNDS	;IF PLAYER 1 IS STANDING --> HEADSHOT
				JNE CHK_BDYSHOT_FRM_P2_PNCHUP
					CALL P1_HEADSHOT
					JMP P1_MOV_LEFT
					JMP MAIN_LOOP_END
				CHK_BDYSHOT_FRM_P2_PNCHUP:
				CMP P1_stance, JMPS		;IF PLAYER 1 IS JUMPING --> BODYSHOT
				JNE MAIN_LOOP_END
					CALL P1_BODYSHOT
					JMP MAIN_LOOP_END	;ELSE IF PLAYER 1 IS CROUCHING -> NOTHING HAPPENS
		
		P2_PNCH_FRNT:
			MOV AX, P2_X
			SUB AX, COLLISION_DIST		;IF THE DISTANCE BETWEEN THE 2 PLAYERS IS NOT SUFFICIENT FOR COLLISION NOTHING HAPPENS
			CMP AX, P1_X
			JNE DRAW_P1_AGAIN ;MAIN_LOOP_END REPLACING THIS WITH DRAW_P1_AGAIN ->  THIS FIXES A BUG WHEN THE PLAYER IS KICKED PART OF HIM IS CLEARED
				
				CMP P1_stance, DEF	;IF PLAYER 2 IS DEFENDING --> MOVE BACKWARD WITH NO DAMAGE
				JNE CHK_BDYSHOT_FRM_P2_FRNTPNCH
					JMP P1_MOV_LEFT
					JMP MAIN_LOOP_END
					
				CHK_BDYSHOT_FRM_P2_FRNTPNCH:
				CMP P1_stance, STNDS	;IF PLAYER 1 IS STANDING --> BODYSHOT
				JNE CHK_LEGSHOT_FRM_P2_FRNTPNCH
					CALL P1_BODYSHOT
					JMP P1_MOV_LEFT
					JMP MAIN_LOOP_END
					
				CHK_LEGSHOT_FRM_P2_FRNTPNCH:
				CMP P1_stance, JMPS		;IF PLAYER 1 IS JUMPING --> LEGSHOT
				JNE DRAW_P1_AGAIN 		;MAIN_LOOP_END REPLACING THIS WITH DRAW_P1_AGAIN ->  THIS FIXES A BUG WHEN THE PLAYER IS KICKED PART OF HIM IS CLEARED
					CALL P1_LEGSHOT
					JMP P1_MOV_LEFT
					JMP MAIN_LOOP_END	;ELSE IF PLAYER 1 IS CROUCHING -> NOTHING HAPPENS
		
		P2_KICK:
			MOV AX, P2_X
			SUB AX, COLLISION_DIST		;IF THE DISTANCE BETWEEN THE 2 PLAYERS IS NOT SUFFICIENT FOR COLLISION NOTHING HAPPENS
			CMP AX, P1_X
			JNE DRAW_P1_AGAIN 		;MAIN_LOOP_END REPLACING THIS WITH DRAW_P1_AGAIN ->  THIS FIXES A BUG WHEN THE PLAYER IS KICKED PART OF HIM IS CLEARED
				
				CMP P1_stance, DEF	;IF PLAYER 2 IS DEFENDING --> THE KICK WILL MAKE A DAMAGE
				JNE CHK_LEGSHOT_FRM_P2_KICKPNCH
					JMP LEGSHOT_FRM_P2_KICKPNCH
			
				CHK_LEGSHOT_FRM_P2_KICKPNCH:
				CMP P1_stance, STNDS	;IF PLAYER 1 IS STANDING --> LEGSHOT
				JNE CHK_HEADSHOT_FRM_P2_KICKPNCH
					LEGSHOT_FRM_P2_KICKPNCH:
					CALL P1_LEGSHOT
					JMP P1_MOV_LEFT
					JMP MAIN_LOOP_END
					
				CHK_HEADSHOT_FRM_P2_KICKPNCH:
				CMP P1_stance, CRCH		;IF PLAYER 1 IS CROUCHING --> HEADSHOT
				JNE MAIN_LOOP_END
					CALL P1_HEADSHOT
					JMP P1_MOV_LEFT
					JMP MAIN_LOOP_END	;ELSE IF PLAYER 1 IS JUMPING -> NOTHING HAPPENS
;-----------------------------------------------------------------------------END P2 COLLISION LOGIC----------------------------------------------------




;--------------------------------------------------------------------------------EXIT-------------------------------------------------------------------
		CHECK_ESC:                                                                                                                                
			CMP IN_KEY, ESC_KEY                                                                                                                  
			JZ EXIT_BY_ESC                                                                                                                               
;--------------------------------------------------------------------------------EXIT-------------------------------------------------------------------


;------------------------------------------------------------------------------END MAIN LOOP------------------------------------------------------------
		MAIN_LOOP_END:	
			;CALL DELAY

        MOV AX, GAME_OVER
        CMP AX, 0
	    JE  MAIN_LOOP       ; NO ONE LOST HIS HP YET

        ; A PLAYER LOST ALL HIS HP
        CMP AX, 2
        JE  PLAYER2_WON            ; PLAYER 2 WON
        ; PLAYER 1 WON
        MOV BX, PLAYER2_HEARTS
        CMP BX, 1
        JE  PLAYER1_WON_FINAL
        DEC PLAYER2_HEARTS
        DRAW_P2_HEARTS PLAYER2_HEARTS
        MOV BX, MAX_HP
        MOV PLAYER2_HP, BX
        CALL DRAW_HP_BAR2
        MOV AX, 0
        MOV GAME_OVER, AX
        JMP MAIN_LOOP

TIME_OUT:
		MOV AX, PLAYER1_HEARTS
		CMP AX, PLAYER2_HEARTS
		JA PLAYER1_WON_FINAL
		JB PLAYER2_WON_FINAL
		MOV AX, PLAYER1_HP
		CMP AX, PLAYER2_HP
		JA PLAYER1_WON_FINAL
		JB PLAYER2_WON_FINAL
		; BUT FIRST CLEAR SCREEN JUST TO LOOK COOL
        MOV AX, 4F02H
	    MOV BX, 105H			
	    INT 10H

		MOV BX, 0
		MOV AH, 2
		MOV DX, 1532H
		INT 10H

        MOV AH, 9
        LEA DX, DRAW_MES
        INT 21H
        JMP EXIT

PLAYER2_WON:
        ; PLAYER 2 WON
        MOV BX, PLAYER1_HEARTS
        CMP BX, 1
        JE  PLAYER2_WON_FINAL
        DEC PLAYER1_HEARTS
        DRAW_P1_HEARTS PLAYER1_HEARTS
        MOV BX, MAX_HP
        MOV PLAYER1_HP, BX
        CALL DRAW_HP_BAR1
        MOV AX, 0
        MOV GAME_OVER, AX
        JMP MAIN_LOOP

PLAYER1_WON_FINAL:
        ; BUT FIRST CLEAR SCREEN JUST TO LOOK COOL
        MOV AX, 4F02H
	    MOV BX, 105H			
	    INT 10H

        LEA SI, HP_BAR_PLAYER1_NAME
        LEA DI, PLAYER1_WON_MES
        MOV CX, 15
        REP MOVSB

		MOV AL, ' '
		MOV [DI], AL

		INC DI
        MOV AL, 'W'
        MOV [DI], AL

        INC DI
        MOV AL, 'o'
        MOV [DI], AL

        INC DI
        MOV AL, 'n'
        MOV [DI], AL

        INC DI
        MOV AL, '!'
        MOV [DI], AL

		MOV BX, 0
		MOV AH, 2
		MOV DX, 1532H
		INT 10H

        MOV AH, 9
        LEA DX, PLAYER1_WON_MES
        INT 21H
        
        JMP EXIT

PLAYER2_WON_FINAL:
        ; BUT FIRST CLEAR SCREEN JUST TO LOOK COOL
        MOV AX, 4F02H
	    MOV BX, 105H			
	    INT 10H

        LEA SI, HP_BAR_PLAYER2_NAME
        LEA DI, PLAYER2_WON_MES
        MOV CX, 15
        REP MOVSB

		MOV AL, ' '
		MOV [DI], AL

		INC DI
        MOV AL, 'W'
        MOV [DI], AL

        INC DI
        MOV AL, 'o'
        MOV [DI], AL

        INC DI
        MOV AL, 'n'
        MOV [DI], AL

        INC DI
        MOV AL, '!'
        MOV [DI], AL

		LEA SI, PLAYER2_WON_MES
		MOV CX, 16
CLEANING_WIN_MESS:
		MOV AL, [SI]
		CMP AL, '$'
		JNE CLEAN_WORD_WIN
		MOV AL, ' '
		MOV [SI], AL
		CLEAN_WORD_WIN:
			INC SI
			LOOP CLEANING_WIN_MESS

		MOV BX, 0
		MOV AH, 2
		MOV DX, 1532H
		INT 10H

        MOV AH, 9
        LEA DX, PLAYER2_WON_MES
        INT 21H
        
        JMP EXIT

EXIT_BY_ESC:
        ; BUT FIRST CLEAR SCREEN JUST TO LOOK COOL
        MOV AX, 4F02H
	    MOV BX, 105H			
	    INT 10H

EXIT:
	;Press Enter key to exit
    ; move cursor

	MOV BX, 0
	MOV AH, 2
	MOV DX, 1729H
	INT 10H

    ;PRESS ENTER TO CONTINUE
    MOV AH, 9
    LEA DX, END_GAME_MES
    INT 21H

EXIT_ENTER_LOOP:
	MOV AH , 0
	INT 16h
    CMP AH, 1CH
    JNE EXIT_ENTER_LOOP
    JMP RETURN_TO_MAIN_MENU
QUIT_GAME:      ; EXIT WITH ERROR LEVEL 0
        ; BUT FIRST CLEAR SCREEN JUST TO LOOK COOL
        MOV AX, 4F02H
	    MOV BX, 105H			
	    INT 10H

        MOV AX, 4C00H
        INT 21H
MAIN ENDP

;NOTE!: THIS PROC USES AX AND ZERO FLAG
;RETURNS AH: SCANCODE, AL: ASCII, CLEARS ZERO FLAG IF THERE EXIST A KEY PRESSED
GET_KEY_PRESSED PROC NEAR 
	MOV AH,1
	INT 16H
	RET
GET_KEY_PRESSED	ENDP
;--------------------------------------------------------------------------
; CLEARS KEYBOARD BUFFER
;--------------------------------------------------------------------------
CLEARKEYBOARDBUFFER		PROC	NEAR
	PUSH		AX
	PUSH		ES
	MOV		AX, 0000H
	MOV		ES, AX
	MOV		ES:[041AH], 041EH
	MOV		ES:[041CH], 041EH				; CLEARS KEYBOARD BUFFER
	POP		ES
	POP		AX
	RET
CLEARKEYBOARDBUFFER		ENDP

DELAY PROC NEAR
	
	MOV AX, 003H
	DELAY1_8SEC_DELAY_8:
		PUSH AX
		MOV AX, 0D090H
	DELAY1_8SEC_DELAY_9:
		DEC AX
		JNZ DELAY1_8SEC_DELAY_9
		POP AX
		DEC AX
		JNZ DELAY1_8SEC_DELAY_8
	RET
DELAY ENDP


CLR_P1 PROC NEAR
	PUSHA
	
	MOV Emsa7, 1
		DRAW_P1 origin_p1 p1_stance
	MOV Emsa7, 0
	
	POPA
	RET
CLR_P1 ENDP

CLR_P2 PROC NEAR
	PUSHA
	
	MOV Emsa7, 1
		DRAW_P2 origin_p2 p2_stance
	MOV Emsa7, 0
	
	POPA
	RET
CLR_P2 ENDP



;-----------------------------------------------------START P1 ATTACKS PROCEDURES---------------------------------------------------------------

P1_HEADSHOT     PROC    NEAR

        MOV AX, PLAYER1_HP

        CMP AX, DMG_HEADSHOT
        JBE PLAYER1_LOST_HEAD

        SUB AX, DMG_HEADSHOT
        MOV PLAYER1_HP, AX

        CALL DRAW_HP_BAR1
        RET
        PLAYER1_LOST_HEAD:
                MOV AX, 0
                MOV PLAYER1_HP, AX
                MOV AX, 2
                MOV GAME_OVER, AX
                CALL DRAW_HP_BAR1
                RET
P1_HEADSHOT     ENDP


P1_BODYSHOT     PROC    NEAR

        MOV AX, PLAYER1_HP

        CMP AX, DMG_BODYSHOT
        JBE PLAYER1_LOST_BODY

        SUB AX, DMG_BODYSHOT
        MOV PLAYER1_HP, AX

        CALL DRAW_HP_BAR1
        RET
        PLAYER1_LOST_BODY:
                MOV AX, 0
                MOV PLAYER1_HP, AX
                MOV AX, 2
                MOV GAME_OVER, AX
                CALL DRAW_HP_BAR1
                RET
P1_BODYSHOT     ENDP

P1_LEGSHOT     PROC    NEAR

        MOV AX, PLAYER1_HP

        CMP AX, DMG_LEGSHOT
        JBE PLAYER1_LOST_LEG

        SUB AX, DMG_LEGSHOT
        MOV PLAYER1_HP, AX

        CALL DRAW_HP_BAR1
        RET

        PLAYER1_LOST_LEG:
                MOV AX, 0
                MOV PLAYER1_HP, AX
                MOV AX, 2
                MOV GAME_OVER, AX
                CALL DRAW_HP_BAR1
                RET
P1_LEGSHOT     ENDP
;-----------------------------------------------------END P1 ATTACKS PROCEDURES-----------------------------------------------------------------

;----------------------------------------------------START P2 ATTACKS PROCEDURES----------------------------------------------------------------


P2_HEADSHOT     PROC    NEAR

        MOV AX, PLAYER2_HP

        CMP AX, DMG_HEADSHOT
        JBE PLAYER2_LOST_HEAD

        SUB AX, DMG_HEADSHOT
        MOV PLAYER2_HP, AX

        CALL DRAW_HP_BAR2
        RET
        PLAYER2_LOST_HEAD:
                MOV AX, 0
                MOV PLAYER2_HP, AX
                MOV AX, 1
                MOV GAME_OVER, AX
                CALL DRAW_HP_BAR2
                RET
P2_HEADSHOT     ENDP


P2_BODYSHOT     PROC    NEAR

        MOV AX, PLAYER2_HP

        CMP AX, DMG_BODYSHOT
        JBE PLAYER2_LOST_BODY

        SUB AX, DMG_BODYSHOT
        MOV PLAYER2_HP, AX

        CALL DRAW_HP_BAR2
        RET
        PLAYER2_LOST_BODY:
                MOV AX, 0
                MOV PLAYER2_HP, AX
                MOV AX, 1
                MOV GAME_OVER, AX
                CALL DRAW_HP_BAR2
                RET
P2_BODYSHOT     ENDP

P2_LEGSHOT     PROC    NEAR

        MOV AX, PLAYER2_HP

        CMP AX, DMG_LEGSHOT
        JBE PLAYER2_LOST_LEG

        SUB AX, DMG_LEGSHOT
        MOV PLAYER2_HP, AX

        CALL DRAW_HP_BAR2
        RET
        PLAYER2_LOST_LEG:
                MOV AX, 0
                MOV PLAYER2_HP, AX
                MOV AX, 1
                MOV GAME_OVER, AX
                CALL DRAW_HP_BAR2
                RET
P2_LEGSHOT     ENDP


;----------------------------------------------------END P2 ATTACKS PROCEDURES-----------------------------------------------------------------


;-------------------------------------------------------BODY DRAWING'S CODE--------------------------------------------------------------------------
ersem proc near
                                                                   
	STANCE_CHK_CRCH:       
		CMP STANCE, CRCH
		JNE STANCE_CHK_STNDS
			CALL WA7EDM2AMBAR 
			RET
		 
	STANCE_CHK_STNDS:
		CMP STANCE, STNDS
		JNE STANCE_CHK_PUNCH
			CALL WA7EDEDOGAMBO
			RET
		
	STANCE_CHK_PUNCH:
		CMP STANCE, PUNCH
		JNE STANCE_CHK_PUNCH_UP
			CALL WA7EDBEYEDRAB
			RET
			
	STANCE_CHK_PUNCH_UP:
		CMP STANCE, PUNCH_UP
		JNE STANCE_CHK_KICK
			CALL WA7EDBEYEDRABFO2
			RET
			
	STANCE_CHK_KICK:
		CMP STANCE, KICKS
		JNE STANCE_CHK_JMPS
			CALL WA7EDBEYKICK
			RET

	STANCE_CHK_JMPS:
		CMP STANCE, JMPS
		JNE STANCE_CHK_DEFENSE
			CALL WA7EDEDOGAMBO
			RET
			
	STANCE_CHK_DEFENSE:
		CMP STANCE, DEF
		JNE GO_OUT
			CALL WA7ED
			
	GO_OUT:	RET
ersem endp    

Background proc near
        
        lea bx,orientate
        mov byte ptr[bx],1
        
        lea si,GroundXY
        lea di,GroundEnd   
        mov bx,word ptr[si+2]
        mov word ptr[di],bx
        mov bx,groundHeight
        add word ptr[di],ScreenEndCol
        mov al,GroundClr  
        
    GndLoop:
        
        mov cx,[si+2]     ;Column
        mov dx,[si]       ;Row
        call draw    
        inc word ptr[si]
        dec bx
        jnz GndLoop
        
        sub word ptr[si],GroundHeight
        mov bx,GroundStart
        mov al,BackGndClr
         
    BackGndLoop:
        
        mov cx,[si+2]     ;Column
        mov dx,[si]       ;Row
        call draw    
        dec word ptr[si]
        dec bx
        jnz BackGndLoop   
    
   ret
    
 Background ENDP 


DrawHearts proc near
        
        
        mov orientate,1
        
        mov bx,P1P2Hearts
        cmp bx,player1   
        
        jz  plr1
        
        lea si,P2HeartsXY
        lea di,P2HeartsEnd 
        mov bx,word ptr[si+2]
        mov word ptr[di],bx
       
        mov bx,P2HeartsLeft
        
        jmp HeartsLoop
  
  plr1: lea si,P1HeartsXY
        lea di,P1HeartsEnd 
        mov bx,word ptr[si+2]
        mov word ptr[di],bx
       
        mov bx,P1HeartsLeft
        
    HeartsLoop:   
    
        push bx
        push word ptr[si+2]
        push word ptr[di]
        mov bx,emsa7Hearts 
        cmp bx,1
        jz to6  
        mov al,HeartsClr
        jmp eo6
   to6: mov al,BackGndClr 
    
   eo6:
        mov bx,HeartsHeight/2
        
        LowHeartLoop:
        
            mov cx,[si+2]     ;Column
            mov dx,[si]       ;Row
            
            call draw    
            dec word ptr[si]
            dec word ptr[si+2]
            inc word ptr[di]
            
            dec bx
            jnz LowHeartLoop
            
        mov bx,word ptr[di]
        add bx,word ptr[si+2]
        mov dx,0
        mov ax,bx
        mov bx,2
        div bx
        mov bx,ax 
        push word ptr[di]                 ;storing endpoint for second half
        mov word ptr[di],bx               ;Calculating Midpoint And Storing it
        push bx                           ;It will be starting point for 2nd half
		
		mov bx,emsa7Hearts 
        cmp bx,1
        jz tq6  
        mov al,HeartsClr
        jmp eq6
   tq6: mov al,BackGndClr 
    
   eq6:
        mov bx,HeartsHeight/4
            
         
        LeftTopHeartLoop:
        
            mov cx,[si+2]     ;Column
            mov dx,[si]       ;Row 
            
            call draw                           ;Top Half of Heart
            dec word ptr[si]                      
            inc word ptr[si+2]
            dec word ptr[di]
            dec bx
            
            jnz LeftTopHeartLoop 
        
        add word ptr[si],HeartsHeight/4
        pop word ptr[si+2]
        pop word ptr[di]
         
        mov bx,emsa7Hearts 
        cmp bx,1
        jz te6  
        mov al,HeartsClr
        jmp er6
   te6: mov al,BackGndClr 
    
   er6:
        mov bx,HeartsHeight/4
             
            
        RightTopHeartLoop:
        
            mov cx,[si+2]     ;Column
            mov dx,[si]       ;Row
            call draw                           ;Top Half of Heart
            dec word ptr[si]                      
            inc word ptr[si+2]
            dec word ptr[di]
            dec bx
            
            jnz RightTopHeartLoop    
        
        pop word ptr[di]
        pop word ptr[si+2]    
        
        add word ptr[si],HeartsHeight*3/4
        
        mov bx,P1P2Hearts
        cmp bx,Player1
        jz  ply1
        sub word ptr[si+2],HeartsHeight*2
        sub word ptr[di],HeartsHeight*2
        jmp fti 
        
  ply1: add word ptr[si+2],HeartsHeight*2
        add word ptr[di],HeartsHeight*2 
        
   fti: pop bx
        dec bx
        
        jnz HeartsLoop
    
   ret
     
 DrawHearts ENDP

ras proc near
    
        lea si,startxy
        mov word ptr[si],280
        mov word ptr[si+2],600      ;ras tayra malhash lazma
        call head
        mov al,p1hairClr 
        call gazma 
        call EYE 
     ret
ras endp       

wa7ed proc near
            
        mov bx,orientate 
        cmp bx,player1
        jz p1  
        
        lea si,startXY2 
        lea di,endy2
        mov bx,emsa7 
        cmp bx,1
        jz tp4  
        mov al,p2gazmaclr 
        
        jmp fen
   tp4: mov al,BackGndClr 
        jmp fen
        
   p1:  lea si,startXY 
        lea di,endy
        mov bx,emsa7 
        cmp bx,1
        jz tq4  
        mov al,p1gazmaclr
        jmp eqi
   tq4: mov al,BackGndClr 
    
   eqi:
         
        mov bx,[si+2]
        mov [di],bx  ;ba7ot fih el starting origin w ba3d kda hazawwed tool kol 7aga
         
  fen:  
        call gazma
        call body
        
        mov bx,[si+2]           ;;gamda 
        push bx                 ;;fash5
        
        call arm 
        
        pop bx                  ;;law
        mov [si+2],bx           ;;etshaloo 
        
        call head 
        
        
        cmp orientate,player1
        jz p11  
        
        mov bx,emsa7 
        cmp bx,1
        jz ti4  
        mov al,p2hairclr 
        
        jmp pen
   ti4: mov al,BackGndClr 
        jmp pen
        
   p11: 
        mov bx,emsa7 
        cmp bx,1
        jz wr4  
        mov al,p1hairclr
        jmp pen
   wr4: mov al,BackGndClr 
    
   pen:
   
        call gazma 
        call EYE
        ret
        
wa7ed    endp


wa7ededogambo proc near
            
        mov bx,orientate 
        cmp bx,player1
        jz pot  
        
        lea si,startXY2 
        lea di,endy2
        mov bx,emsa7 
        cmp bx,1
        jz tu4  
        mov al,p2gazmaclr
        jmp jen 
        
   tu4: mov al,BackGndClr 
        jmp jen
        
   pot: lea si,startXY 
        lea di,endy
        
        cmp emsa7,1
        jz tr4  
        mov al,p1gazmaclr
        jmp eqri
   tr4: mov al,BackGndClr 
    
   eqri:
        
        mov bx,[si+2]
        mov [di],bx  ;ba7ot fih el starting origin w ba3d kda hazawwed tool kol 7aga
         
   jen: 
        call gazma
        call body
                
        push [si+2]          ;;gamda fash5
        
        call armgamboo 
        
        pop [si+2]           ;;law etshaloo 
        
        call head 
         
        cmp orientate,player1
        jz p17  
        
        mov bx,emsa7 
        cmp bx,1
        jz ti7  
        mov al,p2hairclr 
        jmp pon
   ti7: mov al,BackGndClr 
        jmp pon
        
   p17: 
        mov bx,emsa7 
        cmp bx,1
        jz wp4  
        mov al,p1hairclr
        jmp pon
   wp4: mov al,BackGndClr 
    
   pon:
        call gazma 
        call EYE
        ret
        
wa7ededogambo    endp

wa7edbeykick proc near
            
        mov bx,orientate 
        cmp bx,player1
        jz p08  
        
        lea si,startXY2 
        lea di,endy2
        mov bx,emsa7 
        cmp bx,1
        jz ru4  
        mov al,p2gazmaclr
        jmp fen2 
        
   ru4: mov al,BackGndClr 
        jmp fen2
        
   p08: lea si,startXY 
        lea di,endy
        
        mov bx,emsa7 
        cmp bx,1
        jz wt4  
        mov al,p1gazmaclr
        jmp wti
   wt4: mov al,BackGndClr 
    
   wti:
        mov bx,[si+2]
        mov [di],bx  ;ba7ot fih el starting origin w ba3d kda hazawwed tool kol 7aga
         
 fen2:  
        call gazma
        call body
        call kick  
        
        push [si+2]         
        
        call arm
        
        pop [si+2]                   
        
        call head 
        
         
        cmp orientate,player1
        jz p10  
        
        mov bx,emsa7 
        cmp bx,1
        jz te0  
        mov al,p2hairclr 
        
        jmp uen
   te0: mov al,BackGndClr 
        jmp uen
        
   p10: 
        mov bx,emsa7 
        cmp bx,1
        jz w44  
        mov al,p1hairclr
        jmp uen
   w44: mov al,BackGndClr 
    
   uen:
   
        call gazma 
        call EYE
        ret
        
wa7edbeykick    endp

wa7edbeyedrab proc near
            
        mov bx,orientate 
        cmp bx,player1
        jz p4  
        
        lea si,startXY2 
        lea di,endy2  
        mov bx,emsa7 
        cmp bx,1
        jz to4  
        mov al,p2gazmaclr
        jmp col 
        
   to4: mov al,BackGndClr
        jmp col
        
   p4:  lea si,startXY 
        lea di,endy 
        
        mov bx,emsa7 
        cmp bx,1
        jz lu3  
        mov al,p1gazmaclr
        jmp col 
        
   lu3: mov al,BackGndClr 
        ;jmp col
         
        ;mov bx,[si+2]
        ;mov [di],bx  ;ba7ot fih el starting origin w ba3d kda hazawwed tool kol 7aga
         
 
  col:  call gazma
          
        sub word ptr[si],torsoheight
        sub word ptr[si],reglheight
        
        push [si+2]          ;;gamda fash5
        
        call arm
        
        pop [si+2]           ;;law etshaloo   
        
        add word ptr[si],torsoheight
        add word ptr[si],reglheight
        call body
        call starm                              
                                            
        call head 
        
        
        cmp orientate,player1
        jz i17  
        
        mov bx,emsa7 
        cmp bx,1
        jz t17  
        mov al,p2hairclr 
        
        jmp upn
   t17: mov al,BackGndClr 
        jmp upn
        
   i17: 
        mov bx,emsa7 
        cmp bx,1
        jz ep4  
        mov al,p1hairclr
        jmp upn
   ep4: mov al,BackGndClr 
    
   upn:
   
        call gazma 
        call EYE
        ret
        
wa7edbeyedrab    endp

wa7edbeyedrabfo2 proc near
            
        mov bx,orientate 
        cmp bx,player1
        jz p5  
        
        lea si,startXY2 
        lea di,endy2
        mov bx,emsa7 
        cmp bx,1
        jz wr0  
        mov al,p2gazmaclr
        jmp feq
   wr0: mov al,BackGndClr 

        jmp feq
        
   p5:  lea si,startXY 
        lea di,endy
        
        mov bx,emsa7 
        cmp bx,1
        jz tr0  
        mov al,p1gazmaclr
        jmp feq
   tr0: mov al,BackGndClr 
         
        mov bx,[si+2]
        mov [di],bx  ;ba7ot fih el starting origin w ba3d kda hazawwed tool kol 7aga
         
 feq:   
        call gazma
          
        sub word ptr[si],torsoheight
        sub word ptr[si],reglheight
        
        push [si+2]         
        
        call arm 
        
        pop [si+2]                    
        
        add word ptr[si],torsoheight
        add word ptr[si],reglheight
        call body

        call head          
           
        cmp orientate,player1
        jz i97  
 
        cmp emsa7,1
        jz tu7  
        mov al,p2hairclr 
        
        jmp upe
   tu7: mov al,BackGndClr 
        jmp upe
        
   i97: 
        cmp emsa7,1
        jz ep7  
        mov al,p1hairclr
        jmp upe
   ep7: mov al,BackGndClr 
    
   upe:
   
        call gazma 
        call EYE
        
        add word ptr[si],headheight+neckheight 
        
        call starmfo2
        ret
        
wa7edbeyedrabfo2    endp

wa7edm2ambar proc near
            
        cmp orientate,player1
        jz p2  
        
        lea si,startXY2 
        lea di,endy2
         
        cmp emsa7,1
        jz weu  
        mov al,p2gazmaclr
        jmp wati
   weu: mov al,BackGndClr 
        jmp wati
        
   p2:  lea si,startXY 
        lea di,endy 
 
        cmp emsa7,1
        jz weq  
        mov al,p1gazmaclr
        jmp wati 
        
   weq: mov al,BackGndClr 
    
   wati:
 
        mov bx,[si+2]
        mov [di],bx  ;ba7ot fih el starting origin w ba3d kda hazawwed tool kol 7aga

        call gazma
        call crouch 
        
        push [si+2]          ;;gamda fash5
        
        call arm 
        
        pop [si+2]           ;;law etshaloo 
        
        call head  
        
        cmp orientate,player1
        jz i19  
        
        mov bx,emsa7 
        cmp bx,1
        jz t19  
        mov al,p2hairclr 
        
        jmp upp
   t19: mov al,BackGndClr 
        jmp upp
        
   i19: 
        mov bx,emsa7 
        cmp bx,1
        jz ee4  
        mov al,p1hairclr
        jmp upp
   ee4: mov al,BackGndClr 
    
   upp:
   
        call gazma 
        call EYE
        ret
        
wa7edm2ambar    endp
                     
                     
wa7edm2ambarbeyedrab proc near
            
        cmp orientate,player1
        jz p2t  
        
        lea si,startXY2 
        lea di,endy2
         
        cmp emsa7,1
        jz weut  
        mov al,p2gazmaclr
        jmp watit
   weut:mov al,BackGndClr 
        jmp watit
        
   p2t: lea si,startXY 
        lea di,endy 
 
        cmp emsa7,1
        jz weqt  
        mov al,p1gazmaclr
        jmp watit 
        
   weqt:mov al,BackGndClr 
    
   watit:
 
        mov bx,[si+2]
        mov [di],bx  ;ba7ot fih el starting origin w ba3d kda hazawwed tool kol 7aga

        call gazma
        call crouch 
        
        push [si+2]          ;;gamda fash5
        
        call arm 
        
        pop [si+2]           ;;law etshaloo 
        call starm
        call head  
        
        cmp orientate,player1
        jz i1t  
        
        mov bx,emsa7 
        cmp bx,1
        jz t1t  
        mov al,p2hairclr 
        
        jmp uppt
   t1t: mov al,BackGndClr 
        jmp uppt
        
   i1t: 
        mov bx,emsa7 
        cmp bx,1
        jz ee4t  
        mov al,p1hairclr
        jmp uppt
   ee4t:mov al,BackGndClr 
    
   uppt:
   
        call gazma 
        call EYE
        ret
        
wa7edm2ambarbeyedrab    endp

gazma proc near
        
        mov bx,[si+2]
        MOV [di],bx 
        mov bx,orientate
        cmp bx,player1
        jz  f
        sub word ptr[di],gazmawidth
        mov bx,nosgazmaheight
        jmp loop1
        
   f:   add word ptr[di],gazmawidth
        mov bx,nosgazmaheight 
        
loop1:  
        mov dx,[si]     ;Row
        mov cx,[si]+2   ;Column 
        call draw 

        dec word ptr [si] 
        
        push bx
        mov bx,orientate
        cmp bx,player1
        jz i
        pop bx
        dec word ptr [di]
        dec bx 
        jnz loop1
        jmp t
         
  i:    pop bx
        inc word ptr [di]   ;to increment endY (ba3mel curve el gazma)
        dec bx
        jnz loop1 
        
        
    t:  mov bx,[si+2]
        MOV [di],bx   
        mov bx,orientate
        cmp bx,player1
        jz  d
        
        sub word ptr[di],gazmawidth
        mov bx,nosgazmaheight
        jmp loop2
        
   d:   add word ptr[di],gazmawidth
        mov bx,nosgazmaheight   

loop2:
        mov dx,[si]      ;Row
        mov cx,[si]+2    ;Column 
        call draw
        dec word ptr [si] 
        push bx
        mov bx,orientate
        cmp bx,player1
        jz j
        pop bx
        inc word ptr [di]
        dec bx 
        jnz loop2 
        ret
         
  j:    pop bx
        dec word ptr [di]   ;to increment endY (ba3mel curve el gazma)
        dec bx
        jnz loop2
ret       

gazma endp  

gazma_ma2looba proc near
        
        push [si]
        push [si+2]     
        
        add word ptr[si],reglwidth  
        
        cmp orientate,player1
        jz  ou
        sub word ptr[si+2],kickreglheight-2 
        
        cmp emsa7,1
        jz p50  
        mov al,p2gazmaclr
        jmp dez     
        
   p50: mov al,BackGndClr 
        jmp dez
        
   ou:  add word ptr[si+2],kickreglheight-2  
   
        cmp emsa7,1
        jz p54  
        mov al,p1gazmaclr
        jmp dez
        
   p54: mov al,BackGndClr 
           
   dez: 
        mov bx,[si]
        MOV [di],bx  
           
        mov bx,orientate
        cmp bx,player1
        jz  yu
        sub word ptr[si+2],nosgazmaheight*2
        jmp dey
        
   yu:  add word ptr[si+2],nosgazmaheight*2
   
   dey: sub word ptr[di],gazmawidth
        mov bx,nosgazmaheight
        

loopg:  
        mov dx,[si]     ;Row
        mov cx,[si]+2   ;Column 
        call drawvert 
        
        dec word ptr [di]
        
        push bx
        mov bx,orientate
        cmp bx,player1
        jz iu     
        
        pop bx
        inc word ptr [si+2]
        dec bx 
        jnz loopg
        
        jmp tu
         
   iu:  pop bx 
        dec word ptr [si+2]
        dec bx
        jnz loopg 
        
        
   tu:  mov bx,[si]
        MOV [di],bx  
         
        sub word ptr[di],gazmawidth
        mov bx,nosgazmaheight   

loopu:
        mov dx,[si]     ;Row
        mov cx,[si]+2   ;Column 
        call drawvert 
        
        inc word ptr [di]
        
        push bx
        mov bx,orientate
        cmp bx,player1
        jz ju
        pop bx
        
        inc word ptr [si+2]
        
        dec bx 
        jnz loopu
        jmp ru
         
   ju:  pop bx 
        dec word ptr [si+2]
        dec bx
        jnz loopu 
        
   ru:  pop [si+2]
        pop [si]
ret       

gazma_ma2looba endp


body proc near       
    
        mov bx,[si+2]
        MOV [di],bx                   ;I add the width to starting Y-Coordinate
        cmp orientate,player1
        jz  g
        sub word ptr[di],reglwidth
        mov bx,reglheight
        
        cmp emsa7,1
        jz p5l  
        mov al,p2reglclr
        jmp regl
   p5l: mov al,BackGndClr 
        jmp regl
        
   g:   add word ptr[di],reglwidth
        mov bx,reglheight
        cmp emsa7,1
        jz p57  
        mov al,p1reglclr
        jmp regl
   p57: mov al,BackGndClr 

 regl:
        mov cx,[si+2]         ;Column 
        mov dx,[si]       ;Row        
        push bx
        
        call draw
        
        pop bx
        dec word ptr [si] 
        dec bx
        jnz regl
        
        mov bx,[si+2]
        MOV [di],bx
        mov bx,orientate
        cmp bx,player1
        jz  p
        sub word ptr[di],reglwidth
        mov bx,torsoheight*3/4
        jmp torso
        
   p:   add word ptr[di],reglwidth
        mov bx,torsoheight*3/4 
         
        
 torso:
        mov cx,[si+2]         ;Column 
        mov dx,[si]           ;Row
        
        push bx    
             
        cmp orientate,player1
        jz  gop 
        
        cmp emsa7,1
        jz ppl  
        mov al,p2torsoclr
        jmp kit
   ppl: mov al,BackGndClr 
        jmp kit
        
   gop:  
        cmp emsa7,1
        jz p5i  
        mov al,p1torsoclr
        jmp kit
   p5i: mov al,BackGndClr 
    
   kit:
        call draw
        dec word ptr [si]
        pop bx  
        push bx 
        mov ah,0
        mov al,bl
        mov bl,precisionTorso
        div bl 
        pop bx
        cmp ah,0
        jnz ta7t    
        push bx
        mov bx,orientate
        cmp bx,player1
        jz y  
        pop bx
        dec word ptr [di]  
        jmp ta7t
  
      
  y:    pop bx
        inc word ptr [di] 
 
 ta7t:  dec bx
        jnz torso  
        
        mov bx,torsoheight*1/4
        
 torso3:
        mov cx,[si+2]         ;Column 
        mov dx,[si]           ;Row
        push bx  
               
        cmp orientate,player1
        jz  gor 
        
        cmp emsa7,1
        jz bpl  
        mov al,p2torsoclr
        jmp kiw
   bpl: mov al,BackGndClr 
        jmp kiw
        
   gor:  
        cmp emsa7,1
        jz pei  
        mov al,p1torsoclr
        jmp kiw
   pei: mov al,BackGndClr
    
   kiw:
        call draw 
        pop bx
        dec word ptr [si]  
        push bx 
        mov ah,0
        mov al,bl
        mov bl,precisionTorso2
        div bl 
        pop bx
        cmp ah,0
        jnz ta7t3    
        push bx
        mov bx,orientate
        cmp bx,player1
        jz tri  
        pop bx
        inc word ptr [di]  
        jmp ta7t3
  
      
  tri:    pop bx
        dec word ptr [di] 
 
 ta7t3:  dec bx
        jnz torso3
                    
                    
        
        ret
 body endp

arm proc near 
    
        cmp orientate,player1
        jz  gwr5 
        
        cmp emsa7,1
        jz btl5  
        mov al,p2torsoclr
        jmp kip5
   btl5:mov al,BackGndClr 

        
   gwr5:  
        cmp emsa7,1
        jz pri5  
        mov al,p1torsoclr
        jmp kip5
   pri5: mov al,BackGndClr

   kip5:
        mov bx,[si+2]
        MOV [di],bx
        mov bx,orientate
        cmp bx,player1
        jz  h5
        sub word ptr[di],armheight
        mov bx,armwidth/4
                         
        jmp armlp5         
                         
   h5:  add word ptr[di],armheight
        mov bx,armwidth/4
        
 armlp5:
        mov cx,[si+2]         ;Column 
        mov dx,[si]       ;Row
         
        call draw
        inc word ptr [si]
        push bx
         
        mov bx,orientate
        cmp bx,player1
        jz  zed5    
        
        
        dec word ptr[di]
        dec word ptr[si+2]
        jmp lol5         
                         
  zed5: inc word ptr[di]
        inc word ptr[si+2]

        
  lol5:  pop bx
        dec bx
        jnz armlp5
        
        cmp orientate,player1
        jz  gwr 
        
        cmp emsa7,1
        jz btl  
        mov al,p2armclr
        jmp kip
   btl: mov al,BackGndClr 

        
   gwr:  
        cmp emsa7,1
        jz pri  
        mov al,p1armclr
        jmp kip
   pri: mov al,BackGndClr

   kip:
        mov bx,[si+2]
        MOV [di],bx
        mov bx,orientate
        cmp bx,player1
        jz  h
        sub word ptr[di],armheight
        mov bx,armwidth/4
                         
        jmp armlp         
                         
   h:   add word ptr[di],armheight
        mov bx,armwidth/4
        
 armlp:
        mov cx,[si+2]         ;Column 
        mov dx,[si]       ;Row
         
        call draw
        inc word ptr [si]
        push bx
         
        mov bx,orientate
        cmp bx,player1
        jz  zed    
        
        
        dec word ptr[di]
        dec word ptr[si+2]
        jmp lol         
                         
  zed:  inc word ptr[di]
        inc word ptr[si+2]

        
  lol:  pop bx
        dec bx
        jnz armlp       
        
        mov bx,armwidth/2
        
 armlp2:
        mov cx,[si+2]         ;Column 
        mov dx,[si]       ;Row
        
        call draw
        dec word ptr [si]
        push bx
         
        mov bx,orientate
        cmp bx,player1
        jz  zed2
        dec word ptr[di]
        dec word ptr[si+2]
        jmp lol2         
                         
  zed2: inc word ptr[di]
        inc word ptr[si+2]

        
  lol2: pop bx
        dec bx
        jnz armlp2
        ret
 arm endp  


starm proc near  
        
        sub word ptr[si],armheight*3/4
        push [si]
        add word ptr[si],armheight*3/4
        push [si+2]  
        
        cmp orientate,player1
        jz  gpr 
        
        cmp emsa7,1
        jz bol  
        mov al,p2armclr
        jmp kr
   bol: mov al,BackGndClr 
        jmp kr
        
   gpr:  
        cmp emsa7,1
        jz ppi  
        mov al,p1armclr
        jmp kr
   ppi: mov al,BackGndClr
    
   kr:
        mov bx,[si+2]
        MOV [di],bx 
        mov bx,orientate
        cmp bx,player1
        jz  he
        sub word ptr[di],armwidthpunch
        mov bx,armheight*3/4
                         
        jmp armlop         
                         
   he:  add word ptr[di],armwidthpunch
        mov bx,armheight*3/4
        
 armlop:
        mov cx,[si+2]         ;Column 
        mov dx,[si]       ;Row
        
        call draw
        dec word ptr [si]
        dec bx
        jnz armlop 
        
        add word ptr[si],armheight*3/4    
        
        ;------------------------Adding Nos Com------------------
        
        cmp orientate,player1
        jz  gpr3 
        
        cmp emsa7,1
        jz bol3  
        mov al,p2torsoclr
        jmp kr3
   bol3: mov al,BackGndClr 
        jmp kr3
        
   gpr3:  
        cmp emsa7,1
        jz ppi3  
        mov al,p1torsoclr
        jmp kr3
   ppi3:mov al,BackGndClr
    
   kr3:
        mov bx,[si+2]
        MOV [di],bx 
        mov bx,orientate
        cmp bx,player1
        jz  he3
        sub word ptr[di],armwidthpunch/4
        mov bx,armheight*3/4
                         
        jmp armlop3         
                         
   he3: add word ptr[di],armwidthpunch/4
        mov bx,armheight*3/4
        
 armlop3:
        mov cx,[si+2]     ;Column 
        mov dx,[si]       ;Row
        
        call draw
        dec word ptr [si]
        dec bx
        jnz armlop3 
        ;-------------------Nos Com----------------------   
        
        add word ptr[si],armheight*3/4
        
        cmp orientate,player1
        jz  gpr8 
        
        cmp emsa7,1
        jz bol8  
        mov al,p2armclr
        jmp kr8
   bol8: mov al,BackGndClr 
        jmp kr8
        
   gpr8:  
        cmp emsa7,1
        jz ppi8  
        mov al,p1armclr
        jmp kr8
   ppi8: mov al,BackGndClr
    
   kr8:
        cmp orientate,player1
        jz  her                                       ;To draw box
        
        
        sub word ptr[si+2],armwidthpunch-boxwidth/2  
        mov bx,[si+2]
        MOV [di],bx
        sub word ptr[di],boxwidth
        mov bx,armheight*3/4+knucklesheight              
        jmp boxlop1         
                         
   her: add word ptr[si+2],armwidthpunch-boxwidth/2  
        mov bx,[si+2]
        MOV [di],bx
        add word ptr[di],boxwidth
        mov bx,armheight*3/4+knucklesheight  
        
  boxlop1:
        mov cx,[si+2]         ;Column 
        mov dx,[si]           ;Row
        
        call draw
        dec word ptr [si] 
        push bx
        mov bx,orientate
        cmp bx,player1
        jz  herg  
        dec word ptr[si+2] 
        jmp ddt
        
 herg:  inc word ptr[si+2]
 ddt:   pop bx
        dec bx
        jnz boxlop1
            
        add word ptr[si],knucklesheight              ;to get to normal arm height
        
        add word ptr[si],armheight*3/4+fingerwidth   ;to get to fingers below
        
        mov bx,[di]
        mov [si+2],bx
         
        mov bx,orientate
        cmp bx,player1
        jz  herw  
        add word ptr[si+2],fingerwidth*2 
        jmp reyo 
        
 herw:  sub word ptr[si+2],fingerwidth*2
  
        
 reyo:  mov bx,fingerwidth
                           
        
  boxlop2:
        mov cx,[si+2]         ;Column 
        mov dx,[si]           ;Row
        
        call draw
        dec word ptr [si] 
        
        dec bx
        jnz boxlop2 
       
        mov bx,orientate
        cmp bx,player1
        jz  herq  
        sub word ptr[si+2],fingerwidth 
        jmp reyr                              
        
 herq:  add word ptr[si+2],fingerwidth
  
        
 reyr:  mov bx,armheight*5/4-fingerwidth
        
 boxlop3:
        mov cx,[si+2]         ;Column 
        mov dx,[si]           ;Row
        
        call draw
        dec word ptr [si] 
        
        dec bx
        jnz boxlop3
                       
        pop [si+2]
        pop [si]
                 
        ret  
        
 starm endp
        
        
 Kick proc near
        
        push word ptr[si]
        add word ptr[si],torsoheight+reglwidth
        
        cmp orientate,player1
        jz  qor 
        
        cmp emsa7,1
        jz byl  
        mov al,p2reglclr
        jmp ti
   byl: mov al,BackGndClr 
        jmp ti
        
   qor:  
        cmp emsa7,1
        jz pyi  
        mov al,p1reglclr
        jmp ti
   pyi: mov al,BackGndClr
    
   ti:   
        mov bx,[si+2]
        MOV [di],bx
        mov bx,orientate
        cmp bx,player1
        jz  pol
        sub word ptr[di],kickreglheight
        mov bx,reglwidth
                         
        jmp kickloop         
                         
   pol: add word ptr[di],kickreglheight
        mov bx,reglwidth
        
 kickloop:
 
        mov cx,[si+2]         ;Column 
        mov dx,[si]           ;Row
        
        call draw
        dec word ptr [si]
       
        dec bx
        jnz kickloop
        
        call gazma_ma2looba  
        
        pop word ptr[si] 
        ret
        
  Kick Endp      


starmfo2 proc near      
        
        push [si]
        push [si+2]    
        
        cmp orientate,player1
        jz  glr 
        
        cmp emsa7,1
        jz bkl  
        mov al,p2torsoclr
        jmp qi
   bkl: mov al,BackGndClr 
        jmp qi
        
   glr:  
        cmp emsa7,1
        jz yei  
        mov al,p1torsoclr
        jmp qi
   yei: mov al,BackGndClr

   qi:
        mov bx,word ptr[si+2]                
        mov word ptr[di],bx  
                
        mov bx,orientate
        cmp bx,player1
        jz  heo
        sub word ptr[di],neckwidth         
        jmp fre         
                         
   heo: add word ptr[di],neckwidth
                            
   fre:  
        mov bx,armheight*3/4 
        
  ketfloop:
        mov cx,[si+2]      ;Column 
        mov dx,[si]        ;Row
        
        call draw
        dec word ptr [si]
        dec bx
        jnz ketfloop 
        
        
        push[si+2]
        add word ptr[si],armheight*3/4
                  
        mov bx,[si+2]
        MOV [di],bx 
         
        cmp orientate,player1
        jz  gl2r 
        
        cmp emsa7,1
        jz bk2l  
        mov al,p2armclr
        jmp q2i
   bk2l:mov al,BackGndClr 
        jmp q2i
        
   gl2r:  
        cmp emsa7,1
        jz ye2i  
        mov al,p1armclr
        jmp q2i
   ye2i:mov al,BackGndClr

   q2i:
        cmp orientate,player1
        jz  hew
        sub word ptr[di],armheight*5/2
        mov bx,armwidthpunchfo2/3
                         
        jmp armlopy         
                         
   hew: add word ptr[di],armheight*5/2
        mov bx,armwidthpunchfo2/3
        
 armlopy:
        mov cx,[si+2]         ;Column 
        mov dx,[si]       ;Row
        
        call draw
        dec word ptr [si]
        push bx
         
        mov bx,orientate
        cmp bx,player1
        jz  zed3
        sub word ptr[di],4
        sub word ptr[si+2],4
        jmp lol3         
                         
  zed3: add word ptr[di],4
        add word ptr[si+2],4

        
  lol3: pop bx
        dec bx
        jnz armlopy
        
        ;---------------Nos Com------------------
        
        mov ax,word ptr[si+2]
        pop[si+2]
        push ax
        push[si]
        add word ptr[si],armwidthpunchfo2/3
        
        cmp orientate,player1
        jz  glr0 
        
        cmp emsa7,1
        jz bkl0  
        mov al,p2torsoclr
        jmp qi0
   bkl0:mov al,BackGndClr 
        jmp qi0
        
   glr0:  
        cmp emsa7,1
        jz yei0  
        mov al,p1torsoclr
        jmp qi0
   yei0:mov al,BackGndClr

   qi0:          
        mov bx,[si+2]
        MOV [di],bx
        cmp orientate,player1
        jz  hew0
        sub word ptr[di],armheight*5/2
        mov bx,armwidthpunchfo2/10
                         
        jmp armlopy0         
                         
   hew0:add word ptr[di],armheight*5/2
        mov bx,armwidthpunchfo2/10
        
 armlopy0:
        mov cx,[si+2]         ;Column 
        mov dx,[si]       ;Row
        
        call draw
        dec word ptr [si]
        push bx
         
        mov bx,orientate
        cmp bx,player1
        jz  zed30
        sub word ptr[di],4
        sub word ptr[si+2],4
        jmp lol30         
                         
  zed30: add word ptr[di],4
        add word ptr[si+2],4

        
  lol30: pop bx
        dec bx
        jnz armlopy0  
        
        ;-------------------------Nos COM-----------------------
        
        pop[si]                      ;Keeping coordinates right
        pop[si+2]
        mov bx,word ptr[si+2]                
        mov word ptr[di],bx  
        
        cmp orientate,player1
        jz  gl0r 
        
        cmp emsa7,1
        jz bk0l  
        mov al,p2armclr
        jmp q0i
   bk0l:mov al,BackGndClr 
        jmp q0i
        
   gl0r:  
        cmp emsa7,1
        jz ye0i  
        mov al,p1armclr
        jmp q0i
   ye0i:mov al,BackGndClr

   q0i:
           
        mov bx,orientate
        cmp bx,player1
        jz  hee                                       ;To draw box
 
        mov bx,[si+2]
        MOV [di],bx
        sub word ptr[di],boxwidth
        mov bx,armheight*3/4+knucklesheight              
                         
        jmp boxlop6         
                         
   hee: 
        mov bx,[si+2]
        MOV [di],bx
        add word ptr[di],boxwidth
        mov bx,armheight*3/4+knucklesheight  
        
  boxlop6:
        mov cx,[si+2]         ;Column 
        mov dx,[si]           ;Row
        
        call draw
        dec word ptr [si] 
        push bx
        mov bx,orientate
        cmp bx,player1
        jz  heel  
        dec word ptr[si+2] 
        jmp ddp
        
 heel:  inc word ptr[si+2]
  ddp:  pop bx
        dec bx
        jnz boxlop6
            
        add word ptr[si],knucklesheight              ;to get to normal arm height
        
        add word ptr[si],armheight*3/4+fingerwidth   ;to get to fingers below
        
        mov bx,[di]
        mov [si+2],bx
         
        mov bx,orientate
        cmp bx,player1
        jz  hero  
        add word ptr[si+2],fingerwidth*2 
        jmp raps 
        
 hero:  sub word ptr[si+2],fingerwidth*2
  
        
 raps:  mov bx,fingerwidth
                           
        
  boxlop8:
        mov cx,[si+2]         ;Column 
        mov dx,[si]           ;Row
        
        call draw
        dec word ptr [si] 
        
        dec bx
        jnz boxlop8 
       
        mov bx,orientate
        cmp bx,player1
        jz  herp  
        sub word ptr[si+2],fingerwidth 
        jmp reyp                              
        
 herp:  add word ptr[si+2],fingerwidth
  
        
 reyp:  mov bx,armheight*5/4-fingerwidth
        
 boxlop0:
        mov cx,[si+2]         ;Column 
        mov dx,[si]           ;Row
        
        call draw
        dec word ptr [si] 
        
        dec bx
        jnz boxlop0
        
        pop [si+2]
        pop [si]          
        ret  
        
 starmfo2 endp


head proc near
        
        mov bx,emsa7   
        
        cmp orientate,player1
        jz  lip 
        
        cmp emsa7,1
        jz kop  
        mov al,p2skinclr
        jmp ui
   kop: mov al,BackGndClr 
        jmp ui
        
   lip:  
        cmp emsa7,1
        jz dpe  
        mov al,p1skinclr
        jmp ui
   dpe: mov al,BackGndClr

   ui:
        mov bx,[si+2]
        MOV [di],bx    

        cmp orientate,player1
        jz  q
        sub word ptr[di],neckwidth
        mov bx,neckheight
        
        jmp neck
        
   q:   add word ptr[di],neckwidth
        mov bx,neckheight
 neck:
        mov cx,[si]+2         ;Column 
        mov dx,[si]       ;Row   
        
       
        call draw
        dec word ptr [si] 
        dec bx
        jnz neck
        
        mov bx,[si+2]
        MOV [di],bx   
        
        cmp orientate,player1
        jz  w
        sub word ptr[di],headwidth
        mov bx,headheight
        
        jmp headlp
        
   w:   add word ptr[di],headwidth
        mov bx,headheight
 headlp:
        mov cx,[si]+2         ;Column 
        mov dx,[si]       ;Row 
       
        call draw
        dec word ptr [si]
        dec bx
        jnz headlp
        ret
 head endp 

Eye Proc Near 
    
     mov bx,2*nosgazmaheight
     add bx,headheight/4
     add word ptr[si],bx
    
     mov bx,[si+2]
     MOV [di],bx    
     
     mov bx,orientate
     cmp bx,player1
     jz  fert
     sub word ptr[di],eyewidth+headwidth*3/4
     sub word ptr[si+2],headwidth*3/4  
     
     mov bx,emsa7 
        cmp bx,1
        jz e54  
        mov al,SPEyeClr
        jmp ei
   e54: mov al,BackGndClr 
    
   ei:
     mov bx,eyeheight
     
     jmp eyeLp
     
fert:
     add word ptr[di],eyewidth+headwidth*3/4 
     add word ptr[si+2],headwidth*3/4
     mov bx,emsa7 
        cmp bx,1
        jz j54  
        mov al,FPEyeClr
        jmp eji
   j54: mov al,BackGndClr 
    
   eji:
     mov bx,eyeheight
     
eyeLp:
     mov cx,[si]+2         ;Column 
     mov dx,[si]       ;Row   
     
     
     call draw
     dec word ptr [si] 
     dec bx 
     
     jnz eyeLp 
     
     mov bx,orientate
     cmp bx,player1
     jz  ferg
     
     add word ptr[si+2],headwidth*3/4 
     
     ret
     
ferg:
     
     sub word ptr[si+2],headwidth*3/4
   
    ret 
    
Eye endp    
              
              
Crouch proc near       
        
        mov bx,[si+2]
        MOV [di],bx 
        
        cmp orientate,player1
        jz zx
        sub word ptr[di],reglwidth

        mov bx,emsa7 
        cmp bx,1
        jz r24  
        mov al,p2reglclr 
        mov bx,reglheight/2-25 
        jmp regl1        
        
   r24: mov al,BackGndClr
        mov bx,reglheight/2-25 
        jmp regl1 
    
  zx:   add word ptr[di],reglwidth      ;I add the width to starting Y-Coordinate

        mov bx,emsa7 
        cmp bx,1
        jz r54  
        mov al,p1reglclr
        mov bx,reglheight/2-25
        jmp regl1 
        
   r54: mov al,BackGndClr 
        mov bx,reglheight/2-25
 regl1: 
        mov cx,[si+2]         ;Column 
        mov dx,[si]       ;Row
        
        call draw
        dec word ptr [si] 
        push bx
        mov bx,orientate
        cmp bx,player1
        jz jk
        pop bx    
        
        dec word ptr [si+2]
        dec word ptr[di] 
        dec bx
        jnz regl1  
        
        add word ptr [si+2],7
        mov bx,reglheight/2-25
        jmp regl2
  
 jk:    pop bx
        inc word ptr [si+2]
        inc word ptr[di]  
        dec bx
        jnz regl1
        
        
        sub word ptr [si+2],5                             
        mov bx,reglheight/2-25  
        
 regl2: 
        
        mov cx,[si+2]      ;Column 
        mov dx,[si]      ;Row
        
        call draw
        dec word ptr [si]    
        
        push bx
        mov bx,orientate
        cmp bx,player1
        jz ji
        pop bx 
        inc word ptr [si+2]
        inc word ptr[di]  
        dec bx
        jnz regl2              
        
        sub word ptr [si+2],2
        mov bx,[si+2]
        MOV [di],bx
        sub word ptr[di],reglwidth/2+torsowidth/2    ;I add the width to starting Y-Coordinate
        mov bx,torsoheight*2/3 
        jmp torso2
  
 ji:    pop bx
        
        dec word ptr [si+2]
        dec word ptr[di]  
        dec bx
        jnz regl2
      
        inc word ptr [si+2]
        mov bx,[si+2]
        MOV [di],bx
        add word ptr[di],reglwidth/2+torsowidth/2    ;I add the width to starting Y-Coordinate
        mov bx,torsoheight*2/3   
        

  torso2:
        mov cx,[si+2]         ;Column 
        mov dx,[si]           ;Row
        push bx         
        
        cmp orientate,player1
        jz  gur 
        
        cmp emsa7,1
        jz bul  
        mov al,p2torsoclr
        jmp kuw
   bul: mov al,BackGndClr 
        jmp kuw
        
   gur:  
        cmp emsa7,1
        jz pti  
        mov al,p1torsoclr
        jmp kuw
   pti: mov al,BackGndClr
    
   kuw:
        
        call draw 
        pop bx
        dec word ptr [si]  
        push bx 
        mov ah,0
        mov al,bl
        mov bl,precisionTorso
        div bl 
        pop bx
        cmp ah,0
        jnz ta7t2    
        push bx
        mov bx,orientate
        cmp bx,player1
        jz fab  
        pop bx
        dec word ptr [di]  
        jmp ta7t2
  
      
  fab:  pop bx
        inc word ptr [di] 
 
 ta7t2: dec bx
        jnz torso2  
        
        mov bx,torsoheight*1/4
        
 torso4:
        mov cx,[si+2]         ;Column 
        mov dx,[si]           ;Row
        push bx         
        
        cmp orientate,player1
        jz  kul 
        
        cmp emsa7,1
        jz bpu  
        mov al,p2torsoclr
        jmp lri
   bpu: mov al,BackGndClr 
        jmp lri
        
   kul:  
        cmp emsa7,1
        jz oli  
        mov al,p1torsoclr
        jmp lri
   oli: mov al,BackGndClr

   lri:
        call draw 
        pop bx
        dec word ptr [si]  
        push bx 
        mov ah,0
        mov al,bl
        mov bl,precisionTorso2
        div bl 
        pop bx
        cmp ah,0
        jnz ta7t4    
        push bx
        mov bx,orientate
        cmp bx,player1
        jz trid  
        pop bx
        inc word ptr [di]  
        jmp ta7t4
  
      
  trid: pop bx
        dec word ptr [di] 
 
 ta7t4: dec bx
        jnz torso4
        
        ret       
        
crouch endp 

armgamboo proc near       
        
        
        ;----------------------NOS COM---------------------
        
        cmp orientate,player1
        jz  grr 
        
        cmp emsa7,1
        jz upl  
        mov al,p2torsoclr
        jmp prw
   upl: mov al,BackGndClr 
        jmp prw
        
   grr:  
        cmp emsa7,1
        jz lki  
        mov al,p1torsoclr
        jmp prw
   lki: mov al,BackGndClr

   prw:
        mov bx,[si+2]
        MOV [di],bx                   ;I add the width to starting Y-Coordinate
        mov bx,orientate
        cmp bx,player1
        jz  git
        sub word ptr[di],armheight
        mov bx,armgamboowidth/4
        
        jmp dra3
        
   git: add word ptr[di],armheight
        mov bx,armgamboowidth/4
        
 dra3:
        mov cx,[si+2]         ;Column 
        mov dx,[si]       ;Row        
        
        call draw
        
        inc word ptr [si] 
        dec bx
        jnz dra3
        
        ;----------------------NOS COM---------------------
        
        cmp orientate,player1
        jz  grry 
        
        cmp emsa7,1
        jz uply  
        mov al,p2armclr
        jmp prwy
   uply: mov al,BackGndClr 
        jmp prwy
        
   grry:  
        cmp emsa7,1
        jz lkiy  
        mov al,p1armclr
        jmp prwy
   lkiy:mov al,BackGndClr

   prwy:
        mov bx,[si+2]
        MOV [di],bx                   ;I add the width to starting Y-Coordinate
        mov bx,orientate
        cmp bx,player1
        jz  gity
        sub word ptr[di],armheight
        mov bx,armgamboowidth*3/4
        
        jmp dra3y
        
   gity:add word ptr[di],armheight
        mov bx,armgamboowidth*3/4
        
 dra3y:
        mov cx,[si+2]         ;Column 
        mov dx,[si]       ;Row        
        
        call draw
        
        inc word ptr [si] 
        dec bx
        jnz dra3y 
        
        sub word ptr[si],armgamboowidth
        
        
    ret   
    
armgamboo endp        
        
           
draw proc near 
           
           push bx 
           mov bx,orientate
           mov ah,0ch       ;Draw Pixel Command 
    back:  
           int 10h  
           cmp bx,player1    
           jz ymeen
           
           dec cx      
           cmp cx,[di]        
           JA back 
           pop bx
           ret  
           
    ymeen: 
           inc cx      
           cmp cx,[di]        
           JB back  
           
           pop bx
           ret
draw endp



drawvert proc near 
           
           push bx 
           mov ah,0ch       ;Draw Pixel Command 
    back2:  
           int 10h  
           dec dx      
           cmp dx,[di]        
           JA back2  
           
           pop bx
           ret
drawvert endp
;----------------------------------------------------------------------END BODY DRAWING CODE-------------------------------------------------------------------

;------------------------------------------------------Entry Screen-------------------------------------------------------------------------------------
ENTRY_SCREEN	PROC NEAR
		
		; Activate Video mode
		MOV AX, 4F02H
		MOV BX, 105H
		INT 10H
		
		; Call procedures here

		CALL SFIRST
		CALL SSECOND
		CALL STHIRD
		CALL SFOURTH
		CALL SFIFTH
		CALL GFIRST
		CALL GSECOND
		CALL GTHIRD
		CALL GFOURTH
		CALL GFIFTH
		CALL XFIRST
		CALL XSECOND
		
		MOV AL, 0
		
ENTRY_SCREEN_LOOP:
		CALL STRTP1
		CALL STRTR1
		CALL STRTE1
		CALL STRTS1
		CALL STRTS2
		CALL STRTA1
		CALL STRTN1
		CALL STRTY1
		CALL STRTK1
		CALL STRTE2
		CALL STRTY2
		CALL STRTT1
		CALL STRTO1
		CALL STRTS3
		CALL STRTT2
		CALL STRTA2
		CALL STRTR2
		CALL STRTT3
		
		INC AL
		
		CALL DELAY1_8SEC
		
		MOV AH,1
		INT 16H
		JZ ENTRY_SCREEN_LOOP

		MOV AH, 0
		MOV AL, 13H
		INT 10H
		
		RET
ENTRY_SCREEN	ENDP
		
		; Define procedures here	

DELAY1_8SEC   PROC    NEAR
            ; DELAY BY 1/8 SECOND

            MOV CX, 003H
DELAY1_8SEC_DELAY_1: 
            PUSH CX
            MOV CX, 0D090H
DELAY1_8SEC_DELAY_2: 
            DEC CX
            JNZ DELAY1_8SEC_DELAY_2
            POP CX
            DEC CX
            JNZ DELAY1_8SEC_DELAY_1

            RET
DELAY1_8SEC   ENDP
		
SFIRST		PROC	NEAR
		; CONSTANTS THROUGH ENTIRE PROC		CX column, DX row, AL color, AH = 0CH, INT 10H
		MOV AL, 5
		MOV AH, 0CH
		
		; TOP - OF S
		MOV CX, 150
		S_LOOP1_BIG:
			MOV DX, 100
			S_LOOP1_SML:
				INT 10H
				INC DX
				CMP DX, 125
				JNZ S_LOOP1_SML
			INC CX
			CMP CX, 350
			JNZ S_LOOP1_BIG
			
			RET
		
SFIRST		ENDP

SSECOND		PROC	NEAR
		MOV AL, 5
		MOV AH, 0CH
		
		; LEFT | OF S
		MOV CX, 125
		S_LOOP2_BIG:
			MOV DX, 100
			S_LOOP2_SML:
				INT 10H
				INC DX
				CMP DX, 300
				JNZ S_LOOP2_SML
			INC CX
			CMP CX, 150
			JNZ S_LOOP2_BIG
			
			RET
		
SSECOND		ENDP

STHIRD		PROC	NEAR
		MOV AL, 5
		MOV AH, 0CH
		
		; MIDDLE - OF S
		MOV CX, 125
		S_LOOP3_BIG:
			MOV DX, 300
			S_LOOP3_SML:
				INT 10H
				INC DX
				CMP DX, 325
				JNZ S_LOOP3_SML
			INC CX
			CMP CX, 350
			JNZ S_LOOP3_BIG
			
			RET
		
STHIRD		ENDP

SFOURTH		PROC	NEAR
		MOV AL, 5
		MOV AH, 0CH
		
		; LEFT | OF S
		MOV CX, 325
		S_LOOP4_BIG:
			MOV DX, 325
			S_LOOP4_SML:
				INT 10H
				INC DX
				CMP DX, 525
				JNZ S_LOOP4_SML
			INC CX
			CMP CX, 350
			JNZ S_LOOP4_BIG
			
			RET
		
SFOURTH		ENDP

SFIFTH		PROC	NEAR
		MOV AL, 5
		MOV AH, 0CH
		
		; MIDDLE - OF S
		MOV CX, 125
		S_LOOP5_BIG:
			MOV DX, 500
			S_LOOP5_SML:
				INT 10H
				INC DX
				CMP DX, 525
				JNZ S_LOOP5_SML
			INC CX
			CMP CX, 325
			JNZ S_LOOP5_BIG
			
			RET
		
SFIFTH		ENDP

GFIRST		PROC	NEAR

		MOV AL, 10
		MOV AH, 0CH
		
		; TOP - OF G
		MOV CX, 600
		G_LOOP1_BIG:
			MOV DX, 125
			G_LOOP1_SML:
				INT 10H
				INC DX
				CMP DX, 150
				JNZ G_LOOP1_SML
			INC CX
			CMP CX, 925
			JNZ G_LOOP1_BIG
			
			RET

GFIRST		ENDP

GSECOND		PROC	NEAR

		MOV AL, 10
		MOV AH, 0CH
		
		; LEFT | OF G
		MOV CX, 600
		G_LOOP2_BIG:
			MOV DX, 150
			G_LOOP2_SML:
				INT 10H
				INC DX
				CMP DX, 525
				JNZ G_LOOP2_SML
			INC CX
			CMP CX, 625
			JNZ G_LOOP2_BIG
			
			RET

GSECOND		ENDP

GTHIRD		PROC	NEAR

		MOV AL, 10
		MOV AH, 0CH
		
		; BOTTOM _ OF G
		MOV CX, 625
		G_LOOP3_BIG:
			MOV DX, 500
			G_LOOP3_SML:
				INT 10H
				INC DX
				CMP DX, 525
				JNZ G_LOOP3_SML
			INC CX
			CMP CX, 925
			JNZ G_LOOP3_BIG
			
			RET

GTHIRD		ENDP

GFOURTH		PROC	NEAR

		MOV AL, 10
		MOV AH, 0CH
		
		; RIGHT | OF G
		MOV CX, 900
		G_LOOP4_BIG:
			MOV DX, 300
			G_LOOP4_SML:
				INT 10H
				INC DX
				CMP DX, 500
				JNZ G_LOOP4_SML
			INC CX
			CMP CX, 925
			JNZ G_LOOP4_BIG
			
			RET

GFOURTH		ENDP

GFIFTH		PROC	NEAR

		MOV AL, 10
		MOV AH, 0CH
		
		; MIDDLE - OF G
		MOV CX, 725
		G_LOOP5_BIG:
			MOV DX, 300
			G_LOOP5_SML:
				INT 10H
				INC DX
				CMP DX, 325
				JNZ G_LOOP5_SML
			INC CX
			CMP CX, 900
			JNZ G_LOOP5_BIG
			
			RET

GFIFTH		ENDP

XFIRST		PROC	NEAR

		MOV AL, 8
		MOV AH, 0CH
		
		; FIRST STROKE OF X
		MOV BX, 350
		MOV DX, 300
		X_LOOP1_BIG:
			MOV CX, BX
			MOV DI, BX
			ADD DI, 25
			X_LOOP1_SML:
				INT 10H
				INC CX
				CMP CX, DI
				JNZ X_LOOP1_SML
			INC BX	
			INC DX
			CMP DX, 525
			JNZ X_LOOP1_BIG
			
			RET

XFIRST		ENDP

XSECOND		PROC	NEAR

		MOV AL, 8
		MOV AH, 0CH
		
		; SECOND STROKE OF X
		MOV BX, 575
		MOV DX, 300
		X_LOOP2_BIG:
			MOV CX, BX
			MOV DI, BX
			ADD DI, 25
			X_LOOP2_SML:
				INT 10H
				INC CX
				CMP CX, DI
				JNZ X_LOOP2_SML
			DEC BX	
			INC DX
			CMP DX, 525
			JNZ X_LOOP2_BIG
			
			RET

XSECOND		ENDP

STRTP1		PROC	NEAR
		MOV AH, 0CH
		
		; LEFT | OF P
		MOV CX, 130
		P1_LOOP1_BIG:
			MOV DX, 600
			P1_LOOP1_SML:
				INT 10H
				INC DX
				CMP DX, 650
				JNZ P1_LOOP1_SML
			INC CX
			CMP CX, 135
			JNZ P1_LOOP1_BIG
			
		; TOP - OF P
		MOV CX, 135
		P1_LOOP2_BIG:
			MOV DX, 600
			P1_LOOP2_SML:
				INT 10H
				INC DX
				CMP DX, 605
				JNZ P1_LOOP2_SML
			INC CX
			CMP CX, 160
			JNZ P1_LOOP2_BIG
			
		; BOTTOM - OF P
		MOV CX, 135
		P1_LOOP3_BIG:
			MOV DX, 630
			P1_LOOP3_SML:
				INT 10H
				INC DX
				CMP DX, 635
				JNZ P1_LOOP3_SML
			INC CX
			CMP CX, 160
			JNZ P1_LOOP3_BIG
			
		; RIGHT | OF P
		MOV CX, 155
		P1_LOOP4_BIG:
			MOV DX, 605
			P1_LOOP4_SML:
				INT 10H
				INC DX
				CMP DX, 630
				JNZ P1_LOOP4_SML
			INC CX
			CMP CX, 160
			JNZ P1_LOOP4_BIG
			
			RET
			
STRTP1		ENDP

STRTR1		PROC	NEAR
		MOV AH, 0CH
		
		; LEFT | OF R
		MOV CX, 170
		R1_LOOP1_BIG:
			MOV DX, 600
			R1_LOOP1_SML:
				INT 10H
				INC DX
				CMP DX, 650
				JNZ R1_LOOP1_SML
			INC CX
			CMP CX, 175
			JNZ R1_LOOP1_BIG
			
		; TOP - OF R
		MOV CX, 175
		R1_LOOP2_BIG:
			MOV DX, 600
			R1_LOOP2_SML:
				INT 10H
				INC DX
				CMP DX, 605
				JNZ R1_LOOP2_SML
			INC CX
			CMP CX, 200
			JNZ R1_LOOP2_BIG
			
		; RIGHT | OF R
		MOV CX, 195
		R1_LOOP3_BIG:
			MOV DX, 605
			R1_LOOP3_SML:
				INT 10H
				INC DX
				CMP DX, 630
				JNZ R1_LOOP3_SML
			INC CX
			CMP CX, 200
			JNZ R1_LOOP3_BIG
			
		; MIDDLE - OF R
		MOV CX, 175
		R1_LOOP4_BIG:
			MOV DX, 630
			R1_LOOP4_SML:
				INT 10H
				INC DX
				CMP DX, 635
				JNZ R1_LOOP4_SML
			INC CX
			CMP CX, 200
			JNZ R1_LOOP4_BIG
		
		; \ STROKE OF R
		MOV BX, 175
		MOV DX, 635
		R1_LOOP5_BIG:
			MOV CX, BX
			MOV DI, BX
			ADD DI, 5
			R1_LOOP5_SML:
				INT 10H
				INC CX
				CMP CX, DI
				JNZ R1_LOOP5_SML
			INC BX	
			INC DX
			CMP DX, 650
			JNZ R1_LOOP5_BIG
			
			RET
		
STRTR1		ENDP

STRTE1		PROC	NEAR
		MOV AH, 0CH
		
		; LEFT | OF E
		MOV CX, 210
		E1_LOOP1_BIG:
			MOV DX, 600
			E1_LOOP1_SML:
				INT 10H
				INC DX
				CMP DX, 650
				JNZ E1_LOOP1_SML
			INC CX
			CMP CX, 215
			JNZ E1_LOOP1_BIG
			
		; TOP - OF E
		MOV CX, 215
		E1_LOOP2_BIG:
			MOV DX, 600
			E1_LOOP2_SML:
				INT 10H
				INC DX
				CMP DX, 605
				JNZ E1_LOOP2_SML
			INC CX
			CMP CX, 240
			JNZ E1_LOOP2_BIG
			
		; MIDDLE - OF E
		MOV CX, 215
		E1_LOOP3_BIG:
			MOV DX, 622
			E1_LOOP3_SML:
				INT 10H
				INC DX
				CMP DX, 628
				JNZ E1_LOOP3_SML
			INC CX
			CMP CX, 240
			JNZ E1_LOOP3_BIG
			
		; BOT - OF E
		MOV CX, 215
		E1_LOOP4_BIG:
			MOV DX, 645
			E1_LOOP4_SML:
				INT 10H
				INC DX
				CMP DX, 650
				JNZ E1_LOOP4_SML
			INC CX
			CMP CX, 240
			JNZ E1_LOOP4_BIG
			
			RET

STRTE1		ENDP

STRTS1		PROC	NEAR
		MOV AH, 0CH
		
		; TOP - OF S
		MOV CX, 250
		S1_LOOP1_BIG:
			MOV DX, 600
			S1_LOOP1_SML:
				INT 10H
				INC DX
				CMP DX, 605
				JNZ S1_LOOP1_SML
			INC CX
			CMP CX, 280
			JNZ S1_LOOP1_BIG
			
		; MIDDLE - OF S
		MOV CX, 250
		S1_LOOP2_BIG:
			MOV DX, 622
			S1_LOOP2_SML:
				INT 10H
				INC DX
				CMP DX, 628
				JNZ S1_LOOP2_SML
			INC CX
			CMP CX, 280
			JNZ S1_LOOP2_BIG

		; BOT - OF S
		MOV CX, 250
		S1_LOOP3_BIG:
			MOV DX, 645
			S1_LOOP3_SML:
				INT 10H
				INC DX
				CMP DX, 650
				JNZ S1_LOOP3_SML
			INC CX
			CMP CX, 280
			JNZ S1_LOOP3_BIG
			
		; LEFT | OF S
		MOV CX, 250
		S1_LOOP4_BIG:
			MOV DX, 605
			S1_LOOP4_SML:
				INT 10H
				INC DX
				CMP DX, 622
				JNZ S1_LOOP4_SML
			INC CX
			CMP CX, 255
			JNZ S1_LOOP4_BIG
			
		; RIGHT | OF S
		MOV CX, 275
		S1_LOOP5_BIG:
			MOV DX, 628
			S1_LOOP5_SML:
				INT 10H
				INC DX
				CMP DX, 645
				JNZ S1_LOOP5_SML
			INC CX
			CMP CX, 280
			JNZ S1_LOOP5_BIG
			
			RET

STRTS1		ENDP

STRTS2		PROC	NEAR
		MOV AH, 0CH
		
		; TOP - OF S
		MOV CX, 290
		S2_LOOP1_BIG:
			MOV DX, 600
			S2_LOOP1_SML:
				INT 10H
				INC DX
				CMP DX, 605
				JNZ S2_LOOP1_SML
			INC CX
			CMP CX, 320
			JNZ S2_LOOP1_BIG
			
		; MIDDLE - OF S
		MOV CX, 290
		S2_LOOP2_BIG:
			MOV DX, 622
			S2_LOOP2_SML:
				INT 10H
				INC DX
				CMP DX, 628
				JNZ S2_LOOP2_SML
			INC CX
			CMP CX, 320
			JNZ S2_LOOP2_BIG

		; BOT - OF S
		MOV CX, 290
		S2_LOOP3_BIG:
			MOV DX, 645
			S2_LOOP3_SML:
				INT 10H
				INC DX
				CMP DX, 650
				JNZ S2_LOOP3_SML
			INC CX
			CMP CX, 320
			JNZ S2_LOOP3_BIG
			
		; LEFT | OF S
		MOV CX, 290
		S2_LOOP4_BIG:
			MOV DX, 605
			S2_LOOP4_SML:
				INT 10H
				INC DX
				CMP DX, 622
				JNZ S2_LOOP4_SML
			INC CX
			CMP CX, 295
			JNZ S2_LOOP4_BIG
			
		; RIGHT | OF S
		MOV CX, 315
		S2_LOOP5_BIG:
			MOV DX, 628
			S2_LOOP5_SML:
				INT 10H
				INC DX
				CMP DX, 645
				JNZ S2_LOOP5_SML
			INC CX
			CMP CX, 320
			JNZ S2_LOOP5_BIG
			
			RET

STRTS2		ENDP

STRTA1		PROC	NEAR
		MOV AH, 0CH
		
		; LEFT | OF A
		MOV CX, 350
		A1_LOOP1_BIG:
			MOV DX, 600
			A1_LOOP1_SML:
				INT 10H
				INC DX
				CMP DX, 650
				JNZ A1_LOOP1_SML
			INC CX
			CMP CX, 355
			JNZ A1_LOOP1_BIG
			
		; RIGHT | OF A
		MOV CX, 375
		A1_LOOP2_BIG:
			MOV DX, 600
			A1_LOOP2_SML:
				INT 10H
				INC DX
				CMP DX, 650
				JNZ A1_LOOP2_SML
			INC CX
			CMP CX, 380
			JNZ A1_LOOP2_BIG
			
		; TOP - OF A
		MOV CX, 355
		A1_LOOP3_BIG:
			MOV DX, 600
			A1_LOOP3_SML:
				INT 10H
				INC DX
				CMP DX, 605
				JNZ A1_LOOP3_SML
			INC CX
			CMP CX, 375
			JNZ A1_LOOP3_BIG
			
		; BOT - OF A
		MOV CX, 355
		A1_LOOP4_BIG:
			MOV DX, 630
			A1_LOOP4_SML:
				INT 10H
				INC DX
				CMP DX, 635
				JNZ A1_LOOP4_SML
			INC CX
			CMP CX, 375
			JNZ A1_LOOP4_BIG
			
			RET

STRTA1		ENDP

STRTN1		PROC	NEAR
		MOV AH, 0CH
		
		; LEFT | OF N
		MOV CX, 390
		N1_LOOP1_BIG:
			MOV DX, 600
			N1_LOOP1_SML:
				INT 10H
				INC DX
				CMP DX, 650
				JNZ N1_LOOP1_SML
			INC CX
			CMP CX, 395
			JNZ N1_LOOP1_BIG
			
		; RIGHT | OF N
		MOV CX, 420
		N1_LOOP2_BIG:
			MOV DX, 600
			N1_LOOP2_SML:
				INT 10H
				INC DX
				CMP DX, 650
				JNZ N1_LOOP2_SML
			INC CX
			CMP CX, 425
			JNZ N1_LOOP2_BIG
		
		; - OF N
		MOV CX, 395
		N1_LOOP3_BIG:
			MOV DX, 600
			N1_LOOP3_SML:
				INT 10H
				INC DX
				CMP DX, 605
				JNZ N1_LOOP3_SML
			INC CX
			CMP CX, 425
			JNZ N1_LOOP3_BIG
			
			RET

STRTN1		ENDP

STRTY1		PROC	NEAR
		MOV AH, 0CH

		; \ OF Y
		MOV BX, 430
		MOV DX, 600
		Y1_LOOP1_BIG:
			MOV CX, BX
			MOV DI, BX
			ADD DI, 5
			Y1_LOOP1_SML:
				INT 10H
				INC CX
				CMP CX, DI
				JNZ Y1_LOOP1_SML
			INC BX	
			INC DX
			CMP DX, 625
			JNZ Y1_LOOP1_BIG
			
		; | OF Y
		MOV CX, 455
		Y1_LOOP2_BIG:
			MOV DX, 600
			Y1_LOOP2_SML:
				INT 10H
				INC DX
				CMP DX, 650
				JNZ Y1_LOOP2_SML
			INC CX
			CMP CX, 460
			JNZ Y1_LOOP2_BIG
			
			RET

STRTY1		ENDP

STRTK1		PROC	NEAR
		MOV AH, 0CH
		
		; | OF K
		MOV CX, 490
		K1_LOOP1_BIG:
			MOV DX, 600
			K1_LOOP1_SML:
				INT 10H
				INC DX
				CMP DX, 650
				JNZ K1_LOOP1_SML
			INC CX
			CMP CX, 495
			JNZ K1_LOOP1_BIG
			
		; / OF K
		MOV BX, 505
		MOV DX, 610
		K1_LOOP2_BIG:
			MOV CX, BX
			MOV DI, BX
			ADD DI, 5
			K1_LOOP2_SML:
				INT 10H
				INC CX
				CMP CX, DI
				JNZ K1_LOOP2_SML
			DEC BX	
			INC DX
			CMP DX, 625
			JNZ K1_LOOP2_BIG
			
		; \ OF K
		MOV BX, 490
		MOV DX, 625
		K1_LOOP3_BIG:
			MOV CX, BX
			MOV DI, BX
			ADD DI, 5
			K1_LOOP3_SML:
				INT 10H
				INC CX
				CMP CX, DI
				JNZ K1_LOOP3_SML
			INC BX	
			INC DX
			CMP DX, 650
			JNZ K1_LOOP3_BIG
			
			RET

STRTK1		ENDP

STRTE2		PROC	NEAR
		MOV AH, 0CH
		
		; LEFT | OF E
		MOV CX, 520
		E2_LOOP1_BIG:
			MOV DX, 600
			E2_LOOP1_SML:
				INT 10H
				INC DX
				CMP DX, 650
				JNZ E2_LOOP1_SML
			INC CX
			CMP CX, 525
			JNZ E2_LOOP1_BIG
			
		; TOP - OF E
		MOV CX, 525
		E2_LOOP2_BIG:
			MOV DX, 600
			E2_LOOP2_SML:
				INT 10H
				INC DX
				CMP DX, 605
				JNZ E2_LOOP2_SML
			INC CX
			CMP CX, 550
			JNZ E2_LOOP2_BIG
			
		; MIDDLE - OF E
		MOV CX, 525
		E2_LOOP3_BIG:
			MOV DX, 622
			E2_LOOP3_SML:
				INT 10H
				INC DX
				CMP DX, 628
				JNZ E2_LOOP3_SML
			INC CX
			CMP CX, 550
			JNZ E2_LOOP3_BIG
			
		; BOT - OF E
		MOV CX, 525
		E2_LOOP4_BIG:
			MOV DX, 645
			E2_LOOP4_SML:
				INT 10H
				INC DX
				CMP DX, 650
				JNZ E2_LOOP4_SML
			INC CX
			CMP CX, 550
			JNZ E2_LOOP4_BIG
			
			RET
		
STRTE2		ENDP

STRTY2		PROC	NEAR
		MOV AH, 0CH

		; \ OF Y
		MOV BX, 560
		MOV DX, 600
		Y2_LOOP1_BIG:
			MOV CX, BX
			MOV DI, BX
			ADD DI, 5
			Y2_LOOP1_SML:
				INT 10H
				INC CX
				CMP CX, DI
				JNZ Y2_LOOP1_SML
			INC BX	
			INC DX
			CMP DX, 625
			JNZ Y2_LOOP1_BIG
			
		; | OF Y
		MOV CX, 585
		Y2_LOOP2_BIG:
			MOV DX, 600
			Y2_LOOP2_SML:
				INT 10H
				INC DX
				CMP DX, 650
				JNZ Y2_LOOP2_SML
			INC CX
			CMP CX, 590
			JNZ Y2_LOOP2_BIG
			
			RET
			
STRTY2		ENDP

STRTT1		PROC	NEAR
		MOV AH, 0CH
		
		; - OF T
		MOV CX, 620
		T1_LOOP1_BIG:
			MOV DX, 600
			T1_LOOP1_SML:
				INT 10H
				INC DX
				CMP DX, 605
				JNZ T1_LOOP1_SML
			INC CX
			CMP CX, 650
			JNZ T1_LOOP1_BIG
		
		; | OF T
		MOV CX, 632
		T1_LOOP2_BIG:
			MOV DX, 605
			T1_LOOP2_SML:
				INT 10H
				INC DX
				CMP DX, 650
				JNZ T1_LOOP2_SML
			INC CX
			CMP CX, 638
			JNZ T1_LOOP2_BIG
			
			RET
		
STRTT1		ENDP

STRTO1		PROC	NEAR
		MOV AH, 0CH
		
		; TOP - OF O
		MOV CX, 660
		O1_LOOP1_BIG:
			MOV DX, 600
			O1_LOOP1_SML:
				INT 10H
				INC DX
				CMP DX, 605
				JNZ O1_LOOP1_SML
			INC CX
			CMP CX, 690
			JNZ O1_LOOP1_BIG
			
		; BOT - OF O
		MOV CX, 660
		O1_LOOP2_BIG:
			MOV DX, 645
			O1_LOOP2_SML:
				INT 10H
				INC DX
				CMP DX, 650
				JNZ O1_LOOP2_SML
			INC CX
			CMP CX, 690
			JNZ O1_LOOP2_BIG
			
		; LEFT | OF O
		MOV CX, 660
		O1_LOOP3_BIG:
			MOV DX, 605
			O1_LOOP3_SML:
				INT 10H
				INC DX
				CMP DX, 645
				JNZ O1_LOOP3_SML
			INC CX
			CMP CX, 665
			JNZ O1_LOOP3_BIG
			
		; RIGHT | OF O
		MOV CX, 685
		O1_LOOP4_BIG:
			MOV DX, 605
			O1_LOOP4_SML:
				INT 10H
				INC DX
				CMP DX, 645
				JNZ O1_LOOP4_SML
			INC CX
			CMP CX, 690
			JNZ O1_LOOP4_BIG
			
			RET
			
STRTO1		ENDP

STRTS3		PROC	NEAR
		MOV AH, 0CH
		
		; TOP - OF S
		MOV CX, 720
		S3_LOOP1_BIG:
			MOV DX, 600
			S3_LOOP1_SML:
				INT 10H
				INC DX
				CMP DX, 605
				JNZ S3_LOOP1_SML
			INC CX
			CMP CX, 750
			JNZ S3_LOOP1_BIG
			
		; MIDDLE - OF S
		MOV CX, 720
		S3_LOOP2_BIG:
			MOV DX, 622
			S3_LOOP2_SML:
				INT 10H
				INC DX
				CMP DX, 628
				JNZ S3_LOOP2_SML
			INC CX
			CMP CX, 750
			JNZ S3_LOOP2_BIG

		; BOT - OF S
		MOV CX, 720
		S3_LOOP3_BIG:
			MOV DX, 645
			S3_LOOP3_SML:
				INT 10H
				INC DX
				CMP DX, 650
				JNZ S3_LOOP3_SML
			INC CX
			CMP CX, 750
			JNZ S3_LOOP3_BIG
			
		; LEFT | OF S
		MOV CX, 720
		S3_LOOP4_BIG:
			MOV DX, 605
			S3_LOOP4_SML:
				INT 10H
				INC DX
				CMP DX, 622
				JNZ S3_LOOP4_SML
			INC CX
			CMP CX, 725
			JNZ S3_LOOP4_BIG
			
		; RIGHT | OF S
		MOV CX, 745
		S3_LOOP5_BIG:
			MOV DX, 628
			S3_LOOP5_SML:
				INT 10H
				INC DX
				CMP DX, 645
				JNZ S3_LOOP5_SML
			INC CX
			CMP CX, 750
			JNZ S3_LOOP5_BIG
			
			RET
			
STRTS3		ENDP

STRTT2		PROC	NEAR
		MOV AH, 0CH
		
		; - OF T
		MOV CX, 760
		T2_LOOP1_BIG:
			MOV DX, 600
			T2_LOOP1_SML:
				INT 10H
				INC DX
				CMP DX, 605
				JNZ T2_LOOP1_SML
			INC CX
			CMP CX, 790
			JNZ T2_LOOP1_BIG
		
		; | OF T
		MOV CX, 772
		T2_LOOP2_BIG:
			MOV DX, 605
			T2_LOOP2_SML:
				INT 10H
				INC DX
				CMP DX, 650
				JNZ T2_LOOP2_SML
			INC CX
			CMP CX, 778
			JNZ T2_LOOP2_BIG
			
			RET
			
STRTT2		ENDP

STRTA2		PROC	NEAR
		MOV AH, 0CH
		
		; LEFT | OF A
		MOV CX, 800
		A2_LOOP1_BIG:
			MOV DX, 600
			A2_LOOP1_SML:
				INT 10H
				INC DX
				CMP DX, 650
				JNZ A2_LOOP1_SML
			INC CX
			CMP CX, 805
			JNZ A2_LOOP1_BIG
			
		; RIGHT | OF A
		MOV CX, 825
		A2_LOOP2_BIG:
			MOV DX, 600
			A2_LOOP2_SML:
				INT 10H
				INC DX
				CMP DX, 650
				JNZ A2_LOOP2_SML
			INC CX
			CMP CX, 830
			JNZ A2_LOOP2_BIG
			
		; TOP - OF A
		MOV CX, 805
		A2_LOOP3_BIG:
			MOV DX, 600
			A2_LOOP3_SML:
				INT 10H
				INC DX
				CMP DX, 605
				JNZ A2_LOOP3_SML
			INC CX
			CMP CX, 825
			JNZ A2_LOOP3_BIG
			
		; BOT - OF A
		MOV CX, 805
		A2_LOOP4_BIG:
			MOV DX, 630
			A2_LOOP4_SML:
				INT 10H
				INC DX
				CMP DX, 635
				JNZ A2_LOOP4_SML
			INC CX
			CMP CX, 825
			JNZ A2_LOOP4_BIG
			
			RET
			
STRTA2		ENDP

STRTR2		PROC	NEAR
		MOV AH, 0CH
		
		; LEFT | OF R
		MOV CX, 840
		R2_LOOP1_BIG:
			MOV DX, 600
			R2_LOOP1_SML:
				INT 10H
				INC DX
				CMP DX, 650
				JNZ R2_LOOP1_SML
			INC CX
			CMP CX, 845
			JNZ R2_LOOP1_BIG
			
		; TOP - OF R
		MOV CX, 845
		R2_LOOP2_BIG:
			MOV DX, 600
			R2_LOOP2_SML:
				INT 10H
				INC DX
				CMP DX, 605
				JNZ R2_LOOP2_SML
			INC CX
			CMP CX, 870
			JNZ R2_LOOP2_BIG
			
		; RIGHT | OF R
		MOV CX, 865
		R2_LOOP3_BIG:
			MOV DX, 605
			R2_LOOP3_SML:
				INT 10H
				INC DX
				CMP DX, 630
				JNZ R2_LOOP3_SML
			INC CX
			CMP CX, 870
			JNZ R2_LOOP3_BIG
			
		; MIDDLE - OF R
		MOV CX, 845
		R2_LOOP4_BIG:
			MOV DX, 630
			R2_LOOP4_SML:
				INT 10H
				INC DX
				CMP DX, 635
				JNZ R2_LOOP4_SML
			INC CX
			CMP CX, 870
			JNZ R2_LOOP4_BIG
		
		; \ STROKE OF R
		MOV BX, 845
		MOV DX, 635
		R2_LOOP5_BIG:
			MOV CX, BX
			MOV DI, BX
			ADD DI, 5
			R2_LOOP5_SML:
				INT 10H
				INC CX
				CMP CX, DI
				JNZ R2_LOOP5_SML
			INC BX	
			INC DX
			CMP DX, 650
			JNZ R2_LOOP5_BIG
			
			RET
			
STRTR2		ENDP

STRTT3		PROC	NEAR
		MOV AH, 0CH
		
		; - OF T
		MOV CX, 880
		T3_LOOP1_BIG:
			MOV DX, 600
			T3_LOOP1_SML:
				INT 10H
				INC DX
				CMP DX, 605
				JNZ T3_LOOP1_SML
			INC CX
			CMP CX, 910
			JNZ T3_LOOP1_BIG
		
		; | OF T
		MOV CX, 892
		T3_LOOP2_BIG:
			MOV DX, 605
			T3_LOOP2_SML:
				INT 10H
				INC DX
				CMP DX, 650
				JNZ T3_LOOP2_SML
			INC CX
			CMP CX, 898
			JNZ T3_LOOP2_BIG
			
			RET
STRTT3		ENDP
;-------------------------------------------------------------------------------------------------------------------------------------------------------

;--------------------------------------------------------------User Name----------------------------------------------------------------------------------------
USERNAME    PROC       NEAR

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
		MOV AH, 2
        MOV DL, 40
        MOV DH, 20
        INT 10H
        ;DISPLAY MESSAGE
        MOV AH, 9
        LEA DX, USER_NAME_ENTER_MES
        INT 21H

        ; SECOND DISPLAY PRESS ENTER TO CONTINUE
        ; MOVE CURSOR TO RIGHT LOCATION
        MOV AH, 2
        MOV DL, 50
        MOV DH, 24
        INT 10H
        ; DISPLAY MESSAGE
        MOV AH, 9
        LEA DX, USER_NAME_ENTER_KEY
        INT 21H

        ; MOVE CURSOR TO RIGHT LOCATION
        MOV AH, 2
        MOV DL, 55
        MOV DH, 22
        INT 10H

USER_NAME_LOOP5:
		MOV SI, 0
USER_NAME_LOOP1:     ; GET USER INPUT
        MOV AH, 0
        INT 16H

        ; CHECK IF PRESSED ENTER AND AT LEAST 1 CHARACTER WAS ENTERED THEN MOVE TO MAIN MENU
        CMP AH, 1CH
        JE USER_NAME_LOOP1

USER_NAME_CHECK1:
        ; MAKE SURE IT IS A LETTER or space
        CMP AL, 41H
        JB USER_NAME_LOOP1
        CMP AL, 7AH
        JA USER_NAME_LOOP1
        CMP AL, 5BH
        JB VALID_LETTER1
        CMP AL, 60H
        JA VALID_LETTER1
        JMP USER_NAME_LOOP1

VALID_LETTER1:
        LEA BX, PLAYER1_NAME    ; LOAD VALUE INTO MEMORY
        MOV [BX][SI], AL

        MOV AH, 2                      ; SHOW IT ON SCREEN
        MOV DL, AL
        INT 21H

        INC SI              ; INCREMENT VARIABLE

;------------------------------------------------------------------------------

USER_NAME_LOOP:     ; GET USER INPUT
        MOV AH, 0
        INT 16H

        ; CHECK IF PRESSED ENTER AND AT LEAST 1 CHARACTER WAS ENTERED THEN MOVE TO MAIN MENU
        CMP AH, 1CH
		; HERE EXIT USER NAME ENTRY SCREEN
        JE GO_TO_MAIN_MENU
        ; check it it's backspace then clear a character
USER_NAME_CHECK2:
		CMP AH, 0EH
		JNE USER_NAME_CHECK
		MOV AH, 3H
		MOV BX, 0
		INT 10H
		DEC DL
		MOV BX, 0
		MOV AH, 2
		INT 10H
		MOV AH, 2
		MOV DL, ' '
		INT 21H
		MOV AH, 3H
		MOV BX, 0
		INT 10H
		DEC DL
		MOV BX, 0
		MOV AH, 2
		INT 10H
		CMP DL, 55
		JE USER_NAME_LOOP5
		DEC SI
		JMP USER_NAME_LOOP

USER_NAME_CHECK:
        CMP SI, 15
        JE USER_NAME_LOOP

		; TAKE ANY CHARACTER SINCE IT'S AFTER 1ST ONE EXCEPT A $
		CMP AL, 24H
		JE USER_NAME_LOOP

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

SEND_USERNAME	PROC	NEAR

		; Activate Video mode
		MOV AX, 4F02H
		MOV BX, 105H			; FIRST ACTIVATE VIDEO MODE TO CLEAR SCREEN TO DRAW ON CLEAN GROUND
		INT 10H

        ; Activate TEXT mode
		MOV AX, 0003H
        MOV BX, 0
		INT 13H

        ; FIRST DISPLAY ENTER YOUR NAME
		MOV AH, 2
        MOV DL, 38
        MOV DH, 20
        INT 10H
        ;DISPLAY MESSAGE
        MOV AH, 9
        LEA DX, WAITING_FOR_USER
        INT 21H


SEND_USERNAME_WAITING2:
		MOV AL, 0
		MOV PRESSED_KEY, AL
		UART_SEND PRESSED_KEY
		MOV DX , 3FDH		; LINE STATUS REGISTER
		IN AL , DX 
  		TEST AL , 00000001B
		JZ SEND_USERNAME_WAITING2

		MOV DX, 03F8H
		IN AL, DX

		LEA SI, PLAYER1_NAME
		LEA DI, PLAYER2_NAME

		MOV CX, 15

SEND_USERNAME_LOOP:

		MOV AL, [SI]
		MOV PRESSED_KEY, AL
		UART_SEND PRESSED_KEY


		MOV DX , 3FDH		; LINE STATUS REGISTER
SEND_USERNAME_WAITING:
		IN AL , DX 
  		TEST AL , 00000001B
		JZ SEND_USERNAME_WAITING

		MOV DX, 03F8H
		IN AL, DX
		CMP AL, 0
		JE SEND_USERNAME_WAITING
		MOV [DI], AL

		INC SI
		INC DI

		LOOP SEND_USERNAME_LOOP

		RET
SEND_USERNAME	ENDP

LOAD_USER_NAME  PROC    NEAR

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

		LEA DI, HP_BAR_PLAYER2_NAME
        LEA SI, PLAYER2_NAME

        MOV CX, 16
        LOAD_NAME_3:
                MOV AL, [SI]
                MOV [DI], AL
                INC DI
                INC SI
                LOOP LOAD_NAME_3

        RET
LOAD_USER_NAME  ENDP
;-------------------------------------------------------------------------------------------------------------------------------------------------------
;---------------------------------------------------------Main Menu---------------------------------------------------------------------------------------------
SCREEN_WIDTH                      EQU         1024
SCREEN_HEIGHT                     EQU         768
START_GAME_X                      EQU         (SCREEN_WIDTH/2)-(200)
START_GAME_Y                      EQU         (SCREEN_HEIGHT/2)-(125)
MAIN_MENU_CHAT_X                  EQU         (SCREEN_WIDTH/2)-(75)
MAIN_MENU_CHAT_Y                  EQU         (SCREEN_HEIGHT/2)-(25)
MAIN_MENU_QUIT_X                  EQU         (SCREEN_WIDTH/2)-(75)
MAIN_MENU_QUIT_Y                  EQU         (SCREEN_HEIGHT/2)+(75)
NOTIFICATIONS_BAR_LOCATION		  EQU		  (SCREEN_HEIGHT) - (SCREEN_HEIGHT / 10)

MAIN_MENU_STATIC_COLOR            EQU         3
MAIN_MENU_FOCUS_COLOR             EQU         5

MAIN_MENU    PROC    NEAR

		; Activate Video mode
		MOV AX, 4F02H
		MOV BX, 105H			; FIRST ACTIVATE VIDEO MODE TO CLEAR SCREEN TO DRAW ON CLEAN GROUND
		INT 10H

		; CLEAN INPUT BUFFER SO THAT PREVIOUS ENTER PRESSED IN ENTRY SCREEN DOESN'T AFFECT THIS
		PUSH ES
		MOV AX, 0000H
		MOV ES, AX
		MOV ES:[041AH], 041EH
		MOV ES:[041CH], 041EH				; Clears keyboard buffer
		POP		ES

MAIN_MENU_LOOP:

		CALL ADJUST_FOCUS_COLOR

		CALL NOTIFICATIONS_BAR

        CALL MAIN_MENU_START_GAME

        CALL MAIN_MENU_CHAT

        CALL MAIN_MENU_QUIT
                                    ; SCAN CODE -> AH
        MOV AH, 0                   ; SCAN CODE ENTER -> 1CH
        INT 16H                     ; SCAN CODE DOWN ARROW -> 50H
                                    ; SCAN CODE UP ARROW -> 48H
        CMP AH, 1CH
        JE ENTER_PRESSED

        CMP AH, 50H
        JE DOWN_PRESSED

        CMP AH, 48H
        JE UP_PRESSED

        JMP MAIN_MENU_LOOP 

DOWN_PRESSED:
		INC MAIN_MENU_CURRENT_STAT
		MOV AL, MAIN_MENU_CURRENT_STAT
		CMP AL, 3
		JNE MAIN_MENU_LOOP
		MOV AL, 0
		MOV MAIN_MENU_CURRENT_STAT, AL
		JMP MAIN_MENU_LOOP

UP_PRESSED:
		MOV AL, MAIN_MENU_CURRENT_STAT
		CMP AL, 0
		JNE UP_PRESSED_FLAG
		MOV AL, 3
	UP_PRESSED_FLAG:
		DEC AL
		MOV MAIN_MENU_CURRENT_STAT, AL
		JMP MAIN_MENU_LOOP

ENTER_PRESSED:	; GO TO MAIN PROGRAM AND IT'LL HANDLE THE PROPER ACTION TO TAKE

        RET
MAIN_MENU    ENDP

ADJUST_FOCUS_COLOR		PROC	NEAR		; CHANGE COLOR BASED ON PREVIOUS USER INPUT
		MOV AL, MAIN_MENU_CURRENT_STAT

		MOV MAIN_MENU_START_GAME_COLOR, MAIN_MENU_STATIC_COLOR
		MOV MAIN_MENU_CHAT_COLOR, MAIN_MENU_STATIC_COLOR		; MAKE THEM ALL STATIC TO NOT REPEAT IT IN EVERY OPTION
		MOV MAIN_MENU_QUIT_COLOR, MAIN_MENU_STATIC_COLOR

		CMP AL, 0
		JNE NOT_START_GAME
		MOV MAIN_MENU_START_GAME_COLOR, MAIN_MENU_FOCUS_COLOR	; START GAME HAS FOCUS
		JMP ADJUST_FOCUS_COLOR_END

NOT_START_GAME:

		CMP AL, 1
		JNE NOT_CHAT
		MOV MAIN_MENU_CHAT_COLOR, MAIN_MENU_FOCUS_COLOR		; CHAT HAS FOCUS
		JMP ADJUST_FOCUS_COLOR_END

NOT_CHAT:
		; ONLY 1 OPTION LEFT -> QUIT
		MOV MAIN_MENU_QUIT_COLOR, MAIN_MENU_FOCUS_COLOR		; QUIT HAS FOCUS


ADJUST_FOCUS_COLOR_END:

		RET
ADJUST_FOCUS_COLOR		ENDP

NOTIFICATIONS_BAR		PROC	NEAR

		; DRAW THE NOTIFICATIONS LINE
		MOV DX, NOTIFICATIONS_BAR_LOCATION
		MOV AL, 15
		MOV AH, 0CH
		MOV CX, SCREEN_WIDTH
		NOTIFICATIONS_BAR_LOOP:
			INT 10H
			LOOP NOTIFICATIONS_BAR_LOOP

		RET
NOTIFICATIONS_BAR		ENDP

MAIN_MENU_START_GAME      PROC    NEAR
        MOV AL, MAIN_MENU_START_GAME_COLOR

        CALL MAIN_START_S1
        CALL MAIN_START_T1
        CALL MAIN_START_A1
        CALL MAIN_START_R1
        CALL MAIN_START_T2

        CALL MAIN_START_G1
        CALL MAIN_START_A2
        CALL MAIN_START_M1
        CALL MAIN_START_E1

        RET
MAIN_MENU_START_GAME      ENDP

MAIN_MENU_CHAT      PROC    NEAR
        MOV AL, MAIN_MENU_CHAT_COLOR

        CALL MAIN_CHAT_C
        CALL MAIN_CHAT_H
        CALL MAIN_CHAT_A
        CALL MAIN_CHAT_T

        RET
MAIN_MENU_CHAT      ENDP

MAIN_MENU_QUIT      PROC    NEAR
        MOV AL, MAIN_MENU_QUIT_COLOR

        CALL MAIN_QUIT_Q
        CALL MAIN_QUIT_U
        CALL MAIN_QUIT_I
        CALL MAIN_QUIT_T

        RET
MAIN_MENU_QUIT      ENDP

MAIN_START_S1		PROC	NEAR
		MOV AH, 0CH
		
		; TOP - OF S
		MOV CX, START_GAME_X
		MAIN_START_S1_LOOP1_BIG:
			MOV DX, START_GAME_Y
			MAIN_START_S1_LOOP1_SML:
				INT 10H
				INC DX
				CMP DX, START_GAME_Y+5
				JNZ MAIN_START_S1_LOOP1_SML
			INC CX
			CMP CX, START_GAME_X+30
			JNZ MAIN_START_S1_LOOP1_BIG
			
		; MIDDLE - OF S
		MOV CX, START_GAME_X
		MAIN_START_S1_LOOP2_BIG:
			MOV DX, START_GAME_Y+22
			MAIN_START_S1_LOOP2_SML:
				INT 10H
				INC DX
				CMP DX, START_GAME_Y+28
				JNZ MAIN_START_S1_LOOP2_SML
			INC CX
			CMP CX, START_GAME_X+30
			JNZ MAIN_START_S1_LOOP2_BIG

		; BOT - OF S
		MOV CX, START_GAME_X
		MAIN_START_S1_LOOP3_BIG:
			MOV DX, START_GAME_Y+45
			MAIN_START_S1_LOOP3_SML:
				INT 10H
				INC DX
				CMP DX, START_GAME_Y+50
				JNZ MAIN_START_S1_LOOP3_SML
			INC CX
			CMP CX, START_GAME_X+30
			JNZ MAIN_START_S1_LOOP3_BIG
			
		; LEFT | OF S
		MOV CX, START_GAME_X
		MAIN_START_S1_LOOP4_BIG:
			MOV DX, START_GAME_Y+5
			MAIN_START_S1_LOOP4_SML:
				INT 10H
				INC DX
				CMP DX, START_GAME_Y+22
				JNZ MAIN_START_S1_LOOP4_SML
			INC CX
			CMP CX, START_GAME_X+5
			JNZ MAIN_START_S1_LOOP4_BIG
			
		; RIGHT | OF S
		MOV CX, START_GAME_X+25
		MAIN_START_S1_LOOP5_BIG:
			MOV DX, START_GAME_Y+28
			MAIN_START_S1_LOOP5_SML:
				INT 10H
				INC DX
				CMP DX, START_GAME_Y+45
				JNZ MAIN_START_S1_LOOP5_SML
			INC CX
			CMP CX, START_GAME_X+30
			JNZ MAIN_START_S1_LOOP5_BIG
			
			RET

MAIN_START_S1		ENDP

MAIN_START_T1		PROC	NEAR
		MOV AH, 0CH
		
		; - OF T
		MOV CX, START_GAME_X+40
		MAIN_START_T1_LOOP1_BIG:
			MOV DX, START_GAME_Y
			MAIN_START_T1_LOOP1_SML:
				INT 10H
				INC DX
				CMP DX, START_GAME_Y+5
				JNZ MAIN_START_T1_LOOP1_SML
			INC CX
			CMP CX, START_GAME_X+70
			JNZ MAIN_START_T1_LOOP1_BIG
		
		; | OF T
		MOV CX, START_GAME_X+40+12
		MAIN_START_T1_LOOP2_BIG:
			MOV DX, START_GAME_Y+5
			MAIN_START_T1_LOOP2_SML:
				INT 10H
				INC DX
				CMP DX, START_GAME_Y+50
				JNZ MAIN_START_T1_LOOP2_SML
			INC CX
			CMP CX, START_GAME_X+40+18
			JNZ MAIN_START_T1_LOOP2_BIG
			
			RET
		
MAIN_START_T1		ENDP

MAIN_START_A1       PROC    NEAR
        MOV AH, 0CH
		
		; LEFT | OF A
		MOV CX, START_GAME_X+80
		MAIN_START_A1_LOOP1_BIG:
			MOV DX, START_GAME_Y
			MAIN_START_A1_LOOP1_SML:
				INT 10H
				INC DX
				CMP DX, START_GAME_Y+50
				JNZ MAIN_START_A1_LOOP1_SML
			INC CX
			CMP CX, START_GAME_X+85
			JNZ MAIN_START_A1_LOOP1_BIG
			
		; RIGHT | OF A
		MOV CX, START_GAME_X+105
		MAIN_START_A1_LOOP2_BIG:
			MOV DX, START_GAME_Y
			MAIN_START_A1_LOOP2_SML:
				INT 10H
				INC DX
				CMP DX, START_GAME_Y+50
				JNZ MAIN_START_A1_LOOP2_SML
			INC CX
			CMP CX, START_GAME_X+110
			JNZ MAIN_START_A1_LOOP2_BIG
			
		; TOP - OF A
		MOV CX, START_GAME_X+85
		MAIN_START_A1_LOOP3_BIG:
			MOV DX, START_GAME_Y
			MAIN_START_A1_LOOP3_SML:
				INT 10H
				INC DX
				CMP DX, START_GAME_Y+5
				JNZ MAIN_START_A1_LOOP3_SML
			INC CX
			CMP CX, START_GAME_X+85+20
			JNZ MAIN_START_A1_LOOP3_BIG
			
		; BOT - OF A
		MOV CX, START_GAME_X+85
		MAIN_START_A1_LOOP4_BIG:
			MOV DX, START_GAME_Y+30
			MAIN_START_A1_LOOP4_SML:
				INT 10H
				INC DX
				CMP DX, START_GAME_Y+35
				JNZ MAIN_START_A1_LOOP4_SML
			INC CX
			CMP CX, START_GAME_X+85+20
			JNZ MAIN_START_A1_LOOP4_BIG

                    RET
MAIN_START_A1       ENDP

MAIN_START_R1       PROC    NEAR
        MOV AH, 0CH
		
		; LEFT | OF R
		MOV CX, START_GAME_X+120
		MAIN_START_R1_LOOP1_BIG:
			MOV DX, START_GAME_Y
			MAIN_START_R1_LOOP1_SML:
				INT 10H
				INC DX
				CMP DX, START_GAME_Y+50
				JNZ MAIN_START_R1_LOOP1_SML
			INC CX
			CMP CX, START_GAME_X+125
			JNZ MAIN_START_R1_LOOP1_BIG
			
		; TOP - OF R
		MOV CX, START_GAME_X+125
		MAIN_START_R1_LOOP2_BIG:
			MOV DX, START_GAME_Y
			MAIN_START_R1_LOOP2_SML:
				INT 10H
				INC DX
				CMP DX, START_GAME_Y+5
				JNZ MAIN_START_R1_LOOP2_SML
			INC CX
			CMP CX, START_GAME_X+150
			JNZ MAIN_START_R1_LOOP2_BIG
			
		; RIGHT | OF R
		MOV CX, START_GAME_X+145
		MAIN_START_R1_LOOP3_BIG:
			MOV DX, START_GAME_Y+5
			MAIN_START_R1_LOOP3_SML:
				INT 10H
				INC DX
				CMP DX, START_GAME_Y+30
				JNZ MAIN_START_R1_LOOP3_SML
			INC CX
			CMP CX, START_GAME_X+150
			JNZ MAIN_START_R1_LOOP3_BIG
			
		; MIDDLE - OF R
		MOV CX, START_GAME_X+125
		MAIN_START_R1_LOOP4_BIG:
			MOV DX, START_GAME_Y+30
			MAIN_START_R1_LOOP4_SML:
				INT 10H
				INC DX
				CMP DX, START_GAME_Y+35
				JNZ MAIN_START_R1_LOOP4_SML
			INC CX
			CMP CX, START_GAME_X+150
			JNZ MAIN_START_R1_LOOP4_BIG
		
		; \ STROKE OF R
		MOV BX, START_GAME_X+125
		MOV DX, START_GAME_Y+35
		MAIN_START_R1_LOOP5_BIG:
			MOV CX, BX
			MOV DI, BX
			ADD DI, 5
			MAIN_START_R1_LOOP5_SML:
				INT 10H
				INC CX
				CMP CX, DI
				JNZ MAIN_START_R1_LOOP5_SML
			INC BX	
			INC DX
			CMP DX, START_GAME_Y+50
			JNZ MAIN_START_R1_LOOP5_BIG

                RET
MAIN_START_R1   ENDP

MAIN_START_T2		PROC	NEAR
		MOV AH, 0CH
		
		; - OF T
		MOV CX, START_GAME_X+40+120
		MAIN_START_T2_LOOP1_BIG:
			MOV DX, START_GAME_Y
			MAIN_START_T2_LOOP1_SML:
				INT 10H
				INC DX
				CMP DX, START_GAME_Y+5
				JNZ MAIN_START_T2_LOOP1_SML
			INC CX
			CMP CX, START_GAME_X+70+120
			JNZ MAIN_START_T2_LOOP1_BIG
		
		; | OF T
		MOV CX, START_GAME_X+40+12+120
		MAIN_START_T2_LOOP2_BIG:
			MOV DX, START_GAME_Y+5
			MAIN_START_T2_LOOP2_SML:
				INT 10H
				INC DX
				CMP DX, START_GAME_Y+50
				JNZ MAIN_START_T2_LOOP2_SML
			INC CX
			CMP CX, START_GAME_X+40+18+120
			JNZ MAIN_START_T2_LOOP2_BIG
			
			RET
		
MAIN_START_T2		ENDP

MAIN_START_G1   PROC    NEAR
        MOV AH, 0CH

        ; TOP - OF G
        MOV CX, START_GAME_X+230
		MAIN_START_G1_LOOP1_BIG:
			MOV DX, START_GAME_Y
			MAIN_START_G1_LOOP1_SML:
				INT 10H
				INC DX
				CMP DX, START_GAME_Y+5
				JNZ MAIN_START_G1_LOOP1_SML
			INC CX
			CMP CX, START_GAME_X+260
			JNZ MAIN_START_G1_LOOP1_BIG  

        ; LEFT | OF G
        MOV CX, START_GAME_X+230
		MAIN_START_G1_LOOP2_BIG:
			MOV DX, START_GAME_Y+5
			MAIN_START_G1_LOOP2_SML:
				INT 10H
				INC DX
				CMP DX, START_GAME_Y+50
				JNZ MAIN_START_G1_LOOP2_SML
			INC CX
			CMP CX, START_GAME_X+235
			JNZ MAIN_START_G1_LOOP2_BIG 

        ; BOT - OF G
        MOV CX, START_GAME_X+235
		MAIN_START_G1_LOOP3_BIG:
			MOV DX, START_GAME_Y+45
			MAIN_START_G1_LOOP3_SML:
				INT 10H
				INC DX
				CMP DX, START_GAME_Y+50
				JNZ MAIN_START_G1_LOOP3_SML
			INC CX
			CMP CX, START_GAME_X+260
			JNZ MAIN_START_G1_LOOP3_BIG

        ; RIGHT | OF G
        MOV CX, START_GAME_X+255
		MAIN_START_G1_LOOP4_BIG:
			MOV DX, START_GAME_Y+25
			MAIN_START_G1_LOOP4_SML:
				INT 10H
				INC DX
				CMP DX, START_GAME_Y+50
				JNZ MAIN_START_G1_LOOP4_SML
			INC CX
			CMP CX, START_GAME_X+260
			JNZ MAIN_START_G1_LOOP4_BIG  

        ; MIDDLE - OF G
        MOV CX, START_GAME_X+245
		MAIN_START_G1_LOOP5_BIG:
			MOV DX, START_GAME_Y+25
			MAIN_START_G1_LOOP5_SML:
				INT 10H
				INC DX
				CMP DX, START_GAME_Y+30
				JNZ MAIN_START_G1_LOOP5_SML
			INC CX
			CMP CX, START_GAME_X+255
			JNZ MAIN_START_G1_LOOP5_BIG        

        RET
MAIN_START_G1   ENDP

MAIN_START_A2       PROC    NEAR
        MOV AH, 0CH
		
		; LEFT | OF A
		MOV CX, START_GAME_X+80+190
		MAIN_START_A2_LOOP1_BIG:
			MOV DX, START_GAME_Y
			MAIN_START_A2_LOOP1_SML:
				INT 10H
				INC DX
				CMP DX, START_GAME_Y+50
				JNZ MAIN_START_A2_LOOP1_SML
			INC CX
			CMP CX, START_GAME_X+85+190
			JNZ MAIN_START_A2_LOOP1_BIG
			
		; RIGHT | OF A
		MOV CX, START_GAME_X+105+190
		MAIN_START_A2_LOOP2_BIG:
			MOV DX, START_GAME_Y
			MAIN_START_A2_LOOP2_SML:
				INT 10H
				INC DX
				CMP DX, START_GAME_Y+50
				JNZ MAIN_START_A2_LOOP2_SML
			INC CX
			CMP CX, START_GAME_X+110+190
			JNZ MAIN_START_A2_LOOP2_BIG
			
		; TOP - OF A
		MOV CX, START_GAME_X+85+190
		MAIN_START_A2_LOOP3_BIG:
			MOV DX, START_GAME_Y
			MAIN_START_A2_LOOP3_SML:
				INT 10H
				INC DX
				CMP DX, START_GAME_Y+5
				JNZ MAIN_START_A2_LOOP3_SML
			INC CX
			CMP CX, START_GAME_X+85+20+190
			JNZ MAIN_START_A2_LOOP3_BIG
			
		; BOT - OF A
		MOV CX, START_GAME_X+85+190
		MAIN_START_A2_LOOP4_BIG:
			MOV DX, START_GAME_Y+30
			MAIN_START_A2_LOOP4_SML:
				INT 10H
				INC DX
				CMP DX, START_GAME_Y+35
				JNZ MAIN_START_A2_LOOP4_SML
			INC CX
			CMP CX, START_GAME_X+85+20+190
			JNZ MAIN_START_A2_LOOP4_BIG

                    RET
MAIN_START_A2       ENDP

MAIN_START_M1   PROC    NEAR
        MOV AH, 0CH
		        
        ; LEFT | OF M
		MOV CX, START_GAME_X+310
		MAIN_START_M1_LOOP1_BIG:
			MOV DX, START_GAME_Y
			MAIN_START_M1_LOOP1_SML:
				INT 10H
				INC DX
				CMP DX, START_GAME_Y+50
				JNZ MAIN_START_M1_LOOP1_SML
			INC CX
			CMP CX, START_GAME_X+315
			JNZ MAIN_START_M1_LOOP1_BIG

        ; RIGHT | OF M
		MOV CX, START_GAME_X+335
		MAIN_START_M1_LOOP2_BIG:
			MOV DX, START_GAME_Y
			MAIN_START_M1_LOOP2_SML:
				INT 10H
				INC DX
				CMP DX, START_GAME_Y+50
				JNZ MAIN_START_M1_LOOP2_SML
			INC CX
			CMP CX, START_GAME_X+340
			JNZ MAIN_START_M1_LOOP2_BIG

        ; MIDDLE | OF M
		MOV CX, START_GAME_X+323
		MAIN_START_M1_LOOP3_BIG:
			MOV DX, START_GAME_Y+5
			MAIN_START_M1_LOOP3_SML:
				INT 10H
				INC DX
				CMP DX, START_GAME_Y+50
				JNZ MAIN_START_M1_LOOP3_SML
			INC CX
			CMP CX, START_GAME_X+327
			JNZ MAIN_START_M1_LOOP3_BIG

        ; TOP - OF M
		MOV CX, START_GAME_X+315
		MAIN_START_M1_LOOP4_BIG:
			MOV DX, START_GAME_Y
			MAIN_START_M1_LOOP4_SML:
				INT 10H
				INC DX
				CMP DX, START_GAME_Y+5
				JNZ MAIN_START_M1_LOOP4_SML
			INC CX
			CMP CX, START_GAME_X+335
			JNZ MAIN_START_M1_LOOP4_BIG

        RET
MAIN_START_M1   ENDP

MAIN_START_E1   PROC    NEAR
        MOV AH, 0CH
		
		; LEFT | OF E
		MOV CX, START_GAME_X+350
		MAIN_START_E1_LOOP1_BIG:
			MOV DX, START_GAME_Y
			MAIN_START_E1_LOOP1_SML:
				INT 10H
				INC DX
				CMP DX, START_GAME_Y+50
				JNZ MAIN_START_E1_LOOP1_SML
			INC CX
			CMP CX, START_GAME_X+355
			JNZ MAIN_START_E1_LOOP1_BIG
			
		; TOP - OF E
		MOV CX, START_GAME_X+355
		MAIN_START_E1_LOOP2_BIG:
			MOV DX, START_GAME_Y
			MAIN_START_E1_LOOP2_SML:
				INT 10H
				INC DX
				CMP DX, START_GAME_Y+5
				JNZ MAIN_START_E1_LOOP2_SML
			INC CX
			CMP CX, START_GAME_X+380
			JNZ MAIN_START_E1_LOOP2_BIG
			
		; MIDDLE - OF E
		MOV CX, START_GAME_X+355
		MAIN_START_E1_LOOP3_BIG:
			MOV DX, START_GAME_Y+22
			MAIN_START_E1_LOOP3_SML:
				INT 10H
				INC DX
				CMP DX, START_GAME_Y+28
				JNZ MAIN_START_E1_LOOP3_SML
			INC CX
			CMP CX, START_GAME_X+380
			JNZ MAIN_START_E1_LOOP3_BIG
			
		; BOT - OF E
		MOV CX, START_GAME_X+355
		MAIN_START_E1_LOOP4_BIG:
			MOV DX, START_GAME_Y+45
			MAIN_START_E1_LOOP4_SML:
				INT 10H
				INC DX
				CMP DX, START_GAME_Y+50
				JNZ MAIN_START_E1_LOOP4_SML
			INC CX
			CMP CX, START_GAME_X+380
			JNZ MAIN_START_E1_LOOP4_BIG

        RET
MAIN_START_E1   ENDP

MAIN_CHAT_C     PROC    NEAR
        MOV AH, 0CH
		
		; LEFT | OF C
		MOV CX, MAIN_MENU_CHAT_X
		MAIN_CHAT_C_LOOP1_BIG:
			MOV DX, MAIN_MENU_CHAT_Y
			MAIN_CHAT_C_LOOP1_SML:
				INT 10H
				INC DX
				CMP DX, MAIN_MENU_CHAT_Y+50
				JNZ MAIN_CHAT_C_LOOP1_SML
			INC CX
			CMP CX, MAIN_MENU_CHAT_X+5
			JNZ MAIN_CHAT_C_LOOP1_BIG        

        ; TOP - OF C
		MOV CX, MAIN_MENU_CHAT_X+5
		MAIN_CHAT_C_LOOP2_BIG:
			MOV DX, MAIN_MENU_CHAT_Y
			MAIN_CHAT_C_LOOP2_SML:
				INT 10H
				INC DX
				CMP DX, MAIN_MENU_CHAT_Y+5
				JNZ MAIN_CHAT_C_LOOP2_SML
			INC CX
			CMP CX, MAIN_MENU_CHAT_X+30
			JNZ MAIN_CHAT_C_LOOP2_BIG

        ; BOT - OF C
		MOV CX, MAIN_MENU_CHAT_X+5
		MAIN_CHAT_C_LOOP3_BIG:
			MOV DX, MAIN_MENU_CHAT_Y+45
			MAIN_CHAT_C_LOOP3_SML:
				INT 10H
				INC DX
				CMP DX, MAIN_MENU_CHAT_Y+50
				JNZ MAIN_CHAT_C_LOOP3_SML
			INC CX
			CMP CX, MAIN_MENU_CHAT_X+30
			JNZ MAIN_CHAT_C_LOOP3_BIG

        RET
MAIN_CHAT_C     ENDP

MAIN_CHAT_H     PROC    NEAR
        MOV AH, 0CH
		
		; LEFT | OF H
		MOV CX, MAIN_MENU_CHAT_X+40
		MAIN_CHAT_H_LOOP1_BIG:
			MOV DX, MAIN_MENU_CHAT_Y
			MAIN_CHAT_H_LOOP1_SML:
				INT 10H
				INC DX
				CMP DX, MAIN_MENU_CHAT_Y+50
				JNZ MAIN_CHAT_H_LOOP1_SML
			INC CX
			CMP CX, MAIN_MENU_CHAT_X+45
			JNZ MAIN_CHAT_H_LOOP1_BIG  

        ; RIGHT | OF H
		MOV CX, MAIN_MENU_CHAT_X+65
		MAIN_CHAT_H_LOOP2_BIG:
			MOV DX, MAIN_MENU_CHAT_Y
			MAIN_CHAT_H_LOOP2_SML:
				INT 10H
				INC DX
				CMP DX, MAIN_MENU_CHAT_Y+50
				JNZ MAIN_CHAT_H_LOOP2_SML
			INC CX
			CMP CX, MAIN_MENU_CHAT_X+70
			JNZ MAIN_CHAT_H_LOOP2_BIG  

        ; MIDDLE - OF H
		MOV CX, MAIN_MENU_CHAT_X+45
		MAIN_CHAT_H_LOOP3_BIG:
			MOV DX, MAIN_MENU_CHAT_Y+22
			MAIN_CHAT_H_LOOP3_SML:
				INT 10H
				INC DX
				CMP DX, MAIN_MENU_CHAT_Y+28
				JNZ MAIN_CHAT_H_LOOP3_SML
			INC CX
			CMP CX, MAIN_MENU_CHAT_X+65
			JNZ MAIN_CHAT_H_LOOP3_BIG  

        RET
MAIN_CHAT_H     ENDP

MAIN_CHAT_A       PROC    NEAR
        MOV AH, 0CH
		
		; LEFT | OF A
		MOV CX, MAIN_MENU_CHAT_X+80
		MAIN_CHAT_A_LOOP1_BIG:
			MOV DX, MAIN_MENU_CHAT_Y
			MAIN_CHAT_A_LOOP1_SML:
				INT 10H
				INC DX
				CMP DX, MAIN_MENU_CHAT_Y+50
				JNZ MAIN_CHAT_A_LOOP1_SML
			INC CX
			CMP CX, MAIN_MENU_CHAT_X+85
			JNZ MAIN_CHAT_A_LOOP1_BIG
			
		; RIGHT | OF A
		MOV CX, MAIN_MENU_CHAT_X+105
		MAIN_CHAT_A_LOOP2_BIG:
			MOV DX, MAIN_MENU_CHAT_Y
			MAIN_CHAT_A_LOOP2_SML:
				INT 10H
				INC DX
				CMP DX, MAIN_MENU_CHAT_Y+50
				JNZ MAIN_CHAT_A_LOOP2_SML
			INC CX
			CMP CX, MAIN_MENU_CHAT_X+110
			JNZ MAIN_CHAT_A_LOOP2_BIG
			
		; TOP - OF A
		MOV CX, MAIN_MENU_CHAT_X+85
		MAIN_CHAT_A_LOOP3_BIG:
			MOV DX, MAIN_MENU_CHAT_Y
			MAIN_CHAT_A_LOOP3_SML:
				INT 10H
				INC DX
				CMP DX, MAIN_MENU_CHAT_Y+5
				JNZ MAIN_CHAT_A_LOOP3_SML
			INC CX
			CMP CX, MAIN_MENU_CHAT_X+105
			JNZ MAIN_CHAT_A_LOOP3_BIG
			
		; BOT - OF A
		MOV CX, MAIN_MENU_CHAT_X+85
		MAIN_CHAT_A_LOOP4_BIG:
			MOV DX, MAIN_MENU_CHAT_Y+30
			MAIN_CHAT_A_LOOP4_SML:
				INT 10H
				INC DX
				CMP DX, MAIN_MENU_CHAT_Y+35
				JNZ MAIN_CHAT_A_LOOP4_SML
			INC CX
			CMP CX, MAIN_MENU_CHAT_X+105
			JNZ MAIN_CHAT_A_LOOP4_BIG

                    RET
MAIN_CHAT_A       ENDP

MAIN_CHAT_T		PROC	NEAR
		MOV AH, 0CH
		
		; - OF T
		MOV CX, MAIN_MENU_CHAT_X+115
		MAIN_CHAT_T_LOOP1_BIG:
			MOV DX, MAIN_MENU_CHAT_Y
			MAIN_CHAT_T_LOOP1_SML:
				INT 10H
				INC DX
				CMP DX, MAIN_MENU_CHAT_Y+5
				JNZ MAIN_CHAT_T_LOOP1_SML
			INC CX
			CMP CX, MAIN_MENU_CHAT_X+145
			JNZ MAIN_CHAT_T_LOOP1_BIG
		
		; | OF T
		MOV CX, MAIN_MENU_CHAT_X+115+12
		MAIN_CHAT_T_LOOP2_BIG:
			MOV DX, MAIN_MENU_CHAT_Y+5
			MAIN_CHAT_T_LOOP2_SML:
				INT 10H
				INC DX
				CMP DX, MAIN_MENU_CHAT_Y+50
				JNZ MAIN_CHAT_T_LOOP2_SML
			INC CX
			CMP CX, MAIN_MENU_CHAT_X+115+18
			JNZ MAIN_CHAT_T_LOOP2_BIG
			
			RET
		
MAIN_CHAT_T		ENDP

MAIN_QUIT_Q     PROC    NEAR
        MOV AH, 0CH
		
		; LEFT | OF Q
		MOV CX, MAIN_MENU_QUIT_X
		MAIN_QUIT_Q_LOOP1_BIG:
			MOV DX, MAIN_MENU_QUIT_Y
			MAIN_QUIT_Q_LOOP1_SML:
				INT 10H
				INC DX
				CMP DX, MAIN_MENU_QUIT_Y+50
				JNZ MAIN_QUIT_Q_LOOP1_SML
			INC CX
			CMP CX, MAIN_MENU_QUIT_X+5
			JNZ MAIN_QUIT_Q_LOOP1_BIG

        ; TOP - OF Q
		MOV CX, MAIN_MENU_QUIT_X+5
		MAIN_QUIT_Q_LOOP2_BIG:
			MOV DX, MAIN_MENU_QUIT_Y
			MAIN_QUIT_Q_LOOP2_SML:
				INT 10H
				INC DX
				CMP DX, MAIN_MENU_QUIT_Y+5
				JNZ MAIN_QUIT_Q_LOOP2_SML
			INC CX
			CMP CX, MAIN_MENU_QUIT_X+30
			JNZ MAIN_QUIT_Q_LOOP2_BIG

        ; RIGHT | OF Q
		MOV CX, MAIN_MENU_QUIT_X+25
		MAIN_QUIT_Q_LOOP3_BIG:
			MOV DX, MAIN_MENU_QUIT_Y+5
			MAIN_QUIT_Q_LOOP3_SML:
				INT 10H
				INC DX
				CMP DX, MAIN_MENU_QUIT_Y+50
				JNZ MAIN_QUIT_Q_LOOP3_SML
			INC CX
			CMP CX, MAIN_MENU_QUIT_X+30
			JNZ MAIN_QUIT_Q_LOOP3_BIG

        ; BOT - OF Q
		MOV CX, MAIN_MENU_QUIT_X+5
		MAIN_QUIT_Q_LOOP4_BIG:
			MOV DX, MAIN_MENU_QUIT_Y+45
			MAIN_QUIT_Q_LOOP4_SML:
				INT 10H
				INC DX
				CMP DX, MAIN_MENU_QUIT_Y+50
				JNZ MAIN_QUIT_Q_LOOP4_SML
			INC CX
			CMP CX, MAIN_MENU_QUIT_X+25
			JNZ MAIN_QUIT_Q_LOOP4_BIG

        ; BOT STROKE OF Q
		MOV BX, MAIN_MENU_QUIT_X+12
		MOV DX, MAIN_MENU_QUIT_Y+50
		MAIN_QUIT_Q_LOOP5_BIG:
			MOV CX, BX
			MOV DI, BX
			ADD DI, 5
			MAIN_QUIT_Q_LOOP5_SML:
				INT 10H
				INC CX
				CMP CX, DI
				JNZ MAIN_QUIT_Q_LOOP5_SML
			INC BX	
			INC DX
			CMP DX, MAIN_MENU_QUIT_Y+50+10
			JNZ MAIN_QUIT_Q_LOOP5_BIG

        RET
MAIN_QUIT_Q     ENDP

MAIN_QUIT_U     PROC    NEAR
        MOV AH, 0CH

        ; LEFT | OF U
		MOV CX, MAIN_MENU_QUIT_X+40
		MAIN_QUIT_U_LOOP1_BIG:
			MOV DX, MAIN_MENU_QUIT_Y
			MAIN_QUIT_U_LOOP1_SML:
				INT 10H
				INC DX
				CMP DX, MAIN_MENU_QUIT_Y+50
				JNZ MAIN_QUIT_U_LOOP1_SML
			INC CX
			CMP CX, MAIN_MENU_QUIT_X+5+40
			JNZ MAIN_QUIT_U_LOOP1_BIG

        ; RIGHT | OF U
		MOV CX, MAIN_MENU_QUIT_X+25+40
		MAIN_QUIT_U_LOOP2_BIG:
			MOV DX, MAIN_MENU_QUIT_Y
			MAIN_QUIT_U_LOOP2_SML:
				INT 10H
				INC DX
				CMP DX, MAIN_MENU_QUIT_Y+50
				JNZ MAIN_QUIT_U_LOOP2_SML
			INC CX
			CMP CX, MAIN_MENU_QUIT_X+30+40
			JNZ MAIN_QUIT_U_LOOP2_BIG

        ; BOT - OF U
		MOV CX, MAIN_MENU_QUIT_X+5+40
		MAIN_QUIT_U_LOOP3_BIG:
			MOV DX, MAIN_MENU_QUIT_Y+45
			MAIN_QUIT_U_LOOP3_SML:
				INT 10H
				INC DX
				CMP DX, MAIN_MENU_QUIT_Y+50
				JNZ MAIN_QUIT_U_LOOP3_SML
			INC CX
			CMP CX, MAIN_MENU_QUIT_X+25+40
			JNZ MAIN_QUIT_U_LOOP3_BIG

        RET
MAIN_QUIT_U     ENDP

MAIN_QUIT_I     PROC    NEAR
        MOV AH, 0CH

        ; | OF I
		MOV CX, MAIN_MENU_QUIT_X+80+12
		MAIN_QUIT_I_LOOP1_BIG:
			MOV DX, MAIN_MENU_QUIT_Y+5
			MAIN_QUIT_I_LOOP1_SML:
				INT 10H
				INC DX
				CMP DX, MAIN_MENU_QUIT_Y+45
				JNZ MAIN_QUIT_I_LOOP1_SML
			INC CX
			CMP CX, MAIN_MENU_QUIT_X+80+18
			JNZ MAIN_QUIT_I_LOOP1_BIG

        ; TOP - OF I
		MOV CX, MAIN_MENU_QUIT_X+80
		MAIN_QUIT_I_LOOP2_BIG:
			MOV DX, MAIN_MENU_QUIT_Y
			MAIN_QUIT_I_LOOP2_SML:
				INT 10H
				INC DX
				CMP DX, MAIN_MENU_QUIT_Y+5
				JNZ MAIN_QUIT_I_LOOP2_SML
			INC CX
			CMP CX, MAIN_MENU_QUIT_X+80+30
			JNZ MAIN_QUIT_I_LOOP2_BIG

        ; BOT - OF I
		MOV CX, MAIN_MENU_QUIT_X+80
		MAIN_QUIT_I_LOOP3_BIG:
			MOV DX, MAIN_MENU_QUIT_Y+45
			MAIN_QUIT_I_LOOP3_SML:
				INT 10H
				INC DX
				CMP DX, MAIN_MENU_QUIT_Y+50
				JNZ MAIN_QUIT_I_LOOP3_SML
			INC CX
			CMP CX, MAIN_MENU_QUIT_X+80+30
			JNZ MAIN_QUIT_I_LOOP3_BIG

        RET
MAIN_QUIT_I     ENDP

MAIN_QUIT_T     PROC    NEAR
        MOV AH, 0CH

        ; | OF T
		MOV CX, MAIN_MENU_QUIT_X+120+12
		MAIN_QUIT_T_LOOP1_BIG:
			MOV DX, MAIN_MENU_QUIT_Y+5
			MAIN_QUIT_T_LOOP1_SML:
				INT 10H
				INC DX
				CMP DX, MAIN_MENU_QUIT_Y+50
				JNZ MAIN_QUIT_T_LOOP1_SML
			INC CX
			CMP CX, MAIN_MENU_QUIT_X+120+18
			JNZ MAIN_QUIT_T_LOOP1_BIG

        ; TOP - OF T
		MOV CX, MAIN_MENU_QUIT_X+120
		MAIN_QUIT_T_LOOP2_BIG:
			MOV DX, MAIN_MENU_QUIT_Y
			MAIN_QUIT_T_LOOP2_SML:
				INT 10H
				INC DX
				CMP DX, MAIN_MENU_QUIT_Y+5
				JNZ MAIN_QUIT_T_LOOP2_SML
			INC CX
			CMP CX, MAIN_MENU_QUIT_X+120+30
			JNZ MAIN_QUIT_T_LOOP2_BIG

        RET
MAIN_QUIT_T     ENDP
;-------------------------------------------------------------------------------------------------------------------------------------------------------
;-----------------------------------------------------------HP------------------------------------------------------------------------------------------
HP_BAR_FUNCTION    PROC    NEAR

        CALL DRAW_HP_BAR1

        CALL DRAW_HP_BAR2

        MOV CX, SCREEN_WIDTH
        MOV DX, HP_BARS_END_LINE
        MOV AH, 0CH
        MOV AL, 7

HP_BARS_END_LOOP:
                INT 10H
                LOOP HP_BARS_END_LOOP

        RET
HP_BAR_FUNCTION    ENDP

DRAW_HP_BAR1     PROC    NEAR   ; DRAW HP_BAR FOR PLAYER WHICH  DI HAS HP POINTS AND CX HAS START 

        MOV AH, 0CH

        MOV CX, HP_PLAYER1_START_COL    ; DRAW PLAYER 1 HP

        MOV BX, CX
        ADD BX, BAR_WIDTH

        MOV DI, PLAYER1_HP
        CMP DI, 0
        JE  DRAW_HP_BAR1_0

        MOV AL, HP_BAR_COLOR_GREEN

        CMP DI, HALF_HP
        JA DRAW_HP_BAR1_LOOP0
        MOV AL, HP_BAR_COLOR_YELLOW

        CMP DI, QUARTER_HP
        JA DRAW_HP_BAR1_LOOP0
        MOV AL, HP_BAR_COLOR_RED

DRAW_HP_BAR1_LOOP0:
    DRAW_HP_BAR1_LOOP1:
                MOV DX, HP_BAR_START_ROW
                DRAW_HP_BAR1_LOOP2:
                        INT 10H
                        INC DX
                        CMP DX, HP_BAR_END_ROW
                        JNZ DRAW_HP_BAR1_LOOP2
                INC CX
                CMP CX, BX
                JNZ DRAW_HP_BAR1_LOOP1
        ADD BX, BAR_WIDTH
        DEC DI
        JNZ DRAW_HP_BAR1_LOOP0

DRAW_HP_BAR1_0:

        MOV DI, MAX_HP
        SUB DI, PLAYER1_HP
        JZ NO_NEED_CLEAR1
        MOV AL, HP_BACK_COL

DRAW_HP_BAR1_LOOP3:
    DRAW_HP_BAR1_LOOP4:
                MOV DX, HP_BAR_START_ROW
                DRAW_HP_BAR1_LOOP5:
                        INT 10H
                        INC DX
                        CMP DX, HP_BAR_END_ROW
                        JNZ DRAW_HP_BAR1_LOOP5
                INC CX
                CMP CX, BX
                JNZ DRAW_HP_BAR1_LOOP4
        ADD BX, BAR_WIDTH
        DEC DI
        JNZ DRAW_HP_BAR1_LOOP3

NO_NEED_CLEAR1:

        RET
DRAW_HP_BAR1     ENDP

DRAW_HP_BAR2     PROC    NEAR   ; DRAW HP_BAR FOR PLAYER WHICH  DI HAS HP POINTS AND CX HAS START 

        MOV AH, 0CH

        MOV CX, HP_PLAYER2_START_COL    ; DRAW PLAYER 2 HP

        MOV BX, CX
        ADD BX, BAR_WIDTH

        MOV DI, PLAYER2_HP
        CMP DI, 0
        JE  DRAW_HP_BAR2_0

        MOV AL, HP_BAR_COLOR_GREEN

        CMP DI, HALF_HP
        JA DRAW_HP_BAR2_LOOP0
        MOV AL, HP_BAR_COLOR_YELLOW

        CMP DI, QUARTER_HP
        JA DRAW_HP_BAR2_LOOP0
        MOV AL, HP_BAR_COLOR_RED                 ; INITIAL STATIC CONFIGS
        

DRAW_HP_BAR2_LOOP0:
    DRAW_HP_BAR2_LOOP1:
                MOV DX, HP_BAR_START_ROW
                DRAW_HP_BAR2_LOOP2:
                        INT 10H
                        INC DX
                        CMP DX, HP_BAR_END_ROW
                        JNZ DRAW_HP_BAR2_LOOP2
                INC CX
                CMP CX, BX
                JNZ DRAW_HP_BAR2_LOOP1
        SUB BX, BAR_WIDTH
        MOV CX, BX
        SUB CX, BAR_WIDTH
        DEC DI
        JNZ DRAW_HP_BAR2_LOOP0

DRAW_HP_BAR2_0:

        MOV DI, MAX_HP
        SUB DI, PLAYER2_HP
        JZ NO_NEED_CLEAR2
        MOV AL, HP_BACK_COL

DRAW_HP_BAR2_LOOP3:
    DRAW_HP_BAR2_LOOP4:
                MOV DX, HP_BAR_START_ROW
                DRAW_HP_BAR2_LOOP5:
                        INT 10H
                        INC DX
                        CMP DX, HP_BAR_END_ROW
                        JNZ DRAW_HP_BAR2_LOOP5
                INC CX
                CMP CX, BX
                JNZ DRAW_HP_BAR2_LOOP4
        SUB BX, BAR_WIDTH
        MOV CX, BX
        SUB CX, BAR_WIDTH
        DEC DI
        JNZ DRAW_HP_BAR2_LOOP3

NO_NEED_CLEAR2:

        RET
DRAW_HP_BAR2     ENDP
;-------------------------------------------------------------------------------------------------------------------------------------------------------

;------------------------------------------------------------Serial----------------------------------------------------------------------

CHAT PROC NEAR
	
	;TEXT_MODE
	MOV AL, 03H
	MOV AH, 0
	INT 10H
	  
	
	MOV AH,6       				; FUNCTION 6
	MOV AL,0       				; SCROLL BY 0 LINES   
	MOV BH,CLR_ATTR_SEND     	; NORMAL VIDEO ATTRIBUTE  (BLUE)       
	MOV CH,0       				; UPPER LEFT Y
	MOV CL,0       				; UPPER LEFT X
	MOV DH,11     				; LOWER RIGHT Y
	MOV DL,79     				; LOWER RIGHT X 
	INT 10H           

	MOV AH,6       					; FUNCTION 6
	MOV AL,0        				; SCROLL BY 0 LINES    
	MOV BH,CLR_ATTR_RECEIVE      	; NORMAL VIDEO ATTRIBUTE  (RED)       
	MOV CH,12       				; UPPER LEFT Y
	MOV CL,0        				; UPPER LEFT X
	MOV DH,24     					; LOWER RIGHT Y
	MOV DL,79     					; LOWER RIGHT X 
	INT 10H   

	MOV AH, 9
	LEA DX, PLAYER1_NAME
	INT 21H

	MOV AH, 2
	MOV DL, ':'
	INT 21H

	MOV BX, 0
	MOV AH, 2
	MOV DH, WindMid
	MOV DL, 0
	INT 10H

	MOV AH, 9
	LEA DX, PLAYER2_NAME
	INT 21H

	MOV AH, 2
	MOV DL, ':'
	INT 21H

	; MOV AH,2 
    ; MOV DH,0                  ;MOVE CURSOR TO X,Y POSITION DH:Y DL:X
    ; MOV DL,0
    ; INT 10H                                                     
    
    ; MOV AX,0600H 
    ; MOV BH,01FH 
    ; MOV CX,0                  ;CLEARING TOP HALF IN BLUE
    ; MOV DX,0C4FH 
    ; INT 10H
    
    ; MOV AX,0600H 
    ; MOV BH,04FH               ;CLEARING BOTTOM HALF IN RED
    ; MOV CX,0C00H                                              
    ; MOV DX,184FH 
    ; INT 10H 	
	
CHAT_MAIN_LOOP:


	CALL CHECK_KEY_PRESSED
	JZ  CHAT_CHECK_DATA_RECEIVED					;IF THERE IS NO KEY PRESSED GO CHECK FOR RECEIVED DATA
		CALL READ_KEY_PRESSED				;IF THE KEY PRESSED IS ESC --> SEND THE RECEIVER A FLAG THEN EXIT
		CMP  PRESSED_KEY_SC, ESC_KEY
		JE   CHAT_TERMINATE						
											;ELSE: PRINT IT AND SEND IT THROUGH UART
			;;;;;;;;;;;;;;;;;;;HERE PRINT IN THE SEND SCREEN;;;;;;;;;;;;;;;;;;;;;;;;;
			 PRINT_SENT	PRESSED_KEY
			; MOV AL, PRESSED_KEY
			; MOV AH, 0
			; CALL A7laChat
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			UART_SEND	PRESSED_KEY
	
	
	
	
CHAT_CHECK_DATA_RECEIVED:
	CALL UART_CHECK_KEY_RECEIVED
	JZ CHAT_MAIN_LOOP						;IF THERE IS NO DATA RECEIVED REPEAT AGAIN
		CALL UART_READ_KEY_RECEIVED		;ELSE: READ THE RECEIVED DATA AND PRINT IT
			CMP RECEIVED_KEY, 1bh
			JE CHAT_EXIT
				;;;;;;;;;;;;;;;;;;;HERE PRINT IN THE RECEIVED SCREEN;;;;;;;;;;;;;;;;;;;;;;;;;
				PRINT_RECEIVED RECEIVED_KEY
				;MOV AL, PRESSED_KEY
				;MOV AH, 0
				;CALL A7laChat2
				;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
CHAT_MAIN_LOOP_END:	
	;NOTHING HERE
JMP CHAT_MAIN_LOOP

CHAT_TERMINATE:
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;SEND TERMINATE KEY;;;;;;;;;;;;;;;;;;;;;;;;;
	UART_SEND	1bh	;LET THE ASCII 0 INDICATES TERMINATION
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
CHAT_EXIT:
	;TEXT MODE & CLEAR SCREEN
	MOV AL, 13H
	MOV AH, 0
	INT 10H
	
	MOV BX, 0
	MOV AH, 2
	MOV DX, 0A02H
	INT 10H

	;PRINT A MESSAGE TO ASK FOR A KEY TO EXIT
	MOV AH, 9
	MOV DX, OFFSET EXIT_MES
	INT 21H
	
	;Press any key to exit
	MOV AH , 0
	INT 16h

CHAT ENDP

UART_init PROC NEAR
	PUSHA
	
	;Set Divisor Latch Access Bit
	MOV DX,3FBH 			; LINE CONTROL REGISTER
	MOV AL,10000000B		;SET DIVISOR LATCH ACCESS BIT
	OUT DX,AL				;OUT IT

	;SET LSB BYTE OF THE BAUD RATE DIVISOR LATCH REGISTER.
	MOV DX,3F8H			
	MOV AL,0CH			
	OUT DX,AL

	;MSB BYTE OF THE BAUD RATE DIVISOR LATCH REGISTER.
	MOV DX,3F9H
	MOV AL,00H
	OUT DX,AL
	;SET PORT CONFIGURATION
	MOV DX,3FBH
	MOV AL,00011011B
	;0:ACCESS TO RECEIVER BUFFER, TRANSMITTER BUFFER
	;0:SET BREAK DISABLED
	;011:EVEN PARITY
	;0:ONE STOP BIT
	;11:8BITS
	OUT DX,AL

	
	POPA
	RET
UART_init ENDP

;NOTE!: THESE TWO PROCs USE AX AND THE ZERO FLAG
;RETURNS AH: SCANCODE, AL: ASCII, CLEARS ZERO FLAG IF THERE EXIST A KEY PRESSED
CHECK_KEY_PRESSED PROC NEAR 
	PUSHA
	MOV AH,1
	INT 16H
	POPA
	RET
CHECK_KEY_PRESSED	ENDP

READ_KEY_PRESSED PROC NEAR 
	PUSHA
	MOV AH,0
	INT 16H
	MOV PRESSED_KEY, AL			;MOV ASCII CODE IN PRESSED_KEY VARIABLE
	MOV PRESSED_KEY_SC, AH		;MOV SCANCODE IN PRESSED_KEY_SC VARIABLE 
	POPA
	RET
READ_KEY_PRESSED	ENDP

;NOTE!: THIS PROC USES DX, AX AND THE ZERO FLAG IS AFFECTED
;RETURNS CLEARS ZERO FLAG IF THE DATA IS READY
UART_CHECK_KEY_RECEIVED PROC NEAR
	PUSHA
	;CHECK THAT DATA IS READY
	MOV DX , 3FDH		; LINE STATUS REGISTER
	IN AL , DX 
  	TEST AL , 00000001B
	POPA
	RET
UART_CHECK_KEY_RECEIVED ENDP

UART_READ_KEY_RECEIVED PROC NEAR
	PUSHA
	;If Ready read the VALUE in Receive data register
	MOV DX , 03F8H
	IN AL , DX 
	MOV RECEIVED_KEY , AL
	POPA
	RET
UART_READ_KEY_RECEIVED ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;printing logic;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;printing logic;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;printing logic;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
A7laChat Proc near
    
    push ax
    
    cmp p1startx,windWidth
    jae A7laChat_NewLine  
    
    cmp p1starty,windHeight/2-1
    jb A7laChat_continue  
     
    dec p1starty 
    mov ah,2 
    mov dh,p1starty     ;Move Cursor to X,Y position dh:Y dl:X
    mov dl,0
    int 10h
    
    mov ah,6            ; function 6
    mov al,1            ; scroll by 1 line    
    mov bh,01Fh         ; normal video attribute         
    mov ch,1            ; upper left Y
    mov cl,0            ; upper left X
    mov dh,11           ; lower right Y
    mov dl,79           ; lower right X 
    int 10h  
                
A7laChat_continue:
         
    mov ah,2 
    mov dh,p1starty   ;Move Cursor to X,Y position dh:Y dl:X
    mov dl,p1startx
    int 10h
    
    pop ax 
    
    cmp ah,Esc_Key
    jnz A7laChat_stay

    ret
     
A7laChat_stay: 
    
    cmp ah,Enter_Key
    jnz A7laChat_sameY  

A7laChat_NewLine:
    
    inc p1starty
    mov p1startx,0 
    
    ret   
    
A7laChat_sameY:
    
    mov ah,9          ;Display 
    mov bh,0          ;Page 0
    mov cx,1h         ;1 time 
    mov bl,01Ch       ;White (F) on Blue(1) background 
    int 10h

    inc p1startx
    
    ret

A7laChat endp

 
A7laChat2 Proc near
    
    
    push ax  
    
    cmp p2startx,windWidth
    jae A7laChat2_NewLine2  
    
    cmp p2starty,windHeight-1
    jb A7laChat2_continue2  
     
    dec p2starty 
    mov ah,2 
    mov dh,p2starty     ;Move Cursor to X,Y position dh:Y dl:X
    mov dl,0
    int 10h
    
    mov ah,6            ; function 6
    mov al,1            ; scroll by 1 line    
    mov bh,01Fh         ; normal video attribute         
    mov ch,1            ; upper left Y
    mov cl,0            ; upper left X
    mov dh,11           ; lower right Y
    mov dl,79           ; lower right X 
    int 10h           
                 
A7laChat2_continue2:
         
    mov ah,2 
    mov dh,p2starty   ;Move Cursor to X,Y position dh:Y dl:X
    mov dl,p2startx
    int 10h
    
    pop ax 
    
    cmp ah,Esc_Key
    jnz A7laChat2_stay2

    ret
     
A7laChat2_stay2: 
    
    cmp ah,Enter_Key
    jnz A7laChat2_sameY2  

A7laChat2_NewLine2:
    
    inc p2starty
    mov p2startx,0 
    
    ret   
    
A7laChat2_sameY2:
    
    mov ah,9          ;Display 
    mov bh,0          ;Page 0
    mov cx,1h         ;1 time 
    mov bl,049h       ;Blue (9) on Red(4) background 
    int 10h

    inc p2startx
    
    ret


A7laChat2 endp

SET_LEVEL	PROC	NEAR

		MOV AX, 4F02H
		MOV BX, 105H 
		INT 10H

		MOV BX, 0
		MOV AH, 2
		MOV DX, 1334H
		INT 10H

		MOV AH, 9
		LEA DX, LEVEL1_CHOICE
		INT 21H

		MOV BX, 0
		MOV AH, 2
		MOV DX, 1634H
		INT 10H

		MOV AH, 9
		LEA DX, LEVEL2_CHOICE
		INT 21H

		MOV AH, 0
		INT 16H

		CMP AL, '1'
		JNE LEVEL2_PICKED
		MOV AL, 1
		MOV LEVEL, AL

		MOV BX, MAX_HP_LEVEL1

		JMP SET_LEVEL_END

LEVEL2_PICKED:
		MOV AL, 2
		MOV LEVEL, AL

		MOV BX, MAX_HP_LEVEL2

SET_LEVEL_END:
		MOV MAX_HP, BX
		MOV PLAYER1_HP, BX
		MOV PLAYER2_HP, BX
		RET
SET_LEVEL	ENDP

INIT_TIME	PROC	NEAR

		MOV AH,2CH    	; To get System Time
		INT 21H			; Seconds is in DH
		DEC DH
		INC TIME
		MOV PREV_TIME, DH

		MOV AL, LEVEL
		CMP AL, 1
		JNE INIT_TIME_LEVEL_2
		MOV AL, TIME_LEVEL1
		MOV TIME, AL
		JMP INIT_TIME_END

INIT_TIME_LEVEL_2:
		MOV AL, TIME_LEVEL2
		MOV TIME, AL

INIT_TIME_END:
		RET
INIT_TIME	ENDP

DRAW_TIME	PROC	NEAR

		MOV AH,2CH    	; To get System Time
		INT 21H			; Seconds is in DH
		CMP DH, PREV_TIME
		JE DRAW_TIME_END_2

		MOV PREV_TIME, DH
		DEC TIME

		MOV BX, 0
		MOV AH, 2
		MOV DX, 0040H
		INT 10H

		; TURN WORD IN CURRENT TO STRING IN OUTPUT AND DISPLAY IT
            ; FIRST MAKE BX POINT TO OUTPUT
            LEA BX, TIME_DISPLAY
            ; THEN MAKE AX HOLD VALUE
            MOV AL, TIME
			MOV AH, 0
            ; THEN KEEP DIVIDING TILL THERE IS 0 IN AX
            MOV SI, 3

        DRAW_TIME_LOOP:
                MOV DX, 0
                MOV DI, 10
                DIV DI
                
                ADD DL, 48
                MOV [BX][SI]-1, DL
                DEC SI
                JNZ DRAW_TIME_LOOP

            ; Clean output of trailing Zeros
            MOV CX, 2
            LEA BX, TIME_DISPLAY
        DRAW_TIME_CLEAN:
                MOV AL, [BX]
                SUB AL, 48
                JNZ DRAW_TIME_END
                MOV AL, 32
                MOV [BX], AL
                INC BX
                LOOP DRAW_TIME_CLEAN

            ; DISPLAY MESSAGE WITH INT
DRAW_TIME_END:
            MOV AH, 9
            LEA DX, TIME_DISPLAY
            INT 21H
DRAW_TIME_END_2:
		RET
DRAW_TIME	ENDP

END MAIN
