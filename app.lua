local db = require('lapis.db')
local lapis = require('lapis')
local socket = require('socket')
-- local inspect = require('inspect')

local app = lapis.Application()
app:enable('etlua')

app:get('/', function(self)
	if not self.session.auth then
		return { redirect_to = '/login' }
	end
	return { layout = 'index' }
end)

app:get('/login', function(self)
	return { layout = 'login' }
end)

app:get('/logout', function(self)
	self.session.auth = nil
	self.session.email = nil
	return { redirect_to = '/login' }
end)

app:post('/login', function(self)
	local res = db.query('SELECT * FROM usuarios WHERE email = ? AND senha = ?', self.params.email, self.params.password)
	if #res ~= 0 then -- #res é o tamanho da tabela
		self.session.email = res[1]['email']
		self.session.auth = true
		return { redirect_to = '/' }
	end
	self.message = 'Usuário ou senha inválidos'
	return { layout = 'login' }
end)

app:get('/dbstatus', function(self)
	socket.sleep(2)
	local res = db.query('SHOW GLOBAL STATUS')
	local status = {}
	for i, row in ipairs(res) do
		status[string.lower(row['Variable_name'])] = row['Value']
	end
	return { json = { status = status } }
end)

return app
