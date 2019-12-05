include macros.inc
;.386
.MODEL COMPACT
.STACK 256

.DATA
;-------------------------------------------------------------------GAMESTATICCONFIGURATIONS---------------------------------------------
;-------------------------------------------------------------------GAME STATIC CONFIGURATIONS-------------------------------------------
;-------------------------------------------------------------------GAME STATIC CONFIGURATIONS-------------------------------------------

;SCREEN DIMENSIONS 1024X768
SCREEN_MAX_X EQU 1024
SCREEN_MAX_Y EQU 768

;BODY DIMENSIONS
eyewidth    EQU 5
torsowidth  EQU 30
gazmawidth  EQU 50 
reglwidth   EQU 30               
armwidth    EQU 70              
neckwidth   EQU 15               ;blue:1          green:2     LightBlue:3   
headwidth   EQU 40               ;red:4           purple:5    orange:6
                                 ;abyad_wese5:7   Grey:8      blueGamed:9
gazmaClr    EQU 6                ;lightGreen:10   Labany:11
ReglClr     EQU 1                ;                Yellow:14
TorsoClr    EQU 4
armClr      EQU 8
SkinClr     EQU 7 
HairClr     EQU 2  
FPEyeClr    EQU 5
SPEyeClr    EQU 14

precisionTorso EQU 6 
eyeheight      EQU 5          
nosgazmaheight EQU 10
reglheight     EQU 100 
torsoheight    EQU 70
armheight      EQU 10        
neckheight     EQU 12         
headheight     EQU 45



; KEYS SCAN CODES
ESC_KEY EQU 01H
W_KEY EQU 11H
A_KEY EQU 1EH
S_KEY EQU 1FH
D_KEY EQU 20H
SPACE_KEY EQU 39H
UP_KEY EQU 48H
RIGHT_KEY EQU 4DH
DOWN_KEY EQU 50H
LEFT_KEY EQU 4BH
Z_KEY EQU 2CH
Q_KEY EQU 10H
O_KEY EQU 18H
L_KEY EQU 26H


player1  EQU 1
player2  EQU 2

PLAYERS_DISTANCE DW 190
MAX_LEFT EQU 20
MAX_RIGHT EQU SCREEN_MAX_X - 20


RUN_STEP EQU 30
RISE_STEP EQU 20			;NOTE!: ITS VALUE HAS TO BE DIVISIBLE BY 'JUMP_STEPS' VALUE
FALL_STEP EQU 20			;NOTE!: ITS VALUE HAS TO BE DIVISIBLE BY 'JUMP_STEPS' VALUE
JUMP_STEPS EQU 200
JUMP_COUNTER_UP1 DW 0
JUMP_COUNTER_DN1 DW 0
JUMP_COUNTER_UP2 DW 0
JUMP_COUNTER_DN2 DW 0

FLAGS DW ?
IN_KEY DB ?

STNDS EQU 0
CRCH EQU 1
JMPS EQU 2

P1_X EQU word ptr[origin_p1][2]
P1_Y EQU word ptr[origin_p1][0]

P2_X EQU word ptr[origin_p2][2]
P2_Y EQU word ptr[origin_p2][0]

START_Y EQU 600
START_X_1 EQU 80
START_X_2 EQU 500 
;-----------------------------------------GAME VARIABLES-------------------------------------
;-----------------------------------------GAME VARIABLES-------------------------------------
;-----------------------------------------GAME VARIABLES-------------------------------------
;				Y   X
startXY     DW  START_Y, START_X_1
endY        DW  ?
startXY2    DW  START_Y, START_X_2  
endY2       DW  ? 
orientate   DW  1
stance      DW  0		;0-> stands & 1->crouch --> FOR DRAWING 
P1_stance      DW  0	;0-> stands & 1->crouch 2->JUMP --> FOR GAME LOGIC
P2_stance      DW  0	;0-> stands & 1->crouch 2->JUMP --> FOR GAME LOGIC


;			 Y    X
origin_p1 DW START_Y, START_X_1
origin_p2 DW START_Y, START_X_2

;----------------------------------------------CODE--------------------------------------------
;----------------------------------------------CODE--------------------------------------------
;----------------------------------------------CODE--------------------------------------------
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
			 JNZ  REPLACE_P2_2
