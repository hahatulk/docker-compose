# hysteria
1. Выставляем ip сервера в certgen.sh
2. Выставляем ip сервера в `client/example.yaml`
3. Запускаем certgen.sh, копируем sha из `sha256.txt`
4. Заменяем sha в `client/example.yaml`
5. Копируем example.yaml под название конфига (пример `nout.yaml`)
6. Вбиваем userpass клиента в `server/config.yaml`
7. Запускаем hysteria

## Получение конфиг ссылки
1. docker exec -it hysteria bash
2. 
```bash 
hysteria share -c client/example.yaml
```

После изменений в конфигах нужно перезапускать контейнер
