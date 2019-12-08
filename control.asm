include macros.inc
;.386
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
gazmaClr    			EQU 6 
ReglClr     			EQU 1     
TorsoClr    			EQU 4 
armClr      			EQU 8 
SkinClr     			EQU 7     
HairClr     			EQU 9 
FPEyeClr    			EQU 5 
SPEyeClr    			EQU 14
HeartsClr   			EQU 12

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
MAX_LEFT 				EQU 20
MAX_RIGHT 				EQU SCREEN_MAX_X - 20

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
START_X_1 				EQU 80 	;PLAYER1
START_X_2 				EQU 500 ;PLAYER2

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
;---------------------------------------------------------------END GAME VARIABLES--------------------------------------------------------------








;-----------------------------------------------------------------------------GAME CODE------------------------------------------------------------------
.CODE
MAIN PROC FAR
	MOV AX, @DATA
	MOV DS, AX	
;-----------------------------------------------------------------------------SET VIDEO MODE--------------------------------------------------------------
	MOV AX, 4F02H
	MOV BX, 105H 
	INT 10H
	; mov al, 13h
	; mov ah, 0
	; int 10h
;--------------------------------------------------------------------------END SET VIDEO MODE--------------------------------------------------------------

;-------------------------------------------------------------------------- LOAD ENVIROMENT---------------------------------------------------------------
	call Background
    DRAW_P1_HEARTS 3
	DRAW_P2_HEARTS 3
	
;--------------------------------------------------------------------------END LOAD ENVIROMENT--------------------------------------------------------------
	
;-----------------------------------------------------------------------------INTIALIZE PLAYERS------------------------------------------------------------
	DRAW_P1 origin_p1, STNDS
	DRAW_P2 origin_p2, STNDS
;----------------------------------------------------------------------------END INITIALIZE PLAYERS---------------------------------------------------------
	

;-----------------------------------------------------------------------------MAIN LOOP--------------------------------------------------------------------

	
	MAIN_LOOP: 
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
				JBE MAIN_LOOP_END
					CALL CLR_P1
					MOV AX, RUN_STEP
					SUB P1_X, AX
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
				JE MAIN_LOOP_END
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
				JAE MAIN_LOOP_END
					CALL CLR_P2
					ADD P2_X, RUN_STEP
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
			JNE MAIN_LOOP_END
			
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
				JNE MAIN_LOOP_END
					CALL P2_LEGSHOT
					JMP P2_MOV_RIGHT
					JMP MAIN_LOOP_END	;ELSE IF PLAYER 2 IS CROUCHING -> NOTHING HAPPENS
		
		P1_KICK:
			MOV AX, P1_X
			ADD AX, COLLISION_DIST		;IF THE DISTANCE BETWEEN THE 2 PLAYERS IS NOT SUFFICIENT FOR COLLISION NOTHING HAPPENS
			CMP AX, P2_X
			JNE MAIN_LOOP_END
			
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
			JNE MAIN_LOOP_END
				
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
				JNE MAIN_LOOP_END
					CALL P1_LEGSHOT
					JMP P1_MOV_LEFT
					JMP MAIN_LOOP_END	;ELSE IF PLAYER 1 IS CROUCHING -> NOTHING HAPPENS
		
		P2_KICK:
			MOV AX, P2_X
			SUB AX, COLLISION_DIST		;IF THE DISTANCE BETWEEN THE 2 PLAYERS IS NOT SUFFICIENT FOR COLLISION NOTHING HAPPENS
			CMP AX, P1_X
			JNE MAIN_LOOP_END
				
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
			JZ EXIT                                                                                                                               
;--------------------------------------------------------------------------------EXIT-------------------------------------------------------------------


;------------------------------------------------------------------------------END MAIN LOOP------------------------------------------------------------
		MAIN_LOOP_END:	
			;CALL DELAY
	JMP  MAIN_LOOP






EXIT:
	;Press any key to exit
	MOV AH , 0
	INT 16h
	;Change to Text MODE
	MOV AH,0          
	MOV AL,03h
	INT 10h 
	;return control to operating system
	MOV AH , 4ch
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
	DELAY1_8SEC_DELAY_1:
		PUSH AX
		MOV AX, 0D090H
	DELAY1_8SEC_DELAY_2:
		DEC AX
		JNZ DELAY1_8SEC_DELAY_2
		POP AX
		DEC AX
		JNZ DELAY1_8SEC_DELAY_1
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

