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
