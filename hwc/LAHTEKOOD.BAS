DECLARE SUB algusvideo ()
DECLARE SUB addaddress (aadress$)
DECLARE SUB showtabel (kask$)
DECLARE SUB mission8kommentaar ()
DECLARE FUNCTION mission6kuulutus$ ()
DECLARE SUB mission6 (ohoo$)
DECLARE SUB vordleinput (nimi$, YY%, x1%, x2%, varv%)
DECLARE SUB mission2 (ohoo1$)
DECLARE SUB LoadSaveGame (kask$)
DECLARE SUB savemission (fail$)
DECLARE SUB loadmission (nimi$)
DECLARE FUNCTION FUNCTIONpunktid$ (kask$, muutujanimi$, muutujavaartus$)
DECLARE SUB MissionStartEnd (text$)
DECLARE FUNCTION muutujaSTRINGsub$ (kask$, muutujanimi$, muutujavaartus$)
DECLARE SUB makecheckbox (x1%, y1%, nr%, enabled%)
DECLARE SUB lataIDedit (id%, vaartus%)
DECLARE SUB mission1 (nimi$)
DECLARE FUNCTION lataIDfunction% (a AS INTEGER)
REM $DYNAMIC

DECLARE SUB historylisa (kask$, aadress$)
DECLARE SUB inputrida (search$, YY%, x1%, x2%, varv%, errorvaartus$)
DECLARE SUB netsearch (search$)
DECLARE SUB netscape (nimi$)
DECLARE SUB shownetscape (nimi$)
DECLARE SUB userinfo (nimi$)
DECLARE SUB createmail ()
DECLARE SUB deletemail (nimi$)
DECLARE SUB clearekraan ()
DECLARE SUB newmail (nimi$)
DECLARE SUB showmail (nimi$)
DECLARE SUB missionipealkiri (mnr%)
DECLARE SUB pause (ticks AS INTEGER)
DECLARE SUB makenupp (nupunimi$)
DECLARE SUB timenaitaja ()
DECLARE SUB clearlinks ()


'Selle programmi tegemiseks kasutasin Ryan Williamsi koostatud
'programmijuppi, mis juhib hiire tîîd.
' Tema koordinaadid: jwill@onramp.net http://rampages.onramp.net/~jwill
'
DECLARE SUB lata (latanimi AS STRING, x1 AS INTEGER, y1 AS INTEGER)
DECLARE SUB cprint (tekst$, x%, y%, fc%, bc%, at1$)
DECLARE SUB esileht (missionnr AS INTEGER)
DECLARE SUB loadlatafail (yksnumber AS INTEGER)


' Kogu jÑrgnev jamps ongi Ryani programmist ja deklrameerib hiirt
                DECLARE FUNCTION MouseInit% ()
                DECLARE SUB mousestatus (lb%, rb%, xMouse%, yMouse%)
                DECLARE SUB MouseRange (hX1%, hY1%, hx2%, hY2%)
                DECLARE SUB MousePut (hx%, hy%)
                DECLARE SUB mousehide ()
                DECLARE SUB MouseDriver (ahx%, bhx%, chx%, dhx%)
                DECLARE SUB mouseshow ()
                DEFINT A-Z: DEF SEG = &HA000:
                DIM SHARED mouse$: mouse$ = SPACE$(57)



'Ja p‰ris enda tehtu

               
DIM SHARED g$ 'sisestus lingilt v‰i klaviatuurilt

DIM SHARED datafail AS STRING

DIM SHARED kiri(1 TO 30) AS STRING
DIM SHARED mailiaadress(1 TO 20) AS STRING
'DIM SHARED latafail(1 TO 600) AS STRING
DIM SHARED nethistory(1 TO 10) AS STRING 'netilehekÅljed mÑlus (BACk ja FORWARD jaoks)

DIM SHARED ekraan(1 TO 80, 1 TO 30) AS STRING'tÑpselt kirjas, mis ekraanil Åldse nÑha on
FOR x = 1 TO 18: FOR y = 1 TO 30: ekraan(x, y) = "": NEXT y: NEXT x

DIM SHARED link(1 TO 80, 1 TO 30) AS STRING  'siin hoitakse kirjas seda inffi, mis mingi kasti all on
FOR x = 1 TO 18: FOR y = 1 TO 30: link(x, y) = "": NEXT y: NEXT x

DIM SHARED activedir AS STRING 'WOS-i aktiivne direktor.
DIM SHARED search$

'sisestavate klahvide vÑÑrused
DIM sisestus(60 TO 100) AS STRING 'kahekohalise inkeyga asjad
        PRINT "EkraanimÑlud loodud."
DIM SHARED sesc AS STRING'sisestatav ESC-klahv

DIM SHARED mail(1 TO 10, 1 TO 2) AS STRING
DIM SHARED algusaeg AS DOUBLE

DIM SHARED muutujaSTRING(1 TO 20, 1 TO 2) AS STRING

DIM SHARED muutuja(1 TO 499) AS SINGLE

DIM SHARED reklaam(1 TO 20) AS STRING
DIM SHARED reklaaminumber AS INTEGER
DIM SHARED reklaamaeg AS LONG
DIM SHARED timeaeg AS LONG

DIM SHARED punktid(1 TO 10, 1 TO 2) AS STRING

TYPE tabelis
    nimi AS STRING * 10
    punktid AS INTEGER
END TYPE
DIM SHARED punktitabel(1 TO 10) AS tabelis

'punktid(1, 1) = "Eelmisest missioonist"
'punktid(1, 2) = "0"

TYPE xx
        active AS SINGLE  'kas tîîtab vÑi ei
        c AS INTEGER      'vÑrv
        x AS INTEGER      'aktiivne x
        y AS INTEGER      'aktiivne y
        suund AS STRING * 1
        END TYPE
DIM SHARED ussid(1 TO 10) AS xx
DIM SHARED ussaeg AS INTEGER
DIM SHARED email$

DIM SHARED maxaeg AS LONG
DIM SHARED antudaeg AS LONG

TYPE xxxx
        missioninr AS INTEGER
        nimi AS STRING * 10
        gamename AS STRING * 20
END TYPE
DIM SHARED user AS xxxx

PRINT "K‰ik mÑlud loodud."

        SCREEN 0
         COLOR 14: PRINT "                HÑkiprogramm hiirega v 1.1"
         COLOR 7: PRINT "Hiireabi leitud."
                FOR i% = 1 TO 57:  READ a$:  h$ = CHR$(VAL("&H" + a$))
                MID$(mouse$, i%, 1) = h$: NEXT i%
                'b$ = LEFT$(mouse$, i% - 1)
                'mouse$ = b$ + h$
                'NEXT i%
                DATA 55,89,E5,8B,5E,0C,8B,07,50,8B,5E,0A,8B,07,50,8B
                DATA 5E,08,8B,0F,8B,5E,06,8B,17,5B,58,1E,07,CD,33,53
                DATA 8B,5E,0C,89,07,58,8B,5E,0A,89,07,8B,5E,08,89,0F
                DATA 8B,5E,06,89,17,5D,CA,08,00
                RESTORE
        PRINT "Hiiredata laaditud."
       
        'kontrollib, kas hiir on Åldse Åhendatud
        ms% = MouseInit%
        IF NOT ms% THEN
                PRINT "Ei leia hiirt. Sorry.": END
        END IF
        PRINT "Hiir leitud."
        'Siin l‰peb Ryani tîî


'cls


loadmission ""
COLOR 15
DO
INPUT "Sisesta nimi:", user.nimi
LOOP UNTIL LTRIM$(RTRIM$(user.nimi)) <> ""

algusvideo


CLS
SCREEN 12


'a% = LoadAndPlayMIDI("c:\progra~1\qb45\redtrain.mid")



'userinfo "hwc\userinfo.tmp" 'kogu useri kohta kÑiv info failist userinfo.tmp



'loadlatafail 0 'loadib latafailid mÑllu

'*****algstaffi loadimine mÑllu
'loadmission ""
lata "1", 1, 1
activedir = "C:\"
'klaviatuurilt sisestatatavate linkide nimekiri

sisestus(71) = "lata haiglaimemasin"
'sisestus(79) = "lata VUTTMatch"




'nÑitab hiirt
CALL mouseshow
'Defineerib Ñra hiire kasutusala
MouseRange 0, 0, 638, 478




DO
timenaitaja

'Nii. Vaatame, kas vasak v‰i parem hiirenupp on vajutatud ja kus hiir on
mousestatus lb, rb, hx, hy
'muudame vasku hiire nulliks. Ma ei tea, miks see vajalik on
lbt = 0: rbt = 0
 
'vasak hiirenupp -> lbt = 1 /Åks hiirenupp -> lb% = -1
 IF lb% = -1 THEN lbt = 1
 'kui parem nupp ka.
 IF rb% = -1 THEN rbt = 1
 'Kui m‰ni suvaline klahv klaviatuurilt
 g$ = INKEY$
 
  'timeri kontroll
  IF (maxaeg <> 0 AND INT(TIMER) > maxaeg) THEN g$ = "timeover": maxaeg = 0: muutuja(98) = 0

hxt = INT(hx / 8) + 1'hiire vÑÑrtus tekstis
hyt = INT(hy / 16) + 1 ' --- '' ---




' OK, siin lihtsalt ESC l‰petab programmi tîî
IF lbt = 0 THEN GOTO ok

'chekin, kas hiirekl‰psu alla on registreeritud linki
IF link(hxt, hyt) <> "" THEN g$ = link(hxt, hyt)

ok:

        'kui sisestatu on kahekohaline, siis loeme ta automaatselt
        'huvitavaks nupuks klaviatuuril.
IF LEN(g$) = 2 THEN
        'PRINT ASC(RIGHT$(g$, 1))
        g$ = sisestus(ASC(RIGHT$(g$, 1)))
        'ESC nupu uurimine
        END IF
IF g$ = CHR$(27) THEN g$ = sesc

'LOCATE 27, 3: COLOR 7
'PRINT hx, hy, hxt, hyt
    ''INT(hx / 8) + 1, INT(hy / 16) + 1, g$
 'PRINT muutuja(193), muutuja(194), muutuja(195), muutuja(196)