P1_HEADSHOT PROC NEAR
	;--------------------TEST----------------------
	mov ah,9 ;Display
	mov bh,0 ;Page 0
	mov al,44h ;Letter D
	mov cx,5h ;5 times
	mov bl,0FAh ;Green (A) on white(F) background
	int 10h
	;----------------------------------------------

	RET
P1_HEADSHOT ENDP


P1_BODYSHOT PROC NEAR

	;--------------------TEST----------------------
	mov ah,9 ;Display
	mov bh,0 ;Page 0
	mov al,45h ;Letter D
	mov cx,5h ;5 times
	mov bl,0FAh ;Green (A) on white(F) background
	int 10h
	;----------------------------------------------

	RET
P1_BODYSHOT ENDP

P1_LEGSHOT PROC NEAR

	;--------------------TEST----------------------
	mov ah,9 ;Display
	mov bh,0 ;Page 0
	mov al,46h ;Letter D
	mov cx,5h ;5 times
	mov bl,0FAh ;Green (A) on white(F) background
	int 10h
	;----------------------------------------------

	RET
P1_LEGSHOT ENDP
;-----------------------------------------------------END P1 ATTACKS PROCEDURES-----------------------------------------------------------------

;----------------------------------------------------START P2 ATTACKS PROCEDURES----------------------------------------------------------------


P2_HEADSHOT PROC NEAR

	;--------------------TEST----------------------
	mov ah,9 ;Display
	mov bh,0 ;Page 0
	mov al,47h ;Letter D
	mov cx,5h ;5 times
	mov bl,0FAh ;Green (A) on white(F) background
	int 10h
	;----------------------------------------------

	RET
P2_HEADSHOT ENDP


P2_BODYSHOT PROC NEAR

	;--------------------TEST----------------------
	mov ah,9 ;Display
	mov bh,0 ;Page 0
	mov al,48h ;Letter D
	mov cx,5h ;5 times
	mov bl,0FAh ;Green (A) on white(F) background
	int 10h
	;----------------------------------------------

	RET
P2_BODYSHOT ENDP

P2_LEGSHOT PROC NEAR
	;--------------------TEST----------------------
	mov ah,9 ;Display
	mov bh,0 ;Page 0
	mov al,49h ;Letter D
	mov cx,5h ;5 times
	mov bl,0FAh ;Green (A) on white(F) background
	int 10h
	;----------------------------------------------

	RET
P2_LEGSHOT ENDP


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
        mov al,hairClr 
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
        jmp fen
        
   p1:  lea si,startXY 
        lea di,endy
         
        mov bx,[si+2]
        mov [di],bx  ;ba7ot fih el starting origin w ba3d kda hazawwed tool kol 7aga
         
 fen:   mov bx,emsa7 
        cmp bx,1
        jz tq4  
        mov al,gazmaclr
        jmp eqi
   tq4: mov al,BackGndClr 
    
   eqi:
        call gazma
        call body
        
                   
        push [si+2]                 ;;gamda GEDAN
        
        call arm 
        
                         
        pop [si+2]           		;;law etshaloo 
        
        call head
        mov bx,emsa7 
        cmp bx,1
        jz p69  
        mov al,hairclr
        call gazma 
        call EYE
        ret
        
   p69: mov al,BackGndClr 
   
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
        jmp jen
        
   pot: lea si,startXY 
        lea di,endy
         
        mov bx,[si+2]
        mov [di],bx  ;ba7ot fih el starting origin w ba3d kda hazawwed tool kol 7aga
         
 jen:   mov bx,emsa7 
        cmp bx,1
        jz tu4  
        mov al,gazmaclr
        jmp eqli
   tu4: mov al,BackGndClr 
    
   eqli:
        call gazma
        call body
                
        push [si+2]          ;;gamda GEDAN
        
        call armgamboo 
        
        pop [si+2]           ;;law etshaloo 
        
        call head
        mov bx,emsa7 
        cmp bx,1
        jz p09  
        mov al,hairclr
        call gazma 
        call EYE
        ret
        
   p09: mov al,BackGndClr 
   
        call gazma 
        call EYE
        ret
        
wa7ededogambo    endp