JMP REPLACE_P2_2_NEXT
REPLACE_P2_2: JMP REPLACE_P2
REPLACE_P2_2_NEXT:
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
				JNZ  GET_KEY_2
			MOV_UP_P2:
				CMP JUMP_COUNTER_UP2, JUMP_STEPS / RISE_STEP
				JAE MOV_DN_P2
					INC JUMP_COUNTER_UP2
					CALL CLR_P2
					MOV AX, RISE_STEP
					SUB P2_Y, AX
					DRAW_P2 origin_p2, STNDS
					JMP GET_KEY
JMP GET_KEY_2_NEXT
GET_KEY_2: JMP GET_KEY
GET_KEY_2_NEXT:
			MOV_DN_P2:
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
				MOV AX, P2_X
				SUB AX, PLAYERS_DISTANCE
				CMP P1_X, AX
				JGE LOOP_END_2
					CALL CLR_P1		
					ADD P1_X, RUN_STEP
					DRAW_P1 origin_p1, STNDS
					JMP MAIN_LOOP_END
					
		;MOVE PLAYER 1 LEFT
		CHECK_P1_L:		
			CMP IN_KEY, A_KEY
			JNE CHECK_P1_DN
				
				CMP P1_X, MAX_LEFT
				JBE LOOP_END_2
					CALL CLR_P1
					MOV AX, RUN_STEP
					SUB P1_X, AX
					DRAW_P1 origin_p1, STNDS
					JMP MAIN_LOOP_END
		
JMP LOOP_END_2_NEXT
LOOP_END_2: JMP MAIN_LOOP_END
LOOP_END_2_NEXT:
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
				DRAW_P1 origin_p1, CRCH
				MOV P1_stance, CRCH
				JMP MAIN_LOOP_END
			
		;PLAYER 1 JUMP OR STANDS(IF HE WAS CROUCHING)
		CHECK_P1_UP:
			CMP IN_KEY, W_KEY
			JNE CHECK_P2_R_2
				CMP P1_stance, CRCH
				JNE P1_JUMP_BEGIN
				;P1_UP:
					MOV P1_stance, STNDS
					CALL CLR_P1	
					DRAW_P1 origin_p1, STNDS
					JMP MAIN_LOOP_END
JMP CHECK_P2_R_2_NEXT
CHECK_P2_R_2: JMP CHECK_P2_R
CHECK_P2_R_2_NEXT:
				P1_JUMP_BEGIN:
					CMP P1_stance, JMPS
					JE CHECK_P2_R
						MOV P1_stance, JMPS
						;MOV CX, JUMP_STEPS
						MOV JUMP_COUNTER_UP1, 1
					P1_JUMP:
						
						CALL CLR_P1
						MOV AX, RISE_STEP
						SUB P1_Y, AX
						DRAW_P1 origin_p1, STNDS
						;LOOP P1_JUMP
		
		;PLAYER1 ATTACK UP
		
		
;--------------------------------------------------------------------------END CHECK PLAYER 1 INPUTS-------------------------------------------------------------	
;---------------------------------------------------------------------------CHECK PLAYER 2 INPUTS----------------------------------------------------------------
		;Move player 2 right
		CHECK_P2_R:
			CMP IN_KEY, RIGHT_KEY
			JNE CHECK_P2_L
				CMP P2_X, MAX_RIGHT
				JAE LOOP_END_3
					CALL CLR_P2
					ADD P2_X, RUN_STEP
					DRAW_P2 origin_p2, STNDS
					JMP MAIN_LOOP_END
JMP LOOP_END_3_NEXT
LOOP_END_3: JMP MAIN_LOOP_END
LOOP_END_3_NEXT:					
		;MOVE PLAYER 2 LEFT
		CHECK_P2_L:		
			CMP IN_KEY, LEFT_KEY
			JNE CHECK_P2_DN
				MOV AX, P1_X
				ADD AX, PLAYERS_DISTANCE
				CMP P2_X, AX
				JBE LOOP_END_4
					CALL CLR_P2
					MOV AX, RUN_STEP					
					SUB P2_X, AX
					DRAW_P2 origin_p2, STNDS
					JMP MAIN_LOOP_END
				
		
JMP LOOP_END_4_NEXT
LOOP_END_4: JMP MAIN_LOOP_END
LOOP_END_4_NEXT:
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
				DRAW_P2 origin_p2, CRCH
				MOV P2_stance, CRCH
				JMP MAIN_LOOP_END
