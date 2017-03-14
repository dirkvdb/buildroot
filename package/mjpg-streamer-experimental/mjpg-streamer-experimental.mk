################################################################################
#
# mjpg-streamer
#
################################################################################

# Original source is located at
# http://sourceforge.net/p/mjpg-streamer/code/commit_browser
# jacksonliam forked the repo to add support for raspberry camera
MJPG_STREAMER_EXPERIMENTAL_VERSION = 3ed3f4cad86c4ad6e58bdc70a91c3cc3c949276a
MJPG_STREAMER_EXPERIMENTAL_SITE = $(call github,jacksonliam,mjpg-streamer,$(MJPG_STREAMER_EXPERIMENTAL_VERSION))
MJPG_STREAMER_EXPERIMENTAL_LICENSE = GPLv2+
MJPG_STREAMER_EXPERIMENTAL_LICENSE_FILES = LICENSE
MJPG_STREAMER_EXPERIMENTAL_DEPENDENCIES = jpeg
MJPG_STREAMER_EXPERIMENTAL_SUBDIR = mjpg-streamer-experimental

ifeq ($(BR2_PACKAGE_LIBV4L),y)
MJPG_STREAMER_EXPERIMENTAL_DEPENDENCIES += libv4l
MJPG_STREAMER_EXPERIMENTAL_USE_LIBV4L += USE_LIBV4L2=true
endif

define MJPG_STREAMER_EXPERIMENTAL_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) CC="$(TARGET_CC)" -C $(@D)/mjpg-streamer-experimental $(MJPG_STREAMER_EXPERIMENTAL_USE_LIBV4L)
endef

define MJPG_STREAMER_EXPERIMENTAL_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)/mjpg-streamer-experimental DESTDIR=$(TARGET_DIR)/usr install
endef

$(eval $(cmake-package))
