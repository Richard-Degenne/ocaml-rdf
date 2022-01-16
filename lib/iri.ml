type internal = Uri.t
type t = [`Iri of internal]

let create t = `Iri (Uri.of_string t)

let equal (`Iri i1) (`Iri i2) = Uri.equal i1 i2
let compare = compare

let of_string = create
let to_string (`Iri i) = Uri.to_string i
let of_uri u = `Iri u
let to_uri (`Iri i) = i
