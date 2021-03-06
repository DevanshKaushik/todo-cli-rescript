// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Fs = require("fs");
var Os = require("os");

var encoding = "utf8";

function loadTodos(path) {
  if (!Fs.existsSync(path)) {
    return [];
  }
  var todos = Fs.readFileSync(path, {
          encoding: encoding,
          flag: "r"
        }).trim();
  return todos.split(Os.EOL);
}

function writeTodos(todos, path) {
  var todos$1 = todos.join(Os.EOL);
  Fs.writeFileSync(path, todos$1 + Os.EOL, {
        encoding: encoding,
        flag: "w"
      });
  
}

function appendTodos(todos, path) {
  var todos$1 = todos.join(Os.EOL);
  Fs.appendFileSync(path, todos$1 + Os.EOL, {
        encoding: encoding,
        flag: "a"
      });
  
}

exports.loadTodos = loadTodos;
exports.writeTodos = writeTodos;
exports.appendTodos = appendTodos;
/* fs Not a pure module */
