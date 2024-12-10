DECLARE SUB pause (ticks AS INTEGER)
DECLARE SUB checkpassword ()
DECLARE SUB showtabel ()
CONST Etyhi = 224, Etoss1 = 225, Etoss2 = 226, Etoss3 = 227
CONST Kast1pilt = 101, Kast2pilt = 102


'Efekt <tÅhi> - 224
'Efekt <toss1> - 225
'Efekt <toss2> - 226
'Efekt <toss3> - 227
'Kast1 - 101
'Kast2 - 102


DECLARE SUB leiakaugused ()

DECLARE SUB loaduser ()
DECLARE SUB loadlevel ()
DECLARE SUB varistamine ()
DECLARE SUB kollisurm (kollinr!, pohjus!)
DECLARE FUNCTION leiavabasuund (x%, y%, suund%, tarkus%)
DECLARE SUB loobkasti ()
DECLARE SUB astu (x%, y%, suund%, kaader%, nimi$)
DECLARE SUB loadtegelased ()
DECLARE SUB sammuke (suund!)
DIM SHARED plats(0 TO 23, 0 TO 13) AS INTEGER'plats - 50,30-269,149
'DIM SHARED plats(1 TO 22, 1 TO 12) AS INTEGER
DIM SHARED varin AS INTEGER
DIM SHARED level AS INTEGER

DIM SHARED skoor AS INTEGER
DIM SHARED algusaeg AS LONG

TYPE tabelis
        nimi AS STRING * 10
        punktid AS INTEGER
END TYPE
DIM SHARED tabel(12) AS tabelis
DIM SHARED arvutikiirus AS INTEGER


TYPE tegelane
      nimi AS STRING * 10
      x AS INTEGER
      y AS INTEGER
      nagu AS INTEGER
      suund AS INTEGER
      kinni AS INTEGER
      tarkus AS INTEGER ' 1 - idioot, 10 - hoike alt! (v‰imatu)
      uimane AS INTEGER
END TYPE

DIM SHARED kollid(100) AS tegelane
DIM SHARED ise AS tegelane

TYPE kasutaja
        nimi AS STRING * 10
        maxlevel AS INTEGER
END TYPE

DIM SHARED user AS kasutaja

DIM SHARED kaader AS INTEGER


DIM SHARED ise21(1 TO 100) AS INTEGER
DIM SHARED ise41(1 TO 100) AS INTEGER
DIM SHARED ise61(1 TO 100) AS INTEGER
DIM SHARED ise81(1 TO 100) AS INTEGER

DIM SHARED ise22(1 TO 100) AS INTEGER
DIM SHARED ise42(1 TO 100) AS INTEGER
DIM SHARED ise62(1 TO 100) AS INTEGER
DIM SHARED ise82(1 TO 100) AS INTEGER

DIM SHARED isel4(1 TO 100) AS INTEGER
DIM SHARED isel6(1 TO 100) AS INTEGER

DIM SHARED koll121(1 TO 100) AS INTEGER
DIM SHARED koll141(1 TO 100) AS INTEGER
DIM SHARED koll161(1 TO 100) AS INTEGER
DIM SHARED koll181(1 TO 100) AS INTEGER
DIM SHARED koll1kaob1(1 TO 100) AS INTEGER
DIM SHARED koll1kaob2(1 TO 100) AS INTEGER
DIM SHARED koll1kaob3(1 TO 100) AS INTEGER
DIM SHARED koll1uimane1(1 TO 100) AS INTEGER
DIM SHARED koll1uimane2(1 TO 100) AS INTEGER

DIM SHARED koll221(1 TO 100) AS INTEGER
DIM SHARED koll241(1 TO 100) AS INTEGER
DIM SHARED koll261(1 TO 100) AS INTEGER
DIM SHARED koll281(1 TO 100) AS INTEGER
DIM SHARED koll2kaob1(1 TO 100) AS INTEGER
DIM SHARED koll2kaob2(1 TO 100) AS INTEGER
DIM SHARED koll2kaob3(1 TO 100) AS INTEGER
DIM SHARED koll2uimane1(1 TO 100) AS INTEGER
DIM SHARED koll2uimane2(1 TO 100) AS INTEGER

DIM SHARED koll321(1 TO 100) AS INTEGER
DIM SHARED koll341(1 TO 100) AS INTEGER
DIM SHARED koll361(1 TO 100) AS INTEGER
DIM SHARED koll381(1 TO 100) AS INTEGER
DIM SHARED koll3kaob1(1 TO 100) AS INTEGER
DIM SHARED koll3kaob2(1 TO 100) AS INTEGER
DIM SHARED koll3kaob3(1 TO 100) AS INTEGER
DIM SHARED koll3uimane1(1 TO 100) AS INTEGER
DIM SHARED koll3uimane2(1 TO 100) AS INTEGER

DIM SHARED koll421(1 TO 100) AS INTEGER
DIM SHARED koll441(1 TO 100) AS INTEGER
DIM SHARED koll461(1 TO 100) AS INTEGER
DIM SHARED koll481(1 TO 100) AS INTEGER
DIM SHARED koll4kaob1(1 TO 100) AS INTEGER
DIM SHARED koll4kaob2(1 TO 100) AS INTEGER
DIM SHARED koll4kaob3(1 TO 100) AS INTEGER
DIM SHARED koll4uimane1(1 TO 100) AS INTEGER
DIM SHARED koll4uimane2(1 TO 100) AS INTEGER

DIM SHARED koll521(1 TO 100) AS INTEGER
DIM SHARED koll541(1 TO 100) AS INTEGER
DIM SHARED koll561(1 TO 100) AS INTEGER
DIM SHARED koll581(1 TO 100) AS INTEGER
DIM SHARED koll5kaob1(1 TO 100) AS INTEGER
DIM SHARED koll5kaob2(1 TO 100) AS INTEGER
DIM SHARED koll5kaob3(1 TO 100) AS INTEGER
DIM SHARED koll5uimane1(1 TO 100) AS INTEGER
DIM SHARED koll5uimane2(1 TO 100) AS INTEGER


DIM SHARED koll621(1 TO 100) AS INTEGER
DIM SHARED koll641(1 TO 100) AS INTEGER
DIM SHARED koll661(1 TO 100) AS INTEGER
DIM SHARED koll681(1 TO 100) AS INTEGER
DIM SHARED koll6kaob1(1 TO 100) AS INTEGER
DIM SHARED koll6kaob2(1 TO 100) AS INTEGER
DIM SHARED koll6kaob3(1 TO 100) AS INTEGER
DIM SHARED koll6uimane1(1 TO 100) AS INTEGER
DIM SHARED koll6uimane2(1 TO 100) AS INTEGER




DIM SHARED Kast1(1 TO 100) AS INTEGER
DIM SHARED Kast2(1 TO 100) AS INTEGER

DIM SHARED toss3(1 TO 100) AS INTEGER
DIM SHARED toss2(1 TO 100) AS INTEGER
DIM SHARED toss1(1 TO 100) AS INTEGER


DIM SHARED kollidearv AS INTEGER

checkpassword

SCREEN 13


'vÑrvide defineerimine
 'mustast valgeni 20-29
FOR varv = 0 TO 9
        OUT &H3C8, varv + 20
        OUT &H3C9, varv * 7
        OUT &H3C9, varv * 7
        OUT &H3C9, varv * 7
NEXT varv
 'mustast punaseni
FOR varv = 0 TO 9
        OUT &H3C8, varv + 30
        OUT &H3C9, varv * 7
        OUT &H3C9, varv * 2
        OUT &H3C9, varv * 1
NEXT varv

 'mustast roheiseni
FOR varv = 0 TO 9
        OUT &H3C8, varv + 40
        OUT &H3C9, varv * 2
        OUT &H3C9, varv * 5
        OUT &H3C9, varv * 2
NEXT varv
 'ja siniseni
FOR varv = 0 TO 9
        OUT &H3C8, varv + 50
        OUT &H3C9, varv * 2
        OUT &H3C9, varv * 3
        OUT &H3C9, varv * 6
NEXT varv

GOTO algus


'FOR varv = 0 TO 100
'LINE (varv * 2, 3)-(varv * 2 + 1, 4), varv, BF
'NEXT varv
'SLEEP 6
'********************************** ISE ****************************
'alla
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0
DATA  0,23,24,26,26,26,26,24,23, 0
DATA 23,25,26,26,29,26,29,26,25,23
DATA 25,26,26,26,20,26,20,26,26,25
DATA 25,26,24,26,26,26,26,26,26,25
DATA 23,25,26,23,23,23,23,23,25,23
DATA  0,23,25,26,26,26,26,26,24, 0
DATA  0, 0, 4, 0, 0, 4, 4, 4, 0, 0
DATA  0, 4, 4, 4, 0, 0, 0, 0, 0, 0
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0

'vasakule
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0
DATA  0, 0,23,25,26,26,26,24,23, 0
DATA  0, 0,26,28,26,26,26,26,25, 0
DATA  0, 0,26,20,26,26,26,26,26, 0
DATA  0, 0,26,26,26,26,24,26,26, 0
DATA  0, 0,22,23,23,23,26,26,25, 0
DATA  0, 0,23,25,26,26,26,25,24, 0
DATA  0, 0, 4, 4, 4, 0, 0, 4, 0, 0
DATA  0, 0, 0, 0, 0, 0, 4, 4, 4, 0
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0


'paremale
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0
DATA  0,23,24,26,26,26,25,23, 0, 0
DATA  0,25,26,26,26,26,28,26, 0, 0
DATA  0,26,26,26,26,26,20,26, 0, 0
DATA  0,26,26,24,26,26,26,26, 0, 0
DATA  0,25,26,26,23,23,23,22, 0, 0
DATA  0,24,25,26,26,26,25,23, 0, 0
DATA  0, 0, 4, 0, 0, 4, 4, 4, 0, 0
DATA  0, 4, 4, 4, 0, 0, 0, 0, 0, 0
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0


'yles
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0
DATA  0,23,24,26,26,26,26,24,23, 0
DATA 23,25,26,26,26,26,26,26,25,23
DATA 25,26,26,26,26,26,26,26,26,25
DATA 25,26,26,26,26,26,26,26,26,25
DATA 23,25,26,26,26,26,26,26,25,23
DATA  0,23,25,26,26,26,26,26,24, 0
DATA  0, 0, 4, 0, 0, 4, 4, 4, 0, 0
DATA  0, 4, 4, 4, 0, 0, 0, 0, 0, 0
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0



'********************************** KOLL1 ****************************
'alla
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0
DATA  0,33,36,36,36,36,36,36,33, 0
DATA 35,38,39,00,39,39,00,39,38,35
DATA 36,38,39,39,39,39,39,39,38,36
DATA 36,38,27,34,28,00,28,36,38,36
DATA 36,38,33,00,00,00,00,33,38,36
DATA 36,38,36,28,00,28,00,37,38,36
DATA  0,33,36,36,36,36,36,36,33, 0
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0

'vasakule
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0
DATA  0, 0,33,36,36,36,36,33, 0, 0
DATA  0,35,36,35,00,39,39,38,35, 0
DATA  0,37,38,39,39,39,39,38,36, 0
DATA  0,00,29,00,29,00,33,38,36, 0
DATA  0,00,00,27,00,27,00,38,36, 0
DATA  0,36,39,39,39,39,39,38,36, 0
DATA  0, 0,33,36,36,36,36,33, 0, 0
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0


'paremale
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0
DATA  0, 0,33,36,36,36,36,33, 0, 0
DATA  0,35,38,39,39,00,35,36,35, 0
DATA  0,36,38,39,39,39,39,38,37, 0
DATA  0,36,38,33,00,29,00,29,00, 0
DATA  0,36,38,00,27,00,27,00,00, 0
DATA  0,36,38,39,39,39,39,39,36, 0
DATA  0, 0,33,36,36,36,36,33, 0, 0
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0


