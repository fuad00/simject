ifndef SIM_ROOT
  SIM_ROOT = /opt/simject
endif

ifndef ARCH
  ARCHFLAG = 
else
  ARCHFLAG = -arch $(ARCH)
endif

ifdef SYSROOT
  SYSROOTFLAG = -isysroot $(SYSROOT)
endif

clean::
	-@rm -r out/

build : resim.mm
	@mkdir -p out
	@echo "$(PREFIX) Compiling resim for $(shell clang -print-target-triple)"
	@echo "$(SUB_PREFIX) Target directory is $(SIM_ROOT)"
	@$(CXX) resim.mm $(ARCHFLAG) $(SYSROOTFLAG) -framework Foundation -DSIM_ROOT=@\"$(SIM_ROOT)\" -o out/resim
	@echo "$(SUB_PREFIX) Signing..."
	@codesign -f -s - out/resim
	@echo "$(SUB_PREFIX) Copying library..."
	@mkdir -p ../bin
	@cp out/resim ../bin
