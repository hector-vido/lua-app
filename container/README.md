# Container

Aqui estão os arquivos relacionados a imagem de contêiner e ao `compose file`.

## Resolução de Nomes

O arquivo `nginx.conf` está com sua diretiva `resolver` comentada para que o contêiner possa rodar em desktops. Caso o contêiner deva ser executado dentro do `docker-compose` ou mesmo dentro do Kubernetes/Openshift, esta diretiva deverá ser descomentada ou o nginx não conseguirá encontrar o banco de dados pelo nome.

## Build

```bash
cd container
podman build -t lua-app -f Containerfile ../
```
