@ECHO OFF
REM script d'outils au tri de scans
REM imgres *.jpg;*.png ./rd 2000
REM -----------------------------------------------------------------------------------------------
SET scriptver="1.4"
REM -----------------------------------------------------------------------------------------------
:debut
TITLE Menu de selection des outils
COLOR 07
SET ERRORLEVEL=
CLS
ECHO.
ECHO ...............................................
ECHO. Scans Multi Tools
ECHO ...............................................
ECHO.
ECHO 1 - Creation de dossiers
ECHO 2 - Creation de folder.jpg
ECHO.
ECHO 3 - Compression des dossiers en CBZ
ECHO 4 - Decompression des archives vers des dossiers
ECHO.
ECHO 5 - ZIP en CBZ
ECHO 6 - CBZ en ZIP
ECHO.
ECHO 7 - Creation de dossiers par nom de fichiers
ECHO.
ECHO.
ECHO S - suppression du script
ECHO.
ECHO Q - Quitter
ECHO.
CHOICE /C 1234567SQ 

SET CHXMENU=%ERRORLEVEL%
IF %CHXMENU% EQU 1 SET CHX=creadossier
IF %CHXMENU% EQU 2 SET CHX=jpg
IF %CHXMENU% EQU 3 SET CHX=archicbz
IF %CHXMENU% EQU 4 SET CHX=dearchizip
IF %CHXMENU% EQU 5 SET CHX=zipcbz
IF %CHXMENU% EQU 6 SET CHX=cbzzip
IF %CHXMENU% EQU 7 SET CHX=creadossierbycbz
IF %CHXMENU% EQU 8 SET CHX=suppression
IF %CHXMENU% EQU 9 SET CHX=quit
GOTO %CHX%
REM -----------------------------------------------------------------------------------------------
:creadossier
SET ERRORLEVEL=
CLS
ECHO Type de dossiers :
ECHO.
ECHO 1 - Chapitres
ECHO 2 - Volumes
ECHO.
ECHO R - Retour
ECHO.
CHOICE /C 12R 

