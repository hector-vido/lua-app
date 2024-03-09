package = "app"
version = "0.1-1"
source = {
   url = ""
}
description = {
   homepage = "",
   license = ""
}
dependencies = {
	'inspect',
	'lapis',
	'luasql-mysql'
}
build = {
   type = "builtin",
   modules = {
      app = "app.lua",
      config = "config.lua"
   }
}
