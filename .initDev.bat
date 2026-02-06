@echo off
setlocal enabledelayedexpansion

:: Execute this file after first cloning the repository.

call "%~dp0toolkit\scripts\initDevelopmentEnvironment.bat" "%~dp0"
