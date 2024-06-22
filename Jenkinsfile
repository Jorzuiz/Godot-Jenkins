//This script is meant to be used in a Windows server 

// Programs and files that you need in the server computer:
// - Git bash: We need the sh.exe, usually located at C:\Program Files\Git\bin
// - Godot Engine: Whatever version you are using on your project 
// - shells on the script folder, it could be on the repository 
//      but due to the variables of where is godot in your machine 
//      we recommend to be locally on the computer server

// TODO enumerate the jenkins plugins, how to configure ...
//
pipeline {
    agent any

    environment {
        
        SHEXE_PATH= "path\\to\\git\\bin\\sh.exe"        
        SCRIPTS_PATH= "path\\to\\scripts"
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
        .           dir(SCRIPTS_PATH) {
                    script {
                        // Make the shell script executable
                        bat "${SHEXE_PATH} -c 'chmod +x run_tests.sh'"
                        // Execute the shell script
                        bat "${SHEXE_PATH} -c './run_tests.sh'"
                    }
            }
        }
        stage('Build') {
            steps {

                echo "Building project..."
                dir(SCRIPTS_PATH) {
                    script {
                        // Make the shell script executable
                        bat "${SHEXE_PATH} -c 'chmod +x build.sh'"
                        // Execute the shell script
                        bat "${SHEXE_PATH} -c './build.sh'"
                    }
                }
            }
        }
        stage('Archive') {
            steps {
                echo "Archiving test artifacts..."
                archiveArtifacts artifacts: 'tests/test_results.txt', allowEmptyArchive: true
                echo "Archiving build artifacts..."
                archiveArtifacts artifacts: "${OUTPUT_PATH}", fingerprint: true
            }
        }
    }
}
