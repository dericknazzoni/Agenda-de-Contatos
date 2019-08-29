var fs = require('fs');

function lastItemID(jsonFile) {
    var id = 0;
    for (var i in jsonFile) {
        if (jsonFile[i].id > id) {
            id = jsonFile[i].id;
        }
    }
    return id;
}

exports.user = function(jsonFile, id) {
    return jsonFile[id];
}

exports.AddJson = function (json, jsonFile, q) {
    var id = lastItemID(jsonFile);
    var id = parseInt(id);
    var name = q.name;
    var username = q.username;
    var email = q.email;
    var phone = q.phone;
    var website = q.website;

    jsonFile[++id] = {"id":(id),"active":true, "name":name,"username":username,"email":email, "phone":phone, "website":website};

    fs.writeFile(json, JSON.stringify(jsonFile, null, 2), function(err) {
        if (err) return console.log(err);
    });
    return id;
};

exports.ModJson = function (json, jsonFile, q) {
    jsonFile[q.id].name = q.name
    jsonFile[q.id].username = q.username
    jsonFile[q.id].email = q.email
    jsonFile[q.id].phone = q.phone
    jsonFile[q.id].website = q.website

    fs.writeFile(json, JSON.stringify(jsonFile, null, 2), function(err) {
        if (err) return console.log(err);
    });
};

exports.DelJson = function (json, jsonFile, id) {
    id = parseInt(id)
    jsonFile[id].active = false;
    fs.writeFile(json, JSON.stringify(jsonFile, null, 2), function(err) {
        if (err) return console.log(err);
    });
};

exports.searchJson = function (jsonFile, text) {
    var SearchedJson = [];
    text = text.toUpperCase()

    for (var i in jsonFile) {
        if (jsonFile[i].active == true && jsonFile[i].name.toUpperCase().includes(text)) {
            SearchedJson.push(jsonFile[i]);
        }
    }

    return SearchedJson;
};

exports.sortJson = function (jsonFile, item) {
    var sortedJson = jsonFile.sort(function(obj1, obj2) {
        if (item == "id") {
            return obj1.id - obj2.id;
        }
        else if (item == "name") {
            var name1 = obj1.name.toUpperCase();
            var name2 = obj2.name.toUpperCase();
            return name1.localeCompare(name2);
        }
        else if (item == "username") {
            var username1 = obj1.username.toUpperCase();
            var username2 = obj2.username.toUpperCase();
            return username1.localeCompare(username2);
        }
        else if (item == "email") {
            var email1 = obj1.email.toUpperCase();
            var email2 = obj2.email.toUpperCase();
            return email1.localeCompare(email2);
        }
    });
    
    return sortedJson;
};