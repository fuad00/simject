# Simject setup

## How to set up simject on modern Xcode

1. Clone `https://github.com/akemin-dayo/simject.git`
2. `make all`
3. Replace `@cp bin/resim /usr/local/bin/resim` with `@$(NEED_ROOT) cp bin/resim /usr/local/bin/resim` in `Makefile`
4. `make setup`
5. Clone `https://github.com/PoomSmart/substitute.git`
6. `./configure --xcode-sdk=iphonesimulator --xcode-archs=x86_64,arm64`
7. Cry because you need Python 3.9
8. Acquire Python 3.9 from somewhere (probably Xcode, 15.2 should work)
9. `/usr/bin/python3 ./configure --xcode-sdk=iphonesimulator --xcode-archs=x86_64,arm64`
10. `make`
11. Cry because it failed
12. Replace `flags.append('-miphoneos-version-min=11.0')` with `flags.append('-mios-simulator-version-min=11.0')` in configure
13. `make`
14. `mkdir out/CydiaSubstrate.framework`
15. `cp out/libsubstitute.dylib out/CydiaSubstrate.framework/CydiaSubstrate`
16. `cp -r out/CydiaSubstrate.framework /opt/simject/`
17. Compile and deploy something for simulator
    1. Open your tweak Makefile
    2. (Recommended but not required) Switch to rootless
    3. Change target to `simulator:clang::12.0`
    4. Change archs to `x86_64 arm64`
    5. Add `export TARGET_CODESIGN_FLAGS = --sign '-'` because for some reason Theos insists on signing everything for sim using an `Apple Development` cert
    6. `make`  
    7. Cry because there's no `make deploy`
    8. Realize that Substitute isn't being used and you just built it for nothing because Theos changes the default generator to internal for sim
    9. `cp .theos/obj/iphone_simulator/*.dylib /opt/simject/`
    10. `cp YOURFILTERPLIST.plist /opt/simject/`
18. Boot simulator
19. `resim`

## How to set up better simject on modern Xcode

TODO: libroot

1. Clone `https://github.com/dhinakg/simject.git`
2. `make all`
3. `make setup`
4. Extract the provided ellekit into the simject directory (`cd /opt/simject && tar xvf path/to/ellekit_1.1.3+debug_simulator.tar.gz`)  
   To build:
   1. Clone ellekit, switch to simulator branch, `gmake SIMULATOR=1`
5. Compile and deploy something for simulator
    1. Acquire dhinak's Theos fork
    2. Open your tweak Makefile
    3. Switch to rootless
    4. Change target to `simulator:clang::12.0`
    5. Change archs to `x86_64 arm64`
    6. Add `export IPHONE_SIMULATOR_ROOT = /opt/simject`
    7. `make`  
    8. Cry because you're probably using private frameworks and you need a sim SDK
    9. Make yourself a sim SDK
    10. Adjust target to use sim SDK
    11. `make`
    12. `make install`
6. Boot simulator
7. `resim`
