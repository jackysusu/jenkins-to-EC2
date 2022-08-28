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
	registryCredential = "demo-admin-user"
    }

    stages {

        //
        stage('Docker Build'){
            step{
                script{
                    dockerImage = docker.build "${IMAGE_REPO_NAME}:${IMAGE_TAG}"
                }
            }
        }

        //
        stage('Push to ECR'){
            step{

            }
        }
        
        //
        stage('Deploy Script on EC2'){
            step{

            }
        }
    }
}    