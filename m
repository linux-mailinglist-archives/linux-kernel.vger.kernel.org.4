Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DDB5EF328
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235434AbiI2KO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235324AbiI2KOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:14:42 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3890A6175;
        Thu, 29 Sep 2022 03:14:35 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id m4so1411129wrr.5;
        Thu, 29 Sep 2022 03:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=kUCEW4hb+oJmhcZzMTiI6t0KaPO4enyGYaKIYLk4vmg=;
        b=a6rR3A0zrrTaFi4PnR5xWW6eBUmPzLWNhGMoXVC7lQA+QSwL4DE3dA5D5InrYBGoba
         u6fDJ4E2HuCdVIDLvpWAH7jdomDuqfIEaHvBEfI0LiPcff4ELllTrJevAF3xRUw6PAzE
         ENIsL8dlmlbNIfjEmo4QvSmCJWX3VnyK9KAyaRD3+5CjEPRsT5fizEoTOwdkzlkhZ7fz
         9k++XdP3HBqNsKBqFwpA8PUiDSB+/8qzMP7L9v/6grDHwUN62AdJX8EuLwvaEW2L5EiE
         TrRHWjLS9Hjn6b5qpqe6BlTaE4H2cMyTk/lmlrGlSI9IfmlenE4w3zv26gAl/uB63oI3
         A9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kUCEW4hb+oJmhcZzMTiI6t0KaPO4enyGYaKIYLk4vmg=;
        b=KaIt2MwgnPMBZdTr0RwtxhU9QSGJVbkI4LqveqiFURFw1dhZrkwefA4/lDqofIu+dE
         8rMmaNVqEM4xKjM+5WIfLucvrAWWihbfeiAVlyztbqHZ7uXVvL48KkqyRENaHEtCMRQk
         qyD8AmN/VMFItvco4x1rnWmbXAAWJmA9ZZG4As8Klkt4EsB+JdRXYN17iaJ11FyRNvSl
         LSvYfY3z1ePdkfGxif9Bg5w2hKU0gMriH2mN+gIki8ZP5LNIpUkUpMOobTlTG4JSlza5
         Qt1spSDwRpJ8zmnJVOHAHpKv5XBX2k7D9J5TQeUqvalpSa1IjdVdeytBrQRyzWxtUhK0
         g2TQ==
X-Gm-Message-State: ACrzQf1I/XY/oLZGCJfMrBBkdgtdB9xhH7MW4IMhHqa/3hrsvlRBJi3+
        SKO9fOuu7oJGxeV4iSumGvih5Rtwm3g=
X-Google-Smtp-Source: AMsMyM4A6yL6O4svmsmNnNQcjRWWFOK7in2kH9DWyO1tf1rnCe6ERSVumMsd3/zpleIvpWfGHkv4Ow==
X-Received: by 2002:a5d:4d87:0:b0:22c:a868:1fd6 with SMTP id b7-20020a5d4d87000000b0022ca8681fd6mr1708439wru.295.1664446473502;
        Thu, 29 Sep 2022 03:14:33 -0700 (PDT)
Received: from felia.fritz.box (200116b826e11200b190ebfd45660ea6.dip.versatel-1u1.de. [2001:16b8:26e1:1200:b190:ebfd:4566:ea6])
        by smtp.gmail.com with ESMTPSA id h18-20020adfaa92000000b00228dd80d78asm4236341wrc.86.2022.09.29.03.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 03:14:32 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] arm: update config files
Date:   Thu, 29 Sep 2022 12:14:28 +0200
Message-Id: <20220929101428.31746-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up config files by:
  - removing configs that were deleted in the past
  - removing configs not in tree and without recently pending patches
  - adding new configs that are replacements for old configs in the file

For some detailed information, see Link.

Link: https://lore.kernel.org/kernel-janitors/20220929090645.1389-1-lukas.bulwahn@gmail.com/

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/arm/configs/am200epdkit_defconfig    |  7 +------
 arch/arm/configs/assabet_defconfig        |  3 +--
 arch/arm/configs/axm55xx_defconfig        | 11 ++---------
 arch/arm/configs/badge4_defconfig         |  3 ---
 arch/arm/configs/bcm2835_defconfig        |  2 --
 arch/arm/configs/cerfcube_defconfig       |  3 ---
 arch/arm/configs/clps711x_defconfig       |  7 +------
 arch/arm/configs/cm_x300_defconfig        |  6 ------
 arch/arm/configs/cns3420vb_defconfig      |  1 -
 arch/arm/configs/colibri_pxa270_defconfig |  4 ----
 arch/arm/configs/colibri_pxa300_defconfig |  1 -
 arch/arm/configs/collie_defconfig         |  2 +-
 arch/arm/configs/corgi_defconfig          | 13 +++----------
 arch/arm/configs/davinci_all_defconfig    |  2 --
 arch/arm/configs/dove_defconfig           |  5 +----
 arch/arm/configs/ep93xx_defconfig         |  4 ----
 arch/arm/configs/eseries_pxa_defconfig    |  4 +---
 arch/arm/configs/exynos_defconfig         |  2 --
 arch/arm/configs/ezx_defconfig            | 16 ++--------------
 arch/arm/configs/footbridge_defconfig     |  3 ---
 arch/arm/configs/h5000_defconfig          |  3 ---
 arch/arm/configs/hackkit_defconfig        |  2 --
 arch/arm/configs/hisi_defconfig           |  1 -
 arch/arm/configs/imx_v4_v5_defconfig      | 12 ------------
 arch/arm/configs/iop32x_defconfig         |  7 -------
 arch/arm/configs/jornada720_defconfig     |  3 +--
 arch/arm/configs/keystone_defconfig       |  5 -----
 arch/arm/configs/lart_defconfig           |  3 ---
 arch/arm/configs/lpc18xx_defconfig        |  4 ----
 arch/arm/configs/lpc32xx_defconfig        |  4 ----
 arch/arm/configs/lpd270_defconfig         |  4 ----
 arch/arm/configs/lubbock_defconfig        |  3 +--
 arch/arm/configs/magician_defconfig       |  4 ----
 arch/arm/configs/mainstone_defconfig      |  1 -
 arch/arm/configs/milbeaut_m10v_defconfig  |  1 -
 arch/arm/configs/mini2440_defconfig       |  6 ------
 arch/arm/configs/mmp2_defconfig           |  1 -
 arch/arm/configs/moxart_defconfig         |  8 +-------
 arch/arm/configs/mps2_defconfig           |  6 +-----
 arch/arm/configs/mv78xx0_defconfig        |  3 ---
 arch/arm/configs/mvebu_v5_defconfig       |  3 ---
 arch/arm/configs/mxs_defconfig            |  4 ----
 arch/arm/configs/neponset_defconfig       |  6 ++----
 arch/arm/configs/netwinder_defconfig      |  9 ---------
 arch/arm/configs/nhk8815_defconfig        |  1 -
 arch/arm/configs/omap1_defconfig          |  4 ----
 arch/arm/configs/omap2plus_defconfig      |  5 -----
 arch/arm/configs/orion5x_defconfig        |  1 -
 arch/arm/configs/palmz72_defconfig        |  3 ---
 arch/arm/configs/pcm027_defconfig         |  4 ----
 arch/arm/configs/pleb_defconfig           |  3 ---
 arch/arm/configs/pxa168_defconfig         |  1 -
 arch/arm/configs/pxa255-idp_defconfig     |  1 -
 arch/arm/configs/pxa3xx_defconfig         |  6 +-----
 arch/arm/configs/pxa910_defconfig         |  2 --
 arch/arm/configs/pxa_defconfig            | 10 ----------
 arch/arm/configs/qcom_defconfig           | 12 +-----------
 arch/arm/configs/rpc_defconfig            | 10 ----------
 arch/arm/configs/sama5_defconfig          |  4 ++--
 arch/arm/configs/shannon_defconfig        |  3 +--
 arch/arm/configs/simpad_defconfig         |  6 +-----
 arch/arm/configs/socfpga_defconfig        |  1 -
 arch/arm/configs/spear13xx_defconfig      |  1 -
 arch/arm/configs/spear3xx_defconfig       |  1 -
 arch/arm/configs/spear6xx_defconfig       |  1 -
 arch/arm/configs/spitz_defconfig          | 13 +++----------
 arch/arm/configs/stm32_defconfig          |  1 -
 arch/arm/configs/tct_hammer_defconfig     |  1 -
 arch/arm/configs/trizeps4_defconfig       | 12 ------------
 arch/arm/configs/viper_defconfig          |  4 +---
 arch/arm/configs/vt8500_v6_v7_defconfig   |  3 +--
 arch/arm/configs/xcep_defconfig           |  4 ----
 arch/arm/configs/zeus_defconfig           |  4 +---
 73 files changed, 31 insertions(+), 293 deletions(-)

diff --git a/arch/arm/configs/am200epdkit_defconfig b/arch/arm/configs/am200epdkit_defconfig
index 3f633eaf9770..2c0ed3107b02 100644
--- a/arch/arm/configs/am200epdkit_defconfig
+++ b/arch/arm/configs/am200epdkit_defconfig
@@ -21,9 +21,6 @@ CONFIG_NET=y
 CONFIG_PACKET=m
 CONFIG_UNIX=y
 CONFIG_INET=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 CONFIG_BT=m
@@ -50,7 +47,6 @@ CONFIG_BLK_DEV_SD=m
 CONFIG_ATA=m
 CONFIG_PATA_PCMCIA=m
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_SMC91X=m
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_PXA=y
@@ -64,7 +60,6 @@ CONFIG_FB_MODE_HELPERS=y
 CONFIG_FB_TILEBLITTING=y
 CONFIG_FB_PXA=y
 CONFIG_FB_PXA_PARAMETERS=y
-CONFIG_FB_MBX=m
 CONFIG_FB_VIRTUAL=m
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_SOUND=m
@@ -86,7 +81,6 @@ CONFIG_JFFS2_RUBIN=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_DEBUG_KERNEL=y
-# CONFIG_DETECT_SOFTLOCKUP is not set
 CONFIG_CRYPTO=y
 CONFIG_CRYPTO_CBC=m
 CONFIG_CRYPTO_ECB=m
@@ -95,3 +89,4 @@ CONFIG_CRYPTO_ARC4=m
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_DEBUG_PREEMPT is not set
 CONFIG_DEBUG_USER=y
+# CONFIG_LOCKUP_DETECTOR is not set
diff --git a/arch/arm/configs/assabet_defconfig b/arch/arm/configs/assabet_defconfig
index 8ba8eb7a4adf..d52b39070ad3 100644
--- a/arch/arm/configs/assabet_defconfig
+++ b/arch/arm/configs/assabet_defconfig
@@ -28,8 +28,6 @@ CONFIG_MTD_SA1100=y
 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
-CONFIG_NET_PCMCIA=y
 CONFIG_PCMCIA_PCNET=y
 CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_KEYBOARD is not set
@@ -53,3 +51,4 @@ CONFIG_JFFS2_FS=y
 CONFIG_NFS_FS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_DEBUG_USER=y
