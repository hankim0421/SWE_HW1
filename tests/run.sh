#!/bin/bash

cd "$(dirname "$0")"

$MYGREP -V -y -n -b -2 -A1 -B3 -C "MATCH" data/context.txt
$MYGREP -c -h -q -s -v "foo" data/coverage.txt data/empty.txt data/missing.txt
$MYGREP -l "foo" data/coverage.txt data/empty.txt
$MYGREP -L "foo" data/coverage.txt data/empty.txt
$MYGREP "foo" data/missing.txt
printf 'foo\nbar\n' | $MYGREP -c "foo"
printf 'foo\n' | $MYGREP -l "foo"
printf 'bar\n' | $MYGREP -L "foo"
$MYGREP "foo" data/coverage.txt -n
POSIXLY_CORRECT=1 $MYGREP "foo" data/coverage.txt -n
$MYGREP -- "-foo" data/coverage.txt
$MYGREP -f data/patterns_nonl.txt data/coverage.txt
printf 'foo\nbar\n' | $MYGREP -f - data/coverage.txt
$MYGREP -E -f data/ere_mega.txt data/classes.txt
$MYGREP -E -i 'ABC|Def|[A-Z]+' data/engine.txt
$MYGREP -E 'foo.*bar|[a-z]+[0-9]*' data/engine.txt
$MYGREP -E '((ab|a)+|c?d*|[a-z]{2,}|(xy?){2,3})' data/engine.txt
$MYGREP -F -f data/fixed_many.txt data/engine.txt
$MYGREP -F -i -e "foo" -e "BAR" -e "ALPHA" data/coverage.txt
$MYGREP -F -f data/long_pattern.txt data/large.txt
$MYGREP -G '^\(\(\w\+\)\|\(\W\+\)\|\([a-z]\{1,3\}\)\|\([^x]\+\)\|\(.\{1,4\}\)\)\1$' data/engine.txt
$MYGREP -G '^\(\(a*\)\|\(b\+\)\|\(c\?\)\|\(d\{2,4\}\)\)\1$' data/engine.txt
$MYGREP -G '^\(\(.\|..\)\{2,3\}\)\1$' data/engine.txt
$MYGREP -G '^\([[:digit:]]\{1,3\}\)\1$' data/engine.txt
$MYGREP -G '^\([^a-z]\+\)\1$' data/engine.txt
$MYGREP -G '^\(\w\+\)\1$' data/engine.txt
$MYGREP -X egrep '(^a|b$)|(a^b)|(c$d)|([[:digit:]]+)' data/engine.txt
$MYGREP -F -E "foo" data/coverage.txt
$MYGREP -E '[[:bogus:]]' data/coverage.txt
$MYGREP -E '\' data/coverage.txt