pipeline {
    agent { label 'docker-agent' }
    stages {
        stage('Back-end') {
            steps {
                script {    
                    docker.image('maven:3.8.1-adoptopenjdk-11').inside('-v /var/jenkins_home/.m2:/root/.m2') {
                        sh """
                            ls
                            mvn clean package
                        """
                    }
                }
            }
        }
    }
    post {
        success {
            archiveArtifacts artifacts: 'target/**/*.jar', fingerprint: true
        }
    }
}