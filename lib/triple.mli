type subject = [Bnode.t | Iri.t]
type object_ = [Bnode.t | Iri.t | Literal.t]

type t

val create : subject -> Iri.t -> object_ -> t

val subject : t -> subject
val predicate : t -> Iri.t
val object_ : t -> object_