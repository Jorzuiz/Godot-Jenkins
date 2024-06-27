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

echo "Cleaning previous build..."
rmdir /s /q "%projectTemplatePath%%outputDirectory%"
echo "Creating current build directory..."
mkdir "%projectTemplatePath%%outputDirectory%"


:: Function to execute the Godot engine with the specified project and export options
:executeGodotProject
if exist "%godotExecutablePath%" (
    echo "Starting project  %projectTemplatePath% , building at %outputPath%..."
    
    "%godotExecutablePath%" --headless --export-release "Windows Desktop" "%outputPath%" --path "%projectTemplatePath%"
    
    :: Then logs the executable route just in case of failing see if the executable generates in the route
    dir %projectTemplatePath%%outputDirectory% 
) else (
    echo Godot executable not found at: %godotExecutablePath%
    dir %godotExecutablePath%
)

endlocal