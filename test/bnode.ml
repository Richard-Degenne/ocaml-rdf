let test_to_string () =
  let bnode = Rdf.Bnode.of_string "a" in
  Alcotest.(check string) "right fornat" "_:a" (Rdf.Bnode.to_string bnode)

let test_equal_true () =
  let bnode = Rdf.Bnode.of_string "a" in
  let other_bnode = Rdf.Bnode.of_string "a" in
  Alcotest.(check bool) "true" true (Rdf.Bnode.equal bnode other_bnode)

let test_equal_false () =
  let bnode = Rdf.Bnode.of_string "a" in
  let other_bnode = Rdf.Bnode.of_string "b" in
  Alcotest.(check bool) "false" false (Rdf.Bnode.equal bnode other_bnode)

let test_suite = [
  "to_string", `Quick, test_to_string;
  "equal true", `Quick, test_equal_true;
  "equal false", `Quick, test_equal_false
]
