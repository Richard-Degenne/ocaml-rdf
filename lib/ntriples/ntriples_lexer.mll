{
  open Ntriples_parser

  exception SyntaxError of string

(**
  Replaces Unicode escape sequences with their actual characters.
*)
  let unicode_unescape s =
    let re = Str.regexp "\\u([0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F])" in
    let int_of_hex s = int_of_string ("0x" ^ s) in
    let id_of_escape_seq s =
      let id_len =
        match String.get s 1 with
        | 'u' -> 4
        | 'U' -> 8
        | _ -> failwith "Unknown Unicode escape sequence"
      in
      String.sub s 2 id_len
    in
    let uchar_of_id s = id_of_escape_seq s |> int_of_hex |> Uchar.of_int |> Uchar.to_char |> Char.escaped in

    Str.global_substitute re uchar_of_id s
}

let white = [' ' '\t']+
let newline = ('\n' | '\r' | "\r\n")

let hex_digit = ['0'-'9' 'a'-'f' 'A'-'F']
let escape_seq = '\\' ['b' 'f' 'n' 'r' 't' '"' '\'' '\\']
let unicode_seq = (
  ("\\u" hex_digit hex_digit hex_digit hex_digit) |
  ("\\U" hex_digit hex_digit hex_digit hex_digit hex_digit hex_digit hex_digit hex_digit)
)

let iri = ([^'\x00'-'\x20' '<' '>' '"' '{' '}' '|' '^' '`' '\\'] | unicode_seq)*
let literal = ([^'"' '\\' '\n' '\r'] | unicode_seq | escape_seq)*
let bnode_label = ['a'-'z' 'A'-'Z' '0'-'9' '_' ':']+ (* TODO: Follow spec more strictly *)
let lang_tag = ['a'-'z' 'A'-'Z']+ ('-' ['a'-'z' 'A'-'Z' '0'-'9']+)*

(* TODO: Handle Unicode sequences *)

rule read = parse
| '<' { read_iri lexbuf }
| '"' { read_literal lexbuf }
| "_:" { read_bnode lexbuf }
| '@' { read_lang_tag lexbuf }
| "^^" { DOUBLE_CARET }
| '.' { PERIOD }
| white { SPACE }
| newline { Lexing.new_line lexbuf; NEWLINE }
| lang_tag { LANG_TAG (Lexing.lexeme lexbuf) }
| eof { EOF }

and read_iri = parse
| (iri as i) '>' { IRI (unicode_unescape i) }
| _ { raise (SyntaxError "Ill-formed IRI") }
| eof { raise (SyntaxError "Unterminated IRI") }

and read_literal = parse
| (literal as l) '"' { LITERAL (unicode_unescape l |> Scanf.unescaped) }
| _ { raise (SyntaxError "Ill-formed literal") }
| eof { raise (SyntaxError "Unterminated literal") }

and read_bnode = parse
| (bnode_label as b) { BNODE b }
| _ { raise (SyntaxError "Ill-formed blank node") }
| eof { raise (SyntaxError "Unterminated blank node") }

and read_lang_tag = parse
| (lang_tag as t) { LANG_TAG t }
| _ { raise (SyntaxError "Ill-formed language tag") }
| eof { raise (SyntaxError "Unterminated language tag") }
