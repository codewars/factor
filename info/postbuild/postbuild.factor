! copyright 2024 nomennescio
USING: kernel io compiler.errors tools.errors assocs namespaces source-files.errors accessors sequences prettyprint sequences.extras sets ;
IN: postbuild

: report-missing-libraries ( -- )
  linkage-errors get values [ error>> no-such-library? ] [ error>> name>> ] filter-map members
  [ "## Missing libraries:" print
    [ print ] each
  ] unless-empty
;

: run ( -- )
  report-missing-libraries
;

MAIN: run