'yles
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0
DATA  0,33,36,36,36,36,36,36,33, 0
DATA 35,38,39,39,39,39,39,39,38,35
DATA 36,38,39,39,39,39,39,39,38,36
DATA 36,38,39,39,39,39,39,39,38,36
DATA 36,38,39,39,39,39,39,39,38,36
DATA 36,38,39,39,39,39,39,39,38,36
DATA  0,33,36,36,36,36,36,36,33, 0
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0

'******************KAST 2≤********************
DATA  22,23,23,23,23,23,23,23,23,22
DATA  23,24,24,24,24,24,24,24,24,23
DATA  23,24,24,24,24,24,24,24,24,23
DATA  23,24,24,24,24,24,24,24,24,23
DATA  23,24,24,24,24,24,24,24,24,23
DATA  23,24,24,24,24,24,24,24,24,23
DATA  23,24,24,24,24,24,24,24,24,23
DATA  23,24,24,24,24,24,24,24,24,23
DATA  23,24,24,24,24,24,24,24,24,23
DATA  22,23,23,23,23,23,23,23,23,22

'******************KAST 1€********************
DATA  24,25,25,25,25,25,25,25,25,24
DATA  25,26,26,26,26,26,26,26,26,25
DATA  25,26,26,26,26,26,26,26,26,25
DATA  25,26,26,26,26,26,26,26,26,25
DATA  25,26,26,26,26,26,26,26,26,25
DATA  25,26,26,26,26,26,26,26,26,25
DATA  25,26,26,26,26,26,26,26,26,25
DATA  25,26,26,26,26,26,26,26,26,25
DATA  25,26,26,26,26,26,26,26,26,25
DATA  24,25,25,25,25,25,25,25,25,24

'******************TOSS 3********************
DATA  00,00,00,21,00,00,00,00,00,00
DATA  00,00,23,00,23,00,21,22,00,00
DATA  00,00,00,23,25,00,00,21,00,00
DATA  00,22,26,25,22,23,25,00,00,00
DATA  00,23,21,23,24,26,25,24,23,00
DATA  00,21,26,24,22,23,25,00,21,00
DATA  21,23,23,25,24,24,23,22,22,00
DATA  00,00,24,22,24,00,25,26,00,00
DATA  00,00,00,23,25,00,00,00,23,00
DATA  00,00,00,00,00,00,00,00,00,00

'******************TOSS 2********************
DATA  00,00,00,00,00,00,00,00,00,00
DATA  00,00,23,23,00,00,21,00,00,00
DATA  00,00,24,00,24,00,24,00,00,00
DATA  00,00,26,24,23,21,25,21,00,00
DATA  00,25,24,23,00,23,24,24,23,00
DATA  00,00,25,23,22,22,26,26,24,21
DATA  00,22,00,24,23,24,00,25,24,00
DATA  00,26,00,00,21,24,00,21,00,00
DATA  00,00,22,00,24,22,00,00,00,00
DATA  00,00,00,00,00,00,00,00,00,00


'******************TOSS 1********************
DATA  00,00,00,00,00,00,00,00,00,00
DATA 0, 0, 21, 21, 0, 0, 0, 0, 0, 0
DATA  00,00,22,00,22,00,22,00,00,00
DATA  00,00,23,26,21,00,21,00,00,00
DATA  00,22,21,21,00,25,22,21,21,00
DATA  00,00,23,22,25,22,21,21,00,00
DATA  00,22,00,21,21,22,00,21,21,00
DATA  00,00,00,00,21,21,00,21,00,00
DATA  00,00,00,00,21,21,00,00,00,00
DATA  00,00,00,00,00,00,00,00,00,00



'****************KOLL1 kaob Ñra1*************
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0
DATA  0, 0, 0,33,33,33,33, 0, 0, 0
DATA  0, 0,33,36,36,36,36,33, 0, 0
DATA  0,35,38,39,39,39,39,38,35, 0
DATA  0,36,38,39,39,39,39,39,36, 0
DATA  0,36,38,39,39,39,39,39,36, 0
DATA  0,36,38,39,39,39,39,39,36, 0
DATA  0,0, 33,36,36,36,36,33, 0, 0
DATA  0, 0, 0,33,33,33,33, 0, 0, 0
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0

'****************KOLL1 kaob Ñra2*************
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0
DATA  0, 0, 0,33,33,33,33, 0, 0, 0
DATA  0, 0,32,35,36,36,35,32, 0, 0
DATA  0,32,34,36,36,36,36,34,32, 0
DATA  0,32,34,36,36,36,36,34,32, 0
DATA  0, 0,32,35,36,36,35,32, 0, 0
DATA  0, 0, 0,33,33,33,33, 0, 0, 0
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0

'****************KOLL1 kaob Ñra3*************
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0
DATA  0, 0, 0,32,33,33,32,32, 0, 0
DATA  0, 0,31,33,34,34,33,33,31, 0
DATA  0, 0,31,33,34,34,33,33,31, 0
DATA  0, 0, 0,32,33,33,32,32, 0, 0
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0



'********************************** ISE 2 ****************************
'alla
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0
DATA  0,23,24,26,26,26,26,24,23, 0
DATA 23,25,26,26,29,26,29,26,25,23
DATA 25,26,26,26,20,26,20,26,26,25
DATA 25,26,24,26,26,26,26,26,26,25
DATA 23,25,26,23,23,23,23,23,25,23
DATA  0,23,25,26,26,26,26,26,24, 0
DATA  0, 0, 4, 4, 4, 0, 0, 4, 0, 0
DATA  0, 0, 0, 0, 0, 0, 4, 4, 4, 0
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0

'vasakule
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0
DATA  0, 0,23,25,26,26,26,24,23, 0
DATA  0, 0,26,28,26,26,26,26,25, 0
DATA  0, 0,26,20,26,26,26,26,26, 0
DATA  0, 0,26,26,26,26,24,26,26, 0
DATA  0, 0,22,23,23,23,26,26,25, 0
DATA  0, 0,23,25,26,26,26,25,24, 0
DATA  0, 0, 0, 4, 0, 0, 4, 4, 4, 0
DATA  0, 0, 4, 4, 4, 0, 0, 0, 0, 0
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0


'paremale
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0
DATA  0,23,24,26,26,26,25,23, 0, 0
DATA  0,25,26,26,26,26,28,26, 0, 0
DATA  0,26,26,26,26,26,20,26, 0, 0
DATA  0,26,26,24,26,26,26,26, 0, 0
DATA  0,25,26,26,23,23,23,22, 0, 0
DATA  0,24,25,26,26,26,25,23, 0, 0
DATA  0, 4, 4, 4, 0, 0, 4, 0, 0, 0
DATA  0, 0, 0, 0, 0, 4, 4, 4, 0, 0
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0


'yles
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0
DATA  0,23,24,26,26,26,26,24,23, 0
DATA 23,25,26,26,26,26,26,26,25,23
DATA 25,26,26,26,26,26,26,26,26,25
DATA 25,26,26,26,26,26,26,26,26,25
DATA 23,25,26,26,26,26,26,26,25,23
DATA  0,23,25,26,26,26,26,26,24, 0
DATA  0, 0, 4, 4, 4, 0, 0, 4, 0, 0
DATA  0, 0, 0, 0, 0, 0, 4, 4, 4, 0
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0

'******************ISE LôôB****************

'vasakule
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0
DATA  0, 0,23,25,26,26,26,24,23, 0
DATA  0, 0,26,28,26,26,26,26,25, 0
DATA  4, 0,26,20,26,26,26,26,26, 0
DATA  4, 4,26,26,26,26,24,26,26, 0
DATA  4, 0,22,23,23,23,26,26,25, 0
DATA  0, 0,23,25,26,26,26,25,24, 0
DATA  0, 0, 0, 0, 0, 0, 0, 4, 0, 0
DATA  0, 0, 0, 0, 0, 0, 4, 4, 4, 0
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0


'paremale
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0
DATA  0,23,24,26,26,26,25,23, 0, 0
DATA  0,25,26,26,26,26,28,26, 0, 0
DATA  0,26,26,26,26,26,20,26, 0, 4
DATA  0,26,26,24,26,26,26,26, 4, 4
DATA  0,25,26,26,23,23,23,22, 0, 4
DATA  0,24,25,26,26,26,25,23, 0, 0
DATA  0, 0, 4, 0, 0, 0, 0, 0, 0, 0
DATA  0, 4, 4, 4, 0, 0, 0, 0, 0, 0
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0

'**************************** KOLL1 UIMANE1 ***********
DATA  0, 0,25,24,23, 0, 0,29, 0, 0
DATA  0,27, 0, 0, 0, 0, 0, 0,28, 0
DATA  0,23,29, 0, 0, 23,25,26,0, 0
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0
DATA  0,33,36,36,36,36,36,36,33, 0
DATA 35,39,39,39,39,39,39,39,38,35
DATA 36,38,37,36,39,39,36,37,38,36
DATA 37,38,39,38,38,38,38,39,38,36
DATA 33,33,26,34,33,34,34,26,34,33
DATA  0,00,00,00,00,00,00,00,00, 0

'**************************** KOLL1 UIMANE2 ***********
DATA  0, 0,28,26,25,23,21,00, 0, 0
DATA  0,27,00, 0, 0, 0, 0,27, 0, 0
DATA  0,00,21,23,25,26,28, 0, 0, 0
DATA  0, 0, 0, 0, 0, 0, 0, 0, 0, 0
DATA  0,33,36,36,36,36,36,36,33, 0
DATA 35,39,39,39,39,39,39,39,38,35
DATA 36,38,37,36,39,39,36,37,38,36
DATA 37,38,39,38,38,38,38,39,38,36
DATA 33,33,26,34,33,34,34,26,34,33
DATA  0,00,00,00,00,00,00,00,00, 0





FOR kord = 1 TO 24
FOR y = 1 TO 10
FOR x = 1 TO 10
        READ a
        PSET (x, y), a
NEXT x
NEXT y
IF kord = 1 THEN GET (1, 1)-(10, 10), ise21
IF kord = 2 THEN GET (1, 1)-(10, 10), ise41
IF kord = 3 THEN GET (1, 1)-(10, 10), ise61
IF kord = 4 THEN GET (1, 1)-(10, 10), ise81

IF kord = 5 THEN GET (1, 1)-(10, 10), koll121
IF kord = 6 THEN GET (1, 1)-(10, 10), koll141
IF kord = 7 THEN GET (1, 1)-(10, 10), koll161
IF kord = 8 THEN GET (1, 1)-(10, 10), koll181

IF kord = 9 THEN GET (1, 1)-(10, 10), Kast2
IF kord = 10 THEN GET (1, 1)-(10, 10), Kast1

IF kord = 11 THEN GET (1, 1)-(10, 10), toss3
IF kord = 12 THEN GET (1, 1)-(10, 10), toss2
IF kord = 13 THEN GET (1, 1)-(10, 10), toss1

IF kord = 14 THEN GET (1, 1)-(10, 10), koll1kaob1
IF kord = 15 THEN GET (1, 1)-(10, 10), koll1kaob2
IF kord = 16 THEN GET (1, 1)-(10, 10), koll1kaob3

IF kord = 17 THEN GET (1, 1)-(10, 10), ise22
IF kord = 18 THEN GET (1, 1)-(10, 10), ise42
IF kord = 19 THEN GET (1, 1)-(10, 10), ise62
IF kord = 20 THEN GET (1, 1)-(10, 10), ise82

IF kord = 21 THEN GET (1, 1)-(10, 10), isel4
IF kord = 22 THEN GET (1, 1)-(10, 10), isel6

IF kord = 23 THEN GET (1, 1)-(10, 10), koll1uimane1
IF kord = 24 THEN GET (1, 1)-(10, 10), koll1uimane2

NEXT kord




'PUT (1, 1), koll1uimane1, PSET
'PUT (15, 1), kol11uimane2, PSET
'PUT (30, 1), kol11kaob2, PSET
'PUT (45, 1), koll1kaob3, PSET


