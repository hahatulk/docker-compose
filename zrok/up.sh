git clone https://github.com/hahatulk/zrok.git
cp .env ./zrok/docker/compose/zrok2-instance/.env
cd ./zrok/docker/compose/zrok2-instance/
docker compose up -d
sudo ufw-docker reload
