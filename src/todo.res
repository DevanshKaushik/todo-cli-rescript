// https://nodejs.org/api/process.html#process_process_argv
@bs.val external argv: array<string> = "process.argv"

// Driver code ---------------------------->

let command = argv->Belt.Array.get(2)
let arg = argv->Belt.Array.get(3)
let todoId = arg->Belt.Option.flatMap(Belt.Int.fromString)

switch command {
| Some(cmd) =>
  let cmd = cmd->Js.String.trim->Js.String.toLowerCase

  switch cmd {
  | "add" => TodoManager.addTodo(arg)
  | "ls" => TodoManager.showTodo()
  | "del" => TodoManager.delTodo(todoId)
  | "done" => TodoManager.doneTodo(todoId)
  | "help" => TodoManager.showHelp()
  | "report" => TodoManager.showReport()
  | _ => TodoManager.showHelp()
  }
| None => TodoManager.showHelp()
}
