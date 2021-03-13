type fsConfig = {encoding: string, flag: string}

// https://nodejs.org/api/fs.html#fs_fs_existssync_path
@bs.module("fs") external existsSync: string => bool = "existsSync"

// https://nodejs.org/api/fs.html#fs_fs_readfilesync_path_options
@bs.module("fs")
external readFileSync: (string, fsConfig) => string = "readFileSync"

// https://nodejs.org/api/fs.html#fs_fs_appendfilesync_path_data_options
@bs.module("fs")
external appendFileSync: (string, string, fsConfig) => unit = "appendFileSync"

// https://nodejs.org/api/fs.html#fs_fs_writefilesync_file_data_options
@bs.module("fs")
external writeFileSync: (string, string, fsConfig) => unit = "writeFileSync"

// https://nodejs.org/api/os.html#os_os_eol
@bs.module("os") external eol: string = "EOL"

let encoding = "utf8"

// File Management Functions ---------------------------->

// Returns an array of todos fetched from the path provided
let loadTodos = (path: string) => {
  if existsSync(path) {
    let todos = readFileSync(path, {encoding: encoding, flag: "r"})->Js.String.trim
    Js.String.split(eol, todos)
  } else {
    []
  }
}

// Writes todos to the provided path file
let writeTodos = (todos: array<string>, path: string) => {
  let todos = Js.Array.joinWith(eol, todos)
  writeFileSync(path, todos ++ eol, {encoding: encoding, flag: "w"})
}

// Appends todos to the end of the provided path file
let appendTodos = (todos: array<string>, path: string) => {
  let todos = Js.Array.joinWith(eol, todos)
  appendFileSync(path, todos ++ eol, {encoding: encoding, flag: "a"})
}