RANDOMIZE TIMER

'ON ERROR GOTO errorline




'FOR k = 1 TO 101
'        x = INT(RND * 22 + 1)
'        y = INT(RND * 12 + 1)
'        IF k < 10 THEN plats(x, y) = "€"
'        IF (k > 9 AND k < 101) THEN plats(x, y) = "≤"
'        IF k = 101 THEN plats(x, y) = "A": ise.x = x: ise.y = y: ise.nagu = 2: ise.suund = 0: plats(ise.x, ise.y) = 0
'NEXT k

'plats(2, 1) = "≤"
'plats(1, 2) = "≤"
'        kollid(1).x = 1
'        kollid(1).y = 1
'        plats(1, 1) = ""
'        kollid(1).nagu = 2
'        kollid(1).suund = 0
'        kollid(1).tarkus = 1
'        kollid(1).nimi = "koll1"
'



'kollidearv = 5
'FOR k = 2 TO kollidearv
'        x = INT(RND * 22 + 1)
'        y = INT(RND * 12 + 1)
'
'        kollid(k).nimi = "koll1"
'         kollid(k).x = x
'        kollid(k).y = y
'        plats(x, y) = ""
'        kollid(k).nagu = 2
'        kollid(k).suund = 0
'        'kollid(k).kasonvoieiole = 1
'        kollid(k).tarkus = 2
'NEXT k

SCREEN 13

algus:
loadtegelased
peakstootama:
loaduser







'*********************************************************************
'ja mÑng ise
DO


 'kollide suuna mÑÑramine
        
       
        FOR i = 1 TO kollidearv
        IF kollid(i).uimane > 0 THEN kollid(i).uimane = kollid(i).uimane - 1
        IF kollid(i).nagu <> 0 THEN
          a% = kollid(i).x
          B% = kollid(i).y
          c% = kollid(i).suund
          D% = kollid(i).tarkus
         
         
          IF kollid(i).kinni < 10 AND kollid(i).uimane < 1 THEN kollid(i).suund = leiavabasuund(a%, B%, c%, D%)
          
                'kui koll on vangis
          IF kollid(i).suund <> 5 THEN kollid(i).kinni = 0
          IF kollid(i).suund = 5 THEN kollid(i).kinni = kollid(i).kinni + 1
          
                

        END IF
        NEXT i


 FOR x = 1 TO 22
  FOR y = 1 TO 12
   'kui on efekt olemas
    IF plats(x, y) = Etyhi THEN
        plats(x, y) = 0
         LINE (40 + x * 10, 20 + y * 10)-(49 + x * 10, 29 + y * 10), 0, BF
        END IF
    IF plats(x, y) = Etoss1 THEN
        plats(x, y) = Etyhi
         PUT (40 + x * 10, 20 + y * 10), toss1, PSET
        END IF
    IF plats(x, y) = Etoss2 THEN
        plats(x, y) = Etoss1
         PUT (40 + x * 10, 20 + y * 10), toss2, PSET
        END IF
    IF plats(x, y) = Etoss3 THEN
        plats(x, y) = Etoss2
         PUT (40 + x * 10, 20 + y * 10), toss3, PSET
        END IF
  
   'END IF
  NEXT y
 NEXT x

        



 FOR kaader = 1 TO 10'<--------kaadrid
        'ootab Åhe clock-ticki
        FOR aaa% = 1 TO arvutikiirus
        DO
        LOOP UNTIL (INP(&H3DA) AND 8)
        NEXT aaa%
       
        IF ise.suund <> 0 THEN
              

               
               astu ise.x, ise.y, ise.suund, kaader, "ise"
               IF kaader = 10 THEN
                        IF ise.suund = 2 THEN ise.y = ise.y + 1
                        IF ise.suund = 4 THEN ise.x = ise.x - 1
                        IF ise.suund = 6 THEN ise.x = ise.x + 1
                        IF ise.suund = 8 THEN ise.y = ise.y - 1
                ise.suund = 0
                END IF
        END IF
       
        IF ise.suund = 0 THEN
               IF ise.nagu = 2 THEN PUT (40 + ise.x * 10, 20 + ise.y * 10), ise21, PSET
               IF ise.nagu = 4 THEN PUT (40 + ise.x * 10, 20 + ise.y * 10), ise41, PSET
               IF ise.nagu = 6 THEN PUT (40 + ise.x * 10, 20 + ise.y * 10), ise61, PSET
               IF ise.nagu = 8 THEN PUT (40 + ise.x * 10, 20 + ise.y * 10), ise81, PSET
        END IF

        LOCATE 1, 1
        FOR i = 1 TO kollidearv
                
     IF kollid(i).nagu <> 0 THEN
               s = kollid(i).suund
               'liikuv koll
               IF s = 2 OR s = 4 OR s = 6 OR s = 8 THEN astu kollid(i).x, kollid(i).y, kollid(i).suund, kaader, RTRIM$(kollid(i).nimi)
               
               'uimane koll
               IF s = 0 AND kollid(i).uimane > 1 THEN astu kollid(i).x, kollid(i).y, 20, kaader, RTRIM$(kollid(i).nimi)

               'vangistatud koll
                IF kollid(i).kinni > 19 AND kollid(i).kinni < 26 THEN
                         astu kollid(i).x, kollid(i).y, 30 + kollid(i).kinni, kaader, RTRIM$(kollid(i).nimi)
                        END IF
                IF kollid(i).kinni = 26 THEN
                        kollid(i).kinni = 0
                        END IF

                IF kaader = 10 THEN
                        IF kollid(i).suund = 2 THEN kollid(i).y = kollid(i).y + 1
                        IF kollid(i).suund = 4 THEN kollid(i).x = kollid(i).x - 1
                        IF kollid(i).suund = 6 THEN kollid(i).x = kollid(i).x + 1
                        IF kollid(i).suund = 8 THEN kollid(i).y = kollid(i).y - 1

                END IF
       ' IF kollid(i).suund = 0 AND kollid(i).uimane < 2 THEN PUT (40 + kollid(i).x * 10, 20 + kollid(i).y * 10), koll121, PSET
       ' IF kollid(i).suund = 5 AND kollid(i).kinni < 2 THEN PUT (40 + kollid(i).x * 10, 20 + kollid(i).y * 10), koll121, PSET
        'PRINT "x: "; kollid(i).x; " y: "; kollid(i).y; " suund: "; kollid(i).suund
       END IF
      NEXT i

        'seina vÑristamine
         varistamine

        'skoori lisamine
        IF naidatudskoor < skoor THEN
                FOR i = 400 TO 450 STEP 3
                SOUND i, .05
                NEXT i
                
                 DO
                 IF naidatudskoor + 100 < skoor THEN naidatudskoor = naidatudskoor + 105
                 LOOP UNTIL naidatudskoor + 110 > skoor
                

                 DO
                 IF naidatudskoor + 30 < skoor THEN naidatudskoor = naidatudskoor + 35
                 'PRINT naidatudskoor, skoor
                 'SLEEP 1
                 LOOP UNTIL naidatudskoor + 40 > skoor
               
                naidatudskoor = naidatudskoor + 5
                COLOR 25
                LOCATE 21, 7
                PRINT USING "##### $"; naidatudskoor
                END IF


 NEXT kaader

'joonistamised, mis enne olid m‰ttetud
                COLOR 25
                IF (TIMER - algusaeg) > 60 THEN COLOR 26
                IF (TIMER - algusaeg) > 90 THEN COLOR 27
                LOCATE 21, 28
                PRINT USING "#### s"; 120 - INT(TIMER - algusaeg)

               IF INT(TIMER - algusaeg) > 119 THEN
                LOCATE 10, 16: COLOR 15: PRINT "Aeg lÑbi!"
                DO
                LOOP UNTIL INKEY$ = CHR$(27)
                showtabel
                skoor = 0: naidatudskoor = 0
                loadlevel
               END IF


FOR i = 1 TO kollidearv
      
      
       IF kollid(i).nagu <> 0 THEN
           
            IF kollid(i).kinni = 23 THEN
             plats(kollid(i).x, kollid(i).y) = Etyhi
             kollid(i).x = INT(RND * 22) + 1
             kollid(i).y = INT(RND * 12) + 1
             plats(kollid(i).x, kollid(i).y) = Etyhi
            END IF

        IF kollid(i).suund = 0 AND kollid(i).uimane < 2 THEN
                IF RTRIM$(kollid(i).nimi) = "koll1" THEN PUT (40 + kollid(i).x * 10, 20 + kollid(i).y * 10), koll121, PSET
                IF RTRIM$(kollid(i).nimi) = "koll2" THEN PUT (40 + kollid(i).x * 10, 20 + kollid(i).y * 10), koll221, PSET
                IF RTRIM$(kollid(i).nimi) = "koll3" THEN PUT (40 + kollid(i).x * 10, 20 + kollid(i).y * 10), koll321, PSET
                IF RTRIM$(kollid(i).nimi) = "koll4" THEN PUT (40 + kollid(i).x * 10, 20 + kollid(i).y * 10), koll421, PSET
               IF RTRIM$(kollid(i).nimi) = "koll5" THEN PUT (40 + kollid(i).x * 10, 20 + kollid(i).y * 10), koll521, PSET
                IF RTRIM$(kollid(i).nimi) = "koll6" THEN PUT (40 + kollid(i).x * 10, 20 + kollid(i).y * 10), koll621, PSET
               ' IF RTRIM$(kollid(i).nimi) = "koll7" THEN PUT (40 + kollid(i).x * 10, 20 + kollid(i).y * 10), koll721, PSET
               ' IF RTRIM$(kollid(i).nimi) = "koll8" THEN PUT (40 + kollid(i).x * 10, 20 + kollid(i).y * 10), koll821, PSET
               ' IF RTRIM$(kollid(i).nimi) = "koll9" THEN PUT (40 + kollid(i).x * 10, 20 + kollid(i).y * 10), koll921, PSET
                
                END IF
        IF kollid(i).suund = 5 AND kollid(i).kinni < 3 THEN
               
                IF RTRIM$(kollid(i).nimi) = "koll1" THEN PUT (40 + kollid(i).x * 10, 20 + kollid(i).y * 10), koll121, PSET
                IF RTRIM$(kollid(i).nimi) = "koll2" THEN PUT (40 + kollid(i).x * 10, 20 + kollid(i).y * 10), koll221, PSET
                IF RTRIM$(kollid(i).nimi) = "koll3" THEN PUT (40 + kollid(i).x * 10, 20 + kollid(i).y * 10), koll321, PSET
                IF RTRIM$(kollid(i).nimi) = "koll4" THEN PUT (40 + kollid(i).x * 10, 20 + kollid(i).y * 10), koll421, PSET
                IF RTRIM$(kollid(i).nimi) = "koll5" THEN PUT (40 + kollid(i).x * 10, 20 + kollid(i).y * 10), koll521, PSET
                IF RTRIM$(kollid(i).nimi) = "koll6" THEN PUT (40 + kollid(i).x * 10, 20 + kollid(i).y * 10), koll621, PSET
             '   IF RTRIM$(kollid(i).nimi) = "koll7" THEN PUT (40 + kollid(i).x * 10, 20 + kollid(i).y * 10), koll721, PSET
             '   IF RTRIM$(kollid(i).nimi) = "koll8" THEN PUT (40 + kollid(i).x * 10, 20 + kollid(i).y * 10), koll821, PSET
             '   IF RTRIM$(kollid(i).nimi) = "koll9" THEN PUT (40 + kollid(i).x * 10, 20 + kollid(i).y * 10), koll921, PSET
            END IF
        
      
            IF kollid(i).x = ise.x AND kollid(i).y = ise.y AND kollid(i).uimane > 1 THEN
               kollisurm i, 2
            END IF
           
            IF kollid(i).x = ise.x AND kollid(i).y = ise.y AND kollid(i).uimane < 1 THEN
                'gameover

                LOCATE 10, 16: COLOR 15: PRINT "Peksa said!"
                DO
                LOOP UNTIL INKEY$ = CHR$(27)
                showtabel
                skoor = 0: naidatudskoor = 0
                loadlevel
            END IF
        END IF


