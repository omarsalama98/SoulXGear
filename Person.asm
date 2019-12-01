        .MODEL Large
        .STACK 64
        .DATA
startXY     DW  600,80
endY        DW  ?
startXY2    DW  600,500  
endY2       DW  ? 
orientate   DW  1
ambar       DW  1 
           
player1  EQU 1
player2  EQU 2

torsowidth  EQU 37
gazmawidth  EQU 50 
reglwidth   EQU 30               
armwidth    EQU 120              ;abyad wese5:7  blueGamed:9
neckwidth   EQU 15               ;blue:1   purple:5   orange:6 
headwidth   EQU 40              ;red:4  green:2  LightBlue:3  

gazmaClr    EQU 8
ReglClr     EQU 1
TorsoClr    EQU 4
armClr      EQU 8
SkinClr     EQU 7 
HairClr     EQU 9

precisionTorso EQU 6           
nosgazmaheight EQU 10
reglheight     EQU 100 
torsoheight    EQU 70
armheight      EQU 10        
neckheight     EQU 12         
headheight     EQU 45         
               
        .code
MAIN    PROC FAR               
        MOV AX,@DATA
        MOV DS,AX    
                              ;ba5od fel SI starting X,Y w fel DI el end(betkoon '?' ) 
                              
                              ;ay bx thickness bta3et el 7aga elly btetresem 
        mov ax,4f02h
        mov bx,105h 
        int 10h
         
        mov bx,ambar 
        call ersem 
        
        lea bx,orientate
        mov byte ptr[bx],2 
        
        mov bx,ambar 
        call ersem                     
        
        hlt 
        mov ah,4ch
        int 21h 
        
MAIN    ENDP  


ersem proc near

        
        cmp bx,0
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
        call arm
        call head
        mov al,hairClr 
        call gazma
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
        call arm
        call head
        mov al,hairClr 
        call gazma
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
        mov bx,torsoheight*2/3
        jmp torso
        
   p:   add word ptr[di],reglwidth
        mov bx,torsoheight*2/3   
         
        
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
                    
                    
        mov bx,torsoheight/3
 torso2:
        mov cx,[si+2]         ;Column 
        mov dx,[si]       ;Row
        
        mov al,torsoClr
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
 body endp

arm proc near 
        
        mov bx,[si+2]
        MOV [di],bx
        mov bx,orientate
        cmp bx,player1
        jz  h
        sub word ptr[di],armwidth
        mov bx,armheight
                         
        jmp armlp         
                         
   h:   add word ptr[di],armwidth
        mov bx,armheight
        
 armlp:
        mov cx,[si+2]         ;Column 
        mov dx,[si]       ;Row
        mov al,armClr         ;Pixel color 
        call draw
        dec word ptr [si]
        dec bx
        jnz armlp
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
        mov bx,torsoheight*1/5 
        jmp torso1
  
 ji:    pop bx
        
        dec word ptr [si+2]
        dec word ptr[di]  
        dec bx
        jnz regl2
      
        inc word ptr [si+2]
        mov bx,[si+2]
        MOV [di],bx
        add word ptr[di],torsowidth    ;I add the width to starting Y-Coordinate
        mov bx,torsoheight*1/5   
        
 torso1:
        mov cx,[si+2]         ;Column 
        mov dx,[si]       ;Row
        mov al,torsoClr   ;Pixel color 
        mov ah,0ch        ;Draw Pixel Command
        call draw
        dec word ptr [si] 
          
        dec bx
        jnz torso1  
        mov bx,torsoheight*1/3 
        
 torso3:
        mov cx,[si+2]       ;Column 
        mov dx,[si]         ;Row
        mov al,torsoClr     ;Pixel color 
        call draw
        dec word ptr [si] 
        
        push bx
        mov bx,orientate
        cmp bx,player1
        jz  ij
        pop bx    
        
        dec word ptr [si+2]
        sub word ptr[di],2  
        dec bx
        jnz torso3
        ret  
        
 ij:    pop bx
        inc word ptr [si+2]
        add word ptr[di],2  
        dec bx
        jnz torso3
                                     
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
