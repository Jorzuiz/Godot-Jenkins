@echo off
setlocal
:: Define th    e paths to the Godot executable, the project template, and the export path
set godotExecutablePath=C:\Program Files\Godot\Godot_v4.2.2-stable_win64.exe
set projectTemplatePath=.\FirstPersonShooterTemplate
set exportMode ="Windows"
set outputDirectory=.\build\
set executableName=build.exe

:: Construct the full output path using the directory and executable name variables
set outputPath=%outputDirectory%%executableName%

:: Clean the last build in case it

echo "Cleaning las build..."
rmdir /s /q " %projectTemplatePath%%outputDirectory%"
echo "Creating build directory..."
mkdir " %projectTemplatePath%%outputDirectory%"


:: Function to execute the Godot engine with the specified project and export options
:executeGodotProject
if exist "%godotExecutablePath%" (
    dir .
    echo "Starting project  %projectTemplatePath% , building at %outputPath%..."
    start "" /B "%godotExecutablePath%" --headless --verbose --export-release "Windows Desktop" "%outputPath%" --path "%projectTemplatePath%"
    dir %projectTemplatePath%%outputDirectory%
) else (
    echo Godot executable not found at: %godotExecutablePath%
    dir %godotExecutablePath%
)

endlocal