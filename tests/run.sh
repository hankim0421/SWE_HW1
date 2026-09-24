#!/bin/bash
cd "$(dirname "$0")"
$MYGREP -V -i -n -b -2 -A1 -B3 -C -e "MATCH" -e "foo" data/context.txt data/large.txt data/residue_context.txt
$MYGREP -c -h -q -s -v "foo" data/coverage.txt data/empty.txt data/missing.txt
$MYGREP -c -l "foo" data/coverage.txt data/empty.txt
$MYGREP -E '[[:bogus:]]' data/coverage.txt
$MYGREP -L "foo" data/coverage.txt data/empty.txt
$MYGREP "foo" data
printf 'foo!bar\nxfoo foo\n' | $MYGREP -G -G -w '\(foo!\|foo\)\(x*\)\2' - data/word_backtrack.txt
$MYGREP -E -i -w 'FoO([[:alpha:]]|[[:upper:]]|[[:lower:]]|[[:digit:]]|[[:xdigit:]]|[[:space:]]|[[:blank:]]|[[:punct:]]|[[:alnum:]]|[[:print:]]|[[:graph:]]|[[:cntrl:]]|[A-Z][a-z])+' data/classmix.txt
$MYGREP -X egrep -x '(^a|b$)|(a^b)|(c$d)|([[:digit:]]+)|([^a])' data/engine.txt
$MYGREP -F -w "foo" data/words.txt data/no_newline.txt
$MYGREP -F -x -f data/fixed_many.txt data/engine.txt
printf 'bar\n' | $MYGREP -c -L "foo"
$MYGREP -G -f data/bre_mega.txt data/regex_edges.txt data/engine.txt data/runtime_regex.txt data/lex_input.txt
$MYGREP -E -i -e '^((ab|cd)+e?f*){2,4}$' -e 'a{2,}' -e 'b{0}' -e 'c{0,2}' -f data/ere_edges.txt data/engine.txt data/classmix.txt data/lex_input.txt
$MYGREP -G '^\<\(\w\{2,4\}\)\>\W\1$' data/runtime_regex.txt
$MYGREP -G '^\(\w\)\B\w\b\W\1$' data/runtime_regex.txt
$MYGREP -G -f data/boundary_extend.txt -f data/macro_extend.txt data/empty.txt
printf '' | $MYGREP -G -f - data/nulls.txt
$MYGREP -e "foo" -f data/patterns_nonl.txt data/coverage.txt
$MYGREP -F -f data/fixed_overlap.txt data/fixed_overlap_input.txt data/tiny.txt
$MYGREP -G -x '^\([a-c]*d\)\1$' data/backtrack_maybe.txt
$MYGREP -G '^\([^x]*x\)\1$' data/backtrack_maybe.txt
$MYGREP -G '^\(f\)\1!\<.\>.*$' data/boundary_cases.txt
$MYGREP -G '^\(a*\)*\1$' data/backtrack_maybe.txt
$MYGREP -G '^\(\(a*\)b*\)\2$' data/backtrack_maybe.txt
$MYGREP -G -f data/backref_recover.txt data/backref_recover_input.txt
printf 'foo\n' | $MYGREP -c -l "foo"
$MYGREP -G -f data/runtime_core.txt data/runtime_core_lines.txt data/runtime_core_end.txt
$MYGREP -G -f data/deep_regex.txt data/deep_input.txt
$MYGREP -E '[z-a]' data/coverage.txt