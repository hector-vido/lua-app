-- migrations.lua
local schema = require('lapis.db.schema')
local types = schema.types

return {
	[1] = function()
		schema.create_table('usuarios', {
			{ 'id', types.id },
			{ 'nome', types.varchar },
			{ 'email', types.varchar },
			{ 'senha', types.varchar }
		})
		local db = require("lapis.db")
		db.insert("usuarios", {nome = 'Paramahansa Yogananda', email = 'paramahansa@yogananda.in',	senha = '123'})
		db.insert("usuarios", {nome = 'Mary Shelley', email = 'victor@frankenstein.co.uk', senha = '123'})
	end
}
