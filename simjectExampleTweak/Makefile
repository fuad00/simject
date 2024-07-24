# ARM Mac
TARGET = simulator:clang::12.0
ARCHS = x86_64 arm64

export THEOS_PACKAGE_SCHEME = rootless
# export THEOS_PACKAGE_INSTALL_PREFIX = /opt/simject
export IPHONE_SIMULATOR_ROOT = /opt/simject
# export LOGOS_DEFAULT_GENERATOR = MobileSubstrate

# Intel Mac
# TARGET = simulator:clang::7.0
# ARCHS = x86_64 i386
# i386 slice is required for 32-bit iOS Simulator (iPhone 5, etc.)
# export TARGET_CODESIGN_FLAGS = --sign '-'

DEBUG = 0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = simjectExampleTweak
simjectExampleTweak_FILES = simjectExampleTweak.x
simjectExampleTweak_CFLAGS = -fobjc-arc -Wno-deprecated-declarations

include $(THEOS_MAKE_PATH)/tweak.mk

setup:: clean all
	@rm -f /opt/simject/$(TWEAK_NAME).dylib
	@cp -v $(THEOS_OBJ_DIR)/$(TWEAK_NAME).dylib /opt/simject/$(TWEAK_NAME).dylib
	@codesign -f -s - /opt/simject/$(TWEAK_NAME).dylib
	@cp -v $(PWD)/$(TWEAK_NAME).plist /opt/simject
