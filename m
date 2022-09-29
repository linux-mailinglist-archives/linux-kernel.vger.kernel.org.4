Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371B25EF342
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235566AbiI2KQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235238AbiI2KQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:16:10 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7022C14B85E;
        Thu, 29 Sep 2022 03:15:32 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v28so1421065wrd.3;
        Thu, 29 Sep 2022 03:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ARelrikFBdnMKRtx6h7izLAVzhZOrw2dn/3QPwxa78M=;
        b=fQ5iB68L2/ldd/m1RBlsZFwYl7xPxGUpIRkTj/li3j68IiKD3dEzb4pvx3LpA6iXKY
         +Ly0/TbVmCNrcgjtUcD5EunLprAgs/vqOaJuh4I7qfdDFMFNrM68flfNFhjCULwZKk0n
         QiN71sKBWnbprZw59ciwl/RzG5wLJshdB96E4dcZ11omZoMDNqE/FvDbNrjTFRuGGB8n
         fNjprqkic6KGZkZ7bLA4AY1ItyxnuwARYLjWKUukzzXt37XBmX3DRIW/5ERix+//tER1
         DrU24y1Wtjs65aHy0OCl403yaFhSdIumsUgrm3+wCDxTGC+jBu0EvOGCWtmDuQftIcTi
         bjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ARelrikFBdnMKRtx6h7izLAVzhZOrw2dn/3QPwxa78M=;
        b=MNVPJc78V1mFxKfSPDHdgiWFMGJdM1ALg3AP8/AyL+lUU9O8FTaAxO7YwUZUMH/l51
         XrzcSNhht0wx0tHCSbjxXeTb0Zu3d3ihKEF7vt/HgaLDtwOh0rmLJLXaTzBrB02K6iBS
         biFLT7+7uHp7OW4g0SMwRkVrWFUiOOK2+ALFzAqBp+4UGcVHcCWOCPHwO66p0JetA3ZF
         nNVkHze73trmN4nZ8jksPsnbxf9PPyWRKN/HE2fXUgu+pJdsrg1JqWY1KP9hnoxIeJ/s
         F3nu0Lozvd8fWTEfW5Rw8Y0fuZYIxATZiYHy470qsdC7SCyx0aUva6+5Pr+M1b8/9ICG
         KYnA==
X-Gm-Message-State: ACrzQf1gXVgs1QFx1hqsMyoQ3a0tnKxZlD4XpVo/1lBmED09qHFaMMzq
        jfnNp4QCyDlu7TQdMTmJE0/jMGExhhfIEA==
X-Google-Smtp-Source: AMsMyM5enYRaen/6GFq294k1OzW652K/597NIhVtKBDmpx6qduHTX0m+lpt1hLdH/SCWOJNbZuWzqw==
X-Received: by 2002:a5d:5b18:0:b0:22a:fb91:3d6b with SMTP id bx24-20020a5d5b18000000b0022afb913d6bmr1727387wrb.56.1664446511408;
        Thu, 29 Sep 2022 03:15:11 -0700 (PDT)
Received: from felia.fritz.box (200116b826e11200b190ebfd45660ea6.dip.versatel-1u1.de. [2001:16b8:26e1:1200:b190:ebfd:4566:ea6])
        by smtp.gmail.com with ESMTPSA id p11-20020a056000018b00b00226dba960b4sm3280131wrx.3.2022.09.29.03.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 03:15:11 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] sh: update config files
Date:   Thu, 29 Sep 2022 12:15:07 +0200
Message-Id: <20220929101507.32614-1-lukas.bulwahn@gmail.com>
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
 arch/sh/configs/ap325rxa_defconfig          | 10 ----------
 arch/sh/configs/apsh4a3a_defconfig          |  4 ----
 arch/sh/configs/apsh4ad0a_defconfig         |  6 ------
 arch/sh/configs/dreamcast_defconfig         |  4 ----
 arch/sh/configs/ecovec24-romimage_defconfig |  5 -----
 arch/sh/configs/ecovec24_defconfig          | 13 +------------
 arch/sh/configs/edosk7705_defconfig         |  2 --
 arch/sh/configs/edosk7760_defconfig         | 10 +---------
 arch/sh/configs/espt_defconfig              |  3 ---
 arch/sh/configs/kfr2r09-romimage_defconfig  |  4 ----
 arch/sh/configs/kfr2r09_defconfig           |  4 ----
 arch/sh/configs/landisk_defconfig           |  7 -------
 arch/sh/configs/lboxre2_defconfig           |  6 +-----
 arch/sh/configs/magicpanelr2_defconfig      |  6 ------
 arch/sh/configs/microdev_defconfig          |  2 --
 arch/sh/configs/migor_defconfig             |  7 +------
 arch/sh/configs/polaris_defconfig           |  6 +-----
 arch/sh/configs/r7780mp_defconfig           |  4 ----
 arch/sh/configs/r7785rp_defconfig           |  3 ---
 arch/sh/configs/rsk7201_defconfig           |  1 -
 arch/sh/configs/rsk7203_defconfig           |  7 +------
 arch/sh/configs/rsk7264_defconfig           |  7 +------
 arch/sh/configs/rsk7269_defconfig           |  5 -----
 arch/sh/configs/rts7751r2d1_defconfig       |  3 ---
 arch/sh/configs/rts7751r2dplus_defconfig    |  3 ---
 arch/sh/configs/sdk7780_defconfig           |  7 -------
 arch/sh/configs/sdk7786_defconfig           | 12 +-----------
 arch/sh/configs/se7206_defconfig            |  8 +-------
 arch/sh/configs/se7343_defconfig            |  2 --
 arch/sh/configs/se7619_defconfig            |  2 --
 arch/sh/configs/se7705_defconfig            |  2 --
 arch/sh/configs/se7712_defconfig            |  2 --
 arch/sh/configs/se7721_defconfig            |  2 --
 arch/sh/configs/se7722_defconfig            |  3 ---
 arch/sh/configs/se7724_defconfig            | 13 +------------
 arch/sh/configs/se7750_defconfig            |  3 ---
 arch/sh/configs/se7751_defconfig            |  2 --
 arch/sh/configs/se7780_defconfig            |  7 -------
 arch/sh/configs/secureedge5410_defconfig    |  6 ------
 arch/sh/configs/sh03_defconfig              |  3 ---
 arch/sh/configs/sh2007_defconfig            | 10 +---------
 arch/sh/configs/sh7710voipgw_defconfig      |  2 --
 arch/sh/configs/sh7724_generic_defconfig    |  1 -
 arch/sh/configs/sh7757lcr_defconfig         |  1 -
 arch/sh/configs/sh7763rdp_defconfig         |  3 ---
 arch/sh/configs/sh7770_generic_defconfig    |  1 -
 arch/sh/configs/sh7785lcr_32bit_defconfig   |  7 +------
 arch/sh/configs/sh7785lcr_defconfig         |  2 --
 arch/sh/configs/shmin_defconfig             |  2 --
 arch/sh/configs/shx3_defconfig              |  6 +-----
 arch/sh/configs/titan_defconfig             | 13 ++-----------
 arch/sh/configs/ul2_defconfig               |  4 ----
 arch/sh/configs/urquell_defconfig           |  6 ------
 53 files changed, 15 insertions(+), 249 deletions(-)

diff --git a/arch/sh/configs/ap325rxa_defconfig b/arch/sh/configs/ap325rxa_defconfig
index 4d83576b89c6..000372e0e187 100644
--- a/arch/sh/configs/ap325rxa_defconfig
+++ b/arch/sh/configs/ap325rxa_defconfig
@@ -24,9 +24,6 @@ CONFIG_INET=y
 CONFIG_IP_ADVANCED_ROUTER=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_IPV6 is not set
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
@@ -43,7 +40,6 @@ CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_NETDEVICES=y
 CONFIG_SMSC_PHY=y
-CONFIG_NET_ETHERNET=y
 CONFIG_SMSC911X=y
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
@@ -62,10 +58,6 @@ CONFIG_SPI_GPIO=y
 # CONFIG_HWMON is not set
 CONFIG_MEDIA_SUPPORT=y
 CONFIG_VIDEO_DEV=y
-# CONFIG_VIDEO_ALLOW_V4L1 is not set
-# CONFIG_MEDIA_TUNER_CUSTOMISE is not set
-CONFIG_VIDEO_HELPER_CHIPS_AUTO=y
-CONFIG_VIDEO_SH_MOBILE_CEU=y
 # CONFIG_RADIO_ADAPTERS is not set
 CONFIG_FB=y
 CONFIG_FB_SH_MOBILE_LCDC=y
