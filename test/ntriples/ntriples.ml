open Rdf

(* NOTE: Tests are executed from `runtest.ml`, which lives in `..`, relative to
this file. *)
let data_file_path path = Filename.concat "ntriples" path

let test_read_cardinal () =
  let source = "<http://a> <http://b> <http://c> .\n_:a <http://b> \"a\" ." in
  let graph = Ntriples.read source in

  Alcotest.(check int) "right cardinal" 2 (Graph.cardinal graph)

let test_read_subject () =
  let subject = "<http://a> <http://b> <http://c> ." |>
    Ntriples.read |> Graph.choose |> Triple.subject in

  Alcotest.(check string) "right subject" "http://a" (
    match subject with
    | #Iri.t as i -> Iri.to_string i
    | _ -> assert false
  )

let test_read_predicate () =
  let predicate = "<http://a> <http://b> <http://c> ." |>
    Ntriples.read |> Graph.choose |> Triple.predicate in

  Alcotest.(check string) "right predicate" "http://b" (
    Iri.to_string predicate
  )

let test_read_object () =
  let object_ = "<http://a> <http://b> <http://c> ." |>
    Ntriples.read |> Graph.choose |> Triple.object_ in

  Alcotest.(check string) "right object" "http://c" (
    match object_ with
    | #Iri.t as i -> Iri.to_string i
    | _ -> assert false
  )

let test_read_file_empty () =
  let graph = Ntriples.read_file (data_file_path "data/empty.nt") in
  Alcotest.(check bool) "empty" true (
    Graph.is_empty graph
  )

let test_read_file_cardinal () =
  let graph = Ntriples.read_file (data_file_path "data/graph.nt") in
  Alcotest.(check int) "right cardinal" 6 (Graph.cardinal graph)

let test_read_file_syntax () =
  let graph () = Ntriples.read_file (data_file_path "data/syntax_error.nt") in
  Alcotest.check_raises "Syntax error" (Ntriples.ParseError ":1:71: Ill-formed literal") (fun () -> ignore (graph ()))

let test_read_file_grammar () =
  let graph () = Ntriples.read_file (data_file_path "data/grammar_error.nt") in
  Alcotest.check_raises "Syntax error" (Ntriples.ParseError ":1:10: syntax error") (fun () -> ignore (graph ()))

let test_suite = [
  "read cardinal", `Quick, test_read_cardinal;
  "read subject", `Quick, test_read_subject;
  "read predicate", `Quick, test_read_predicate;
  "read object", `Quick, test_read_object;
  "read_file empty", `Quick, test_read_file_empty;
  "read_file cardinal", `Quick, test_read_file_cardinal;
  "read_file syntax error", `Quick, test_read_file_syntax;
  "read_file grammar error", `Quick, test_read_file_grammar;
]
