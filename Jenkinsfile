pipeline {
    agent any
    environment {
        AWS_ACCOUNT_ID="0123456789"
        AWS_DEFAULT_REGION="ap-northeast-1" 
        IMAGE_REPO_NAME="nginx"
        IMAGE_TAG="${env.BUILD_ID}"
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
	registryCredential = "aws-login"
    ec2_ip = "35.79.228.201"
    }

    stages {

        //Building Docker images
        stage('Docker Build'){
            steps{
                script{
                    dockerImage = docker.build "${IMAGE_REPO_NAME}:${IMAGE_TAG}"
                }
                echo "Image name = ${IMAGE_REPO_NAME}"
            }
        }

        //Upload images to ECR
        stage('Push to ECR'){
            steps{
                script {
                    docker.withRegistry("https://" + REPOSITORY_URI, "ecr:${AWS_DEFAULT_REGION}:" + registryCredential) {
                       dockerImage.push() 
                    }
                }
            }
        }

        //SSH connect to ec2 instance
        stage('Deploy') {
            steps {
                sh 'sed -i "s#IMAGE_TAG#$IMAGE_TAG#g" deploy.sh'
                sh 'sed -i "s#REPOSITORY_URI#$REPOSITORY_URI#g" deploy.sh'
                sh 'sed -i "s#AWS_DEFAULT_REGION#$AWS_DEFAULT_REGION#g" deploy.sh'
                sshagent (credentials: ['ssh-ec2']) {
                    sh "scp -r /var/lib/jenkins/.aws/ ubuntu@${ec2_ip}:/home/ubuntu/"
                    sh "scp deploy.sh ubuntu@${ec2_ip}:/home/ubuntu"
                    //sh "ssh ubuntu@${ec2_ip} 'sudo apt update -y && \
                        //sudo apt install awscli -y' "
                    sh "ssh ubuntu@${ec2_ip} 'chmod +x deploy.sh'"                        
                    sh "ssh ubuntu@${ec2_ip} 'sh ./deploy.sh'"
                }
            }
        }
    }
}