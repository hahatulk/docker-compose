docker compose down -v --remove-orphans

docker stop nextcloud-aio-apache
docker stop nextcloud-aio-collabora
docker stop nextcloud-aio-domaincheck
docker stop nextcloud-aio-imaginary
docker stop nextcloud-aio-nextcloud
docker stop nextcloud-aio-notify-push
docker stop nextcloud-aio-redis
docker stop nextcloud-aio-talk
docker stop nextcloud-aio-whiteboard
docker stop nextcloud-aio-database

docker container rm nextcloud-aio-apache
docker container rm nextcloud-aio-collabora
docker container rm nextcloud-aio-domaincheck
docker container rm nextcloud-aio-imaginary
docker container rm nextcloud-aio-nextcloud
docker container rm nextcloud-aio-notify-push
docker container rm nextcloud-aio-redis
docker container rm nextcloud-aio-talk
docker container rm nextcloud-aio-whiteboard
docker container rm nextcloud-aio-database

docker volume rm nextcloud_aio_apache
docker volume rm nextcloud_aio_database
docker volume rm nextcloud_aio_database_dump
docker volume rm nextcloud_aio_nextcloud
docker volume rm nextcloud_aio_nextcloud_data
docker volume rm nextcloud_aio_redis
docker volume rm nextcloud_aio_talk_recording
docker volume rm nextcloud_aio_mastercontainer


docker network rm nextcloud-aio
