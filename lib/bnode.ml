type t = string

let equal = String.equal

let of_string id = id

let to_string t =
  Printf.sprintf "_:%s" t
