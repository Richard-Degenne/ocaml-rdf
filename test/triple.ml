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

let test_suite = [
  "subject", `Quick, test_subject;
  "predicate", `Quick, test_predicate;
  "object", `Quick, test_object;
]
