;-------------------------------------------------MACROS--------------------------------------------------
;PUSH ALL REGISTERS
PUSHA MACRO
	PUSH AX
	PUSH CX 
	PUSH DX
	PUSH BX
	PUSH SP
	PUSH BP
	PUSH SI
	PUSH DI
ENDM PUSHA


;POP ALL REGISTERS
POPA MACRO
	POP DI
	POP SI
	POP BP 
	POP SP
	POP BX
	POP DX
	POP CX
	POP AX
ENDM POPA

;---------------------------------------------------------------------------------------------------------
DRAW_P1 MACRO IN_XY, IN_ST 
	PUSHA
	
	MOV AX, word ptr[IN_XY][0]
	MOV word ptr[startXY][0], AX
	MOV AX, word ptr[IN_XY][2]
	MOV word ptr[startXY][2], AX
	
	MOV orientate, player1
	MOV AX, IN_ST
	MOV stance, AX
	CALL ersem

	POPA
ENDM DRAW_P1
;------------------------------------------------------------------------------
DRAW_P2 MACRO IN_XY, IN_ST
PUSHA
	PUSHA
	
	MOV AX, word ptr[IN_XY][0]
	MOV word ptr[startXY2][0], AX
	MOV AX, word ptr[IN_XY][2]
	MOV word ptr[startXY2][2], AX
	
	MOV orientate, player2
	MOV AX, IN_ST
	MOV stance, AX
	CALL ersem

	POPA

POPA
ENDM DRAW_P2
;--------------------------------------------------------------------------------
DRAW_P1_HEARTS MACRO HEARTS_NUM

	PUSHA
	
	MOV WORD PTR [P1HeartsXY][0], P1HEARTS_Y
	MOV WORD PTR [P1HeartsXY][2], P1HEARTS_X
	
	MOV P1P2HEARTS, PLAYER1

	MOV AX, 3
	MOV P1HeartsLeft, AX
	
	MOV EMSA7HEARTS, 1
	CALL DRAWHEARTS
	MOV EMSA7HEARTS, 0
	
	MOV WORD PTR [P1HeartsXY][0], P1HEARTS_Y
	MOV WORD PTR [P1HeartsXY][2], P1HEARTS_X
	
	MOV AX, HEARTS_NUM
	MOV P1HeartsLeft, AX
	
	CALL DRAWHEARTS
	

	POPA
ENDM DRAW_P1_HEARTS
;--------------------------------------------------------------------------------
DRAW_P2_HEARTS MACRO HEARTS_NUM
	PUSHA
	
	MOV WORD PTR [P2HeartsXY][0], P2HEARTS_Y
	MOV WORD PTR [P2HeartsXY][2], P2HEARTS_X
	
	MOV P1P2HEARTS, PLAYER2

	MOV AX, 3
	MOV P1HeartsLeft, AX
	
	MOV EMSA7HEARTS, 1
	CALL DRAWHEARTS
	MOV EMSA7HEARTS, 0
	
	MOV WORD PTR [P2HeartsXY][0], P2HEARTS_Y
	MOV WORD PTR [P2HeartsXY][2], P2HEARTS_X
	
	MOV AX, HEARTS_NUM
	MOV P2HeartsLeft, AX
	
	CALL DRAWHEARTS
	

	POPA
ENDM DRAW_P2_HEARTS

;----------------------------------------------------------------------------------


PRINT_SENT MACRO INPUT_KEY_ASCII
	LOCAL NOT_EOL_S
	LOCAL LF_CR_S
	LOCAL P_S_MACRO_END
	LOCAL NOT_BKSPC
	PUSHA
	
	CMP INPUT_KEY_ASCII, Enter_Key
	JE LF_CR_S
		MOV DH, CURSOR_SEND_Y
		MOV DL, CURSOR_SEND_X
		MOV BH, 0
		MOV AH, 2
		INT 10H
		
		MOV AL, INPUT_KEY_ASCII
		CMP AL, 08H
		JNE NOT_BKSPC
		CMP DL, 0
		JE P_S_MACRO_END
		DEC DL
		MOV BH, 0
		MOV AH, 2
		INT 10H
		MOV AL, ' '				;AL = character to display.
		MOV BH, 0							;BH = page number.
		MOV BL, CLR_ATTR_SEND				;BL = attribute.
		MOV CX,1							;CX = number of times to write character.
		MOV AH, 09
		INT 10H 
		MOV BH, 0
		MOV AH, 2
		INT 10H

		MOV CURSOR_SEND_Y, DH
		MOV CURSOR_SEND_X, DL
		JMP P_S_MACRO_END