@@ -83,7 +75,6 @@ CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_EXT3_FS_POSIX_ACL=y
 CONFIG_EXT3_FS_SECURITY=y
 CONFIG_VFAT_FS=y
@@ -96,7 +87,6 @@ CONFIG_NFSD=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_932=y
 CONFIG_NLS_ISO8859_1=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_CRYPTO=y
 CONFIG_CRYPTO_CBC=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/sh/configs/apsh4a3a_defconfig b/arch/sh/configs/apsh4a3a_defconfig
index 99931a13a74d..021e41af7a44 100644
--- a/arch/sh/configs/apsh4a3a_defconfig
+++ b/arch/sh/configs/apsh4a3a_defconfig
@@ -38,7 +38,6 @@ CONFIG_MTD_PHYSMAP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=16384
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_SMSC911X=y
 # CONFIG_WLAN is not set
 # CONFIG_INPUT_MOUSEDEV is not set
@@ -52,7 +51,6 @@ CONFIG_SERIAL_SH_SCI_CONSOLE=y
 CONFIG_HW_RANDOM=y
 # CONFIG_HWMON is not set
 CONFIG_FB=y
-CONFIG_FB_SH7785FB=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_FONTS=y
 CONFIG_FONT_8x8=y
@@ -61,7 +59,6 @@ CONFIG_LOGO=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_NTFS_FS=y
@@ -80,7 +77,6 @@ CONFIG_NLS_CODEPAGE_932=y
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_PREEMPT is not set
diff --git a/arch/sh/configs/apsh4ad0a_defconfig b/arch/sh/configs/apsh4ad0a_defconfig
index d9fb124bf015..c51cb36cc858 100644
--- a/arch/sh/configs/apsh4ad0a_defconfig
+++ b/arch/sh/configs/apsh4ad0a_defconfig
@@ -9,7 +9,6 @@ CONFIG_CGROUPS=y
 CONFIG_CGROUP_FREEZER=y
 CONFIG_CGROUP_DEVICE=y
 CONFIG_CGROUP_CPUACCT=y
-CONFIG_CGROUP_MEMCG=y
 CONFIG_BLK_CGROUP=y
 CONFIG_NAMESPACES=y
 CONFIG_BLK_DEV_INITRD=y
@@ -61,11 +60,9 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=16384
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
-CONFIG_SCSI_MULTI_LUN=y
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_NETDEVICES=y
 CONFIG_MDIO_BITBANG=y
-CONFIG_NET_ETHERNET=y
 CONFIG_SMSC911X=y
 # CONFIG_WLAN is not set
 CONFIG_INPUT_EVDEV=y
@@ -79,7 +76,6 @@ CONFIG_SERIAL_SH_SCI_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 # CONFIG_HWMON is not set
 CONFIG_FB=y
-CONFIG_FB_SH7785FB=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_FONTS=y
 CONFIG_FONT_8x8=y
@@ -91,7 +87,6 @@ CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_STORAGE=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_NTFS_FS=y
@@ -111,7 +106,6 @@ CONFIG_NLS_CODEPAGE_932=y
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_SHIRQ=y
diff --git a/arch/sh/configs/dreamcast_defconfig b/arch/sh/configs/dreamcast_defconfig
index 6a82c7b8ff32..cd042db20db6 100644
--- a/arch/sh/configs/dreamcast_defconfig
+++ b/arch/sh/configs/dreamcast_defconfig
@@ -18,8 +18,6 @@ CONFIG_CPU_FREQ_GOV_POWERSAVE=y
 CONFIG_CPU_FREQ_GOV_USERSPACE=y
 CONFIG_SH_DMA=y
 CONFIG_SH_DMA_API=y
-CONFIG_NR_DMA_CHANNELS_BOOL=y
-CONFIG_NR_DMA_CHANNELS=9
 CONFIG_SECCOMP=y
 CONFIG_PREEMPT=y
 CONFIG_CMDLINE_OVERWRITE=y
@@ -35,8 +33,6 @@ CONFIG_INET=y
 # CONFIG_FW_LOADER is not set
 CONFIG_GDROM=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
-CONFIG_NET_PCI=y
 CONFIG_8139TOO=y
 # CONFIG_8139TOO_PIO is not set
 # CONFIG_KEYBOARD_ATKBD is not set
diff --git a/arch/sh/configs/ecovec24-romimage_defconfig b/arch/sh/configs/ecovec24-romimage_defconfig
index 5c60e71d839e..e589aefe4314 100644
--- a/arch/sh/configs/ecovec24-romimage_defconfig
+++ b/arch/sh/configs/ecovec24-romimage_defconfig
@@ -21,16 +21,12 @@ CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_SH_ETH=y
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
@@ -54,5 +50,4 @@ CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 # CONFIG_MISC_FILESYSTEMS is not set
 # CONFIG_NETWORK_FILESYSTEMS is not set
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_FS=y
diff --git a/arch/sh/configs/ecovec24_defconfig b/arch/sh/configs/ecovec24_defconfig
index b52e14ccb450..38880a71a52f 100644
--- a/arch/sh/configs/ecovec24_defconfig
+++ b/arch/sh/configs/ecovec24_defconfig
@@ -25,9 +25,6 @@ CONFIG_INET=y
 CONFIG_IP_ADVANCED_ROUTER=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_IPV6 is not set
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
@@ -43,7 +40,6 @@ CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_NETDEVICES=y
 CONFIG_SMSC_PHY=y
-CONFIG_NET_ETHERNET=y
 CONFIG_SH_ETH=y
 # CONFIG_INPUT_MOUSEDEV is not set
 CONFIG_INPUT_EVDEV=y
@@ -65,13 +61,8 @@ CONFIG_I2C_SH_MOBILE=y
 CONFIG_SPI=y
 CONFIG_SPI_BITBANG=y
 # CONFIG_HWMON is not set
-CONFIG_MFD_SH_MOBILE_SDHI=y
 CONFIG_MEDIA_SUPPORT=y
 CONFIG_VIDEO_DEV=y
-# CONFIG_MEDIA_TUNER_CUSTOMISE is not set
-CONFIG_VIDEO_HELPER_CHIPS_AUTO=y
-CONFIG_VIDEO_SH_MOBILE_CEU=y
-# CONFIG_V4L_USB_DRIVERS is not set
 CONFIG_FB=y
 CONFIG_FB_SH_MOBILE_LCDC=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
@@ -92,7 +83,6 @@ CONFIG_SND_PCM_OSS=y
 # CONFIG_SND_USB is not set
 CONFIG_SND_SOC=y
 CONFIG_SND_SOC_SH4_FSI=y
-CONFIG_SND_FSI_DA7210=y
 CONFIG_USB=y
 CONFIG_USB_MON=y
 CONFIG_USB_R8A66597_HCD=y
@@ -111,7 +101,6 @@ CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_EXT3_FS_POSIX_ACL=y
 CONFIG_EXT3_FS_SECURITY=y
 CONFIG_VFAT_FS=y
@@ -124,9 +113,9 @@ CONFIG_NFSD=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_932=y
 CONFIG_NLS_ISO8859_1=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_FS=y
 CONFIG_CRYPTO=y
 CONFIG_CRYPTO_CBC=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRC_T10DIF=y
+CONFIG_SND_SOC_DA7210=y
diff --git a/arch/sh/configs/edosk7705_defconfig b/arch/sh/configs/edosk7705_defconfig
index 9ee35269bee2..a5c78e52af3a 100644
--- a/arch/sh/configs/edosk7705_defconfig
+++ b/arch/sh/configs/edosk7705_defconfig
@@ -2,7 +2,6 @@
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 # CONFIG_UID16 is not set
 # CONFIG_KALLSYMS is not set
-# CONFIG_HOTPLUG is not set
 # CONFIG_PRINTK is not set
 # CONFIG_BUG is not set
 # CONFIG_ELF_CORE is not set
@@ -31,5 +30,4 @@ CONFIG_SH_PCLK_FREQ=31250000
 # CONFIG_DNOTIFY is not set
 # CONFIG_PROC_FS is not set
 # CONFIG_SYSFS is not set
-# CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_CRC32 is not set
diff --git a/arch/sh/configs/edosk7760_defconfig b/arch/sh/configs/edosk7760_defconfig
index f427a95bcd21..4865d271d080 100644
--- a/arch/sh/configs/edosk7760_defconfig
+++ b/arch/sh/configs/edosk7760_defconfig
@@ -27,15 +27,11 @@ CONFIG_UNIX=y
 CONFIG_INET=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_BOOTP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_IPV6 is not set
 # CONFIG_FW_LOADER is not set
 CONFIG_DEBUG_DRIVER=y
 CONFIG_DEBUG_DEVRES=y
 CONFIG_MTD=y
