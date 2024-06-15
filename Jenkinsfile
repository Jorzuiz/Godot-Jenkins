pipeline {
    agent any

    environment {
        GODOT_VERSION = '4.2.2' // Cambia esta versión según sea necesario
        GODOT_EXECUTABLE = "C:\\path\\to\\Godot_v${GODOT_VERSION}-stable_win64.exe" // Cambia la ruta al ejecutable de Godot
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Checkout of the repository..."
            }
        }
        stage('Tests') {
            steps {
                echo "Testing the project..."
            }
        }
        stage('Build') {
            steps {
                echo "Building project..."
                powershell '''
                    $godot_executable = "${env:GODOT_EXECUTABLE}"
                    
                    Write-Output "Checking if Godot executable exists at: $godot_executable"
                    if (Test-Path $godot_executable) {
                        Write-Output "Godot executable found. Starting build..."
                        & $godot_executable --export-debug "Windows Desktop" "$pwd\\build\\game.exe"
                    } else {
                        Write-Error "Godot executable not found: $godot_executable"
                        Write-Output "Listing contents of directory:"
                        Get-ChildItem -Path $godot_executable | Write-Output
                        exit 1
                    }
                '''
            }
        }

        stage('Archive') {
            steps {
                echo "Archiving build artifacts..."
                archiveArtifacts artifacts: 'build/game.exe', fingerprint: true
            }
        }
    }
}