NEXT i




IF ise.suund > 10 AND ise.suund < 20 THEN ise.suund = ise.suund - 10

        'annab Hi$-le sisestatu vÑÑrtuse
       
        varin = 0
        Hi2$ = INKEY$
       DO
       hi$ = Hi2$
       Hi2$ = INKEY$
       LOOP UNTIL Hi2$ = ""

        IF hi$ <> "" THEN
               
                'DO
                '        a$ = INKEY$
                'LOOP UNTIL a$ = ""

        IF hi$ = CHR$(32) THEN ise.suund = ise.nagu + 10: loobkasti
        IF LEN(hi$) = 2 AND ASC(RIGHT$(hi$, 1)) = 72 THEN sammuke 8
        IF LEN(hi$) = 2 AND ASC(RIGHT$(hi$, 1)) = 80 THEN sammuke 2
        IF LEN(hi$) = 2 AND ASC(RIGHT$(hi$, 1)) = 75 THEN sammuke 4
        IF LEN(hi$) = 2 AND ASC(RIGHT$(hi$, 1)) = 77 THEN sammuke 6
        END IF


leiakaugused
LOOP UNTIL hi$ = CHR$(27)

GOTO peakstootama

'LOCATE 10, 8
'COLOR 59
'PRINT "Esc - vÑlja Enter - uuesti"

'DO
'Hi1$ = INKEY$
'LOOP UNTIL Hi1$ <> ""

'IF Hi1$ = CHR$(13) THEN GOTO peakstootama

'SCREEN 0
'PRINT "PAHARET"
'PRINT "®2000 by Cooler & Urmas Nimetu"
'PRINT "Made in Estonia"
'SYSTEM


errorline:
LOCATE 2, 1
PRINT i
PRINT a
INPUT a
SCREEN 0
SYSTEM

SUB astu (x%, y%, suund%, kaader%, nimi$)

'0-seisab. Aga ilmselt vahib alla
' 2,4,6,8 - liigub
' 12,14,16,18 - lîîb (ise)
' 20 - on uimane
'50,51,52 -kaob 53,54,54-tekib
'





x1 = 40 + x% * 10
y1 = 20 + y% * 10


IF suund% = 2 THEN
        'teeb tausta (ja -1 pixel) tÅhjaks
        y1 = y1 + kaader%
        LINE (x1, y1 - 1)-(x1 + 9, y1 - 1), 0
END IF

IF suund% = 4 THEN
        'teeb tausta (ja -1 pixel) tÅhjaks
        x1 = x1 - kaader%
        LINE (x1 + 10, y1)-(x1 + 10, y1 + 9), 0
END IF

IF suund% = 6 THEN
        'teeb tausta (ja -1 piX%el) tÅhjaks
        x1 = x1 + kaader%
        LINE (x1 - 1, y1)-(x1 - 1, y1 + 9), 0
       
END IF

IF suund% = 8 THEN
        'teeb tausta (ja -1 piX%el) tÅhjaks
        y1 = y1 - kaader%
        LINE (x1, y1 + 10)-(x1 + 9, y1 + 10), 0
END IF



IF nimi$ = "ise" THEN
        IF suund% = 2 AND kaader% < 5 THEN PUT (x1, y1), ise22, PSET
        IF suund% = 2 AND kaader% > 4 THEN PUT (x1, y1), ise21, PSET
        IF suund% = 4 AND kaader% < 5 THEN PUT (x1, y1), ise42, PSET
        IF suund% = 4 AND kaader% > 4 THEN PUT (x1, y1), ise41, PSET
        IF suund% = 6 AND kaader% < 5 THEN PUT (x1, y1), ise62, PSET
        IF suund% = 6 AND kaader% > 4 THEN PUT (x1, y1), ise61, PSET
        IF suund% = 8 AND kaader% < 5 THEN PUT (x1, y1), ise82, PSET
        IF suund% = 8 AND kaader% > 4 THEN PUT (x1, y1), ise81, PSET
       
        'lîîgid
        IF suund% = 12 AND kaader% < 5 THEN PUT (x1, y1), ise22, PSET
        IF suund% = 18 AND kaader% < 5 THEN PUT (x1, y1), ise82, PSET
        IF suund% = 14 AND kaader% < 5 THEN PUT (x1, y1), isel4, PSET
        IF suund% = 16 AND kaader% < 5 THEN PUT (x1, y1), isel6, PSET

END IF

IF nimi$ = "koll1" THEN
        IF suund% = 2 THEN PUT (x1, y1), koll121, PSET
        IF suund% = 4 THEN PUT (x1, y1), koll141, PSET
        IF suund% = 6 THEN PUT (x1, y1), koll161, PSET
        IF suund% = 8 THEN PUT (x1, y1), koll181, PSET
       
        'uimane
        IF suund% = 20 AND kaader% < 6 THEN PUT (x1, y1), koll1uimane1, PSET
        IF suund% = 20 AND kaader% > 5 THEN PUT (x1, y1), koll1uimane2, PSET
       


        'vangist vabanev
        IF suund% = 50 THEN PUT (x1, y1), koll1kaob1, PSET
        IF suund% = 51 THEN PUT (x1, y1), koll1kaob2, PSET
        IF suund% = 52 THEN PUT (x1, y1), koll1kaob3, PSET
        IF suund% = 53 THEN PUT (x1, y1), koll1kaob3, PSET
        IF suund% = 54 THEN PUT (x1, y1), koll1kaob2, PSET
        IF suund% = 55 THEN PUT (x1, y1), koll1kaob1, PSET
        END IF

IF nimi$ = "koll2" THEN
        IF suund% = 2 THEN PUT (x1, y1), koll221, PSET
        IF suund% = 4 THEN PUT (x1, y1), koll241, PSET
        IF suund% = 6 THEN PUT (x1, y1), koll261, PSET
        IF suund% = 8 THEN PUT (x1, y1), koll281, PSET
        'uimane
        IF suund% = 20 AND kaader% < 6 THEN PUT (x1, y1), koll2uimane1, PSET
        IF suund% = 20 AND kaader% > 5 THEN PUT (x1, y1), koll2uimane2, PSET
        'vangist vabanev
        IF suund% = 50 THEN PUT (x1, y1), koll2kaob1, PSET
        IF suund% = 51 THEN PUT (x1, y1), koll2kaob2, PSET
        IF suund% = 52 THEN PUT (x1, y1), koll2kaob3, PSET
        IF suund% = 53 THEN PUT (x1, y1), koll2kaob3, PSET
        IF suund% = 54 THEN PUT (x1, y1), koll2kaob2, PSET
        IF suund% = 55 THEN PUT (x1, y1), koll2kaob1, PSET
        END IF


IF nimi$ = "koll3" THEN
        IF suund% = 2 THEN PUT (x1, y1), koll321, PSET
        IF suund% = 4 THEN PUT (x1, y1), koll341, PSET
        IF suund% = 6 THEN PUT (x1, y1), koll361, PSET
        IF suund% = 8 THEN PUT (x1, y1), koll381, PSET
        'uimane
        IF suund% = 20 AND kaader% < 6 THEN PUT (x1, y1), koll3uimane1, PSET
        IF suund% = 20 AND kaader% > 5 THEN PUT (x1, y1), koll3uimane2, PSET
        'vangist vabanev
        IF suund% = 50 THEN PUT (x1, y1), koll3kaob1, PSET
        IF suund% = 51 THEN PUT (x1, y1), koll3kaob2, PSET
        IF suund% = 52 THEN PUT (x1, y1), koll3kaob3, PSET
        IF suund% = 53 THEN PUT (x1, y1), koll3kaob3, PSET
        IF suund% = 54 THEN PUT (x1, y1), koll3kaob2, PSET
        IF suund% = 55 THEN PUT (x1, y1), koll3kaob1, PSET
        END IF

IF nimi$ = "koll4" THEN
        IF suund% = 2 THEN PUT (x1, y1), koll421, PSET
        IF suund% = 4 THEN PUT (x1, y1), koll441, PSET
        IF suund% = 6 THEN PUT (x1, y1), koll461, PSET
        IF suund% = 8 THEN PUT (x1, y1), koll481, PSET
        'uimane
        IF suund% = 20 AND kaader% < 6 THEN PUT (x1, y1), koll4uimane1, PSET
        IF suund% = 20 AND kaader% > 5 THEN PUT (x1, y1), koll4uimane2, PSET
        'vangist vabanev
        IF suund% = 50 THEN PUT (x1, y1), koll4kaob1, PSET
        IF suund% = 51 THEN PUT (x1, y1), koll4kaob2, PSET
        IF suund% = 52 THEN PUT (x1, y1), koll4kaob3, PSET
        IF suund% = 53 THEN PUT (x1, y1), koll4kaob3, PSET
        IF suund% = 54 THEN PUT (x1, y1), koll4kaob2, PSET
        IF suund% = 55 THEN PUT (x1, y1), koll4kaob1, PSET
        END IF

IF nimi$ = "koll5" THEN
        IF suund% = 2 THEN PUT (x1, y1), koll521, PSET
        IF suund% = 4 THEN PUT (x1, y1), koll541, PSET
        IF suund% = 6 THEN PUT (x1, y1), koll561, PSET
        IF suund% = 8 THEN PUT (x1, y1), koll581, PSET
        'uimane
        IF suund% = 20 AND kaader% < 6 THEN PUT (x1, y1), koll5uimane1, PSET
        IF suund% = 20 AND kaader% > 5 THEN PUT (x1, y1), koll5uimane2, PSET
        'vangist vabanev
        IF suund% = 50 THEN PUT (x1, y1), koll5kaob1, PSET
        IF suund% = 51 THEN PUT (x1, y1), koll5kaob2, PSET
        IF suund% = 52 THEN PUT (x1, y1), koll5kaob3, PSET
        IF suund% = 53 THEN PUT (x1, y1), koll5kaob3, PSET
        IF suund% = 54 THEN PUT (x1, y1), koll5kaob2, PSET
        IF suund% = 55 THEN PUT (x1, y1), koll5kaob1, PSET
        END IF


IF nimi$ = "koll6" THEN
        IF suund% = 2 THEN PUT (x1, y1), koll621, PSET
        IF suund% = 4 THEN PUT (x1, y1), koll641, PSET
        IF suund% = 6 THEN PUT (x1, y1), koll661, PSET
        IF suund% = 8 THEN PUT (x1, y1), koll681, PSET
        'uimane
        IF suund% = 20 AND kaader% < 6 THEN PUT (x1, y1), koll6uimane1, PSET
        IF suund% = 20 AND kaader% > 5 THEN PUT (x1, y1), koll6uimane2, PSET
        'vangist vabanev
        IF suund% = 50 THEN PUT (x1, y1), koll6kaob1, PSET
        IF suund% = 51 THEN PUT (x1, y1), koll6kaob2, PSET
        IF suund% = 52 THEN PUT (x1, y1), koll6kaob3, PSET
        IF suund% = 53 THEN PUT (x1, y1), koll6kaob3, PSET
        IF suund% = 54 THEN PUT (x1, y1), koll6kaob2, PSET
        IF suund% = 55 THEN PUT (x1, y1), koll6kaob1, PSET
        END IF



END SUB

SUB checkpassword

OPEN "paharet.inf" FOR INPUT AS #1
LINE INPUT #1, a$
IF a$ = "takataka" THEN LINE INPUT #1, a$: arvutikiirus = VAL(a$): CLOSE #1: EXIT SUB
CLOSE #1

