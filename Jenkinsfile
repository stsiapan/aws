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
                withCredentials([sshUserPrivateKey(credentialsId: 'to_web', keyFileVariable: 'identity', passphraseVariable: '', usernameVariable: 'userName')]) {
                    sshagent(['to_web']) {
                         sh "scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ${WORKSPACE}/index.html  ${remote_user}@${remote_host}:/tmp"
                         sh "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ${remote_user}@${remote_host} 'sudo mv /tmp/index.html /usr/share/nginx/html/index.html; sudo service nginx restart'"  
                    }
                }
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
