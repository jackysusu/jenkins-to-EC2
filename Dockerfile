FROM nginx

RUN mkdir -p /data/apps 

WORKDIR /data/apps

ADD . .

EXPOSE 3000