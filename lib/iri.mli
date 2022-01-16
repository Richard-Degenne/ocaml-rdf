type internal
type t = [`Iri of internal]

val create : string -> [> t]

val equal : t -> t -> bool
val compare : t -> t -> int

val of_string : string -> [> t]
val to_string : t -> string
val of_uri : Uri.t -> [> t]
val to_uri : t -> Uri.t
