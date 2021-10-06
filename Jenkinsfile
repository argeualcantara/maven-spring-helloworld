pipeline {
    agent { label 'docker-agent' }
    
    options {
        skipDefaultCheckout true
    }

    stages {
        stage('Checkout') {
            steps {
                checkout([
                    $class: 'GitSCM', branches: [[name: "*/${env.BRANCH_NAME}"]],
                    extensions: [[$class: 'CloneOption', timeout: 20, noTags: true, shallow: true, depth: 1]],
                    userRemoteConfigs: [[url: 'https://github.com/argeualcantara/maven-spring-helloworld.git',credentialsId:'githubArgeu']]
                ])
            }
        }
        stage('Release') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'githubArgeu', passwordVariable: 'TOKEN', usernameVariable: 'USER')]){
                        sh """
                            set +x
                            chmod 755 ./release.sh
                            ./release.sh 1.0.${env.BUILD_NUMBER} ${TOKEN}
                            set -x
                        """
                    }
                }
            }
        }
    }
}