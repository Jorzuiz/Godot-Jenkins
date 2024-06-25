//This script is meant to be used in a Windows server 

// Programs and files that you need in the server computer
// - Godot Engine: Whatever version you are using on your project 

// TODO enumerate the jenkins plugins, how to configure ...
//
pipeline {
    agent any

    environment {
        PROJECT_NAME="FirstPersonShooterTemplate"
        PROJECT_PATH = "${WORKSPACE}" // Use Jenkins workspace path
    }

    stages {
        stage('Tests') {
            steps {
                echo "Testing the project..."
                   
                 
                
            }
        }
        stage('Build') {
            steps {

                echo "Building project..."
                    script {
                        bat "${WORKSPACE}\\scripts\\build.bat"
                    }
                
            }
        }
    }
    post{
        always{
            echo "Archiving test artifacts..."
    
            echo "Archiving build artifacts..."
            archive "${PROJECT_NAME}\\build\\**"
            
            
        }
    }
}