JMP LOOP_END_5_NEXT
LOOP_END_5: JMP MAIN_LOOP_END
LOOP_END_5_NEXT:			
		;PLAYER 2 JUMP OR STANDS(IF HE WAS CROUCHING)
		CHECK_P2_UP:
			CMP IN_KEY, UP_KEY
			JNE CHECK_ESC_2
				CMP P2_stance, CRCH
				JNE P2_JUMP_BEGIN
				;P2_UP:
					MOV P2_stance, STNDS
					CALL CLR_P2	
					DRAW_P2 origin_p2, STNDS
					JMP MAIN_LOOP_END
JMP CHECK_ESC_2_NEXT
CHECK_ESC_2: JMP CHECK_ESC
CHECK_ESC_2_NEXT:
				P2_JUMP_BEGIN:
					CMP P2_stance, JMPS
					JE CHECK_ESC
						MOV P2_stance, JMPS
						;MOV CX, JUMP_STEPS
						MOV JUMP_COUNTER_UP2, 1
					P2_JUMP:
						
						CALL CLR_P2
						MOV AX, RISE_STEP
						SUB P2_Y, AX
						DRAW_P2 origin_p2, STNDS
						;LOOP P2_JUMP	
;---------------------------------------------------------------------------END CHECK PLAYER 2 INPUTS--------------------------------------------------------


;--------------------------------------------------------------------------------EXIT------------------------------------------------------------------------
		CHECK_ESC:                                                                                                                                
			CMP IN_KEY, ESC_KEY                                                                                                                   
			JZ EXIT                                                                                                                               
;---------------------------------------------------------------------------------EXIT-----------------------------------------------------------------------


;------------------------------------------------------------------------------END MAIN LOOP-----------------------------------------------------------------
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
DELAY ENDP


CLR_P1 PROC NEAR
	PUSHA
	
	MOV AL,0					;PIXEL COLOR : BLACK
	MOV AH,0CH 					;DRAW PIXEL COMMAND
	MOV DX,ORIGIN_P1[0] 		;ROW
	MOV SI, DX
	SUB SI, nosgazmaheight * 4 + reglheight+  torsoheight + neckheight + headheight    
	
	MOV DI, ORIGIN_P1[2]
	ADD DI, ARMWIDTH * 3/2 
	LOOP_ROWS:
		MOV CX,ORIGIN_P1[2] 		;COLUMN
		SUB CX, 5	;FIXES A BUG WHEN CROUCH IS TRIGGERED
		LOOP_COLS:
			INT 10H
			INC CX
			CMP CX, DI
		JNZ LOOP_COLS
		DEC DX
		CMP DX, SI
	JNZ LOOP_ROWS

	POPA
	RET
CLR_P1 ENDP


CLR_P2 PROC NEAR
	PUSHA
	
	MOV AL,0					;PIXEL COLOR : BLACK
	MOV AH,0CH 					;DRAW PIXEL COMMAND
	MOV DX,ORIGIN_P2[0] 		;ROW
	MOV SI, DX
	SUB SI, nosgazmaheight * 4 + reglheight+  torsoheight + neckheight + headheight    
	
	MOV DI, ORIGIN_P2[2]
	SUB DI, ARMWIDTH * 3/2
	LOOP_ROWS_2:
		MOV CX,ORIGIN_P2[2] 		;COLUMN
		ADD CX, 6	;FIXES A BUG WHEN CROUCH IS TRIGGERED
		
		LOOP_COLS_2:
			INT 10H
			DEC CX
			CMP CX, DI
		JNZ LOOP_COLS_2
		DEC DX
		CMP DX, SI
	JNZ LOOP_ROWS_2

	POPA
	RET
CLR_P2 ENDP


;-------------------------------------------------------SALAMA'S CODE-----------------------------------------
;-------------------------------------------------------SALAMA'S CODE-----------------------------------------
;-------------------------------------------------------SALAMA'S CODE-----------------------------------------
;-------------------------------------------------------SALAMA'S CODE-----------------------------------------
;-------------------------------------------------------SALAMA'S CODE-----------------------------------------

ersem proc near

        
        cmp STANCE, 0
        jz sep
        call wa7edm2ambar 
        ret
         
 sep:               
        call wa7ed
         
        ret 
         
