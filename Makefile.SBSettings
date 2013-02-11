export TARGET=iphone:clang

include theos/makefiles/common.mk

LIBRARY_NAME = Toggle
Toggle_FILES = Toggle.m
#Toggle_FRAMEWORKS = UIKit CoreGraphics
Toggle_PRIVATE_FRAMEWORKS = BulletinBoard
Toggle_INSTALL_PATH = /var/mobile/Library/SBSettings/Toggles/Do Not Disturb/

include $(THEOS_MAKE_PATH)/library.mk

internal-stage::
	$(ECHO_NOTHING)find . -name '.DS_Store' -exec rm {} \;$(ECHO_END)
	$(ECHO_NOTHING)cp -r Themes $(THEOS_STAGING_DIR)/var/mobile/Library/SBSettings/$(ECHO_END)

after-install::
	install.exec "killall SpringBoard"

