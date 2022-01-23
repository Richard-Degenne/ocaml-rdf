exception ParseError of string

let position (lexbuf : Lexing.lexbuf) =
  let pos = lexbuf.lex_curr_p in
  Printf.sprintf "%s:%d:%d"
    pos.pos_fname pos.pos_lnum (pos.pos_cnum - pos.pos_bol + 1)

let read_lexbuf lexbuf =
  try Ntriples_parser.doc Ntriples_lexer.read lexbuf with
    | Ntriples_parser.Error ->
        raise (
          ParseError (Printf.sprintf "%s: syntax error\n" (position lexbuf))
        )
    | Ntriples_lexer.SyntaxError msg ->
        raise (
          ParseError (Printf.sprintf "%s: %s\n" (position lexbuf) msg)
        )

let read inx =
  let lexbuf = Lexing.from_channel inx in
  read_lexbuf lexbuf

let read_file filename =
  filename |> open_in |> Lexing.from_channel |> read_lexbuf
