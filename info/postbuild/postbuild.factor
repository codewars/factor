! copyright 2024 nomennescio
USING: accessors assocs compiler.errors io kernel namespaces prettyprint sequences sequences.extras sets source-files.errors tools.errors ;
IN: postbuild

: report-missing-libraries ( -- )
  linkage-errors get values [ error>> no-such-library? ] [ error>> name>> ] filter-map members
  [ "## Missing libraries" print
    [ print ] each
  ] unless-empty
;

: run ( -- )
  report-missing-libraries
;

MAIN: run