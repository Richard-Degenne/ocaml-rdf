(**
  N-Triples is an easy-to-parse syntax for RDF graphs.

  @see <https://www.w3.org/TR/n-triples/>
*)

(** {1 Parsing} *)

exception ParseError of string

val read : string -> Graph.t

(**
  Reads a graph from a file.

  @param path Path to the file to read.
*)
val read_file : string -> Graph.t

(** {1 Serialization} *)

val write : Graph.t -> string
