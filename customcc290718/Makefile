THEOS_DEVICE_IP = 192.168.1.105
TARGET = iphone:11.2:11.0
# TARGET = simulator:clang::11.0

ARCHS = arm64
# ARCHS = x86_64
DEBUG = 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = CustomCC
CustomCC_FILES = Tweak.xm
#CustomCC_EXTRA_FRAMEWORKS += Cephei
#CustomCC_EXTRA_FRAMEWORKS += CepheiPrefs

include $(THEOS_MAKE_PATH)/tweak.mk

# comment out after this for "simulator"
after-install::
	install.exec "killall -9 SpringBoard"

SUBPROJECTS += customccpreferences

include $(THEOS_MAKE_PATH)/aggregate.mk
