pipeline {
    agent { label 'docker-agent' }
    
    options {
        skipDefaultCheckout true
    }

    stages {
        stage('Checkout') {
            steps {
                checkout([
                    $class: 'GitSCM', branches: [[name: '*/${env.BRANCH_NAME}']],
                    extensions: [[$class: 'CloneOption', timeout: 20]],
                    userRemoteConfigs: [[url: 'https://github.com/argeualcantara/maven-spring-helloworld.git',credentialsId:'githubArgeu']]
                ])
            }
        }
        stage('Back-end') {
            steps {
                script {    
                    sh "ls -ilha"
                }
            }
        }
    }
}