CLS
INPUT "Sisesta kood:", a$
IF LCASE$(a$) = "tornado" THEN
PRINT "Sinu arvuti on umbes sellise kiirusega:"
PRINT "  1) Mega-aeglane"
PRINT "  2) PENTIUM 100Mhz"
PRINT "  3) PENTIUM 166-MMX"
PRINT "  4) PENTIUM II 266Mhz"
PRINT "  5) Kiireim k‰igist"
INPUT a

SELECT CASE a
        CASE 1
           arvutikiirus = 10
        CASE 2
           arvutikiirus = 70
        CASE 3
           arvutikiirus = 130
        CASE 4
           arvutikiirus = 180
        CASE 5
           arvutikiirus = 240
        CASE ELSE
           PRINT "JOBU!": SCREEN 0: SYSTEM
END SELECT

        OPEN "paharet.inf" FOR OUTPUT AS #1
                PRINT #1, "takataka"
                PRINT #1, arvutikiirus
        CLOSE #1

            user.maxlevel = 1
            user.nimi = "Trivimi"
            DEF SEG = VARSEG(user)
            BSAVE "paharet.usr", VARPTR(user), 12
            DEF SEG

ELSE
  PRINT "SEE MéNG ON VAID KILLUKE OSAKE <HACKERS WORLD II-st>."
  PRINT "Enne mÑngi ikka ÂIGET MéNGU"
  PRINT "JA ALLES SIIS PôôRDU PAHARETI POOLE!"
  SCREEN 0
  SYSTEM
END IF


END SUB

SUB kollisurm (kollinr, pohjus)

'pohjus = 1 - koll sai kastiga pÑhe
'pohjus = 2 - oli uimane ja sîîdi ise poolt Ñra


'leia bonuse suurus
IF pohjus = 1 THEN
                FOR i = 400 TO 200 STEP -6
                SOUND i, .02
                NEXT
                FOR i = 300 TO 200 STEP -6
                SOUND i, .03
                NEXT

        bonus = kollid(kollinr).tarkus * 10
END IF

IF pohjus = 2 THEN
         FOR i = 250 TO 370 STEP 4
         SOUND i, .12
         NEXT
         FOR i = 250 TO 370 STEP 4
         SOUND i, .06
         NEXT


        bonus = kollid(kollinr).tarkus * 20
END IF


'tapa koll
kollid(kollinr).nagu = 0

'nÑita skoori
        skoor = skoor + bonus
        COLOR 25
        LOCATE 21, 7
        PRINT USING "##### $"; skoor




'kontrolli mitu kolli on veel elus

a = 0
FOR i = 1 TO kollidearv
IF kollid(i).nagu <> 0 THEN a = a + 1
NEXT i

IF a = 0 THEN
        LOCATE 10, 13
        COLOR 28
        PRINT "ésasid Ñra neile!"
        
        DO
        LOOP UNTIL INKEY$ = CHR$(13)
       
        level = level + 1
        IF level = 100 THEN level = 99
        IF level > user.maxlevel THEN user.maxlevel = level
                'savegame (automaatne)
                DEF SEG = VARSEG(user)
                BSAVE "paharet.usr", VARPTR(user), 12
                DEF SEG
        loadlevel
        SLEEP 4
END IF


END SUB

SUB leiakaugused

FOR y% = 1 TO 12
FOR x% = 1 TO 22
        IF plats(x%, y%) < 100 AND plats(x%, y%) > 0 THEN plats(x%, y%) = 0
NEXT x%
NEXT y%


'FOR j% = 1 TO 12
'FOR i% = 1 TO 22
   'plats(i%, j%) = 0
   'IF plats(i%, j%) = "" THEN plats(i%, j%) = 0
  'IF plats(i%, j%) <> 0 THEN plats(i%, j%) = 1
    'IF plats(i%, j%) = "€" THEN mote(i%, j%) = 1
    'IF plats(i%, j%) = "≤" THEN mote(i%, j%) = 1
    'IF plats(i%, j%) = "±" THEN mote(i%, j%) = 1
'NEXT i%
'NEXT j%


x% = ise.x
y% = ise.y
a% = 0

teepikkus% = 1
plats(x%, y%) = teepikkus% + 1

DO
        a% = a% + 1
        teepikkus% = teepikkus% + 1
        oli% = 0
        FOR j% = 1 TO 12
        FOR i% = 1 TO 22
        IF plats(i%, j%) = teepikkus% THEN
                IF i% < 22 THEN
                        IF plats(i% + 1, j%) = 0 THEN plats(i% + 1, j%) = teepikkus% + 1: oli% = 1
                        END IF
                IF j% < 12 THEN
                        IF plats(i%, j% + 1) = 0 THEN plats(i%, j% + 1) = teepikkus% + 1: oli% = 1
                        END IF
                IF i% > 1 THEN
                        IF plats(i% - 1, j%) = 0 THEN plats(i% - 1, j%) = teepikkus% + 1: oli% = 1
                        END IF
                IF j% > 1 THEN
                        IF plats(i%, j% - 1) = 0 THEN plats(i%, j% - 1) = teepikkus% + 1: oli% = 1
                        END IF
        END IF
        NEXT i%
        NEXT j%

IF a% = 50 THEN EXIT DO
LOOP UNTIL oli% = 0

'FOR y% = 1 TO 12
'FOR x% = 1 TO 22
'
'LOCATE y%, x%
'COLOR 14
'IF plats(x%, y%) < 100 THEN COLOR 15
'PRINT LTRIM$(STR$(plats(x%, y%)))
'NEXT x%
'NEXT y%
'SLEEP 7

END SUB

FUNCTION leiavabasuund (x%, y%, suund%, tarkus%)





'SIIT ALGAB SEE AI, MILLE TEGI URMAS

'saabminna = 1 -> valitud suunas saab liikuda kyll




'k‰igepealt vaatame, ega koll pÑris kinni ei ole
s% = suund%
a = 0
FOR suund% = 2 TO 8 STEP 2
 GOSUB proovisamm
 IF saabminna% = 0 THEN a = a + 1
NEXT suund%
suund% = s%
IF a = 4 THEN leiavabasuund = 5: EXIT FUNCTION






IF tarkus% = 1 THEN
  a = INT(RND * 3)
        IF a = 0 THEN leiavabasuund = 0
        IF a = 1 THEN GOSUB valiisetee
        IF a = 2 THEN
                B = INT(RND * 2)
                 IF B = 0 THEN 'y teljel
                        IF ise.y > y% THEN suund% = 2
                        IF ise.y < y% THEN suund% = 8
                        IF ise.y = y% THEN B = 1
                        END IF
                 IF B = 1 THEN
                        IF ise.x > x% THEN suund% = 6
                        IF ise.x < x% THEN suund% = 4
                        IF ise.x = x% THEN GOSUB valiisetee
                        END IF
                 GOSUB proovisamm
                 leiavabasuund = suund%
                 IF saabminna% = 0 THEN GOSUB valiisetee
                END IF

END IF


IF tarkus% = 2 THEN
  a = INT(RND * 2)
        IF a = 0 THEN
                B = INT(RND * 2)
                IF B = 1 THEN GOSUB valiisetee
                IF B = 0 THEN leiavabasuund = 0
                END IF
        IF a = 1 THEN
                B = INT(RND * 2)
                 IF B = 0 THEN 'y teljel
                        IF ise.y > y% THEN suund% = 2
                        IF ise.y < y% THEN suund% = 8
                        IF ise.y = y% THEN B = 1
                        END IF
                 IF B = 1 THEN
                        IF ise.x > x% THEN suund% = 6
                        IF ise.x < x% THEN suund% = 4
                        IF ise.x = x% THEN GOSUB valiisetee
                        END IF
                 GOSUB proovisamm
                 leiavabasuund = suund%
                 IF saabminna% = 0 THEN GOSUB valiisetee
                END IF
 
END IF

IF tarkus% = 3 THEN
                a = INT(RND * 2)
                 IF a = 0 THEN 'y teljel
                        IF ise.y > y% THEN suund% = 2
                        IF ise.y < y% THEN suund% = 8
                        IF ise.y = y% THEN a = 1
                        END IF
                 IF a = 1 THEN
                        IF ise.x > x% THEN suund% = 6
                        IF ise.x < x% THEN suund% = 4
                        IF ise.x = x% THEN
                                IF ise.y > y% THEN suund% = 2
                                IF ise.y < y% THEN suund% = 8
                                 END IF
                        END IF
                 GOSUB proovisamm
                 leiavabasuund = suund%
                 IF saabminna% = 0 THEN GOSUB valiisetee
              

END IF

IF tarkus% = 4 THEN
   'kui ise on lÑheduses, siis%liigub...
  IF ise.x > x% - 4 AND ise.x < x% + 4 AND ise.y > y% - 4 AND ise.y < y% + 4 THEN
        a = INT(RND * 2)
                '... lÑhemale
                B = INT(RND * 2)
                 IF B = 0 THEN 'y teljel
                        IF ise.y > y% THEN suund% = 2
                        IF ise.y < y% THEN suund% = 8
                        IF ise.y = y% THEN B = 1
                        END IF
                 IF B = 1 THEN
                        IF ise.x > x% THEN suund% = 6
                        IF ise.x < x% THEN suund% = 4
                        IF ise.x = x% THEN
                                IF ise.y > y% THEN suund% = 2
                                IF ise.y < y% THEN suund% = 8
                                 END IF
                        END IF
                '...eemale
           IF a = 1 THEN
                GOSUB valiisetee
           END IF
                
                 GOSUB proovisamm
                 leiavabasuund = suund%
                 IF saabminna% = 0 THEN GOSUB valiisetee
         END IF
     'kui koll on isest kaugel
     IF ise.x < x% - 3 OR ise.x > x% + 3 OR ise.y < y% - 3 OR ise.y > y% + 3 THEN
      a = INT(RND * 20)
       leiavabasuund = 0
       IF a = 0 THEN GOSUB valiisetee
     END IF
END IF


IF tarkus% = 5 THEN
  a = 0
   
  IF ise.x < x% - 5 OR ise.x > x% + 5 THEN a = 1
  IF ise.y < y% - 5 OR ise.y > y% + 5 THEN a = 1
   'PRINT ise.x; ise.y; x; y%; a
   'SLEEP 1
    ' kui ise on kaugel, siis proovib liikuda lÑhemale
  IF a = 1 THEN

                B = INT(RND * 2)
                 IF B = 0 THEN 'y teljel
                        IF ise.y > y% THEN suund% = 2
                        IF ise.y < y% THEN suund% = 8
                        IF ise.y = y% THEN B = 1
                        END IF
                IF B = 1 THEN
                        IF ise.x > x% THEN suund% = 6
                        IF ise.x < x% THEN suund% = 4
                        IF ise.x = x% THEN
                                IF ise.y > y% THEN suund% = 2
                                IF ise.y < y% THEN suund% = 8
                                 END IF
                        END IF
                'aga ummikusse ei jookse
                GOSUB prooviummik
           LOCATE 1, 1
           
                
                IF ummik > 1 THEN
                        B = INT(RND * 3)
                        IF B = 0 THEN suund% = 0
                        IF B = 1 THEN
                                IF suund% = 8 OR suund% = 2 THEN s% = 6
                                IF suund% = 4 OR suund% = 6 THEN s% = 2
                                END IF
                        IF B = 2 THEN
                                IF suund% = 8 OR suund% = 2 THEN s% = 4
                                IF suund% = 4 OR suund% = 6 THEN s% = 8
                                END IF
                        suund% = s
                        END IF
        

  END IF

  'kui koll on isele lÑhedal
  IF a = 0 THEN
                 
                 B = INT(RND * 2)
                      IF B = 0 THEN
                        IF ise.x > x% THEN suund% = 6
                        IF ise.x < x% THEN suund% = 4
                        IF ise.x = x% THEN B = 1
                        END IF
                      IF B = 1 THEN
                        IF ise.y > y% THEN suund% = 2
                        IF ise.y < y% THEN suund% = 8
                        IF ise.y = y% THEN
                                IF ise.x > x% THEN suund% = 6
                                IF ise.x < x% THEN suund% = 4
                                END IF
                        END IF
                   
  END IF
 
  GOSUB proovisamm
  leiavabasuund = suund%
  IF saabminna% = 0 THEN GOSUB valiisetee


