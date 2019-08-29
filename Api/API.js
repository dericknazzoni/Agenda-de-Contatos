var express = require('express');
var bodyParser = require('body-parser');
var app = express();
var json = './users.json';
var jsonFile = require(json);
var update = require ('./update_json_module');

app.use(bodyParser.urlencoded({ extended: false}));

app.use(bodyParser.json());

//---------------------------GET---------------------------------
app.get('/users', function (req, res) {
    res.writeHead(200, {'Conntent-Type': 'application/json'});
    res.end(JSON.stringify(jsonFile, null, 2));
});

app.get('/user/:id', function (req, res) {
    if (jsonFile[req.params.id]) {
        res.writeHead(200, {'Conntent-Type': 'application/json'});
        res.send(JSON.stringify(jsonFile[req.params.id], null, 2));
    }
    else {
        res.status(404).send("ID invalido");
    }
});

app.get('/users/search/:text', function(req, res) {
    var JsonSearch = update.searchJson(jsonFile, req.params.text);
    if (JsonSearch.length == 0) {
        res.status(404).send("Não há usuários que correspondem a pesquisa");
    }
    else {
        res.writeHead(200, {'Conntent-Type': 'application/json'});
        res.end(JSON.stringify(JsonSearch, null, 2));
    }
});

app.get('/users/sort/:item', function(req, res) {
    var item = req.params.item
    if (item != "id" || item != "name" || item != "username" || item != "email") {
        res.status(404).send("Item inválido");
    }
    else {
        var JsonSort = update.sortJson(jsonFile, req.params.item);
        res.writeHead(200, {'Conntent-Type': 'application/json'});
        res.end(JSON.stringify(JsonSort, null, 2));
    }
});

app.get('/users/search/:text/sort/:item', function(req, res) {
    var JsonSearch = update.searchJson(jsonFile, req.params.text);
    if (JsonSearch.length == 0) {
        res.status(404).send("Não há usuários que correspondem a pesquisa");
    }
    else {
        var JsonSort = update.sortJson(JsonSearch, req.params.item);
        res.writeHead(200, {'Conntent-Type': 'application/json'});
        res.end(JSON.stringify(JsonSort, null, 2));
    }
});

//---------------------------POST---------------------------------
app.post('/users/add', function (req, res) {
    if (Object.keys(req.body).length == 0) {
        res.status(202).send("Erro, body não enviado");
    }
    else if (!req.body.name || !req.body.username || !req.body.email || !req.body.phone || !req.body.website) {
        res.status(206).end("Body incompleto");
    }
    else if (req.body) {
        var id = update.AddJson(json, jsonFile, req.body);
        res.end("Usuário de ID: " + id + " adicionado");
        console.log("Usuário de ID: " + id + " adicionado");
    }
});

//----------------------------PUT---------------------------------
app.put('/users/mod', function (req, res) {
    if (Object.keys(req.body).length == 0) {
        res.status(202).send("Erro, body não enviado");
        console.log("")
    }
    else if (!req.body.name || !req.body.username || !req.body.email || !req.body.phone || !req.body.website) {
        res.status(206).end("Body incompleto");
    }
    else {
        update.ModJson(json, jsonFile, req.body);
        res.send("Usuário de ID: " + req.body.id + " modificado.");
        console.log("Usuário de ID: " + req.body.id + " modificado.");
    }
});

//---------------------------DELETE-------------------------------
app.delete('/users/del/:id', function(req, res) {
    if (jsonFile[req.params.id]) {
        update.DelJson(json, jsonFile, req.params.id);
        res.send("Usuário de ID: " + req.params.id + " deletado");
        console.log("Usuário de ID: " + req.params.id + " deletado");
    }
    else {
        res.status(202).send("ID invalido");
        console.log("Requisição para deletar inválda");
    }
});

app.use(function (req, res) {
    res.status(404).send("Sorry, can't find that!");
});

app.listen(8080, function () {
    console.log('server running on port ' + 8080);
});