-CONFIG_MTD_DEBUG=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
@@ -57,7 +53,6 @@ CONFIG_MTD_PHYSMAP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=26000
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_SMC91X=y
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
@@ -86,9 +81,7 @@ CONFIG_SND_SOC=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
-CONFIG_EXT2_FS_XIP=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_NFS_FS=y
@@ -100,15 +93,14 @@ CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_ISO8859_15=y
 CONFIG_NLS_UTF8=y
 CONFIG_PRINTK_TIME=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_SHIRQ=y
 CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_SCHED_DEBUG is not set
-CONFIG_TIMER_STATS=y
 CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_CRYPTO=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
+CONFIG_FS_DAX=y
diff --git a/arch/sh/configs/espt_defconfig b/arch/sh/configs/espt_defconfig
index 2804cb760a76..f520e1e214b7 100644
--- a/arch/sh/configs/espt_defconfig
+++ b/arch/sh/configs/espt_defconfig
@@ -39,7 +39,6 @@ CONFIG_MTD_PHYSMAP=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_SH_ETH=y
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
@@ -61,7 +60,6 @@ CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_STORAGE=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_AUTOFS4_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
@@ -108,7 +106,6 @@ CONFIG_NLS_ISO8859_15=y
 CONFIG_NLS_KOI8_R=y
 CONFIG_NLS_KOI8_U=y
 CONFIG_NLS_UTF8=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_FS=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRC_T10DIF=y
diff --git a/arch/sh/configs/kfr2r09-romimage_defconfig b/arch/sh/configs/kfr2r09-romimage_defconfig
index 04436b4fbd76..fbb5c52b7754 100644
--- a/arch/sh/configs/kfr2r09-romimage_defconfig
+++ b/arch/sh/configs/kfr2r09-romimage_defconfig
@@ -22,9 +22,6 @@ CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 # CONFIG_WIRELESS is not set
@@ -48,6 +45,5 @@ CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 # CONFIG_MISC_FILESYSTEMS is not set
 # CONFIG_NETWORK_FILESYSTEMS is not set
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_FS=y
 # CONFIG_CRC32 is not set
diff --git a/arch/sh/configs/kfr2r09_defconfig b/arch/sh/configs/kfr2r09_defconfig
index 833404490cfe..fba6d1a526e4 100644
--- a/arch/sh/configs/kfr2r09_defconfig
+++ b/arch/sh/configs/kfr2r09_defconfig
@@ -27,9 +27,6 @@ CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 # CONFIG_WIRELESS is not set
@@ -80,5 +77,4 @@ CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 # CONFIG_MISC_FILESYSTEMS is not set
 # CONFIG_NETWORK_FILESYSTEMS is not set
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_FS=y
diff --git a/arch/sh/configs/landisk_defconfig b/arch/sh/configs/landisk_defconfig
index 492a0a2e0e36..a1cdc27d9c9e 100644
--- a/arch/sh/configs/landisk_defconfig
+++ b/arch/sh/configs/landisk_defconfig
@@ -1,6 +1,5 @@
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_KALLSYMS_EXTRA_PASS=y
 CONFIG_SLAB=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
@@ -33,7 +32,6 @@ CONFIG_PATA_ATP867X=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=y
-CONFIG_SCSI_MULTI_LUN=y
 CONFIG_MD=y
 CONFIG_BLK_DEV_MD=m
 CONFIG_MD_LINEAR=m
@@ -41,8 +39,6 @@ CONFIG_MD_RAID0=m
 CONFIG_MD_RAID1=m
 CONFIG_NETDEVICES=y
 CONFIG_TUN=m
-CONFIG_NET_ETHERNET=y
-CONFIG_NET_PCI=y
 CONFIG_8139CP=y
 CONFIG_USB_PEGASUS=m
 CONFIG_USB_RTL8150=m
@@ -55,7 +51,6 @@ CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_SOUND=m
-CONFIG_SOUND_PRIME=m
 CONFIG_USB_HID=m
 CONFIG_HID_A4TECH=m
 CONFIG_HID_APPLE=m
@@ -95,7 +90,6 @@ CONFIG_USB_SISUSBVGA=m
 CONFIG_USB_SISUSBVGA_CON=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_REISERFS_FS=y
 CONFIG_ISO9660_FS=m
 CONFIG_MSDOS_FS=y
@@ -108,7 +102,6 @@ CONFIG_UFS_FS=m
 CONFIG_NFS_FS=m
 CONFIG_NFS_V3=y
 CONFIG_NFSD=m
-CONFIG_SMB_FS=m
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_932=y
 CONFIG_SH_STANDARD_BIOS=y
diff --git a/arch/sh/configs/lboxre2_defconfig b/arch/sh/configs/lboxre2_defconfig
index 05e4ac6fed5f..aa33a97f8207 100644
--- a/arch/sh/configs/lboxre2_defconfig
+++ b/arch/sh/configs/lboxre2_defconfig
@@ -1,6 +1,5 @@
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_KALLSYMS_EXTRA_PASS=y
 CONFIG_SLAB=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
@@ -34,12 +33,9 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_ATA=y
 CONFIG_PATA_PLATFORM=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
-CONFIG_NET_PCI=y
 CONFIG_NE2K_PCI=y
 CONFIG_8139TOO=y
 CONFIG_8139TOO_TUNE_TWISTER=y
-CONFIG_NET_PCMCIA=y
 CONFIG_PCMCIA_PCNET=y
 # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 # CONFIG_INPUT_KEYBOARD is not set
@@ -51,7 +47,6 @@ CONFIG_HW_RANDOM=y
 CONFIG_RTC_CLASS=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
@@ -60,3 +55,4 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_SH_STANDARD_BIOS=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRC_T10DIF=y
+CONFIG_ARCNET=y
diff --git a/arch/sh/configs/magicpanelr2_defconfig b/arch/sh/configs/magicpanelr2_defconfig
index ef1d98e35c91..fda5e349f5fd 100644
--- a/arch/sh/configs/magicpanelr2_defconfig
+++ b/arch/sh/configs/magicpanelr2_defconfig
@@ -29,9 +29,6 @@ CONFIG_UNIX=y
 CONFIG_INET=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_IPV6 is not set
 # CONFIG_STANDALONE is not set
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
@@ -46,7 +43,6 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=65536
 CONFIG_NETDEVICES=y
 CONFIG_SMSC_PHY=y
-CONFIG_NET_ETHERNET=y
 CONFIG_SMSC911X=y
 CONFIG_INPUT_EVDEV=y
 # CONFIG_MOUSE_PS2 is not set
@@ -65,8 +61,6 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_SH=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-# CONFIG_EXT3_FS_XATTR is not set
 # CONFIG_DNOTIFY is not set
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
diff --git a/arch/sh/configs/microdev_defconfig b/arch/sh/configs/microdev_defconfig
index e9825196dd66..0776997ddf0b 100644
--- a/arch/sh/configs/microdev_defconfig
+++ b/arch/sh/configs/microdev_defconfig
@@ -21,7 +21,6 @@ CONFIG_IP_PNP=y
 # CONFIG_FW_LOADER is not set
 CONFIG_BLK_DEV_RAM=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_SMC91X=y
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
@@ -30,7 +29,6 @@ CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_VFAT_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
diff --git a/arch/sh/configs/migor_defconfig b/arch/sh/configs/migor_defconfig
index 4859cd30cfc4..c5d6cf41a1ea 100644
--- a/arch/sh/configs/migor_defconfig
+++ b/arch/sh/configs/migor_defconfig
@@ -37,7 +37,6 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_SMC91X=y
 # CONFIG_INPUT_MOUSEDEV is not set
 CONFIG_INPUT_EVDEV=y
@@ -57,10 +56,6 @@ CONFIG_I2C_SH_MOBILE=y
 # CONFIG_HWMON is not set
 CONFIG_MEDIA_SUPPORT=y
 CONFIG_VIDEO_DEV=y
-# CONFIG_VIDEO_ALLOW_V4L1 is not set
-# CONFIG_MEDIA_TUNER_CUSTOMISE is not set
-CONFIG_VIDEO_HELPER_CHIPS_AUTO=y
-CONFIG_VIDEO_SH_MOBILE_CEU=y
 # CONFIG_RADIO_ADAPTERS is not set
 CONFIG_FB=y
 CONFIG_FB_SH_MOBILE_LCDC=y
@@ -75,7 +70,6 @@ CONFIG_LOGO=y
 # CONFIG_LOGO_SUPERH_MONO is not set
 # CONFIG_LOGO_SUPERH_CLUT224 is not set
 CONFIG_USB_GADGET=y
