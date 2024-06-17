pipeline {
    agent any

    environment {
        GODOT_VERSION = '4.2.2' // Change this version as needed
        GODOT_EXECUTABLE = "path\\to\\Godot_v${GODOT_VERSION}-stable_win64.exe" // Change the path to your Godot executable
        EXPORT_PRESET = "Windows Desktop" // Change this to your export preset name
        OUTPUT_PATH = "build\\game.exe" // Change this to your desired output path
        PROJECT_NAME="FirstPersonShooterTemplate"
        PROJECT_PATH = "${WORKSPACE}" // Use Jenkins workspace path

        REPOSITORY= 'https://github.com/Jorzuiz/Godot-Jenkins.git'
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Checkout of the repository..."
                git url: REPOSITORY, branch: 'main'
            }
        }
        stage('Tests') {
            steps {
                echo "Testing the project..."
                // Add steps to run your tests, if any
            }
        }
        stage('Build') {
            steps {
                echo "Building project..."
                script {
                    def godot_executable = GODOT_EXECUTABLE
                    def export_preset = EXPORT_PRESET
                    def output_path = OUTPUT_PATH
                    def project_path = PROJECT_PATH + "\\" + PROJECT_NAME

                    sh """
                        echo "Checking if Godot executable exists at: $godot_executable"
                        if [ -f "$godot_executable" ]; then
                            echo "Godot executable found. Starting build..."
                            "$godot_executable"--headless --path "$project_path" --export "$export_preset" "$output_path"
                        else
                            echo "Godot executable not found: $godot_executable"
                            echo "Listing contents of directory:"
                            ls -l "$(dirname "$godot_executable")"
                            exit 1
                        fi
                    """
                }
            }
        }
        stage('Archive') {
            steps {
                echo "Archiving build artifacts..."
                archiveArtifacts artifacts: OUTPUT_PATH, fingerprint: true
            }
        }
    }
}
