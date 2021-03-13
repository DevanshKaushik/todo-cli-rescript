// Helper Functions ---------------------------->

// Return true if enough arguments are not provided and false otherwise
let missingArg = argv => Js.Array.length(argv) < 4 ? true : false

// Converts string to int and returns -1 for invalid value
let stringToInt = value => {
  let value = Belt.Int.fromString(value)

  switch value {
  | Some(y) => y
  | None => -1
  }
}

// Removes item with the provided index from the given array
let removeEle = (arr, index) => {
  Belt.Array.keepWithIndex(arr, (_, i) => i != index)
}

// Returns current date in yyyy-mm-dd format
let getDate: unit => string = %raw(`
function() {
  let date = new Date();
  return new Date(date.getTime() - (date.getTimezoneOffset() * 60000))
    .toISOString()
    .split("T")[0];
}`)