END IF

IF tarkus% = 6 THEN
        suund% = 0
        GOSUB valilyhimtee
        leiavabasuund = suund%
        IF suund% = 0 THEN
        GOSUB valiisetee
        END IF
END IF





'iga koll sîîb k‰rvale ilmunud Ise Ñra

IF x% = ise.x + 1 AND y% = ise.y THEN leiavabasuund = 4
IF x% = ise.x - 1 AND y% = ise.y THEN leiavabasuund = 6
IF y% = ise.y + 1 AND x% = ise.x THEN leiavabasuund = 8
IF y% = ise.y - 1 AND x% = ise.x THEN leiavabasuund = 2






EXIT FUNCTION

'see on asi, mis katsub Ñra, kas valitud suunas Åldse liikuda saab
'y1 - plaanitav y
'x1 - plaanitav x
'VALIB TEE RANDOMIZEGA
valiisetee:

  s% = INT(RND * 4) * 2 + 2
 DO
  suund% = s%

GOSUB proovisamm
 
 
  s% = s% + 2
  IF s% = 10 THEN s% = 2
 LOOP UNTIL saabminna% = 1
leiavabasuund = suund%
RETURN


'see m‰‰dab, millal saabub valitud suunas ummik
'1-ei saa Åldse liikuda
'2-ei julge liikuda(v‰ib minna platsilt vÑlja)
'3-pÑrast Åhte sammu
'4-pÑrast teist sammu

prooviummik:

ummik = 0

GOSUB proovisamm
IF saabminna% = 0 THEN
        ummik = 1
END IF


                y1 = y%: x1 = x%
                IF suund% = 8 THEN y1 = y% - 1
                IF suund% = 2 THEN y1 = y% + 1
                IF suund% = 4 THEN x1 = x% - 1
                IF suund% = 6 THEN x1 = x% + 1
IF x1 < 3 AND suund% = 8 THEN ummik = 2
IF x1 > 20 AND suund% = 2 THEN ummik = 2
IF y1 < 3 AND suund% = 4 THEN ummik = 2
IF y1 > 10 AND suund% = 6 THEN ummik = 2
    

IF ummik = 0 THEN
      u1 = 0
      'vaatab, kas k‰ik suunad on TéIESTI tÅhjad
      IF plats(x1, y1 - 1) > 100 AND plats(x1, y1 - 1) < 199 THEN u1 = u1 + 1
      IF plats(x1, y1 + 1) > 100 AND plats(x1, y1 + 1) < 199 THEN u1 = u1 + 1
      IF plats(x1 - 1, y1) > 100 AND plats(x1 - 1, y1) < 199 THEN u1 = u1 + 1
      IF plats(x1 + 1, y1) > 100 AND plats(x1 + 1, y1) < 199 THEN u1 = u1 + 1
      IF u1 > 2 THEN ummik = 3
       
        'vaatab Ñra jÑrgmise koha
        IF u1 = 2 THEN
                IF plats(x1, y1 - 1) > 100 AND plats(x1, y1 - 1) < 199 AND suund% <> 2 THEN y1 = y1 - 1
                IF plats(x1, y1 + 1) > 100 AND plats(x1, y1 + 1) < 199 AND suund% <> 8 THEN y1 = y1 + 1
                IF plats(x1 - 1, y1) > 100 AND plats(x1 - 1, y1) < 199 AND suund% <> 6 THEN x1 = x1 - 1
                IF plats(x1 + 1, y1) > 100 AND plats(x1 + 1, y1) < 199 AND suund% <> 4 THEN x1 = x1 + 1
                       
                        'ja selle k‰rval asuvad asjad
                        u1 = 0
                        IF plats(x1, y1 - 1) > 100 AND plats(x1, y1 - 1) THEN u1 = u1 + 1
                        IF plats(x1, y1 + 1) > 100 AND plats(x1, y1 + 1) THEN u1 = u1 + 1
                        IF plats(x1 - 1, y1) > 100 AND plats(x1 - 1, y1) THEN u1 = u1 + 1
                        IF plats(x1 + 1, y1) > 100 AND plats(x1 + 1, y1) THEN u1 = u1 + 1
                        IF u1 > 2 THEN ummik = 4
      END IF
END IF

RETURN




'peaks leidma k‰ikse lÅhema tee iseni

valilyhimtee:

IF x% < 22 THEN
        IF plats(x% + 1, y%) <> 1 AND plats(x% + 1, y%) < plats(x%, y%) THEN suund% = 6
        END IF
IF y% < 12 THEN
        IF plats(x%, y% + 1) <> 1 AND plats(x%, y% + 1) < plats(x%, y%) THEN suund% = 2
        END IF
IF x% > 1 THEN
        IF plats(x% - 1, y%) <> 1 AND plats(x% - 1, y%) < plats(x%, y%) THEN suund% = 4
        END IF
IF y% > 1 THEN
        IF plats(x%, y% - 1) <> 1 AND plats(x%, y% - 1) < plats(x%, y%) THEN suund% = 8
        END IF

RETURN

'See annab saabminna-le vÑÑrtuseks 1-e, kui
        'soovitd suunas saab liikuda

proovisamm:

y1 = y%
x1 = x%


 saabminna% = 1
IF suund% = 8 THEN
        IF y% = 1 THEN saabminna% = 0
         IF y% <> 1 THEN y1 = y% - 1
       END IF
 IF suund% = 2 THEN
        IF y% = 12 THEN saabminna% = 0
        IF y% <> 12 THEN y1 = y% + 1
       END IF
 IF suund% = 4 THEN
        IF x% = 1 THEN saabminna% = 0
        IF x% <> 1 THEN x1 = x% - 1
       END IF
 IF suund% = 6 THEN
        IF x% = 22 THEN saabminna% = 0
        IF x% <> 22 THEN x1 = x% + 1
       END IF


'vaatame, kas y1 ja x1 on astumisk‰lbulikud
   
    IF plats(x1, y1) = Kast2pilt THEN saabminna% = 0
    IF plats(x1, y1) = Kast1pilt THEN saabminna% = 0
    'IF plats(x1, y1) = "±" THEN saabminna% = 0

RETURN


END FUNCTION

SUB loadlevel
 'user.currentlevel = nr
 'level = 99
 maxlevel = 100
 varin = 0

 IF level = 0 THEN level = 1
 IF level > maxlevel THEN level = 1

IF level < 99 THEN
 OPEN "pahaleve.txt" FOR INPUT AS #1
DO
IF EOF(1) THEN
   SCREEN 0
   PRINT "Tasandeid pole praegu rohkem valmis tehtud."
   PRINT "Uuendusi otsi lehekÅljelt:"
   PRINT "http://www.hot.ee/cooler/hacker/"
   CLOSE #1
   SYSTEM
END IF
LINE INPUT #1, rida$
LOOP UNTIL rida$ = "[" + LTRIM$(RTRIM$(STR$(level))) + "]"

FOR y = 1 TO 12
FOR x = 1 TO 22
plats(x, y) = 0
NEXT x
NEXT y

FOR y = 1 TO 12
LINE INPUT #1, rida$
FOR x = 1 TO 22
 plats(x, y) = ASC(RIGHT$(LEFT$(rida$, x), 1))
    IF RIGHT$(LEFT$(rida$, x), 1) = "€" THEN plats(x, y) = Kast2pilt
    IF RIGHT$(LEFT$(rida$, x), 1) = "≤" THEN plats(x, y) = Kast1pilt
    IF RIGHT$(LEFT$(rida$, x), 1) = "A" THEN plats(x, y) = 100


 IF plats(x, y) > 48 AND plats(x, y) < 58 THEN
        kaunter = kaunter + 1

          kollid(kaunter).x = x
          kollid(kaunter).y = y
          kollid(kaunter).uimane = 0
          kollid(kaunter).kinni = 0
          kollid(kaunter).tarkus = VAL(RIGHT$(LEFT$(rida$, x), 1))
          kollid(kaunter).nimi = "koll" + RIGHT$(LEFT$(rida$, x), 1)
          kollid(kaunter).nagu = 2
          kollid(kaunter).suund% = 0
        plats(x, y) = 0
        END IF
 IF plats(x, y) = 100 THEN
         ise.x = x
         ise.y = y
         plats(x, y) = 0
        END IF

 IF plats(x, y) = 32 THEN plats(x, y) = 0

NEXT x
NEXT y

kollidearv = kaunter
CLOSE #1

END IF

' SIIS KUI ENAM UUSI LEVELEID EI OLE!
IF level = 99 THEN
RANDOMIZE TIMER
'teeme tyhjaks
FOR a = 1 TO 22
FOR B = 1 TO 12
plats(a, B) = 0
NEXT B
NEXT a


'lihtsad kastid
a = INT(RND * 120) + 10
FOR kast = 1 TO a
B = INT(RND * 22) + 1
c = INT(RND * 12) + 1
plats(B, c) = Kast1pilt
NEXT kast
'teised kastid
a = INT(RND * 50) + 1
FOR kast = 1 TO a
B = INT(RND * 22) + 1
c = INT(RND * 12) + 1
plats(B, c) = Kast2pilt
NEXT kast
'kollid
kollidearv = INT(RND * 6) + 2

FOR kaunter = 1 TO kollidearv
B = INT(RND * 5) + 1
kollid(kaunter).x = INT(RND * 22) + 1
kollid(kaunter).y = INT(RND * 12) + 1
kollid(kaunter).uimane = 0
kollid(kaunter).kinni = 0
kollid(kaunter).tarkus = B
kollid(kaunter).nimi = "koll" + LTRIM$(RTRIM$(STR$(B)))
kollid(kaunter).nagu = 2
kollid(kaunter).suund% = 0
plats(kollid(kaunter).x, kollid(kaunter).y) = 0
NEXT kaunter

IF kollidearv < 5 THEN
a = INT(RND * kollidearv)
        IF a = 0 THEN
        
        kollid(kaunter).x = INT(RND * 22) + 1
        kollid(kaunter).y = INT(RND * 12) + 1
        kollid(kaunter).uimane = 0
        kollid(kaunter).kinni = 0
        kollid(kaunter).tarkus = 6
        kollid(kaunter).nimi = "koll6"
        kollid(kaunter).nagu = 2
        kollid(kaunter).suund% = 0
        plats(kollid(kaunter).x, kollid(kaunter).y) = 0
        kollidearv = kollidearv + 1
        END IF

END IF

'ja mÑngija ise
a = INT(RND * 22) + 1
B = INT(RND * 12) + 1
plats(a, B) = 100
ise.x = a
ise.y = B
END IF



CLS
'vÑlisÑÑr
LINE (49, 29)-(270, 150), 25, B
LINE (48, 28)-(271, 151), 24, B
LINE (47, 27)-(272, 152), 22, B

'pildi joonistamine
'LINE (100, 100)-(110, 110), 12, BF
FOR x = 1 TO 22
FOR y = 1 TO 12
 IF plats(x, y) = Kast2pilt THEN PUT (40 + x * 10, 20 + y * 10), Kast1, PSET
 IF plats(x, y) = Kast1pilt THEN PUT (40 + x * 10, 20 + y * 10), Kast2, PSET
 'IF plats(x, y) = "A" THEN c = 9: LINE (40 + x * 10, 20 + y * 10)-(49 + x * 10, 29 + y * 10), c, B: plats(x, y) = 0
 'IF plats(x, y) = "1" THEN c = 12: LINE (40 + x * 10, 20 + y * 10)-(49 + x * 10, 29 + y * 10), c, B
NEXT y
NEXT x

PUT (ise.x * 10 + 40, ise.y * 10 + 20), ise22, PSET

