PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

# Disable excessive dalvik debug messages
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.debug.alloc=0

# Backup tool
PRODUCT_COPY_FILES += \
    vendor/krexus/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/krexus/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/krexus/prebuilt/common/bin/50-krexus.sh:system/addon.d/50-krexus.sh \
    vendor/krexus/prebuilt/common/bin/clean_cache.sh:system/bin/clean_cache.sh

# Backup services whitelist
PRODUCT_COPY_FILES += \
    vendor/krexus/config/permissions/backup.xml:system/etc/sysconfig/backup.xml

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/krexus/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# krexus-specific init file
PRODUCT_COPY_FILES += \
    vendor/krexus/prebuilt/common/etc/init.local.rc:root/init.krexus.rc

# SELinux filesystem labels
PRODUCT_COPY_FILES += \
    vendor/krexus/prebuilt/common/etc/init.d/50selinuxrelabel:system/etc/init.d/50selinuxrelabel

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Don't export PS1 in /system/etc/mkshrc.
PRODUCT_COPY_FILES += \
    vendor/krexus/prebuilt/common/etc/mkshrc:system/etc/mkshrc \
    vendor/krexus/prebuilt/common/etc/sysctl.conf:system/etc/sysctl.conf

# Fix Dialer
PRODUCT_COPY_FILES +=  \
    vendor/krexus/prebuilt/common/sysconfig/dialer_experience.xml:system/etc/sysconfig/dialer_experience.xml

# krexus-specific startup services
PRODUCT_COPY_FILES += \
    vendor/krexus/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/krexus/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit \
    vendor/krexus/prebuilt/common/bin/sysinit:system/bin/sysinit

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni

# Extra packages
PRODUCT_PACKAGES += \
    AudioFX \
    BluetoothExt \
    LatinIME \
    LiveWallpapersPicker \
    RootlessPixelLauncher


# Extra tools
PRODUCT_PACKAGES += \
    openvpn \
    e2fsck \
    mke2fs \
    tune2fs \
    fsck.exfat \
    mkfs.exfat \
    ntfsfix \
    ntfs-3g


PRODUCT_PACKAGES += \
    charger_res_images

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

# Storage manager
PRODUCT_PROPERTY_OVERRIDES += \
    ro.storage_manager.enabled=true

# easy way to extend to add more packages
-include vendor/extra/product.mk

PRODUCT_PACKAGES += \
    AndroidDarkThemeOverlay \
    SettingsDarkThemeOverlay

PRODUCT_PACKAGE_OVERLAYS += vendor/krexus/overlay/common

# Bootanimation (add if it exists)
ifneq ($(wildcard vendor/krexus/prebuilt/bootanimation/$(TARGET_DEVICE).zip),)
PRODUCT_COPY_FILES += \
        vendor/krexus/prebuilt/bootanimation/$(TARGET_DEVICE).zip:system/media/bootanimation.zip
endif

# Versioning System
# krexus first version.
PRODUCT_VERSION_MAJOR = $(shell echo $(PLATFORM_VERSION))
PRODUCT_VERSION_MINOR = $(shell echo $(TARGET_PRODCUT))
PRODUCT_VERSION_MAINTENANCE = 1.0
KREXUS_POSTFIX := -$(shell date +%Y%m%d)
ifdef KREXUS_BUILD_EXTRA
    KREXUS_POSTFIX := -$(KREXUS_BUILD_EXTRA)
endif

ifndef KREXUS_BUILD_TYPE
    KREXUS_BUILD_TYPE := UNOFFICIAL
endif

# Set all versions
KREXUS_VERSION := krexus-$(KREXUS_BUILD)-$(PRODUCT_VERSION_MAJOR)_$(PRODUCT_VERSION_MINOR)$(KREXUS_BUILD_TYPE)$(KREXUS_POSTFIX)
KREXUS_MOD_VERSION := krexus-$(KREXUS_BUILD)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)-$(KREXUS_BUILD_TYPE)$(KREXUS_POSTFIX)

PRODUCT_PROPERTY_OVERRIDES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    krexus.ota.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE) \
    ro.krexus.version=$(KREXUS_VERSION) \
    ro.modversion=$(KREXUS_MOD_VERSION) \
    ro.krexus.buildtype=$(KREXUS_BUILD_TYPE)

# Google sounds
include vendor/krexus/google/GoogleAudio.mk

# Set Pixel blue light theme on Gboard
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.ime.theme_id=5

EXTENDED_POST_PROCESS_PROPS := vendor/krexus/tools/krexus_process_props.py
