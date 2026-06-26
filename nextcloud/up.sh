docker network create nextcloud-aio
sudo chown -R 33:33 /var/docker/nextcloud/data
sudo chmod -R 750 /var/docker/nextcloud/data
docker compose up -d

docker start nextcloud-aio-apache
docker start nextcloud-aio-collabora
docker start nextcloud-aio-domaincheck
docker start nextcloud-aio-imaginary
docker start nextcloud-aio-nextcloud
docker start nextcloud-aio-notify-push
docker start nextcloud-aio-redis
docker start nextcloud-aio-talk
docker start nextcloud-aio-whiteboard
docker start nextcloud-aio-database
docker start nextcloud-aio-talk-recording
docker start nextcloud-aio-fulltextsearch