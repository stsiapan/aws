pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
        stage('Email') {
            steps {
              emailext body: "${env.BUILD_URL} has result ${currentBuild.result}",
              mimeType: 'text/html',
              subject: "Status of pipeline: ${currentBuild.fullDisplayName}",
              to: 'stsiapanhanchar@gmail.com',
              replyTo: 'stsiapan_hanchar@epam.com'
              recipientProviders: [[$class: 'DevelopersRecipientProvider']]              
            }
        }
    }
}
