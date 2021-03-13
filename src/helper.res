// Helper Functions ---------------------------->

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
