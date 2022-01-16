let test_subject () =
  let subject = Rdf.Iri.create "http://www.example.com#subject" in
  let predicate = Rdf.Iri.create "http://www.example.com#predicate" in
  let object_ = Rdf.Iri.create "http://www.example.com#object" in
  let triple = Rdf.Triple.create subject predicate object_ in
  Alcotest.(check string) "right subject" "http://www.example.com#subject"
    (match Rdf.Triple.subject triple with
    `Iri _ as i -> Rdf.Iri.to_string i
    | _ -> assert false)

let test_predicate () =
  let subject = Rdf.Iri.create "http://www.example.com#subject" in
  let predicate = Rdf.Iri.create "http://www.example.com#predicate" in
  let object_ = Rdf.Iri.create "http://www.example.com#object" in
  let triple = Rdf.Triple.create subject predicate object_ in
  Alcotest.(check string) "right predicate" "http://www.example.com#predicate"
    (Rdf.Triple.predicate triple |> Rdf.Iri.to_string)

let test_object () =
  let subject = Rdf.Iri.create "http://www.example.com#subject" in
  let predicate = Rdf.Iri.create "http://www.example.com#predicate" in
  let object_ = Rdf.Iri.create "http://www.example.com#object" in
  let triple = Rdf.Triple.create subject predicate object_ in
  Alcotest.(check string) "right object" "http://www.example.com#object"
    (match Rdf.Triple.object_ triple with
    `Iri _ as i -> Rdf.Iri.to_string i
    | _ -> assert false)

let test_compare_0 () =
  let subject = Rdf.Iri.create "http://www.example.com#subject" in
  let predicate = Rdf.Iri.create "http://www.example.com#predicate" in
  let object_ = Rdf.Iri.create "http://www.example.com#object" in
  let triple = Rdf.Triple.create subject predicate object_ in
  let other_triple = Rdf.Triple.create subject predicate object_ in
  Alcotest.(check int) "0" 0 (Rdf.Triple.compare triple other_triple)

let test_compare_other_subject () =
  let subject = Rdf.Iri.create "http://www.example.com#subject" in
  let other_subject = Rdf.Bnode.of_string "other_subject" in
  let predicate = Rdf.Iri.create "http://www.example.com#predicate" in
  let object_ = Rdf.Iri.create "http://www.example.com#object" in
  let triple = Rdf.Triple.create subject predicate object_ in
  let other_triple = Rdf.Triple.create other_subject predicate object_ in
  Alcotest.(check int) "1" 1 (Rdf.Triple.compare triple other_triple)

let test_compare_other_predicate () =
  let subject = Rdf.Iri.create "http://www.example.com#subject" in
  let predicate = Rdf.Iri.create "http://www.example.com#predicate" in
  let other_predicate =
    Rdf.Iri.create "http://www.example.com#other_predicate"
  in
  let object_ = Rdf.Iri.create "http://www.example.com#object" in
  let triple = Rdf.Triple.create subject predicate object_ in
  let other_triple = Rdf.Triple.create subject other_predicate object_ in
  Alcotest.(check int) "1" 1 (Rdf.Triple.compare triple other_triple)

let test_compare_other_object () =
  let subject = Rdf.Iri.create "http://www.example.com#subject" in
  let predicate = Rdf.Iri.create "http://www.example.com#predicate" in
  let object_ = Rdf.Iri.create "http://www.example.com#object" in
  let other_object = Rdf.Literal.of_int 42 in
  let triple = Rdf.Triple.create subject predicate object_ in
  let other_triple = Rdf.Triple.create subject predicate other_object in
  Alcotest.(check int) "1" 1 (Rdf.Triple.compare triple other_triple)

let test_suite = [
  "subject", `Quick, test_subject;
  "predicate", `Quick, test_predicate;
  "object", `Quick, test_object;
  "compare 0", `Quick, test_compare_0;
  "compare other subject", `Quick, test_compare_other_subject;
  "compare other predicate", `Quick, test_compare_other_predicate;
  "compare other object", `Quick, test_compare_other_object;
]
