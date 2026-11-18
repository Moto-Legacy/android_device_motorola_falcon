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

# Retrofit dynamic partitions: the bootloader only takes Motorola signed
# partition tables, so super spans the stock system and cache partitions
# instead (see BoardConfigCommon.mk)
TARGET_MSM8226_DYNAMIC_PARTITIONS := true
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
BOARD_USERDATAIMAGE_PARTITION_SIZE := 5930598400 # 5930614784 - 16384
# No cache image is built; the non-A/B OTA tools only need its size
BOARD_CACHEIMAGE_PARTITION_SIZE := 694288384

# Super: system (1023410176) + cache (694288384), metadata in system.
# /metadata is a logical partition too, created empty by the OTA.
BOARD_SUPER_PARTITION_SIZE := 1717698560
BOARD_SUPER_PARTITION_METADATA_DEVICE := system
BOARD_SUPER_PARTITION_BLOCK_DEVICES := system cache
BOARD_SUPER_PARTITION_SYSTEM_DEVICE_SIZE := 1023410176
BOARD_SUPER_PARTITION_CACHE_DEVICE_SIZE := 694288384
BOARD_SUPER_PARTITION_GROUPS := falcon_dynamic_partitions
BOARD_FALCON_DYNAMIC_PARTITIONS_PARTITION_LIST := system vendor
# super minus 4 MiB for the logical partition metadata
BOARD_FALCON_DYNAMIC_PARTITIONS_SIZE := 1713504256
BOARD_SUPER_EMPTY_PARTITIONS := metadata:falcon_dynamic_partitions:16777216
# All of super is handed out: group 1713504256 - metadata 16777216 =
# 1696727040, minus 8 MiB of slack for liblp's extent alignment across the
# two block devices. vendor 120 MiB (~100 MiB used), system the rest
# (~1424 MiB used).
BOARD_VENDORIMAGE_PARTITION_SIZE := 125829120
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1562509312
# super is looked up as /dev/block/by-name/system, which ueventd only
# creates for the boot devices
BOARD_KERNEL_CMDLINE += androidboot.super_partition=system androidboot.boot_devices=msm_sdcc.1
BOARD_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy

# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop

# inherit from the proprietary version
-include vendor/motorola/falcon/BoardConfigVendor.mk

