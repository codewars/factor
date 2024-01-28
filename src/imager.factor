USING: memory namespaces sequences system vocabs.hierarchy vocabs.loader ;
IN: codewars.imager

"resource:extra" vocab-roots get remove [ load-root ] each

! Preload useful/common vocabs from extras
{ "arrays" "assocs" "combinators" "coroutines" "decimals" "generators"
"grouping" "infix" "lists" "lru-cache" "math" "multisets" "pair-rocket"
"pairs" "path-finding" "qw" "sequences" "sets" "sorting" "splitting"
"trees" "variants" }
[ load ] each

image-path save-image-and-exit
