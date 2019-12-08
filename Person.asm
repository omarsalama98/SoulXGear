        .MODEL Large
        .386
        .STACK 64
        .DATA 

ScreenEndCol    EQU 1024
ScreenEndRow    EQU 768    
GroundStart     EQU 500          ;Rows
GroundHeight    EQU 100
HeartsStart     EQU 100          ;Rows
HeartsHeight    EQU 20

GroundXY    DW  500,0
GroundEnd   DW  ?

P1HeartsXY    DW  100,50
P1HeartsEnd   DW  ? 
P1HeartsLeft  DW  2

P2HeartsXY    DW  100,974
P2HeartsEnd   DW  ?
P2HeartsLeft  DW  1

P1P2Hearts    DW  1
        
startXY     DW  500,270
endY        DW  ?
startXY2    DW  500,500                   
endY2       DW  ?                         
orientate   DW  1                         
stance      DW  0                         
Emsa7       DW  0         ;Variable to clear player                
                                          
player1  EQU 1                               
player2  EQU 2                              
                                          
eyewidth          EQU 5                            
torsowidth        EQU 25                     
gazmawidth        EQU 50                                                               
reglwidth         EQU 22
armgamboowidth    EQU 90        ;Widths are generally the length of the body parts   
armwidth          EQU 80        ;But they were called this way as everything was sideways
armwidthpunch     EQU 110
armwidthpunchfo2  EQU 90        ;zawwed hena 3shan el punch fo2 bas elly tetzabbat    
neckwidth         EQU 15                 
headwidth         EQU 40
fingerwidth       EQU 3 
boxwidth          EQU 22



GroundClr   EQU 14                     ;Navy:1         Green:2     LightBlue:3 
BackGndClr  EQU 3                                 
gazmaClr    EQU 6                      ;Maroon:4       Purple:5    Brown:6      
ReglClr     EQU 1                           
TorsoClr    EQU 4                      ;Silver:7       Gray:8      Blue:9      
armClr      EQU 8                           
SkinClr     EQU 7                      ;Lime:10        Aqua:11     Red:12  
HairClr     EQU 9                                
FPEyeClr    EQU 5                      ;Fuchsia:13     Yellow:14
SPEyeClr    EQU 14
HeartsClr   EQU 12

precisionTorso  EQU 8
precisionTorso2 EQU 2 
eyeheight       EQU 5          
nosgazmaheight  EQU 10
kickreglheight  EQU 120 
reglheight      EQU 100 
torsoheight     EQU 70
armheight       EQU 10        
neckheight      EQU 12         
headheight      EQU 45
knucklesheight  EQU 4
         
               
        .code
MAIN    PROC FAR               
        MOV AX,@DATA
        MOV DS,AX    
                              ;ba5od fel SI starting X,Y w fel DI el end(betkoon '?' ) 
                              
                              ;ay bx thickness bta3et el 7aga elly btetresem 
        mov ax,4f02h
        mov bx,105h 
        int 10h
         
        call Background
        call DrawHearts  
        
        lea bx,P1P2Hearts
        mov byte ptr[bx],2 
        
        call DrawHearts
         
        call ersem 
        
        lea bx,orientate
        mov byte ptr[bx],2 
        
        
        call wa7edm2ambar
        
                           
        
;	Press any key to exit  
               
		MOV AH , 0
		INT 16h
                       
;Change to Text MODE   

		MOV AH,0          
		MOV AL,03h
		INT 10h 

; return control to operating system     

		MOV AH , 4ch
		INT 21H 
        
MAIN    ENDP  


ersem proc near
                                                                   
        
        cmp stance,0
        jz sep
        call wa7edm2ambar 
        ret
         
 sep:               
        call wa7ededogambo
        
        
         
        ret 
         
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
        
        lea bx,orientate
        mov byte ptr[bx],1
        
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
        mov bx,HeartsHeight/2
        mov al,HeartsClr 
        
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
        mov bx,HeartsHeight/4
        mov al,HeartsClr    
         
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
         
        mov bx,HeartsHeight/4
        mov al,HeartsClr     
            
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
        
        mov bx,[si+2]           ;;gamda 
        push bx                 ;;fash5
        
        call arm 
        
        pop bx                  ;;law
        mov [si+2],bx           ;;etshaloo 
        
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
                
        push [si+2]          ;;gamda fash5
        
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
        
        push [si+2]          ;;gamda fash5
        
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
        
        push [si+2]          ;;gamda fash5
        
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


        END MAIN