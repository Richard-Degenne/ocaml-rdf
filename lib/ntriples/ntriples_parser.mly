%token <string> IRI

%token <string> LITERAL
%token DOUBLE_CARET
%token <string> LANG_TAG

%token <string> BNODE

%token SPACE
%token PERIOD
%token NEWLINE
%token EOF

%start <Graph.t> doc

%type <Triple.t list> triples
%type <Triple.t> triple

%type <Triple.subject> subject
%type <Iri.t> iri

%%

doc:
  | t = triples EOF { Graph.of_list t }
  ;

triples:
  | (* empty *) { [] }
  | h = triple { [h] }
  | t = triples ; NEWLINE ; h = triple { h :: t }
  | t = triples ; NEWLINE { t }
  ;
triple:
  | s = subject SPACE p = iri SPACE o = object_ SPACE PERIOD {
    Triple.create s p o
  }
  ;

subject:
  | i = iri { i :> Triple.subject }
  | b = bnode { b :> Triple.subject }
  ;
object_:
  | i = iri { i :> Triple.object_ }
  | b = bnode { b :> Triple.object_ }
  | l = literal { l :> Triple.object_ }
  ;

iri:
  | s = IRI { Iri.of_string s }
  ;
bnode:
  | s = BNODE { Bnode.of_string s }
  ;
literal:
  | v = LITERAL { Literal.of_string v }
  | v = LITERAL DOUBLE_CARET datatype = iri { Literal.create v datatype }
  | v = LITERAL language = LANG_TAG { Literal.of_string ~language v }
  ;
