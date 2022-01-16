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

let test_equal_true () =
  let value = "value" in
  let datatype = Rdf.Iri.of_string "http://www.example.com#datatype" in
  let literal = Rdf.Literal.create value datatype in
  let other_literal = Rdf.Literal.create value datatype in
  Alcotest.(check bool) "true" true (Rdf.Literal.equal literal other_literal)

let test_equal_true_lang () =
  let value = "value" in
  let language = "en" in
  let literal = Rdf.Literal.of_string value ~language in
  let other_literal = Rdf.Literal.of_string value ~language in
  Alcotest.(check bool) "true" true (Rdf.Literal.equal literal other_literal)

let test_equal_different_value () =
  let value = "value" in
  let other_value = "other_value" in
  let datatype = Rdf.Iri.of_string "http://www.example.com#datatype" in
  let literal = Rdf.Literal.create value datatype in
  let other_literal = Rdf.Literal.create other_value datatype in
  Alcotest.(check bool) "false" false (Rdf.Literal.equal literal other_literal)

let test_equal_different_datatype () =
  let value = "value" in
  let datatype = Rdf.Iri.of_string "http://www.example.com#datatype" in
  let other_datatype =
    Rdf.Iri.of_string "http://www.example.com#other_datatype"
  in
  let literal = Rdf.Literal.create value datatype in
  let other_literal = Rdf.Literal.create value other_datatype in
  Alcotest.(check bool) "false" false (Rdf.Literal.equal literal other_literal)

let test_equal_different_lang () =
  let value = "value" in
  let language = "en" in
  let other_language = "fr" in
  let literal = Rdf.Literal.of_string value ~language in
  let other_literal = Rdf.Literal.of_string value ~language:other_language in
  Alcotest.(check bool) "false" false (Rdf.Literal.equal literal other_literal)



let test_compare_0 () =
  let value = "value" in
  let datatype = Rdf.Iri.of_string "http://www.example.com#datatype" in
  let literal = Rdf.Literal.create value datatype in
  let other_literal = Rdf.Literal.create value datatype in
  Alcotest.(check int) "0" 0 (Rdf.Literal.compare literal other_literal)

let test_compare_0_lang () =
  let value = "value" in
  let language = "en" in
  let literal = Rdf.Literal.of_string value ~language in
  let other_literal = Rdf.Literal.of_string value ~language in
  Alcotest.(check int) "0" 0 (Rdf.Literal.compare literal other_literal)

let test_compare_different_value () =
  let value = "value" in
  let other_value = "other_value" in
  let datatype = Rdf.Iri.of_string "http://www.example.com#datatype" in
  let literal = Rdf.Literal.create value datatype in
  let other_literal = Rdf.Literal.create other_value datatype in
  Alcotest.(check int) "1" 1 (Rdf.Literal.compare literal other_literal)

let test_compare_different_datatype () =
  let value = "value" in
  let datatype = Rdf.Iri.of_string "http://www.example.com#datatype" in
  let other_datatype =
    Rdf.Iri.of_string "http://www.example.com#other_datatype"
  in
  let literal = Rdf.Literal.create value datatype in
  let other_literal = Rdf.Literal.create value other_datatype in
  Alcotest.(check int) "-1" (-1) (Rdf.Literal.compare literal other_literal)

let test_compare_different_lang () =
  let value = "value" in
  let language = "en" in
  let other_language = "fr" in
  let literal = Rdf.Literal.of_string value ~language in
  let other_literal = Rdf.Literal.of_string value ~language:other_language in
  Alcotest.(check int) "1" 1 (Rdf.Literal.compare literal other_literal)



let test_of_string_value () =
  let value = "value" in
  let language = "en" in
  let literal = Rdf.Literal.of_string ~language value in
  Alcotest.(check string) "right value" value (Rdf.Literal.value literal)

let test_of_string_language () =
  let value = "value" in
  let language = "en" in
  let literal = Rdf.Literal.of_string ~language value in
  Alcotest.(check (option string)) "right value" (Some language)
    (Rdf.Literal.language literal)

let test_of_string_datatype () =
  let value = "value" in
  let language = "en" in
  let lang_string = "http://www.w3.org/1999/02/22-rdf-syntax-ns#langString" in
  let literal = Rdf.Literal.of_string ~language value in
  Alcotest.(check string) "right datatype" lang_string
    (Rdf.Literal.datatype literal |> Rdf.Iri.to_string)

let test_of_string_no_language () =
  let value = "value" in
  let string = "http://www.w3.org/2001/XMLSchema#string" in
  let literal = Rdf.Literal.of_string value in
  Alcotest.(check string) "right datatype" string
    (Rdf.Literal.datatype literal |> Rdf.Iri.to_string)

let test_of_int_value () =
  let value = 42 in
  let literal = Rdf.Literal.of_int value in
  Alcotest.(check string) "right value" "42" (Rdf.Literal.value literal)

let test_of_int_datatype () =
  let value = 42 in
  let integer = "http://www.w3.org/2001/XMLSchema#integer" in
  let literal = Rdf.Literal.of_int value in
  Alcotest.(check string) "right datatype" integer
    (Rdf.Literal.datatype literal |> Rdf.Iri.to_string)

let test_of_float_value () =
  let value = 42.0 in
  let literal = Rdf.Literal.of_float value in
  Alcotest.(check string) "right value" "42." (Rdf.Literal.value literal)

let test_of_float_datatype () =
  let value = 42.0 in
  let integer = "http://www.w3.org/2001/XMLSchema#double" in
  let literal = Rdf.Literal.of_float value in
  Alcotest.(check string) "right datatype" integer
    (Rdf.Literal.datatype literal |> Rdf.Iri.to_string)

let test_suite = [
  "create invalid", `Quick, test_create_exception;
  "value", `Quick, test_value;
  "datatype", `Quick, test_datatype;
  "language", `Quick, test_language;
  "no language", `Quick, test_no_language;
  "equal true", `Quick, test_equal_true;
  "equal true langString", `Quick, test_equal_true_lang;
  "equal different value", `Quick, test_equal_different_value;
  "equal different datatype", `Quick, test_equal_different_datatype;
  "compare 0", `Quick, test_compare_0;
  "compare 0 langString", `Quick, test_compare_0_lang;
  "compare different value", `Quick, test_compare_different_value;
  "compare different datatype", `Quick, test_compare_different_datatype;
  "of_string value", `Quick, test_of_string_value;
  "of_string language", `Quick, test_of_string_language;
  "of_string datatype", `Quick, test_of_string_datatype;
  "of_string no language", `Quick, test_of_string_no_language;
  "of_int value", `Quick, test_of_int_value;
  "of_int datatype", `Quick, test_of_int_datatype;
  "of_float value", `Quick, test_of_float_value;
  "of_float datatype", `Quick, test_of_float_datatype;
]
