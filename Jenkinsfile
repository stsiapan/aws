pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                echo 'Checkout..'
                checkout scm
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
                echo " this is ${WORKSPACE}"
                sh "ls -la ${WORKSPACE}"
            }
        }
    }
    post {
        always {
          mail to: 'stsiapan_hanchar@epam.com',
             subject: "Pipeline: ${currentBuild.fullDisplayName}",
             body: "Something is good/bad with ${env.BUILD_URL}"
        }
    }
}