-CONFIG_USB_GADGET_M66592=y
 CONFIG_USB_G_SERIAL=m
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_RS5C372=y
@@ -92,3 +86,4 @@ CONFIG_CRYPTO_MANAGER=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
 CONFIG_CRC_T10DIF=y
+CONFIG_USB_M66592=y
diff --git a/arch/sh/configs/polaris_defconfig b/arch/sh/configs/polaris_defconfig
index f42e4867ddc1..db59c770f977 100644
--- a/arch/sh/configs/polaris_defconfig
+++ b/arch/sh/configs/polaris_defconfig
@@ -32,9 +32,6 @@ CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_IPV6 is not set
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
@@ -48,7 +45,6 @@ CONFIG_MTD_PHYSMAP_START=0x00000000
 CONFIG_MTD_PHYSMAP_LEN=0x01000000
 CONFIG_NETDEVICES=y
 CONFIG_SMSC_PHY=y
-CONFIG_NET_ETHERNET=y
 CONFIG_SMSC911X=y
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
@@ -78,6 +74,6 @@ CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_DEBUG_RT_MUTEXES=y
 CONFIG_DEBUG_LOCK_ALLOC=y
-CONFIG_DEBUG_SPINLOCK_SLEEP=y
 CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_DEBUG_SG=y
+CONFIG_DEBUG_ATOMIC_SLEEP=y
diff --git a/arch/sh/configs/r7780mp_defconfig b/arch/sh/configs/r7780mp_defconfig
index e527cd60a191..2dbdbcab4665 100644
--- a/arch/sh/configs/r7780mp_defconfig
+++ b/arch/sh/configs/r7780mp_defconfig
@@ -45,10 +45,8 @@ CONFIG_ATA=y
 CONFIG_SATA_SIL=y
 CONFIG_PATA_PLATFORM=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_AX88796=y
 CONFIG_AX88796_93CX6=y
-CONFIG_NET_PCI=y
 CONFIG_PCNET32=m
 CONFIG_8139CP=m
 CONFIG_8139TOO=m
@@ -70,13 +68,11 @@ CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_HIGHLANDER=y
 CONFIG_THERMAL=y
 CONFIG_SOUND=m
-CONFIG_SOUND_PRIME=m
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_RS5C372=y
 CONFIG_RTC_DRV_SH=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_FUSE_FS=m
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
diff --git a/arch/sh/configs/r7785rp_defconfig b/arch/sh/configs/r7785rp_defconfig
index a3f952a83d97..3dbc7f0022d4 100644
--- a/arch/sh/configs/r7785rp_defconfig
+++ b/arch/sh/configs/r7785rp_defconfig
@@ -47,7 +47,6 @@ CONFIG_ATA=y
 CONFIG_SATA_SIL=y
 CONFIG_PATA_PLATFORM=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_AX88796=y
 CONFIG_AX88796_93CX6=y
 CONFIG_R8169=y
@@ -65,13 +64,11 @@ CONFIG_I2C_HIGHLANDER=y
 CONFIG_FB=y
 CONFIG_FB_SH_MOBILE_LCDC=m
 CONFIG_SOUND=m
-CONFIG_SOUND_PRIME=m
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_RS5C372=y
 CONFIG_RTC_DRV_SH=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_FUSE_FS=m
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
diff --git a/arch/sh/configs/rsk7201_defconfig b/arch/sh/configs/rsk7201_defconfig
index 619c18699459..cb399b97a998 100644
--- a/arch/sh/configs/rsk7201_defconfig
+++ b/arch/sh/configs/rsk7201_defconfig
@@ -57,6 +57,5 @@ CONFIG_EXT2_FS=y
 # CONFIG_DNOTIFY is not set
 CONFIG_JFFS2_FS=y
 CONFIG_ROMFS_FS=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
diff --git a/arch/sh/configs/rsk7203_defconfig b/arch/sh/configs/rsk7203_defconfig
index d00fafc021e1..7de64bd76dbc 100644
--- a/arch/sh/configs/rsk7203_defconfig
+++ b/arch/sh/configs/rsk7203_defconfig
@@ -36,9 +36,6 @@ CONFIG_NET=y
 CONFIG_INET=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 # CONFIG_STANDALONE is not set
@@ -52,7 +49,6 @@ CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_PHYSMAP=y
 CONFIG_NETDEVICES=y
 CONFIG_SMSC_PHY=y
-CONFIG_NET_ETHERNET=y
 CONFIG_SMSC911X=y
 CONFIG_INPUT_FF_MEMLESS=m
 # CONFIG_INPUT_MOUSEDEV is not set
@@ -103,7 +99,6 @@ CONFIG_RTC_DRV_SH=y
 CONFIG_ROMFS_FS=y
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_KERNEL=y
@@ -111,10 +106,10 @@ CONFIG_DEBUG_SHIRQ=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_DEBUG_OBJECTS=y
 CONFIG_DEBUG_MUTEXES=y
-CONFIG_DEBUG_SPINLOCK_SLEEP=y
 CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_DEBUG_VM=y
 CONFIG_DEBUG_LIST=y
 CONFIG_DEBUG_SG=y
 CONFIG_FRAME_POINTER=y
 CONFIG_DEBUG_STACK_USAGE=y
+CONFIG_DEBUG_ATOMIC_SLEEP=y
diff --git a/arch/sh/configs/rsk7264_defconfig b/arch/sh/configs/rsk7264_defconfig
index f7b9c528c6df..f202dfcc85b0 100644
--- a/arch/sh/configs/rsk7264_defconfig
+++ b/arch/sh/configs/rsk7264_defconfig
@@ -10,7 +10,6 @@ CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_EMBEDDED=y
-CONFIG_PERF_COUNTERS=y
 # CONFIG_VM_EVENT_COUNTERS is not set
 CONFIG_SLAB=y
 CONFIG_MMAP_ALLOW_UNINITIALIZED=y
@@ -28,9 +27,6 @@ CONFIG_NET=y
 CONFIG_INET=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
@@ -60,12 +56,11 @@ CONFIG_USB_STORAGE=y
 CONFIG_USB_STORAGE_DEBUG=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_VFAT_FS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_FTRACE is not set
+CONFIG_PERF_EVENTS=y
diff --git a/arch/sh/configs/rsk7269_defconfig b/arch/sh/configs/rsk7269_defconfig
index 4bff14fb185d..d3a082b09105 100644
--- a/arch/sh/configs/rsk7269_defconfig
+++ b/arch/sh/configs/rsk7269_defconfig
@@ -18,9 +18,6 @@ CONFIG_NET=y
 CONFIG_INET=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 # CONFIG_FW_LOADER is not set
@@ -44,7 +41,6 @@ CONFIG_USB_STORAGE=y
 CONFIG_USB_STORAGE_DEBUG=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_VFAT_FS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
@@ -52,5 +48,4 @@ CONFIG_ROOT_NFS=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_FTRACE is not set
diff --git a/arch/sh/configs/rts7751r2d1_defconfig b/arch/sh/configs/rts7751r2d1_defconfig
index 96263a4912b7..93d613a98044 100644
--- a/arch/sh/configs/rts7751r2d1_defconfig
+++ b/arch/sh/configs/rts7751r2d1_defconfig
@@ -26,8 +26,6 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_ATA=y
 CONFIG_PATA_PLATFORM=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
-CONFIG_NET_PCI=y
 CONFIG_8139TOO=y
 # CONFIG_8139TOO_PIO is not set
 CONFIG_INPUT_FF_MEMLESS=m
@@ -56,7 +54,6 @@ CONFIG_LOGO=y
 CONFIG_SOUND=y
 CONFIG_SND=m
 CONFIG_SND_YMFPCI=m
-CONFIG_SOUND_PRIME=m
 CONFIG_HID_A4TECH=y
 CONFIG_HID_APPLE=y
 CONFIG_HID_BELKIN=y
diff --git a/arch/sh/configs/rts7751r2dplus_defconfig b/arch/sh/configs/rts7751r2dplus_defconfig
index 92e586e6c974..27918fb3b3f1 100644
--- a/arch/sh/configs/rts7751r2dplus_defconfig
+++ b/arch/sh/configs/rts7751r2dplus_defconfig
@@ -31,8 +31,6 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_ATA=y
 CONFIG_PATA_PLATFORM=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
-CONFIG_NET_PCI=y
 CONFIG_8139TOO=y
 # CONFIG_8139TOO_PIO is not set
 CONFIG_INPUT_FF_MEMLESS=m