wa7edbeykick proc near
            
        mov bx,orientate 
        cmp bx,player1
        jz p7  
        
        lea si,startXY2 
        lea di,endy2
        jmp fen2
        
   p7:  lea si,startXY 
        lea di,endy
         
        mov bx,[si+2]
        mov [di],bx  ;ba7ot fih el starting origin w ba3d kda hazawwed tool kol 7aga
         
 fen2:  mov bx,emsa7 
        cmp bx,1
        jz wt4  
        mov al,gazmaclr
        jmp wti
   wt4: mov al,BackGndClr 
    
   wti:
        call gazma
        call body
        call kick  
        
        push [si+2]         
        
        call arm
        
        pop [si+2]                   
        
        call head 
        
        mov bx,emsa7 
        cmp bx,1
        jz p0  
        mov al,hairclr
        call gazma 
        call EYE
        ret
        
   p0:  mov al,BackGndClr 
   
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
        jmp fev
        
   p4:  lea si,startXY 
        lea di,endy
         
        mov bx,[si+2]
        mov [di],bx  ;ba7ot fih el starting origin w ba3d kda hazawwed tool kol 7aga
         
 fev:   mov bx,emsa7 
        cmp bx,1
        jz p58  
        mov al,gazmaclr
        jmp col
   p58: mov al,BackGndClr 
   
  col:  call gazma
          
        sub word ptr[si],torsoheight
        sub word ptr[si],reglheight
        
        push [si+2]          ;;gamda GEDAN
        
        call arm
        
        pop [si+2]           ;;law etshaloo   
        
        add word ptr[si],torsoheight
        add word ptr[si],reglheight
        call body
        call starm                              
                                            
        call head 
        
        mov bx,emsa7 
        cmp bx,1
        jz p9  
        mov al,hairclr
        call gazma 
        call EYE
        ret
        
   p9:  mov al,BackGndClr 
   
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
        jmp feq
        
   p5:  lea si,startXY 
        lea di,endy
         
        mov bx,[si+2]
        mov [di],bx  ;ba7ot fih el starting origin w ba3d kda hazawwed tool kol 7aga
         
 feq:   mov bx,emsa7 
        cmp bx,1
        jz wr4  
        mov al,gazmaclr
        jmp wri
   wr4: mov al,BackGndClr 
    
   wri:
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
           
        mov bx,emsa7 
        cmp bx,1
        jz p97  
        mov al,hairclr
        call gazma 
        call EYE 
        
        add word ptr[si],headheight+neckheight 
        
        call starmfo2
        ret
        
   p97: mov al,BackGndClr 
   
        call gazma 
        call EYE
        
        add word ptr[si],headheight+neckheight 
        
        call starmfo2
        ret
        
wa7edbeyedrabfo2    endp

wa7edm2ambar proc near
            
        mov bx,orientate 
        cmp bx,player1
        jz p2  
        
        lea si,startXY2 
        lea di,endy2
        jmp den
        
   p2:  lea si,startXY 
        lea di,endy
         
        mov bx,[si+2]
        mov [di],bx  ;ba7ot fih el starting origin w ba3d kda hazawwed tool kol 7aga
         
 den:   mov bx,emsa7 
        cmp bx,1
        jz weq  
        mov al,gazmaclr
        jmp wati
   weq: mov al,BackGndClr 
    
   wati:
        call gazma
        call crouch 
        
        push [si+2]          ;;gamda GEDAN
        
        call arm 
        
        pop [si+2]           ;;law etshaloo 

        call head  
        
        mov bx,emsa7 
        cmp bx,1
        jz p93  
        mov al,hairclr
        call gazma 
        call EYE
        ret
        
   p93: mov al,BackGndClr 
   
        call gazma 
        call EYE
        ret
        
