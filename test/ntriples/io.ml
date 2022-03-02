open Rdf
open Ntriples

let test_read_cardinal () =
  let source = "<http://a> <http://b> <http://c> .\n_:a <http://b> \"a\" ." in
  let graph = Io.read source in

  Alcotest.(check int) "right cardinal" 2 (Graph.cardinal graph)

let test_read_subject () =
  let subject = "<http://a> <http://b> <http://c> ." |>
    Io.read |> Graph.choose |> Triple.subject in

  Alcotest.(check string) "right subject" "http://a" (
    match subject with
    | #Iri.t as i -> Iri.to_string i
    | _ -> assert false
  )

let test_read_predicate () =
  let predicate = "<http://a> <http://b> <http://c> ." |>
    Io.read |> Graph.choose |> Triple.predicate in

  Alcotest.(check string) "right predicate" "http://b" (
    Iri.to_string predicate
  )

let test_read_object () =
  let object_ = "<http://a> <http://b> <http://c> ." |>
    Io.read |> Graph.choose |> Triple.object_ in

  Alcotest.(check string) "right object" "http://c" (
    match object_ with
    | #Iri.t as i -> Iri.to_string i
    | _ -> assert false
  )

let test_read_file_empty () =
  let graph = Io.read_file "data/empty.nt" in
  Alcotest.(check bool) "empty" true (
    Graph.is_empty graph
  )

let test_read_file_cardinal () =
  let graph = Io.read_file "data/graph.nt" in
  Alcotest.(check int) "right cardinal" 6 (Graph.cardinal graph)

let test_read_file_syntax () =
  let graph () = Io.read_file "data/syntax_error.nt" in
  Alcotest.check_raises "Syntax error" (Io.ParseError ":1:71: Ill-formed literal") (fun () -> ignore (graph ()))

let test_read_file_grammar () =
  let graph () = Io.read_file "data/grammar_error.nt" in
  Alcotest.check_raises "Syntax error" (Io.ParseError ":1:10: syntax error") (fun () -> ignore (graph ()))

let test_write_iris () =
  let s = Iri.of_string "http://a" in
  let p = Iri.of_string "http://b" in
  let o = Iri.of_string "http://c" in
  let t = Triple.create s p o in
  let g = Graph.of_list [t] in
  Alcotest.(check string) "right triple" "<http://a> <http://b> <http://c> .\n"
    (Io.write g)

let test_write_bnodes () =
  let s = Bnode.of_string "a" in
  let p = Iri.of_string "http://b" in
  let o = Bnode.of_string "c" in
  let t = Triple.create s p o in
  let g = Graph.of_list [t] in
  Alcotest.(check string) "right triple" "_:a <http://b> _:c .\n"
    (Io.write g)

let test_write_string () =
  let s = Bnode.of_string "a" in
  let p = Iri.of_string "http://b" in
  let o = Literal.of_string "c" in
  let t = Triple.create s p o in
  let g = Graph.of_list [t] in
  Alcotest.(check string) "right triple" "_:a <http://b> \"c\" .\n"
    (Io.write g)

let test_write_lang_string () =
  let s = Bnode.of_string "a" in
  let p = Iri.of_string "http://b" in
  let o = Literal.of_string "c" ~language: "en" in
  let t = Triple.create s p o in
  let g = Graph.of_list [t] in
  Alcotest.(check string) "right triple" "_:a <http://b> \"c\"@en .\n"
    (Io.write g)

let test_write_datatype () =
  let s = Bnode.of_string "a" in
  let p = Iri.of_string "http://b" in
  let o = Literal.of_int 42 in
  let t = Triple.create s p o in
  let g = Graph.of_list [t] in
  Alcotest.(check string) "right triple" "_:a <http://b> \"42\"^^<http://www.w3.org/2001/XMLSchema#integer> .\n"
    (Io.write g)

let test_suite = [
  "read cardinal", `Quick, test_read_cardinal;
  "read subject", `Quick, test_read_subject;
  "read predicate", `Quick, test_read_predicate;
  "read object", `Quick, test_read_object;
  "read_file empty", `Quick, test_read_file_empty;
  "read_file cardinal", `Quick, test_read_file_cardinal;
  "read_file syntax error", `Quick, test_read_file_syntax;
  "read_file grammar error", `Quick, test_read_file_grammar;
  "write iris", `Quick, test_write_iris;
  "write bnodes", `Quick, test_write_bnodes;
  "write string", `Quick, test_write_string;
  "write lang_string", `Quick, test_write_lang_string;
  "write datatype", `Quick, test_write_datatype
]