@@ -61,7 +59,6 @@ CONFIG_LOGO=y
 CONFIG_SOUND=y
 CONFIG_SND=m
 CONFIG_SND_YMFPCI=m
-CONFIG_SOUND_PRIME=m
 CONFIG_HID_A4TECH=y
 CONFIG_HID_APPLE=y
 CONFIG_HID_BELKIN=y
diff --git a/arch/sh/configs/sdk7780_defconfig b/arch/sh/configs/sdk7780_defconfig
index 41cb588ca99c..986d0f2e6f27 100644
--- a/arch/sh/configs/sdk7780_defconfig
+++ b/arch/sh/configs/sdk7780_defconfig
@@ -37,9 +37,7 @@ CONFIG_IP_MULTICAST=y
 CONFIG_IP_ADVANCED_ROUTER=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_BOOTP=y
-# CONFIG_INET_XFRM_MODE_BEET is not set
 CONFIG_IPV6=y
-# CONFIG_INET6_XFRM_MODE_BEET is not set
 CONFIG_NET_SCHED=y
 CONFIG_PARPORT=y
 CONFIG_BLK_DEV_LOOP=y
@@ -55,7 +53,6 @@ CONFIG_PATA_PLATFORM=y
 CONFIG_MD=y
 CONFIG_BLK_DEV_DM=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_SMC91X=y
 CONFIG_NETCONSOLE=y
 CONFIG_INPUT_FF_MEMLESS=m
@@ -74,7 +71,6 @@ CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
 CONFIG_LOGO=y
 CONFIG_SOUND=y
-CONFIG_SOUND_PRIME=y
 CONFIG_HID_A4TECH=y
 CONFIG_HID_APPLE=y
 CONFIG_HID_BELKIN=y
@@ -103,7 +99,6 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_EXT3_FS_POSIX_ACL=y
 CONFIG_AUTOFS4_FS=y
 CONFIG_ISO9660_FS=y
@@ -125,12 +120,10 @@ CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_ISO8859_15=y
 CONFIG_NLS_UTF8=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_SCHED_DEBUG is not set
-CONFIG_TIMER_STATS=y
 CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_SH_STANDARD_BIOS=y
 CONFIG_CRYPTO_MD5=y
diff --git a/arch/sh/configs/sdk7786_defconfig b/arch/sh/configs/sdk7786_defconfig
index 97b7356639ed..71b658604a34 100644
--- a/arch/sh/configs/sdk7786_defconfig
+++ b/arch/sh/configs/sdk7786_defconfig
@@ -15,7 +15,6 @@ CONFIG_CGROUP_DEVICE=y
 CONFIG_CPUSETS=y
 # CONFIG_PROC_PID_CPUSET is not set
 CONFIG_CGROUP_CPUACCT=y
-CONFIG_CGROUP_MEMCG=y
 CONFIG_CGROUP_SCHED=y
 CONFIG_RT_GROUP_SCHED=y
 CONFIG_BLK_CGROUP=y
@@ -73,7 +72,6 @@ CONFIG_CMDLINE="console=ttySC1,115200 earlyprintk=sh-sci.1,115200 root=/dev/sda1
 CONFIG_PCI=y
 CONFIG_PCIEPORTBUS=y
 CONFIG_PCIEAER_INJECT=y
-CONFIG_PCIEASPM_DEBUG=y
 CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
 CONFIG_BINFMT_MISC=y
 CONFIG_PM=y
@@ -111,11 +109,9 @@ CONFIG_MTD_NAND_SH_FLCTL=m
 CONFIG_MTD_UBI=y
 CONFIG_MTD_UBI_GLUEBI=m
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_CRYPTOLOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=y
-CONFIG_SCSI_MULTI_LUN=y
 CONFIG_SCSI_CONSTANTS=y
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_ATA=y
@@ -127,7 +123,6 @@ CONFIG_DM_DEBUG=y
 CONFIG_DM_UEVENT=y
 CONFIG_NETDEVICES=y
 CONFIG_MDIO_BITBANG=y
-CONFIG_NET_ETHERNET=y
 CONFIG_SMC91X=y
 CONFIG_SMSC911X=y
 # CONFIG_WLAN is not set
@@ -150,22 +145,18 @@ CONFIG_USB_MON=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_GADGET=y
-CONFIG_USB_GADGET_M66592=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_MAX6900=y
 CONFIG_RTC_DRV_SH=y
 CONFIG_DMADEVICES=y
 CONFIG_SH_DMAE=y
 CONFIG_UIO=m
-CONFIG_UIO_PDRV=m
 CONFIG_UIO_PDRV_GENIRQ=m
 CONFIG_UIO_PCI_GENERIC=m
 CONFIG_STAGING=y
-# CONFIG_STAGING_EXCLUDE_BUILD is not set
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_EXT4_FS=y
 CONFIG_XFS_FS=y
 CONFIG_BTRFS_FS=y
@@ -202,11 +193,9 @@ CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_UTF8=m
 CONFIG_PRINTK_TIME=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_HUNG_TASK=y
-CONFIG_TIMER_STATS=y
 CONFIG_DEBUG_MEMORY_INIT=y
 CONFIG_LATENCYTOP=y
 CONFIG_FUNCTION_TRACER=y
@@ -215,3 +204,4 @@ CONFIG_DMA_API_DEBUG=y
 CONFIG_DEBUG_STACK_USAGE=y
 CONFIG_DWARF_UNWINDER=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
+CONFIG_USB_M66592=y
diff --git a/arch/sh/configs/se7206_defconfig b/arch/sh/configs/se7206_defconfig
index 122216123e63..f4c9060be92e 100644
--- a/arch/sh/configs/se7206_defconfig
+++ b/arch/sh/configs/se7206_defconfig
@@ -9,7 +9,6 @@ CONFIG_CGROUPS=y
 CONFIG_CGROUP_DEBUG=y
 CONFIG_CGROUP_DEVICE=y
 CONFIG_CGROUP_CPUACCT=y
-CONFIG_CGROUP_MEMCG=y
 CONFIG_RELAY=y
 CONFIG_NAMESPACES=y
 CONFIG_UTS_NS=y
@@ -48,9 +47,6 @@ CONFIG_NET_KEY=y
 CONFIG_INET=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 # CONFIG_STANDALONE is not set
@@ -65,7 +61,6 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_EEPROM_93CX6=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_SMC91X=y
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
@@ -88,10 +83,8 @@ CONFIG_ROMFS_FS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_HUNG_TASK=y
-CONFIG_DEBUG_SPINLOCK_SLEEP=y
 CONFIG_DEBUG_VM=y
 CONFIG_DEBUG_LIST=y
 CONFIG_FRAME_POINTER=y
@@ -105,3 +98,4 @@ CONFIG_CRC16=y
 CONFIG_CRC_ITU_T=y
 CONFIG_CRC7=y
 CONFIG_LIBCRC32C=y
+CONFIG_DEBUG_ATOMIC_SLEEP=y
diff --git a/arch/sh/configs/se7343_defconfig b/arch/sh/configs/se7343_defconfig
index 5d6c19338ebf..16a331c92920 100644
--- a/arch/sh/configs/se7343_defconfig
+++ b/arch/sh/configs/se7343_defconfig
@@ -33,7 +33,6 @@ CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_RAM=y
 CONFIG_MTD_PHYSMAP=y
 CONFIG_SCSI=y
-CONFIG_SCSI_MULTI_LUN=y
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_NETDEVICES=y
 CONFIG_USB_USBNET=y
@@ -86,7 +85,6 @@ CONFIG_USB_ISP116X_HCD=y
 CONFIG_UIO=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 # CONFIG_DNOTIFY is not set
 CONFIG_JFFS2_FS=y
 CONFIG_CRAMFS=y
diff --git a/arch/sh/configs/se7619_defconfig b/arch/sh/configs/se7619_defconfig
index 71a672c30716..84e12e69e94b 100644
--- a/arch/sh/configs/se7619_defconfig
+++ b/arch/sh/configs/se7619_defconfig
@@ -2,7 +2,6 @@
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_UID16 is not set
 # CONFIG_KALLSYMS is not set
-# CONFIG_HOTPLUG is not set
 # CONFIG_ELF_CORE is not set
 # CONFIG_BASE_FULL is not set
 # CONFIG_FUTEX is not set
@@ -40,4 +39,3 @@ CONFIG_SERIAL_SH_SCI_CONSOLE=y
 # CONFIG_DNOTIFY is not set
 # CONFIG_SYSFS is not set
 CONFIG_ROMFS_FS=y