+CONFIG_ARCNET=y
diff --git a/arch/arm/configs/axm55xx_defconfig b/arch/arm/configs/axm55xx_defconfig
index bfbaa2df3be5..937f768df6c8 100644
--- a/arch/arm/configs/axm55xx_defconfig
+++ b/arch/arm/configs/axm55xx_defconfig
@@ -34,7 +34,6 @@ CONFIG_ARM_ERRATA_754327=y
 CONFIG_ARM_ERRATA_764369=y
 CONFIG_ARM_ERRATA_775420=y
 CONFIG_ARM_ERRATA_798181=y
-CONFIG_PCIE_AXXIA=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=16
 CONFIG_HOTPLUG_CPU=y
@@ -85,8 +84,6 @@ CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_CFI_STAA=y
 CONFIG_MTD_PHYSMAP=y
 CONFIG_MTD_PHYSMAP_OF=y
-CONFIG_MTD_M25P80=y
-CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_EEPROM_AT24=y
@@ -103,7 +100,6 @@ CONFIG_NETDEVICES=y
 CONFIG_TUN=y
 CONFIG_VETH=y
 CONFIG_VIRTIO_NET=y
-# CONFIG_NET_CADENCE is not set
 # CONFIG_NET_VENDOR_BROADCOM is not set
 # CONFIG_NET_VENDOR_CIRRUS is not set
 # CONFIG_NET_VENDOR_FARADAY is not set
@@ -182,7 +178,6 @@ CONFIG_USB=y
 CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
 CONFIG_USB_EHCI_HCD=y
 # CONFIG_USB_EHCI_TT_NEWSCHED is not set
-CONFIG_USB_EHCI_HCD_AXXIA=y
 CONFIG_USB_STORAGE=y
 CONFIG_MMC=y
 CONFIG_MMC_ARMMMCI=y
@@ -195,18 +190,14 @@ CONFIG_PL320_MBOX=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_EXT4_FS=y
 CONFIG_AUTOFS4_FS=y
 CONFIG_FUSE_FS=y
 CONFIG_CUSE=y
 CONFIG_FSCACHE=y
 CONFIG_FSCACHE_STATS=y
-CONFIG_FSCACHE_HISTOGRAM=y
 CONFIG_FSCACHE_DEBUG=y
-CONFIG_FSCACHE_OBJECT_LIST=y
 CONFIG_CACHEFILES=y
-CONFIG_CACHEFILES_HISTOGRAM=y
 CONFIG_ISO9660_FS=y
 CONFIG_UDF_FS=y
 CONFIG_MSDOS_FS=y
@@ -234,3 +225,5 @@ CONFIG_DEBUG_USER=y
 CONFIG_CRYPTO_GCM=y
 CONFIG_CRYPTO_SHA256=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
+CONFIG_MTD_SPI_NOR=y
+# CONFIG_NET_VENDOR_CADENCE is not set
diff --git a/arch/arm/configs/badge4_defconfig b/arch/arm/configs/badge4_defconfig
index 337e5c9718ae..533c75857a0a 100644
--- a/arch/arm/configs/badge4_defconfig
+++ b/arch/arm/configs/badge4_defconfig
@@ -22,7 +22,6 @@ CONFIG_BT_HCIUART=m
 CONFIG_BT_HCIVHCI=m
 # CONFIG_FW_LOADER is not set
 CONFIG_MTD=y
-CONFIG_MTD_DEBUG=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_ADV_OPTIONS=y
@@ -60,7 +59,6 @@ CONFIG_WATCHDOG=y
 CONFIG_SOFT_WATCHDOG=m
 CONFIG_SA1100_WATCHDOG=m
 CONFIG_SOUND=y
-CONFIG_SOUND_PRIME=y
 CONFIG_USB=y
 CONFIG_USB_MON=y
 CONFIG_USB_ACM=m
@@ -96,7 +94,6 @@ CONFIG_CRAMFS=m
 CONFIG_MINIX_FS=m
 CONFIG_NFS_FS=m
 CONFIG_NFS_V3=y
-CONFIG_SMB_FS=m
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index a51babd178c2..198e494a413f 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -21,7 +21,6 @@ CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_EMBEDDED=y
 CONFIG_PROFILING=y
-CONFIG_CC_STACKPROTECTOR_REGULAR=y
 CONFIG_ARCH_MULTI_V6=y
 CONFIG_ARCH_BCM=y
 CONFIG_ARCH_BCM2835=y
@@ -177,7 +176,6 @@ CONFIG_PRINTK_TIME=y
 CONFIG_BOOT_PRINTK_DELAY=y
 CONFIG_DYNAMIC_DEBUG=y
 CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_LOCKUP_DETECTOR=y
 CONFIG_DEBUG_FS=y
 CONFIG_KGDB=y
diff --git a/arch/arm/configs/cerfcube_defconfig b/arch/arm/configs/cerfcube_defconfig
index 9ada868e2648..2ef4dce62ca1 100644
--- a/arch/arm/configs/cerfcube_defconfig
+++ b/arch/arm/configs/cerfcube_defconfig
@@ -37,8 +37,6 @@ CONFIG_MTD_SA1100=y
 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_RAM=m
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
-CONFIG_NET_PCI=y
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
@@ -63,7 +61,6 @@ CONFIG_NFS_V3=y
 CONFIG_NFS_V4=y
 CONFIG_NFSD=m
 CONFIG_NFSD_V4=y
-CONFIG_SMB_FS=m
 CONFIG_NLS=y
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_ISO8859_1=m
diff --git a/arch/arm/configs/clps711x_defconfig b/arch/arm/configs/clps711x_defconfig
index 92481b2a88fa..5e4fde8839a3 100644
--- a/arch/arm/configs/clps711x_defconfig
+++ b/arch/arm/configs/clps711x_defconfig
@@ -7,11 +7,6 @@ CONFIG_EMBEDDED=y
 CONFIG_JUMP_LABEL=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_ARCH_CLPS711X=y
-CONFIG_ARCH_AUTCPU12=y
-CONFIG_ARCH_CDB89712=y
-CONFIG_ARCH_CLEP7312=y
-CONFIG_ARCH_EDB7211=y
-CONFIG_ARCH_P720T=y
 CONFIG_AEABI=y
 # CONFIG_COREDUMP is not set
 CONFIG_SLOB=y
@@ -33,7 +28,6 @@ CONFIG_MTD_PLATRAM=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_GPIO=y
 CONFIG_NETDEVICES=y
-# CONFIG_NET_CADENCE is not set
 # CONFIG_NET_VENDOR_BROADCOM is not set
 CONFIG_CS89x0=y
 CONFIG_CS89x0_PLATFORM=y
@@ -83,3 +77,4 @@ CONFIG_DEBUG_LL=y
 CONFIG_EARLY_PRINTK=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
+# CONFIG_NET_VENDOR_CADENCE is not set
diff --git a/arch/arm/configs/cm_x300_defconfig b/arch/arm/configs/cm_x300_defconfig
index 95144e380b4b..5824114d46c4 100644
--- a/arch/arm/configs/cm_x300_defconfig
+++ b/arch/arm/configs/cm_x300_defconfig
@@ -30,9 +30,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_IP_PNP_RARP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 CONFIG_BT=m
@@ -55,9 +52,7 @@ CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_DM9000=y
-CONFIG_DM9000_DEBUGLEVEL=0
 CONFIG_DM9000_FORCE_SIMPLE_PHY_POLL=y
 # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 CONFIG_INPUT_EVDEV=y
@@ -132,7 +127,6 @@ CONFIG_RTC_DRV_V3020=y
 CONFIG_RTC_DRV_PXA=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_FS_XATTR is not set
 CONFIG_MSDOS_FS=m
 CONFIG_VFAT_FS=m
 CONFIG_TMPFS=y
diff --git a/arch/arm/configs/cns3420vb_defconfig b/arch/arm/configs/cns3420vb_defconfig
index b3aab97c0728..afa7d13f27f6 100644
--- a/arch/arm/configs/cns3420vb_defconfig
+++ b/arch/arm/configs/cns3420vb_defconfig
@@ -57,7 +57,6 @@ CONFIG_EXT2_FS_XATTR=y
 CONFIG_AUTOFS4_FS=y
 CONFIG_FSCACHE=y
 CONFIG_TMPFS=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_ARM_UNWIND is not set
 CONFIG_CRC_CCITT=y
 CONFIG_DEBUG_FS=y
diff --git a/arch/arm/configs/colibri_pxa270_defconfig b/arch/arm/configs/colibri_pxa270_defconfig
index 8357d721c69c..ebedd21d61b1 100644
--- a/arch/arm/configs/colibri_pxa270_defconfig
+++ b/arch/arm/configs/colibri_pxa270_defconfig
@@ -9,7 +9,6 @@ CONFIG_LOG_BUF_SHIFT=14
 CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
-CONFIG_KALLSYMS_EXTRA_PASS=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_PXA=y
 CONFIG_MACH_COLIBRI=y
@@ -66,12 +65,10 @@ CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0x4000000
 CONFIG_MTD_NAND_DISKONCHIP_PROBE_HIGH=y
 CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE=y
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=8
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_DM9000=y
 CONFIG_PHYLIB=y
 CONFIG_HOSTAP=y
@@ -106,7 +103,6 @@ CONFIG_LOGO=y
 CONFIG_USB=y
 CONFIG_USB_SERIAL=m
 CONFIG_USB_GADGET=m
-CONFIG_USB_GADGET_DUMMY_HCD=y
 CONFIG_MMC=y
 CONFIG_NEW_LEDS=y
 CONFIG_RTC_CLASS=y
diff --git a/arch/arm/configs/colibri_pxa300_defconfig b/arch/arm/configs/colibri_pxa300_defconfig
index 42adfefdb6dc..618f830b2a04 100644
--- a/arch/arm/configs/colibri_pxa300_defconfig
+++ b/arch/arm/configs/colibri_pxa300_defconfig
@@ -20,7 +20,6 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_SG=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_AX88796=y
 CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_KEYBOARD is not set
diff --git a/arch/arm/configs/collie_defconfig b/arch/arm/configs/collie_defconfig
index 2a2d2cb3ce2e..6926ddefbd71 100644
--- a/arch/arm/configs/collie_defconfig
+++ b/arch/arm/configs/collie_defconfig
@@ -84,5 +84,5 @@ CONFIG_FONT_MINI_4x6=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
-# CONFIG_DETECT_SOFTLOCKUP is not set
 CONFIG_DEBUG_MUTEXES=y
+# CONFIG_LOCKUP_DETECTOR is not set
diff --git a/arch/arm/configs/corgi_defconfig b/arch/arm/configs/corgi_defconfig
index df84640f4f57..7376b3088513 100644
--- a/arch/arm/configs/corgi_defconfig
+++ b/arch/arm/configs/corgi_defconfig
@@ -34,11 +34,9 @@ CONFIG_INET6_IPCOMP=m
 CONFIG_IPV6_TUNNEL=m
 CONFIG_NETFILTER=y
 CONFIG_IP_NF_IPTABLES=m
