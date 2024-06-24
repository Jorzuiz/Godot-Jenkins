@echo off
setlocal
:: Define th    e paths to the Godot executable, the project template, and the export path
set godotExecutablePath=C:\Program Files\Godot\Godot_v4.2.2-stable_win64.exe
set projectTemplatePath=.\FirstPersonShooterTemplate
set outputDirectory=.\tests\

:: Construct the full output path using the directory and executable name variables
set outputPath=%outputDirectory%%executableName%

:: Check if the build directory exists, clean it, and then create it
if exist "%outputDirectory%" (
    echo "Cleaning the tests log"
    rmdir /s /q "%outputDirectory%"
) else (
    echo "Creating build directory..."
    mkdir "%outputDirectory%"
)

:: Function to execute the Godot engine with the specified project and export options
:executeGodotProject
if exist "%godotExecutablePath%" (
    echo "Starting project  %projectTemplatePath% , building at %outputPath%..."
    start "" /B "$godot_executable" --headless --verbose --path "$project_path" --run-tests > "$output_path/test_results.txt""
) else (
    echo Godot executable not found at: %godotExecutablePath%
    dir %godotExecutablePath%
)

endlocal