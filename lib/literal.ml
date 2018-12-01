type internal = {
  value: string;
  datatype: Iri.t;
  language: string option
}
type t = [`Literal of internal]

exception Invalid_datatype

let lang_string =
  Iri.of_string "http://www.w3.org/1999/02/22-rdf-syntax-ns#langString"

let create value ?language datatype =
  let internal = match language with
  | None -> {value; datatype; language}
  | Some _ -> if Iri.equal datatype lang_string then
    {value; datatype; language}
    else raise Invalid_datatype
  in
  `Literal internal

let value (`Literal l) = l.value
let datatype (`Literal l) = l.datatype
let language (`Literal l) = l.language

let to_string = value

let of_string ?language value =
  let datatype = match language with
    | None -> Iri.of_string "http://www.w3.org/2001/XMLSchema#string"
    | Some _ -> lang_string
  in
  create ?language value datatype

let of_int value =
  create (string_of_int value)
    (Iri.of_string "http://www.w3.org/2001/XMLSchema#integer")

let of_float value =
  create (string_of_float value)
    (Iri.of_string "http://www.w3.org/2001/XMLSchema#double")

let of_bool value =
  create (string_of_bool value)
    (Iri.of_string "http://www.w3.org/2001/XMLSchema#boolean")