-CONFIG_IP_NF_MATCH_ADDRTYPE=m
 CONFIG_IP_NF_MATCH_ECN=m
 CONFIG_IP_NF_MATCH_TTL=m
 CONFIG_IP_NF_FILTER=m
-CONFIG_IP_NF_TARGET_LOG=m
 CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_RAW=m
 CONFIG_IP_NF_ARPTABLES=m
@@ -70,7 +68,6 @@ CONFIG_BT_HCIBFUSB=m
 CONFIG_BT_HCIDTL1=m
 CONFIG_BT_HCIBT3C=m
 CONFIG_BT_HCIBLUECARD=m
-CONFIG_BT_HCIBTUART=m
 CONFIG_BT_HCIVHCI=m
 CONFIG_PCCARD=y
 CONFIG_PCMCIA_PXA2XX=y
@@ -84,15 +81,12 @@ CONFIG_MTD_NAND_SHARPSL=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=m
-CONFIG_CHR_DEV_OSST=m
 CONFIG_BLK_DEV_SR=m
 CONFIG_CHR_DEV_SG=m
-CONFIG_SCSI_MULTI_LUN=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_ATA=y
 CONFIG_PATA_PCMCIA=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_PCMCIA_PCNET=m
 CONFIG_PPP=m
 CONFIG_PPP_BSDCOMP=m
@@ -103,7 +97,6 @@ CONFIG_USB_PEGASUS=m
 CONFIG_USB_RTL8150=m
 CONFIG_USB_USBNET=m
 # CONFIG_USB_NET_CDC_SUBSET is not set
-CONFIG_NET_PCMCIA=y
 CONFIG_INPUT_FF_MEMLESS=m
 # CONFIG_INPUT_MOUSEDEV is not set
 CONFIG_INPUT_EVDEV=y
@@ -131,7 +124,6 @@ CONFIG_BACKLIGHT_CLASS_DEVICE=y
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_SOUND=y
-CONFIG_SOUND_PRIME=y
 CONFIG_HID_A4TECH=m
 CONFIG_HID_APPLE=m
 CONFIG_HID_BELKIN=m
@@ -209,8 +201,6 @@ CONFIG_CRAMFS=m
 CONFIG_NFS_FS=m
 CONFIG_NFS_V3=y
 CONFIG_NFS_V4=y
-CONFIG_SMB_FS=m
-CONFIG_SMB_NLS_DEFAULT=y
 CONFIG_NFS_V4=m
 CONFIG_NLS_DEFAULT="cp437"
 CONFIG_NLS_CODEPAGE_437=y
@@ -245,3 +235,6 @@ CONFIG_FONT_8x16=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_DEBUG_PREEMPT is not set
 # CONFIG_FTRACE is not set
+CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
+CONFIG_NETFILTER_XT_TARGET_LOG=m
+CONFIG_ARCNET=y
diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 821d966c95a5..d8076a051f18 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -63,7 +63,6 @@ CONFIG_MTD_CFI=m
 CONFIG_MTD_CFI_INTELEXT=m
 CONFIG_MTD_CFI_AMDSTD=m
 CONFIG_MTD_PHYSMAP=m
-CONFIG_MTD_M25P80=m
 CONFIG_MTD_RAW_NAND=m
 CONFIG_MTD_NAND_DAVINCI=m
 CONFIG_MTD_SPI_NOR=m
@@ -145,7 +144,6 @@ CONFIG_VIDEO_ADV7343=m
 CONFIG_DRM=m
 CONFIG_DRM_TILCDC=m
 CONFIG_DRM_SIMPLE_BRIDGE=m
-CONFIG_DRM_TINYDRM=m
 CONFIG_TINYDRM_ST7586=m
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
diff --git a/arch/arm/configs/dove_defconfig b/arch/arm/configs/dove_defconfig
index ff37f46c82fb..035f6fde4341 100644
--- a/arch/arm/configs/dove_defconfig
+++ b/arch/arm/configs/dove_defconfig
@@ -8,7 +8,6 @@ CONFIG_ARCH_MULTI_V7=y
 CONFIG_ARCH_DOVE=y
 CONFIG_MACH_DOVE_DB=y
 CONFIG_MACH_CM_A510=y
-CONFIG_MACH_DOVE_DT=y
 CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
 CONFIG_ARM_APPENDED_DTB=y
@@ -43,7 +42,6 @@ CONFIG_MTD_CFI_GEOMETRY=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_STAA=y
 CONFIG_MTD_PHYSMAP=y
-CONFIG_MTD_M25P80=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
@@ -99,7 +97,6 @@ CONFIG_DMADEVICES=y
 CONFIG_MV_XOR=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_FS_XATTR is not set
 CONFIG_EXT4_FS=y
 CONFIG_ISO9660_FS=y
 CONFIG_JOLIET=y
@@ -115,7 +112,6 @@ CONFIG_NLS_CODEPAGE_850=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_ISO8859_2=y
 CONFIG_NLS_UTF8=y
-CONFIG_TIMER_STATS=y
 CONFIG_CRYPTO_NULL=y
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
@@ -140,3 +136,4 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_DEBUG_USER=y
+CONFIG_MACH_DOVE=y
diff --git a/arch/arm/configs/ep93xx_defconfig b/arch/arm/configs/ep93xx_defconfig
index 3154125321c5..bbb3e6fa1b59 100644
--- a/arch/arm/configs/ep93xx_defconfig
+++ b/arch/arm/configs/ep93xx_defconfig
@@ -35,9 +35,6 @@ CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_SYN_COOKIES=y
 CONFIG_IPV6=y
-# CONFIG_INET6_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET6_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET6_XFRM_MODE_BEET is not set
 # CONFIG_IPV6_SIT is not set
 # CONFIG_FW_LOADER is not set
 CONFIG_MTD=y
@@ -105,7 +102,6 @@ CONFIG_DMADEVICES=y
 CONFIG_EP93XX_DMA=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_FS_XATTR is not set
 CONFIG_EXT4_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
diff --git a/arch/arm/configs/eseries_pxa_defconfig b/arch/arm/configs/eseries_pxa_defconfig
index b4c2e6457e04..2b2a7df19c9e 100644
--- a/arch/arm/configs/eseries_pxa_defconfig
+++ b/arch/arm/configs/eseries_pxa_defconfig
@@ -25,7 +25,6 @@ CONFIG_INET=y
 # CONFIG_IPV6 is not set
 CONFIG_CFG80211=m
 CONFIG_MAC80211=m
-CONFIG_MAC80211_RC_PID=y
 # CONFIG_MAC80211_RC_MINSTREL is not set
 CONFIG_PCCARD=y
 CONFIG_PCMCIA=m
@@ -45,7 +44,6 @@ CONFIG_PATA_PCMCIA=m
 CONFIG_NETDEVICES=y
 CONFIG_HERMES=m
 CONFIG_PCMCIA_HERMES=m
-CONFIG_NET_PCMCIA=y
 # CONFIG_INPUT_MOUSEDEV is not set
 CONFIG_INPUT_EVDEV=m
 # CONFIG_KEYBOARD_ATKBD is not set
@@ -89,9 +87,9 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_CRYPTO_CBC=m
 CONFIG_CRYPTO_PCBC=m
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_FONTS=y
 CONFIG_FONT_MINI_4x6=y
+CONFIG_ARCNET=y
diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 31e8e0c0ee1b..825b298527ad 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -90,7 +90,6 @@ CONFIG_NFC_S3FWRN5_I2C=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_CRYPTOLOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=65536
 CONFIG_SCSI=y
@@ -357,7 +356,6 @@ CONFIG_CRYPTO_XTS=m
 CONFIG_CRYPTO_MD5=m
 CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_SHA3=m
-CONFIG_CRYPTO_SALSA20=m
 CONFIG_CRYPTO_LZO=m
 CONFIG_CRYPTO_LZ4=m
 CONFIG_CRYPTO_USER_API_HASH=m
diff --git a/arch/arm/configs/ezx_defconfig b/arch/arm/configs/ezx_defconfig
index ef7b0a0aee3a..d88363649df1 100644
--- a/arch/arm/configs/ezx_defconfig
+++ b/arch/arm/configs/ezx_defconfig
@@ -43,9 +43,6 @@ CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_IP_PNP_RARP=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
@@ -103,15 +100,12 @@ CONFIG_NETFILTER_XT_MATCH_STRING=m
 CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
 CONFIG_NETFILTER_XT_MATCH_TIME=m
 CONFIG_NETFILTER_XT_MATCH_U32=m
-CONFIG_NF_CONNTRACK_IPV4=m
 CONFIG_IP_NF_IPTABLES=m
-CONFIG_IP_NF_MATCH_ADDRTYPE=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
 CONFIG_IP_NF_MATCH_TTL=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
-CONFIG_IP_NF_TARGET_LOG=m
 CONFIG_IP_NF_TARGET_MASQUERADE=m
 CONFIG_IP_NF_TARGET_NETMAP=m
 CONFIG_IP_NF_TARGET_REDIRECT=m
@@ -124,7 +118,6 @@ CONFIG_IP_NF_RAW=m
 CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
-CONFIG_NF_CONNTRACK_IPV6=m
 CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP6_NF_MATCH_AH=m
 CONFIG_IP6_NF_MATCH_EUI64=m
@@ -172,7 +165,6 @@ CONFIG_MTD_OTP=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_PXA2XX=y
 CONFIG_BLK_DEV_LOOP=m
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_NETDEVICES=y
@@ -215,7 +207,6 @@ CONFIG_REGULATOR_DEBUG=y
 CONFIG_REGULATOR_PCAP=y
 CONFIG_MEDIA_SUPPORT=y
 CONFIG_VIDEO_DEV=y
-CONFIG_MEDIA_TUNER_CUSTOMISE=y
 CONFIG_RADIO_TEA5764=y
 # CONFIG_MEDIA_TUNER_MC44S803 is not set
 # CONFIG_MEDIA_TUNER_MT2060 is not set
@@ -234,9 +225,7 @@ CONFIG_RADIO_TEA5764=y
 # CONFIG_MEDIA_TUNER_TEA5767 is not set
 # CONFIG_MEDIA_TUNER_XC2028 is not set
 # CONFIG_MEDIA_TUNER_XC5000 is not set
-# CONFIG_VIDEO_HELPER_CHIPS_AUTO is not set
 CONFIG_VIDEO_PXA27x=y
-# CONFIG_V4L_USB_DRIVERS is not set
 CONFIG_FB=y
 CONFIG_FB_PXA=y
 CONFIG_FB_PXA_OVERLAY=y
@@ -307,9 +296,7 @@ CONFIG_NFS_V3=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_NFSD=m
 CONFIG_NFSD_V3_ACL=y
-CONFIG_SMB_FS=m
 CONFIG_CIFS=m
-CONFIG_CIFS_STATS=y
 CONFIG_CIFS_XATTR=y
 CONFIG_CIFS_POSIX=y
 CONFIG_NLS_CODEPAGE_437=m
@@ -366,7 +353,6 @@ CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_SHA256=m
 CONFIG_CRYPTO_SHA512=m
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_AES=m
 CONFIG_CRYPTO_ARC4=m
 CONFIG_CRYPTO_BLOWFISH=m