FOR i = 100 TO 400 STEP 10
SOUND i, i / 1000
NEXT
FOR i = 200 TO 100 STEP -20
SOUND i, .3
NEXT

LOCATE 21, 16
COLOR 48
IF level < 99 THEN PRINT USING "Tasand ###"; level
IF level = 99 THEN PRINT " Vaba maa"

LOCATE 3, (40 - LEN(RTRIM$(user.nimi))) \ 2 + 1
PRINT user.nimi


SLEEP 4
 algusaeg = INT(TIMER)


END SUB

'
'
SUB loadtegelased
OPEN "pahadata.txt" FOR INPUT AS #1



FOR kord = 1 TO 69
LINE INPUT #1, rida$

FOR y = 1 TO 10
LINE INPUT #1, rida$
FOR x = 1 TO 10
        a = ASC(RIGHT$(LEFT$(rida$, x), 1)) - 50
        PSET (x, y), a
NEXT x
NEXT y
IF kord = 1 THEN GET (1, 1)-(10, 10), ise21
IF kord = 2 THEN GET (1, 1)-(10, 10), ise41
IF kord = 3 THEN GET (1, 1)-(10, 10), ise61
IF kord = 4 THEN GET (1, 1)-(10, 10), ise81

IF kord = 5 THEN GET (1, 1)-(10, 10), ise22
IF kord = 6 THEN GET (1, 1)-(10, 10), ise42
IF kord = 7 THEN GET (1, 1)-(10, 10), ise62
IF kord = 8 THEN GET (1, 1)-(10, 10), ise82

IF kord = 9 THEN GET (1, 1)-(10, 10), isel4
IF kord = 10 THEN GET (1, 1)-(10, 10), isel6

IF kord = 11 THEN GET (1, 1)-(10, 10), Kast2
IF kord = 12 THEN GET (1, 1)-(10, 10), Kast1

IF kord = 13 THEN GET (1, 1)-(10, 10), toss3
IF kord = 14 THEN GET (1, 1)-(10, 10), toss2
IF kord = 15 THEN GET (1, 1)-(10, 10), toss1

IF kord = 16 THEN GET (1, 1)-(10, 10), koll121
IF kord = 17 THEN GET (1, 1)-(10, 10), koll141
IF kord = 18 THEN GET (1, 1)-(10, 10), koll161
IF kord = 19 THEN GET (1, 1)-(10, 10), koll181

IF kord = 20 THEN GET (1, 1)-(10, 10), koll1kaob1
IF kord = 21 THEN GET (1, 1)-(10, 10), koll1kaob2
IF kord = 22 THEN GET (1, 1)-(10, 10), koll1kaob3

IF kord = 23 THEN GET (1, 1)-(10, 10), koll1uimane1
IF kord = 24 THEN GET (1, 1)-(10, 10), koll1uimane2

IF kord = 25 THEN GET (1, 1)-(10, 10), koll221
IF kord = 26 THEN GET (1, 1)-(10, 10), koll241
IF kord = 27 THEN GET (1, 1)-(10, 10), koll261
IF kord = 28 THEN GET (1, 1)-(10, 10), koll281

IF kord = 29 THEN GET (1, 1)-(10, 10), koll2kaob1
IF kord = 30 THEN GET (1, 1)-(10, 10), koll2kaob2
IF kord = 31 THEN GET (1, 1)-(10, 10), koll2kaob3

IF kord = 32 THEN GET (1, 1)-(10, 10), koll2uimane1
IF kord = 33 THEN GET (1, 1)-(10, 10), koll2uimane2

IF kord = 34 THEN GET (1, 1)-(10, 10), koll321
IF kord = 35 THEN GET (1, 1)-(10, 10), koll341
IF kord = 36 THEN GET (1, 1)-(10, 10), koll361
IF kord = 37 THEN GET (1, 1)-(10, 10), koll381

IF kord = 38 THEN GET (1, 1)-(10, 10), koll3kaob1
IF kord = 39 THEN GET (1, 1)-(10, 10), koll3kaob2
IF kord = 40 THEN GET (1, 1)-(10, 10), koll3kaob3

IF kord = 41 THEN GET (1, 1)-(10, 10), koll3uimane1
IF kord = 42 THEN GET (1, 1)-(10, 10), koll3uimane2

IF kord = 43 THEN GET (1, 1)-(10, 10), koll421
IF kord = 44 THEN GET (1, 1)-(10, 10), koll441
IF kord = 45 THEN GET (1, 1)-(10, 10), koll461
IF kord = 46 THEN GET (1, 1)-(10, 10), koll481

IF kord = 47 THEN GET (1, 1)-(10, 10), koll4kaob1
IF kord = 48 THEN GET (1, 1)-(10, 10), koll4kaob2
IF kord = 49 THEN GET (1, 1)-(10, 10), koll4kaob3

IF kord = 50 THEN GET (1, 1)-(10, 10), koll4uimane1
IF kord = 51 THEN GET (1, 1)-(10, 10), koll4uimane2

IF kord = 52 THEN GET (1, 1)-(10, 10), koll521
IF kord = 53 THEN GET (1, 1)-(10, 10), koll541
IF kord = 54 THEN GET (1, 1)-(10, 10), koll561
IF kord = 55 THEN GET (1, 1)-(10, 10), koll581

IF kord = 56 THEN GET (1, 1)-(10, 10), koll5kaob1
IF kord = 57 THEN GET (1, 1)-(10, 10), koll5kaob2
IF kord = 58 THEN GET (1, 1)-(10, 10), koll5kaob3

IF kord = 59 THEN GET (1, 1)-(10, 10), koll5uimane1
IF kord = 60 THEN GET (1, 1)-(10, 10), koll5uimane2

IF kord = 61 THEN GET (1, 1)-(10, 10), koll621
IF kord = 62 THEN GET (1, 1)-(10, 10), koll641
IF kord = 63 THEN GET (1, 1)-(10, 10), koll661
IF kord = 64 THEN GET (1, 1)-(10, 10), koll681

IF kord = 65 THEN GET (1, 1)-(10, 10), koll6kaob1
IF kord = 66 THEN GET (1, 1)-(10, 10), koll6kaob2
IF kord = 67 THEN GET (1, 1)-(10, 10), koll6kaob3

IF kord = 68 THEN GET (1, 1)-(10, 10), koll6uimane1
IF kord = 69 THEN GET (1, 1)-(10, 10), koll6uimane2



'IF kord > 30 THEN SLEEP 1
  NEXT kord



CLOSE #1
END SUB

SUB loaduser
DIM nr AS INTEGER

'SCREEN 13
CLS

DEF SEG = VARSEG(user)
BLOAD "paharet.usr", VARPTR(user)
DEF SEG

'user.nimi = "Loll"
'user.maxlevel = 4


COLOR 27
LOCATE 3, 30
PRINT "PAHARET"
COLOR 24
LOCATE 4, 23
PRINT "Sulev Reisberg"
LOCATE 5, 23
PRINT "Urmas Reisberg"


COLOR 25
index = 1

COLOR 29
LOCATE 10, 10
PRINT "LAHINGUSSE!"
COLOR 25
LOCATE 11, 10
PRINT "Tasand"
LOCATE 12, 10
PRINT "Nime muutmine"
LOCATE 13, 10
PRINT "Punktitabel"
LOCATE 14, 10
PRINT "KOJU"

CONST DOWN = 80, UP = 72
DO
    'LOCATE 1, 1
    'PRINT user.nimi
    'PRINT user.maxlevel
    DO
        Choice$ = INKEY$
        IF Choice$ = CHR$(13) THEN EXIT DO
    LOOP UNTIL LEN(Choice$) = 2
   
       IF Choice$ = CHR$(13) THEN
        IF index = 1 THEN loadlevel: EXIT SUB
         IF index = 2 THEN
           LOCATE 17, 10
           COLOR 29
           PRINT "Vali tasand ( 1 -"; user.maxlevel; "):_"
                msg$ = ""
                kaunter = 0
                nr = 0
                DO
                        DO
                        a$ = INKEY$
                        LOOP UNTIL a$ <> ""
                'IF (ASC(a$) > 47 AND ASC(a$) < 58 AND kaunter = 1) THEN msg$ = a$: nr = val$(a$): LOCATE 17, 31: PRINT msg$: kaunter = kaunter + 1
                IF (ASC(a$) > 47 AND ASC(a$) < 58 AND kaunter < 2) THEN msg$ = msg$ + a$: nr = nr * 10 + VAL(a$): LOCATE 17, 33: PRINT msg$: kaunter = kaunter + 1
                IF (ASC(a$) = 8 AND kaunter > 0) THEN nr = nr - VAL(RIGHT$(msg$, 1)): msg$ = LEFT$(msg$, LEN(msg$) - 1): LOCATE 17, 33: PRINT msg$ + " ": kaunter = kaunter - 1
                LOOP UNTIL a$ = CHR$(13) OR a$ = CHR$(27)
                IF (a$ = CHR$(13) AND nr <= user.maxlevel AND nr > 0) THEN level = nr: loadlevel: EXIT SUB
                LOCATE 17, 10: PRINT "                         "
         END IF
        
         IF index = 3 THEN
           LOCATE 17, 10
           COLOR 29
           PRINT "Uus nimi: _"
                msg$ = ""
                kaunter = 0
                DO
                        DO
                        a$ = INKEY$
                        LOOP UNTIL a$ <> ""
                IF (ASC(a$) > 31 AND kaunter < 10) THEN msg$ = msg$ + a$: LOCATE 17, 20: PRINT msg$: kaunter = kaunter + 1
                IF (ASC(a$) = 8 AND kaunter > 0) THEN msg$ = LEFT$(msg$, LEN(msg$) - 1): LOCATE 17, 20: PRINT msg$ + " ": kaunter = kaunter - 1
                LOOP UNTIL a$ = CHR$(13) OR a$ = CHR$(27)
                IF a$ = CHR$(13) THEN user.nimi = msg$
                 'savegame (automaatne)
                 DEF SEG = VARSEG(user)
                 BSAVE "paharet.usr", VARPTR(user), 11
                 DEF SEG
                LOCATE 17, 10: PRINT "                     "
         END IF
        IF index = 4 THEN showtabel
        IF index = 5 THEN SCREEN 0: SYSTEM
       END IF

        Choice$ = RIGHT$(Choice$, 1)
        SELECT CASE Choice$
            CASE CHR$(DOWN)
                IF index < 5 THEN index = index + 1
            CASE CHR$(UP)
                IF index > 1 THEN index = index - 1
        END SELECT
        'LOCATE 1, 1: PRINT achoice$
    FOR i = 1 TO 5
        'LOCATE 2, 1: PRINT index
       IF i = index THEN
        COLOR 29
       ELSE
        COLOR 25
       END IF
       LOCATE i + 9, 10
       IF i = 1 THEN PRINT "LAHINGUSSE!"
       IF i = 2 THEN PRINT "Tasand"
       IF i = 3 THEN PRINT "Nime muutmine"
       IF i = 4 THEN PRINT "Punktitabel"
       IF i = 5 THEN PRINT "KOJU"
    NEXT i
LOOP



'INPUT a


END SUB

SUB loobkasti
DIM kunikastini AS INTEGER
DIM x1 AS INTEGER
DIM y1 AS INTEGER
DIM x2 AS INTEGER
DIM y2 AS INTEGER

'***********************kas lîîdi ÑÑrt
x1 = 1: x2 = 22: y1 = 1: y2 = 12
IF ise.nagu = 2 AND ise.y = 12 THEN varin = 2: y1 = 12
IF ise.nagu = 4 AND ise.x = 1 THEN varin = 4: x2 = 1
IF ise.nagu = 6 AND ise.x = 22 THEN varin = 6: x1 = 22
IF ise.nagu = 8 AND ise.y = 1 THEN varin = 8: y2 = 1
IF varin <> 0 THEN
         'loeb kollid Åle jÑlle
        FOR i = 1 TO kollidearv
         'leiab sobiva kolli
         IF kollid(i).x >= x1 AND kollid(i).x <= x2 AND kollid(i).y >= y1 AND kollid(i).y <= y2 THEN
            kollid(i).uimane = 30
            kollid(i).suund = 0
                END IF
        NEXT i
               
        FOR i = 250 TO 350 STEP 8
        SOUND i, .12
        NEXT
        FOR i = 350 TO 250 STEP -9
        SOUND i, .09
        NEXT
                EXIT SUB
        END IF




