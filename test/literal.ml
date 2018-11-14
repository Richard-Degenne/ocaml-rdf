let test_create_exception () =
  let create_invalid () =
    Rdf.Literal.create "value" ~language:"en" 
      (Rdf.Iri.of_string "http://www.not_lang_string.com")
    |> ignore
  in
  Alcotest.check_raises "invalid datatype" Rdf.Literal.Invalid_datatype create_invalid

let test_value () =
  let value = "value" in
  let datatype = Rdf.Iri.of_string "http://www.example.com#datatype" in
  let literal = Rdf.Literal.create value datatype in
  Alcotest.(check string) "right value" value (Rdf.Literal.value literal)

let test_datatype () =
  let value = "value" in
  let datatype_value = "http://www.example.com#datatype" in
  let datatype = Rdf.Iri.of_string datatype_value in
  let literal = Rdf.Literal.create value datatype in
  Alcotest.(check string) "right datatype" datatype_value
    (Rdf.Literal.datatype literal |> Rdf.Iri.to_string)

let test_language () =
  let value = "value" in
  let language = Some "en" in
  let literal = Rdf.Literal.of_string ?language value  in
  Alcotest.(check (option string)) "right language" language
    (Rdf.Literal.language literal)

let test_no_language () =
  let value = "value" in
  let datatype = Rdf.Iri.of_string "http://www.example.com#datatype" in
  let literal = Rdf.Literal.create value datatype in
  Alcotest.(check (option string)) "language none" None
    (Rdf.Literal.language literal)

let test_suite = [
  "create invalid", `Quick, test_create_exception;
  "value", `Quick, test_value;
  "datatype", `Quick, test_datatype;
  "language", `Quick, test_language;
  "no language", `Quick, test_no_language;
]
