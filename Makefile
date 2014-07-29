SRC_DIR  := src
TEST_DIR := test

all: build

init:
	cabal sandbox init
	cabal install --only-dependencies 

build: 
	cabal configure
	cabal build

install:  
	mkdir -p $(to)
	cabal install --bindir=$(to) --ghc-option="-O"

# Removes current build and makes a clean new one (Don't use if starting from scratch!)
cleanEnv:
	make clean
	ghc-pkg unregister clafer
	rm `which clafer`
	make 

# regenerate grammar, call after clafer.cf changed
grammar:
	$(MAKE) -C $(SRC_DIR) grammar

# enable profiler
# first remove `cabal` and `ghc` folders (on win: `<User>\AppData\Roaming\cabal` and `<User>\AppData\Roaming\ghc`)
# this will reinstall everything with profiling support, build clafer, and copy it to .
prof:
	cabal update
	cabal install --only-dependencies -p --enable-executable-profiling $(GPLK_LIBS_INCLUDES) $(MAC_USR_LIB)
	cabal configure -p --enable-executable-profiling
	cabal build --ghc-options="-prof -auto-all -rtsopts"

.PHONY : test

test:
	cabal test	
	$(MAKE) -C $(TEST_DIR) test

diffRegressions:
	$(MAKE) -C $(TEST_DIR) diffRegressions

reg:
	$(MAKE) -C $(TEST_DIR) reg

clean:
	rm -f clafer
	cabal clean
	$(MAKE) -C $(SRC_DIR) clean
	$(MAKE) cleanTest

cleanTest:
	$(MAKE) -C $(TEST_DIR) clean
