								.MODEL SMALL
								.STACK 64
					.DATA
SCOL	EQU		5
GCOL	EQU		10
XCOL	EQU		8
BOTCOL	EQU		0
					.CODE
MAIN	PROC FAR
		MOV AX, @DATA
		MOV DS, AX
		
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
		
		MOV AL, BOTCOL
		
MAIN_LOOP:
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
		
		MOV CX, 65535
		DELAY:
			LOOP DELAY
		
		MOV AH,1
		INT 16H
		JZ MAIN_LOOP

		MOV AH, 0
		MOV AL, 13H
		INT 10H
		
		MOV AX, 4C00H
		INT 21H
MAIN	ENDP
		
		; Define procedures here				
		
SFIRST		PROC	NEAR
		; CONSTANTS THROUGH ENTIRE PROC		CX column, DX row, AL color, AH = 0CH, INT 10H
		MOV AL, SCOL
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
		MOV AL, SCOL
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
		MOV AL, SCOL
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
		MOV AL, SCOL
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
		MOV AL, SCOL
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

		MOV AL, GCOL
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

		MOV AL, GCOL
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

		MOV AL, GCOL
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

		MOV AL, GCOL
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

		MOV AL, GCOL
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

		MOV AL, XCOL
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

		MOV AL, XCOL
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

		END MAIN