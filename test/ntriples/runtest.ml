let () =
  Alcotest.run "N-Triples test suite" [
    "Io", Io.test_suite
  ]