-# CONFIG_ENABLE_MUST_CHECK is not set
diff --git a/arch/sh/configs/se7705_defconfig b/arch/sh/configs/se7705_defconfig
index ed00a6eeadf5..3093226b7115 100644
--- a/arch/sh/configs/se7705_defconfig
+++ b/arch/sh/configs/se7705_defconfig
@@ -3,7 +3,6 @@ CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 # CONFIG_KALLSYMS is not set
-# CONFIG_HOTPLUG is not set
 CONFIG_SLAB=y
 CONFIG_MODULES=y
 # CONFIG_BLK_DEV_BSG is not set
@@ -31,7 +30,6 @@ CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=8192
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_STNIC=y
 CONFIG_PPP=y
 CONFIG_PPP_ASYNC=y
diff --git a/arch/sh/configs/se7712_defconfig b/arch/sh/configs/se7712_defconfig
index 36356223d51c..836c2ce88ad9 100644
--- a/arch/sh/configs/se7712_defconfig
+++ b/arch/sh/configs/se7712_defconfig
@@ -69,7 +69,6 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_ATA=y
 CONFIG_PATA_PLATFORM=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_SH_ETH=y
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
@@ -86,7 +85,6 @@ CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 # CONFIG_DNOTIFY is not set
 CONFIG_JFFS2_FS=y
 CONFIG_CRAMFS=y
diff --git a/arch/sh/configs/se7721_defconfig b/arch/sh/configs/se7721_defconfig
index 46c5a263a239..a941baf9817c 100644
--- a/arch/sh/configs/se7721_defconfig
+++ b/arch/sh/configs/se7721_defconfig
@@ -65,7 +65,6 @@ CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_BLK_DEV_SD=y
-CONFIG_SCSI_MULTI_LUN=y
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_ATA=y
 CONFIG_PATA_PLATFORM=y
@@ -110,7 +109,6 @@ CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 # CONFIG_DNOTIFY is not set
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
diff --git a/arch/sh/configs/se7722_defconfig b/arch/sh/configs/se7722_defconfig
index 09e455817447..ef49d7cda78f 100644
--- a/arch/sh/configs/se7722_defconfig
+++ b/arch/sh/configs/se7722_defconfig
@@ -30,7 +30,6 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_ATA=y
 CONFIG_PATA_PLATFORM=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_SMC91X=y
 # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 # CONFIG_INPUT_MOUSE is not set
@@ -44,12 +43,10 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_SH=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_HUGETLBFS=y
 CONFIG_PRINTK_TIME=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
 CONFIG_SH_STANDARD_BIOS=y
diff --git a/arch/sh/configs/se7724_defconfig b/arch/sh/configs/se7724_defconfig
index d817df7cc4a7..c6ce4d55d966 100644
--- a/arch/sh/configs/se7724_defconfig
+++ b/arch/sh/configs/se7724_defconfig
@@ -26,9 +26,6 @@ CONFIG_INET=y
 CONFIG_IP_ADVANCED_ROUTER=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_IPV6 is not set
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
@@ -44,7 +41,6 @@ CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_NETDEVICES=y
 CONFIG_SMSC_PHY=y
-CONFIG_NET_ETHERNET=y
 CONFIG_SH_ETH=y
 CONFIG_SMC91X=y
 # CONFIG_INPUT_MOUSEDEV is not set
@@ -66,13 +62,8 @@ CONFIG_SPI_BITBANG=y
 # CONFIG_HWMON is not set
 CONFIG_MEDIA_SUPPORT=y
 CONFIG_VIDEO_DEV=y
-# CONFIG_VIDEO_ALLOW_V4L1 is not set
 CONFIG_DVB_CORE=m
-# CONFIG_MEDIA_TUNER_CUSTOMISE is not set
-CONFIG_VIDEO_HELPER_CHIPS_AUTO=y
-CONFIG_VIDEO_SH_MOBILE_CEU=y
 # CONFIG_RADIO_ADAPTERS is not set
-# CONFIG_DVB_FE_CUSTOMISE is not set
 CONFIG_FB=y
 CONFIG_FB_SH_MOBILE_LCDC=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
@@ -90,7 +81,6 @@ CONFIG_SND=m
 # CONFIG_SND_SUPERH is not set
 CONFIG_SND_SOC=m
 CONFIG_SND_SOC_SH4_FSI=m
-CONFIG_SND_FSI_AK4642=y
 CONFIG_SND_SOC_ALL_CODECS=m
 CONFIG_USB=y
 CONFIG_USB_MON=y
@@ -112,7 +102,6 @@ CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_EXT3_FS_POSIX_ACL=y
 CONFIG_EXT3_FS_SECURITY=y
 CONFIG_VFAT_FS=y
@@ -125,8 +114,8 @@ CONFIG_NFSD=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_932=y
 CONFIG_NLS_ISO8859_1=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_CRYPTO=y
 CONFIG_CRYPTO_CBC=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRC_T10DIF=y
+CONFIG_SND_SOC_AK4642=y
diff --git a/arch/sh/configs/se7750_defconfig b/arch/sh/configs/se7750_defconfig
index 4defc7628a49..ed198e2731ca 100644
--- a/arch/sh/configs/se7750_defconfig
+++ b/arch/sh/configs/se7750_defconfig
@@ -5,7 +5,6 @@ CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
-# CONFIG_HOTPLUG is not set
 CONFIG_SLAB=y
 CONFIG_MODULES=y
 # CONFIG_BLK_DEV_BSG is not set
@@ -31,7 +30,6 @@ CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_ROM=y
 CONFIG_SCSI=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_STNIC=y
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
@@ -51,5 +49,4 @@ CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_PARTITION_ADVANCED=y
 # CONFIG_MSDOS_PARTITION is not set
-# CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/sh/configs/se7751_defconfig b/arch/sh/configs/se7751_defconfig
index 4a024065bb75..59d7a3098281 100644
--- a/arch/sh/configs/se7751_defconfig
+++ b/arch/sh/configs/se7751_defconfig
@@ -3,7 +3,6 @@ CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
-# CONFIG_HOTPLUG is not set
 CONFIG_SLAB=y
 CONFIG_MODULES=y
 # CONFIG_BLK_DEV_BSG is not set
@@ -32,7 +31,6 @@ CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_RAM=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
diff --git a/arch/sh/configs/se7780_defconfig b/arch/sh/configs/se7780_defconfig
index dcd85b858ac8..39a51363e224 100644
--- a/arch/sh/configs/se7780_defconfig
+++ b/arch/sh/configs/se7780_defconfig
@@ -4,7 +4,6 @@ CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_KALLSYMS is not set
-# CONFIG_HOTPLUG is not set
 # CONFIG_EPOLL is not set
 CONFIG_SLAB=y
 CONFIG_MODULES=y
@@ -24,9 +23,6 @@ CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
 CONFIG_IP_PNP=y
 CONFIG_IPV6=y
-# CONFIG_INET6_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET6_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET6_XFRM_MODE_BEET is not set
 # CONFIG_IPV6_SIT is not set
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
 CONFIG_MTD=y
@@ -47,9 +43,7 @@ CONFIG_SATA_SIL=y
 CONFIG_NETDEVICES=y
 CONFIG_PHYLIB=y
 CONFIG_SMSC_PHY=y
-CONFIG_NET_ETHERNET=y
 CONFIG_SMC91X=y
-CONFIG_NET_PCI=y
 CONFIG_INPUT_FF_MEMLESS=m
 # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 # CONFIG_INPUT_KEYBOARD is not set
@@ -70,7 +64,6 @@ CONFIG_LOGO=y
 # CONFIG_LOGO_SUPERH_MONO is not set
 # CONFIG_LOGO_SUPERH_VGA16 is not set
 CONFIG_SOUND=y
-CONFIG_SOUND_PRIME=y
 CONFIG_HID_A4TECH=y
 CONFIG_HID_APPLE=y
 CONFIG_HID_BELKIN=y
diff --git a/arch/sh/configs/secureedge5410_defconfig b/arch/sh/configs/secureedge5410_defconfig
index 8422599cfb04..817984589b0f 100644
--- a/arch/sh/configs/secureedge5410_defconfig
+++ b/arch/sh/configs/secureedge5410_defconfig
@@ -1,7 +1,6 @@
 # CONFIG_SWAP is not set
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
-# CONFIG_HOTPLUG is not set
 CONFIG_SLAB=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_CPU_SUBTYPE_SH7751R=y
@@ -13,9 +12,6 @@ CONFIG_SH_DMA_API=y
 CONFIG_PCI=y
 CONFIG_NET=y
 CONFIG_INET=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 CONFIG_MTD=y
