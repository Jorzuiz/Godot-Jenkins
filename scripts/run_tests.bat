@echo off
setlocal
:: Define the paths to the Godot executable, the project template, and the export path
set godotExecutablePath=C:\Program Files\Godot\Godot_v4.2.2-stable_win64.exe
set projectTemplatePath=.\FirstPersonShooterTemplate
set outputDirectory=.\test_results\

:: Function to execute the Godot engine with the specified project and export options
:executeGodotProject
if exist "%godotExecutablePath%" (
    echo "Starting project  %projectTemplatePath% , testing ..."
    start "" /B "%godotExecutablePath%" --headless --verbose --path "$project_path" --run-tests > "./test_results.txt"" 
 
) else (
    echo Godot executable not found at: %godotExecutablePath%
    dir %godotExecutablePath%
)

endlocal
   