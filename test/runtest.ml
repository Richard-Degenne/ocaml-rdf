let () =
  Alcotest.run "Test suite" [
    "Blank nodes", Bnode.test_suite
  ]