@@ -30,8 +26,6 @@ CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_PLATRAM=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
-CONFIG_NET_PCI=y
 CONFIG_8139CP=y
 CONFIG_8139TOO=y
 # CONFIG_INPUT_MOUSEDEV is not set
diff --git a/arch/sh/configs/sh03_defconfig b/arch/sh/configs/sh03_defconfig
index 9fcf68b22dba..2060303aed1c 100644
--- a/arch/sh/configs/sh03_defconfig
+++ b/arch/sh/configs/sh03_defconfig
@@ -43,8 +43,6 @@ CONFIG_BLK_DEV_SD=m
 CONFIG_BLK_DEV_SR=m
 CONFIG_CHR_DEV_SG=m
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
-CONFIG_NET_PCI=y
 CONFIG_8139CP=y
 # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 # CONFIG_INPUT_KEYBOARD is not set
@@ -59,7 +57,6 @@ CONFIG_SH_WDT=m
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_EXT3_FS_POSIX_ACL=y
 CONFIG_AUTOFS4_FS=y
 CONFIG_ISO9660_FS=m
diff --git a/arch/sh/configs/sh2007_defconfig b/arch/sh/configs/sh2007_defconfig
index 259c69e3fa22..8b09347ac8f6 100644
--- a/arch/sh/configs/sh2007_defconfig
+++ b/arch/sh/configs/sh2007_defconfig
@@ -18,7 +18,6 @@ CONFIG_SH_SH2007=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_SH_DMA=y
 CONFIG_SH_DMA_API=y
-CONFIG_NR_DMA_CHANNELS_BOOL=y
 CONFIG_HZ_100=y
 CONFIG_CMDLINE_OVERWRITE=y
 CONFIG_CMDLINE="console=ttySC1,115200 ip=dhcp root=/dev/nfs rw nfsroot=/nfs/rootfs,rsize=1024,wsize=1024 earlyprintk=sh-sci.1"
@@ -38,9 +37,6 @@ CONFIG_IP_ROUTE_VERBOSE=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_NET_IPIP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_IPV6 is not set
 CONFIG_NETWORK_SECMARK=y
 CONFIG_NET_PKTGEN=y
@@ -52,7 +48,6 @@ CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=y
 CONFIG_CHR_DEV_SG=y
-CONFIG_SCSI_MULTI_LUN=y
 CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_LOGGING=y
 CONFIG_SCSI_SCAN_ASYNC=y
@@ -66,7 +61,6 @@ CONFIG_DUMMY=y
 CONFIG_EQUALIZER=y
 CONFIG_TUN=y
 CONFIG_VETH=y
-CONFIG_NET_ETHERNET=y
 CONFIG_SMSC911X=y
 # CONFIG_WLAN is not set
 CONFIG_INPUT_FF_MEMLESS=y
@@ -154,10 +148,8 @@ CONFIG_NLS_ISO8859_15=y
 CONFIG_NLS_KOI8_R=y
 CONFIG_NLS_KOI8_U=y
 CONFIG_NLS_UTF8=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_KERNEL=y
-# CONFIG_DETECT_SOFTLOCKUP is not set
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_FRAME_POINTER=y
@@ -175,7 +167,6 @@ CONFIG_CRYPTO_MICHAEL_MIC=y
 CONFIG_CRYPTO_SHA1=y
 CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_SHA512=y
-CONFIG_CRYPTO_TGR192=y
 CONFIG_CRYPTO_WP512=y
 CONFIG_CRYPTO_AES=y
 CONFIG_CRYPTO_ANUBIS=y
@@ -197,3 +188,4 @@ CONFIG_CRYPTO_LZO=y
 CONFIG_CRC_CCITT=y
 CONFIG_CRC16=y
 CONFIG_LIBCRC32C=y
+# CONFIG_LOCKUP_DETECTOR is not set
diff --git a/arch/sh/configs/sh7710voipgw_defconfig b/arch/sh/configs/sh7710voipgw_defconfig
index 0d814770b07f..d19617fc83d0 100644
--- a/arch/sh/configs/sh7710voipgw_defconfig
+++ b/arch/sh/configs/sh7710voipgw_defconfig
@@ -36,8 +36,6 @@ CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_RAM=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
-CONFIG_PHONE=y
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
diff --git a/arch/sh/configs/sh7724_generic_defconfig b/arch/sh/configs/sh7724_generic_defconfig
index cbc9389a89a8..1ece11d09065 100644
--- a/arch/sh/configs/sh7724_generic_defconfig
+++ b/arch/sh/configs/sh7724_generic_defconfig
@@ -37,5 +37,4 @@ CONFIG_UIO_PDRV_GENIRQ=y
 # CONFIG_PROC_FS is not set
 # CONFIG_SYSFS is not set
 # CONFIG_MISC_FILESYSTEMS is not set
-# CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_CRC32 is not set
diff --git a/arch/sh/configs/sh7757lcr_defconfig b/arch/sh/configs/sh7757lcr_defconfig
index 2579dc4bc0c8..f10fb730b6f4 100644
--- a/arch/sh/configs/sh7757lcr_defconfig
+++ b/arch/sh/configs/sh7757lcr_defconfig
@@ -41,7 +41,6 @@ CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_NETDEVICES=y
 CONFIG_VITESSE_PHY=y
-CONFIG_NET_ETHERNET=y
 CONFIG_SH_ETH=y
 # CONFIG_WLAN is not set
 # CONFIG_KEYBOARD_ATKBD is not set
diff --git a/arch/sh/configs/sh7763rdp_defconfig b/arch/sh/configs/sh7763rdp_defconfig
index 8a6a446f9eb8..0fe76b28e4d8 100644
--- a/arch/sh/configs/sh7763rdp_defconfig
+++ b/arch/sh/configs/sh7763rdp_defconfig
@@ -40,7 +40,6 @@ CONFIG_MTD_PHYSMAP=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_SH_ETH=y
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
@@ -63,7 +62,6 @@ CONFIG_USB_STORAGE=y
 CONFIG_MMC=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_AUTOFS4_FS=y
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
@@ -110,7 +108,6 @@ CONFIG_NLS_ISO8859_15=y
 CONFIG_NLS_KOI8_R=y
 CONFIG_NLS_KOI8_U=y
 CONFIG_NLS_UTF8=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_FS=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRC_T10DIF=y
diff --git a/arch/sh/configs/sh7770_generic_defconfig b/arch/sh/configs/sh7770_generic_defconfig
index ee2357deba0f..dda18777054a 100644
--- a/arch/sh/configs/sh7770_generic_defconfig
+++ b/arch/sh/configs/sh7770_generic_defconfig
@@ -39,5 +39,4 @@ CONFIG_UIO_PDRV_GENIRQ=y
 # CONFIG_PROC_FS is not set
 # CONFIG_SYSFS is not set
 # CONFIG_MISC_FILESYSTEMS is not set
-# CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_CRC32 is not set
diff --git a/arch/sh/configs/sh7785lcr_32bit_defconfig b/arch/sh/configs/sh7785lcr_32bit_defconfig
index 781ff13227fc..105e24d18d94 100644
--- a/arch/sh/configs/sh7785lcr_32bit_defconfig
+++ b/arch/sh/configs/sh7785lcr_32bit_defconfig
@@ -49,7 +49,6 @@ CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_PHYSMAP=y
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_RAM=y
 # CONFIG_SCSI_PROC_FS is not set
 CONFIG_BLK_DEV_SD=y
@@ -57,7 +56,6 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_ATA=y
 CONFIG_SATA_SIL=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_NET_VENDOR_3COM=y
 CONFIG_VORTEX=y
 CONFIG_R8169=y
@@ -69,7 +67,6 @@ CONFIG_VT_HW_CONSOLE_BINDING=y
 CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_SH_SCI_NR_UARTS=6
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 # CONFIG_LEGACY_PTYS is not set
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C=y
@@ -114,7 +111,6 @@ CONFIG_DMADEVICES=y
 CONFIG_UIO=m
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_NTFS_FS=y
@@ -133,17 +129,16 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_932=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_PRINTK_TIME=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_DEBUG_KMEMLEAK=y
 CONFIG_DEBUG_SPINLOCK=y
 CONFIG_DEBUG_MUTEXES=y
-CONFIG_DEBUG_SPINLOCK_SLEEP=y
 CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_LATENCYTOP=y
 # CONFIG_FTRACE is not set
 CONFIG_CRYPTO_HMAC=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