@@ -387,3 +373,5 @@ CONFIG_DEBUG_FS=y
 CONFIG_PROVE_LOCKING=y
 # CONFIG_FTRACE is not set
 CONFIG_DEBUG_USER=y
+CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
+CONFIG_NETFILTER_XT_TARGET_LOG=m
diff --git a/arch/arm/configs/footbridge_defconfig b/arch/arm/configs/footbridge_defconfig
index 87c489337d0e..87d12bd312a4 100644
--- a/arch/arm/configs/footbridge_defconfig
+++ b/arch/arm/configs/footbridge_defconfig
@@ -3,7 +3,6 @@ CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
-# CONFIG_HOTPLUG is not set
 CONFIG_ARCH_MULTI_V4=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_FOOTBRIDGE=y
@@ -55,10 +54,8 @@ CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_NET_VENDOR_3COM=y
 CONFIG_VORTEX=y
-CONFIG_NET_PCI=y
 CONFIG_NE2K_PCI=y
 CONFIG_PPP=m
 CONFIG_PPP_BSDCOMP=m
diff --git a/arch/arm/configs/h5000_defconfig b/arch/arm/configs/h5000_defconfig
index d01f1a6bd04d..29dba91e5287 100644
--- a/arch/arm/configs/h5000_defconfig
+++ b/arch/arm/configs/h5000_defconfig
@@ -26,9 +26,6 @@ CONFIG_UNIX=y
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
 CONFIG_IP_PNP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 CONFIG_MTD=y
diff --git a/arch/arm/configs/hackkit_defconfig b/arch/arm/configs/hackkit_defconfig
index 3c91a851fd08..c372108daf57 100644
--- a/arch/arm/configs/hackkit_defconfig
+++ b/arch/arm/configs/hackkit_defconfig
@@ -17,8 +17,6 @@ CONFIG_INET=y
 CONFIG_SYN_COOKIES=y
 # CONFIG_IPV6 is not set
 CONFIG_MTD=y
-CONFIG_MTD_DEBUG=y
-CONFIG_MTD_DEBUG_VERBOSE=3
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_INTELEXT=y
diff --git a/arch/arm/configs/hisi_defconfig b/arch/arm/configs/hisi_defconfig
index 0376a65e8bc1..85650232f377 100644
--- a/arch/arm/configs/hisi_defconfig
+++ b/arch/arm/configs/hisi_defconfig
@@ -60,7 +60,6 @@ CONFIG_FB_SIMPLE=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_EHCI_HCD=y
-CONFIG_USB_EHCI_MXC=y
 CONFIG_USB_EHCI_HCD_PLATFORM=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_HCD_PLATFORM=y
diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index 711a79e9be00..8a5c76c62cb9 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -12,11 +12,6 @@ CONFIG_ARCH_MULTI_V4T=y
 CONFIG_ARCH_MULTI_V5=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_MXC=y
-CONFIG_MACH_MX21ADS=y
-CONFIG_MACH_MX27ADS=y
-CONFIG_MACH_MX27_3DS=y
-CONFIG_MACH_IMX27_VISSTRIM_M10=y
-CONFIG_MACH_PCA100=y
 CONFIG_SOC_IMX1=y
 CONFIG_SOC_IMX25=y
 CONFIG_SOC_IMX27=y
@@ -35,9 +30,6 @@ CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 CONFIG_NETFILTER=y
@@ -121,16 +113,12 @@ CONFIG_SND=y
 # CONFIG_SND_SPI is not set
 CONFIG_SND_SOC=y
 CONFIG_SND_IMX_SOC=y
-CONFIG_SND_SOC_MX27VIS_AIC32X4=y
-CONFIG_SND_SOC_PHYCORE_AC97=y
 CONFIG_SND_SOC_EUKREA_TLV320=y
-CONFIG_SND_SOC_IMX_MC13783=y
 CONFIG_SND_SOC_FSL_ASOC_CARD=y
 CONFIG_SND_SOC_SGTL5000=y
 CONFIG_USB_HID=m
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
-CONFIG_USB_EHCI_MXC=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_CHIPIDEA=y
 CONFIG_USB_CHIPIDEA_UDC=y
diff --git a/arch/arm/configs/iop32x_defconfig b/arch/arm/configs/iop32x_defconfig
index 19e30e790d35..afc22266354d 100644
--- a/arch/arm/configs/iop32x_defconfig
+++ b/arch/arm/configs/iop32x_defconfig
@@ -24,9 +24,6 @@ CONFIG_IP_MULTICAST=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_IPV6=y
-# CONFIG_INET6_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET6_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET6_XFRM_MODE_BEET is not set
 # CONFIG_IPV6_SIT is not set
 CONFIG_MTD=y
 CONFIG_MTD_REDBOOT_PARTS=y
@@ -54,8 +51,6 @@ CONFIG_MD_RAID10=y
 CONFIG_MD_RAID456=y
 CONFIG_BLK_DEV_DM=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
-CONFIG_NET_PCI=y
 CONFIG_E100=y
 CONFIG_E1000=y
 CONFIG_R8169=y
@@ -82,7 +77,6 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_RS5C372=y
 CONFIG_DMADEVICES=y
 CONFIG_INTEL_IOP_ADMA=y
-CONFIG_NET_DMA=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_TMPFS=y
@@ -104,7 +98,6 @@ CONFIG_CRYPTO_MICHAEL_MIC=y
 CONFIG_CRYPTO_SHA1=y
 CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_SHA512=y
-CONFIG_CRYPTO_TGR192=y
 CONFIG_CRYPTO_WP512=y
 CONFIG_CRYPTO_AES=y
 CONFIG_CRYPTO_ANUBIS=y
diff --git a/arch/arm/configs/jornada720_defconfig b/arch/arm/configs/jornada720_defconfig
index ae1d68da4f2a..b7ab861152e9 100644
--- a/arch/arm/configs/jornada720_defconfig
+++ b/arch/arm/configs/jornada720_defconfig
@@ -27,8 +27,6 @@ CONFIG_ATA=y
 CONFIG_PATA_PCMCIA=y
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=y
-CONFIG_NET_ETHERNET=y
-CONFIG_NET_PCMCIA=y
 CONFIG_INPUT_MOUSEDEV_SCREEN_X=640
 CONFIG_INPUT_MOUSEDEV_SCREEN_Y=240
 # CONFIG_KEYBOARD_ATKBD is not set
@@ -96,3 +94,4 @@ CONFIG_DEBUG_KERNEL=y
 # CONFIG_FTRACE is not set
 CONFIG_DEBUG_LL=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
+CONFIG_ARCNET=y
diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index 4a5b9adbf2a1..fba38dcd3ce5 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -62,9 +62,6 @@ CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
 CONFIG_IP_PIMSM_V2=y
 CONFIG_INET_AH=y
 CONFIG_INET_IPCOMP=y
-CONFIG_INET6_XFRM_MODE_TRANSPORT=m
-CONFIG_INET6_XFRM_MODE_TUNNEL=m
-CONFIG_INET6_XFRM_MODE_BEET=m
 CONFIG_IPV6_SIT=m
 CONFIG_IPV6_MULTIPLE_TABLES=y
 CONFIG_IPV6_SUBTREES=y
@@ -90,7 +87,6 @@ CONFIG_NETFILTER_XT_MATCH_MARK=y
 CONFIG_NETFILTER_XT_MATCH_MULTIPORT=y
 CONFIG_NETFILTER_XT_MATCH_PKTTYPE=y
 CONFIG_NETFILTER_XT_MATCH_STATE=y
-CONFIG_NF_CONNTRACK_IPV4=y
 CONFIG_IP_NF_IPTABLES=y
 CONFIG_IP_NF_MATCH_AH=y
 CONFIG_IP_NF_MATCH_ECN=y
@@ -118,7 +114,6 @@ CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_PLATRAM=y
-CONFIG_MTD_M25P80=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_DAVINCI=y
 CONFIG_MTD_SPI_NOR=y
diff --git a/arch/arm/configs/lart_defconfig b/arch/arm/configs/lart_defconfig
index 916177d07a39..2598979d1057 100644
--- a/arch/arm/configs/lart_defconfig
+++ b/arch/arm/configs/lart_defconfig
@@ -19,14 +19,11 @@ CONFIG_INET=y
 CONFIG_SYN_COOKIES=y
 # CONFIG_IPV6 is not set
 CONFIG_MTD=y
-CONFIG_MTD_DEBUG=y
-CONFIG_MTD_DEBUG_VERBOSE=1
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_LART=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=m
-CONFIG_NET_ETHERNET=y
 CONFIG_PPP=m
 CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
diff --git a/arch/arm/configs/lpc18xx_defconfig b/arch/arm/configs/lpc18xx_defconfig
index 56eae6a0a311..1ef49f595b5f 100644
--- a/arch/arm/configs/lpc18xx_defconfig
+++ b/arch/arm/configs/lpc18xx_defconfig
@@ -31,9 +31,6 @@ CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 # CONFIG_WIRELESS is not set
@@ -150,7 +147,6 @@ CONFIG_JFFS2_FS=y
 CONFIG_CRC_ITU_T=y
 CONFIG_CRC7=y
 CONFIG_PRINTK_TIME=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
diff --git a/arch/arm/configs/lpc32xx_defconfig b/arch/arm/configs/lpc32xx_defconfig
index fabb66a53350..a8bac13c6dd5 100644
--- a/arch/arm/configs/lpc32xx_defconfig
+++ b/arch/arm/configs/lpc32xx_defconfig
@@ -32,9 +32,6 @@ CONFIG_IP_MULTICAST=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_WIRELESS is not set
 CONFIG_DEVTMPFS=y
@@ -48,7 +45,6 @@ CONFIG_MTD_NAND_SLC_LPC32XX=y
 CONFIG_MTD_NAND_MLC_LPC32XX=y
 CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_CRYPTOLOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=1
 CONFIG_BLK_DEV_RAM_SIZE=16384
diff --git a/arch/arm/configs/lpd270_defconfig b/arch/arm/configs/lpd270_defconfig
index b0c21a99a0a8..ce6bc678bdf6 100644
--- a/arch/arm/configs/lpd270_defconfig
+++ b/arch/arm/configs/lpd270_defconfig
@@ -14,9 +14,6 @@ CONFIG_INET=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_IPV6=y
-# CONFIG_INET6_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET6_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET6_XFRM_MODE_BEET is not set
 # CONFIG_IPV6_SIT is not set
 CONFIG_MTD=y
 CONFIG_MTD_REDBOOT_PARTS=y
@@ -28,7 +25,6 @@ CONFIG_MTD_CFI_GEOMETRY=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_BLK_DEV_NBD=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_SMC91X=y
 CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_MOUSE is not set
diff --git a/arch/arm/configs/lubbock_defconfig b/arch/arm/configs/lubbock_defconfig
index 4fc744c96196..1b82923b44e3 100644
--- a/arch/arm/configs/lubbock_defconfig
+++ b/arch/arm/configs/lubbock_defconfig
@@ -24,8 +24,6 @@ CONFIG_MTD_CFI_GEOMETRY=y
 # CONFIG_MTD_CFI_I1 is not set
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
-CONFIG_NET_PCMCIA=y
 CONFIG_PCMCIA_PCNET=y
 CONFIG_SMC91X=y
 CONFIG_INPUT_EVDEV=y
