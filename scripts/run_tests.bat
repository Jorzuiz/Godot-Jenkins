@echo off
setlocal
:: Define the paths to the Godot executable, the project template, and the export path
set godotExecutablePath=C:\Program Files\Godot\Godot_v4.2.2-stable_win64.exe
set projectTemplatePath=.\FirstPersonShooterTemplate
set outputDirectory=.\test_results\


:: Clean the last build in case it

echo "Cleaning previous tests log"
rmdir /s /q " %projectTemplatePath%%outputDirectory%"
echo "Creating test directory..."
mkdir " %projectTemplatePath%%outputDirectory%"


:: Function to execute the Godot engine with the specified project and export options
:executeGodotProject
if exist "%godotExecutablePath%" (
    echo "Starting project  %projectTemplatePath% , testing ..."
    start "" /B "$godot_executable" --headless --verbose --path "$project_path" --run-tests > "$output_path/test_results.txt"" 
    dir %projectTemplatePath%%outputDirectory%
) else (
    echo Godot executable not found at: %godotExecutablePath%
    dir %godotExecutablePath%
)

endlocal
   