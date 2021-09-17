pipeline {
    agent { label 'docker-agent' }
    stages {
        stage('Back-end') {
            steps {
                docker.image('maven:3.8.1-adoptopenjdk-11').inside('-v ${WORKSPACE}:/work') {
                    sh """
                        cd /work
                        mvn --version
                    """
                }
                
            }
        }
    }
}