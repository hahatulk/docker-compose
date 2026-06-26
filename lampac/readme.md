# Lampa selfhosted
## Источник - https://alcofuck.net/install.html

Docker<br>
Рекомендуемый способ. <br>
Образ для linux/amd64 и linux/arm64. <br>
Порт по умолчанию — 9118. <br>

```bash
git clone https://github.com/lampac-nextgen/lampac.git
cd lampac
mkdir -p lampac-docker/config lampac-docker/plugins
cp config/example.init.conf lampac-docker/config/init.conf
printf '%s' 'ваш_пароль_root' > lampac-docker/config/passwd
```

# Раскомментируйте блок volumes в docker-compose.yaml
docker compose up -d
