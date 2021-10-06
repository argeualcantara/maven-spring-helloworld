pipeline {
    agent { label 'docker-agent' }
    
    options {
        skipDefaultCheckout true
    }


    stages {
        stage('Checkout') {
            steps {
                script{
                    checkout([
                        $class: 'GitSCM', branches: [[name: "*/${env.BRANCH_NAME}"]],
                        extensions: [[$class: 'CloneOption', timeout: 20, noTags: true, shallow: true, depth: 1]],
                        userRemoteConfigs: [[url: 'https://github.com/argeualcantara/maven-spring-helloworld.git',credentialsId:'githubArgeu']]
                    ])
                }
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