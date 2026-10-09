@echo off
setlocal

:: Usage: .\sha256.bat <project> <version> [github_user]

set "PROJECT=%~1"
set "VERSION=%~2"
set "GH_USER=%~3"

if "%PROJECT%"=="" goto :usage
if "%VERSION%"=="" goto :usage
if "%GH_USER%"=="" set "GH_USER=JonathanMohr"

set "URL=https://github.com/%GH_USER%/%PROJECT%/archive/refs/tags/%VERSION%.tar.gz"

set "CODE="
for /f %%c in ('curl -fsSL -o NUL -w "%%{http_code}" "%URL%"') do set "CODE=%%c"

if not "%CODE%"=="200" (
    >&2 echo Error: Could not find tarball at: %URL%
    exit /b 1
)

set "TMPFILE=%TEMP%\sha256_%RANDOM%.tar.gz"

curl -fsSL -o "%TMPFILE%" "%URL%" || (
    >&2 echo Error: Download failed: %URL%
    exit /b 1
)

set "HASH="
for /f "skip=1 delims=" %%h in ('certutil -hashfile "%TMPFILE%" SHA256') do (
    if not defined HASH set "HASH=%%h"
)
set "HASH=%HASH: =%"

del "%TMPFILE%" 2>NUL

if not defined HASH (
    >&2 echo Error: Failed to compute SHA256 hash.
    exit /b 1
)

echo SHA256: %HASH%
exit /b 0

:usage
>&2 echo Usage: %~nx0 ^<project^> ^<version^> [github_user]
exit /b 1
