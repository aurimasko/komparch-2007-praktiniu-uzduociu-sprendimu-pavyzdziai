.model small
.stack
.code
   Mov ah,00h              ; � registr� AH �ra�oma komanda, kuri nustato grafin� re�im�
   Mov al,13               ; � registr� AL nustatomas pats grafinis re�imas (�iuo atveju 320x200)
   Int 10h                 ; �vykdomas grafinis pertraukimas

   Mov ah,0ch              ; � registr� AH �ra�omas komandos kodas, kuris nurodo, jog bus �dedamas� ta�kas 
   Mov al,01               ; � registr� AL nurodomas ta�ko spalvos kod� (�iuo atveju raudon�)
   Mov cx,110              ; � CX registr� nustatoma ta�ko X koordinat� ekrane
   Mov dx,50               ; � DX registr� nustatoma ta�ko Y koordinat� ekrane
   Vert:                   ; pradedu cikl�, pie�iant� vertikalius keturkampio kra�tus
      Mov cx,110           ; nustatomos X koordinat�s
      Int 10h              ; i��aukiamas petraukimas � padedamas ta�kas
      Mov cx,210
      Int 10h
      Inc dx               ; didinama DX reik�m� � didinama y koordinat�
      Cmp dx,150           ; tikrinama ar baigti cikl� (DX did�ja iki 150)
      Jng Vert             ; per�okama � eilut� �Vert:� jei DX yra ne didesnis u� 150
;---------------------
   Mov dx,50               ; atstatomos pradin�s DX ir CX reik�m�s
   Mov cx,110
;---------------------
   Horiz:                  ; analogi�kai pie�iamos horizontalios keturkampio linijos
      Mov dx,50            ; tik �� kart� nustomos Y koordinat�s i DX registr�
      Int 10h
      Mov dx,150
      Int 10h
      Inc cx               ; ir didinama CX rei�m� � X koordinat�
      Cmp cx,210
      Jng Horiz
;---------------------
   Mov dx,50               ; v�lgi atstatomos pradin�s reik�m�s
   Mov cx,110
;---------------------
   Tusuot:                 ; ciklas skirtas u�tu�uoti puse kvadrato
      Push cx              ; CX registro reik�m� pasidedama i steko vir��n�
      Linija:              ; ciklas skirtas nubr��ti linij� 
         Inc cx            ; didinama CX reik�m�, kuri nurodo ta�ko X koordinat� (formuojama linija)
         Int 10h
         Cmp cx,209        ; patikrinama ar ta�ko X koordinat� nedidesn� u� 209
         Jng Linija        ; jei ma�esn� � gry�tama i pociklio �Linija:� prad�i�
      Inc dx               ; didinama DX reik�m� � Y koordinat�
      Pop cx               ; nuskaitoma CX reik�m� i� steko vir��n�s
      Inc cx               ; padidinama CX reik�m� (tai reikalinga sukurti ��stri�ain�)
      Cmp dx,149           ; tikrinama ar dar nereikia baigti darbo � Y nedidesnis u� 149
      Jng Tusuot           ; jei ne didesnis � tai gry�tama � ciklo �Tusuot:� prad�i�
;---------------------
 
   Mov ah,00h              ; � AH regist� nustatoma komanda skirta laukti klavi�o nuspaudimo
   Int 16h                 ; vykdomas klaviat�ros pertraukimas
 
   Mov ah,00h              ; � AH registr� �ra�oma komanda, kuri nustato grafin� re�im�
   Mov al,03               ; atstatomas normalaus texto re�imas
   Int 10h                 ; i��aukiamas pertraukimas
 
   Mov ah,4ch              ; nustatomas programos baigimo kodas
   Int 21h                 ; i��aukiamas DOS pertraukimas
End