wa7edm2ambar    endp

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
        
        mov bx,emsa7 
        cmp bx,1
        jz p54  
        mov al,gazmaclr
        jmp ki
   p54: mov al,BackGndClr 
    
   ki: 
        add word ptr[si],reglwidth  
        
        mov bx,orientate
        cmp bx,player1
        jz  ou
        sub word ptr[si+2],kickreglheight-2
        jmp dez
        
   ou:  add word ptr[si+2],kickreglheight-2
           
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
        mov bx,orientate
        cmp bx,player1
        jz  g
        sub word ptr[di],reglwidth
        mov bx,reglheight
        
        jmp regl
        
   g:   add word ptr[di],reglwidth
        mov bx,reglheight
        
 regl:
        mov cx,[si+2]         ;Column 
        mov dx,[si]       ;Row        
        push bx
        mov bx,emsa7 
        cmp bx,1
        jz p57  
        mov al,reglclr
        jmp poi
   p57: mov al,BackGndClr 
    
   poi:
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
        mov bx,emsa7 
        cmp bx,1
        jz p5h  
        mov al,torsoclr
        jmp kit
   p5h: mov al,BackGndClr 
    
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
        mov bx,emsa7 
        cmp bx,1
        jz p52  
        mov al,torsoclr
        jmp kiw
   p52: mov al,BackGndClr 
    
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
        
        mov bx,emsa7 
        cmp bx,1
        jz p5K  
        mov al,armclr
        jmp kip
   p5K: mov al,BackGndClr 
    
   kip:
        mov bx,[si+2]
        MOV [di],bx
        mov bx,orientate
        cmp bx,player1
        jz  h
        sub word ptr[di],armheight
        mov bx,armwidth/2
                         
        jmp armlp         
                         
   h:   add word ptr[di],armheight
        mov bx,armwidth/2
        
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
        
        mov bx,emsa7 
        cmp bx,1
        jz i54  
        mov al,armclr
        jmp kr
   i54: mov al,BackGndClr 
    
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
        
        mov bx,orientate
        cmp bx,player1
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
        
        mov bx,emsa7 
        cmp bx,1
        jz t54  
        mov al,reglclr
        jmp ti
   t54: mov al,BackGndClr 
    
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
        mov bx,emsa7 
        cmp bx,1
        jz q54  
        mov al,armclr
        jmp qi
   q54: mov al,BackGndClr 
    
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
        
        add word ptr[si],armheight*3/4
                  
        mov bx,[si+2]
        MOV [di],bx
        mov bx,orientate
        cmp bx,player1
        jz  hew
        sub word ptr[di],armheight*2
        mov bx,armwidthpunchfo2/3
                         
        jmp armlopy         
                         
   hew: add word ptr[di],armheight*2
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
        
        
        mov bx,word ptr[si+2]                
        mov word ptr[di],bx  
                
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
        jz  heeg  
        dec word ptr[si+2] 
        jmp ddp
        
 heeg:  inc word ptr[si+2]
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
        cmp bx,1
        jz u54  
        mov al,skinclr
        jmp ui
   u54: mov al,BackGndClr 
    
   ui:
        mov bx,[si+2]
        MOV [di],bx    
        
        mov bx,orientate
        cmp bx,player1
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
        
        mov bx,orientate
        cmp bx,player1
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
        
        mov bx,emsa7 
        cmp bx,1
        jz r54  
        mov al,reglclr
        jmp ri
   r54: mov al,BackGndClr 
    
   ri:
        mov bx,[si+2]
        MOV [di],bx 
        mov bx,orientate
        cmp bx,player1
        jz zx
        sub word ptr[di],reglwidth
        mov bx,reglheight/2-25
        jmp regl1
        
  zx:   add word ptr[di],reglwidth      ;I add the width to starting Y-Coordinate
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
        mov bx,emsa7 
        cmp bx,1
        jz tt4  
        mov al,torsoclr
        jmp eti
   tt4: mov al,BackGndClr
    
   eti:
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
        mov bx,emsa7 
        cmp bx,1
        jz tp4  
        mov al,torsoclr
        jmp epi
   tp4: mov al,BackGndClr 
    
   epi:
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
        
        mov bx,emsa7 
        cmp bx,1
        jz pi7  
        mov al,armclr
        jmp pii
   pi7: mov al,BackGndClr 
    
   pii:
        mov bx,[si+2]
        MOV [di],bx                   ;I add the width to starting Y-Coordinate
        mov bx,orientate
        cmp bx,player1
        jz  git
        sub word ptr[di],armheight
        mov bx,armgamboowidth
        
        jmp dra3
        
   git: add word ptr[di],armheight
        mov bx,armgamboowidth
        
 dra3:
        mov cx,[si+2]         ;Column 
        mov dx,[si]       ;Row        
        
        call draw
        
        inc word ptr [si] 
        dec bx
        jnz dra3
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

END MAIN