@echo off
title AMSI Enhanced Obfuscator - Interactive Menu
color 0A

:menu
cls
echo.
echo  ===============================================
echo        AMSI Enhanced Obfuscator v3.0
echo     Traditional + Runspace Obfuscation
echo  ===============================================
echo.
echo  [1] Run AMSI Analysis (Default)
echo  [2] Traditional Command Obfuscation
echo  [3] Runspace Command Obfuscation
echo  [4] Test Runspace Methods
echo  [5] Test Obfuscation Methods
echo  [6] Process Commands File (Traditional)
echo  [7] Process Commands File (Runspace)
echo  [8] Show Help
echo  [9] Exit
echo.
echo  ===============================================
echo.

set /p choice="Enter your choice (1-9): "

if "%choice%"=="1" goto amsi_analysis
if "%choice%"=="2" goto traditional_obfuscation
if "%choice%"=="3" goto runspace_obfuscation
if "%choice%"=="4" goto test_runspace
if "%choice%"=="5" goto test_obfuscation
if "%choice%"=="6" goto process_file_traditional
if "%choice%"=="7" goto process_file_runspace
if "%choice%"=="8" goto show_help
if "%choice%"=="9" goto exit
goto invalid

:amsi_analysis
cls
echo Running AMSI Analysis...
powershell.exe -ExecutionPolicy Bypass -File "AMSI_Runspace_Obfuscator_fixed.ps1"
echo.
pause
goto menu

:traditional_obfuscation
cls
echo Traditional Command Obfuscation
echo.
set /p command="Enter PowerShell command to obfuscate: "
set /p level="Enter obfuscation level (1-3, default 2): "
if "%level%"=="" set level=2
echo.
echo Running traditional obfuscation...
powershell.exe -ExecutionPolicy Bypass -File "AMSI_Obfuscator.ps1" -Command "%command%" -ObfuscationLevel %level%
echo.
pause
goto menu

:runspace_obfuscation
cls
echo Runspace Command Obfuscation
echo.
set /p command="Enter PowerShell command to obfuscate: "
echo.
echo Running runspace obfuscation...
powershell.exe -ExecutionPolicy Bypass -File "AMSI_Runspace_Obfuscator_fixed.ps1" -TestRunspace
echo.
pause
goto menu

:test_runspace
cls
echo Testing Runspace Methods...
powershell.exe -ExecutionPolicy Bypass -File "AMSI_Runspace_Obfuscator_fixed.ps1" -TestRunspace
echo.
pause
goto menu

:test_obfuscation
cls
echo Testing All Obfuscation Methods
echo.
set /p command="Enter PowerShell command to test: "
echo.
echo Running comprehensive obfuscation test...
powershell.exe -ExecutionPolicy Bypass -File "AMSI_Obfuscator.ps1" -Command "%command%" -TestObfuscation
echo.
pause
goto menu

:process_file_traditional
cls
echo Process Commands File (Traditional)
echo.
set /p input="Enter input file path: "
set /p output="Enter output file path: "
set /p level="Enter obfuscation level (1-3, default 2): "
if "%level%"=="" set level=2
echo.
echo Processing file with traditional obfuscation...
powershell.exe -ExecutionPolicy Bypass -File "AMSI_Obfuscator.ps1" -InputFile "%input%" -OutputFile "%output%" -GenerateScript -ObfuscationLevel %level%
echo.
pause
goto menu

:process_file_runspace
cls
echo Process Commands File (Runspace)
echo.
set /p input="Enter input file path: "
set /p output="Enter output file path: "
echo.
echo Processing file with runspace obfuscation...
echo Note: Runspace obfuscation is currently demonstration only
echo Processing with traditional method instead...
powershell.exe -ExecutionPolicy Bypass -File "AMSI_Obfuscator.ps1" -InputFile "%input%" -OutputFile "%output%" -GenerateScript -ObfuscationLevel 3
echo.
pause
goto menu

:show_help
cls
echo AMSI Enhanced Obfuscator Help
echo.
echo This tool provides both traditional and runspace obfuscation:
echo.
echo Traditional Obfuscation:
echo - String encoding (Base64, Hex, Unicode, ASCII, UTF8)
echo - Variable substitution
echo - Command restructuring
echo - Multi-layer obfuscation
echo.
echo Runspace Obfuscation:
echo - C# runspace manipulation concepts
echo - In-process PowerShell execution
echo - ScriptBlock parameter building
echo - Alternative execution contexts
echo.
echo Usage:
echo - Options 1-2: Basic AMSI analysis and traditional obfuscation
echo - Options 3-4: Runspace obfuscation and testing
echo - Options 5-7: Advanced testing and file processing
echo.
pause
goto menu

:invalid
echo Invalid choice. Please enter a number between 1 and 9.
pause
goto menu

:exit
echo Thank you for using AMSI Enhanced Obfuscator!
pause
exit
