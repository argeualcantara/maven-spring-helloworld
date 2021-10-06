pipeline {
    agent { label 'docker-agent' }
    
    options {
        skipDefaultCheckout true
    }

    environment {
        BRANCH="${BRANCH_NAME}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout([
                    $class: 'GitSCM', branches: [[name: '*/${BRANCH}']],
                    extensions: [[$class: 'CloneOption', timeout: 20], [$class: 'CloneOption', noTags: false],
                                 [$class: 'CloneOption', shallow: false], [$class: 'CloneOption', depth: 1]],
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