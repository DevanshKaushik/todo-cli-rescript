// https://nodejs.org/api/process.html#process_process_argv
@bs.module("process") external argv: array<string> = "argv"

// https://nodejs.org/api/os.html#os_os_eol
@bs.module("os") external eol: string = "EOL"

// Functions for executing commands ---------------------------->

// Appends a new todo with the given text
let addTodo = (path: string) => {
  if Helper.missingArg(argv) {
    Js.log("Error: Missing todo string. Nothing added!")
  } else {
    let todoText = argv[3]

    FileManager.appendTodos([todoText], path)

    Js.log(`Added todo: "${todoText}"`)
  }
}

// Shows all the pending todos
let showTodo = (path: string) => {
  let todos = FileManager.loadTodos(path)

  if Belt.Array.length(todos) == 0 {
    Js.log("There are no pending todos!")
  } else {
    let todos = Belt.Array.mapWithIndex(todos, (index, todo) => {
      `[${Belt.Int.toString(index + 1)}] ${todo}`
    })->Belt.Array.reverse

    Js.Array.joinWith(eol, todos)->Js.log
  }
}

// Deletes a todo with the given index
let delTodo = (path: string) => {
  if Helper.missingArg(argv) {
    Js.log("Error: Missing NUMBER for deleting todo.")
  } else {
    let todoIndex = Helper.stringToInt(argv[3]) - 1

    let todos = FileManager.loadTodos(path)

    if Belt.Array.length(todos) == 0 || todoIndex < 0 || todoIndex >= Belt.Array.length(todos) {
      Js.log(`Error: todo #${Belt.Int.toString(todoIndex + 1)} does not exist. Nothing deleted.`)
    } else {
      let todos = todos->Helper.removeEle(todoIndex)

      FileManager.writeTodos(todos, path)

      Js.log(`Deleted todo #${Belt.Int.toString(todoIndex + 1)}`)
    }
  }
}

// Marks a todo as done with the given index
let doneTodo = (todoPath: string, donePath: string) => {
  if Helper.missingArg(argv) {
    Js.log("Error: Missing NUMBER for marking todo as done.")
  } else {
    let todoIndex = Helper.stringToInt(argv[3]) - 1

    let todos = FileManager.loadTodos(todoPath)

    if Belt.Array.length(todos) == 0 || todoIndex < 0 || todoIndex >= Belt.Array.length(todos) {
      Js.log(`Error: todo #${Belt.Int.toString(todoIndex + 1)} does not exist.`)
    } else {
      let doneTodo = todos[todoIndex]
      let todos = todos->Helper.removeEle(todoIndex)

      FileManager.writeTodos(todos, todoPath)

      let parsedDoneTodo = `x ${Helper.getDate()} ${doneTodo}`

      FileManager.appendTodos([parsedDoneTodo], donePath)

      Js.log(`Marked todo #${Belt.Int.toString(todoIndex + 1)} as done.`)
    }
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
let showReport = (todoPath: string, donePath: string) => {
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
