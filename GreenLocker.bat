@echo off
setlocal enabledelayedexpansion
set precision=1
set abrupt=0
set color=2f
color %color%

set /p nothing="Welcome to GreenLocker. Using this batch file, you can easily set a timer for as long as you want, and your computer will automatically shut down. This program also allows various customizability options. This started as a project to help the environment; using computers less means charging them less leading to less energy waste. Enter R to resume a paused timer or enter anything else to start a new one (the paused timer will be erased):"
if /i "%nothing%"=="r" goto read

:mi
cls
set /p timer="Enter time in minutes for timer. PLEASE ENTER A WHOLE NUMBER. ADVANCED COMMANDS: enter 'se' to type in seconds instead or enter 'pr' to enter countdown precision or 'ab' to enable abrupt mode or 'da' to disable abrupt mode or 'co' to change color."
if "%timer%"=="se" goto se
if "%timer%"=="pr" goto pr
if "%timer%"=="ab" goto ab
if "%timer%"=="da" goto da
if "%timer%"=="co" goto co
set /a timer=timer * 60
set countdown=%timer%
goto countdown

:se
cls
set /p timer="Enter time in seconds for timer. PLEASE ENTER A WHOLE NUMBER. ADVANCED COMMANDS: enter 'mi' to return to typing in minutes instead or enter 'pr' to enter countdown precision or 'ab' to enable abrupt mode or 'da' to disable abrupt mode or 'co' to change color."
if "%timer%"=="se" goto se
if "%timer%"=="pr" goto pr
if "%timer%"=="ab" goto ab
if "%timer%"=="da" goto da
if "%timer%"=="co" goto co
set countdown=%timer%
goto countdown

:pr
cls
set /p precision="Enter precision of countdown. countdown is timer that displays on screen when timer starts. Precision is how many seconds until timer updates, and default is 1. This can be used to adjust resources used. After typing, you will enter minutes for timer. PLEASE TYPE A WHOLE NUMBER."
goto mi

:ab
cls
set abrupt=1
set /p nothing="Abrupt mode is enabled. After timer is up, computer will forcefully shut down without prompting to save files. Enter anything to continue and enter minutes for timer."
goto mi

:da
cls
set abrupt=0
set /p nothing="Abrupt mode is disabled. After timer is up, computer will shut down with prompt to save files. Abrupt mode is disabled by default. Enter anything to continue and enter minutes for timer."
goto mi

:co
cls
set /p color="Type a 2-digit hexadecimal number for your color. First digit is background color and second digit is text color. Make sure both digits are different. Please set each digit to one of these hexadecimal digits: 0=black, 1=blue, 2=green, 3=aqua, 4=red, 5=purple, 6=orange, 7=white, 8=gray, 9=light blue, a=light green, b=light aqua, c=light red, d=light purple, e=light yellow, f=bright white. Default is 2f. After entering, color will change and you will type minutes for timer."
color %color%
goto mi

:read
set counter=0
for /f "tokens=* delims=" %%a in (PauseParams.txt) do (
	set /a counter+=1
	if !counter! == 1 set timer=%%a
	if !counter! == 2 set countdown=%%a
	if !counter! == 3 set precision=%%a
	if !counter! == 4 set abrupt=%%a
	if !counter! == 5 set color=%%a
)

color %color%

:countdown
(
echo %timer%
echo %countdown%
echo %precision%
echo %abrupt%
echo %color%
) > PauseParams.txt

cls
echo Time left: %countdown%/%timer% seconds. Computer will shut down after timer is up. Close window before timer is up to pause or cancel.
if %countdown% LEQ 60 echo 1 MINUTE WARNING
if %countdown% LEQ 30 echo 30 SECOND WARNING
if %countdown% LEQ 10 echo 10 SECOND WARNING
if %countdown% LEQ 5 echo 5 SECOND WARNING
if %countdown% LEQ 0 goto decider
set /a countdown=countdown - %precision%
timeout /t %precision% /nobreak >nul
goto countdown

:decider
if %abrupt%==0 goto shutdown

:shutabrupt
shutdown /s /f /t 0

:shutdown
shutdown /s /t 0