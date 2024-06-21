pipeline {
    agent any

    environment {
      
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
        .           cd SCRIPTS_ROUTE
                    // Make the shell script executable
                    sh 'chmod +x run_tests.sh'
                    // Execute the shell script
                    sh './run_tests.sh'
                    cd PROJECT_PATH
            }
        }
        stage('Build') {
            steps {

                echo "Building project..."
                    cd SCRIPTS_ROUTE

                     // Make the shell script executable
                    sh 'chmod +x build.sh'
                    // Execute the shell script
                    sh './build.sh'
                         cd PROJECT_PATH
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
