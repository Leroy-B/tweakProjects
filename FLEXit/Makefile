TARGET = simulator:clang::11.0
ARCHS = x86_64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = FLEXit
FLEXit_FILES = Tweak.xm $(wildcard Sources/*.m)
FLEXit_CFLAGS = -fobjc-arc -w
FLEXit_LIBRARIES = sqlite3 z

include $(THEOS_MAKE_PATH)/tweak.mk


#after-install::
#	install.exec "killall -9 SpringBoard"
