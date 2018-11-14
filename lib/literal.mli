type t

exception Invalid_datatype

val create : string -> ?language : string -> Iri.t -> t

val value : t -> string
val datatype : t -> Iri.t
val language : t -> string option

val to_string : t -> string

val of_string : ?language : string -> string -> t
val of_int : int -> t
val of_float : float -> t
val of_bool : bool -> t
