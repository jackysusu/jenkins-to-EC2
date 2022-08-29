aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin 077073559458.dkr.ecr.ap-northeast-1.amazonaws.com/nginx
docker pull 077073559458.dkr.ecr.ap-northeast-1.amazonaws.com/nginx:latest
#aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${REPOSITORY_URI}
#docker pull ${REPOSITORY_URI}:latest