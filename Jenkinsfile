pipeline {
    agent any
    environment {
        AWS_ACCOUNT_ID="673996734079"
        AWS_DEFAULT_REGION="ap-northeast-1" 
	//CLUSTER_NAME="CHANGE_ME"
	//SERVICE_NAME="CHANGE_ME"
	//TASK_DEFINITION_NAME="CHANGE_ME"
	//DESIRED_COUNT="CHANGE_ME"
        IMAGE_REPO_NAME="nginx"
        IMAGE_TAG="${env.BUILD_ID}"
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
	registryCredential = "jackysusu_aws_key"
    ec2_ip = "3.112.24.148"
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
        stage('uploade file and deploy') {
            steps {
                sh 'sed -i "s#IMAGE_TAG#$IMAGE_TAG#g" deploy.sh'
                sh 'sed -i "s#REPOSITORY_URI#$REPOSITORY_URI#g" deploy.sh'
                sh 'sed -i "s#AWS_DEFAULT_REGION#$AWS_DEFAULT_REGION#g" deploy.sh'
                sshagent (credentials: ['ssh-ec2']) {
                    sh "scp deploy.sh ubuntu@${ec2_ip}:/home/ubuntu"
                    //sh "ssh ubuntu@${ec2_ip} 'sudo apt update -y && \
                        //sudo apt install awscli -y' "
                    sh "ssh ubuntu@1${ec2_ip} sudo chmod +x deploy.sh"                        
                    sh "ssh ubuntu@1${ec2_ip} sudo sh ./deploy.sh"
                }
            }
        }

        //Deploy images to EC2 Instance
        //stage('Deploy Script on EC2'){
            //steps{

            //}
        //}
    }
}