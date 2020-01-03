pipeline {
    remote_user = 'ec2-user'
    agent any

    stages {
        stage('Checkout') {
            steps {
                echo 'Checkout..'
                checkout scm
            }
        }
        stage ("Get_aws_info") {
            steps {
                script {
                    stage ("pv_dns") {
                        withAWS(credentials:'aws') {
                            PV_DNS = sh (
                            script: 'aws --region "us-east-1" ec2 describe-instances --filters "Name=tag:Name,Values=Nginx" | jq ".Reservations[].Instances[].NetworkInterfaces[].PrivateIpAddresses[].PrivateDnsName" | sed "s/.$//; s/^.//"',
                            returnStdout: true
                            ).trim()
                            PV_IP = sh (
                            script: 'aws --region "us-east-1" ec2 describe-instances --filters "Name=tag:Name,Values=Nginx" | jq ".Reservations[].Instances[].NetworkInterfaces[].PrivateIpAddresses[].PrivateIpAddress" | sed "s/.$//; s/^.//"',
                            returnStdout: true
                            ).trim()
                            echo "$PV_DNS"
                            echo "$PV_IP"
                            echo "$remote_user"

                         }    
                     }

                 }
             } 
         }        
        stage('Deploy') {
            steps {
                echo 'Deploying....'
                withCredentials([sshUserPrivateKey(credentialsId: 'to_web', keyFileVariable: 'identity', passphraseVariable: '', usernameVariable: 'userName')]) {
                    sshagent(['to_web']) {
                         sh "scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ${WORKSPACE}/index.html  ${remote_user}@${PV_IP}:/tmp"
                         sh "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ${remote_user}@${PV_IP} 'sudo mv /tmp/index.html /usr/share/nginx/html/index.html; sudo service nginx restart'"
                         echo "$remote_user"
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
