# grep 2.0 테스트 과제용 Makefile
#

CC       := gcc
SRC      := src/grep.c
CFLAGS   := -g -O0 -w -Isrc
COVFLAGS := -fprofile-arcs -ftest-coverage
BUILD    := build

.PHONY: all cov report reset clean

all: $(BUILD)/grep

$(BUILD)/grep: $(SRC) | $(BUILD)
	$(CC) $(CFLAGS) -o $@ $(SRC)

cov: $(BUILD)/grep-cov

$(BUILD)/grep-cov: $(SRC) | $(BUILD)
	$(CC) $(CFLAGS) $(COVFLAGS) -o $@ $(SRC)

$(BUILD):
	@mkdir -p $(BUILD)

reset:
	@rm -f $(BUILD)/*.gcda *.gcov
	@echo "커버리지 데이터를 초기화했습니다."

check: cov
	@if [ ! -f $(BUILD)/grep-cov-grep.gcda ]; then \
	    echo "오류: 커버리지 데이터가 없습니다."; \
	    exit 1; \
	fi
	@gcov -b -o $(BUILD) $(BUILD)/grep-cov-grep > $(BUILD)/gcov.log 2>&1
	@echo "------------------------------------------------"
	@printf "  라인 커버리지 : %s\n" "$$(grep -m1 'Lines executed'      $(BUILD)/gcov.log | cut -d: -f2)"
	@printf "  분기 커버리지 : %s   <- 채점 지표\n" "$$(grep -m1 'Taken at least once' $(BUILD)/gcov.log | cut -d: -f2)"
	@echo "------------------------------------------------"
	@echo "  미커버 코드는 grep.c.gcov 에서 '#####' 를 찾아보세요."

report: cov
	@rm -f $(BUILD)/*.gcda *.gcov
	@MYGREP="$(CURDIR)/$(BUILD)/grep-cov" timeout 300 bash tests/run.sh >/dev/null 2>&1 || true
	@if [ ! -f $(BUILD)/grep-cov-grep.gcda ]; then \
	    echo "오류: 커버리지 데이터가 생성되지 않았습니다."; \
	    echo "      tests/run.sh 안에서 \$$MYGREP 을 실제로 호출했는지 확인하세요."; \
	    exit 1; \
	fi
	@gcov -b -o $(BUILD) $(BUILD)/grep-cov-grep > $(BUILD)/gcov.log 2>&1
	@echo "------------------------------------------------"
	@printf "  라인 커버리지 : %s\n" "$$(grep -m1 'Lines executed'      $(BUILD)/gcov.log | cut -d: -f2)"
	@printf "  분기 커버리지 : %s   <- 채점 지표\n" "$$(grep -m1 'Taken at least once' $(BUILD)/gcov.log | cut -d: -f2)"
	@echo "------------------------------------------------"
	@echo "  미커버 코드는 grep.c.gcov 에서 '#####' 를 찾아보세요."

clean:
	@rm -rf $(BUILD) *.gcov
