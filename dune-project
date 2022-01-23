(lang dune 2.9)

(name rdf)

(generate_opam_files true)

(license GPL)

(authors "Richard Degenne <richard.degenne@gmail.com>")
(maintainers "Richard Degenne <richard.degenne@gmail.com>")

(source
  (github Richard-Degenne/ocaml-rdf))
(bug_reports "https://github.com/Richard-Degenne/ocaml-rdf/issues")
(homepage "https://github.com/Richard-Degenne/ocaml-rdf")
(documentation "https://github.com/Richard-Degenne/ocaml-rdf")

(package
  (name rdf)
  (synopsis "A new RDF library for OCaml")
  (description "A new RDF library for OCaml")
  (depends
    (ocaml (>= 4.02.3))
    (alcotest :with-test)
    uri
    uuidm
    dune
  )
)

(using menhir 2.1)
