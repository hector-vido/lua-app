# Kubernetes

Aqui estão os manifestos do Kubernetes.

Comece criando o `lua.yml` pois contém o `namespace` seguido do `mariadb.yml`, após isso crie o secret para a aplicação:

```bash
kubectl apply -f lua.yml -f mariadb.yml
kubectl create secret generic -n lua lua --from-env-file app-secret.ini
```

> **Observação:** O `secret` foi criado apenas para a aplicação por questões de legibilidade.

## Resolver

O contêiner construido pelo `Containerfile` presente neste repositório desabilita a resolução de nomes local
necessária para que a aplicação encontre o banco de dados dentro do Kubernetes.
Para evitar que isso aconteça sem a necessidade de reconstruir a imagem, podemos criar um `ConfigMap` com
a nova configuração, alterando apenas o seguinte trecho:

```
http {
        include mime.types;
        lua_package_path "/opt/app/?.lua;/usr/share/lua/common/?.lua;;";
        resolver local=on;
```

> Descomente a linha do **resolver**.

Para criar o `ConfigMap` podemos utilizar:

```bash
kubectl create cm nginx-conf --from-file ../container/nginx.conf
```
