# Copyright (C) 2017 The ABC rom
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Include pure telephony configuration
$(call inherit-product, vendor/krexus/config/common_full_phone.mk)

# Inherit AOSP device configuration for berkeley
$(call inherit-product, device/huawei/berkeley/aosp_berkeley.mk)

$(call inherit-product, vendor/gapps/gapps.mk)

# Override AOSP build properties
PRODUCT_NAME := berkeley
PRODUCT_DEVICE := berkeley
PRODUCT_BRAND := Huawei
PRODUCT_MODEL := Honor View 10

# Device Fingerprint
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=berkeley \
    BUILD_FINGERPRINT=Huawei/generic_a15/generic_a15:8.1.0/OPM1.171019.011/jslave01241211:user/test-keys \
    PRIVATE_BUILD_DESC="generic_a15-user 8.1.0 OPM1.171019.011 eng.jslave.20180124.121154 test-keys"

$(call inherit-product-if-exists, vendor/huawei/berkeley/berkeley-vendor.mk)
