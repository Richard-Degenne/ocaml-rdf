(**
  Blank nodes are anonymous labelled nodes in a graph.

  @see <https://www.w3.org/TR/rdf11-concepts/#section-blank-nodes>
*)

type internal
type t = [`Bnode of internal]

(** {1 Initialization} *)

(**
  Creates a new blank node with a random label.

  The label is constructed from a v4 (random) UUID.

  @see <https://www.itu.int/ITU-T/recommendations/rec.aspx?rec=11746>
*)
val create : unit -> [> t]

(** {1 Comparison} *)

val equal : t -> t -> bool
val compare : t -> t -> int

(** {1 String operations} *)

val of_string : string -> [> t]
val to_string : t -> string
