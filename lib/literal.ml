type t = {
  value: string;
  datatype: Iri.t;
  language: string option
}

exception Invalid_datatype

let lang_string =
  Iri.of_string "http://www.w3.org/1999/02/22-rdf-syntax-ns#langString"

let create value ?language datatype =
  match language with
  | None -> {value; datatype; language}
  | Some _ -> if Iri.equal datatype lang_string then
    {value; datatype; language}
    else raise Invalid_datatype

let value t = t.value
let datatype t = t.datatype
let language t = t.language

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
