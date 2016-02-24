echo off

:: Clean terminal
cls

echo ##################
echo.
echo END YOUR WORK
echo.
echo ##################
echo.
echo This tool will commit last changes in your current branch, merge branch into Maintenance and finally update to default.
echo.
echo No push will be execute.
echo.
echo ##################
echo.
echo.
echo.

goto run

:error
	echo.
    echo "Error: current branch should not be default and maintenance."
    pause
	
:run

	:: set local username
	for /f "delims=" %%a in ('hg config -u ui.username') do @set username=%%a

	:: set local repo
	for /f "delims=" %%a in ('hg config -u paths.default') do @set currentrepo=%%a

	::pull
	hg pull --verbose "%currentrepo%"

	::set currentbranch var
	for /f "delims=" %%a in ('hg branch') do @set currentbranch=%%a

	::if current branch is "default" or "Maintenance" jump to error
	if "%currentbranch%" == "default" goto error
	if "%currentbranch%" == "Maintenance" goto error
	
	echo.
	echo.
	echo -------------------------
	echo.
    echo Current branch is %currentbranch% 
	echo.
	echo -------------------------
	
	:: Ask confirmation
	Choice /M "Are you sure you want to continue"
	If Errorlevel 2 Goto abort
	If Errorlevel 1 Goto runConfirmed

	:runConfirmed
	
    ::pull
    hg pull --verbose --update --config ui.merge=internal:merge "%currentrepo%"

    ::update to last commit on current branch
    hg update -t beyondcompare4

    ::commit
    hg commit --verbose "--message= fixed" --user "%username%"

    ::set id revision
    for /f "delims=" %%a in ('hg identify --num') do @set idrevision=%%a

    ::update to maintenance
    hg update --config ui.merge=internal:merge --rev Maintenance --check

    ::merge branch into maintenance
    hg merge --tool :merge --verbose "%idrevision%" -t beyondcompare4

    ::commit
    hg commit --verbose "--message= Merge" --user "%username%"

    ::update to default
    hg update --config ui.merge=internal:merge --rev default --check
	echo.
	echo.
	echo.
	echo ##################
	echo.
	echo Done!
	echo You are now in default branch and you just need to push you last changes
	echo.
	echo ##################
	echo.
	
	pause

	exit

:abort
    echo "Operation aborted."
    pause
	exit
