#!/bin/bash
cd "$(dirname "$0")"

$MYGREP -V -i -n -b -2 -A1 -B3 -C -e "MATCH" -e "foo" data/context.txt data/large.txt data/residue_context.txt
$MYGREP -c -h -q -s -v "foo" data/coverage.txt data/empty.txt data/missing.txt
$MYGREP -c "foo" data/coverage.txt data/empty.txt
$MYGREP -l "foo" data/missing.txt data/coverage.txt
$MYGREP -L "foo" data/coverage.txt data/empty.txt
$MYGREP "foo" data
printf 'foo!bar\nxfoo foo\n' | $MYGREP -G -G -w '\(foo!\|foo\)\(x*\)\2' - data/word_backtrack.txt
$MYGREP -G -x '^\(ab\)\1$' data/engine.txt
$MYGREP -E -E -w -f data/ere_mega.txt data/classes.txt
$MYGREP -X egrep -x '(^a|b$)|(a^b)|(c$d)|([[:digit:]]+)' data/engine.txt
$MYGREP -F -F -w "foo" data/words.txt
$MYGREP -F -x "foo" data/words.txt
$MYGREP -F -f data/fixed_many.txt data/engine.txt
$MYGREP -E 'foo+bar' data/kw_nonexact.txt
$MYGREP -G -f data/bre_mega.txt data/regex_edges.txt
$MYGREP -G '^\(a*\)b\1$' data/regex_edges.txt
$MYGREP -G '^\([a-c]*\)z\1$' data/regex_edges.txt
$MYGREP -E 'a{0}|b{1}|c{1,3}|d{2,}|e{0,2}' data/engine.txt
$MYGREP -G -f data/boundary_extend.txt data/empty.txt
$MYGREP -G -f data/macro_extend.txt data/empty.txt
printf '' | $MYGREP -G -f - data/nulls.txt
$MYGREP -e "foo" -f data/patterns_nonl.txt data/coverage.txt
$MYGREP -f data/missing_patterns.txt data/coverage.txt
$MYGREP -E '[[:bogus:]]' data/coverage.txt
$MYGREP -E '\' data/coverage.txt
$MYGREP -G '\2' data/coverage.txt
$MYGREP -G '\(' data/coverage.txt
$MYGREP -Z "foo" data/coverage.txt
$MYGREP -F -E "foo" data/coverage.txt
$MYGREP -E -F "foo" data/coverage.txt