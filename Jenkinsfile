pipeline {
    agent any
    environment {
        AWS_ACCOUNT_ID="077073559458"
        AWS_DEFAULT_REGION="ap-northeast-1" 
	//CLUSTER_NAME="CHANGE_ME"
	//SERVICE_NAME="CHANGE_ME"
	//TASK_DEFINITION_NAME="CHANGE_ME"
	//DESIRED_COUNT="CHANGE_ME"
        IMAGE_REPO_NAME="nginx"
        IMAGE_TAG="${env.BUILD_ID}"
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
	registryCredential = "aws-login"
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
        stage('ssh to ec2') {
            steps {
                sshagent (credentials: ['ssh-ec2']) {
                    sh 'scp deploy.sh ubuntu@18.182.25.165:/home/ubuntu'
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@18.182.25.165'
                    sh 'whoami'
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