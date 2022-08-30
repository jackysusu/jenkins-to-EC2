aws configure set default.region AWS_DEFAULT_REGION; aws configure set aws_access_key_id 'AKIAZZ3KV7Z73DGFFQFV' ; aws configure set aws_secret_access_key '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' | sudo sh
aws ecr get-login-password --region AWS_DEFAULT_REGION | docker login --username AWS --password-stdin REPOSITORY_URI
docker pull REPOSITORY_URI:IMAGE_TAG