SET CHXMENU=%ERRORLEVEL%
IF %CHXMENU% EQU 1 SET CHX=creachap
IF %CHXMENU% EQU 2 SET CHX=creavol
IF %CHXMENU% EQU 3 SET CHX=debut
GOTO %CHX%
REM -----------------------------------------------------------------------------------------------
:creachap
CLS
ECHO.
ECHO.
ECHO.
Set /P nbchapitre=nombre de chapitres : || GOTO erreurnbdossier
IF %nbchapitre% LSS 10 GOTO c1a9
IF %nbchapitre% LSS 100 GOTO c1a99
IF %nbchapitre% LSS 1000 GOTO c1a999
GOTO erreurnbdossier
REM -----------------------------------------------------------------------------------------------
:c1a9
FOR /L %%i IN (1,1,%nbchapitre%) DO mkdir "Ch. %%i"
CLS
ECHO.
ECHO.
ECHO.
ECHO %nbchapitre% dossiers crees
ECHO.
ECHO.
ECHO.
REM TIMEOUT 2
GOTO debut
REM -----------------------------------------------------------------------------------------------
:c1a99
FOR /L %%i IN (1,1,9) DO mkdir "Ch. 0%%i"
FOR /L %%i IN (10,1,%nbchapitre%) DO mkdir "Ch. %%i"
CLS
ECHO.
ECHO.
ECHO.
ECHO %nbchapitre% dossiers crees
ECHO.
ECHO.
ECHO.
REM TIMEOUT 2
GOTO debut
REM -----------------------------------------------------------------------------------------------
:c1a999
FOR /L %%i IN (1,1,9) DO mkdir "Ch. 00%%i"
FOR /L %%i IN (10,1,99) DO mkdir "Ch. 0%%i"
FOR /L %%i IN (100,1,%nbchapitre%) DO mkdir "Ch. %%i"
CLS
ECHO.
ECHO.
ECHO.
ECHO %nbchapitre% dossiers crees
ECHO.
ECHO.
ECHO.
REM TIMEOUT 2
GOTO debut
REM -----------------------------------------------------------------------------------------------
:creavol
CLS
ECHO.
ECHO.
ECHO.
Set /P nbdossier=nombre de volume : || GOTO erreurnbdossier
IF %nbdossier% LSS 10 GOTO v1a9
IF %nbdossier% LSS 100 GOTO v1a99
IF %nbdossier% LSS 1000 GOTO v1a999
GOTO erreurnbdossier
REM -----------------------------------------------------------------------------------------------
:v1a9
FOR /L %%j IN (1,1,%nbdossier%) DO mkdir "Vol. %%j"
CLS
ECHO.
ECHO.
ECHO.
ECHO %nbdossier% dossiers crees
ECHO.
ECHO.
ECHO.
REM TIMEOUT 2
GOTO debut
REM -----------------------------------------------------------------------------------------------
:v1a99
FOR /L %%j IN (1,1,9) DO mkdir "Vol. 0%%j"
FOR /L %%j IN (10,1,%nbdossier%) DO mkdir "Vol. %%j"
CLS
ECHO.
ECHO.
ECHO.
ECHO %nbdossier% dossiers crees
ECHO.
ECHO.
ECHO.
REM TIMEOUT 2
GOTO debut
REM -----------------------------------------------------------------------------------------------
:v1a999
FOR /L %%j IN (1,1,9) DO mkdir "Vol. 00%%j"
FOR /L %%j IN (10,1,99) DO mkdir "Vol. 0%%j"
FOR /L %%j IN (100,1,%nbdossier%) DO mkdir "Vol. %%j"
CLS
ECHO.
ECHO.
ECHO.
ECHO %nbdossier% dossiers crees
ECHO.
ECHO.
ECHO.
REM TIMEOUT 2
GOTO debut
REM -----------------------------------------------------------------------------------------------
:erreurnbdossier
CLS
ECHO.
ECHO.
ECHO.
ECHO Pas de nombre de dossiers specifie
ECHO.
ECHO.
ECHO.
TIMEOUT 2
GOTO debut
REM -----------------------------------------------------------------------------------------------
:jpg
CLS
IF EXIST folder.jpg (
    GOTO jpgexiste
 ) ELSE ( 
    GOTO jpgcopy
 )
REM -----------------------------------------------------------------------------------------------
:jpgcopy
COPY /y NUL folder.jpg >NUL
CLS
COLOR 20
ECHO.
ECHO.
ECHO.
ECHO folder.jpg cree
ECHO.
ECHO.
ECHO.
TIMEOUT 2
GOTO debut
REM -----------------------------------------------------------------------------------------------
:jpgexiste
CLS
COLOR 30
ECHO.
ECHO.
ECHO.
ECHO folder.jpg existe deja
ECHO.
ECHO.
ECHO.
TIMEOUT 2
GOTO debut
REM -----------------------------------------------------------------------------------------------
:archicbz
for /d %%X in (*) do 7z a "%%X.zip" "%%X\" -sdel
GOTO zipcbz
REM -----------------------------------------------------------------------------------------------
:dearchizip
REM REN *.cbz *.zip
for %%i in (*.cbz) do 7z e "%%i" * -o"%%~ni"
DEL *.cbz
GOTO debut
REM -----------------------------------------------------------------------------------------------
:zipcbz
REN *.zip *.cbz
GOTO debut
REM -----------------------------------------------------------------------------------------------
:cbzzip
REN *.cbz *.zip
GOTO debut
REM -----------------------------------------------------------------------------------------------
:creadossierbycbz
FOR %%G IN (*.cbz) DO (
md "%%~nG"
move "%%G" "%%~nG\" )
REM ~n dans %~nG permet d'extraire le nom du fichier sans son extension
GOTO debut
REM -----------------------------------------------------------------------------------------------
:suppression
del ScanMultiTools%scriptver%.cmd
REM -----------------------------------------------------------------------------------------------
:quit
EXIT