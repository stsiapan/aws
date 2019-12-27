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
     }
    post {
        always {
          mail to: 'stsiapan_hanchar@epam.com',
             subject: "Pipeline: ${currentBuild.fullDisplayName}",
             body: "Something is good/bad with ${env.BUILD_URL}"
        }
    }
}
