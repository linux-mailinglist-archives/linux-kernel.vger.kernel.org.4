Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B475EF336
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbiI2KQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235477AbiI2KPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:15:34 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E770413F2AC;
        Thu, 29 Sep 2022 03:15:08 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id s14so1445511wro.0;
        Thu, 29 Sep 2022 03:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=wBxQTk+ONmm7hrnfe1vaeGpF3i3UIPDGS7Q2KKRSWsM=;
        b=eVLazdNUWnGYhZEPUI48twAK5x1aSp65GlmgOXikADJAgmeOZDW8Y1rNGd30+lQFto
         jkorP92VkEZ4CmQDTyYa8hQfAIGxjm2zp3bNo9Hd6VNqcPX7KbfOA96Yy4PWapt/ObAm
         aEgXhC1gGKqjhRkXvIBUDD/Q+SpiweofuCnSxtDUf2iJnBv+IbaECdu0xPQ7slioJ04M
         lqWuS/Pf0ggmNV6pc0XdF9QPXtCu1noyht+7bfaFJ7KlaFtc8AGeKc+4n6g79U2LUMdv
         vK4khGysDHZ9LO7BmyVDi5YYI5n7RXD4WkvfQFaoQm/6YI9uae9U0K9yDRJHUD+S9ah2
         zxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=wBxQTk+ONmm7hrnfe1vaeGpF3i3UIPDGS7Q2KKRSWsM=;
        b=u4EFx6MBqOSe6iig8doilmYOuV3whXrF6+IbMGaPWCPapxavAwkzbzQ7TWG9CtybRe
         V+IQsSx0Bn70Dj6xTICwLSEDaVRr0MSqL+VGUb5psviq1HRuCkH9dXISUNX7Y/4qQVTy
         KdqzttJR4PNwCq6ukRGiHJOggc6yHudFSaReeaD2j2iYdJtLzK8AcgUl3y3KYSb3vyoJ
         aJ0lZirbJbQzec2EUQTgfWuyG2tYb2TQFMmxof0g1DCMRCgVNCLSjuDxZpRgvEby5Mp9
         ubopjewxPlwSn9Lj+n0VIPR8vHunhwEHF9sID2NdiziZwQIyDeKwli0m6f/U414qgIn1
         K3og==
X-Gm-Message-State: ACrzQf3gJN0MTbZF9+tfH+QaNdNFfjcetKRlPs1cW6DuUHZplbJFN6Np
        oVoasoqiCoa557duVDu56xME5++z7Q5Jgg==
X-Google-Smtp-Source: AMsMyM5jG3MToWxWYX0RnrWohMUHHC6RmilbwdEkKZAfoAK7WS5C+7JZKmaV8MQyZj+S/vf4jYAo4A==
X-Received: by 2002:adf:f501:0:b0:22c:cbea:240a with SMTP id q1-20020adff501000000b0022ccbea240amr1708897wro.78.1664446506718;
        Thu, 29 Sep 2022 03:15:06 -0700 (PDT)
Received: from felia.fritz.box (200116b826e11200b190ebfd45660ea6.dip.versatel-1u1.de. [2001:16b8:26e1:1200:b190:ebfd:4566:ea6])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c4e8e00b003b47e75b401sm4412219wmq.37.2022.09.29.03.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 03:15:06 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] powerpc: update config files
Date:   Thu, 29 Sep 2022 12:15:02 +0200
Message-Id: <20220929101502.32527-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
 arch/powerpc/configs/83xx/mpc837x_rdb_defconfig | 1 -
 arch/powerpc/configs/85xx/ge_imp3a_defconfig    | 1 -
 arch/powerpc/configs/85xx/ppa8548_defconfig     | 2 --
 arch/powerpc/configs/cell_defconfig             | 1 -
 arch/powerpc/configs/g5_defconfig               | 1 -
 arch/powerpc/configs/mpc512x_defconfig          | 1 -
 arch/powerpc/configs/mpc885_ads_defconfig       | 2 +-
 arch/powerpc/configs/pasemi_defconfig           | 1 -
 arch/powerpc/configs/pmac32_defconfig           | 1 -
 arch/powerpc/configs/powernv_defconfig          | 3 ---
 arch/powerpc/configs/ppc64_defconfig            | 3 ---
 arch/powerpc/configs/ppc64e_defconfig           | 3 ---
 arch/powerpc/configs/ppc6xx_defconfig           | 7 -------
 arch/powerpc/configs/ps3_defconfig              | 1 -
 arch/powerpc/configs/pseries_defconfig          | 3 ---
 arch/powerpc/configs/skiroot_defconfig          | 2 --
 arch/powerpc/configs/storcenter_defconfig       | 1 -
 17 files changed, 1 insertion(+), 33 deletions(-)

