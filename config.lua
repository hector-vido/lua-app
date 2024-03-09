-- config.lua
local config = require('lapis.config')

config('development', {
  secret = os.getenv('LUA_SECRET') or 'UxNGNjv5qjbmhpbRjTnVNGknUEzBQnee',
  mysql = {
    host = os.getenv('MYSQL_HOST') or '127.0.0.1',
    port = os.getenv('MYSQL_PORT') or '3306',
    user = os.getenv('MYSQL_USER') or 'lua',
    password = os.getenv('MYSQL_PASSWORD') or 'lua',
    database = os.getenv('MYSQL_DATABASE') or 'lua'
  }
})
