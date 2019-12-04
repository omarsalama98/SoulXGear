        .MODEL Large
        .STACK 64
        .DATA
startXY     DW  600,80
endY        DW  ?
startXY2    DW  600,500  
endY2       DW  ? 
orientate   DW  1
stance      DW  0 
           
player1  EQU 1
player2  EQU 2

eyewidth    EQU 5
torsowidth  EQU 30
gazmawidth  EQU 50 
reglwidth   EQU 25               
armwidth    EQU 70              
neckwidth   EQU 15               ;blue:1          green:2     LightBlue:3   
headwidth   EQU 40               ;red:4           purple:5    orange:6
                                 ;abyad_wese5:7   Grey:8      blueGamed:9
gazmaClr    EQU 6                ;lightGreen:10   Labany:11
ReglClr     EQU 1                ;                Yellow:14
TorsoClr    EQU 4
armClr      EQU 8
SkinClr     EQU 7 
HairClr     EQU 9  
FPEyeClr    EQU 5
SPEyeClr    EQU 14

precisionTorso  EQU 8
precisionTorso2 EQU 2 
eyeheight       EQU 5          
nosgazmaheight  EQU 10
reglheight      EQU 100 
torsoheight     EQU 70
armheight       EQU 10        
neckheight      EQU 12         
headheight      EQU 45         
               
        .code
MAIN    PROC FAR               
        MOV AX,@DATA
        MOV DS,AX    
                              ;ba5od fel SI starting X,Y w fel DI el end(betkoon '?' ) 
                              
                              ;ay bx thickness bta3et el 7aga elly btetresem 
        mov ax,4f02h
        mov bx,105h 
        int 10h
         
          
        call ersem 
        
        lea bx,orientate
        mov byte ptr[bx],2 
        
        
        call wa7edbeyedrab                     
        
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
        call wa7edbeyedrab
         
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
        push bx                 ;;fash5
        
        call arm 
        
        pop bx                  ;;law
        mov [si+2],bx           ;;etshaloo
        
        call head
        mov al,hairClr 
        call gazma 
        call EYE
        ret
        
wa7ed    endp

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
         
 fev:   mov al,gazmaClr
        call gazma
          
        sub word ptr[si],torsoheight
        sub word ptr[si],reglheight
        
        mov bx,[si+2]           ;;gamda 
        push bx                 ;;fash5
        
        call arm
         
        pop bx                  ;;law
        mov [si+2],bx           ;;etshaloo  
        
        add word ptr[si],torsoheight
        add word ptr[si],reglheight
        call body
        call starm                              
                                            
        call head
        mov al,hairClr 
        call gazma   
        
        call EYE
        ret
        
wa7edbeyedrab    endp

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
        push bx                 ;;fash5
        
        call arm 
        
        pop bx                  ;;law
        mov [si+2],bx           ;;etshaloo
            
        call starm
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
        mov bx,torsoheight*3/4
        jmp torso
        
   p:   add word ptr[di],reglwidth
        mov bx,torsoheight*3/4 
         
        
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
        
        mov bx,torsoheight*1/4
        
 torso3:
        mov cx,[si+2]         ;Column 
        mov dx,[si]           ;Row
                 
        mov al,torsoClr        ;Pixel color
        call draw
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


starm proc near 
        
        mov bx,[si+2]
        MOV [di],bx
        mov bx,orientate
        cmp bx,player1
        jz  he
        sub word ptr[di],armwidth*3/2
        mov bx,armheight*3/4
                         
        jmp armlop         
                         
   he:  add word ptr[di],armwidth*3/2
        mov bx,armheight*3/4
        
 armlop:
        mov cx,[si+2]         ;Column 
        mov dx,[si]       ;Row
        mov al,armclr         ;Pixel color 
        call draw
        dec word ptr [si]
        dec bx
        jnz armlop 
        
        add word ptr[si],armheight   
        
        mov bx,orientate
        cmp bx,player1
        jz  her  
        
        sub word ptr[si+2],armwidth*3/2  
        mov bx,[si+2]
        MOV [di],bx
        sub word ptr[di],armwidth/6
        mov bx,armheight*5/4
                         
        jmp boxlop         
                         
   her: add word ptr[si+2],armwidth*3/2  
        mov bx,[si+2]
        MOV [di],bx
        add word ptr[di],armwidth/6
        mov bx,armheight*5/4  
        
  boxlop:
        mov cx,[si+2]         ;Column 
        mov dx,[si]       ;Row
        mov al,4         ;Pixel color 
        call draw
        dec word ptr [si]
        dec bx
        jnz boxlop    
        
        add word ptr[si],armheight/4 
                   
        mov bx,orientate
        cmp bx,player1
        jz  hert  
        
        add word ptr[si+2],armwidth*3/2  
        
        ret
        
 hert:  sub word ptr[si+2],armwidth*3/2     
                   
        ret  
        
 starm endp


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
        add word ptr[di],torsowidth    ;I add the width to starting Y-Coordinate
        mov bx,torsoheight*2/3   
        

  torso2:
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
                 
        mov al,torsoClr        ;Pixel color
        call draw
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



        END MAIN