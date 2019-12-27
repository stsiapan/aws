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
        post {
          always {
              emailext body: 'A Test EMail',
              recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']],
              subject: 'Test',
              to: 'stsiapanhanchar@gmail.com',
              replyTo: 'stsiapan_hanchar@epam.com'
            }
          }
     }
}
