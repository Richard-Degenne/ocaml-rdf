(**
  Triples are sets of entities that codifies {e statements} about resources.

  A triple is composed of:

  - A subject;
  - A predicate;
  - An object.

  @see <https://www.w3.org/TR/rdf11-concepts/#section-triples>
*)

type subject = [Bnode.t | Iri.t]
type object_ = [Bnode.t | Iri.t | Literal.t]
type t

(** {1 Initialization} *)

val create : subject -> Iri.t -> object_ -> t

(** {1 Access} *)

val subject : t -> subject
val predicate : t -> Iri.t
val object_ : t -> object_

(** {1 Comparison} *)

val compare : t -> t -> int
