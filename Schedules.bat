@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"

set counter=0
for /f "tokens=* delims=" %%a in (SchedParams.txt) do (
	set /a counter+=1
	if !counter! == 2 set timer=%%a
	if !counter! == 4 set countdown=%%a
	if !counter! == 6 set precision=%%a
	if !counter! == 8 set abrupt=%%a
	if !counter! == 10 set color=%%a
)
set /a timer=%timer%*60+%countdown%
set countdown=%timer%
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
echo Welcome to GreenLocker for scheduling. To use, start by editing the parameters in SchedParams.txt to your liking. Then, copy Schedules.bat as path. Then, press winkey+r and type 'shell:startup'. In the startup folder, make a new shortcut with the path you copied. That's it. Now this batch program will run every time you log into your computer. If this program doesn't run immediately after logging in, be patient; It will run eventually. The speed that this program opens depends on the speed of your computer. You can also use Task Scheduler if you know how to have even more control over when you want this program to run.
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