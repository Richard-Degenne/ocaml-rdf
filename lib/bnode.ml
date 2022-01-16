type internal = string
type t = [`Bnode of internal]

let equal (`Bnode b1) (`Bnode b2) = String.equal b1 b2
let compare  = compare

let of_string b = `Bnode b

let create () =
  `Bnode (Uuidm.(v `V4 |> to_string))

let to_string (`Bnode t) =
  Printf.sprintf "_:%s" t