@@ -51,3 +49,4 @@ CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
+CONFIG_ARCNET=y
diff --git a/arch/arm/configs/magician_defconfig b/arch/arm/configs/magician_defconfig
index 5a8776f6aba3..9a234752b1e6 100644
--- a/arch/arm/configs/magician_defconfig
+++ b/arch/arm/configs/magician_defconfig
@@ -29,9 +29,6 @@ CONFIG_UNIX=y
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
 CONFIG_IP_PNP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 CONFIG_BT=m
@@ -144,7 +141,6 @@ CONFIG_FONT_MINI_4x6=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_SCHED_DEBUG is not set
-CONFIG_TIMER_STATS=y
 # CONFIG_DEBUG_PREEMPT is not set
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
diff --git a/arch/arm/configs/mainstone_defconfig b/arch/arm/configs/mainstone_defconfig
index 096cd7bc667a..2f6f1384dc9b 100644
--- a/arch/arm/configs/mainstone_defconfig
+++ b/arch/arm/configs/mainstone_defconfig
@@ -22,7 +22,6 @@ CONFIG_MTD_CFI_GEOMETRY=y
 # CONFIG_MTD_CFI_I1 is not set
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_SMC91X=y
 CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_MOUSE is not set
diff --git a/arch/arm/configs/milbeaut_m10v_defconfig b/arch/arm/configs/milbeaut_m10v_defconfig
index a2e25bf843cc..951193a28cd9 100644
--- a/arch/arm/configs/milbeaut_m10v_defconfig
+++ b/arch/arm/configs/milbeaut_m10v_defconfig
@@ -23,7 +23,6 @@ CONFIG_SMP=y
 CONFIG_HAVE_ARM_ARCH_TIMER=y
 CONFIG_NR_CPUS=16
 CONFIG_THUMB2_KERNEL=y
-# CONFIG_THUMB2_AVOID_R_ARM_THM_JUMP11 is not set
 # CONFIG_ARM_PATCH_IDIV is not set
 CONFIG_HIGHMEM=y
 CONFIG_ARCH_FORCE_MAX_ORDER=12
diff --git a/arch/arm/configs/mini2440_defconfig b/arch/arm/configs/mini2440_defconfig
index 86e00f684e16..2d2d81d29eee 100644
--- a/arch/arm/configs/mini2440_defconfig
+++ b/arch/arm/configs/mini2440_defconfig
@@ -303,12 +303,8 @@ CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MICHAEL_MIC=y
-CONFIG_CRYPTO_RMD128=m
 CONFIG_CRYPTO_RMD160=m
-CONFIG_CRYPTO_RMD256=m
-CONFIG_CRYPTO_RMD320=m
 CONFIG_CRYPTO_SHA512=m
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_ARC4=y
@@ -318,7 +314,6 @@ CONFIG_CRYPTO_CAST5=m
 CONFIG_CRYPTO_CAST6=m
 CONFIG_CRYPTO_FCRYPT=m
 CONFIG_CRYPTO_KHAZAD=m
-CONFIG_CRYPTO_SALSA20=m
 CONFIG_CRYPTO_SEED=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
@@ -330,7 +325,6 @@ CONFIG_FONTS=y
 CONFIG_FONT_8x8=y
 CONFIG_FONT_MINI_4x6=y
 CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_KERNEL=y
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_DEBUG_FS=y
diff --git a/arch/arm/configs/mmp2_defconfig b/arch/arm/configs/mmp2_defconfig
index 7984640e994e..fbad5cc356c2 100644
--- a/arch/arm/configs/mmp2_defconfig
+++ b/arch/arm/configs/mmp2_defconfig
@@ -29,7 +29,6 @@ CONFIG_MTD_ONENAND_GENERIC=y
 CONFIG_MTD_RAW_NAND=y
 # CONFIG_BLK_DEV is not set
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_SMC91X=y
 # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 # CONFIG_INPUT_KEYBOARD is not set
diff --git a/arch/arm/configs/moxart_defconfig b/arch/arm/configs/moxart_defconfig
index ea31f116d577..9a0b4dfa4826 100644
--- a/arch/arm/configs/moxart_defconfig
+++ b/arch/arm/configs/moxart_defconfig
@@ -29,9 +29,6 @@ CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 # CONFIG_WIRELESS is not set
@@ -48,12 +45,10 @@ CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_COMPLEX_MAPPINGS=y
 CONFIG_MTD_PHYSMAP=y
 CONFIG_MTD_PHYSMAP_OF=y
-CONFIG_PROC_DEVICETREE=y
 CONFIG_NETDEVICES=y
 CONFIG_NETCONSOLE=y
 CONFIG_NETCONSOLE_DYNAMIC=y
 # CONFIG_NET_VENDOR_ARC is not set
-# CONFIG_NET_CADENCE is not set
 # CONFIG_NET_VENDOR_BROADCOM is not set
 # CONFIG_NET_VENDOR_CIRRUS is not set
 # CONFIG_NET_VENDOR_FARADAY is not set
@@ -86,7 +81,6 @@ CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
 CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_HW_RANDOM is not set
-CONFIG_GPIO_MOXART=y
 CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_GPIO=y
 CONFIG_POWER_SUPPLY=y
@@ -122,7 +116,6 @@ CONFIG_CRC32_BIT=y
 CONFIG_DMA_API_DEBUG=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_KGDB=y
 CONFIG_DEBUG_PAGEALLOC=y
 # CONFIG_SLUB_DEBUG is not set
@@ -140,3 +133,4 @@ CONFIG_DEBUG_LL_UART_8250=y
 CONFIG_DEBUG_UART_PHYS=0x98200000
 CONFIG_DEBUG_UART_VIRT=0xf9820000
 CONFIG_EARLY_PRINTK=y
+# CONFIG_NET_VENDOR_CADENCE is not set
diff --git a/arch/arm/configs/mps2_defconfig b/arch/arm/configs/mps2_defconfig
index 3ed73f184d83..25821af5deac 100644
--- a/arch/arm/configs/mps2_defconfig
+++ b/arch/arm/configs/mps2_defconfig
@@ -28,9 +28,6 @@ CONFIG_UNIX=y
 CONFIG_INET=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 # CONFIG_WIRELESS is not set
@@ -40,7 +37,6 @@ CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_NETDEVICES=y
 # CONFIG_NET_CORE is not set
 # CONFIG_NET_VENDOR_ARC is not set
-# CONFIG_NET_CADENCE is not set
 # CONFIG_NET_VENDOR_BROADCOM is not set
 # CONFIG_NET_VENDOR_CIRRUS is not set
 # CONFIG_NET_VENDOR_EZCHIP is not set
@@ -94,10 +90,10 @@ CONFIG_NFS_V4_2=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS=y
 CONFIG_PRINTK_TIME=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_DEBUG_FS=y
 # CONFIG_SLUB_DEBUG is not set
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_MEMTEST=y
+# CONFIG_NET_VENDOR_CADENCE is not set
diff --git a/arch/arm/configs/mv78xx0_defconfig b/arch/arm/configs/mv78xx0_defconfig
index 877c5150a987..3502e5db152c 100644
--- a/arch/arm/configs/mv78xx0_defconfig
+++ b/arch/arm/configs/mv78xx0_defconfig
@@ -55,9 +55,7 @@ CONFIG_CHR_DEV_SG=m
 CONFIG_ATA=y
 CONFIG_SATA_MV=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
-CONFIG_NET_PCI=y
 CONFIG_MV643XX_ETH=y
 # CONFIG_INPUT_MOUSEDEV is not set
 CONFIG_MARVELL_PHY=y
@@ -97,7 +95,6 @@ CONFIG_RTC_DRV_RS5C372=y
 CONFIG_RTC_DRV_M41T80=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_FS_XATTR is not set
 CONFIG_EXT4_FS=m
 CONFIG_ISO9660_FS=m
 CONFIG_JOLIET=y
diff --git a/arch/arm/configs/mvebu_v5_defconfig b/arch/arm/configs/mvebu_v5_defconfig
index 2467afd32146..38b06e355709 100644
--- a/arch/arm/configs/mvebu_v5_defconfig
+++ b/arch/arm/configs/mvebu_v5_defconfig
@@ -15,7 +15,6 @@ CONFIG_MACH_DNS323=y
 CONFIG_MACH_TS209=y
 CONFIG_MACH_TERASTATION_PRO2=y
 CONFIG_MACH_LINKSTATION_PRO=y
-CONFIG_MACH_LINKSTATION_LSCHL=y
 CONFIG_MACH_LINKSTATION_MINI=y
 CONFIG_MACH_TS409=y
 CONFIG_MACH_TS78XX=y
@@ -63,7 +62,6 @@ CONFIG_MTD_CFI_GEOMETRY=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_STAA=y
 CONFIG_MTD_PHYSMAP=y
-CONFIG_MTD_M25P80=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_ORION=y
 CONFIG_MTD_SPI_NOR=y
@@ -166,7 +164,6 @@ CONFIG_RTC_DRV_MV=y
 CONFIG_DMADEVICES=y
 CONFIG_MV_XOR=y
 CONFIG_STAGING=y
-CONFIG_FB_XGI=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_ISO9660_FS=m
diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index feb38a94c1a7..10c48cc6979e 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -32,9 +32,6 @@ CONFIG_INET=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 CONFIG_CAN=m
@@ -45,7 +42,6 @@ CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_DATAFLASH=y
-CONFIG_MTD_M25P80=y
 CONFIG_MTD_SST25L=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_GPMI_NAND=y
diff --git a/arch/arm/configs/neponset_defconfig b/arch/arm/configs/neponset_defconfig
index c333406ce5e3..30bc35a3f764 100644
--- a/arch/arm/configs/neponset_defconfig
+++ b/arch/arm/configs/neponset_defconfig
@@ -38,12 +38,9 @@ CONFIG_BLK_DEV_RAM_SIZE=8192
 CONFIG_SCSI=m
 CONFIG_BLK_DEV_SD=m
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
-CONFIG_NET_VENDOR_SMC=y
 CONFIG_PCMCIA_PCNET=y
 CONFIG_SMC9194=y
 CONFIG_SMC91X=y
-CONFIG_NET_PCMCIA=y
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_SERIO_SERPORT=m
@@ -63,7 +60,6 @@ CONFIG_FB_SA1100=y
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_SOUND=y
-CONFIG_SOUND_PRIME=y
 # CONFIG_USB_HID is not set
 CONFIG_USB=m
 CONFIG_USB_MON=m
@@ -85,3 +81,5 @@ CONFIG_DEBUG_KERNEL=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
+CONFIG_ARCNET=y
+CONFIG_NET_VENDOR_SMSC=y
diff --git a/arch/arm/configs/netwinder_defconfig b/arch/arm/configs/netwinder_defconfig
index 30ff6fbce5a3..119ef9bc5b62 100644
--- a/arch/arm/configs/netwinder_defconfig
+++ b/arch/arm/configs/netwinder_defconfig
@@ -27,12 +27,10 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_ATA=y
 CONFIG_PATA_WINBOND=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
 CONFIG_NET_TULIP=y
 CONFIG_TULIP=y
 CONFIG_TULIP_MMIO=y
