@echo off
chcp 65001
color a
cls

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
	echo ###############################################################
	echo "  _______             _        _________  _______            "
	echo " (  ____ \ |\     /| ( \    /| \__   __/ (  ___  ) |\     /| "
	echo " | (    \/ ( \   / ) |  \  ( |    ) (    | (   ) | ( \   / ) "
	echo " | (_____   \ (_) /  |   \ | |    | |    | (___) |  \ (_) /  "
	echo " (_____  )   \   /   | (\ \) |    | |    |  ___  |   ) _ (   "
	echo "       ) |    ) (    | | \   |    | |    | (   ) |  / ( ) \  "
	echo " /\____) |    | |    | )  \  |    | |    | )   ( | ( /   \ ) "
	echo " \_______/    \_/    |/    \_|    |_|    |/     \| |/     \| "
	echo "                                                             "
	echo ###############################################################
	echo.
  	echo Yönetici izni bekleniyor.
	echo Scripte devam etmek istiyorsanız lütfen açılacak pencerede 'Evet' tuşuna basın.
	echo UAC Sanallaştırması devre dışı ise Evet/Hayır penceresi çıkmayabilir, direkt scripte devam edebilirsiniz.
	REM timeout /T 7 /NOBREAK
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------
@echo off
chcp 65001
color a
cls
:menu
cls
echo ###############################################################
echo "  _______             _        _________  _______            "
echo " (  ____ \ |\     /| ( \    /| \__   __/ (  ___  ) |\     /| "
echo " | (    \/ ( \   / ) |  \  ( |    ) (    | (   ) | ( \   / ) "
echo " | (_____   \ (_) /  |   \ | |    | |    | (___) |  \ (_) /  "
echo " (_____  )   \   /   | (\ \) |    | |    |  ___  |   ) _ (   "
echo "       ) |    ) (    | | \   |    | |    | (   ) |  / ( ) \  "
echo " /\____) |    | |    | )  \  |    | |    | )   ( | ( /   \ ) "
echo " \_______/    \_/    |/    \_|    |_|    |/     \| |/     \| "
echo "                                                             "
echo ###############################################################
echo.
echo [1] - Hosts dosyasını yedekle
echo [2] - Hosts dosyasını güncelle (Kaynak: ugurhosts.txt from GitHub by ugurkrdmr)
echo [3] - Hosts dosyasını yedekten geri yükle
echo [4] - Hosts dosyasını sıfırla
echo [5] - Terminali kapat
echo.
set /p m= Yapmak istediğiniz işlemin numarasını yazın (1-2-3-4-5): 
if %m%==1 goto HOSTBACKUP
if %m%==2 goto HOSTUPDATE
if %m%==3 goto HOSTRELOAD
if %m%==4 goto HOSTRESET
if %m%==5 exit

:HOSTBACKUP
copy "%windir%\System32\Drivers\Etc\hosts" "%windir%\System32\Drivers\Etc\hosts.bak"

cls
echo ###############################################################
echo "  _______             _        _________  _______            "
echo " (  ____ \ |\     /| ( \    /| \__   __/ (  ___  ) |\     /| "
echo " | (    \/ ( \   / ) |  \  ( |    ) (    | (   ) | ( \   / ) "
echo " | (_____   \ (_) /  |   \ | |    | |    | (___) |  \ (_) /  "
echo " (_____  )   \   /   | (\ \) |    | |    |  ___  |   ) _ (   "
echo "       ) |    ) (    | | \   |    | |    | (   ) |  / ( ) \  "
echo " /\____) |    | |    | )  \  |    | |    | )   ( | ( /   \ ) "
echo " \_______/    \_/    |/    \_|    |_|    |/     \| |/     \| "
echo "                                                             "
echo ###############################################################
echo.
echo Hosts dosyası başarıyla yedeklendi.
echo.
echo [1] - Ana menüye dön
echo [2] - Terminali kapat
echo.
set /p m= Yapmak istediğiniz işlemin numarasını yazın (1-2): 
if %m%==1 goto menu
if %m%==2 exit

:HOSTUPDATE
curl -o "C:\Users\%USERNAME%\AppData\Local\Temp\ugurhosts.txt" https://raw.githubusercontent.com/ugurkrdmr/hosts-ad-block/main/myhosts.txt
attrib -R %windir%\System32\Drivers\etc\hosts
copy /-Y /Y "C:\Users\%USERNAME%\AppData\Local\Temp\ugurhosts.txt" "%windir%\System32\Drivers\Etc\hosts"
attrib +R %windir%\System32\Drivers\etc\hosts
del "C:\Users\%USERNAME%\AppData\Local\Temp\ugurhosts.txt"

