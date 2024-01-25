! copyright 2024 nomennescio
USING: accessors assocs compiler.errors formatting io kernel namespaces prettyprint sequences sequences.extras sets source-files.errors system tools.errors ;
IN: postbuild

: report-factor-version ( -- )
  "## Factor version : " write vm-version print
  vm-git-id dup "git ID <a href=\"https://github.com/factor/factor/commit/%s\">%s</a>\n" printf
;

: report-testest-version ( -- )
  "## Testest version : " write "testest-version" get print
;

: report-missing-libraries ( -- )
  linkage-errors get values [ error>> no-such-library? ] [ error>> name>> ] filter-map members
  [ "## Missing libraries" print
    [ print ] each
  ] unless-empty
;

: run ( -- )
  report-factor-version
  report-testest-version
  report-missing-libraries
;

MAIN: run