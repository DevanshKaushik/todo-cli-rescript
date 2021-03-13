/* https://nodejs.org/api/process.html#process_process_argv */
@bs.val external argv: array<string> = "process.argv"

let todo_path = "todo.txt"
let done_path = "done.txt"

// Driver code ---------------------------->

if Js.Array.length(argv) <= 2 {
  TodoManager.showHelp()
} else {
  let cmd = argv[2]->Js.String.trim->Js.String.toLowerCase
  switch cmd {
  | "add" => TodoManager.addTodo(todo_path)
  | "ls" => TodoManager.showTodo(todo_path)
  | "del" => TodoManager.delTodo(todo_path)
  | "done" => TodoManager.doneTodo(todo_path, done_path)
  | "help" => TodoManager.showHelp()
  | "report" => TodoManager.showReport(todo_path, done_path)
  | _ => TodoManager.showHelp()
  }
}
