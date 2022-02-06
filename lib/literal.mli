(**
  Literals are used in graphs for values such as strings, numbers or dates.

  @see <https://www.w3.org/TR/rdf11-concepts/#section-Graph-Literal>
*)

type internal
type t = [`Literal of internal]

(** {1 Initialization } *)

(**
  Exception raised when a literal's datatype is inconsistent.

  For instance,
  {[Literal.create "Some literal" ~language: "en" Xsd.integer]}
  is not valid since language tags are reserved for [rdfs:langString].
*)
exception Invalid_datatype

(**
  Creates a new literal.

  @param value Lexical value for the literal
  @param language An optional language tag for the literal
  @param datatype Datatype for the literal

  See [Rdf.Xsd] for standard literal datatypes.
*)
val create : string -> ?language : string -> Iri.t -> [> t]

(** {1 Access} *)

val value : t -> string
val datatype : t -> Iri.t
val language : t -> string option

(** {1 Comparison} *)

val equal : t -> t -> bool
val compare : t -> t -> int

(** {1 Coercion} *)

val to_string : t -> string
val of_string : ?language : string -> string -> [> t]
val of_int : int -> [> t]
val of_float : float -> [> t]
val of_bool : bool -> [> t]
