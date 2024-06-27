//This script is meant to be used in a Windows server 

// Programs and files that you need in the server computer
// - Godot Engine: Whatever version you are using on your project 

// Jenkins Plugins:
// - Git Plugin: needed for cloning the repository
// - Pipeline plugin - workflow-aggregator: 
// - Archive plugin - artifact manager: for uploading the artifacts
pipeline {
    agent any

    environment {
        PROJECT_NAME="FirstPersonShooterTemplate" //Change this to your project name of your repository
        PROJECT_PATH = "${WORKSPACE}" // Use Jenkins workspace path
    }

    stages {


        //Then generate the exe 
        stage('Build') {
            steps {

                echo "Building project..."
                    script {
                        bat "${WORKSPACE}\\scripts\\build.bat"
                    }
                
            }
        }

        //First we run the tests
        //stage('Tests') {
            //steps {
                //echo "${WORKSPACE} Testing the project..."
                //bat "${WORKSPACE}\\scripts\\run_tests.bat"         
            //}
        //}

    }

    //And lastly we upload that generated files to the jenkins server
    post{
        always{
            //echo "Archiving test artifacts..."
            //archive "${WORKSPACE}\\test_results.txt"
    
            echo "Archiving build artifacts..."
            archiveArtifacts artifacts:"${PROJECT_NAME}\\build\\**", fingerprint: true
            
            
        }
    }
}