-CONFIG_NET_PCI=y
 CONFIG_NE2K_PCI=y
 CONFIG_MOUSE_SERIAL=y
 CONFIG_INPUT_MISC=y
@@ -51,12 +49,6 @@ CONFIG_FB_CYBER2000=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_LOGO=y
 CONFIG_SOUND=y
-CONFIG_SOUND_PRIME=y
-CONFIG_SOUND_OSS=y
-CONFIG_SOUND_TRACEINIT=y
-CONFIG_SOUND_DMAP=y
-CONFIG_SOUND_YM3812=y
-CONFIG_SOUND_WAVEARTIST=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_TRIGGERS=y
@@ -70,7 +62,6 @@ CONFIG_NFS_V3=y
 CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=y
-CONFIG_SMB_FS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_850=y
 CONFIG_NLS_CODEPAGE_852=y
diff --git a/arch/arm/configs/nhk8815_defconfig b/arch/arm/configs/nhk8815_defconfig
index d5881de42018..ca35d23ff921 100644
--- a/arch/arm/configs/nhk8815_defconfig
+++ b/arch/arm/configs/nhk8815_defconfig
@@ -53,7 +53,6 @@ CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_FSMC=y
 CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC=y
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_CRYPTOLOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
diff --git a/arch/arm/configs/omap1_defconfig b/arch/arm/configs/omap1_defconfig
index 70511fe4b3ec..a3863f03c471 100644
--- a/arch/arm/configs/omap1_defconfig
+++ b/arch/arm/configs/omap1_defconfig
@@ -53,9 +53,6 @@ CONFIG_IP_MULTICAST=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 CONFIG_IPV6=y
 CONFIG_NETFILTER=y
@@ -216,7 +213,6 @@ CONFIG_NLS_ISO8859_5=y
 CONFIG_NLS_ISO8859_15=y
 CONFIG_NLS_KOI8_R=y
 CONFIG_NLS_UTF8=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_KERNEL=y
 CONFIG_SECURITY=y
 CONFIG_CRYPTO_ECB=y
diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 2a66850d3288..c5e426895365 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -86,7 +86,6 @@ CONFIG_IP_PNP_BOOTP=y
 CONFIG_IP_PNP_RARP=y
 CONFIG_NETFILTER=y
 CONFIG_NF_CONNTRACK=m
-CONFIG_NF_LOG_NETDEV=m
 CONFIG_NF_CONNTRACK_ZONES=y
 CONFIG_NF_CONNTRACK_EVENTS=y
 CONFIG_NF_CONNTRACK_TIMEOUT=y
@@ -100,7 +99,6 @@ CONFIG_NF_TABLES_INET=y
 CONFIG_NF_TABLES_NETDEV=y
 CONFIG_NFT_NUMGEN=m
 CONFIG_NFT_CT=m
-CONFIG_NFT_COUNTER=m
 CONFIG_NFT_CONNLIMIT=m
 CONFIG_NFT_LOG=m
 CONFIG_NFT_LIMIT=m
@@ -187,7 +185,6 @@ CONFIG_NETFILTER_XT_MATCH_TIME=m
 CONFIG_NETFILTER_XT_MATCH_U32=m
 CONFIG_NFT_DUP_IPV4=m
 CONFIG_NFT_FIB_IPV4=m
-CONFIG_NF_FLOW_TABLE_IPV4=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
@@ -208,7 +205,6 @@ CONFIG_IP_NF_RAW=m
 CONFIG_IP_NF_SECURITY=m
 CONFIG_NFT_DUP_IPV6=m
 CONFIG_NFT_FIB_IPV6=m
-CONFIG_NF_FLOW_TABLE_IPV6=m
 CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP6_NF_MATCH_AH=m
 CONFIG_IP6_NF_MATCH_EUI64=m
@@ -233,7 +229,6 @@ CONFIG_IP6_NF_TARGET_NPT=m
 CONFIG_NF_TABLES_BRIDGE=m
 CONFIG_NFT_BRIDGE_META=m
 CONFIG_NFT_BRIDGE_REJECT=m
-CONFIG_NF_LOG_BRIDGE=m
 CONFIG_BRIDGE=m
 CONFIG_BRIDGE_VLAN_FILTERING=y
 CONFIG_VLAN_8021Q=m
diff --git a/arch/arm/configs/orion5x_defconfig b/arch/arm/configs/orion5x_defconfig
index 0629b088a584..8bc15109fc76 100644
--- a/arch/arm/configs/orion5x_defconfig
+++ b/arch/arm/configs/orion5x_defconfig
@@ -116,7 +116,6 @@ CONFIG_DMADEVICES=y
 CONFIG_MV_XOR=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_FS_XATTR is not set
 CONFIG_EXT4_FS=m
 CONFIG_ISO9660_FS=m
 CONFIG_JOLIET=y
diff --git a/arch/arm/configs/palmz72_defconfig b/arch/arm/configs/palmz72_defconfig
index a9a808bc2f70..3a5ff674d90f 100644
--- a/arch/arm/configs/palmz72_defconfig
+++ b/arch/arm/configs/palmz72_defconfig
@@ -24,9 +24,6 @@ CONFIG_UNIX=y
 CONFIG_INET=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_BOOTP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_IPV6 is not set
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
diff --git a/arch/arm/configs/pcm027_defconfig b/arch/arm/configs/pcm027_defconfig
index a392312a13ce..995023f91895 100644
--- a/arch/arm/configs/pcm027_defconfig
+++ b/arch/arm/configs/pcm027_defconfig
@@ -28,9 +28,6 @@ CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
 CONFIG_IP_PNP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 CONFIG_MTD=y
@@ -45,7 +42,6 @@ CONFIG_BLK_DEV_SD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_SMC91X=y
 # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 # CONFIG_INPUT_KEYBOARD is not set
diff --git a/arch/arm/configs/pleb_defconfig b/arch/arm/configs/pleb_defconfig
index fd2667873273..f1c053aaf450 100644
--- a/arch/arm/configs/pleb_defconfig
+++ b/arch/arm/configs/pleb_defconfig
@@ -2,7 +2,6 @@ CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
-# CONFIG_HOTPLUG is not set
 # CONFIG_SHMEM is not set
 CONFIG_ARCH_MULTI_V4=y
 # CONFIG_ARCH_MULTI_V7 is not set
@@ -33,7 +32,6 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=8192
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_SMC91X=y
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
@@ -42,7 +40,6 @@ CONFIG_SERIAL_SA1100=y
 CONFIG_SERIAL_SA1100_CONSOLE=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_FS_XATTR is not set
 # CONFIG_DNOTIFY is not set
 CONFIG_MSDOS_FS=m
 CONFIG_VFAT_FS=m
diff --git a/arch/arm/configs/pxa168_defconfig b/arch/arm/configs/pxa168_defconfig
index 826ebbef2e3c..a578aed019ae 100644
--- a/arch/arm/configs/pxa168_defconfig
+++ b/arch/arm/configs/pxa168_defconfig
@@ -26,7 +26,6 @@ CONFIG_IP_PNP=y
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
 # CONFIG_BLK_DEV is not set
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_SMC91X=y
 # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 # CONFIG_INPUT_KEYBOARD is not set
diff --git a/arch/arm/configs/pxa255-idp_defconfig b/arch/arm/configs/pxa255-idp_defconfig
index ae0444949a87..b28f3b339c3a 100644
--- a/arch/arm/configs/pxa255-idp_defconfig
+++ b/arch/arm/configs/pxa255-idp_defconfig
@@ -23,7 +23,6 @@ CONFIG_MTD_CFI_GEOMETRY=y
 # CONFIG_MTD_CFI_I1 is not set
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_SMC91X=y
 CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_MOUSE is not set
diff --git a/arch/arm/configs/pxa3xx_defconfig b/arch/arm/configs/pxa3xx_defconfig
index d1e83b52e03a..03eebc66be0a 100644
--- a/arch/arm/configs/pxa3xx_defconfig
+++ b/arch/arm/configs/pxa3xx_defconfig
@@ -18,9 +18,6 @@ CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
 CONFIG_IP_PNP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 # CONFIG_STANDALONE is not set
@@ -35,7 +32,6 @@ CONFIG_MTD_NAND_MARVELL=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_SMC91X=y
 # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 # CONFIG_KEYBOARD_ATKBD is not set
@@ -106,8 +102,8 @@ CONFIG_DEBUG_SHIRQ=y
 CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_DEBUG_SPINLOCK=y
-CONFIG_DEBUG_SPINLOCK_SLEEP=y
 # CONFIG_FTRACE is not set
 CONFIG_DEBUG_USER=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
+CONFIG_DEBUG_ATOMIC_SLEEP=y
diff --git a/arch/arm/configs/pxa910_defconfig b/arch/arm/configs/pxa910_defconfig
index 353008de5678..11b403c38404 100644
--- a/arch/arm/configs/pxa910_defconfig
+++ b/arch/arm/configs/pxa910_defconfig
@@ -26,7 +26,6 @@ CONFIG_IP_PNP=y
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
 # CONFIG_BLK_DEV is not set
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_SMC91X=y
 # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 # CONFIG_INPUT_KEYBOARD is not set
@@ -41,7 +40,6 @@ CONFIG_SPI=y
 CONFIG_FB=y
 CONFIG_MMP_DISP=y
 CONFIG_MMP_DISP_CONTROLLER=y
-CONFIG_MMP_SPI=y
 CONFIG_MMP_PANEL_TPOHVGA=y
 CONFIG_MMP_FB=y
 CONFIG_LOGO=y
diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
index d60cc9cc4c21..bfac1ed12cdc 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -85,7 +85,6 @@ CONFIG_BT_HCIBFUSB=m
 CONFIG_BT_HCIDTL1=m
 CONFIG_BT_HCIBT3C=m
 CONFIG_BT_HCIBLUECARD=m
-CONFIG_BT_HCIBTUART=m
 CONFIG_BT_HCIVHCI=m
 CONFIG_BT_MRVL=m
 CONFIG_BT_MRVL_SDIO=m
@@ -129,7 +128,6 @@ CONFIG_MTD_ROM=m
 CONFIG_MTD_COMPLEX_MAPPINGS=y
 CONFIG_MTD_PHYSMAP=y
 CONFIG_MTD_PXA2XX=m
-CONFIG_MTD_M25P80=m
 CONFIG_MTD_BLOCK2MTD=y
 CONFIG_MTD_DOCG3=m
 CONFIG_MTD_ONENAND=m
@@ -146,13 +144,11 @@ CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED=y
 CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0x4000000
 CONFIG_MTD_NAND_DISKONCHIP_PROBE_HIGH=y
 CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE=y
