Title 2 u�duoties pavyzdys (c) 2002 Irmantas Naujikas

.model small	; programos mod�lis; "small" - nedidel�m programom
.stack 1000	; stekas
.data		; �ia apra�omas duomen� segmentas

  MAX_WIDTH  dw 320
  MAX_HEIGHT dw 200

  ineil  db 40, 41 dup(0)            ;  klav. skait. buferis

.code

  main proc
    mov ax,@data                    ; ds registro iniciavimas
    mov ds, ax                      ;

    mov ah, 0			    ; �jungiam 320x200 grafin� re�im�
    mov al, 13h
    int 10h

    mov ax, 0a000h		    ; grafin�s atminties segmentas
    mov es, ax

    ; pai�ysim trikamp�

    mov cx, 100                     ; statinio ilgis pikseliais
    mov bx, 10			    ; x - pradin� koordinat�
    mov ax, 10			    ; y - pradin� koordinat�
    mov dh, 0			    ; pradin� spalva

ciklas:
    push cx ax bx dx		    ; i�saugom registrus
    call Hlinija		    ; pai�om linij�
    pop dx bx ax cx
    inc dh			    ; kei�iam spalv�
    inc ax			    ; kei�iam y koordinat�
    loop ciklas

    ; analogi�kai pai�om kvadrat�

    mov cx, 100
    mov bx, 120
    mov ax, 10
    mov dh, 0

ciklas2:
    push cx ax bx dx	
    mov cx, 100
    call Vlinija
    pop dx bx ax cx
    inc dh
    inc bx
    loop ciklas2


    ; laukiam kol bus paspaustas "enter"
    call ivedimas                   ; duomenu ivedimas

    mov ah, 0			    ; �jungiam tekstin� re�im�
    mov al, 3h
    int 10h

galas:
    mov ah, 4ch                     ; baigiam programa ir griztam i os
    int 21h                         ;
  endp

  ivedimas proc                     ; nuskaito eilute is klaviaturos
    mov dx, offset ineil            ;
    mov ah, 0ah                     ; skaitome is klaviaturos
    int 21h                         ;
    ret
  endp


  Hlinija proc                      ; bx, ax - x, y koordinates; cx - kiekis; dh - spalva
     push dx

     mul MAX_WIDTH
     add bx, ax
     mov di, bx

     pop dx
     mov al, dh

     rep stosb

     ret
  endp

  Vlinija proc                      ; bx, ax - x, y koordinates; cx - kiekis; dh - spalva
     push dx

     mul MAX_WIDTH
     add bx, ax
     mov di, bx

     pop dx

    vciklas:
     mov es:[di], dh
     add di, MAX_WIDTH
     loop vciklas

     ret
  endp


END