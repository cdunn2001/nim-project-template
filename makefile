# Set $BRANCH in ENV.
BRANCH?=master

bin/nim:
	${MAKE} nim/bin/nim
	mkdir -p bin/
	cp -af nim/bin/nim bin/

nim:
	git clone -b ${BRANCH} --depth 1 git://github.com/nim-lang/nim nim/
	cd nim; git clone -b ${BRANCH} --depth 1 git://github.com/nim-lang/csources csources/

nim/bin/nim: | nim
	cd nim/csources; sh build.sh; cd ..; rm -rf csources; bin/nim c koch; ./koch boot -d:release

hi:
	echo hi
