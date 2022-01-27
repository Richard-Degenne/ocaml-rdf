exception ParseError of string

val read : string -> Graph.t

val read_file : string -> Graph.t
