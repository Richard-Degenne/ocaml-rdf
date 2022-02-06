(**
  Internationalized Resource Identifiers (IRI) are Unicode strings that
  identify resources in graphs.

  @see <https://www.w3.org/TR/rdf11-concepts/#section-IRIs>
  @see <https://www.ietf.org/rfc/rfc3987.txt>
*)

type internal
type t = [`Iri of internal]

(** {1 Initialization} *)

val create : string -> [> t]


(** {1 Comparison} *)

val equal : t -> t -> bool
val compare : t -> t -> int

(** {1 String operations} *)

val of_string : string -> [> t]
val to_string : t -> string

(** {1 URI operations} *)

val of_uri : Uri.t -> [> t]
val to_uri : t -> Uri.t