ersem endp    

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
         
 fen:   mov al,gazmaClr
        call gazma
        call body  
        
        mov bx,[si+2]           ;;gamda 
        push bx                 ;;GDN
        
        call arm 
        
        pop bx                  ;;law
        mov [si+2],bx           ;;etshaloo
        
        call head
        mov al,hairClr 
        call gazma 
        call EYE
        ret
        
wa7ed    endp

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
         
 den:   mov al,gazmaClr
        call gazma
        call crouch
        mov bx,[si+2]           ;;gamda 
        push bx                 ;;GDN
        
        call arm 
        
        pop bx                  ;;law
        mov [si+2],bx           ;;etshaloo
        call head
        mov al,hairClr 
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
        
        mov al,reglClr         ;Pixel color 
        call draw
        
        dec word ptr [si] 
        dec bx
        jnz regl
        
        mov bx,[si+2]
        MOV [di],bx
        mov bx,orientate
        cmp bx,player1
        jz  p
        sub word ptr[di],reglwidth
        mov bx,torsoheight;*2/3
        jmp torso
        
   p:   add word ptr[di],reglwidth
        mov bx,torsoheight;*2/3   
         
        
 torso:
        mov cx,[si+2]         ;Column 
        mov dx,[si]           ;Row
                 
        mov al,torsoClr        ;Pixel color
        call draw
        dec word ptr [si]  
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
                    
                    
        
        ret
 body endp

arm proc near 
        
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
        mov al,armClr         ;Pixel color 
        call draw
        inc word ptr [si]
        push bx
         
        mov bx,orientate
        cmp bx,player1
        jz  zed    
        
        
  pok:  
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
        mov al,armClr         ;Pixel color 
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

head proc near
        
        mov al,SkinClr         ;Pixel color 
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
     mov al,SPEyeClr
     mov bx,eyeheight
     
     jmp eyeLp
     
fert:
     add word ptr[di],eyewidth+headwidth*3/4 
     add word ptr[si+2],headwidth*3/4
     mov al,FPEyeClr
     mov bx,eyeheight
     
eyeLp:
     mov cx,[si]+2         ;Column 
     mov dx,[si]       ;Row   
     
     
     call draw
     dec word ptr [si] 
     dec bx
     jnz eyeLp
   
    ret 
    
Eye endp    
              
              
Crouch proc near       
    
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
        mov al,reglClr         ;Pixel color 
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
        mov al,reglClr   ;Pixel color 
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
        sub word ptr[di],torsowidth    ;I add the width to starting Y-Coordinate
        mov bx,torsoheight*3/4 
        jmp torso2
  
 ji:    pop bx
        
        dec word ptr [si+2]
        dec word ptr[di]  
        dec bx
        jnz regl2
      
        inc word ptr [si+2]
        mov bx,[si+2]
        MOV [di],bx
        add word ptr[di],torsowidth    ;I add the width to starting Y-Coordinate
        mov bx,torsoheight*3/4   
        

 torso2:
        mov cx,[si+2]         ;Column 
        mov dx,[si]       ;Row
        
        mov al,torsoClr
        call draw
        dec word ptr [si]
        push bx 
        mov ah,0
        mov al,bl
        mov bl,precisionTorso-2
        div bl 
        pop bx
        cmp ah,0
        jnz ta7t2   
        
        push bx
        mov bx,orientate
        cmp bx,player1
        jz z  
        pop bx
        dec word ptr [di]  
        jmp ta7t2
  
  z:    
        pop bx
        inc word ptr [di]
 ta7t2: dec bx
        jnz torso2 
                                     
        ret         
        
crouch endp
           
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
           jnz back 
           pop bx
           ret  
           
    ymeen: 
           inc cx      
           cmp cx,[di]        
           jnz back  
           
           pop bx
           ret
draw endp
;----------------------------------------------------------------------END OF SALAMA'S CODE-------------------------------------------------------------------
;----------------------------------------------------------------------END OF SALAMA'S CODE-------------------------------------------------------------------
;----------------------------------------------------------------------END OF SALAMA'S CODE-------------------------------------------------------------------
;----------------------------------------------------------------------END OF SALAMA'S CODE-------------------------------------------------------------------
;----------------------------------------------------------------------END OF SALAMA'S CODE-------------------------------------------------------------------
;----------------------------------------------------------------------END OF SALAMA'S CODE-------------------------------------------------------------------
;----------------------------------------------------------------------END OF SALAMA'S CODE-------------------------------------------------------------------
END MAIN