-CONFIG_MTD_NAND_CM_X270=m
 CONFIG_MTD_NAND_ECC_SW_BCH=y
 CONFIG_MTD_SPI_NOR=m
 CONFIG_MTD_UBI=m
 CONFIG_MTD_UBI_BLOCK=y
 CONFIG_BLK_DEV_LOOP=m
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=8
@@ -166,7 +162,6 @@ CONFIG_SENSORS_LIS3_SPI=m
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=m
 CONFIG_CHR_DEV_ST=m
-CONFIG_CHR_DEV_OSST=m
 CONFIG_BLK_DEV_SR=m
 CONFIG_CHR_DEV_SG=y
 CONFIG_ATA=m
@@ -391,7 +386,6 @@ CONFIG_FB_PXA=y
 CONFIG_FB_PXA_OVERLAY=y
 CONFIG_FB_PXA_PARAMETERS=y
 CONFIG_PXA3XX_GCU=m
-CONFIG_FB_MBX=m
 CONFIG_FB_VIRTUAL=m
 CONFIG_FB_SIMPLE=y
 CONFIG_LCD_CORGI=m
@@ -420,7 +414,6 @@ CONFIG_SND_SOC_AK4642=m
 CONFIG_SND_SOC_WM8731_I2C=m
 CONFIG_SND_SOC_WM8978=m
 CONFIG_SND_SIMPLE_CARD=m
-CONFIG_SOUND_PRIME=m
 CONFIG_HID=m
 CONFIG_HID_A4TECH=m
 CONFIG_HID_APPLE=m
@@ -634,7 +627,6 @@ CONFIG_NFSD=m
 CONFIG_NFSD_V3_ACL=y
 CONFIG_NFSD_V4=y
 CONFIG_CIFS=m
-CONFIG_CIFS_STATS=y
 CONFIG_CIFS_XATTR=y
 CONFIG_CIFS_POSIX=y
 CONFIG_NLS_DEFAULT="utf8"
@@ -645,7 +637,6 @@ CONFIG_NLS_ASCII=m
 CONFIG_NLS_ISO8859_1=m
 CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_UTF8=m
-CONFIG_TIMER_STATS=y
 CONFIG_SECURITY=y
 CONFIG_CRYPTO_MANAGER=y
 CONFIG_CRYPTO_CRYPTD=m
@@ -657,7 +648,6 @@ CONFIG_CRYPTO_XTS=m
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_VMAC=m
 CONFIG_CRYPTO_SHA512=m
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_BLOWFISH=m
diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 7d8b6884fd00..a5b2bfa4aac4 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -43,9 +43,6 @@ CONFIG_IP_MULTIPLE_TABLES=y
 CONFIG_IP_ROUTE_VERBOSE=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_IPV6 is not set
 CONFIG_QRTR=m
 CONFIG_QRTR_SMD=m
@@ -63,7 +60,6 @@ CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
 CONFIG_MTD_QCOMSMEM_PARTS=y
 CONFIG_MTD_BLOCK=y
-CONFIG_MTD_M25P80=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_QCOM=y
 CONFIG_MTD_SPI_NOR=y
@@ -105,7 +101,6 @@ CONFIG_KEYBOARD_PMIC8XXX=y
 CONFIG_INPUT_JOYSTICK=y
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_INPUT_MISC=y
-CONFIG_INPUT_MSM_VIBRATOR=m
 CONFIG_INPUT_PM8941_PWRKEY=m
 CONFIG_INPUT_PM8XXX_VIBRATOR=y
 CONFIG_INPUT_PMIC8XXX_PWRKEY=y
@@ -182,16 +177,13 @@ CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
 CONFIG_USB_OTG=y
 CONFIG_USB_MON=y
 CONFIG_USB_EHCI_HCD=y
-CONFIG_USB_EHCI_MSM=y
 CONFIG_USB_ACM=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_CHIPIDEA=y
 CONFIG_USB_CHIPIDEA_UDC=y
 CONFIG_USB_CHIPIDEA_HOST=y
-CONFIG_USB_CHIPIDEA_ULPI=y
 CONFIG_USB_SERIAL=y
 CONFIG_USB_HSIC_USB4604=y
-CONFIG_USB_MSM_OTG=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DEBUG_FILES=y
 CONFIG_USB_GADGET_VBUS_DRAW=500
@@ -240,9 +232,7 @@ CONFIG_QCOM_APCS_IPC=y
 CONFIG_MSM_IOMMU=y
 CONFIG_ARM_SMMU=y
 CONFIG_REMOTEPROC=y
-CONFIG_QCOM_ADSP_PIL=y
 CONFIG_QCOM_Q6V5_PAS=y
-CONFIG_QCOM_Q6V5_PIL=y
 CONFIG_QCOM_WCNSS_PIL=y
 CONFIG_RPMSG_CHAR=y
 CONFIG_RPMSG_CTRL=y
@@ -251,7 +241,6 @@ CONFIG_RPMSG_QCOM_SMD=y
 CONFIG_QCOM_COMMAND_DB=y
 CONFIG_QCOM_GSBI=y
 CONFIG_QCOM_OCMEM=y
-CONFIG_QCOM_PM=y
 CONFIG_QCOM_RPMH=y
 CONFIG_QCOM_RPMHPD=y
 CONFIG_QCOM_RMTFS_MEM=y
@@ -320,3 +309,4 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
 # CONFIG_SLUB_DEBUG is not set
 # CONFIG_SCHED_DEBUG is not set
+CONFIG_ARM_QCOM_SPM_CPUIDLE=y
diff --git a/arch/arm/configs/rpc_defconfig b/arch/arm/configs/rpc_defconfig
index 210974364d61..eb6d81e2dbd2 100644
--- a/arch/arm/configs/rpc_defconfig
+++ b/arch/arm/configs/rpc_defconfig
@@ -17,12 +17,6 @@ CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET6_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET6_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET6_XFRM_MODE_BEET is not set
 CONFIG_PARPORT=y
 CONFIG_PARPORT_PC=y
 CONFIG_PARPORT_PC_FIFO=y
@@ -46,7 +40,6 @@ CONFIG_ATA=y
 CONFIG_PATA_ICSIDE=y
 CONFIG_PATA_PLATFORM=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_ARM_ETHER1=y
 CONFIG_ARM_ETHER3=y
 CONFIG_ARM_ETHERH=y
@@ -72,9 +65,6 @@ CONFIG_FB_ACORN=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_LOGO=y
 CONFIG_SOUND=m
-CONFIG_SOUND_PRIME=m
-CONFIG_SOUND_OSS=m
-CONFIG_SOUND_VIDC=m
 # CONFIG_USB_SUPPORT is not set
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_PCF8583=y
diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index 877bbe7b777e..82923aa07bb7 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -71,8 +71,6 @@ CONFIG_BLK_DEV_SD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_NETDEVICES=y
-CONFIG_NET_DSA_MICROCHIP_KSZ9477=m
-CONFIG_NET_DSA_MICROCHIP_KSZ9477_SPI=m
 # CONFIG_NET_VENDOR_BROADCOM is not set
 CONFIG_MACB=y
 # CONFIG_NET_VENDOR_CIRRUS is not set
@@ -252,3 +250,5 @@ CONFIG_DEBUG_MEMORY_INIT=y
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_FTRACE is not set
 CONFIG_DEBUG_USER=y
+CONFIG_NET_DSA_MICROCHIP_KSZ_COMMON=m
+CONFIG_NET_DSA_MICROCHIP_KSZ_SPI=m
diff --git a/arch/arm/configs/shannon_defconfig b/arch/arm/configs/shannon_defconfig
index dfcea70b8034..b6c9633abd7f 100644
--- a/arch/arm/configs/shannon_defconfig
+++ b/arch/arm/configs/shannon_defconfig
@@ -25,8 +25,6 @@ CONFIG_MTD_SA1100=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=8192
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
-CONFIG_NET_PCMCIA=y
 CONFIG_PCMCIA_PCNET=y
 CONFIG_PCMCIA_SMC91C92=y
 CONFIG_SERIAL_SA1100=y
@@ -43,3 +41,4 @@ CONFIG_JFFS2_FS=y
 CONFIG_MINIX_FS=y
 CONFIG_NFS_FS=y
 CONFIG_DEBUG_USER=y
+CONFIG_ARCNET=y
diff --git a/arch/arm/configs/simpad_defconfig b/arch/arm/configs/simpad_defconfig
index 4e00a4c2c287..1ffe6a45a0fc 100644
--- a/arch/arm/configs/simpad_defconfig
+++ b/arch/arm/configs/simpad_defconfig
@@ -4,7 +4,6 @@ CONFIG_PREEMPT=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
-CONFIG_KALLSYMS_EXTRA_PASS=y
 CONFIG_ARCH_MULTI_V4=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_SA1100=y
@@ -47,9 +46,6 @@ CONFIG_BLK_DEV_RAM=m
 CONFIG_BLK_DEV_RAM_SIZE=8192
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=y
-CONFIG_NET_ETHERNET=y
-CONFIG_NET_PCI=y
-CONFIG_NET_PCMCIA=y
 CONFIG_PCMCIA_3C574=m
 CONFIG_PCMCIA_3C589=m
 CONFIG_PCMCIA_PCNET=m
@@ -89,7 +85,6 @@ CONFIG_JFFS2_FS=y
 CONFIG_CRAMFS=m
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
-CONFIG_SMB_FS=m
 CONFIG_NLS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_850=y
@@ -98,3 +93,4 @@ CONFIG_NLS_ISO8859_15=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
+CONFIG_ARCNET=y
diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index 70739e09d0f4..9591af0441dd 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -41,7 +41,6 @@ CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
-CONFIG_MTD_M25P80=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_DENALI_DT=y
 CONFIG_MTD_SPI_NOR=y
diff --git a/arch/arm/configs/spear13xx_defconfig b/arch/arm/configs/spear13xx_defconfig
index bfde0c86cdc5..8d7b45c4e605 100644
--- a/arch/arm/configs/spear13xx_defconfig
+++ b/arch/arm/configs/spear13xx_defconfig
@@ -60,7 +60,6 @@ CONFIG_KEYBOARD_SPEAR=y
 CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
-CONFIG_RAW_DRIVER=y
 CONFIG_I2C=y
 CONFIG_I2C_DESIGNWARE_PLATFORM=y
 CONFIG_SPI=y
diff --git a/arch/arm/configs/spear3xx_defconfig b/arch/arm/configs/spear3xx_defconfig
index a96ed5cf778e..afb06021019d 100644
--- a/arch/arm/configs/spear3xx_defconfig
+++ b/arch/arm/configs/spear3xx_defconfig
@@ -40,7 +40,6 @@ CONFIG_KEYBOARD_SPEAR=y
 CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
-CONFIG_RAW_DRIVER=y
 CONFIG_I2C=y
 CONFIG_I2C_DESIGNWARE_PLATFORM=y
 CONFIG_SPI=y
diff --git a/arch/arm/configs/spear6xx_defconfig b/arch/arm/configs/spear6xx_defconfig
index 3d631b1f3cfa..c9dd6c7408ec 100644
--- a/arch/arm/configs/spear6xx_defconfig
+++ b/arch/arm/configs/spear6xx_defconfig
@@ -35,7 +35,6 @@ CONFIG_INPUT_FF_MEMLESS=y
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
-CONFIG_RAW_DRIVER=y
 CONFIG_I2C=y
 CONFIG_I2C_DESIGNWARE_PLATFORM=y
 CONFIG_SPI=y
