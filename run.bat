SET GITHUB_ACCOUNT=semichin
SET WS_DIR=workspace
SET REPO_NAME=Title_Validation_E2E
SET APP_VERSION=1.1
SET MAIN_CLASS=core.Selenium

IF "%JAVA_HOME%" == "" GOTO EXIT_JAVA
ECHO Java installed
IF "%M2%" == "" GOTO EXIT_MVN
ECHO Maven installed
CALL git --version > nul 2>&1
IF NOT %ERRORLEVEL% == 0 GOTO EXIT_GIT
ECHO Git installed
 
GOTO NEXT
 
:NEXT
IF NOT EXIST C:\%WS_DIR% GOTO NO_WORKSPACE
IF EXIST C:\%WS_DIR%\%REPO_NAME% RMDIR /S /Q C:\%WS_DIR%\%REPO_NAME%
CD C:\%WS_DIR%
git clone https://github.com/%GITHUB_ACCOUNT%/%REPO_NAME%.git
CD %REPO_NAME%
SLEEP 2
CALL mvn clean site test -Dtest=AllTests -Dbuild.version="1.1"
ECHO.
ECHO Executing Java programm ...
java -cp C:\%WS_DIR%\%REPO_NAME%\target\%REPO_NAME%-%APP_VERSION%.jar%MAIN_CLASS%
GOTO END
 
:EXIT_JAVA
ECHO No Java installed
GOTO END
:EXIT_MVN
ECHO No Maven installed
GOTO END
:EXIT_GIT
ECHO No Git installed
GOTO END
:NO_WORKSPACE
ECHO %WS_DIR% is not exists
GOTO END
:END
CD\