diff --git a/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig b/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig
index cbcae2a927e9..4e3373381ab6 100644
--- a/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig
+++ b/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig
@@ -77,6 +77,5 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_CRC_T10DIF=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
diff --git a/arch/powerpc/configs/85xx/ge_imp3a_defconfig b/arch/powerpc/configs/85xx/ge_imp3a_defconfig
index e7672c186325..ea719898b581 100644
--- a/arch/powerpc/configs/85xx/ge_imp3a_defconfig
+++ b/arch/powerpc/configs/85xx/ge_imp3a_defconfig
@@ -74,7 +74,6 @@ CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_FSL_ELBC=y
 CONFIG_BLK_DEV_LOOP=m
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=131072
diff --git a/arch/powerpc/configs/85xx/ppa8548_defconfig b/arch/powerpc/configs/85xx/ppa8548_defconfig
index 190978a5b7d5..4bd5f993d26a 100644
--- a/arch/powerpc/configs/85xx/ppa8548_defconfig
+++ b/arch/powerpc/configs/85xx/ppa8548_defconfig
@@ -7,9 +7,7 @@ CONFIG_RAPIDIO=y
 CONFIG_FSL_RIO=y
 CONFIG_RAPIDIO_DMA_ENGINE=y
 CONFIG_RAPIDIO_ENUM_BASIC=y
-CONFIG_RAPIDIO_TSI57X=y
 CONFIG_RAPIDIO_CPS_XX=y
-CONFIG_RAPIDIO_TSI568=y
 CONFIG_RAPIDIO_CPS_GEN2=y
 CONFIG_ADVANCED_OPTIONS=y
 CONFIG_LOWMEM_SIZE_BOOL=y
diff --git a/arch/powerpc/configs/cell_defconfig b/arch/powerpc/configs/cell_defconfig
index 7fd9e596ea33..06391cc2af3a 100644
--- a/arch/powerpc/configs/cell_defconfig
+++ b/arch/powerpc/configs/cell_defconfig
@@ -195,7 +195,6 @@ CONFIG_NLS_ISO8859_9=m
 CONFIG_NLS_ISO8859_13=m
 CONFIG_NLS_ISO8859_14=m
 CONFIG_NLS_ISO8859_15=m
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_MUTEXES=y
diff --git a/arch/powerpc/configs/g5_defconfig b/arch/powerpc/configs/g5_defconfig
index 9d6212a8b195..71d9d112c0b6 100644
--- a/arch/powerpc/configs/g5_defconfig
+++ b/arch/powerpc/configs/g5_defconfig
@@ -119,7 +119,6 @@ CONFIG_INPUT_EVDEV=y
 # CONFIG_SERIO_I8042 is not set
 # CONFIG_SERIO_SERPORT is not set
 # CONFIG_HW_RANDOM is not set
-CONFIG_RAW_DRIVER=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_AGP=m
 CONFIG_AGP_UNINORTH=m
