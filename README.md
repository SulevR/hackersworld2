# Hackers World 2

See repositoorium sisaldab arvutimängu "Hackers World II" lähtekoodi ja EXE-faili. Mäng on tehtud Sulev ja Urmas Reisbergi poolt 2000. aastal ja on järg arvutimängule "Hackers World".

## Kuidas mängida

Mäng on loodud DOS keskkonna jaoks, arvestades omaaegseid arvutite jõudlusi, nii et tänapäeval on võimalik seda mängida mõnda DOS-emulaatorit, näiteks [DOSBox](https://www.dosbox.com), kasutades. Lühike juhis selleks on järgmine:

1. Tõmba siinne repo endale arvutisse, näiteks kausta `"~/Downloads/hackers world 2"`
2. Paigalda endale DOSBox
3. Käivita DOSBox
4. Mounti see "Hackers world" mängu kaust DOSBoxis külge kui kataloog "C:\". Selleks kirjuta DOSBox konsoolis: `mount c "~/Downloads/hackers world 2"` (jah, me teame, et seal aknas ei tööta keerulised märgid samade klahvide alt, mis muidu - tuleb katsetada). Ilmuma peaks teade stiilis `Drive C is mounted as local directory /.../Downloads/hackers world 2/`
5. Navigeeri DOSBox konsoolil C-kettale: `C:\`
6. Kui paned nüüd DOSBox konsoolil `dir`, peaks ta näitama vastava kausta sisu, mis näeb välja umbes selline:
```
	.       <DIR>
	..      <DIR>
	HWC     <DIR>
	PAHARET <DIR>
	HW2     EXE
	jne
```
7. Käivita mäng, trükkides DOSBox konsoolile `hw2.exe` ja vajuta ENTER.
8. 

## Trikid ja nipid

Esmalt tasuks tutvuda mängu endaga kaasa tulnud põhjaliku [READMEga](LOE_MIND.txt).

Üldiselt käib mäng klaviatuuri ja hiirega. Hiirt kasuta eelkõige õiges kohas klikkimiseks. Kui hiir vahepeal ära kaob, siis tavaliselt aitab, kui vajutada ESC ja vahel ka ENTER.

Kolm piiksu tähendab seda, et sulle on saabunud kiri.

Ära unusta mängu õigete kohtade peal salvestada.

### Mõned DOSBox trikid ja nipid

* Täisekraani režiimi ja tagasi saad nupukombinatsiooniga ALT+ENTER (Macis Option+ENTER)
* Protsessori emulaator ei tööta iga koha peal päris sama kiiresti kui peaks - siis saad kiirust juurde panna või vähemaks võtta, kasutades lühiklahve CTRL+F11 ja CTRL+F12 (Macis Fn+Control+F11 ja Fn+Control+F12)
* Muid lühiklahve vaata [https://www.dosbox.com/wiki/Special_Keys](https://www.dosbox.com/wiki/Special_Keys)

## Lähtekood

Selles repositooriumis asub ka mängu lähtekood. Põhifaili lähtekood asub failis [hwc/LAHTEKOOD.BAS]() ja alam-mängu "Paharet" lähtekood failis [paharet/PAHARET_LAHTEKOOD.BAS](). Tegemist on QBasic programmidega, seega idee pooleks peaks neid saama QBasicust jooksutada, aga me pole seda ise enam pärast mängu avaldamist proovinud.

## Autorid

Sulev Reisberg ja Urmas Reisberg