NOT_BKSPC:
		MOV AL, INPUT_KEY_ASCII				;AL = character to display.
		MOV BH, 0							;BH = page number.
		MOV BL, CLR_ATTR_SEND				;BL = attribute.
		MOV CX,1							;CX = number of times to write character.
		MOV AH, 09
		INT 10H
		
		
		INC CURSOR_SEND_X
		CMP CURSOR_SEND_X, WindWidth
		JB NOT_EOL_S
		LF_CR_S: 						;LINE FEED AND CARRIAGE RETURN
			INC CURSOR_SEND_Y
			MOV CURSOR_SEND_X, 0
		NOT_EOL_S:
		CMP CURSOR_SEND_Y, (WindHeight-1)/2 - 1
		JBE	P_S_MACRO_END
			;SCROLL UP
			MOV AH,6       				; FUNCTION 6
			MOV AL,1        			; SCROLL BY 1 LINE   
			MOV BH,CLR_ATTR_SEND      	; NORMAL VIDEO ATTRIBUTE  (BLUE)       
			MOV CH,1       				; UPPER LEFT Y
			MOV CL,0       				; UPPER LEFT X
			MOV DH,11     				; LOWER RIGHT Y
			MOV DL,79     				; LOWER RIGHT X
			INT 10H
			MOV CURSOR_SEND_Y, (WindHeight-1)/2 - 1
P_S_MACRO_END:
	POPA
ENDM PRINT_SENT

PRINT_RECEIVED MACRO INPUT_KEY_ASCII
	LOCAL NOT_EOL_R
	LOCAL LF_CR_R
	LOCAL P_R_MACRO_END
	LOCAL NOT_BKSPC
	PUSHA
	
	CMP INPUT_KEY_ASCII, Enter_Key
	JE LF_CR_R
		MOV DH, CURSOR_RECEIVE_Y
		MOV DL, CURSOR_RECEIVE_X
		MOV BH, 0
		MOV AH, 2
		INT 10H

		MOV AL, INPUT_KEY_ASCII
		CMP AL, 08H
		JNE NOT_BKSPC
		CMP DL, 0
		JE P_R_MACRO_END
		DEC DL
		MOV BH, 0
		MOV AH, 2
		INT 10H
		MOV AL, ' '				;AL = character to display.
		MOV BH, 0							;BH = page number.
		MOV BL, CLR_ATTR_RECEIVE				;BL = attribute.
		MOV CX,1							;CX = number of times to write character.
		MOV AH, 09
		INT 10H 
		MOV BH, 0
		MOV AH, 2
		INT 10H

		MOV CURSOR_RECEIVE_Y, DH
		MOV CURSOR_RECEIVE_X, DL
		JMP P_R_MACRO_END

NOT_BKSPC:
		
		MOV AL, INPUT_KEY_ASCII				;AL = character to display.
		MOV BH, 0							;BH = page number.
		MOV BL, CLR_ATTR_RECEIVE							;BL = attribute.
		MOV CX,1							;CX = number of times to write character.
		MOV AH, 09
		INT 10H
		
		
		INC CURSOR_RECEIVE_X
		CMP CURSOR_RECEIVE_X, WindWidth
		JB NOT_EOL_R
		LF_CR_R: 							;LINE FEED AND CARRIAGE RETURN
			INC CURSOR_RECEIVE_Y
			MOV CURSOR_RECEIVE_X, 0
		NOT_EOL_R:
		CMP CURSOR_RECEIVE_Y, (WindHeight-1)
		JBE	P_R_MACRO_END
			;SCROLL UP
			MOV AH,6       					; FUNCTION 6
			MOV AL,1        				; SCROLL BY 1 LINE   
			MOV BH,CLR_ATTR_RECEIVE      	; NORMAL VIDEO ATTRIBUTE  (BLUE)       
			MOV CH,13       				; UPPER LEFT Y
			MOV CL,0       					; UPPER LEFT X
			MOV DH,24     					; LOWER RIGHT Y
			MOV DL,79     					; LOWER RIGHT X
			INT 10H
			MOV CURSOR_RECEIVE_Y, (WindHeight-1)
P_R_MACRO_END:
	POPA
ENDM PRINT_RECEIVED


UART_SEND MACRO KEY
LOCAL AGAIN
	PUSHA
	
	
	;CHECK THAT TRANSMITTER HOLDING REGISTER IS EMPTY
	MOV DX , 3FDH			; LINE STATUS REGISTER
AGAIN:  
	IN AL , DX 				;READ LINE STATUS
	TEST AL , 00100000B
	JZ AGAIN             	;NOT EMPTY

	;IF EMPTY PUT THE VALUE IN TRANSMIT DATA REGISTER
	MOV DX , 3F8H			; TRANSMIT DATA REGISTER
	MOV  AL,KEY
	OUT DX , AL
	
	
	POPA
ENDM UART_SEND
