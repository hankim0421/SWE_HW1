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
$MYGREP -E -i 'FoO([[:alpha:]]|[[:upper:]]|[[:lower:]]|[[:digit:]]|[[:xdigit:]]|[[:space:]]|[[:punct:]]|[[:alnum:]]|[[:print:]]|[[:graph:]]|[[:cntrl:]])+' data/classmix.txt
$MYGREP -X egrep -x '(^a|b$)|(a^b)|(c$d)|([[:digit:]]+)' data/engine.txt
$MYGREP -F -F -w "foo" data/words.txt
$MYGREP -F -x "foo" data/words.txt
$MYGREP -F -f data/fixed_many.txt data/engine.txt
$MYGREP -E 'foo+bar' data/kw_nonexact.txt
$MYGREP -G -f data/bre_mega.txt data/regex_edges.txt
$MYGREP -E -e '^((ab|cd)+e?f*){2,4}$' -e 'a{2,}' -e 'b{0}' -e 'c{0,2}' data/engine.txt
$MYGREP -G '^\<\(\w\{2,4\}\)\>\W\1$' data/runtime_regex.txt
$MYGREP -G '^\(\w\)\B\w\b\W\1$' data/runtime_regex.txt
$MYGREP -G -f data/boundary_extend.txt data/empty.txt
$MYGREP -G -f data/macro_extend.txt data/empty.txt
printf '' | $MYGREP -G -f - data/nulls.txt
$MYGREP -e "foo" -f data/patterns_nonl.txt data/coverage.txt
$MYGREP -F -f data/fixed_overlap.txt data/fixed_overlap_input.txt
$MYGREP -G '^\([a-c]*d\)\1$' data/backtrack_maybe.txt
$MYGREP -G '^\([^x]*x\)\1$' data/backtrack_maybe.txt
$MYGREP -G '^\(f\)\1!\<.\>.*$' data/boundary_cases.txt
$MYGREP -G '^\(a*\)*\1$' data/backtrack_maybe.txt
$MYGREP -G '^\(\(a*\)b*\)\2$' data/backtrack_maybe.txt
$MYGREP -G -f data/endbuf_pattern.txt data/end_ok.txt data/end_bad.txt
printf 'foo\nbar\n' | $MYGREP -c "foo"