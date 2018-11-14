type t

val create : unit -> t

val equal : t -> t -> bool

val of_string : string -> t
val to_string : t -> string

