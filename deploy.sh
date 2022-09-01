aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin 077073559458.dkr.ecr.ap-northeast-1.amazonaws.com/nginx
#aws ecr get-login-password --region AWS_DEFAULT_REGION | docker login --username AWS --password-stdin REPOSITORY_URI
docker pull REPOSITORY_URI:IMAGE_TAG
docker run -d -p 80:80 --restart=always --name webserver REPOSITORY_URI:IMAGE_TAG