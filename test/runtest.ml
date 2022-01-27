let () =
  Alcotest.run "Test suite" [
    "Blank nodes", Bnode.test_suite;
    "Literals", Literal.test_suite;
    "Triples", Triple.test_suite;
    "N-Triples", Ntriples.test_suite
  ]
