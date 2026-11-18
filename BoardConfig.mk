#
# Copyright (C) 2016 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Repartitioned with falcon-repartition.zip: ext4 system and vendor,
# separate metadata and cache (see BoardConfigCommon.mk)
TARGET_MSM8226_REPARTITIONED := true
TARGET_RECOVERY_FSTAB := device/motorola/falcon/rootdir/etc/fstab.qcom

# inherit from common msm8226-common
-include device/motorola/msm8226-common/BoardConfigCommon.mk

DEVICE_PATH := device/motorola/falcon

# Assert
TARGET_OTA_ASSERT_DEVICE := xt1031,xt1032,xt1033,xt1034,falcon_umts,falcon_umtsds,falcon_cdma,falcon_retuaws,falcon,falcon_gpe

# Board
TARGET_BOARD_INFO_FILE := $(DEVICE_PATH)/board-info.txt

# Camera
BOARD_GLOBAL_CFLAGS += -DCAMERA_VENDOR_L_COMPAT

# Kernel
TARGET_KERNEL_CONFIG := falcon_defconfig

# Disable basic dexpreopt enabled from msm8226-common

# Init
TARGET_INIT_VENDOR_LIB := libinit_falcon
TARGET_RECOVERY_DEVICE_MODULES := libinit_falcon

# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE := 10485760
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 10485760
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 2147483648
BOARD_VENDORIMAGE_PARTITION_SIZE := 314572800
BOARD_CACHEIMAGE_PARTITION_SIZE := 50331648
# 8 GB units; 16 GB ones have more, it's only used for userdata.img
BOARD_USERDATAIMAGE_PARTITION_SIZE := 5116903424
BOARD_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy

# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop

# inherit from the proprietary version
-include vendor/motorola/falcon/BoardConfigVendor.mk