diff --git a/arch/arm/configs/spitz_defconfig b/arch/arm/configs/spitz_defconfig
index 66d74653f3fb..b92cef448ed9 100644
--- a/arch/arm/configs/spitz_defconfig
+++ b/arch/arm/configs/spitz_defconfig
@@ -30,11 +30,9 @@ CONFIG_INET6_IPCOMP=m
 CONFIG_IPV6_TUNNEL=m
 CONFIG_NETFILTER=y
 CONFIG_IP_NF_IPTABLES=m
-CONFIG_IP_NF_MATCH_ADDRTYPE=m
 CONFIG_IP_NF_MATCH_ECN=m
 CONFIG_IP_NF_MATCH_TTL=m
 CONFIG_IP_NF_FILTER=m
-CONFIG_IP_NF_TARGET_LOG=m
 CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_RAW=m
 CONFIG_IP_NF_ARPTABLES=m
@@ -66,7 +64,6 @@ CONFIG_BT_HCIBFUSB=m
 CONFIG_BT_HCIDTL1=m
 CONFIG_BT_HCIBT3C=m
 CONFIG_BT_HCIBLUECARD=m
-CONFIG_BT_HCIBTUART=m
 CONFIG_BT_HCIVHCI=m
 CONFIG_PCCARD=y
 CONFIG_PCMCIA_PXA2XX=y
@@ -80,14 +77,12 @@ CONFIG_MTD_NAND_SHARPSL=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=m
-CONFIG_CHR_DEV_OSST=m
 CONFIG_BLK_DEV_SR=m
 CONFIG_CHR_DEV_SG=m
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_ATA=y
 CONFIG_PATA_PCMCIA=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_PCMCIA_PCNET=m
 CONFIG_PPP=m
 CONFIG_PPP_BSDCOMP=m
@@ -98,7 +93,6 @@ CONFIG_USB_PEGASUS=m
 CONFIG_USB_RTL8150=m
 CONFIG_USB_USBNET=m
 # CONFIG_USB_NET_CDC_SUBSET is not set
-CONFIG_NET_PCMCIA=y
 CONFIG_INPUT_FF_MEMLESS=m
 # CONFIG_INPUT_MOUSEDEV is not set
 CONFIG_INPUT_EVDEV=y
@@ -183,7 +177,6 @@ CONFIG_USB_LCD=m
 CONFIG_USB_CYTHERM=m
 CONFIG_USB_IDMOUSE=m
 CONFIG_USB_GADGET=m
-CONFIG_USB_GADGET_DUMMY_HCD=y
 CONFIG_USB_ZERO=m
 CONFIG_USB_ETH=m
 CONFIG_USB_GADGETFS=m
@@ -196,7 +189,6 @@ CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_FS_XATTR is not set
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
@@ -208,8 +200,6 @@ CONFIG_CRAMFS=m
 CONFIG_NFS_FS=m
 CONFIG_NFS_V3=y
 CONFIG_NFS_V4=y
-CONFIG_SMB_FS=m
-CONFIG_SMB_NLS_DEFAULT=y
 CONFIG_NFS_V4=m
 CONFIG_NLS_DEFAULT="cp437"
 CONFIG_NLS_CODEPAGE_437=y
@@ -244,3 +234,6 @@ CONFIG_FONT_8x16=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_DEBUG_PREEMPT is not set
 # CONFIG_FTRACE is not set
+CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
+CONFIG_NETFILTER_XT_TARGET_LOG=m
+CONFIG_ARCNET=y
diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index dc1a32f50b7e..39b59df9c144 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -74,7 +74,6 @@ CONFIG_NLS=y
 CONFIG_CRC_ITU_T=y
 CONFIG_CRC7=y
 CONFIG_PRINTK_TIME=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
diff --git a/arch/arm/configs/tct_hammer_defconfig b/arch/arm/configs/tct_hammer_defconfig
index 3b29ae1fb750..9b84c34fb95a 100644
--- a/arch/arm/configs/tct_hammer_defconfig
+++ b/arch/arm/configs/tct_hammer_defconfig
@@ -53,6 +53,5 @@ CONFIG_VFAT_FS=y
 CONFIG_JFFS2_FS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_CRC_CCITT=y
 CONFIG_DEBUG_LL=y
diff --git a/arch/arm/configs/trizeps4_defconfig b/arch/arm/configs/trizeps4_defconfig
index 009abe1e49ef..3de3fe04d05d 100644
--- a/arch/arm/configs/trizeps4_defconfig
+++ b/arch/arm/configs/trizeps4_defconfig
@@ -8,7 +8,6 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
-CONFIG_KALLSYMS_EXTRA_PASS=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_PXA=y
 CONFIG_TRIZEPS_PXA=y
@@ -66,12 +65,6 @@ CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_COMPLEX_MAPPINGS=y
 CONFIG_MTD_PHYSMAP=y
 CONFIG_MTD_BLOCK2MTD=y
-CONFIG_MTD_DOC2000=y
-CONFIG_MTD_DOC2001=y
-CONFIG_MTD_DOC2001PLUS=y
-CONFIG_MTD_DOCPROBE_ADVANCED=y
-CONFIG_MTD_DOCPROBE_ADDRESS=0x4000000
-CONFIG_MTD_DOCPROBE_HIGH=y
 CONFIG_MTD_ONENAND=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_DISKONCHIP=y
@@ -80,19 +73,16 @@ CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0x4000000
 CONFIG_MTD_NAND_DISKONCHIP_PROBE_HIGH=y
 CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE=y
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=8
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_SG=y
-CONFIG_SCSI_MULTI_LUN=y
 CONFIG_ATA=m
 CONFIG_PATA_PCMCIA=m
 CONFIG_PATA_PLATFORM=m
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_DM9000=y
 CONFIG_PHYLIB=y
 CONFIG_PPP=m
@@ -153,7 +143,6 @@ CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_STORAGE=m
 CONFIG_USB_SERIAL=m
 CONFIG_USB_GADGET=m
-CONFIG_USB_GADGET_DUMMY_HCD=y
 CONFIG_MMC=y
 CONFIG_MMC_PXA=y
 CONFIG_NEW_LEDS=y
@@ -181,7 +170,6 @@ CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=y
 CONFIG_NFSD_V4=y
-CONFIG_SMB_FS=m
 CONFIG_CIFS=m
 CONFIG_NLS_DEFAULT="iso8859-15"
 CONFIG_NLS_CODEPAGE_437=y
diff --git a/arch/arm/configs/viper_defconfig b/arch/arm/configs/viper_defconfig
index 02f9849893b2..b7171c8e59a8 100644
--- a/arch/arm/configs/viper_defconfig
+++ b/arch/arm/configs/viper_defconfig
@@ -65,7 +65,6 @@ CONFIG_ATA=m
 # CONFIG_SATA_PMP is not set
 CONFIG_PATA_PCMCIA=m
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_SMC91X=y
 CONFIG_PPP=m
 CONFIG_PPP_BSDCOMP=m
@@ -74,7 +73,6 @@ CONFIG_PPP_ASYNC=m
 CONFIG_USB_PEGASUS=m
 CONFIG_USB_USBNET=m
 # CONFIG_USB_NET_CDC_SUBSET is not set
-CONFIG_NET_PCMCIA=y
 CONFIG_INPUT_MOUSEDEV=m
 # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 CONFIG_INPUT_EVDEV=m
@@ -138,7 +136,6 @@ CONFIG_RTC_DRV_DS1307=m
 CONFIG_RTC_DRV_SA1100=m
 CONFIG_EXT2_FS=m
 CONFIG_EXT3_FS=m
-# CONFIG_EXT3_FS_XATTR is not set
 # CONFIG_DNOTIFY is not set
 CONFIG_VFAT_FS=m
 CONFIG_JFFS2_FS=y
@@ -158,3 +155,4 @@ CONFIG_DEBUG_MUTEXES=y
 # CONFIG_FTRACE is not set
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_ARC4=m
+CONFIG_ARCNET=y
diff --git a/arch/arm/configs/vt8500_v6_v7_defconfig b/arch/arm/configs/vt8500_v6_v7_defconfig
index 41607a84abc8..f4a368e2ca3b 100644
--- a/arch/arm/configs/vt8500_v6_v7_defconfig
+++ b/arch/arm/configs/vt8500_v6_v7_defconfig
@@ -23,12 +23,10 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
-CONFIG_PROC_DEVICETREE=y
 CONFIG_EEPROM_93CX6=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_NETDEVICES=y
-# CONFIG_NET_CADENCE is not set
 # CONFIG_NET_VENDOR_BROADCOM is not set
 # CONFIG_NET_VENDOR_CIRRUS is not set
 # CONFIG_NET_VENDOR_FARADAY is not set
@@ -86,3 +84,4 @@ CONFIG_ROOT_NFS=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_LOCKUP_DETECTOR=y
+# CONFIG_NET_VENDOR_CADENCE is not set
diff --git a/arch/arm/configs/xcep_defconfig b/arch/arm/configs/xcep_defconfig
index ea59e4b6bfc5..47c94d3e71e6 100644
--- a/arch/arm/configs/xcep_defconfig
+++ b/arch/arm/configs/xcep_defconfig
@@ -38,9 +38,6 @@ CONFIG_IP_MULTICAST=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
@@ -48,7 +45,6 @@ CONFIG_IP_PNP_BOOTP=y
 CONFIG_MTD_COMPLEX_MAPPINGS=y
 CONFIG_MTD_PXA2XX=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
diff --git a/arch/arm/configs/zeus_defconfig b/arch/arm/configs/zeus_defconfig
index c4535315e216..6d2452920298 100644
--- a/arch/arm/configs/zeus_defconfig
+++ b/arch/arm/configs/zeus_defconfig
@@ -63,7 +63,6 @@ CONFIG_ATA=m
 # CONFIG_SATA_PMP is not set
 CONFIG_PATA_PCMCIA=m
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_DM9000=y
 CONFIG_PPP=m
 CONFIG_PPP_BSDCOMP=m
@@ -73,7 +72,6 @@ CONFIG_HERMES=m
 CONFIG_PCMCIA_HERMES=m
 CONFIG_RT2X00=m
 CONFIG_RT73USB=m
-CONFIG_NET_PCMCIA=y
 # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 CONFIG_INPUT_EVDEV=m
 # CONFIG_INPUT_KEYBOARD is not set
@@ -152,7 +150,6 @@ CONFIG_RTC_DRV_ISL1208=m
 CONFIG_RTC_DRV_PXA=m
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_FS_XATTR is not set
 # CONFIG_DNOTIFY is not set
 CONFIG_VFAT_FS=m
 CONFIG_TMPFS=y
@@ -171,3 +168,4 @@ CONFIG_DEBUG_KERNEL=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_MUTEXES=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
+CONFIG_ARCNET=y
-- 
2.17.1