diff --git a/arch/powerpc/configs/mpc512x_defconfig b/arch/powerpc/configs/mpc512x_defconfig
index e75d3f3060c9..10fe061c5e6d 100644
--- a/arch/powerpc/configs/mpc512x_defconfig
+++ b/arch/powerpc/configs/mpc512x_defconfig
@@ -114,5 +114,4 @@ CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_CRYPTO_HW is not set
diff --git a/arch/powerpc/configs/mpc885_ads_defconfig b/arch/powerpc/configs/mpc885_ads_defconfig
index 700115d85d6f..56b876e418e9 100644
--- a/arch/powerpc/configs/mpc885_ads_defconfig
+++ b/arch/powerpc/configs/mpc885_ads_defconfig
@@ -78,4 +78,4 @@ CONFIG_DEBUG_VM_PGTABLE=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_BDI_SWITCH=y
 CONFIG_PPC_EARLY_DEBUG=y
-CONFIG_PPC_PTDUMP=y
+CONFIG_GENERIC_PTDUMP=y
diff --git a/arch/powerpc/configs/pasemi_defconfig b/arch/powerpc/configs/pasemi_defconfig
index e00a703581c3..96aa5355911f 100644
--- a/arch/powerpc/configs/pasemi_defconfig
+++ b/arch/powerpc/configs/pasemi_defconfig
@@ -92,7 +92,6 @@ CONFIG_LEGACY_PTY_COUNT=4
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_HW_RANDOM=y
-CONFIG_RAW_DRIVER=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_PASEMI=y
 CONFIG_SENSORS_LM85=y
diff --git a/arch/powerpc/configs/pmac32_defconfig b/arch/powerpc/configs/pmac32_defconfig
index 13885ec563d1..019163c2571e 100644
--- a/arch/powerpc/configs/pmac32_defconfig
+++ b/arch/powerpc/configs/pmac32_defconfig
@@ -284,7 +284,6 @@ CONFIG_BOOTX_TEXT=y
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_SHA512=m
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_BLOWFISH=m
diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
index 4acca5263404..e1213973d858 100644
--- a/arch/powerpc/configs/powernv_defconfig
+++ b/arch/powerpc/configs/powernv_defconfig
@@ -251,7 +251,6 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_GENERIC=y
 # CONFIG_VIRTIO_MENU is not set
 CONFIG_LIBNVDIMM=y
-# CONFIG_ND_BLK is not set
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
@@ -324,13 +323,11 @@ CONFIG_CRYPTO_MD5_PPC=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_SHA1_PPC=m
 CONFIG_CRYPTO_SHA256=y
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_CAST6=m
 CONFIG_CRYPTO_KHAZAD=m
-CONFIG_CRYPTO_SALSA20=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 6be0c43397b4..d6949a6c5b2b 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -215,7 +215,6 @@ CONFIG_HVC_RTAS=y
 CONFIG_HVCS=m
 CONFIG_VIRTIO_CONSOLE=m
 CONFIG_IBM_BSR=m
-CONFIG_RAW_DRIVER=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_AMD8111=y
 CONFIG_I2C_PASEMI=y
@@ -344,13 +343,11 @@ CONFIG_CRYPTO_MD5_PPC=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_SHA1_PPC=m
 CONFIG_CRYPTO_SHA256=y
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_CAST6=m
 CONFIG_CRYPTO_KHAZAD=m
-CONFIG_CRYPTO_SALSA20=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
diff --git a/arch/powerpc/configs/ppc64e_defconfig b/arch/powerpc/configs/ppc64e_defconfig
index 5cf49a515f8e..f97a2d31bbf7 100644
--- a/arch/powerpc/configs/ppc64e_defconfig
+++ b/arch/powerpc/configs/ppc64e_defconfig
@@ -118,7 +118,6 @@ CONFIG_INPUT_MISC=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
-CONFIG_RAW_DRIVER=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_AMD8111=y
 CONFIG_FB=y
@@ -234,13 +233,11 @@ CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_SHA512=m
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_CAST6=m
 CONFIG_CRYPTO_KHAZAD=m
-CONFIG_CRYPTO_SALSA20=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index a24f484bfbd2..d23deb94b36e 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -321,7 +321,6 @@ CONFIG_PNP=y
 CONFIG_ISAPNP=y
 CONFIG_MAC_FLOPPY=m
 CONFIG_BLK_DEV_LOOP=m
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=16384
@@ -590,7 +589,6 @@ CONFIG_GAMEPORT_EMU10K1=m
 CONFIG_GAMEPORT_FM801=m
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_NONSTANDARD=y
-CONFIG_ROCKETPORT=m
 CONFIG_SYNCLINK_GT=m
 CONFIG_NOZOMI=m
 CONFIG_N_HDLC=m