+CONFIG_DEBUG_ATOMIC_SLEEP=y
diff --git a/arch/sh/configs/sh7785lcr_defconfig b/arch/sh/configs/sh7785lcr_defconfig
index 1b88929083f7..9655062515c2 100644
--- a/arch/sh/configs/sh7785lcr_defconfig
+++ b/arch/sh/configs/sh7785lcr_defconfig
@@ -91,7 +91,6 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_RS5C372=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_NTFS_FS=y
@@ -108,7 +107,6 @@ CONFIG_NFSD_V4=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_932=y
 CONFIG_NLS_ISO8859_1=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
diff --git a/arch/sh/configs/shmin_defconfig b/arch/sh/configs/shmin_defconfig
index c0b6f40d01cc..fdb87ed2d694 100644
--- a/arch/sh/configs/shmin_defconfig
+++ b/arch/sh/configs/shmin_defconfig
@@ -2,7 +2,6 @@
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_UID16 is not set
 # CONFIG_KALLSYMS is not set
-# CONFIG_HOTPLUG is not set
 # CONFIG_BUG is not set
 # CONFIG_ELF_CORE is not set
 # CONFIG_BASE_FULL is not set
@@ -34,7 +33,6 @@ CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_PHYSMAP=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
 # CONFIG_VT is not set
diff --git a/arch/sh/configs/shx3_defconfig b/arch/sh/configs/shx3_defconfig
index 32ec6eb1eabc..1095297884cd 100644
--- a/arch/sh/configs/shx3_defconfig
+++ b/arch/sh/configs/shx3_defconfig
@@ -11,7 +11,6 @@ CONFIG_CGROUPS=y
 CONFIG_CGROUP_FREEZER=y
 CONFIG_CGROUP_DEVICE=y
 CONFIG_CGROUP_CPUACCT=y
-CONFIG_CGROUP_MEMCG=y
 CONFIG_RELAY=y
 CONFIG_NAMESPACES=y
 CONFIG_UTS_NS=y
@@ -64,7 +63,6 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_ATA=y
 CONFIG_PATA_PLATFORM=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_SMC91X=y
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
@@ -80,17 +78,14 @@ CONFIG_USB=y
 CONFIG_USB_MON=y
 CONFIG_USB_R8A66597_HCD=m
 CONFIG_USB_GADGET=y
-CONFIG_USB_GADGET_M66592=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_SH=y
 CONFIG_UIO=m
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_HUGETLBFS=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_SHIRQ=y
@@ -100,3 +95,4 @@ CONFIG_FRAME_POINTER=y
 CONFIG_SH_STANDARD_BIOS=y
 CONFIG_DEBUG_STACK_USAGE=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
+CONFIG_USB_M66592=y
diff --git a/arch/sh/configs/titan_defconfig b/arch/sh/configs/titan_defconfig
index 73a0d68b0de6..da1d78fee992 100644
--- a/arch/sh/configs/titan_defconfig
+++ b/arch/sh/configs/titan_defconfig
@@ -49,7 +49,6 @@ CONFIG_INET_ESP=y
 CONFIG_INET_IPCOMP=y
 CONFIG_INET_DIAG=m
 CONFIG_IPV6=y
-CONFIG_IPV6_PRIVACY=y
 CONFIG_INET6_AH=y
 CONFIG_INET6_ESP=y
 CONFIG_INET6_IPCOMP=y
@@ -77,13 +76,11 @@ CONFIG_NETFILTER_XT_MATCH_SCTP=m
 CONFIG_NETFILTER_XT_MATCH_STRING=m
 CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
 CONFIG_IP_NF_IPTABLES=m
-CONFIG_IP_NF_MATCH_ADDRTYPE=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
 CONFIG_IP_NF_MATCH_TTL=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
-CONFIG_IP_NF_TARGET_LOG=m
 CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
@@ -144,7 +141,6 @@ CONFIG_NET_ACT_PEDIT=m
 CONFIG_FW_LOADER=m
 CONFIG_CONNECTOR=m
 CONFIG_MTD=m
-CONFIG_MTD_DEBUG=y
 CONFIG_MTD_BLOCK=m
 CONFIG_FTL=m
 CONFIG_NFTL=m
@@ -154,7 +150,6 @@ CONFIG_MTD_CFI=m
 CONFIG_MTD_JEDECPROBE=m
 CONFIG_MTD_RAW_NAND=m
 CONFIG_BLK_DEV_LOOP=m
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_ATA_OVER_ETH=m
 CONFIG_SCSI=y
@@ -169,8 +164,6 @@ CONFIG_DAVICOM_PHY=m
 CONFIG_QSEMI_PHY=m
 CONFIG_LXT_PHY=m
 CONFIG_CICADA_PHY=m
-CONFIG_NET_ETHERNET=y
-CONFIG_NET_PCI=y
 CONFIG_8139TOO=y
 # CONFIG_8139TOO_PIO is not set
 CONFIG_8139TOO_TUNE_TWISTER=y
@@ -220,8 +213,6 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_SH=m
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-# CONFIG_EXT3_FS_XATTR is not set
 CONFIG_REISERFS_FS=m
 CONFIG_XFS_FS=m
 CONFIG_FUSE_FS=m
@@ -239,7 +230,6 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=y
-CONFIG_SMB_FS=m
 CONFIG_CIFS=m
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_NLS_CODEPAGE_437=m
@@ -255,7 +245,6 @@ CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MICHAEL_MIC=y
 CONFIG_CRYPTO_SHA256=m
 CONFIG_CRYPTO_SHA512=m
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_AES=y
 CONFIG_CRYPTO_ANUBIS=m
@@ -270,3 +259,5 @@ CONFIG_CRYPTO_TWOFISH=m
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRC16=m
 CONFIG_LIBCRC32C=m
+CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
+CONFIG_NETFILTER_XT_TARGET_LOG=m
diff --git a/arch/sh/configs/ul2_defconfig b/arch/sh/configs/ul2_defconfig
index 103b81ec1ffb..2694f70e56d6 100644
--- a/arch/sh/configs/ul2_defconfig
+++ b/arch/sh/configs/ul2_defconfig
@@ -29,7 +29,6 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_IPV6 is not set
 CONFIG_CFG80211=y
 CONFIG_MAC80211=y
-CONFIG_MAC80211_RC_PID=y
 # CONFIG_MAC80211_RC_MINSTREL is not set
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
@@ -41,7 +40,6 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_ATA=y
 CONFIG_PATA_PLATFORM=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_LIBERTAS=m
 CONFIG_LIBERTAS_SDIO=m
 CONFIG_LIBERTAS_DEBUG=y
@@ -67,7 +65,6 @@ CONFIG_USB_STORAGE=y
 CONFIG_MMC=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_VFAT_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
@@ -79,6 +76,5 @@ CONFIG_NFSD=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_932=y
 CONFIG_NLS_ISO8859_1=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_CRYPTO_MICHAEL_MIC=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/sh/configs/urquell_defconfig b/arch/sh/configs/urquell_defconfig
index 8fc687c98fd1..eb0ba1b75434 100644
--- a/arch/sh/configs/urquell_defconfig
+++ b/arch/sh/configs/urquell_defconfig
@@ -13,7 +13,6 @@ CONFIG_CGROUP_DEVICE=y
 CONFIG_CPUSETS=y
 # CONFIG_PROC_PID_CPUSET is not set
 CONFIG_CGROUP_CPUACCT=y
-CONFIG_CGROUP_MEMCG=y
 CONFIG_CGROUP_SCHED=y
 CONFIG_RT_GROUP_SCHED=y
 CONFIG_BLK_DEV_INITRD=y
@@ -32,7 +31,6 @@ CONFIG_KEXEC=y
 CONFIG_SECCOMP=y
 CONFIG_PCI=y
 CONFIG_PCIEPORTBUS=y
-CONFIG_PCIEASPM_DEBUG=y
 CONFIG_PCI_DEBUG=y
 CONFIG_BINFMT_MISC=y
 CONFIG_PM=y
@@ -59,9 +57,7 @@ CONFIG_SATA_SIL24=y
 CONFIG_NETDEVICES=y
 CONFIG_PHYLIB=y
 CONFIG_MARVELL_PHY=y
-CONFIG_NET_ETHERNET=y
 CONFIG_SMC91X=y
-CONFIG_NET_PCI=y
 CONFIG_8139CP=y
 CONFIG_SKY2=y
 CONFIG_SKY2_DEBUG=y
@@ -115,7 +111,6 @@ CONFIG_RTC_DRV_SH=y
 CONFIG_RTC_DRV_GENERIC=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_EXT4_FS=y
 CONFIG_BTRFS_FS=y
 CONFIG_MSDOS_FS=y
@@ -134,7 +129,6 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_932=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_PRINTK_TIME=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_HUNG_TASK=y
-- 
2.17.1

