@echo off
setlocal
:: Define th    e paths to the Godot executable, the project template, and the export path
set godotExecutablePath=C:\Users\ampxr\Documents\Godot_v4.2.2-stable_win64.exe
set projectTemplatePath=.
set exportMode ="Windows"
set outputDirectory=.\build\
set executableName=build.exe

:: Construct the full output path using the directory and executable name variables
set outputPath=%outputDirectory%%executableName%

:: Check if the build directory exists, clean it, and then create it
if exist "%outputDirectory%" (
    echo "Cleaning las build..."
    rmdir /s /q "%outputDirectory%"
) else (
    echo "Creating build directory..."
    mkdir "%outputDirectory%"
)

:: Function to execute the Godot engine with the specified project and export options
:executeGodotProject
if exist "%godotExecutablePath%" (
    echo "%godotExecutablePath%" --path "%projectTemplatePath%" --export-release "Windows Desktop" "%outputPath%"
    start "" /B "%godotExecutablePath%" --headless --verbose --export-release "Windows Desktop" "%outputPath%"
) else (
    echo Godot executable not found at: %godotExecutablePath%
    dir %godotExecutablePath%
)

endlocal