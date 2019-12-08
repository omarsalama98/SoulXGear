; EXPORT MY SELF
PUBLIC HP_BAR_FUNCTION
PUBLIC P1_HEADSHOT
PUBLIC P1_BODYSHOT
PUBLIC P1_LEGSHOT
PUBLIC P2_HEADSHOT
PUBLIC P2_BODYSHOT
PUBLIC P2_LEGSHOT
; VARIABLE WHICH ARE DECLARED IN MAIN PROGRAM
                                EXTRN PLAYER1_HP:WORD
                                EXTRN PLAYER2_HP:WORD
                                EXTRN GAME_OVER:WORD
                                
;----------------------------------------------------------------------------------------------------------------------
                                                .MODEL SMALL
                                ; CONSTANTS FOR USAGE
                                ; marron->4, yellow->14, green->2

SCREEN_WIDTH            EQU         1024
SCREEN_HEIGHT           EQU         768
MAX_HP                  EQU         20
HALF_HP                 EQU         MAX_HP/2
QUARTER_HP              EQU         MAX_HP/4
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

DMG_LEGSHOT             EQU         1
DMG_BODYSHOT            EQU         2
DMG_HEADSHOT            EQU         3

                                .CODE
HP_BAR_FUNCTION    PROC    FAR

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

P1_HEADSHOT     PROC    FAR

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

P1_BODYSHOT     PROC    FAR

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

P1_LEGSHOT     PROC    FAR

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

P2_HEADSHOT     PROC    FAR

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

P2_BODYSHOT     PROC    FAR

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

P2_LEGSHOT     PROC    FAR

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

END