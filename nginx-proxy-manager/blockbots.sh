#!/bin/bash
set -euo pipefail

BASE_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
CUSTOM_DIR="$BASE_DIR/data/nginx/custom"
CUSTOM_FILE="$CUSTOM_DIR/server_proxy.conf"

printf '1) Включить\n2) Выключить\n'
read -r -p 'Блокировка ботов [1/2]: ' choice

case "$choice" in
    1)
        mkdir -p "$CUSTOM_DIR"
        cp -- "$BASE_DIR/server_proxy.conf" "$CUSTOM_FILE"
        echo 'Блокировка ботов включена.'
        ;;
    2)
        rm -f -- "$CUSTOM_FILE"
        echo 'Блокировка ботов выключена.'
        ;;
    *)
        echo 'Неверный выбор. Введите 1 или 2.' >&2
        exit 1
        ;;
esac

cd -- "$BASE_DIR"
docker compose restart
