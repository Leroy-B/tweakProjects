ARCHS = arm64

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = CustomCCPreferences
CustomCCPreferences_FILES = CustomCCPreferences.mm
CustomCCPreferences_INSTALL_PATH = /Library/PreferenceBundles
CustomCCPreferences_FRAMEWORKS = UIKit
CustomCCPreferences_PRIVATE_FRAMEWORKS = Preferences
CustomCCPreferences_EXTRA_FRAMEWORKS += Cephei
CustomCCPreferences_EXTRA_FRAMEWORKS += CepheiPrefs

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/CustomCCPreferences.plist$(ECHO_END)