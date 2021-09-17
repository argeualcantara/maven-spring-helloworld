pipeline {
    agent { label 'docker-agent' }
    stages {
        stage('Back-end') {
            steps {
                script {    
                    docker.image('maven:3.8.1-adoptopenjdk-11').inside('-v ${WORKSPACE}:/work') {
                        sh """
                            cd /work
                            mvn clean package
                        """
                    }
                }
                
            }
        }

        post {
        always {
            archiveArtifacts artifacts: '${WORKSPACE}/target/**/*.jar', fingerprint: true
        }
    }
    }
}