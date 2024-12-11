# Hackers World 2

See repositoorium sisaldab arvutimängu "Hackers World II" lähtekoodi ja EXE-faili. Mäng on tehtud Sulev ja Urmas Reisbergi poolt 2000. aastal ja on järg arvutimängule "Hackers World".

Hackers Worldi I osa on saadaval [eraldi repos](https://github.com/SulevR/hackersworld1).

## Mängu reklaam
Kas sa oled kunagi unistanud 100% täiuslikust mängust?

Kas oled unistanud 100% naljakast mängust?

Kas oled lootnud leida mõtlemist ja oskusi nõudvat mängu?

Kas oled unistanud mängust, mis oleks mõeldud kõrgele IQ-le?

SIIT SA SELLIST MÄNGU EI LEIA!

Aga meil on sulle lohutuseks pakkuda
Hackers World II.

## Kuidas Sõnumileht seda mängu 17. juunil 2000. a tutvustas

Eestimaal on tegelikult juba iidsetest aegadest alates arvutimänge tehtud. Kodumaiseid tegijaid tuleb ikka toetada.

Siin on ühed vennikesed valmis saanud mänguga, mis kannab kõlavat nime Hackers World. Tegu on häkkeri raske elu simulatsiooniga. Mängude eliiti ta muidugi ei kuulu ja kõigi aegade top 100-sse samuti vaevalt ronib, aga muidu päris muhe kraam. Lisaks täidab ta tänuväärset ülesannet desinformeerida avalikkust sellest, kuidas näeb välja häkkeri päev.

## Eeltingimus mängimiseks

Mängu on lubatud mängida üksnes juhul, kui oled nõus järgnevaga:

*Olen teadlik, et Hackers World on 100% väljamõeldis ja selles ei ole kujutatud ühtki reaalselt tegutsevat isikut ega ettevõtet. Mitte ühtki mängus leiduvat sõna ega lauset ei tule võtta tõena, solvamise ega pahatahtliku mahategemisena. Luban, et ei esita mängu autoritele mingeid pretensioone ega kaebusi. Juhul kui mäng mulle ei meeldi, on mul võimalus seda mitte mängida.*

*Hackers World on arvutimäng, mis on levitatav täiesti tasuta. Mängu eest tasu küsimine on ebaseaduslik.*

## Kuidas mängida

Mäng on loodud DOS keskkonna jaoks, arvestades omaaegseid arvutite jõudlusi, nii et tänapäeval on võimalik seda mängida mõnda DOS-emulaatorit, näiteks [DOSBox](https://www.dosbox.com), kasutades. Lühike juhis selleks on järgmine:

1. Tõmba siinne repo endale arvutisse, näiteks kausta `"~/Downloads/hackers world 2"`. Selleks vajuta githubis rohelist nuppu "Code" ja vali "Download ZIP".
2. Paigalda endale [DOSBox](https://www.dosbox.com)
3. Käivita DOSBox
4. Mounti see "Hackers world" mängu kaust DOSBoxis külge kui kataloog "C:\". Selleks kirjuta DOSBox konsoolis: `mount c "~/Downloads/hackers world 2"` (jah, me teame, et seal aknas ei tööta keerulised märgid samade klahvide alt, mis muidu - tuleb katsetada. Kui viitsid rohkem jännata, siis [https://www.dosbox.com/DOSBoxManual.html#KeyboardLayout](https://www.dosbox.com/DOSBoxManual.html#KeyboardLayout) peal on õpetus, kuidas saada teisi klaviatuuri paigutusi tööle). Ilmuma peaks teade stiilis `Drive C is mounted as local directory /.../Downloads/hackers world 2/`
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

## Trikid ja nipid

* Esmalt tasuks tutvuda mängu endaga kaasa tulnud põhjaliku [READMEga](LOE_MIND.txt).
* Üldiselt käib mäng klaviatuuri ja hiirega. Hiirt kasuta eelkõige õiges kohas klikkimiseks. Kui hiir vahepeal ära kaob, siis tavaliselt aitab, kui vajutada ESC ja vahel ka ENTER.
* Kolm piiksu tähendab seda, et sulle on saabunud kiri.
* Ära unusta mängu õigete kohtade peal salvestada.

### Mõned DOSBox trikid ja nipid

* Täisekraani režiimi ja tagasi saad nupukombinatsiooniga ALT+ENTER (Macis Option+ENTER)
* Protsessori emulaator ei tööta iga koha peal päris sama kiiresti kui peaks - siis saad kiirust juurde panna või vähemaks võtta, kasutades lühiklahve CTRL+F11 ja CTRL+F12 (Macis Fn+Control+F11 ja Fn+Control+F12)
* Muid lühiklahve vaata [https://www.dosbox.com/wiki/Special_Keys](https://www.dosbox.com/wiki/Special_Keys)

## Kui jääd mõne missiooniga jänni

Eks fännid aeg-ajalt meile ikka kirjutasid ja palusid vihjeid, kuidas mängus edasi pääseda. Kui sinulgi tekib sama probleem, siis vaata vihjeid siit.

Hackers World 2 missioonide vihjed:

* [Missioon 1](vihjed/abi_hw2_1.md)
* [Missioon 3](vihjed/abi_hw2_3.md)
* [Missioon 4](vihjed/abi_hw2_4.md)
* [Missioon 5](vihjed/abi_hw2_5.md)
* [Missioon 6](vihjed/abi_hw2_6.md)
* [Missioon 7](vihjed/abi_hw2_7.md)
* [Missioon 9](vihjed/abi_hw2_9.md)


## Lähtekood

Selles repositooriumis asub ka mängu lähtekood. Põhifaili lähtekood asub failis [hwc/LAHTEKOOD.BAS](hwc/LAHTEKOOD.BAS) ja alam-mängu "Paharet" lähtekood failis [paharet/PAHARET_LAHTEKOOD.BAS](paharet/PAHARET_LAHTEKOOD.BAS). Tegemist on QBasic programmidega, seega idee pooleks peaks neid saama QBasicust jooksutada, aga me pole seda ise enam pärast mängu avaldamist proovinud. Me ei ole päris 100% kindlad, et absoluutselt kogu vajalik kood on olemas.
