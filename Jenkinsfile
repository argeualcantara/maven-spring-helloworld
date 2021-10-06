pipeline {
    agent { label 'docker-agent' }
    
    options {
        skipDefaultCheckout true
    }

    environment {
        BRANCH="${env.BRANCH_NAME}"
    }

    stages {
        stage('Checkout') {
            steps {
                script{
                    checkout([
                        $class: 'GitSCM', branches: [[name: '*/\${BRANCH}']],
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