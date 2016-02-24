@echo off

:: Clean terminal
cls

echo ##################
echo.
echo START YOUR WORK
echo.
echo ##################
echo.
echo This tool will create a new branch, started from default, with the name you choose. 
echo.
echo No commit or push will be execute
echo.
echo #############
echo.
echo.
set /p idtp="Enter branch name: "
echo.
echo -------------------------
echo.
echo.

:: Ask confirmation
Choice /M "Are you sure you want to create this branch: %idtip%"
If Errorlevel 2 Goto abort
If Errorlevel 1 Goto runConfirmed

:runConfirmed

	:: set locale username
	for /f "delims=" %%a in ('hg config -u ui.username') do @set username=%%a

	:: set local repo
	for /f "delims=" %%a in ('hg config -u paths.default') do @set currentrepo=%%a

	:: pull
	hg pull --verbose "%currentrepo%"

	:: update to default
	hg update --config ui.merge=internal:merge --rev default --check

	:: create new branch with passed ID
	hg branch --force "%idtp%"

	::commit
	hg commit --verbose "--message= branch opened" --user "%username%"

	echo.
	echo.
	echo.
	echo ##################
	echo.
	echo Branch successfully created. Enjoy your coding!
	echo.
	echo ##################
	echo.

	pause
	exit
	
:abort
    echo "Operation aborted."
    pause
	exit

