exception ParseError of string

val read : in_channel -> Graph.t

val read_file : string -> Graph.t
