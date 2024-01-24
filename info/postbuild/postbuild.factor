! copyright 2024 nomennescio
USING: kernel io compiler.errors tools.errors assocs namespaces source-files.errors accessors sequences prettyprint ;
IN: postbuild

: report-linkage-errors ( -- )
  ! all-errors get values errors.
  "==== LINKAGE" print
  linkage-errors get values [ error>> no-such-library? ] filter ...
  ! "==== COMPILER" print
  ! compiler-errors get values errors.
  ! "==== ALL" print
  ! all-errors get errors.
;

: run ( -- )
  report-linkage-errors
;

MAIN: run