'PRINT link(hxt, hyt), ekraan(hxt, hyt)
   '''link(INT(hx / 8) + 1, INT(hy / 16) + 1)



IF LEFT$(g$, 4) = "lata" THEN lata RIGHT$(g$, LEN(g$) - 5), 1, 1


'esilk asjad
IF g$ = "Continue" THEN
        IF algusaeg = 0 THEN algusaeg = INT(TIMER) ': missionipealkiri user.missioninr
        IF algusaeg <> 0 THEN lata "WOS", 1, 1
        END IF
        IF g$ = "Intro" THEN algusvideo: mouseshow: lata "1", 1, 1
'Mailboxi juhtimiseks
IF g$ = "MAILBOX" THEN lata "MAILBOX", 1, 1
IF LEFT$(g$, 5) = "mail " THEN showmail RIGHT$(g$, LEN(g$) - 5)
IF LEFT$(g$, 11) = "Deletemail " THEN mousehide: deletemail RIGHT$(g$, LEN(g$) - 11): mouseshow: lata "MAILBOX", 1, 1
'IF g$ = "createnewmail" THEN WriteLongLetter "", 5, 10, 15, 8, 14
IF g$ = "createnewmail" THEN createmail
IF g$ = "GetMsg" THEN lata "MAILBOX", 1, 1


IF g$ = "netscaabakas" THEN netscape ""
IF g$ = "net search" THEN
        inputrida search$, 12, 37, 54, 15, ""
        netsearch search$
END IF
IF g$ = "net aadress" THEN
        inputrida search$, 6, 14, 64, 12, "http://not found/"
        netsearch search$
END IF

IF LEFT$(g$, 8) = "net back" THEN historylisa "back", ""
IF LEFT$(g$, 10) = "net reload" THEN historylisa "last", ""
IF LEFT$(g$, 8) = "net home" THEN lata "http://www.yehaa.com/", 1, 1

IF LEFT$(g$, 9) = "mission1 " THEN mission1 ""
IF LEFT$(g$, 9) = "mission2 " THEN mission2 ""

IF LEFT$(g$, 12) = "addressbook " THEN addaddress RIGHT$(g$, LEN(g$) - 12)

'WOS-i juhtimiseks
IF LEFT$(g$, 3) = "wos" THEN
        activedir = RIGHT$(g$, LEN(g$) - 4)
        lata "WOS", 1, 1
        END IF
        IF g$ = "WOS" THEN lata "WOS", 1, 1


'muutujate muutmiseks ja olemiseks Åldse
IF LEFT$(g$, 8) = "muutuja " THEN
        muutuja(VAL(LEFT$(RIGHT$(g$, 5), 3))) = VAL(RIGHT$(g$, 1))
        IF ekraan(hxt, hyt) = "œcheckbox" THEN
                
                makecheckbox hxt - 1, hyt, VAL(LEFT$(RIGHT$(g$, 4), 2)), 1

                END IF
        END IF

'inputrida
IF LEFT$(g$, 10) = "inputrida " THEN
   YY = VAL(RIGHT$(LEFT$(g$, 12), 2))
   x1 = VAL(RIGHT$(LEFT$(g$, 15), 2))
   x2 = VAL(RIGHT$(LEFT$(g$, 18), 2))
   varv = VAL(RIGHT$(LEFT$(g$, 21), 2))
   g$ = RIGHT$(g$, LEN(g$) - 22)
   a = INSTR(g$, ">")
     IF a = 0 THEN a$ = g$: b$ = ""
      IF a <> 0 THEN
        'msg$ = RIGHT$(g$, LEN(g$) - 22)
        a$ = LEFT$(g$, a - 2)
        b$ = RIGHT$(g$, LEN(g$) - a)
      END IF
   inputrida msg$, YY, x1, x2, varv, b$
   c$ = muutujaSTRINGsub("lisa", a$, msg$)
END IF

IF LEFT$(g$, 12) = "vordleinput " THEN
   YY = VAL(RIGHT$(LEFT$(g$, 14), 2))
   x1 = VAL(RIGHT$(LEFT$(g$, 17), 2))
   x2 = VAL(RIGHT$(LEFT$(g$, 20), 2))
   varv = VAL(RIGHT$(LEFT$(g$, 23), 2))
   nimi$ = RIGHT$(g$, LEN(g$) - 24)
   'locate 1,1: print "u"
   vordleinput nimi$, YY, x1, x2, varv
END IF


IF LEFT$(g$, 17) = "missioncompleted " THEN MissionStartEnd g$
IF LEFT$(g$, 14) = "missionfailed " THEN MissionStartEnd g$
IF LEFT$(g$, 12) = "missiontext " THEN MissionStartEnd g$
IF LEFT$(g$, 14) = "RestartMission" THEN loadmission "hwc\userinfo.tmp": lata "1", 1, 1
IF LEFT$(g$, 13) = "LoadSaveGame " THEN LoadSaveGame RIGHT$(g$, LEN(g$) - 13)
IF LEFT$(g$, 7) = "NewGame" THEN RESET: punktid(1, 2) = "0": loadmission "": lata "1", 1, 1
IF LEFT$(g$, 11) = "punktitabel" THEN showtabel "": lata "1", 1, 1
IF LEFT$(g$, 8) = "timeover" THEN MissionStartEnd g$


IF LEFT$(g$, 11) = "exitprogram" THEN SYSTEM
IF g$ <> "" THEN pause 4
LOOP

REM $STATIC
SUB addaddress (aadress$)
FOR i% = 1 TO 20
   IF mailiaadress(i%) = aadress$ THEN EXIT SUB
   IF mailiaadress(i%) = "" THEN mailiaadress(i%) = aadress$: EXIT SUB
NEXT i%
END SUB

REM $DYNAMIC
SUB algusvideo


DIM taust(1 TO 150) AS INTEGER

mousehide
SCREEN 13
'vÑrvid - 20-40 mustast valgeni
' 40 - 60 punaseni
' 60 - 80 roheliseni
FOR varv% = 0 TO 20
        OUT &H3C8, varv% + 20
        OUT &H3C9, varv% * 3
        OUT &H3C9, varv% * 3
        OUT &H3C9, varv% * 3
NEXT varv%

FOR varv% = 0 TO 20
        OUT &H3C8, varv% + 40
        OUT &H3C9, varv% * 3
        OUT &H3C9, varv% * 1
        OUT &H3C9, varv% * 1
NEXT varv%

FOR varv% = 0 TO 20
        OUT &H3C8, varv% + 60
        OUT &H3C9, varv% * 1
        OUT &H3C9, varv% * 3
        OUT &H3C9, varv% * 1
NEXT varv%




'VIEW    'Make the viewport cover most of the screen.
CLS

FOR rida% = 1 TO 3
'alguskirjad
IF rida% = 1 THEN a$ = "Sulev Reisberg"
IF rida% = 2 THEN a$ = "Urmas Reisberg"
IF rida% = 3 THEN a$ = "HACKERS WORLD II"

FOR c% = 40 TO 58
        'FOR aaa% = 1 TO 240
        'DO
        'LOOP UNTIL (INP(&H3DA) AND 8)
        'NEXT aaa%
        pause 1
        IF a$ = "HACKERS WORLD II" THEN pause 1

LOCATE 15, INT((40 - LEN(a$)) / 2)
COLOR c%
PRINT a$
NEXT c%

FOR c% = 58 TO 40 STEP -2
        'FOR aaa% = 1 TO 240
        'DO
        'LOOP UNTIL (INP(&H3DA) AND 8)
        'NEXT aaa%
        pause 1

LOCATE 15, INT((40 - LEN(a$)) / 2)
COLOR c%
PRINT a$
NEXT c%

SLEEP 1
IF INKEY$ <> "" THEN EXIT FOR
NEXT rida%


IF INKEY$ <> "" THEN GOTO videolopp
VIEW (80, 60)-(240, 130)
  CLS
  SLEEP 3


  'pilt mARSIST
  FOR v = 0 TO 5
   LINE (0, 30 + v)-(160, 30 + v), v + 40
  NEXT
  FOR v = 0 TO 5
   LINE (0, 34 + v * 2)-(160, 35 + v * 2), v + 45, B
  NEXT
  FOR v = 0 TO 5
   LINE (0, 44 + v * 3)-(160, 46 + v * 3), v + 50, BF
  NEXT
  FOR v = 0 TO 1
   LINE (0, 59 + v * 5)-(160, 64 + v * 5), v + 55, BF
  NEXT
   LINE (0, 70)-(160, 70), 55
  FOR p = 1 TO 100
   x = INT(RND * 160)
   y = INT(RND * 25) + 35
   c = INT(RND * 10) + 45
   PSET (x, y), c
  NEXT p
  FOR p = 1 TO 60
   x = INT(RND * 160)
   y = INT(RND * 30)
   c = INT(RND * 7) + 30
   PSET (x, y), c
  NEXT p

  
SLEEP 2
IF INKEY$ <> "" THEN GOTO videolopp


  'tekst "Tundmatu planeet"
a$ = "Tundmatu planeet"
FOR taht = 1 TO LEN(a$)
        FOR aaa% = 1 TO 40
        DO
        LOOP UNTIL (INP(&H3DA) AND 8)
        NEXT aaa%
'18,22
 LOCATE 18, 11 + taht
 COLOR 76
  PRINT RIGHT$(LEFT$(a$, taht), 1)
 LOCATE 18, 11 + taht - 1
 COLOR 74
  PRINT RIGHT$(LEFT$(a$, taht - 1), 1)
NEXT taht

SLEEP 2
IF INKEY$ <> "" THEN GOTO videolopp

'ja kustutab selle


FOR taht = 1 TO LEN(a$)
        FOR aaa% = 1 TO 40
        DO
        LOOP UNTIL (INP(&H3DA) AND 8)
        NEXT aaa%
'18,22
 LOCATE 18, 11 + taht
 COLOR 73
  PRINT RIGHT$(LEFT$(a$, taht), 1)
 LOCATE 18, 11 + taht - 1
  PRINT " "

NEXT taht
 LOCATE 18, 11 + LEN(a$)
  PRINT " "
     



SLEEP 2
IF INKEY$ <> "" THEN GOTO videolopp


' UFO kukub
x = 120
y = 10
GET (x - 7, y - 3)-(x + 7, y + 3), taust
FOR y = 0 TO 40 STEP 2

        FOR aaa% = 1 TO 20
        DO
        LOOP UNTIL (INP(&H3DA) AND 8)
        NEXT aaa%

 PUT (x - 6, y - 5), taust, PSET
GET (x - 7, y - 3)-(x + 7, y + 3), taust
'SLEEP 1
CIRCLE (x, y), 5, 29, , , .3
CIRCLE (x, y), 4, 32, , , .3
CIRCLE (x, y), 2, 30, , , .2
PSET (x - 2, y), 75
PSET (x + 1, y), 76
PSET (x - 3, y + 2), 33
PSET (x + 3, y + 2), 33
x = x - 1
NEXT y

SLEEP 2
IF INKEY$ <> "" THEN GOTO videolopp

'ja target lock Ñra

GET (x - 7, y - 5)-(x + 7, y + 1), taust
FOR c = 70 TO 79
LINE (x - 7, y - 5)-(x + 7, y + 1), c, B
'LINE (x - 5, y - 4)-(x + 6, y ), c - 1, B
        FOR aaa% = 1 TO 50
        DO
        LOOP UNTIL (INP(&H3DA) AND 8)
        NEXT aaa%
NEXT c

  'tekst "Target lock"
a$ = "HÑvita sihtmÑrk"
FOR taht = 1 TO LEN(a$)
        FOR aaa% = 1 TO 40
        DO
        LOOP UNTIL (INP(&H3DA) AND 8)
        NEXT aaa%
'18,22
 LOCATE 18, 11 + taht
 COLOR 76
  PRINT RIGHT$(LEFT$(a$, taht), 1)
 LOCATE 18, 11 + taht - 1
 COLOR 74
  PRINT RIGHT$(LEFT$(a$, taht - 1), 1)
NEXT taht

SLEEP 2
IF INKEY$ <> "" THEN GOTO videolopp

'ruut kaob


FOR c = 79 TO 68
LINE (x - 7, y - 5)-(x + 7, y + 1), c, B
'LINE (x - 5, y - 4)-(x + 6, y ), c - 1, B
        FOR aaa% = 1 TO 30
        DO
        LOOP UNTIL (INP(&H3DA) AND 8)
        NEXT aaa%
NEXT c
PUT (x - 7, y - 5), taust, PSET

'ja kustutab selle

FOR taht = 1 TO LEN(a$)
        FOR aaa% = 1 TO 40
        DO
        LOOP UNTIL (INP(&H3DA) AND 8)
        NEXT aaa%
'18,22
 LOCATE 18, 11 + taht
 COLOR 73
  PRINT RIGHT$(LEFT$(a$, taht), 1)
 LOCATE 18, 11 + taht - 1
  PRINT " "

NEXT taht
 LOCATE 18, 11 + LEN(a$)
  PRINT " "

SLEEP 1
IF INKEY$ <> "" THEN GOTO videolopp


'Pilt UFO seest
   'metalne sisu
    LINE (0, 0)-(160, 70), 28, BF
   'ja alumine hÑmarus
   FOR c = 0 TO 4
    LINE (0, 70 - c * 3)-(160, 72 - c * 3), 24 + c, BF
   NEXT c

   'juhtpult
    FOR c = 3 TO 10
     LINE (53 - INT(c * 1.4), c + 40)-(130 + INT(c / 3), c + 40), 30 + INT(c / 2)
    NEXT c
   
        FOR c = 0 TO 20
         LINE (40, 50 + c)-(133, 50 + c), 34 - INT(c / 3)
        NEXT c
    FOR p = 1 TO 40
     x = INT(RND * 70) + 55
     y = INT(RND * 4) + 44
     c = INT(RND * 6) + 8
     PSET (x, y), c
    NEXT p
   'aknad
    LINE (40, 18)-(90, 32), 30, B
    LINE (41, 19)-(89, 31), 29, B
        FOR c = 2 TO 14
         LINE (42, 17 + c)-(88, 17 + c), c + 40, BF
        NEXT c
      
        'LINE (42, 20)-(88, 30), 51, BF

    LINE (100, 18)-(150, 32), 30, B
    LINE (101, 19)-(149, 31), 28, B
        FOR c = 2 TO 14
         LINE (102, 17 + c)-(148, 17 + c), c + 40, BF
        NEXT c
    'kollid
    CIRCLE (30, 70), 40, 70, , , 2.7
    CIRCLE (30, 70), 39, 72, , , 2.7
    CIRCLE (30, 70), 38, 75, , , 2.7
    CIRCLE (30, 70), 37, 79, , , 2.7
    PAINT (30, 69), 79
     CIRCLE (37, 46), 5, 37, , , 2
     CIRCLE (37, 46), 4, 38, , , 2
     PAINT (37, 46), 38
     CIRCLE (39, 46), 1, 0
     PSET (39, 46), 23
    LINE (35, 39)-(39, 41), 61
   LINE (26, 62)-(44, 65), 72, BF
   LINE (26, 62)-(43, 62), 76
  
    CIRCLE (110, 70), 36, 70, , , 2.7
    CIRCLE (110, 70), 35, 72, , , 2.7
    CIRCLE (110, 70), 34, 75, , , 2.7
    CIRCLE (110, 70), 33, 79, , , 2.7
    PAINT (110, 69), 79

SLEEP 1
IF INKEY$ <> "" THEN GOTO videolopp

'vestlus

a$ = "Mis nÅÅd juhtus? "
FOR taht = 1 TO LEN(a$)
        FOR aaa% = 1 TO 40
        DO
        LOOP UNTIL (INP(&H3DA) AND 8)
        NEXT aaa%
'18,22
 LOCATE 18, 11 + taht
 COLOR 76
  PRINT RIGHT$(LEFT$(a$, taht), 1)
 LOCATE 18, 11 + taht - 1
 COLOR 74
  PRINT RIGHT$(LEFT$(a$, taht - 1), 1)
NEXT taht

SLEEP 2
IF INKEY$ <> "" THEN GOTO videolopp

'ja kustutab selle

a$ = "Kust mina tean?   "
FOR taht = 1 TO LEN(a$)
        FOR aaa% = 1 TO 40
        DO
        LOOP UNTIL (INP(&H3DA) AND 8)
        NEXT aaa%
'18,22
 LOCATE 18, 11 + taht
 COLOR 76
  PRINT RIGHT$(LEFT$(a$, taht), 1)
 LOCATE 18, 11 + taht - 1
 COLOR 74
  PRINT RIGHT$(LEFT$(a$, taht - 1), 1)
NEXT taht

SLEEP 2
IF INKEY$ <> "" THEN GOTO videolopp

a$ = "Keegi on end me "
FOR taht = 1 TO LEN(a$)
        FOR aaa% = 1 TO 40
        DO
        LOOP UNTIL (INP(&H3DA) AND 8)
        NEXT aaa%
'18,22
 LOCATE 18, 11 + taht
 COLOR 76
  PRINT RIGHT$(LEFT$(a$, taht), 1)
 LOCATE 18, 11 + taht - 1
 COLOR 74
  PRINT RIGHT$(LEFT$(a$, taht - 1), 1)
NEXT taht

a$ = "pardaarvutisse "
FOR taht = 1 TO LEN(a$)
        FOR aaa% = 1 TO 40
        DO
        LOOP UNTIL (INP(&H3DA) AND 8)
        NEXT aaa%
'18,22
 LOCATE 19, 11 + taht
 COLOR 76
  PRINT RIGHT$(LEFT$(a$, taht), 1)
 LOCATE 19, 11 + taht - 1
 COLOR 74
  PRINT RIGHT$(LEFT$(a$, taht - 1), 1)
NEXT taht
  
    FOR p = 1 TO 10
     x = INT(RND * 30) + 55
     y = INT(RND * 4) + 44
     c = INT(RND * 6) + 8
     PSET (x, y), c
    NEXT p


a$ = "sisse hÑkkinud!"
FOR taht = 1 TO LEN(a$)
        FOR aaa% = 1 TO 40
        DO
        LOOP UNTIL (INP(&H3DA) AND 8)
        NEXT aaa%
'18,22
 LOCATE 20, 11 + taht
 COLOR 76
  PRINT RIGHT$(LEFT$(a$, taht), 1)
 LOCATE 20, 11 + taht - 1
 COLOR 74
  PRINT RIGHT$(LEFT$(a$, taht - 1), 1)
NEXT taht

SLEEP 4
IF INKEY$ <> "" THEN GOTO videolopp

FOR taht = 1 TO 20
        FOR aaa% = 1 TO 40
        DO
        LOOP UNTIL (INP(&H3DA) AND 8)
        NEXT aaa%
 LOCATE 18, 11 + taht
  PRINT " "
 LOCATE 19, 11 + taht
  PRINT " "
 LOCATE 20, 11 + taht
  PRINT " "

'NEXT taht
' LOCATE 18, 11 + LEN(a$)
'  PRINT " "

NEXT taht

    FOR p = 1 TO 40
     x = INT(RND * 40) + 55
     y = INT(RND * 4) + 44
     c = INT(RND * 6) + 28
     PSET (x, y), c
    NEXT p

a$ = "JÑlle??!"
FOR taht = 1 TO LEN(a$)
        FOR aaa% = 1 TO 40
        DO
        LOOP UNTIL (INP(&H3DA) AND 8)
        NEXT aaa%

 LOCATE 18, 11 + taht
 COLOR 76
  PRINT RIGHT$(LEFT$(a$, taht), 1)
 LOCATE 18, 11 + taht - 1
 COLOR 74
  PRINT RIGHT$(LEFT$(a$, taht - 1), 1)
NEXT taht

SLEEP 2
IF INKEY$ <> "" THEN GOTO videolopp

a$ = "See mees peab ikka "
FOR taht = 1 TO LEN(a$)
        FOR aaa% = 1 TO 40
        DO
        LOOP UNTIL (INP(&H3DA) AND 8)
        NEXT aaa%

 LOCATE 18, 11 + taht
 COLOR 76
  PRINT RIGHT$(LEFT$(a$, taht), 1)
 LOCATE 18, 11 + taht - 1
 COLOR 74
  PRINT RIGHT$(LEFT$(a$, taht - 1), 1)
NEXT taht

a$ = "karm hÑkker olema."
FOR taht = 1 TO LEN(a$)
        FOR aaa% = 1 TO 40
        DO
        LOOP UNTIL (INP(&H3DA) AND 8)
        NEXT aaa%
'18,22
 LOCATE 19, 11 + taht
 COLOR 76
  PRINT RIGHT$(LEFT$(a$, taht), 1)
 LOCATE 19, 11 + taht - 1
 COLOR 74
  PRINT RIGHT$(LEFT$(a$, taht - 1), 1)
NEXT taht


SLEEP 3
IF INKEY$ <> "" THEN GOTO videolopp

FOR taht = 1 TO 20
        FOR aaa% = 1 TO 40
        DO
        LOOP UNTIL (INP(&H3DA) AND 8)
        NEXT aaa%
 LOCATE 18, 11 + taht
  PRINT " "
 LOCATE 19, 11 + taht
  PRINT " "
 LOCATE 20, 11 + taht
  PRINT " "

NEXT taht



SLEEP 1
CLS
'CD

FOR y% = 40 TO 30 STEP -1
        FOR aaa% = 1 TO 80
        DO
        LOOP UNTIL (INP(&H3DA) AND 8)
        NEXT aaa%


LINE (45, y% - 25)-(95, y% + 25), 0, BF

CIRCLE (70, y%), 25, 29
CIRCLE (70, y%), 24, 34

CIRCLE (70, y%), 3, 32
CIRCLE (70, y%), 5, 26
CIRCLE (70, y%), 7, 34
 PAINT (60, y%), 34
CIRCLE (70, y%), 23, 31
NEXT y%


'CIRCLE (60, 52), 14, 77, , , 1.3
SLEEP 1
a$ = "Panen meie hÑki- "
FOR taht = 1 TO LEN(a$)
        FOR aaa% = 1 TO 40
        DO
        LOOP UNTIL (INP(&H3DA) AND 8)
        NEXT aaa%

 LOCATE 18, 11 + taht
 COLOR 76
  PRINT RIGHT$(LEFT$(a$, taht), 1)
 LOCATE 18, 11 + taht - 1
 COLOR 74
  PRINT RIGHT$(LEFT$(a$, taht - 1), 1)
NEXT taht

a$ = "t‰rje CD kÑima."
FOR taht = 1 TO LEN(a$)
        FOR aaa% = 1 TO 40
        DO
        LOOP UNTIL (INP(&H3DA) AND 8)
        NEXT aaa%
'18,22
 LOCATE 19, 11 + taht
 COLOR 76
  PRINT RIGHT$(LEFT$(a$, taht), 1)
 LOCATE 19, 11 + taht - 1
 COLOR 74
  PRINT RIGHT$(LEFT$(a$, taht - 1), 1)
NEXT taht

SLEEP 3
IF INKEY$ <> "" THEN GOTO videolopp

FOR taht = 1 TO 20
        FOR aaa% = 1 TO 40
        DO
        LOOP UNTIL (INP(&H3DA) AND 8)
        NEXT aaa%
 LOCATE 18, 11 + taht
  PRINT " "
 LOCATE 19, 11 + taht
  PRINT " "
 LOCATE 20, 11 + taht
  PRINT " "

NEXT taht


IF INKEY$ <> "" THEN GOTO videolopp
CLS

'Pilt UFO seest
   'metalne sisu
    LINE (0, 0)-(160, 70), 28, BF
   'ja alumine hÑmarus
   FOR c = 0 TO 4
    LINE (0, 70 - c * 3)-(160, 72 - c * 3), 24 + c, BF
   NEXT c

   'juhtpult
    FOR c = 3 TO 10
     LINE (53 - INT(c * 1.4), c + 40)-(130 + INT(c / 3), c + 40), 30 + INT(c / 2)
    NEXT c
  
        FOR c = 0 TO 20
         LINE (40, 50 + c)-(133, 50 + c), 34 - INT(c / 3)
        NEXT c
    FOR p = 1 TO 40
     x = INT(RND * 70) + 55
     y = INT(RND * 4) + 44
     c = INT(RND * 6) + 8
     PSET (x, y), c
    NEXT p
   'aknad
    LINE (40, 18)-(90, 32), 30, B
    LINE (41, 19)-(89, 31), 29, B
        FOR c = 2 TO 14
         LINE (42, 17 + c)-(88, 17 + c), c + 40, BF
        NEXT c
     
        'LINE (42, 20)-(88, 30), 51, BF

    LINE (100, 18)-(150, 32), 30, B
    LINE (101, 19)-(149, 31), 28, B
        FOR c = 2 TO 14
         LINE (102, 17 + c)-(148, 17 + c), c + 40, BF
        NEXT c
    'kollid
    CIRCLE (30, 70), 40, 70, , , 2.7
    CIRCLE (30, 70), 39, 72, , , 2.7
    CIRCLE (30, 70), 38, 75, , , 2.7
    CIRCLE (30, 70), 37, 79, , , 2.7
    PAINT (30, 69), 79
  '   CIRCLE (37, 46), 5, 37, , , 2
  '   CIRCLE (37, 46), 4, 38, , , 2
  '   PAINT (37, 46), 38
  '   CIRCLE (39, 46), 1, 0
  '   PSET (39, 46), 23
  '  LINE (35, 39)-(39, 41), 61
  ' LINE (26, 62)-(44, 65), 72, BF
  ' LINE (26, 62)-(43, 62), 76
 
    CIRCLE (110, 70), 36, 70, , , 2.7
    CIRCLE (110, 70), 35, 72, , , 2.7
    CIRCLE (110, 70), 34, 75, , , 2.7
    CIRCLE (110, 70), 33, 79, , , 2.7
    PAINT (110, 69), 79

SLEEP 1
IF INKEY$ <> "" THEN GOTO videolopp


a$ = "Arvuti on nÅÅd puhas!"
FOR taht = 1 TO LEN(a$)
        FOR aaa% = 1 TO 40
        DO
        LOOP UNTIL (INP(&H3DA) AND 8)
        NEXT aaa%
'18,22
 LOCATE 18, 10 + taht
 COLOR 76
  PRINT RIGHT$(LEFT$(a$, taht), 1)
 LOCATE 18, 10 + taht - 1
 COLOR 74
  PRINT RIGHT$(LEFT$(a$, taht - 1), 1)
NEXT taht

SLEEP 2
IF INKEY$ <> "" THEN GOTO videolopp

 
   'suu
   LINE (26, 62)-(44, 65), 72, BF

a$ = "Kaome siit!           "
FOR taht = 1 TO LEN(a$)
        FOR aaa% = 1 TO 40
        DO
        LOOP UNTIL (INP(&H3DA) AND 8)
        NEXT aaa%
'18,22
 LOCATE 18, 10 + taht
 COLOR 76
  PRINT RIGHT$(LEFT$(a$, taht), 1)
 LOCATE 18, 10 + taht - 1
 COLOR 74
  PRINT RIGHT$(LEFT$(a$, taht - 1), 1)
NEXT taht

SLEEP 2
IF INKEY$ <> "" THEN GOTO videolopp

'ja kustutab selle


FOR taht = 1 TO LEN(a$)
        FOR aaa% = 1 TO 40
        DO
        LOOP UNTIL (INP(&H3DA) AND 8)
        NEXT aaa%
'18,22
 LOCATE 18, 11 + taht
 COLOR 73
  PRINT RIGHT$(LEFT$(a$, taht), 1)
 LOCATE 18, 11 + taht - 1
  PRINT " "

NEXT taht
 LOCATE 18, 11 + LEN(a$)
  PRINT " "
    

IF INKEY$ <> "" THEN GOTO videolopp



  'pilt mARSIST
  CLS
  FOR v = 0 TO 5
   LINE (0, 30 + v)-(160, 30 + v), v + 40
  NEXT
  FOR v = 0 TO 5
   LINE (0, 34 + v * 2)-(160, 35 + v * 2), v + 45, B
  NEXT
  FOR v = 0 TO 5
   LINE (0, 44 + v * 3)-(160, 46 + v * 3), v + 50, BF
  NEXT
  FOR v = 0 TO 1
   LINE (0, 59 + v * 5)-(160, 64 + v * 5), v + 55, BF
  NEXT
   LINE (0, 70)-(160, 70), 55
  FOR p = 1 TO 100
   x = INT(RND * 160)
   y = INT(RND * 25) + 35
   c = INT(RND * 10) + 45
   PSET (x, y), c
  NEXT p
  FOR p = 1 TO 60
   x = INT(RND * 160)
   y = INT(RND * 30)
   c = INT(RND * 7) + 30
   PSET (x, y), c
  NEXT p

 
SLEEP 1
IF INKEY$ <> "" THEN GOTO videolopp


' UFO t‰useb
x = 100
y = 40
GET (x - 7, y - 3)-(x + 7, y + 3), taust
FOR y = 40 TO 0 STEP -1

        FOR aaa% = 1 TO 100
        DO
        LOOP UNTIL (INP(&H3DA) AND 8)
        NEXT aaa%

 PUT (x - 7, y - 2), taust, PSET
GET (x - 7, y - 3)-(x + 7, y + 3), taust
'SLEEP 1
CIRCLE (x, y), 5, 29, , , .3
CIRCLE (x, y), 4, 32, , , .3
CIRCLE (x, y), 2, 30, , , .2
PSET (x - 2, y), 75
PSET (x + 1, y), 76
PSET (x - 3, y + 2), 33
PSET (x + 3, y + 2), 33

NEXT y

PUT (x - 7, y - 2), taust, PSET

SLEEP 5
IF INKEY$ <> "" THEN GOTO videolopp
    
CLS




videolopp:
VIEW
SCREEN 12





END SUB

REM $STATIC
SUB clearekraan

CLS
FOR x = 1 TO 80
FOR y = 1 TO 30

 ekraan(x, y) = ""

NEXT y
NEXT x

FOR nr = 1 TO 10
ussid(nr).active = 0
NEXT nr

END SUB

SUB clearlinks

FOR x = 1 TO 80
FOR y = 1 TO 30

 link(x, y) = ""

NEXT y
NEXT x

END SUB

'
'
SUB cprint (tekst$, x, y, fc, bc, at1$)
xx = x: YY = y
IF fc > 0 AND fc < 16 THEN COLOR fc
IF fc = 0 THEN COLOR 15

FOR taht = 1 TO LEN(tekst$)


'Teeb tÑhe mustal taustal ‰igesse kohta
LOCATE YY, xx
PRINT RIGHT$(LEFT$(tekst$, taht), 1)

'ja kirjutab selle ekraanimÑllu ning vabastab lingi selle alt
ekraan(xx, YY) = RIGHT$(LEFT$(tekst$, taht), 1)
link(xx, YY) = ""

    'vÑrvib musta taustavÑrviks
        FOR yy1 = 0 TO 15
        FOR xx1 = 0 TO 7
            IF POINT((xx - 1) * 8 + xx1, (YY - 1) * 16 + yy1) = 0 THEN PSET ((xx - 1) * 8 + xx1, (YY - 1) * 16 + yy1), bc
          IF fc = 0 AND POINT((xx - 1) * 8 + xx1, (YY - 1) * 16 + yy1) = 15 THEN PSET ((xx - 1) * 8 + xx1, (YY - 1) * 16 + yy1), 0
        NEXT xx1
        NEXT yy1

't‰stab tÑhte edasi

xx = xx + 1
IF xx > 80 THEN xx = 1: YY = YY + 1
NEXT taht

END SUB

SUB createmail

'kiri(x) on kirja sisu v‰i muu info kirja kohta
'kiri(1) = subject$
'kiri(2) = to$

vastusleitud = 0 'kui meili Ñra saadad ja sellele leitakse
                'vastama m‰ni lata, siis muutub see 1-ks
rida = 7
veerg = 36
TahtiYhesReas = 37
KokkuRidasid = 17
varv = 14

COLOR varv

Maxrida = KokkuRidasid + rida - 1


msg$ = ""
counter = 3 'esimesed 2 rida on reserveeritud (SUBJECT ja TO)

IF kiri(1) = "" THEN kiri(1) = " "'mingi bugi, igatahes on see siin vajalik
IF kiri(2) = "" THEN kiri(2) = "olen@loll.ee"'mingi bugi, igatahes on see siin vajalik
IF kiri(3) = "" THEN kiri(3) = " "'mingi bugi, igatahes on see siin vajalik


'****************
' ILUSA PILDI JOONISTAMINE
'*******************
        mousehide

 'tooma pildi nÑhtavale, ilusana
 FOR i = 1 TO 480 STEP 2
 LINE (0, i)-(640, i), 0
 NEXT i
 lata "createnewmail", 1, 1

 'kaotame eelmise kirja
 FOR i = 1 TO 20
 kiri(i) = ""
 NEXT i

 LOCATE rida, veerg + 1
 PRINT "≤"
       
        mouseshow



DO UNTIL valjaprogrammist <> 0


 '********* PÂHILINE <DO>, mis ootab klahvi v‰i hiirenupu vajutust *******
 DO
  mousestatus lb, rb, hx, hy
  lbt = 0
  g$ = ""
    IF lb% = -1 THEN lbt = 1
    
    IF link(INT(hx / 8) + 1, INT(hy / 16) + 1) <> "" THEN g$ = link(INT(hx / 8) + 1, INT(hy / 16) + 1)'
    
    IF lbt = 1 THEN
       
       
        'Saadab programmist vÑlja
        IF g$ = "lata MAILBOX" THEN
                valjaprogrammist = 1
            EXIT DO
        END IF



 '*******************
 'Maili Ñrasaatmine
 'SENDING MAIL
 '************************
IF g$ = "SEND lata MAILBOX" THEN
mousehide
           
      
filenr = FREEFILE
nimi$ = kiri(2)
       
OPEN "hwc\mailsend.hw2" FOR INPUT AS filenr
       
           'Otsib maili adressaati
        DO
                IF EOF(filenr) THEN EXIT DO
                LINE INPUT #filenr, rida$
                IF rida$ = "[" + nimi$ + "]" THEN EXIT DO
        LOOP
          
           'Otsib sisalduvat teksti
        DO
                IF EOF(filenr) THEN EXIT DO
                LINE INPUT #filenr, rida$
               
                IF LEFT$(rida$, 1) = "[" THEN EXIT DO
                       
                'otsib vajalikke s‰nu
                IF LEFT$(rida$, 6) = "text: " THEN
                        FOR i = 1 TO 20
                                Miskirjutab$ = kiri(i)
                               
                               
                                IF INSTR(Miskirjutab$, RIGHT$(rida$, LEN(rida$) - 6)) <> 0 THEN
                                        LINE INPUT #filenr, rida$
                                         CLOSE filenr
                                         vastusleitud = 1
                                         lata RIGHT$(rida$, LEN(rida$) - 6), 1, 1
                                         EXIT DO
                                        END IF
                                IF i = 1 THEN i = 2 'jÑtmaks vahele adressaati ennast
                                NEXT i
                        END IF
               
                        IF LEFT$(rida$, 12) = "playernimi: " THEN
                                playernimi$ = LCASE$(LTRIM$(RTRIM$(user.nimi)))
                                FOR i = 2 TO 20
                                Miskirjutab$ = kiri(i)
                                IF INSTR(Miskirjutab$, playernimi$) <> 0 THEN
                                         CLOSE filenr
                                         vastusleitud = 1
                                        lata RIGHT$(rida$, LEN(rida$) - 12), 1, 1
                                        EXIT DO
                                END IF
                                NEXT i
                        END IF
               
                        IF LEFT$(rida$, 6) = "else: " THEN
                                         CLOSE filenr
                                         vastusleitud = 1
                                lata RIGHT$(rida$, LEN(rida$) - 6), 1, 1
                                        EXIT DO
                                END IF
                LOOP UNTIL INSTR(rida1$, "[") <> 0
                
        IF vastusleitud = 0 THEN CLOSE filenr
       
        lata "sendingmail", 1, 1
        mouseshow
        valjaprogrammist = 1
        END IF



        'vakliti mailiaadress addressboogist
        IF LEFT$(g$, 7) = "mailto " THEN
            mousehide
            IF g$ = "mailto " THEN g$ = "mailto olen@loll.ee"
            IF INSTR(g$, "[") <> 0 THEN g$ = "mailto olen@loll.ee"
            kiri(2) = RIGHT$(g$, LEN(g$) - 7)
            
                'toome pildi addressboogi alt tagasi
            COLOR 7
            LOCATE 4, 46
            PRINT "_______________________"
            LOCATE 4, 46
            PRINT kiri(2)
            LOCATE 6, 46
                PRINT "ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ"
            LOCATE 7, 46
                PRINT "                        "
           
            'tÅhjaks
            FOR y% = 7 TO 23
            FOR x% = 36 TO 73
            LOCATE y%, x%
             PRINT " "
             link(x%, y%) = ""
            NEXT x%
            NEXT y%
            

            COLOR 14
            FOR i = 7 TO 25
             LOCATE i, veerg + 1
             PRINT kiri(i - 4)
            NEXT i
            mouseshow

        END IF

        ' loeb subjecti
        IF g$ = "subject" THEN
                inputrida subject$, 5, 46, 70, 14, "No subject"
                IF (kiri(1) = "" AND subject$ = "No subject") THEN kiri(1) = "No subject"
                IF subject$ <> "No subject" THEN kiri(1) = subject$
                LOCATE 5, 46
                COLOR 7
                PRINT subject$
                COLOR 14
        END IF


        'loob addressboogi
        IF g$ = "addressbook" THEN
            pause 5
            nr = 1
            COLOR 15
            
            mousehide
            
             'joonistab ja kehtestab vastava mailiaadressi lingi
             FOR nr = 1 TO 20
             IF mailiaadress(nr) = "" THEN EXIT FOR
             link$ = "mailto " + mailiaadress(nr)
                 FOR i = 46 TO 69
                        link(i, nr + 5) = link$
                        NEXT i
                        LOCATE nr + 5, 46
                        PRINT "≥                      ≥"
                        LOCATE nr + 5, 47
                        PRINT mailiaadress(nr)
               
                 NEXT nr
                LOCATE nr + 5, 46
                PRINT "¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ"
           
            mouseshow
            COLOR 14
        END IF

     END IF

 a$ = INKEY$
 LOOP UNTIL (a$ <> "" OR valjaprogrammist <> 0)
IF valjaprogrammist <> 0 THEN EXIT DO

 '************************************************************************

       
       


       '******************************
       'MAILI KIRJUTAMISE KORRALDAMINE
       '*******************************
        IF (ASC(a$) > 31 AND ASC(a$) <> 91) THEN
         msg$ = msg$ + a$
         LOCATE rida, LEN(msg$) + veerg
         PRINT a$
         IF LEN(msg$) >= TahtiYhesReas THEN
         kiri(counter) = msg$
         IF rida = Maxrida THEN msg$ = LEFT$(msg$, LEN(msg$) - 1)
         IF rida < Maxrida THEN rida = rida + 1: counter = counter + 1: msg$ = ""
         END IF
         LOCATE rida, LEN(msg$) + veerg + 1
         PRINT "≤"
        END IF

        IF ASC(a$) = 13 THEN
         LOCATE rida, LEN(msg$) + 1 + veerg  'v‰tab ≤-mÑrgi Ñra
         PRINT " "
         IF msg$ = "" THEN msg$ = " "
         kiri(counter) = msg$
         IF rida < Maxrida THEN rida = rida + 1: counter = counter + 1: msg$ = ""
         LOCATE rida, veerg + 1 + LEN(msg$)
         PRINT "≤"
        END IF
       
        IF ASC(a$) = 8 THEN
         IF msg$ <> "" THEN
         msg$ = LEFT$(msg$, LEN(msg$) - 1)
         kiri(counter) = msg$
         LOCATE rida, LEN(msg$) + veerg + 1
         PRINT "≤ "
   
        ELSE
         IF counter <> 3 THEN
         LOCATE rida, veerg + 1
         PRINT " "
          IF kiri(counter - 1) <> "" THEN
           msg$ = kiri(counter - 1)
           msg$ = LEFT$(msg$, LEN(msg$) - 1)
           rida = rida - 1
           counter = counter - 1
           LOCATE rida, veerg + 1
           PRINT msg$
           LOCATE rida, veerg + 1 + LEN(msg$)
           PRINT "≤"
          ELSE
           'rida = rida - 1
           'counter = counter - 1
           LOCATE rida, veerg + 1
           PRINT "≤"
          END IF
        END IF
     END IF

   
 END IF

LOOP

       
       
       
       
       
       
       
       
       
       
       
       







'************************************************************************
  ' VéLJAPééS
     mousehide
     clearlinks
     clearekraan
     
     lata "MAILBOX", 1, 1

     mouseshow
     mousestatus lb, rb, hx, hy
    

END SUB

'See oli algselt Sulevi tehtud, aga kuna see
'minu arust ei tîîtanud, siis ma tegin selle uuesti
SUB deletemail (nimi$)

'otsib vÑlja meili, mis on vajamineva nimega
x = 0
DO
x = x + 1
IF x > 10 THEN EXIT DO
LOOP UNTIL mail(x, 2) = nimi$

'k‰ik ‰igest meilist jÑrgmised meilid t‰stab Åhe v‰rra ettepoole
DO
IF x < 10 THEN
        mail(x, 2) = mail(x + 1, 2)
        mail(x, 1) = mail(x + 1, 1)
        ELSE EXIT DO
        END IF
x = x + 1
LOOP

'viimase topelt-meili asemele teeb tÅhja koha
mail(10, 1) = ""
mail(10, 2) = ""


END SUB

SUB esileht (missionnr AS INTEGER)
mousehide
clearekraan

'
'FOR x = 1 TO 80
'FOR y = 1 TO 30
' ekraan(x, y) = ""
'NEXT y
'NEXT x

clearlinks

'screen 12
OPEN "hwc\menyy.hw2" FOR INPUT AS #2

 INPUT #2, a$
LoebUueRea:
       INPUT #2, y
       IF y > 478 THEN GOTO lopp
        DO
         INPUT #2, a$
         IF INSTR(a$, "[") <> 0 THEN GOTO LoebUueRea
         INPUT #2, b$
         a$ = RTRIM$(RTRIM$(a$))
         b$ = RTRIM$(RTRIM$(b$))
         x = VAL(a$)
         i = VAL(b$)
         LINE (x, y)-(x + i, y), 7
         'PRINT "y="; y; "   x="; x; "   i="; i
        LOOP 'UNTIL INSTR(a$, "[") <> 0
lopp:
CLOSE #2
LOCATE 1, 1

'PRINT "Usernimi: "; user.nimi; "   Punktid: "; punktid(1, 2)
'PRINT "Mission nr: "; user.missioninr
'IF muutuja(99) = 1 THEN PRINT "Missiooni algustekst: VAJA NéIDATA"
'IF muutuja(99) = 0 THEN PRINT "Missiooni algustekst: EI OLE VAJA NéIDATA"
'IF muutuja(98) = 1 THEN PRINT "TIMER kÑib: "; INT(TIMER); ". Antudaeg: "; antudaeg; ". Maxaeg: "; maxaeg; ". Aega jÑrel:"; maxaeg - INT(TIMER)
'IF muutuja(98) = 0 THEN PRINT "TIMER ei kÑi. Maxaeg: "; maxaeg


mouseshow
END SUB

FUNCTION FUNCTIONpunktid$ (kask$, muutujanimi$, muutujavaartus$)

IF kask$ = "lisa" THEN
        FOR i = 1 TO 11
        IF i = 11 THEN EXIT FOR
        IF punktid(i, 1) = muutujanimi$ THEN EXIT FOR
        NEXT i
        IF i = 11 THEN
                FOR i = 1 TO 10
                IF i = 11 THEN EXIT FOR
                IF punktid(i, 1) = "" THEN EXIT FOR
                NEXT i
                IF i = 11 THEN i = 1
        END IF
punktid(i, 1) = muutujanimi$
punktid(i, 2) = muutujavaartus$
FUNCTIONpunktid = ""
EXIT FUNCTION
END IF

IF kask$ = "otsi" THEN
        FOR i = 1 TO 11
        IF i = 11 THEN EXIT FOR
        IF punktid(i, 1) = muutujanimi$ THEN EXIT FOR
        NEXT i
        IF i = 11 THEN FUNCTIONpunktid = ""
        IF i < 11 THEN FUNCTIONpunktid = punktid(i, 2)
EXIT FUNCTION
END IF


END FUNCTION

SUB historylisa (kask$, aadress$)

'VÂIMALUSED:
' historylisa "lisa", "http://huumor/" <- lisab uue aadressi cache'sse
' historylisa "back", "" <- pîîrdub viimati vaadatud lehekÅljele (1 lk tagasi)
' historylisa "last", "" <- pîîrdub viimati vaadatud lehekÅljele (sama lk)


IF kask$ = "lisa" THEN
        FOR i = 1 TO 11
        IF i = 11 THEN EXIT FOR
                IF nethistory(i) = aadress$ THEN EXIT FOR
                IF nethistory(i) = "" THEN nethistory(i) = aadress$: EXIT FOR
        NEXT i

        IF i < 10 THEN
         FOR a = i + 1 TO 10
         nethistory(a) = ""
         NEXT a
        END IF

        IF i = 10 THEN
         FOR b = 2 TO 10
         nethistory(b - 1) = nethistory(b)
         NEXT b
         nethistory(10) = aadress$
        END IF

END IF

IF kask$ = "back" THEN
        IF nethistory(1) = "" THEN EXIT SUB
        IF nethistory(2) = "" THEN EXIT SUB

          FOR i = 3 TO 11
          IF i = 11 THEN EXIT FOR
          IF nethistory(i) = "" THEN nethistory(i - 1) = "": a$ = nethistory(i - 2): EXIT FOR
          NEXT i
        
        'IF i < 11 THEN
        IF i = 11 THEN a$ = nethistory(9): nethistory(10) = ""

        lata a$, 1, 1
END IF

IF kask$ = "last" THEN
'FOR y = 8 TO 26
'        FOR x = 2 TO 79
'        LOCATE y, x
'        PRINT " "
'        link(x, y) = ""
'        NEXT x
'NEXT y

FOR i = 1 TO 10
IF i = 10 THEN EXIT FOR
IF nethistory(i + 1) = "" THEN EXIT FOR
NEXT i
IF nethistory(1) <> "" THEN lata nethistory(i), 1, 1: EXIT SUB
IF nethistory(1) = "" THEN lata "http://www.yehaa.com/", 1, 1: EXIT SUB

END IF

END SUB

SUB inputrida (search$, YY, x1, x2, varv, errorvaartus$)

mousehide
 COLOR varv
 LOCATE YY, x1
 FOR a = x1 TO x2
 LOCATE YY, a
 PRINT " "
 NEXT a
 LOCATE YY, x1

search$ = ""
           LOCATE YY, x1
           PRINT "≤"
           DO
             DO
             a$ = INKEY$
             LOOP UNTIL a$ > CHR$(31) OR a$ = CHR$(8) OR a$ = CHR$(13) OR a$ = CHR$(27)
           
            IF a$ = CHR$(13) THEN EXIT DO

            IF a$ = CHR$(8) THEN
                IF LEN(search$) > 0 THEN search$ = LEFT$(search$, LEN(search$) - 1)
                a$ = ""
            END IF
           
            IF a$ = CHR$(27) THEN search$ = "": EXIT DO
           
            search$ = search$ + a$
            LOCATE YY, x1
            PRINT search$
           
            IF LEN(search$) > (x2 - x1 - 1) THEN search$ = LEFT$(search$, LEN(search$) - 1)
           
            LOCATE YY, x1 + LEN(search$)
            PRINT "≤ "
           LOOP UNTIL a$ = CHR$(13)
           
            IF search$ = "" THEN search$ = errorvaartus$
            a$ = search$ + " "
            LOCATE YY, x1
            PRINT a$
           IF INSTR(search$, "[") THEN search$ = errorvaartus$

mouseshow
END SUB

SUB lata (latanimi$, x1, y1)


FOR nr = 1 TO 10
 ussid(nr).active = 0
NEXT nr


Parisalgus:
CALL mouseshow
CALL mousehide
RESET
IF LEFT$(latanimi$, 17) = "http://not found/" THEN notfound$ = RIGHT$(latanimi$, LEN(latanimi$) - 17): latanimi$ = "http://not found/"

IF INSTR(latanimi$, "http:") <> 0 THEN OPEN "hwc\internet.hw2" FOR INPUT AS #4
IF INSTR(latanimi$, "http:") = 0 AND LEFT$(latanimi$, 4) <> "shop" THEN OPEN "hwc\latad2.hw2" FOR INPUT AS #4
IF LEFT$(latanimi$, 4) = "shop" THEN OPEN "hwc\kuulutus.hw2" FOR INPUT AS #4

maxridadearv = 25000

lataleitud = 0
xx = x1
YY = y1
counter = 1
DO
IF EOF(4) THEN EXIT DO

LINE INPUT #4, rida$
IF rida$ = "[" + RTRIM$(LTRIM$(latanimi$)) + "]" THEN lataleitud = 1: EXIT DO
counter = counter + 1
LOOP UNTIL counter > maxridadearv

IF (INSTR(latanimi$, "http:") <> 0 AND lataleitud = 0) THEN
        latanimi$ = "http://not found/" + latanimi$
        'PRINT "maxridadearv: "; maxridadearv: PRINT "counter: "; counter: INPUT a
        IF counter > maxridadearv THEN PRINT "Vaja suurendada MAXRIDADEARV (sub lata)": PRINT "maxridadearv: "; maxridadearv: PRINT "counter: "; counter: INPUT a
        GOTO Parisalgus
END IF

IF LEFT$(latanimi$, 3) = "wos" THEN
        xx = 3: YY = 8: fc = 11: bc = 0
        cprint activedir, 4, 7, 0, 11, ""
        END IF

DO
IF EOF(4) THEN GOTO Taitsalopp
counter = counter + 1
LINE INPUT #4, rida$
'rida$ = latafail(counter)
IF LEFT$(rida$, 1) = "[" THEN EXIT DO
IF INSTR(rida$, "[") <> 0 THEN CLOSE #4: EXIT DO

7
IF rida$ = "adddaemon" THEN addaddress "mailer@daemon.com"
IF LEFT$(rida$, 14) = "name: esileht" THEN esileht 0
IF LEFT$(rida$, 5) = "esc: " THEN sesc = RIGHT$(rida$, LEN(rida$) - 5)
IF LEFT$(rida$, 4) = "sx: " THEN xx = VAL(RIGHT$(rida$, 2))
IF LEFT$(rida$, 4) = "sy: " THEN YY = VAL(RIGHT$(rida$, 2))
IF LEFT$(rida$, 4) = "fc: " THEN fc = VAL(RIGHT$(rida$, 2))
IF LEFT$(rida$, 4) = "bc: " THEN bc = VAL(RIGHT$(rida$, 2))
IF LEFT$(rida$, 3) = "t: " AND bc <> 0 THEN
        cprint RIGHT$(rida$, LEN(rida$) - 3), xx, YY, fc, bc, ""
        YY = YY + 1
        END IF
IF LEFT$(rida$, 3) = "t: " AND bc = 0 THEN
        COLOR fc
       
        FOR taht = 4 TO LEN(rida$)
        LOCATE YY, xx + taht - 4
        t$ = LTRIM$(RTRIM$(RIGHT$(LEFT$(rida$, taht), 1))): IF t$ = "" THEN t$ = " "
        PRINT t$
        ekraan(xx + taht - 4, YY) = LTRIM$(RTRIM$(RIGHT$(LEFT$(rida$, taht), 1)))
        link(xx + taht - 4, YY) = ""
        NEXT taht
        YY = YY + 1
        END IF
IF LEFT$(rida$, 4) = "ct: " THEN
        t$ = RIGHT$(rida$, LEN(rida$) - 16)
        cxx = VAL(RIGHT$(LEFT$(rida$, 6), 2))
        cyy = VAL(RIGHT$(LEFT$(rida$, 9), 2))
        cfc = VAL(RIGHT$(LEFT$(rida$, 12), 2))
        cbc = VAL(RIGHT$(LEFT$(rida$, 15), 2))
        cprint t$, cxx, cyy, cfc, cbc, ""
        END IF

IF LEFT$(rida$, 5) = "box: " THEN
        x1 = VAL(RIGHT$(LEFT$(rida$, 7), 2))
        y1 = VAL(RIGHT$(LEFT$(rida$, 10), 2))
        x2 = VAL(RIGHT$(LEFT$(rida$, 13), 2))
        y2 = VAL(RIGHT$(LEFT$(rida$, 16), 2))
        bc = VAL(RIGHT$(LEFT$(rida$, 19), 2))
        FOR rida = x1 TO x2
         FOR veerg = y1 TO y2
          ekraan(rida, veerg) = ""
          link(rida, veerg) = ""
         NEXT veerg
        NEXT rida
        x1 = 8 * (x1 - 1)
        x2 = 8 * x2 - 1
        y1 = 16 * (y1 - 1)
        y2 = 16 * y2 - 1
        LINE (x1, y1)-(x2, y2), bc, BF
         
         IF LEN(rida$) > 19 THEN
         N = VAL(RIGHT$(rida$, 1))
         fc = VAL(RIGHT$(LEFT$(rida$, 22), 2))
         IF N = 1 THEN
                LINE (x1 + 3, y1 + 7)-(x2 - 4, y2 - 8), fc, B
                LINE (x1 + 4, y1 + 7)-(x1 + 4, y2 - 8), fc
                LINE (x2 - 3, y1 + 7)-(x2 - 3, y2 - 8), fc
                END IF
         IF N = 2 THEN
                LINE (x1 + 5, y1 + 7)-(x2 - 5, y2 - 10), fc, B
                LINE (x1 + 6, y1 + 7)-(x1 + 6, y2 - 10), fc
                LINE (x2 - 4, y1 + 7)-(x2 - 4, y2 - 10), fc
               
                LINE (x1 + 2, y1 + 5)-(x2 - 2, y2 - 8), fc, B
                LINE (x1 + 3, y1 + 5)-(x1 + 3, y2 - 8), fc
                LINE (x2 - 1, y1 + 5)-(x2 - 1, y2 - 8), fc
                END IF
         END IF
        END IF


IF LEFT$(rida$, 3) = "l: " THEN
        FOR l = VAL(RIGHT$(LEFT$(rida$, 5), 2)) TO VAL(RIGHT$(LEFT$(rida$, 8), 2))
        link(l, YY - 1) = RIGHT$(rida$, LEN(rida$) - 9)
        NEXT l
        END IF
IF LEFT$(rida$, 6) = "link: " THEN
        YY = VAL(RIGHT$(LEFT$(rida$, 8), 2))
        FOR l = VAL(RIGHT$(LEFT$(rida$, 11), 2)) TO VAL(RIGHT$(LEFT$(rida$, 14), 2))
        link(l, YY) = RIGHT$(rida$, LEN(rida$) - 15)
        NEXT l
        END IF


IF rida$ = "clearlinks" THEN clearlinks


IF LEFT$(rida$, 6) = "date: " THEN
        cprint DATE$, VAL(RIGHT$(LEFT$(rida$, 8), 2)), VAL(RIGHT$(LEFT$(rida$, 11), 2)), VAL(RIGHT$(LEFT$(rida$, 14), 2)), VAL(RIGHT$(LEFT$(rida$, 17), 2)), ""
        END IF
IF LEFT$(rida$, 7) = "clock: " THEN
        YY = VAL(RIGHT$(LEFT$(rida$, 9), 2))
        l = VAL(RIGHT$(LEFT$(rida$, 12), 2))
        rida$ = "œclock: " + RIGHT$(LEFT$(rida$, 15), 2)
        ekraan(l, YY) = rida$
        END IF
IF LEFT$(rida$, 8) = "player: " THEN
        cprint user.nimi, VAL(RIGHT$(LEFT$(rida$, 10), 2)), VAL(RIGHT$(LEFT$(rida$, 13), 2)), VAL(RIGHT$(LEFT$(rida$, 16), 2)), VAL(RIGHT$(LEFT$(rida$, 19), 2)), ""
        END IF
IF LEFT$(rida$, 9) = "reklaam: " THEN
        YY = VAL(LEFT$(RIGHT$(rida$, LEN(rida$) - 9), 2))
        xx = VAL(LEFT$(RIGHT$(rida$, LEN(rida$) - 12), 2))
        rida$ = "œReklaam: "
        ekraan(xx, YY) = rida$
        END IF
 
  'usse juhtivad
IF LEFT$(rida$, 6) = "ussp: " THEN
        ekraan(VAL(RIGHT$(LEFT$(rida$, 8), 2)), VAL(RIGHT$(LEFT$(rida$, 11), 2))) = "œusskeera" + RIGHT$(rida$, 1)
        END IF
IF LEFT$(rida$, 8) = "ussend: " THEN
        ekraan(VAL(RIGHT$(LEFT$(rida$, 10), 2)), VAL(RIGHT$(LEFT$(rida$, 13), 2))) = "œussend"
        END IF
IF LEFT$(rida$, 10) = "ussalarm: " THEN
        ekraan(VAL(RIGHT$(LEFT$(rida$, 12), 2)), VAL(RIGHT$(LEFT$(rida$, 15), 2))) = "œussalarm " + RIGHT$(rida$, LEN(rida$) - 16)
        END IF
IF LEFT$(rida$, 6) = "ussj: " THEN
        ekraan(VAL(RIGHT$(LEFT$(rida$, 8), 2)), VAL(RIGHT$(LEFT$(rida$, 11), 2))) = "œusshyppa" + RIGHT$(rida$, 5)
        END IF
IF LEFT$(rida$, 5) = "uss: " THEN
        FOR nr = 1 TO 10
        IF ussid(nr).active = 0 THEN EXIT FOR
        NEXT nr
        ussid(nr).active = 1
        ussid(nr).x = VAL(RIGHT$(LEFT$(rida$, 7), 2))
        ussid(nr).y = VAL(RIGHT$(LEFT$(rida$, 10), 2))
        ussid(nr).c = VAL(LEFT$(RIGHT$(rida$, 4), 2))
        ussid(nr).suund = RIGHT$(rida$, 1)
        END IF

IF LEFT$(rida$, 7) = "pause: " THEN pause VAL(RIGHT$(rida$, LEN(rida$) - 7))

IF LEFT$(rida$, 11) = "activedir: " THEN activedir = RIGHT$(rida$, LEN(rida$) - 11)

IF LEFT$(rida$, 8) = "button: " THEN
        makenupp RIGHT$(rida$, LEN(rida$) - 8)
        END IF

IF LEFT$(rida$, 10) = "checkbox: " THEN
       
        x1 = VAL(RIGHT$(LEFT$(rida$, 12), 2))
        y1 = VAL(RIGHT$(LEFT$(rida$, 15), 2))
        nr = VAL(RIGHT$(LEFT$(rida$, 19), 3))
        enabled = VAL(RIGHT$(rida$, 1))
        makecheckbox x1, y1, nr, enabled
        LOCATE 1, 1
        END IF

IF LEFT$(rida$, 9) = "muutuja: " THEN muutuja(VAL(RIGHT$(LEFT$(rida$, 12), 3))) = VAL(RIGHT$(rida$, 1))
IF LEFT$(rida$, 3) = "m: " THEN
        IF muutuja(VAL(RIGHT$(LEFT$(rida$, 6), 3))) = VAL(RIGHT$(LEFT$(rida$, 8), 1)) THEN latanimi$ = RIGHT$(rida$, LEN(rida$) - 8): GOTO Parisalgus
        END IF

IF LEFT$(rida$, 10) = "antudaeg: " THEN antudaeg = VAL(RIGHT$(rida$, LEN(rida$) - 10))


IF LEFT$(rida$, 6) = "lata: " THEN
        IF rida$ = "lata: showactivedir" THEN latanimi$ = "wos " + activedir: CLOSE #4: GOTO Parisalgus
        IF rida$ <> "lata: showactivedir" THEN latanimi$ = RIGHT$(rida$, LEN(rida$) - 12): x1 = VAL(RIGHT$(LEFT$(rida$, 8), 2)): y1 = VAL(RIGHT$(LEFT$(rida$, LEN(rida$) - 11), 2)): CLOSE #4: GOTO Parisalgus
        END IF

IF LEFT$(rida$, 16) = "mission6kuulutus" THEN
        latanimi$ = mission6kuulutus$
        CLOSE #4
        GOTO Parisalgus
        END IF

IF LEFT$(rida$, 11) = "pressanykey" THEN
                DO
                LOOP UNTIL INKEY$ <> ""
        END IF

IF rida$ = "showmailid" THEN
         FOR y = 1 TO 10
          LOCATE y + 11, 14
          IF mail(y, 1) = "NEW" THEN COLOR 15: PRINT mail(y, 1)
          IF mail(y, 1) <> "NEW" THEN COLOR 7: PRINT mail(y, 1)
          IF mail(y, 1) <> "" THEN
                        msg$ = "mail " + mail(y, 2)
                        FOR i = 10 TO 55
                        link(i, y + 11) = msg$
                        NEXT i
          END IF

          LOCATE y + 11, 20
          PRINT mail(y, 2)
         NEXT y
        END IF
IF LEFT$(rida$, 5) = "loc: " THEN LOCATE 6, 14: PRINT "                                                  ": LOCATE 6, 14: COLOR 12: PRINT RIGHT$(rida$, LEN(rida$) - 5)
IF LEFT$(rida$, 5) = "loc: " THEN loc$ = RIGHT$(rida$, LEN(rida$) - 5): historylisa "lisa", loc$
IF LEFT$(rida$, 6) = "line: " THEN
   IF RIGHT$(rida$, 1) = "L" THEN LINE (VAL(LEFT$(RIGHT$(rida$, LEN(rida$) - 6), 3)), VAL(LEFT$(RIGHT$(rida$, LEN(rida$) - 10), 3)))-(VAL(LEFT$(RIGHT$(rida$, LEN(rida$) - 14), 3)), VAL(LEFT$(RIGHT$(rida$, LEN(rida$) - 18), 3))), VAL(LEFT$(RIGHT$( _
rida$, LEN(rida$) - 22), 2))
   IF RIGHT$(rida$, 1) = "B" THEN LINE (VAL(LEFT$(RIGHT$(rida$, LEN(rida$) - 6), 3)), VAL(LEFT$(RIGHT$(rida$, LEN(rida$) - 10), 3)))-(VAL(LEFT$(RIGHT$(rida$, LEN(rida$) - 14), 3)), VAL(LEFT$(RIGHT$(rida$, LEN(rida$) - 18), 3))), VAL(LEFT$(RIGHT$( _
rida$, LEN(rida$) - 22), 2)), B
   IF RIGHT$(rida$, 1) = "F" THEN LINE (VAL(LEFT$(RIGHT$(rida$, LEN(rida$) - 6), 3)), VAL(LEFT$(RIGHT$(rida$, LEN(rida$) - 10), 3)))-(VAL(LEFT$(RIGHT$(rida$, LEN(rida$) - 14), 3)), VAL(LEFT$(RIGHT$(rida$, LEN(rida$) - 18), 3))), VAL(LEFT$(RIGHT$( _
rida$, LEN(rida$) - 22), 2)), BF
END IF

IF LEFT$(rida$, 6) = "mail: " THEN
                'kui selline mail on juba olemas, siis ei tule uut maili
                FOR ua = 1 TO 11
                        IF ua = 11 THEN EXIT FOR
                        IF mail(ua, 2) = RIGHT$(rida$, LEN(rida$) - 6) THEN EXIT FOR
                NEXT ua
        IF ua = 11 THEN newmail RIGHT$(rida$, LEN(rida$) - 6)
END IF
IF LEFT$(rida$, 9) = "delmail: " THEN deletemail RIGHT$(rida$, LEN(rida$) - 9)

IF LEFT$(rida$, 13) = "clearnetscape" THEN
        FOR y = 8 TO 26
        FOR x = 2 TO 79
        LOCATE y, x
        PRINT " "
        ekraan(x, y) = ""
        link(x, y) = ""
        NEXT x
        NEXT y
        FOR nr = 1 TO 10
        ussid(nr).active = 0
        NEXT nr
END IF

IF rida$ = "kommentaar" THEN mission8kommentaar



LOOP UNTIL counter > maxridadearv
IF counter > maxridadearv THEN PRINT "Vaja suurendada MAXRIDADEARV (sub lata)": INPUT a

Taitsalopp:


IF latanimi$ = "http://not found/" THEN LOCATE 12, 3: COLOR 14: PRINT "URL not found: "; notfound$

lbt = 0: rbt = 0
pause 4



CLOSE #4
RESET



CALL mouseshow


END SUB

SUB loadlatafail (yksnumber AS INTEGER)
'RESET
'OPEN "hwc\latad2.hw2" FOR INPUT AS #4
'        counter = 1
'        DO
'        IF EOF(4) THEN EXIT DO
'        LINE INPUT #4, rida$
'        latafail(counter) = rida$
'        counter = counter + 1
'        LOOP
'CLOSE #4
'RESET

END SUB

SUB loadmission (fail$)

'PRINT "Flushing punktid..."
'punktid
FOR i = 2 TO 10            'peab olema 2-10!!!!
punktid(i, 1) = ""
punktid(i, 2) = ""
NEXT i
IF punktid(1, 1) = "" THEN punktid(1, 1) = "Eelmisest missioonist": punktid(1, 2) = "0"


'PRINT "Flushing muutujaSTRING..."
'muutujaSTRING
FOR i = 1 TO 20
muutujaSTRING(i, 1) = ""
muutujaSTRING(i, 2) = ""
NEXT i

'PRINT "Flushing muutuja..."
'muutuja
FOR i = 21 TO 499
muutuja(i) = 0
muutuja(i) = 0
NEXT i


'DIM SHARED datafail AS STRING

'PRINT "Flushing kiri..."
'kiri
FOR i = 1 TO 30
kiri(i) = ""
NEXT i

'PRINT "Flushing mailbox..."
'mail
FOR i = 1 TO 10
mail(i, 1) = ""
mail(i, 2) = ""
NEXT i


'PRINT "Flushing nethistory..."
FOR i = 1 TO 10
nethistory(i) = ""
NEXT i

'PRINT "Flushing ekraan/link..."
clearlinks
clearekraan
'FOR x = 1 TO 80
'FOR y = 1 TO 30
'ekraan(x, y) = ""
'link(x, y) = ""
'NEXT y
'NEXT x

activedir = ""
search$ = ""

'PRINT "Flushing timer..."
algusaeg = 0
antudaeg = 0
maxaeg = 0

'PRINT "Flushing reklaam..."
FOR i = 1 TO 20
reklaam(i) = ""
NEXT i
reklaaminumber = 0
reklaamiaeg = 0
timeaeg = 0

email$ = ""

activedir = "C:\"
sesc = "exitprogram" '

userinfo fail$

'***************************** MISSION 1 ALGUSE JAOKS ******************
IF user.missioninr = 0 OR user.missioninr = 1 THEN
        PRINT "Flushing MISSION 1 DATA"
        userinfo "hwc\start.hw2"
        user.gamename = "esimene"
        user.missioninr = 1
        muutuja(99) = 1
        'userinfo "" 'kogu useri kohta kÑiv info failist userinfo.tmp
END IF
'***********************************************************************

IF user.missioninr > 1 THEN
        FOR uuu = 1 TO user.missioninr - 1
        muutuja(uuu) = 0
        NEXT uuu
END IF
muutuja(user.missioninr) = 1
muutuja(99) = 1

savemission "hwc\userinfo.tmp"

msg$ = "showmission" + LTRIM$(RTRIM$(STR$(user.missioninr))) + "text"
maxaeg = 0
antudaeg = 0

END SUB

SUB LoadSaveGame (parameters$)

IF parameters$ = "savefiles" OR parameters$ = "loadfiles" THEN
COLOR 7
IF parameters$ = "savefiles" THEN lata "SaveGameLata", 1, 1
IF parameters$ = "loadfiles" THEN lata "LoadGameLata", 1, 1
      FOR i = 1 TO 3
        gamename$ = ""
        IF i = 1 THEN fail$ = "hwc\savgam1.hw2"
        IF i = 2 THEN fail$ = "hwc\savgam2.hw2"
        IF i = 3 THEN fail$ = "hwc\savgam3.hw2"
        OPEN fail$ FOR INPUT AS #6
         DO
          IF EOF(6) THEN EXIT DO
          LINE INPUT #6, a$
            IF a$ = "[gamename]" THEN
                IF EOF(6) THEN EXIT DO
                  LINE INPUT #6, a$
                  gamename$ = a$
            END IF
            IF LEFT$(a$, 11) = "missioninr " THEN missioninr$ = LTRIM$(RTRIM$(RIGHT$(a$, 2)))
          LOOP
         IF gamename$ = "" THEN gamename$ = "EMPTY"
         IF missioninr$ = "" THEN missioninr$ = "1"
        CLOSE #6
      LOCATE i + 17, 32
      PRINT gamename$
      LOCATE i + 17, 46
      PRINT missioninr$
      NEXT i
END IF

IF LEFT$(parameters$, 9) = "savegame?" THEN
        lata "savegame?x", 1, 1
        inputrida user.gamename, 18, 37, 44, 15, ""
        IF LTRIM$(RTRIM$(user.gamename)) = "" THEN user.gamename = "esimene": lata "1", 1, 1: EXIT SUB
        'else save
        lata "savegame", 1, 1
                fail$ = "hwc\savgam" + RIGHT$(parameters$, 1) + ".hw2"
                savemission fail$
END IF

IF LEFT$(parameters$, 9) = "loadgame?" THEN
        fail$ = "hwc\savgam" + RIGHT$(parameters$, 1) + ".hw2"
        'userinfo fail$
        loadmission fail$
        CLS
        lata "loadgame", 1, 1
        'muutuja(99) = 0
END IF



END SUB

SUB makecheckbox (x1, y1, nr, enabled)
mousehide
'x1 - Åks koht enne seda ‰iget. nr - muutuja number, mida muudetakse,
'enabled = 1 => enabled : enabled = 0 =>disabled

'joonistan selle suvalt vÑlja


fc = 15: IF enabled = 1 THEN fc = 15
bc = 7

'LINE (x1 * 8 - 8, y1 * 16 - 16)-(x1 * 8 + 15, y1 * 16 - 1), bc, BF
COLOR bc
LOCATE y1, x1
IF enabled = 1 THEN PRINT "€€€"
IF enabled = 0 THEN PRINT "∞∞∞"
       
'kirjutan vÑÑrtuse vahepeal
        IF muutuja(nr) = 1 THEN
        PSET (x1 * 8, y1 * 16 - 8), fc
        DRAW "d1;r1;d2;r1;d2;r1;d1;u1;r1;u2;r1;u3;r1;u3;r1;u3"
        'cprint "Y", x1 + 1, y1, fc, bc, ""
        END IF
LINE (x1 * 8 - 8, y1 * 16 - 16)-(x1 * 8 + 15, y1 * 16 - 16), 8
LINE (x1 * 8 - 8, y1 * 16 - 16)-(x1 * 8 - 8, y1 * 16 - 1), 8
LINE (x1 * 8 + 15, y1 * 16 - 15)-(x1 * 8 + 15, y1 * 16 - 1), 15
LINE (x1 * 8 - 8, y1 * 16 - 1)-(x1 * 8 + 15, y1 * 16 - 1), 15

'teen mÑlust selle koha tÅhjaks
FOR x = x1 TO x1 + 2
ekraan(x, y1) = ""
NEXT x

LOCATE 1, 1

'kirjutan, kas Y v‰i < >, ja annan linkidele uue vÑÑrtuse
IF enabled = 1 THEN
        link(x1 + 1, y1) = "muutuja " + LTRIM$(STR$(nr)) + " " + LTRIM$(STR$(ABS(muutuja(nr) - 1)))
        ekraan(x1 + 1, y1) = "œcheckbox"
        END IF

'l$ = "checkbox"

mouseshow

END SUB

SUB makenupp (nupunimi$)

pressed = 0
y1 = 1: y2 = 2: x1 = 1: x2 = 2: fc = 15: bc = 9
IF LEFT$(nupunimi$, 7) = "pressed" THEN
        pressed = 1
        nupunimi$ = RIGHT$(nupunimi$, LEN(nupunimi$) - 7)
        END IF
IF pressed = 0 THEN hc = 15: sc = 8
IF pressed = 1 THEN hc = 8: sc = 15

OPEN "hwc/nupud.hw2" FOR INPUT AS #5

DO
IF EOF(5) THEN EXIT DO
LINE INPUT #5, r$
LOOP UNTIL r$ = "[" + nupunimi$ + "]"

DO
IF EOF(5) THEN EXIT DO
LINE INPUT #5, r$

IF LEFT$(r$, 4) = "fc: " THEN fc = VAL(RIGHT$(r$, 2))
IF LEFT$(r$, 4) = "bc: " THEN bc = VAL(RIGHT$(r$, 2))
IF LEFT$(r$, 4) = "y1: " THEN y1 = VAL(RIGHT$(r$, 2))
IF LEFT$(r$, 4) = "y2: " THEN y2 = VAL(RIGHT$(r$, 2))
IF LEFT$(r$, 4) = "x1: " THEN x1 = VAL(RIGHT$(r$, 2))
IF LEFT$(r$, 4) = "x2: " THEN x2 = VAL(RIGHT$(r$, 2))
IF LEFT$(r$, 6) = "text: " THEN
        t$ = RIGHT$(r$, LEN(r$) - 6)
       
        IF LEN(t$) < x2 - x1 - 1 THEN t$ = SPACE$(INT((x2 - x1 - LEN(t$)) / 2)) + t$ + SPACE$(INT((x2 - x1 - LEN(t$)) / 2))
        ty = INT(y2 + y1) / 2
        LINE (x1 * 8 - 8, y1 * 16 - 16)-(x2 * 8 - 1, y2 * 16 - 1), bc, BF
       
          FOR x = x1 TO x2: FOR y = y1 TO y2
          ekraan(x, y) = ""
          NEXT y: NEXT x
       
        cprint t$, x1, ty, fc, bc, ""
       

        LINE (x1 * 8 - 8, y1 * 16 - 16)-(x2 * 8 - 1, y1 * 16 - 16), hc
        LINE (x1 * 8 - 8, y1 * 16 - 16)-(x1 * 8 - 8, y2 * 16 - 1), hc
        LINE (x2 * 8 - 1, y1 * 16 - 15)-(x2 * 8 - 1, y2 * 16 - 1), sc
        LINE (x1 * 8 - 7, y2 * 16 - 1)-(x2 * 8 - 1, y2 * 16 - 1), sc
        END IF
        
IF LEFT$(r$, 6) = "link: " AND pressed = 0 THEN
        t$ = RIGHT$(r$, LEN(r$) - 6)
        FOR x = x1 TO x2
        FOR y = y1 TO y2
         link(x, y) = t$
        NEXT y
        NEXT x
        END IF
IF LEFT$(r$, 7) = "plink: " AND pressed = 1 THEN
        t$ = RIGHT$(r$, LEN(r$) - 7)
        FOR x = x1 TO x2
        FOR y = y1 TO y2
         link(x, y) = t$
        NEXT y
        NEXT x
       
       
        
       
       
       
        END IF
        
       
LOOP UNTIL LEFT$(r$, 1) = "["

'CLOSE #5
CLOSE #5

END SUB

SUB mission1 (ohoo$)

IF g$ = "mission1 ilmajaamID" THEN
        inputrida a$, 16, 13, 20, 15, ""
   END IF

IF g$ = "mission1 ilmajaamPASSWORD" THEN
        inputrida a$, 17, 13, 20, 15, ""
        muutuja(21) = 1
        lata "http://www.ilmajaam.com/login/enter/", 1, 1
        lata "http://www.ilmajaam.com/login/first/", 1, 1
   END IF

IF g$ = "mission1 ilmajaam disagree" THEN
        'lataIDedit 10, 1
        historylisa "back", ""
   END IF

IF g$ = "mission1 generateILM" THEN
         kuupaev$ = LEFT$(RIGHT$(DATE$, 7), 2)       'paev
         kuupaev$ = kuupaev$ + LEFT$(DATE$, 2)       'kuu
         kuupaev$ = kuupaev$ + RIGHT$(DATE$, 4)      'aasta
        msg$ = ""
        email$ = ""
       
        'kuupaev
        IF muutuja(28) = 1 THEN
                a$ = muutujaSTRINGsub("otsi", "IlmajaamKP", "")
                IF LEN(a$) = 8 THEN msg$ = LEFT$(a$, 2) + "." + RIGHT$(LEFT$(a$, 4), 2) + "." + RIGHT$(a$, 4)
                IF a$ = kuupaev$ THEN msg$ = "TÑna"
        END IF
        IF msg$ = "" THEN msg$ = "Homme"
       
        'pilvisus
        a$ = ""
        IF muutuja(29) = 1 THEN a$ = " on pilves ilm,": c$ = "Tolvan!" + CHR$(13) + " " + CHR$(13) + "Palusin sinult ju pilvitut ilma, aga siin" + CHR$(13) + "kisub taevas iga hetkega Åha sÅngemaks!"
        IF muutuja(30) = 1 THEN a$ = " on vahelduva" + CHR$(13) + "pilvisusega ilm,": c$ = "Susserdaja!" + CHR$(13) + " " + CHR$(13) + "Kus on ilus ilm? Pilved keerutavad taevas nagu" + CHR$(13) + "segased ja Ñhvardavad iga hetk vihma!"
        IF muutuja(31) = 1 THEN a$ = " on tÑiesti " + CHR$(13) + "pilvitu ilm,": c$ = "Susserdaja!" + CHR$(13) + " "
        IF a$ <> "" THEN msg$ = msg$ + a$: email$ = email$ + c$
        IF a$ = "" THEN msg$ = msg$ + " on kohutavalt" + CHR$(13) + "sajune ilm,": email$ = "Susserdaja!" + CHR$(13)
                
        'tuul
        a$ = ""
        IF muutuja(33) = 1 THEN
                a$ = muutujaSTRINGsub("otsi", "IlmajaamTUULs", "")
                IF LEN(a$) = 0 THEN a$ = "NW"
        END IF
        IF a$ = "" THEN a$ = "NW"
        msg$ = msg$ + CHR$(13) + "tuul puhub suunaga " + a$:
          a$ = ""
          IF muutuja(34) = 1 THEN
                a$ = muutujaSTRINGsub("otsi", "IlmajaamTUULt", "")
                IF LEN(a$) = 0 THEN a$ = "12"
          END IF
          IF a$ = "" THEN a$ = "12"
          msg$ = msg$ + CHR$(13) + "ja kiirusega " + a$ + " m/s."
                IF a$ = "" OR a$ = "0" OR a$ = "00" THEN
                 email$ = email$ + CHR$(13) + "VÑhemalt on tuuletu ilm!"
                ELSE
                 email$ = email$ + CHR$(13) + "Mis meeletu tuul siin veel on???"
                END IF
       
        'temperatuur
        a$ = ""
        IF muutuja(32) = 1 THEN a$ = muutujaSTRINGsub("otsi", "IlmajaamTEMP", "")
        IF a$ = "" THEN a$ = "14"
        kraad$ = a$
        msg$ = msg$ + CHR$(13) + "Sooja on " + a$ + " kraadi."

        'pÑike t‰useb/loojub
        a$ = ""
        IF muutuja(35) = 1 THEN a$ = LEFT$(muutujaSTRINGsub("otsi", "IlmajaamPT", ""), 2) + ":" + RIGHT$(muutujaSTRINGsub("otsi", "IlmajaamPT", ""), 2)
        IF a$ = "" THEN a$ = "4:55"
        b$ = ""
        IF muutuja(35) = 1 THEN b$ = LEFT$(muutujaSTRINGsub("otsi", "IlmajaamPL", ""), 2) + ":" + RIGHT$(muutujaSTRINGsub("otsi", "IlmajaamPL", ""), 2)
        IF b$ = "" THEN b$ = "22:14"
        msg$ = msg$ + CHR$(13) + "PÑike tìuseb: " + a$ + CHR$(13) + "      loojub: " + b$

        'kuu
        a$ = ""
        IF muutuja(37) = 1 THEN a$ = "Kuuseis: noorkuu": c$ = "Ilusa kuu oled taevasse organiseerinud!" + CHR$(13) + "Aga ega sa selleks ometi firma rahasid" + CHR$(13) + "ei kasutanud?"
        IF muutuja(38) = 1 THEN a$ = "Kuuseis: tÑiskuu": c$ = "Ilusa tÑiskuu oled taevasse organiseerinud!" + CHR$(13) + "Aga ega sa selleks ometi firma rahasid" + CHR$(13) + "ei kasutanud?"
        IF muutuja(39) = 1 THEN a$ = "Kuuseis: vanakuu": c$ = "Mida peaks tÑhendama vanakuu? Kas vihjad" + CHR$(13) + "mu vanusele??? KUI MA SU KéTTE SAAN!!!!"
        IF a$ <> "" THEN msg$ = msg$ + CHR$(13) + a$: email$ = email$ + CHR$(13) + c$
        IF a$ = "" THEN msg$ = msg$ + CHR$(13) + "Kuuseis: hirmuÑratav": email$ = email$ + CHR$(13) + "Ilusa kuu oleksid vìinud mulle taevasse" + CHR$(13) + "organiseerida! Sa tead, et oleksin selle" + CHR$(13) + "sulle pÑrast kinni maksnud!"

        msg$ = msg$ + CHR$(13)
       
        a$ = muutujaSTRINGsub("otsi", "IlmajaamKP", "")
       
        
        IF (muutuja(28) = 1 AND a$ = kuupaev$ AND muutuja(40) = 0) THEN
                a = 0
                'kui on vÑhe pilvi
                IF (muutuja(29) = 0 AND (muutuja(30) = 1 OR muutuja(31) = 1)) THEN a = 1
               
                IF muutuja(34) = 1 THEN a$ = muutujaSTRINGsub("otsi", "IlmajaamTUULt", ""): IF a$ = "0" OR a$ = "00" THEN a = a + 1
                IF a < 1 THEN
                        email$ = email$ + CHR$(13) + " " + CHR$(13) + "OLED SAAMATU KOBAKéPP! OLED VALLANDATUD!" + CHR$(13) + " " + CHR$(13) + "sinu boss" + CHR$(13)
                        newmail "Rikutud piknik"
                        muutuja(40) = 1
                END IF
                IF a >= 1 THEN
                        muutuja(50) = 1
                        email$ = email$ + CHR$(13) + "Ma olen su tîîga rahul." + CHR$(13) + " " + CHR$(13) + "sinu boss" + CHR$(13)
                        'x$ = FUNCTIONpunktid("lisa", "Missiooni tÑitmise eest", "+10000")
                        IF (muutuja(38) = 1 AND muutuja(37) = 0 AND muutuja(39) = 0) THEN muutuja(51) = 1
                        newmail "Piknikult"
                        muutuja(40) = 1
                END IF
        END IF

        IF (g$ = "mission1 generateILM" AND ohoo$ = "vanamission") THEN
                email$ = email$ + CHR$(13) + " " + CHR$(13) + "Sinu boss."
                EXIT SUB
        END IF

        lata "http://www.ilmajaam.com/ilmamasin/generate.cgi/", 1, 1
        lata "http://www.ilmajaam.com/ilmamasin/generate/", 1, 1
        lata "http://www.ilmajaam.com/ilmamasin/report/", 1, 1

        mousehide
        i = 16
        COLOR 7
          DO
                a = INSTR(msg$, CHR$(13))
                IF a <= 0 THEN EXIT DO
                a$ = LEFT$(msg$, a)
                msg$ = RIGHT$(msg$, LEN(msg$) - a)
                LOCATE i, 6
                PRINT a$
                i = i + 1
                'IF i > 28 THEN EXIT DO
          LOOP
        mouseshow
       
END IF

END SUB

SUB mission2 (ohoo1$)

IF g$ = "mission2 searchkodu" THEN
a$ = muutujaSTRINGsub$("otsi", "kodu", "")
IF (a$ <> "0.2" AND a$ <> "") THEN muutuja(75) = 1
IF (muutuja(75) = 1 AND muutuja(76) = 0) THEN newmail "ABI TULEB!": muutuja(76) = 1
lata "http://www.kanalisatsioon.ee/valvur/", 1, 1
END IF





END SUB

SUB mission6 (ohoo$)

IF ohoo$ = "kuulutus" THEN lata "shop1", 1, 1

END SUB

FUNCTION mission6kuulutus$

a% = RND * 22
b$ = "shop" + LTRIM$(RTRIM$(STR$(a%)))
mission6kuulutus$ = b$
IF a% = 0 THEN mission6kuulutus$ = "shopSEEP"

END FUNCTION

SUB mission8kommentaar
a = INT(RND * 20) + 1
cprint "                               ", 10, 8, 15, 0, ""
cprint "                               ", 10, 9, 15, 0, ""


SELECT CASE a
  CASE 1
     msg1$ = "Tohoh! Vastane sai palli"
     msg2$ = "oma valdusse!"
  CASE 2
     msg1$ = "NÅÅd peaks kÅll meie mehed"
     msg2$ = "ka rÅnnakule saama"
  CASE 3
     msg1$ = "Ja pall on..."
     msg2$ = " meie kÑes!"
  CASE 4
     msg1$ = "Edasi, Kentucky poisid!"
     msg2$ = ""
  CASE 5
     msg1$ = "Siit vaadates tundus korraks,"
     msg2$ = "et pall oli juba sees."
  CASE 6
     msg1$ = "Hmm. Kisub vist vihmale..."
     msg2$ = ""
  CASE 7
     msg1$ = "Oo, milline tehnika."
     msg2$ = ""
  CASE 8
     msg1$ = "Ei ole meie meestel seda"
     msg2$ = " kiirust."
  CASE 9
     msg1$ = "Sellise mÑnguga ei vìideta"
     msg2$ = "kÅll kedagi"
  CASE 10
     msg1$ = "Sellest mÑngust vìib saada"
     msg2$ = "ajaloo tÅÅtuim mÑng."
  CASE 11
     msg1$ = "JÑlle vìeti pall Ñra!"
     msg2$ = ""
  CASE 12
     msg1$ = "Meie mehed vìiks ka sama-"
     msg2$ = "moodi teeselda."
  CASE 13
     msg1$ = "Kìigele lisaks on kohtunik"
     msg2$ = "ka meie vastu."
  CASE 14
     msg1$ = "Ei tulnud seekord kokku-"
     msg2$ = "mÑngust asja"
  CASE 15
     msg1$ = "Sellest rÅnnakust vìib"
     msg2$ = "veel asja saada."
  CASE 16
     msg1$ = "Publik ootab muidugi meie"
     msg2$ = "meeste vìitu."
  CASE 17
     msg1$ = "Siiamaale ei ole isegi"
     msg2$ = "vilet enam kuulda."
  CASE 18
     msg1$ = "Milline sîît!"
     msg2$ = ""
  CASE 19
     msg1$ = "Oi, milline ebaìnn."
     msg2$ = ""
  CASE 20
     msg1$ = "Eks meie meestel ole"
     msg2$ = "muidugi vÑsimust ka."


END SELECT
cprint msg1$, 10, 8, 12, 0, ""
cprint msg2$, 10, 9, 12, 0, ""


END SUB

SUB missionipealkiri (mnr)

'PRINT TIMER
'SLEEP 6

'algusaeg = 10000
algusaeg = INT(TIMER)
'PRINT ahaa
'SLEEP 6


SCREEN 13
clearekraan

mousehide
pause 20

FOR i = 0 TO 41
        OUT &H3C8, i
        OUT &H3C9, i
        OUT &H3C9, 0
        OUT &H3C9, 0
    
        OUT &H3C8, i + 42
        OUT &H3C9, 42 + (i / 2)
        OUT &H3C9, INT(2 / 3 * i)
        OUT &H3C9, INT(2 / 3 * i)
    
        OUT &H3C8, i + 84
        OUT &H3C9, 63
        OUT &H3C9, 27 + INT(1 / 3 * i)
        OUT &H3C9, 27 - INT(2 / 3 * i)


        OUT &H3C8, i + 126
        OUT &H3C9, 63 - INT(i / 2)
        OUT &H3C9, 42 - INT(1 / 3 * i)
        OUT &H3C9, 0

        OUT &H3C8, i + 168
        OUT &H3C9, 42 - INT(i / 2)
        OUT &H3C9, 27 - INT(2 / 3 * i)
        OUT &H3C9, 0


        OUT &H3C8, i + 210
        OUT &H3C9, 21 - INT(i / 2)
        OUT &H3C9, 0
        OUT &H3C9, 0
NEXT i



clearekraan
FOR i = 0 TO 250

IF i = 120 THEN pause 50
'PSET (i, 100), i
COLOR i
pause 1

missionnr$ = "MISSION 1"
missionname$ = "Bla bla bla"
a = LEN(missionnr$)
b = LEN(missionname$)
LOCATE 18, (20 - INT(a / 2))
PRINT missionnr$
LOCATE 19, (20 - INT(b / 2))
PRINT missionname$
i = i + 4
NEXT i

CLS
PALETTE

SCREEN 12
CLS

mouseshow
lata "WOS", 1, 1

END SUB

SUB MissionStartEnd (text$)

DIM skoor AS LONG
DIM missionskoor AS LONG
DIM aegayle AS LONG

muutuja(98) = 0 'st timer ei kÑi enam (JUHUL, kui ta veel kÑis)

CLS
SCREEN 13
CLS
pause 30
FOR i = 0 TO 41
        OUT &H3C8, i
        OUT &H3C9, i
        OUT &H3C9, 0
        OUT &H3C9, 0
  
        OUT &H3C8, i + 42
        OUT &H3C9, 42 + (i / 2)
        OUT &H3C9, INT(2 / 3 * i)
        OUT &H3C9, INT(2 / 3 * i)
  
        OUT &H3C8, i + 84
        OUT &H3C9, 63
        OUT &H3C9, 27 + INT(1 / 3 * i)
        OUT &H3C9, 27 - INT(2 / 3 * i)


        OUT &H3C8, i + 126
        OUT &H3C9, 63 - INT(i / 2)
        OUT &H3C9, 42 - INT(1 / 3 * i)
        OUT &H3C9, 0

        OUT &H3C8, i + 168
        OUT &H3C9, 42 - INT(i / 2)
        OUT &H3C9, 27 - INT(2 / 3 * i)
        OUT &H3C9, 0


        OUT &H3C8, i + 210
        OUT &H3C9, 21 - INT(i / 2)
        OUT &H3C9, 0
        OUT &H3C9, 0
NEXT i



CLS

IF LEFT$(text$, 8) = "timeover" THEN pealkiri$ = "AEG OTSAS!": alapealkiri$ = "MISSIOON TéIDETUD!": text$ = "missionfailed "
IF LEFT$(text$, 14) = "missionfailed " THEN alapealkiri$ = "MISSIOON KAOTATUD!"
IF LEFT$(text$, 17) = "missioncompleted " THEN alapealkiri$ = "MISSIOON TéIDETUD!"
IF LEFT$(text$, 13) = "missiontext 1" THEN pealkiri$ = "MISSIOON 1": alapealkiri$ = "Piknik Lepassaares"
IF LEFT$(text$, 13) = "missiontext 2" THEN pealkiri$ = "MISSIOON 2": alapealkiri$ = "Kanalisatsioonis"
IF LEFT$(text$, 13) = "missiontext 3" THEN pealkiri$ = "MISSIOON 3": alapealkiri$ = "Cheoppzy pÅramiid"
IF LEFT$(text$, 13) = "missiontext 4" THEN pealkiri$ = "MISSIOON 4": alapealkiri$ = "Haigused"
IF LEFT$(text$, 13) = "missiontext 5" THEN pealkiri$ = "MISSIOON 5": alapealkiri$ = "Alati kohale!"
IF LEFT$(text$, 13) = "missiontext 6" THEN pealkiri$ = "MISSIOON 6": alapealkiri$ = "Uued seebiseriaalid"
IF LEFT$(text$, 13) = "missiontext 7" THEN pealkiri$ = "MISSIOON 7": alapealkiri$ = "Suur mÑngumaania"
IF LEFT$(text$, 13) = "missiontext 8" THEN pealkiri$ = "MISSIOON 8": alapealkiri$ = "Palli taguma!"
IF LEFT$(text$, 13) = "missiontext 9" THEN pealkiri$ = "MISSIOON 9": alapealkiri$ = "KÑkitegu"
muutuja(99) = 0

FOR i = 0 TO 250
IF i = 120 THEN pause 60
IF user.missioninr = 9 AND LEFT$(text$, 17) = "missioncompleted " AND i = 120 THEN EXIT FOR
COLOR i
pause 1
a = LEN(pealkiri$)
b = LEN(alapealkiri$)
LOCATE 16, (20 - INT(a / 2))
PRINT pealkiri$
LOCATE 18, (20 - INT(b / 2))
PRINT alapealkiri$
i = i + 4
NEXT i

c = 0
IF user.missioninr <> 9 THEN PALETTE: SCREEN 12: CLS
IF user.missioninr = 9 AND LEFT$(text$, 17) <> "missioncompleted " THEN PALETTE: SCREEN 12: CLS

IF LEFT$(text$, 14) = "missionfailed " THEN loadmission "hwc\userinfo.tmp": lata "1", 1, 1: EXIT SUB
IF LEFT$(text$, 12) = "missiontext " THEN
        muutuja(99) = 0
        maxaeg = INT(TIMER) + antudaeg
        muutuja(98) = 1
        lata "MAILBOX", 1, 1
        EXIT SUB
END IF


'******************************** PUNKTID **************************
IF user.missioninr = 1 THEN
        i = 2
        IF muutuja(50) = 1 THEN punktid(i, 1) = "Missiooni tÑitmise eest": punktid(i, 2) = "+1000": i = i + 1: muutuja(50) = 0
        IF muutuja(51) = 1 THEN punktid(i, 1) = "Ilusa tÑiskuu eest": punktid(i, 2) = "+100": i = i + 1: muutuja(51) = 0
                aegayle = INT(maxaeg - INT(TIMER))
        punktid(i, 1) = "Time bonus": punktid(i, 2) = STR$(aegayle): i = i + 1
END IF
IF user.missioninr = 2 THEN
        i = 2
        punktid(i, 1) = "Missiooni tÑitmise eest": punktid(i, 2) = "+1000": i = i + 1
                aegayle = INT(maxaeg - INT(TIMER))
        punktid(i, 1) = "Time bonus": punktid(i, 2) = STR$(aegayle): i = i + 1
END IF
IF user.missioninr = 3 THEN
        i = 2
        punktid(i, 1) = "Missiooni tÑitmise eest": punktid(i, 2) = "+1000": i = i + 1
                aegayle = INT((maxaeg - INT(TIMER)) * 1.5)
        punktid(i, 1) = "Time bonus": punktid(i, 2) = STR$(aegayle): i = i + 1
END IF
IF user.missioninr = 4 THEN
        i = 2
        punktid(i, 1) = "Missiooni tÑitmise eest": punktid(i, 2) = "+1000": i = i + 1
                aegayle = INT((maxaeg - INT(TIMER)) * 1.5)
        punktid(i, 1) = "Time bonus": punktid(i, 2) = STR$(aegayle): i = i + 1
END IF
IF user.missioninr = 5 THEN
        i = 2
        punktid(i, 1) = "Missiooni tÑitmise eest": punktid(i, 2) = "+1000": i = i + 1
                aegayle = INT((maxaeg - INT(TIMER)) * 1.5)
        punktid(i, 1) = "Time bonus": punktid(i, 2) = STR$(aegayle): i = i + 1
END IF
IF user.missioninr = 6 THEN
        i = 2
        punktid(i, 1) = "Missiooni tÑitmise eest": punktid(i, 2) = "+1000": i = i + 1
                aegayle = INT((maxaeg - INT(TIMER)) * 1.5)
        punktid(i, 1) = "Time bonus": punktid(i, 2) = STR$(aegayle): i = i + 1
END IF
IF user.missioninr = 7 THEN
        i = 2
        punktid(i, 1) = "Missiooni tÑitmise eest": punktid(i, 2) = "+999": i = i + 1
END IF
IF user.missioninr = 8 THEN
        i = 2
        punktid(i, 1) = "Missiooni tÑitmise eest": punktid(i, 2) = "+1000": i = i + 1
                aegayle = INT((maxaeg - INT(TIMER)) * 1.5)
        punktid(i, 1) = "Time bonus": punktid(i, 2) = STR$(aegayle): i = i + 1
        IF muutuja(190) = 1 THEN punktid(i, 1) = "Uue mÑngu eest": punktid(i, 2) = "+300": i = i + 1
        IF muutuja(192) = 1 THEN punktid(i, 1) = "HeldekÑelisus": punktid(i, 2) = "-500": i = i + 1
        IF muutuja(197) = 1 THEN punktid(i, 1) = "Kobatsemine": punktid(i, 2) = "-200": i = i + 1
        punktid(i, 1) = "KÑibemaks": punktid(i, 2) = "-143": i = i + 1
END IF
IF user.missioninr = 9 THEN
        i = 2
        punktid(i, 1) = "Missiooni tÑitmise eest": punktid(i, 2) = "+2000": i = i + 1
END IF



'***************************** LÂPUS **************

IF user.missioninr = 9 AND LEFT$(text$, 17) = "missioncompleted " THEN

        OUT &H3C8, 15
        OUT &H3C9, 63
        OUT &H3C9, 63
        OUT &H3C9, 63

  COLOR 15
     FOR y% = 0 TO 10
       pause 1
       LINE (0, y% * 10)-(320, y% * 10 + 9), 15, BF
       LINE (0, 200 - y% * 10)-(320, 191 - y% * 10), 15, BF
     NEXT y%
   LINE (0, 100)-(320, 100), 0
   pause 5
     FOR x% = 0 TO 15
       LINE (x% * 10, 99)-(x% * 10 + 9, 101), 15, BF
       LINE (320 - x% * 10, 99)-(311 - x% * 10, 101), 15, BF
       pause 1
     NEXT x%
     pause 20
LOCATE 13, 15
PRINT "MÑngu lìpp"
pause 40
SCREEN 12

END IF
'LOCATE 13, 15
'PRINT "MÑngu lìpp"
'pause 40
'SCREEN 12
'*******************************************************************





COLOR 4
LOCATE 4, 1
PRINT "           ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø"
PRINT "           ≥                       PUNKTID                     ≥"
PRINT "           √ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥"

FOR i = 1 TO 10
IF punktid(i, 1) = "" THEN EXIT FOR

LOCATE 6 + (i * 2) - 1, 1
COLOR 4
PRINT "           ≥                                   ≥               ≥"
PRINT "           √ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥"
a$ = punktid(i, 1)
a = LEN(a$)
LOCATE 6 + (i * 2) - 1, 47 - a
IF i = 1 THEN COLOR 12
PRINT a$
LOCATE 6 + (i * 2) - 1, 50
PRINT punktid(i, 2); " bytes"
IF i = 1 THEN COLOR 4
IF i > 1 THEN missionskoor = missionskoor + VAL(punktid(i, 2))
LOCATE
NEXT i

COLOR 4
LOCATE 6 + (i * 2) - 1, 1
PRINT "           ≥                                   ≥               ≥"
PRINT "           √ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥"
PRINT "           ≥                                   ≥               ≥"
PRINT "           ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ"
COLOR 12
LOCATE 6 + (i * 2) - 1, 27
PRINT "Selle missiooni eest"
LOCATE 6 + (i * 2) - 1, 49
PRINT missionskoor; " bytes"
LOCATE 6 + (i * 2) + 1, 38
PRINT "K O K K U"
LOCATE 6 + (i * 2) + 1, 49
skoor = missionskoor + VAL(punktid(1, 2))
PRINT skoor; " bytes"

'COLOR 4
'PRINT "           ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ"
punktid(1, 1) = "Eelmisest missioonist"
punktid(1, 2) = STR$(skoor)

DO
LOOP UNTIL INKEY$ <> ""

showtabel "uuenda"

IF user.missioninr = 9 THEN
   RESET
   CLOSE
   SCREEN 0
   PRINT "---------------------- AitÑh mÑngimast! -------------------------"
   PRINT
   PRINT ""
   PRINT "  Loodame, et suutsime halli argiellu tuua m‰nusat vaheldust"
   PRINT "                  ja ohtralt r‰‰muhetki! :)"
   PRINT
   PRINT "TÑname k‰iki fÑnne ja s‰pru-tuttavaid, kes meid veel unustanud"
   PRINT "ei ole! Ka SINA saad saata meile e-kaarti, meie mailiaadress on"
   PRINT "                        cooler@hot.ee"
   PRINT ""
   PRINT "                                   HACKERS WORLD II AUTORID"
   PRINT "-----------------------------------------------------------------"
    SYSTEM
END IF


muutuja(user.missioninr) = 0
muutuja(user.missioninr + 1) = 1
user.missioninr = user.missioninr + 1
savemission "hwc\userinfo.tmp"
loadmission "hwc\userinfo.tmp"


lata "1", 1, 1
END SUB

DEFLNG A-Z
'made by Ryan Williams
SUB MouseDriver (ahx%, bhx%, chx%, dhx%)
  DEF SEG = VARSEG(mouse$)
  mouse% = SADD(mouse$)
  CALL absolute(ahx%, bhx%, chx%, dhx%, mouse%)
END SUB

'made by Ryan Williams
SUB mousehide
 ahx% = 2
 MouseDriver ahx%, 0, 0, 0
END SUB

'made by Ryan Williams
FUNCTION MouseInit%
  ahx% = 0
  MouseDriver ahx%, 0, 0, 0
  MouseInit% = ahx%
END FUNCTION

'made by Ryan Williams
SUB MousePut (hx%, hy%)
  ahx% = 4
  chx% = hx%
  dhx% = hy%
  MouseDriver ahx%, 0, chx%, dhx%
END SUB

'made by Ryan Williams
SUB MouseRange (hX1%, hY1%, hx2%, hY2%)
  ahx% = 7
  chx% = hX1%
  dhx% = hx2%
MouseDriver ahx%, 0, chx%, dhx%
  ahx% = 8
  chx% = hY1%
  dhx% = hY2%
  MouseDriver ahx%, 0, chx%, dhx%
END SUB

'made by Ryan Williams
SUB mouseshow
  ahx% = 1
  MouseDriver ahx%, 0, 0, 0
END SUB

'made by Ryan Williams
SUB mousestatus (lb%, rb%, xMouse%, yMouse%)
  ahx% = 3
  MouseDriver ahx%, bhx%, chx%, dhx%
  lb% = ((bhx% AND 1) <> 0)
  rb% = ((bhx% AND 2) <> 0)
  xMouse% = chx%
  yMouse% = dhx%
END SUB

DEFINT A-Z
FUNCTION muutujaSTRINGsub$ (kask$, muutujanimi$, muutujavaartus$)


IF kask$ = "lisa" THEN
        FOR i = 1 TO 21
        IF i = 21 THEN EXIT FOR
        IF muutujaSTRING(i, 1) = muutujanimi$ THEN EXIT FOR
        NEXT i
        IF i = 21 THEN
                FOR i = 1 TO 20
                IF i = 21 THEN EXIT FOR
                IF muutujaSTRING(i, 1) = "" THEN EXIT FOR
                NEXT i
                IF i = 21 THEN i = 1
        END IF
muutujaSTRING(i, 1) = muutujanimi$
muutujaSTRING(i, 2) = muutujavaartus$
muutujaSTRINGsub = ""
EXIT FUNCTION
END IF

IF kask$ = "otsi" THEN
        FOR i = 1 TO 21
        IF i = 21 THEN EXIT FOR
        IF muutujaSTRING(i, 1) = muutujanimi$ THEN EXIT FOR
        NEXT i
        IF i = 21 THEN muutujaSTRINGsub = ""
        IF i < 21 THEN muutujaSTRINGsub = muutujaSTRING(i, 2)
EXIT FUNCTION
END IF


END FUNCTION

SUB netscape (nimi$)

RANDOMIZE TIMER

'**************
'loadreklaam
OPEN "hwc\reklaam.hw2" FOR INPUT AS #1
DO
IF EOF(1) THEN EXIT DO
LINE INPUT #1, a$
IF INSTR(a$, "[") <> 0 THEN counter = counter + 1
LOOP
CLOSE #1

OPEN "hwc\reklaam.hw2" FOR INPUT AS #1
nr = INT(RND * counter) + 1
counter = 0
DO
IF EOF(1) THEN EXIT DO
LINE INPUT #1, a$
IF INSTR(a$, "[") <> 0 THEN counter = counter + 1
LOOP UNTIL nr = counter

FOR i = 1 TO 20
IF EOF(1) THEN EXIT FOR
LINE INPUT #1, a$
IF INSTR(a$, "[") <> 0 THEN
        FOR a = i TO 20
        reklaam(a) = ""
        NEXT a
        EXIT FOR
        END IF
        
reklaam(i) = a$
NEXT i


reklaaminumber = 0
CLOSE #1
'**************

'FOR i = 1 TO 20
'PRINT reklaam(i)
'NEXT i
'INPUT a
CLS


lata "netscaabakas1", 1, 1
historylisa "last", ""


END SUB

SUB netsearch (search$)
mousehide

FOR y = 8 TO 26
        FOR x = 2 TO 79
        LOCATE y, x
        PRINT " "
        link(x, y) = ""
        NEXT x
NEXT y

search$ = LCASE$(search$)
IF LEFT$(search$, 4) = "www." THEN search$ = "http://" + search$
IF LEFT$(search$, 4) = "http" THEN
        IF RIGHT$(search$, 1) <> "/" THEN search$ = search$ + "/"
        lata search$, 1, 1
        EXIT SUB
END IF


'IF LEFT$(search$, 4) = "www." THEN search$ = RIGHT$(search$, LEN(search$) - 4)
IF RIGHT$(search$, 4) = ".com" THEN search$ = LEFT$(search$, LEN(search$) - 4)
IF RIGHT$(search$, 3) = ".ee" THEN search$ = LEFT$(search$, LEN(search$) - 3)


OPEN "hwc\internet.hw2" FOR INPUT AS #1
DO
IF EOF(1) THEN EXIT DO
LINE INPUT #1, a$
'PRINT "line: "; a$: INPUT a
      IF (INSTR(a$, "[") <> 0 AND INSTR(a$, "]") <> 0) THEN latanimi$ = LEFT$(RIGHT$(a$, LEN(a$) - 1), LEN(a$) - 2)
      IF LEFT$(a$, 6) = "name: " THEN
         'PRINT "name: "; a$: INPUT a
         IF INSTR(RIGHT$(a$, LEN(a$) - 6), search$) <> 0 THEN GOTO leidsinlehe
      END IF
LOOP
latanimi$ = "http://not found/" + search$


leidsinlehe:


CLOSE #1

'lata "http://not found/", 1, 1
'historylisa "add", "http://not found/": EXIT SUB

lata latanimi$, 1, 1

mouseshow
END SUB

SUB newmail (nimi$)

PLAY "MB T200 L4 A P8 A P8 A"

m = 0

DO
m = m + 1
IF m > 10 THEN
        FOR m = 2 TO 10
        mail(m - 1, 1) = mail(m, 1)
        mail(m - 1, 2) = mail(m, 2)
        NEXT m
        mail(10, 1) = "NEW"
        mail(10, 2) = nimi$
        EXIT SUB
        END IF
LOOP UNTIL mail(m, 2) = ""
mail(m, 1) = "NEW"
mail(m, 2) = nimi$


END SUB

SUB pause (ticks AS INTEGER)
IF ticks < 1 THEN EXIT SUB
DEF SEG = &H40
AX = PEEK(&H6C)
FOR cx = 1 TO ticks
idle:
      
        dx = PEEK(&H6C)
        IF AX = dx THEN GOTO idle
        AX = dx
NEXT cx
'
END SUB

SUB savemission (fail$)


IF fail$ = "hwc\userinfo.tmp" THEN
OPEN fail$ FOR OUTPUT AS #5
        PRINT #5, "[gamename]"
        PRINT #5, LTRIM$(RTRIM$(user.gamename))
        PRINT #5, ""

        PRINT #5, "[user]"
        PRINT #5, "nimi "; LTRIM$(RTRIM$(user.nimi))
        PRINT #5, "missioninr"; user.missioninr
        IF punktid(1, 2) <> "" THEN PRINT #5, "punktid "; punktid(1, 2)
        IF punktid(1, 2) = "" THEN PRINT #5, "punktid 0"
        PRINT #5, ""

        PRINT #5, "[addressbook]"
           FOR i = 1 TO 20
           a$ = mailiaadress(i)
           IF a$ <> "" THEN PRINT #5, a$
           NEXT i
               
        PRINT #5, "[mailbox]"
           FOR i = 1 TO 10
           IF mail(i, 1) = "" THEN EXIT FOR
           IF mail(i, 1) <> "" THEN
                PRINT #5, LTRIM$(RTRIM$(mail(i, 1))) + " " + LTRIM$(RTRIM$(mail(i, 2)))
           END IF
           'IF mail(i, 1) = "" THEN EXIT FOR
           'IF i = 10 THEN EXIT FOR
           NEXT i
        PRINT #5, ""

        PRINT #5, "[muutujad]"
           FOR i = 21 TO 499 '1-20 missionid -neid ei muuda
           IF muutuja(i) <> 0 THEN
                'IF i < 10 THEN msg$ = "00" + LTRIM$(RTRIM$(STR$(i))) + " 1"
                'IF (i > 9 AND i < 100) THEN msg$ = "0" + LTRIM$(RTRIM$(STR$(i))) + " 1"
                'IF i > 99 THEN msg$ = LTRIM$(RTRIM$(STR$(i))) + " 1"
                'print ainult need, mille vÑÑrtus on 1
                IF i <> 99 THEN PRINT #5, LTRIM$(RTRIM$(STR$(i)))
                IF i = 99 THEN PRINT #5, "99": muutuja(99) = 1
           END IF
           NEXT i
        PRINT #5, ""
CLOSE #5
END IF

IF fail$ <> "hwc\userinfo.tmp" THEN
        OPEN "hwc\userinfo.tmp" FOR INPUT AS #5
        OPEN fail$ FOR OUTPUT AS #6
                a = 0
                DO
                 IF EOF(5) THEN EXIT DO
                 LINE INPUT #5, a$
                 PRINT #6, a$
                 IF a$ = "[gamename]" THEN LINE INPUT #5, a$: PRINT #6, LTRIM$(RTRIM$(user.gamename))
                LOOP
        CLOSE #6
        CLOSE #5
END IF


END SUB

SUB showmail (nimi$)

IF (nimi$ = "piknikult" AND user.missioninr <> 1) THEN
        email$ = ""
        g$ = "mission1 generateILM": mission1 "vanamission"
        nimi$ = "piknikult"
END IF

sesc = ""


mousehide
clearlinks
clearekraan

'teeb Newst Oldi
m = 0
DO
m = m + 1
IF m > 10 THEN EXIT DO
IF mail(m, 2) = nimi$ AND mail(m, 1) = "NEW" THEN mail(m, 1) = "OLD": EXIT DO
LOOP


LINE (25, 25)-(98, 55), 2, B
LINE (25, 25)-(98, 55), 2
LINE (25, 55)-(98, 25), 2
pause 10

LINE (24, 24)-(99, 56), 10, B

FOR i = 100 TO 550
        LINE (i, 40)-(i + 49, 40), 2
        i = i + 49
        pause 1
NEXT i

FOR i = 40 TO 400
        LINE (150, i)-(150, i + 39), 2
        LINE (600, i)-(600, i + 39), 2
        i = i + 39
        pause 1
NEXT i

FOR i = 0 TO 200
        LINE (i + 150, 440)-(i + 174, 440), 2
        LINE (576 - i, 440)-(600 - i, 440), 2
        i = i + 24
        pause 1
NEXT i

Mailalgus:
LOCATE 4, 23
COLOR 7
PRINT "From:"
LOCATE 5, 23
PRINT "To:"
LOCATE 7, 23
PRINT "Subject:"
                               
        COLOR 8
        LOCATE 26, 34
        PRINT "⁄ƒƒƒƒƒƒƒƒø⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒø⁄ƒƒƒƒƒƒø⁄ƒƒƒƒƒø"
        LOCATE 27, 34
        PRINT "≥Continue≥≥Run attachment≥≥Delete≥≥Close≥"
        LOCATE 28, 34
        PRINT "¿ƒƒƒƒƒƒƒƒŸ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ¿ƒƒƒƒƒƒŸ¿ƒƒƒƒƒŸ"





OPEN "hwc\mailid.hw2" FOR INPUT AS #6
DO
IF EOF(6) THEN EXIT DO
LINE INPUT #6, a$
LOOP UNTIL a$ = "[" + nimi$ + "]"

IF EOF(6) THEN GOTO notfound
        LINE INPUT #6, a$    '***FROM***
        COLOR 15
        LOCATE 4, 32
        PRINT RIGHT$(a$, LEN(a$) - 6)
       
        LOCATE 5, 32
        PRINT RTRIM$(user.nimi) + "@burburbur.com"
       
        LOCATE 7, 32
        PRINT nimi$
       
'LINE (155, 188)-(490, 227), 0, BF

   
       
        i = 10
        COLOR 15
          DO
        IF EOF(6) THEN EXIT DO
        LINE INPUT #6, a$
        IF LEFT$(a$, 1) = "[" THEN EXIT DO
        IF LEFT$(a$, 7) = "close: " THEN
                FOR x = 68 TO 74
                 FOR y = 26 TO 28
                 link(x, y) = RIGHT$(a$, LEN(a$) - 7)
                 NEXT y
                NEXT x
                      COLOR 2
                      LOCATE 26, 68
                      PRINT "⁄ƒƒƒƒƒø": LOCATE 27, 68
                      PRINT "≥Close≥": LOCATE 28, 68
                      PRINT "¿ƒƒƒƒƒŸ":
                      COLOR 15
                LINE INPUT #6, a$
                END IF
        IF LEFT$(a$, 8) = "delete: " THEN
                FOR x = 60 TO 67
                 FOR y = 26 TO 28
                 link(x, y) = RIGHT$(a$, LEN(a$) - 8)
                 NEXT y
                NEXT x
                      COLOR 2
                        LOCATE 26, 60: PRINT "⁄ƒƒƒƒƒƒø"
                        LOCATE 27, 60: PRINT "≥Delete≥"
                        LOCATE 28, 60: PRINT "¿ƒƒƒƒƒƒŸ"
                       COLOR 15
                LINE INPUT #6, a$
                END IF
        IF LEFT$(a$, 5) = "run: " THEN
                FOR x = 44 TO 59
                 FOR y = 26 TO 28
                 link(x, y) = RIGHT$(a$, LEN(a$) - 5)
                 NEXT y
                NEXT x
                      COLOR 12
                LOCATE 26, 44: PRINT "⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒø"
                LOCATE 27, 44: PRINT "≥Run attachment≥"
                LOCATE 28, 44: PRINT "¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ"
                       COLOR 15
                LINE INPUT #6, a$
                END IF
        

        IF LEFT$(a$, 10) = "continue: " THEN
                FOR x = 34 TO 43
                 FOR y = 26 TO 28
                 link(x, y) = RIGHT$(a$, LEN(a$) - 10)
                 NEXT y
                NEXT x
                      COLOR 2
                        LOCATE 26, 34: PRINT "⁄ƒƒƒƒƒƒƒƒø"
                        LOCATE 27, 34: PRINT "≥Continue≥"
                        LOCATE 28, 34: PRINT "¿ƒƒƒƒƒƒƒƒŸ"
                       COLOR 15
                LINE INPUT #6, a$
                END IF

      '  IF LEFT$(a$, 3) = "m: " THEN
      '          IF muutuja(VAL(RIGHT$(LEFT$(a$, 6), 3))) = VAL(RIGHT$(LEFT$(a$, 8), 1)) THEN
      '                  CLOSE #6
      '                  nimi$ = RIGHT$(a$, 9)
      '                  a$ = ""
      '                  GOTO Mailalgus
      '          ELSE
      '                  a$ = ""
      '          END IF
      '  END IF
       
        IF LEFT$(a$, 6) = "nr: 01" THEN GOTO MailNr01: EXIT DO


        LOCATE i, 23
        PRINT a$
        pause 2
        i = i + 1
       
       
        LOOP
GOTO notfound:

'*************************** MAIL NR 01 *************************
MailNr01:
       
       
        'COLOR 15
        'LOCATE 4, 32
        'PRINT "osvald@Ñss.ee"
        'LOCATE 5, 32
        'PRINT RTRIM$(user.nimi) + "@burburbur.com"
      
        'LOCATE 7, 32
        'PRINT nimi$
       
        i = 10
        COLOR 15
          DO
                a = INSTR(email$, CHR$(13))
                IF a <= 0 THEN EXIT DO
                a$ = LEFT$(email$, a)
                email$ = RIGHT$(email$, LEN(email$) - a)
                LOCATE i, 23
                PRINT a$
                pause 2
                i = i + 1
          LOOP
        GOTO notfound

'***************************************************************



notfound:



CLOSE #6
mouseshow

g$ = ""

END SUB

SUB showtabel (kask$)

CLS
'*************************** ARVUTAB TABELI ***********************
DIM ontabelis AS INTEGER

'tabel tÅhjaks
'FOR i% = 1 TO 10
'punktitabel(i%).nimi = "    -"
'punktitabel(i%).punktid = 0
'NEXT i%
'DEF SEG = VARSEG(punktitabel(1))
'BSAVE "hwc\tabel.hw2", VARPTR(punktitabel(1)), 131
'DEF SEG

' ****************************** LAADIB naaVANA TABELI **************
DEF SEG = VARSEG(punktitabel(1))
BLOAD "hwc\tabel.hw2", VARPTR(punktitabel(1))
DEF SEG

IF kask$ <> "uuenda" THEN GOTO lopptabel

FOR i% = 1 TO 10
 IF VAL(punktid(1, 2)) > punktitabel(i%).punktid THEN
        FOR j% = 10 TO i% + 1 STEP -1
         punktitabel(j%).punktid = punktitabel(j% - 1).punktid
         punktitabel(j%).nimi = punktitabel(j% - 1).nimi
        NEXT j%
        punktitabel(i%).nimi = user.nimi
        punktitabel(i%).punktid = VAL(punktid(1, 2))
        ontabelis = i%
        EXIT FOR
 END IF
NEXT i%


'**************************** SEIVIB UUE TABELI **********************
DEF SEG = VARSEG(punktitabel(1))
BSAVE "hwc\tabel.hw2", VARPTR(punktitabel(1)), 131
DEF SEG

'********* JOONISTAB TABELI **********
lopptabel:
LOCATE 8, 12
COLOR 12
PRINT "PUNKTITABEL"
LINE (230, 104)-(230, 384), 12
LINE (84, 130)-(560, 130), 12
LINE (220, 136)-(590, 136), 12
LINE (40, 348)-(440, 348), 12
LOCATE 23, 36
PRINT "Hackers World II"

FOR i% = 1 TO 10
COLOR 12
IF i% = ontabelis THEN COLOR 14
LOCATE i% + 9, 15
PRINT punktitabel(i%).nimi
LOCATE i% + 9, 32
PRINT punktitabel(i%).punktid; " bytes"
NEXT i%

DO
LOOP UNTIL INKEY$ <> ""

CLS
END SUB

SUB timenaitaja

'SUVALINE MAIL
IF maxaeg - INT(TIMER) = 500 OR maxaeg - INT(TIMER) = 350 OR maxaeg - INT(TIMER) = 200 THEN
   RANDOMIZE TIMER
   a% = RND * 50
   SLEEP 1
   IF a% = 1 THEN newmail "Vanaema synnip2ev!"
   IF a% = 2 THEN newmail "Uued pastakad!"
   IF a% = 3 THEN newmail "Suur probleem"
   IF a% = 4 THEN newmail "Palun abi"
   IF a% = 5 THEN newmail "Hea film"
   IF a% = 6 THEN newmail "Uus saatesari Zallmonid!"
   IF a% = 7 THEN newmail "Ilmajaama UUDISTE-list2"
   IF a% = 8 THEN newmail "Mingi jama!"
   IF a% = 9 THEN newmail "Riigieksami tulemused"
   IF a% = 10 THEN newmail "tantsukursused"
   IF a% = 11 THEN newmail "hinded"
   IF a% = 12 THEN newmail "edetabel"
   IF a% = 13 THEN newmail "khmm khmm"
   'IF a% < 14 THEN muutuja(210) = 1
   SLEEP 1
END IF



'usse jooksutav jupp

FOR nr = 1 TO 10
        IF ussid(nr).active = 1 THEN
                IF ussid(nr).suund = "U" THEN ussid(nr).y = ussid(nr).y - 1
                IF ussid(nr).suund = "D" THEN ussid(nr).y = ussid(nr).y + 1
                IF ussid(nr).suund = "R" THEN ussid(nr).x = ussid(nr).x + 1
                IF ussid(nr).suund = "L" THEN ussid(nr).x = ussid(nr).x - 1
        IF ussid(nr).x > 79 OR ussid(nr).x < 2 THEN ussid(nr).active = 0
        IF ussid(nr).y < 2 OR ussid(nr).y > 27 THEN ussid(nr).active = 0
      IF (ussid(nr).suund = "D" OR ussid(nr).suund = "U") THEN x1 = (ussid(nr).x * 8) - 4
      IF ussid(nr).suund = "R" THEN x1 = (ussid(nr).x) * 8 - 8
      IF ussid(nr).suund = "L" THEN x1 = (ussid(nr).x) * 8 - 1
      IF (ussid(nr).suund = "L" OR ussid(nr).suund = "R") THEN y1 = (ussid(nr).y) * 16 - 8
      IF ussid(nr).suund = "U" THEN y1 = (ussid(nr).y) * 16 - 1
      IF ussid(nr).suund = "D" THEN y1 = (ussid(nr).y) * 16 - 16
       y2 = (ussid(nr).y) * 16 - 8: x2 = ussid(nr).x * 8 - 4

      PSET (x1, y1), ussid(nr).c
      DO
        ussaeg = ussaeg + 1
        IF x1 < x2 THEN x1 = x1 + 1
        IF x1 > x2 THEN x1 = x1 - 1
        IF y1 < y2 THEN y1 = y1 + 1
        IF y1 > y2 THEN y1 = y1 - 1
        PSET (x1, y1), ussid(nr).c
         IF ussaeg > 45 THEN pause 1: ussaeg = 0
      LOOP UNTIL (x1 = x2 AND y1 = y2)

       
        IF LEFT$(ekraan(ussid(nr).x, ussid(nr).y), 9) = "œusskeera" THEN ussid(nr).suund = RIGHT$(ekraan(ussid(nr).x, ussid(nr).y), 1)
     
      IF (ussid(nr).suund = "D" OR ussid(nr).suund = "U") THEN x2 = (ussid(nr).x * 8) - 4
      IF ussid(nr).suund = "R" THEN x2 = (ussid(nr).x) * 8 - 1
      IF ussid(nr).suund = "L" THEN x2 = (ussid(nr).x) * 8 - 8
      IF ussid(nr).suund = "L" OR ussid(nr).suund = "R" THEN y2 = (ussid(nr).y) * 16 - 8
      IF ussid(nr).suund = "U" THEN y2 = (ussid(nr).y) * 16 - 16
      IF ussid(nr).suund = "D" THEN y2 = (ussid(nr).y) * 16 - 1
      
'LOCATE 20, 3
'PRINT nr, ussid(nr).x, ussid(nr).y, ussid(nr).suund, ussid(nr).active
'PRINT x1, y1, x2, y2
       
       
       
        DO
        ussaeg = ussaeg + 1
        IF x1 < x2 THEN x1 = x1 + 1
        IF x1 > x2 THEN x1 = x1 - 1
        IF y1 < y2 THEN y1 = y1 + 1
        IF y1 > y2 THEN y1 = y1 - 1
        PSET (x1, y1), ussid(nr).c
        IF ussaeg > 45 THEN pause 1: ussaeg = 0
        LOOP UNTIL (x1 = x2 AND y1 = y2)
     IF LEFT$(ekraan(ussid(nr).x, ussid(nr).y), 9) = "œusshyppa" THEN
               
                x1 = VAL(LEFT$(RIGHT$(ekraan(ussid(nr).x, ussid(nr).y), 5), 2))
                y1 = VAL(RIGHT$(ekraan(ussid(nr).x, ussid(nr).y), 2))
                ussid(nr).x = x1
                ussid(nr).y = y1
                END IF
     IF ekraan(ussid(nr).x, ussid(nr).y) = "œussend" THEN ussid(nr).active = 0
     IF LEFT$(ekraan(ussid(nr).x, ussid(nr).y), 9) = "œussalarm" THEN
                lata RIGHT$(ekraan(ussid(nr).x, ussid(nr).y), LEN(ekraan(ussid(nr).x, ussid(nr).y)) - 10), 1, 1
                END IF
        END IF
    
NEXT nr




IF timeaeg = INT(TIMER) THEN EXIT SUB
timeaeg = INT(TIMER)

FOR x = 1 TO 80
FOR y = 1 TO 30
 IF LEFT$(ekraan(x, y), 8) = "œclock: " THEN
        LOCATE x, y
        COLOR VAL(RIGHT$(ekraan(x, y), 2))
        PRINT TIME$

        END IF

 IF LEFT$(ekraan(x, y), 10) = "œReklaam: " THEN
        IF reklaamaeg + VAL(reklaam(1)) > INT(TIMER) THEN EXIT SUB
        reklaamaeg = INT(TIMER)
        IF reklaaminumber = 0 THEN reklaaminumber = 2
reklaamtagasi:
        reklaaminumber = reklaaminumber + 2
        IF reklaaminumber > 20 THEN reklaaminumber = 2: GOTO reklaamtagasi
        IF reklaam(reklaaminumber) = "" THEN reklaaminumber = 2: GOTO reklaamtagasi
       
         msg1$ = reklaam(reklaaminumber)
         msg2$ = reklaam(reklaaminumber - 1)

         COLOR VAL(reklaam(2))
         LOCATE 3, 35
         PRINT msg2$
         LOCATE 4, 35
         PRINT msg1$

         'cprint msg$, 35, 3, 15, 9, ""
        END IF
 

NEXT y

NEXT x










END SUB

SUB userinfo (fail$)

'PRINT "Loading USERINFO/SAVED GAME..."

IF fail$ = "" THEN fail$ = "hwc\start.hw2"

OPEN fail$ FOR INPUT AS #1

DO
IF EOF(1) THEN EXIT DO
LINE INPUT #1, a$

        IF a$ = "[gamename]" THEN
         IF EOF(1) THEN EXIT DO
         LINE INPUT #1, user.gamename
        END IF
       
        IF a$ = "[user]" THEN
          DO
          IF EOF(1) THEN EXIT DO
          LINE INPUT #1, a$
          IF LEFT$(a$, 5) = "nimi " THEN user.nimi = LTRIM$(RTRIM$(RIGHT$(a$, LEN(a$) - 5)))
          IF LEFT$(a$, 11) = "missioninr " THEN
                user.missioninr = VAL(LTRIM$(RTRIM$(RIGHT$(a$, LEN(a$) - 11))))
                'datafail = "hwc\mission" + LTRIM$(RTRIM$(RIGHT$(a$, LEN(a$) - 10))) + ".hw2"
           END IF
          IF LEFT$(a$, 8) = "punktid " THEN punktid(1, 2) = RIGHT$(a$, LEN(a$) - 8): punktid(1, 1) = "Eelmisest missioonist"
          LOOP UNTIL INSTR(a$, "[") > 0
        END IF
       
        IF a$ = "[addressbook]" THEN
                nr = 1
                DO
                IF EOF(1) THEN EXIT DO
                LINE INPUT #1, a$
                IF INSTR(a$, "[") > 0 THEN EXIT DO
                mailiaadress(nr) = a$
                nr = nr + 1
                LOOP
                END IF
       
       
       
        IF a$ = "[mailbox]" THEN
          i = 0
          DO
          IF EOF(1) THEN EXIT DO
          LINE INPUT #1, a$
          'IF ((LEFT$(a$, 4) = "OLD " OR LEFT$(a$, 4) = "NEW ") AND i = 10) THEN
          '  FOR i = 1 TO 9
          '  mail(i, 1) = mail(i + 1, 1)
          '  mail(i, 2) = mail(i + 1, 2)
          '  NEXT i
          '  i = 10
          'END IF
               IF LEFT$(a$, 4) = "OLD " THEN
                i = i + 1
                mail(i, 1) = "OLD"
                mail(i, 2) = LTRIM$(RTRIM$(RIGHT$(a$, LEN(a$) - 4)))
                     'see siin on VAJALIK selleks, et mission2-s ei tuleks "mission 1 completed"-emaili
                       IF (mail(i, 2) = "Piknikult" AND user.missioninr <> 1) THEN
                        mail(i, 2) = "piknikult"
                       END IF
                       IF (mail(i, 2) = "Jehaaa!!" AND user.missioninr <> 2) THEN
                        mail(i, 2) = "jehaaa!!"
                       END IF
                       IF (mail(i, 2) = "Lyhis6num mobiiltelefonilt3" AND user.missioninr <> 3) THEN
                        mail(i, 2) = "lyhis6num mobiiltelefonilt3"
                       END IF
                       IF (mail(i, 2) = "Ja uksed avanesid" AND user.missioninr <> 4) THEN
                        mail(i, 2) = "ja uksed avanesid"
                       END IF
                       IF (mail(i, 2) = "Tehnovaatus korras!" AND user.missioninr <> 5) THEN
                        mail(i, 2) = "tehnovaatus korras!"
                       END IF
                       IF (mail(i, 2) = "Sa oled mu ingel!" AND user.missioninr <> 6) THEN
                        mail(i, 2) = "sa oled mu ingel!"
                       END IF
                       IF (mail(i, 2) = "You're the WINNER!" AND user.missioninr <> 7) THEN
                        mail(i, 2) = "you're the winner!"
                       END IF
                       IF (mail(i, 2) = "Ei oleks uskunud" AND user.missioninr <> 8) THEN
                        mail(i, 2) = "ei oleks uskunud"
                       END IF


                END IF
               IF LEFT$(a$, 4) = "NEW " THEN
                i = i + 1
                mail(i, 1) = "NEW"
                mail(i, 2) = LTRIM$(RTRIM$(RIGHT$(a$, LEN(a$) - 4)))
               END IF
        LOOP UNTIL INSTR(a$, "[") <> 0
        END IF


        IF a$ = "[muutujad]" THEN
                DO
                IF EOF(1) THEN EXIT DO
                LINE INPUT #1, a$
                a = VAL(LTRIM$(RTRIM$(a$)))
                'b = VAL(RIGHT$(a$, 1))
                IF a > 0 THEN muutuja(a) = 1 'igax juhux peab a>0 (vÑltimaks erroreid)
                LOOP UNTIL INSTR(a$, "[") > 0
                'INPUT a
        END IF

LOOP

CLOSE #1
END SUB

SUB vordleinput (nimi$, YY, x1, x2, varv)


inputrida Miskirjutab$, YY, x1, x2, varv, ""

Miskirjutab$ = LCASE$(Miskirjutab$)
filenr = FREEFILE

OPEN "hwc\input.hw2" FOR INPUT AS filenr
        DO
         IF EOF(filenr) THEN EXIT DO
         LINE INPUT #filenr, rida$
           IF rida$ = "[" + nimi$ + "]" THEN
                DO
                 IF EOF(filenr) THEN EXIT DO
                 LINE INPUT #filenr, rida$
                 IF LEFT$(rida$, 1) = "[" THEN EXIT DO
                 IF LEFT$(rida$, 6) = "text: " THEN
                  IF INSTR(Miskirjutab$, RIGHT$(rida$, LEN(rida$) - 6)) <> 0 THEN
                        LINE INPUT #filenr, rida$
                        IF LEFT$(rida$, 6) = "lata: " THEN
                                CLOSE filenr
                                lata RIGHT$(rida$, LEN(rida$) - 6), 1, 1
                                EXIT SUB
                        END IF
                  END IF
                 END IF
                
                 IF LEFT$(rida$, 12) = "playernimi: " THEN
                  playernimi$ = LCASE$(LTRIM$(RTRIM$(user.nimi)))
                  IF INSTR(Miskirjutab$, playernimi$) <> 0 THEN
                        CLOSE filenr
                        lata RIGHT$(rida$, LEN(rida$) - 12), 1, 1
                        EXIT SUB
                  END IF
                 END IF
                
                 IF LEFT$(rida$, 6) = "else: " THEN
                        CLOSE filenr
                        lata RIGHT$(rida$, LEN(rida$) - 6), 1, 1
                        EXIT SUB
                 END IF
                LOOP UNTIL INSTR(rida1$, "[") <> 0
           END IF
        LOOP
CLOSE filenr

END SUB

