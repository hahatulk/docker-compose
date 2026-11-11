chown -R 2000:2000 \
  ./source/stalwart-data/config \
  ./source/stalwart-data/data

chmod -R u+rwX \
  ./source/stalwart-data/config \
  ./source/stalwart-data/data

docker compose up -d
