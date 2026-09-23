#!/bin/bash

cd "$(dirname "$0")"

# 1: V, i, n, b
$MYGREP -V -i -n -b "foo" data/coverage.txt

# 2: y, q, v + invert 중간구간
$MYGREP -y -q -v "foo" data/coverage.txt

# 3: 숫자 context + A/B
$MYGREP -2 -A1 -B3 "MATCH" data/context.txt

# 4: C + 실제 context 출력 + line/byte
$MYGREP -C -n -b "MATCH" data/context.txt

# 5: 여러 파일 + count + match/nonmatch 둘 다
$MYGREP -c "foo" data/coverage.txt data/empty.txt

# 6: 여러 파일이지만 filename 출력 금지
$MYGREP -h "foo" data/coverage.txt data/empty.txt

# 7: match 있는 파일 이름 출력
$MYGREP -l "foo" data/coverage.txt data/empty.txt

# 8: match 없는 파일 이름 출력
$MYGREP -L "foo" data/coverage.txt data/empty.txt

# 9: open 실패 + error()
$MYGREP "foo" data/missing.txt

# 10: 같은 open 실패지만 -s로 error 억제
$MYGREP -s "foo" data/missing.txt

# 11: 명시적인 "-" stdin + 일반 파일을 한 실행에서
printf 'foo from stdin\nnope\n' | $MYGREP "foo" - data/empty.txt

# 12: 마지막 newline 없는 입력 -> residue 경로
$MYGREP "foo" data/no_newline.txt

# 13: 큰 입력 -> mmap/buffer resize/save 경로
$MYGREP "foo" data/large.txt

# 14: BRE + 여러 -e + 반복 -G + backreference
$MYGREP -G -G -e '^\(ab\|a[bc]\+\)\1c\?$' -e '^\([a-c]*\)\1[[:digit:]]\{1,2\}$' -e '^\(a*\)\1$' data/coverage.txt

# 15: POSIX ERE + -e 뒤에 -f 두 번
# ere_patterns는 trailing newline 있음,
# patterns_nonl은 trailing newline 없음
$MYGREP -E -e "zz" -f data/ere_patterns.txt -f data/patterns_nonl.txt data/coverage.txt

# 16: pattern 자체를 stdin으로 전달
printf 'foo\nbar\n' | $MYGREP -f - data/coverage.txt

# 17: pattern file open 실패 -> fatal(errno)
$MYGREP -f data/missing_patterns.txt data/coverage.txt

# 18: 잘못된 option -> default/usage
$MYGREP -Z "foo" data/coverage.txt

# 19: matcher 충돌 -> fatal(0)
$MYGREP -E -F "foo" data/coverage.txt

# 20: Fcompile + multiple fixed strings + case folding
$MYGREP -F -F -y -e "foo" -e "BAR" -e "alpha" data/coverage.txt

# 21: Fexecute whole-word 경로
$MYGREP -F -w "foo" data/words.txt

# 22: Fexecute whole-line 경로
$MYGREP -F -x "foo" data/words.txt

# 23: -X로 old egrep matcher + anchor 위치 분기
$MYGREP -X egrep '(a|^b)|(c$|d)|([[:digit:]]+)' data/coverage.txt

# 24: Ecompile의 match_words / match_lines 둘 다
$MYGREP -E -w -x 'foo|bar' data/words.txt

# 25: mandatory fixed string이 거의 없는 nullable regexp
# DFA state 생성/실행 경로를 노림
$MYGREP -E '^([ab]?|[cd]*)+$' data/coverage.txt

# 26: negated class + range + star + dot
$MYGREP -E '^[^a-c0-9][A-Za-z0-9_-]*.$' data/coverage.txt

# 27: DFA의 word 관련 token들
$MYGREP -G '\<foo\>\|\bfoo\B\|\w\W' data/words.txt

# 28: anychar + repetition + backreference
# re_match_2의 backtracking을 노림
$MYGREP -G '^\(.\+\)\1$' data/coverage.txt

# 29: unbalanced bracket -> regexp compiler error 경로
$MYGREP -E '[abc' data/coverage.txt

# 30: 잘못된 range -> 또 다른 regexp compiler error 경로
$MYGREP -E '[z-a]' data/coverage.txt