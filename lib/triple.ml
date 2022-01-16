type subject = [Bnode.t | Iri.t]
type object_ = [Bnode.t | Iri.t | Literal.t]

type t = {
  subject: subject;
  predicate: Iri.t;
  object_ : object_
}

(* let create : type a b. a subject -> Iri.t -> b object_ -> (a, b) t = *)
let create subject predicate object_ = {subject; predicate; object_}

let subject t = t.subject
let predicate t = t.predicate
let object_ t = t.object_

let compare = compare
