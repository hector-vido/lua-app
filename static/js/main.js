window.addEventListener('load', function() {

	lua.div = document.getElementById('dynamic');
	lua.data = document.getElementById('data');

	// faz cache da imagem
	document.body.appendChild(lua.createElement('img', {src : '/static/images/loading.gif', style : 'display:none'}))

	lua.request('get', '/dbstatus')
	.onload(function(response) {
		lua.load(response.data);
	})
	.onerror(function(response) {
		console.log('Ops...');
	});

	lua.div.appendChild(lua.createElement('h1', {text : 'Consultando MySQL...'}));
	lua.div.appendChild(lua.createElement('img', {src : '/static/images/loading.gif'}))
	setTimeout(lua.reload, 5000);
});

var lua = {div : null, data : null}
lua.load = function(response) {
	lua.clear(lua.div);
	lua.data.style.display = "inline-block";
	var data = JSON.parse(response);
	var table = document.createElement('table');
	var show = [
		'uptime',
		'threads_running',
		'threads_connected',
		'slow_queries',
		'innodb_row_lock_waits',
		'table_open_cache_misses',
		'table_open_cache_hits',
		'innodb_row_lock_time_avg',
		'queries'
	];
	for(var property in data.status) {
		if (show.indexOf(property) == -1)
			continue;
		var element = document.getElementById(property);
		element.textContent = data.status[property];
		element.nextElementSibling.textContent = property;
	}
	lua.div.appendChild(lua.createElement('h1', {text : 'MySQL Status'}));
	lua.div.appendChild(table);
};
lua.reload = function() {
	var loading = lua.createElement('img', {src : '/static/images/loading.gif', className : 'loading'})
	lua.request('get', '/dbstatus')
	.onload(function(response) {
		lua.load(response.data);
		loading.parentNode.removeChild(loading);
		setTimeout(lua.reload, 5000);
	})
	.onerror(function(response) {
		loading.parentNode.removeChild(loading);
		setTimeout(lua.reload, 5000);
	});
	document.body.appendChild(loading)
};
lua.request = function(verb, endpoint) {
	var request = {_onload : function() {}, _error : function() {}}
	request.request = new XMLHttpRequest();
	request.onload = function(fnc) {
		request._onload = fnc;
		return request;
	};
	request.onerror = function(fnc) {
		request._onerror = fnc;
		return request;
	};
	request.handler = function(e) {
		var response = {data : e.target.response, status: e.target.status}
		if([200, 201].indexOf(response.status) != -1)
			request._onload(response);
		else
			request._onerror(response);
	};
	request.request.addEventListener("load", request.handler);
	request.request.addEventListener("error", request.handler);
	request.request.open(verb, endpoint);
	request.request.send();
	return request;
};
lua.createElement = function(type, element) {
	_e = document.createElement(type);
	if(element['text']) {
		_e.appendChild(document.createTextNode(element['text']));
		delete element['text'];
	}
	for (var property in element)
		_e[property] = element[property];
	return _e;
};
lua.clear = function(node) {
	while (node.firstChild)
		node.removeChild(node.lastChild);
};

