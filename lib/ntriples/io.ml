exception ParseError of string

open Rdf

let position (lexbuf : Lexing.lexbuf) =
  let pos = lexbuf.lex_curr_p in
  Printf.sprintf "%s:%d:%d"
    pos.pos_fname pos.pos_lnum (pos.pos_cnum - pos.pos_bol + 1)

let read_lexbuf lexbuf =
  try Parser.doc Lexer.read lexbuf with
    | Parser.Error ->
        raise (
          ParseError (Printf.sprintf "%s: syntax error" (position lexbuf))
        )
    | Lexer.SyntaxError msg ->
        raise (
          ParseError (Printf.sprintf "%s: %s" (position lexbuf) msg)
        )

let read source =
  Lexing.from_string source |> read_lexbuf

let read_file filename =
  filename |> open_in |> Lexing.from_channel |> read_lexbuf

let write_iri i =
  "<" ^ Iri.to_string i ^ ">"

let write_literal l =
  let base_value = "\"" ^ (Literal.value l |> String.escaped) ^ "\"" in

  match Literal.language l with
  | Some lang -> base_value ^ "@" ^ lang
  | None -> let datatype = Literal.datatype l in
    if datatype = Xsd.string then
      base_value
    else
      base_value ^ "^^" ^ (write_iri datatype)

let write_term = function
| #Iri.t as i -> write_iri i
| #Bnode.t as b -> Bnode.to_string b
| #Literal.t as l -> write_literal l

let write_triple t =
  let s = Triple.subject t in
  let p = Triple.predicate t in
  let o = Triple.object_ t in
  (write_term s) ^ " " ^ (write_term p) ^ " " ^ (write_term o) ^ " .\n"

let write graph =
  Graph.elements graph |> List.map write_triple |> String.concat ""
