# Lua - Lapis + MySQL

## Como Rodar

Para testar a aplicação da forma mais fácil possível baixe a imagem do Docker `hectorvido/lapis:alpine` e torne o código da aplicação disponível em `/opt/app`:

```bash
git clone https://github.com/hector-vido/lua-app.git
cd lua-app/container
podman build -t lua-app -f Containerfile ../
podman run --rm -ti -v $PWD:/opt/app -p 8080:8080 --name lapis lua-app
```

> A maioria das dependências já estão disponíveis dentro do contêiner

Para fazer login na aplicação será necessário executar uma **migration**, mas para isso é preciso antes conectá-la a um banco de dados MySQL conforme a explicação mais abaixo.

## MySQL

Um banco de dados MySQL é necessário e suas dados são especificados no arquivo `config.lua`:

```lua
config('development', {
  mysql = {
    host = '172.17.0.1',
    port = '3306',
    user = 'lua',
    password = '4linux',
    database = 'lua'
  }
})

```

> **Observação:** Quando utilizamos o Docker o endereço `172.17.0.1` é a máquina hospedeira.

```bash
podman run -dti --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD='!Abc123' -e MYSQL_USER=lua -e MYSQL_PASSWORD=4linux -e MYSQL_DATABASE=lua mysql:8.3
```

## Dependências

Para instalar apenas as dependências da aplicação é possível executar o seguinte comando:

```bash
luarocks build --only-deps app-0.1-1.rockspec
```

> **Atenção:** Muitas dependências necessitam dos arquivos de cabeçalho para compilação

## Migration

Para popular o banco e criar as tabelas necessárias entre no contêiner e execute `lapis migrate` a partir do diretório da aplicação:

```bash
podman exec -ti lapis sh
cd /opt/app
lapis migrate
```

> **Antenção:** Verifique se os dados de acesso no arquivo `config.lua` estão corretos.
