### Makefile for erlang.mk ppiper Project build

PROJECT = ppiper
PROJECT_DESCRIPTION = Worker to collect URL data
PROJECT_VERSION = 0.1.0

ROOT      := $(shell pwd)
REL       := ${PROJECT}-${PROJECT_VERSION}
ROOT_REL  := ${ROOT}/_rel/${PROJECT}


CMN_EFLAGS = \
	-boot start_sasl \
	-smp enable \
	-setcookie ${COOKIE} \
	+P 1000000 \
	+K true +A 160 -sbt ts \
	+C multi_time_warp +c true

DEV_EFLAGS = \
	-pa ${ROOT}/deps/*/ebin \
	-pa ${ROOT}/ebin \
	${CMN_EFLAGS}

REL_EFLAGS = \
	-pa ${ROOT_REL}/lib/*/ebin \
	${CMN_EFLAGS}


### erlang.mk settings
## 4 spaces per tab when auto-generating OTP files
SP = 4

## Change to V = 1 for verbose debugging
V = 0

## Dependencies for building
DEPS = eper

### Test parameters
TEST_DEPS = proper

dep_proper = git https://github.com/manopapad/proper v1.2

TEST_ERLC_OPTS := +debug_info +\"{cover_enabled,true}\" -I include -I test/ppiper

CT_OPTS   := -cover test/ppiper.coverspec
CT_SUITES := ppiper

DIALYZER_OPTS := -I include -Werror_handling -Wrace_conditions -Wunmatched_returns

include erlang.mk

dev:
	erl ${DEV_EFLAGS} -name ${PROJECT}@${ADDR} -s ppiper_app

rel_shell:
	erl ${REL_EFLAGS} -name ${PROJECT}@${ADDR} -s ppiper_app

### 'make dialyze' crashes on user_default loading, use my_dialyzer if necessary
my_dialyzer:
	dialyzer --plt .ppiper.plt --no_native \
		--src -r src -I include \
		-Werror_handling -Wrace_conditions -Wunmatched_returns

emacs: distclean-ct
	rm -f *~
	rm -f src/*~
	rm -f include/*~
	rm -f test/*~
	rm -f test/*/*~
	rm -f priv/www/*~
	rm -f priv/www/*/*~