cls
echo ###############################################################
echo "  _______             _        _________  _______            "
echo " (  ____ \ |\     /| ( \    /| \__   __/ (  ___  ) |\     /| "
echo " | (    \/ ( \   / ) |  \  ( |    ) (    | (   ) | ( \   / ) "
echo " | (_____   \ (_) /  |   \ | |    | |    | (___) |  \ (_) /  "
echo " (_____  )   \   /   | (\ \) |    | |    |  ___  |   ) _ (   "
echo "       ) |    ) (    | | \   |    | |    | (   ) |  / ( ) \  "
echo " /\____) |    | |    | )  \  |    | |    | )   ( | ( /   \ ) "
echo " \_______/    \_/    |/    \_|    |_|    |/     \| |/     \| "
echo "                                                             "
echo ###############################################################
echo.
echo Hosts dosyası başarıyla güncellendi.
echo.
echo [1] - Ana menüye dön
echo [2] - Terminali kapat
echo.
set /p m= Yapmak istediğiniz işlemin numarasını yazın (1-2): 
if %m%==1 goto menu
if %m%==2 exit

:HOSTRELOAD
attrib -R %windir%\System32\Drivers\etc\hosts
del "%windir%\System32\Drivers\Etc\hosts"
ren "%windir%\System32\Drivers\Etc\hosts.bak" hosts
attrib +R %windir%\System32\Drivers\etc\hosts

cls
echo ###############################################################
echo "  _______             _        _________  _______            "
echo " (  ____ \ |\     /| ( \    /| \__   __/ (  ___  ) |\     /| "
echo " | (    \/ ( \   / ) |  \  ( |    ) (    | (   ) | ( \   / ) "
echo " | (_____   \ (_) /  |   \ | |    | |    | (___) |  \ (_) /  "
echo " (_____  )   \   /   | (\ \) |    | |    |  ___  |   ) _ (   "
echo "       ) |    ) (    | | \   |    | |    | (   ) |  / ( ) \  "
echo " /\____) |    | |    | )  \  |    | |    | )   ( | ( /   \ ) "
echo " \_______/    \_/    |/    \_|    |_|    |/     \| |/     \| "
echo "                                                             "
echo ###############################################################
echo.
echo Hosts dosyası başarıyla yedekten geri yüklendi.
echo.
echo [1] - Ana menüye dön
echo [2] - Terminali kapat
echo.
set /p m= Yapmak istediğiniz işlemin numarasını yazın (1-2): 
if %m%==1 goto menu
if %m%==2 exit

:HOSTRESET

cls
echo ###############################################################
echo "  _______             _        _________  _______            "
echo " (  ____ \ |\     /| ( \    /| \__   __/ (  ___  ) |\     /| "
echo " | (    \/ ( \   / ) |  \  ( |    ) (    | (   ) | ( \   / ) "
echo " | (_____   \ (_) /  |   \ | |    | |    | (___) |  \ (_) /  "
echo " (_____  )   \   /   | (\ \) |    | |    |  ___  |   ) _ (   "
echo "       ) |    ) (    | | \   |    | |    | (   ) |  / ( ) \  "
echo " /\____) |    | |    | )  \  |    | |    | )   ( | ( /   \ ) "
echo " \_______/    \_/    |/    \_|    |_|    |/     \| |/     \| "
echo "                                                             "
echo ###############################################################
echo.

echo DİKKAT! Bu işlem hosts dosyası içerisindeki tüm bağlantı yönlendirmelerini silecektir, eğer ki yedeğiniz yoksa yönlendirmeleri elle en baştan yapmanız gerekir.
echo.
set /p m= İşleme devam etmek için 'y', çıkmak için 'n' ana menüye dönmek için 'm' yazınız : 
if %m%==y goto GORESET
if %m%==n exit
if %m%==m goto menu

:GORESET
attrib -R %windir%\System32\Drivers\etc\hosts
del %windir%\System32\Drivers\Etc\hosts
nul > %windir%\System32\Drivers\Etc\hosts
attrib +R %windir%\System32\Drivers\etc\hosts

cls
echo ###############################################################
echo "  _______             _        _________  _______            "
echo " (  ____ \ |\     /| ( \    /| \__   __/ (  ___  ) |\     /| "
echo " | (    \/ ( \   / ) |  \  ( |    ) (    | (   ) | ( \   / ) "
echo " | (_____   \ (_) /  |   \ | |    | |    | (___) |  \ (_) /  "
echo " (_____  )   \   /   | (\ \) |    | |    |  ___  |   ) _ (   "
echo "       ) |    ) (    | | \   |    | |    | (   ) |  / ( ) \  "
echo " /\____) |    | |    | )  \  |    | |    | )   ( | ( /   \ ) "
echo " \_______/    \_/    |/    \_|    |_|    |/     \| |/     \| "
echo "                                                             "
echo ###############################################################
echo.
echo Hosts dosyası başarıyla sıfırlandı.
echo.
echo [1] - Ana menüye dön
echo [2] - Terminali kapat
echo.
set /p m= Yapmak istediğiniz işlemin numarasını yazın (1-2): 
if %m%==1 goto menu
if %m%==2 exit