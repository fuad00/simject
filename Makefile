export PREFIX = \033[1;36m>>\033[0m
export SUB_PREFIX = \033[1;36m>>>\033[0m
export DONE_PREFIX = \033[1;32m>>\033[0m

ifndef SIM_ROOT
  SIM_ROOT = /opt/simject
endif

PARENT = $(shell dirname $(SIM_ROOT))
DD_NOT_EXISTS = $(shell test -d $(SIM_ROOT); echo $$?)
DD_NOT_WRITABLE = $(shell test -w $(PARENT); echo $$?)
ifeq '$(DD_NOT_WRITABLE)' '1'
NEED_ROOT = sudo
NEED_ROOT_ASK = \033[1;32m>>\033[0m $(PARENT) is not writable. Using sudo.
endif

ifndef SYSROOT
  SYSROOT = $(shell xcode-select -p)/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk
endif

ifndef TRIPLE
  TRIPLE = $(shell clang -print-target-triple)
endif

all::
	@make -C resim build
	@make -C simject build

clean::
	@rm -rfv bin
	@make -C resim clean
	@make -C simject clean

setup:: all
	@test -w $(PARENT) || echo "$(NEED_ROOT_ASK)"
	@$(NEED_ROOT) mkdir -p $(SIM_ROOT)
	@$(NEED_ROOT) chown -R $(USER) $(SIM_ROOT)
	@echo "$(PREFIX) Copying Tweak Loader to $(SIM_ROOT)"
	@rm -f $(SIM_ROOT)/simject.dylib
	@cp bin/simject.dylib $(SIM_ROOT)
	@cp simject/simject.plist $(SIM_ROOT)
	@echo "$(PREFIX) Installing resim"
	@$(NEED_ROOT) cp bin/resim /usr/local/bin/resim
	@echo "$(DONE_PREFIX) Done. Place your tweak inside $(SIM_ROOT) to load them in the iOS Simulator."
	@echo "$(DONE_PREFIX) To load/reload tweaks, run 'resim' in your terminal"