@@ -1107,13 +1105,9 @@ CONFIG_CRYPTO_XTS=m
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_RMD128=m
 CONFIG_CRYPTO_RMD160=m
-CONFIG_CRYPTO_RMD256=m
-CONFIG_CRYPTO_RMD320=m
 CONFIG_CRYPTO_SHA1=y
 CONFIG_CRYPTO_SHA512=m
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_BLOWFISH=m
@@ -1121,7 +1115,6 @@ CONFIG_CRYPTO_CAMELLIA=m
 CONFIG_CRYPTO_CAST6=m
 CONFIG_CRYPTO_FCRYPT=m
 CONFIG_CRYPTO_KHAZAD=m
-CONFIG_CRYPTO_SALSA20=m
 CONFIG_CRYPTO_SEED=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
diff --git a/arch/powerpc/configs/ps3_defconfig b/arch/powerpc/configs/ps3_defconfig
index 2d9ac233da68..0a1b42c4f26a 100644
--- a/arch/powerpc/configs/ps3_defconfig
+++ b/arch/powerpc/configs/ps3_defconfig
@@ -165,6 +165,5 @@ CONFIG_RCU_CPU_STALL_TIMEOUT=60
 # CONFIG_FTRACE is not set
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_SALSA20=m
 CONFIG_CRYPTO_LZO=m
 CONFIG_PRINTK_TIME=y
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index 44c0e6e5f546..7497e17ea657 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -189,7 +189,6 @@ CONFIG_HVC_RTAS=y
 CONFIG_HVCS=m
 CONFIG_VIRTIO_CONSOLE=m
 CONFIG_IBM_BSR=m
-CONFIG_RAW_DRIVER=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
@@ -304,13 +303,11 @@ CONFIG_CRYPTO_MD5_PPC=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_SHA1_PPC=m
 CONFIG_CRYPTO_SHA256=y
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_CAST6=m
 CONFIG_CRYPTO_KHAZAD=m
-CONFIG_CRYPTO_SALSA20=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
diff --git a/arch/powerpc/configs/skiroot_defconfig b/arch/powerpc/configs/skiroot_defconfig
index f491875700e8..e0964210f259 100644
--- a/arch/powerpc/configs/skiroot_defconfig
+++ b/arch/powerpc/configs/skiroot_defconfig
@@ -133,7 +133,6 @@ CONFIG_ACENIC_OMIT_TIGON_I=y
 # CONFIG_NET_VENDOR_AQUANTIA is not set
 # CONFIG_NET_VENDOR_ARC is not set
 # CONFIG_NET_VENDOR_ATHEROS is not set
-# CONFIG_NET_VENDOR_AURORA is not set
 CONFIG_TIGON3=m
 CONFIG_BNX2X=m
 # CONFIG_NET_VENDOR_BROCADE is not set
@@ -274,7 +273,6 @@ CONFIG_NLS_UTF8=y
 CONFIG_ENCRYPTED_KEYS=y
 CONFIG_SECURITY=y
 CONFIG_HARDENED_USERCOPY=y
-CONFIG_HARDENED_USERCOPY_PAGESPAN=y
 CONFIG_FORTIFY_SOURCE=y
 CONFIG_SECURITY_LOCKDOWN_LSM=y
 CONFIG_SECURITY_LOCKDOWN_LSM_EARLY=y
diff --git a/arch/powerpc/configs/storcenter_defconfig b/arch/powerpc/configs/storcenter_defconfig
index 47dcfaddc1ac..7a978d396991 100644
--- a/arch/powerpc/configs/storcenter_defconfig
+++ b/arch/powerpc/configs/storcenter_defconfig
@@ -76,4 +76,3 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
 CONFIG_CRC_T10DIF=y
-# CONFIG_ENABLE_MUST_CHECK is not set
-- 
2.17.1

