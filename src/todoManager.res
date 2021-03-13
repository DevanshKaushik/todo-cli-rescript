// https://nodejs.org/api/os.html#os_os_eol
@bs.module("os") external eol: string = "EOL"

let todoPath = "todo.txt"
let donePath = "done.txt"

// Functions for executing commands ---------------------------->

// Appends a new todo with the given text
let addTodo = todoText => {
  switch todoText {
  | Some(todoTxt) => {
      FileManager.appendTodos([todoTxt], todoPath)
      Js.log(`Added todo: "${todoTxt}"`)
    }
  | None => Js.log("Error: Missing todo string. Nothing added!")
  }
}

// Shows all the pending todos
let showTodo = () => {
  let todos = FileManager.loadTodos(todoPath)
  let todosCount = Js.Array.length(todos)

  if Belt.Array.length(todos) == 0 {
    Js.log("There are no pending todos!")
  } else {
    todos
    ->Belt.Array.reverse
    ->Belt.Array.reduceWithIndex("", (acc, todo, index) => {
      acc ++ `[${Belt.Int.toString(todosCount - index)}] ${todo}` ++ eol
    })
    ->Js.String.trim
    ->Js.log
  }
}

// Deletes a todo with the given index
let delTodo = todoId => {
  switch todoId {
  | Some(id) => {
      let todoIndex = id - 1

      let todos = FileManager.loadTodos(todoPath)

      if Belt.Array.length(todos) == 0 || todoIndex < 0 || todoIndex >= Belt.Array.length(todos) {
        Js.log(`Error: todo #${Belt.Int.toString(todoIndex + 1)} does not exist. Nothing deleted.`)
      } else {
        let todos = todos->Helper.removeEle(todoIndex)

        FileManager.writeTodos(todos, todoPath)

        Js.log(`Deleted todo #${Belt.Int.toString(id)}`)
      }
    }
  | None => Js.log("Error: Missing NUMBER for deleting todo.")
  }
}

// Marks a todo as done with the given index
let doneTodo = todoId => {
  switch todoId {
  | Some(id) => {
      let todoIndex = id - 1

      let todos = FileManager.loadTodos(todoPath)

      if Belt.Array.length(todos) == 0 || todoIndex < 0 || todoIndex >= Belt.Array.length(todos) {
        Js.log(`Error: todo #${Belt.Int.toString(todoIndex + 1)} does not exist.`)
      } else {
        let doneTodo = todos[todoIndex]
        let todos = todos->Helper.removeEle(todoIndex)

        FileManager.writeTodos(todos, todoPath)

        let parsedDoneTodo = `x ${Helper.getDate()} ${doneTodo}`

        FileManager.appendTodos([parsedDoneTodo], donePath)

        Js.log(`Marked todo #${Belt.Int.toString(id)} as done.`)
      }
    }
  | None => Js.log("Error: Missing NUMBER for marking todo as done.")
  }
}

// Shows the help text
let showHelp = () => {
  let help = "Usage :-
$ ./todo add \"todo item\"  # Add a new todo
$ ./todo ls               # Show remaining todos
$ ./todo del NUMBER       # Delete a todo
$ ./todo done NUMBER      # Complete a todo
$ ./todo help             # Show usage
$ ./todo report           # Statistics"

  Js.log(help)
}

// Shows reports of all the todos
let showReport = () => {
  let todoCount = Belt.Array.length(FileManager.loadTodos(todoPath))
  let doneCount = Belt.Array.length(FileManager.loadTodos(donePath))
  Js.log(
    Helper.getDate() ++
    " Pending : " ++
    Belt.Int.toString(todoCount) ++
    " Completed : " ++
    Belt.Int.toString(doneCount),
  )
}