'***********************kas lîîdi kasti
IF ise.nagu = 2 THEN
 IF ise.y = 12 THEN EXIT SUB
 IF plats(ise.x, ise.y + 1) <> Kast1pilt THEN EXIT SUB
 
 kunikastini = ise.y + 1
 FOR y1 = ise.y + 2 TO 13
    IF y1 = 13 THEN kunikastini = 12: EXIT FOR
    IF plats(ise.x, y1) = Kast1pilt THEN kunikastini = y1 - 1: EXIT FOR
    IF plats(ise.x, y1) = Kast2pilt THEN kunikastini = y1 - 1: EXIT FOR
 NEXT y1
 IF kunikastini = ise.y + 1 THEN EXIT SUB
        'kasti kohale tÅhi koht
        LINE (40 + ise.x * 10, 20 + ise.y * 10 + 10)-(49 + ise.x * 10, 29 + ise.y * 10 + 10), 0, BF
        plats(ise.x, ise.y + 1) = 0
        
         'kast uues kohas
                FOR y1 = ise.y + 1 TO kunikastini - 1
                        plats(ise.x, y1) = Etoss3
                NEXT y1
             'kontrollib, kas koll oli all
                FOR i = 1 TO kollidearv
                 IF kollid(i).nagu <> 0 THEN
                    IF ((kollid(i).x = ise.x AND kollid(i).y > ise.y) AND kollid(i).y <= kunikastini) THEN kollisurm i, 1
                 END IF
                NEXT i
                PUT (40 + ise.x * 10, 20 + kunikastini * 10), Kast2, PSET
         'LINE (40 + ise.x * 10, 20 + kunikastini * 10)-(49 + ise.x * 10, 29 + kunikastini * 10), 14, B
         plats(ise.x, kunikastini) = Kast1pilt
         
kaskastliigub = 1
END IF

IF ise.nagu = 4 THEN
 IF ise.x = 1 THEN EXIT SUB
 IF plats(ise.x - 1, ise.y) <> Kast1pilt THEN EXIT SUB
 
 kunikastini = ise.x - 1
 FOR x1 = ise.x - 2 TO 0 STEP -1
    IF x1 = 0 THEN kunikastini = 1: EXIT FOR
    IF plats(x1, ise.y) = Kast1pilt THEN kunikastini = x1 + 1: EXIT FOR
    IF plats(x1, ise.y) = Kast2pilt THEN kunikastini = x1 + 1: EXIT FOR
 NEXT x1
 IF kunikastini = ise.x - 1 THEN EXIT SUB
        'kasti kohale tÅhi koht
        LINE (40 + ise.x * 10 - 10, 20 + ise.y * 10)-(49 + ise.x * 10 - 10, 29 + ise.y * 10), 0, BF
        plats(ise.x - 1, ise.y) = 0
         'kast uues kohas
                FOR x1 = ise.x - 1 TO kunikastini + 1 STEP -1
                        plats(x1, ise.y) = Etoss3
                        
                NEXT x1
             'kontrollib, kas koll jÑi alla
                FOR i = 1 TO kollidearv
                 IF kollid(i).nagu <> 0 THEN
                    IF ((kollid(i).y = ise.y AND kollid(i).x < ise.x) AND kollid(i).x >= kunikastini) THEN kollisurm i, 1
                 END IF
                NEXT i
         PUT (40 + kunikastini * 10, 20 + ise.y * 10), Kast2, PSET
         'LINE (40 + kunikastini * 10, 20 + ise.y * 10)-(49 + kunikastini * 10, 29 + ise.y * 10), 14, B
         plats(kunikastini, ise.y) = Kast1pilt
kaskastliigub = 1
END IF

IF ise.nagu = 6 THEN
 IF ise.x = 22 THEN EXIT SUB
 IF plats(ise.x + 1, ise.y) <> Kast1pilt THEN EXIT SUB
 
 kunikastini = ise.x + 1
 FOR x1 = ise.x + 2 TO 23
    IF x1 = 23 THEN kunikastini = 22: EXIT FOR
    IF plats(x1, ise.y) = Kast1pilt THEN kunikastini = x1 - 1: EXIT FOR
    IF plats(x1, ise.y) = Kast2pilt THEN kunikastini = x1 - 1: EXIT FOR
 NEXT x1
 IF kunikastini = ise.x + 1 THEN EXIT SUB
        'kasti kohale tÅhi koht
        LINE (40 + ise.x * 10 + 10, 20 + ise.y * 10)-(49 + ise.x * 10 + 10, 29 + ise.y * 10), 0, BF
        plats(ise.x + 1, ise.y) = 0
        
         'kast uues kohas
                FOR x1 = ise.x + 1 TO kunikastini - 1
                        plats(x1, ise.y) = Etoss3
                NEXT x1
             'kontrollib, kas koll jÑi alla
                FOR i = 1 TO kollidearv
                 IF kollid(i).nagu <> 0 THEN
                    IF ((kollid(i).y = ise.y AND kollid(i).x > ise.x) AND kollid(i).x <= kunikastini) THEN kollisurm i, 1
                 END IF
                NEXT i
         PUT (40 + kunikastini * 10, 20 + ise.y * 10), Kast2, PSET
         'LINE (40 + kunikastini * 10, 20 + ise.y * 10)-(49 + kunikastini * 10, 29 + ise.y * 10), 14, B
         
         plats(kunikastini, ise.y) = Kast1pilt
kaskastliigub = 1
END IF

IF ise.nagu = 8 THEN
 IF ise.y = 1 THEN EXIT SUB
 IF plats(ise.x, ise.y - 1) <> Kast1pilt THEN EXIT SUB
 
 kunikastini = ise.y + 1
 FOR y1 = ise.y - 2 TO 0 STEP -1
    IF y1 = 0 THEN kunikastini = 1: EXIT FOR
    IF plats(ise.x, y1) = Kast1pilt THEN kunikastini = y1 + 1: EXIT FOR
    IF plats(ise.x, y1) = Kast2pilt THEN kunikastini = y1 + 1: EXIT FOR
 NEXT y1
 IF kunikastini = ise.y + 1 THEN EXIT SUB
        'kasti kohale tÅhi koht
        LINE (40 + ise.x * 10, 20 + ise.y * 10 - 10)-(49 + ise.x * 10, 29 + ise.y * 10 - 10), 0, BF
        plats(ise.x, ise.y - 1) = 0
         'kast uues kohas
                FOR y1 = ise.y - 1 TO kunikastini + 1 STEP -1
                        plats(ise.x, y1) = Etoss3
                NEXT y1
             'kontrollib, kas koll oli all
                FOR i = 1 TO kollidearv
                 IF kollid(i).nagu <> 0 THEN
                    IF ((kollid(i).x = ise.x AND kollid(i).y < ise.y) AND kollid(i).y >= kunikastini) THEN kollisurm i, 1
                 END IF
                NEXT i
         PUT (40 + ise.x * 10, 20 + kunikastini * 10), Kast2, PSET
         'LINE (40 + ise.x * 10, 20 + kunikastini * 10)-(49 + ise.x * 10, 29 + kunikastini * 10), 14, B
         plats(ise.x, kunikastini) = Kast1pilt
kaskastliigub = 1
END IF

IF kaskastliigub = 1 THEN
        FOR i = 400 TO 200 STEP -5
         SOUND i, .03
        NEXT
        END IF


END SUB

SUB sammuke (suund)

IF suund = 2 THEN
        ise.nagu = 2
        IF ise.y = 12 THEN EXIT SUB
        IF plats(ise.x, ise.y + 1) < 100 OR plats(ise.x, ise.y + 1) > 223 THEN ise.suund = 2
        
END IF
IF suund = 4 THEN
        ise.nagu = 4
        IF ise.x = 1 THEN EXIT SUB
        IF plats(ise.x - 1, ise.y) < 100 OR plats(ise.x - 1, ise.y) > 223 THEN ise.suund = 4
        
END IF
IF suund = 6 THEN
        ise.nagu = 6
        IF ise.x = 22 THEN EXIT SUB
        IF plats(ise.x + 1, ise.y) < 100 OR plats(ise.x + 1, ise.y) > 223 THEN ise.suund = 6
        
END IF
IF suund = 8 THEN
        ise.nagu = 8
        IF ise.y = 1 THEN EXIT SUB
        IF plats(ise.x, ise.y - 1) < 100 OR plats(ise.x, ise.y - 1) > 223 THEN ise.suund = 8
END IF


END SUB

SUB showtabel
CLS

DIM ontabelis AS INTEGER

'tabel tÅhjaks
'FOR i% = 1 TO 10
'tabel(i%).nimi = "    -"
'tabel(i%).punktid = 0
'NEXT i%
'DEF SEG = VARSEG(tabel(0))
'BSAVE "pahatabl.usr", VARPTR(tabel(0)), 131
'DEF SEG


DEF SEG = VARSEG(tabel(0))
BLOAD "pahatabl.usr", VARPTR(tabel(0))
DEF SEG

FOR i% = 1 TO 10
IF skoor > tabel(i%).punktid THEN
        FOR j% = 10 TO i% + 1 STEP -1
         tabel(j%).punktid = tabel(j% - 1).punktid
         tabel(j%).nimi = tabel(j% - 1).nimi
        NEXT j%
        tabel(i%).nimi = user.nimi
        tabel(i%).punktid = skoor
        ontabelis = i%
        EXIT FOR
END IF
NEXT i%

DEF SEG = VARSEG(tabel(0))
BSAVE "pahatabl.usr", VARPTR(tabel(0)), 131
DEF SEG

COLOR 27
LOCATE 7, 15
PRINT "PUNKTITABEL"

FOR i% = 1 TO 10
COLOR 25
IF i% = ontabelis THEN COLOR 29
LOCATE i% + 8, 12
PRINT tabel(i%).nimi
LOCATE i% + 8, 23
PRINT USING "#####$"; tabel(i%).punktid
NEXT i%



DO
LOOP UNTIL INKEY$ <> ""

CLS

END SUB

SUB varistamine


'vÑlisÑÑr
'LINE (49, 29)-(270, 150), 25, B
'LINE (48, 28)-(271, 151), 24, B
'LINE (47, 27)-(272, 152), 22, B




IF kaader < 6 THEN
        IF varin = 8 THEN
        LINE (50, 29)-(269, 29), 0
        LINE (49, 28)-(270, 28), 25
        LINE (48, 27)-(271, 27), 24
        LINE (47, 26)-(272, 26), 22
        END IF
       
        IF varin = 2 THEN
        LINE (50, 150)-(269, 150), 0
        LINE (49, 151)-(270, 151), 25
        LINE (48, 152)-(271, 152), 24
        LINE (47, 153)-(272, 153), 22
        END IF


        IF varin = 6 THEN
        LINE (270, 30)-(270, 149), 0
        LINE (271, 29)-(271, 150), 25
        LINE (272, 28)-(272, 151), 24
        LINE (273, 27)-(273, 152), 22
        END IF

        IF varin = 4 THEN
        LINE (49, 30)-(49, 149), 0
        LINE (48, 29)-(48, 150), 25
        LINE (47, 28)-(47, 151), 24
        LINE (46, 27)-(46, 152), 22
        END IF
        
END IF

IF kaader > 5 THEN
LINE (49, 29)-(270, 150), 25, B
LINE (48, 28)-(271, 151), 24, B
LINE (47, 27)-(272, 152), 22, B
LINE (46, 26)-(273, 153), 0, B
END IF

END SUB

