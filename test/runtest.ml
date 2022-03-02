let () =
  Alcotest.run "RDF Test suite" [
    "Blank nodes", Bnode.test_suite;
    "Literals", Literal.test_suite;
    "Triples", Triple.test_suite
  ]
