TARGET = iphone:11.2:9.3
ARCHS = arm64
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = myMedusa
myMedusa_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
