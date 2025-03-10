@echo off
setlocal enabledelayedexpansion

:: Define paths for files
set NUMBER_FILE=number.txt
set MESSAGE_FILE=message.txt
set LOG_FILE=logs.txt

:: Create log file
echo Logging started at %date% %time% > %LOG_FILE%

:: Ensure number.txt exists
if not exist %NUMBER_FILE% (
    echo %NUMBER_FILE% does not exist. Creating file...
    echo. > %NUMBER_FILE%
)

:: Ensure message.txt exists
if not exist %MESSAGE_FILE% (
    echo %MESSAGE_FILE% does not exist. Creating file...
    echo. > %MESSAGE_FILE%
)

:: Start application with delay
echo Launching app...
timeout /t 2 > nul
adb shell am start -n com.gogii.textplus/com.nextplus.android.activity.ComposeActivity
timeout /t 3 > nul

:: Process each number in number.txt
for /f "delims=" %%n in (%NUMBER_FILE%) do (
    set "number=%%n"
    echo Typing number: !number!
    adb shell input text "!number!"
    adb shell input keyevent 66  :: Press Enter
    timeout /t 1 > nul

    :: Process each line in message.txt
    for /f "delims=" %%m in (%MESSAGE_FILE%) do (
        set "message=%%m"
        echo Typing message: !message!
        
        :: Type each word with space using keyevent 62
        for %%w in (!message!) do (
            adb shell input text "%%w"
            adb shell input keyevent 62  :: Space
            timeout /t 0.5 > nul
        )

        adb shell input keyevent 66  :: Press Enter (Send)
        timeout /t 1 > nul
        adb shell input tap 675 764  :: Click send button

        echo Sent message to !number!: !message! >> %LOG_FILE%
    )
)

:: Developer credit in hacker style
echo.
echo [32m██████╗░███████╗░██████╗░██╗░░░██╗
echo ██╔══██╗██╔════╝██╔════╝░██║░░░██║
echo ██████╔╝█████╗░░██║░░██╗░██║░░░██║
echo ██╔═══╝░██╔══╝░░██║░░╚██╗██║░░░██║
echo ██║░░░░░███████╗╚██████╔╝╚██████╔╝
echo ╚═╝░░░░░╚══════╝░╚═════╝░░╚═════╝░
echo Developed by: Pjɗw Sʌzzʌɗ [0m

echo Developed by: Pjɗw Sʌzzʌɗ >> %LOG_FILE%

echo Logging finished at %date% %time% >> %LOG_FILE%
echo All operations completed.

:: Keep window open
cmd /k
