pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/Jorzuiz/Godot-Jenkins.git', credentialsId: 'Github'
            }
        }
        stage('Install Export Templates') {
            steps {
                script {
                    def godotExportPath = 'C:/Users/ampxr/AppData/Roaming/Godot/export_templates/4.2.2.stable'
                    def exportTemplatesURL = 'https://downloads.tuxfamily.org/godotengine/4.2.2/Godot_v4.2.2-stable_export_templates.tpz'
                    def exportTemplatesArchive = 'export_templates.tpz'
                    
                    // Download export templates if not present
                    if (!fileExists("${godotExportPath}/windows_debug_x86_64.exe")) {
                        sh """
                            curl -L -o ${exportTemplatesArchive} ${exportTemplatesURL}
                            mkdir -p ${godotExportPath}
                            tar -xzf ${exportTemplatesArchive} -C ${godotExportPath}
                        """
                    }
                }
            }
        }
        stage('Prepare Export Directory') {
            steps {
                script {
                    def exportDir = 'C:/path/to/export/directory'  // Ajusta esta ruta según tu configuración
                    if (!fileExists(exportDir)) {
                        sh "mkdir -p ${exportDir}"
                    }
                }
            }
        }
        stage('Run Shell Script') {
            steps {
                sh 'sh ./build.sh'  // Usar Git Bash para ejecutar el script
            }
        }
    }
}
