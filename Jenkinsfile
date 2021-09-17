pipeline {
    agent { label 'docker-agent' }
    stages {
        stage('Back-end') {
            steps {
                script {    
                    docker.image('maven:3.8.1-adoptopenjdk-11').inside('-v ${WORKSPACE}:/work -v /var/jenkins_home/.m2:/root/.m2').withRun('-u 0:0') {
                        sh """
                            cd /work
                            mvn clean package
                        """
                    }
                }
                //docker run -u 1000:1000 --rm -it --entrypoint sh maven:3.8.1-adoptopenjdk-11 
            }
        }
    }
    post {
        always {
            archiveArtifacts artifacts: '${WORKSPACE}/target/**/*.jar', fingerprint: true
        }
    }
}