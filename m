Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E169D60F186
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 09:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbiJ0Hva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 03:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbiJ0HvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 03:51:18 -0400
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CB8A8351;
        Thu, 27 Oct 2022 00:51:11 -0700 (PDT)
X-QQ-mid: bizesmtp73t1666857066t3if1a5l
Received: from localhost.localdomain ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 27 Oct 2022 15:51:05 +0800 (CST)
X-QQ-SSF: 01400000000000B0E000000A0000000
X-QQ-FEAT: eSZ1CZgv+JB4GhixT03N5Oq70SwhexyGMU4hrahRqlY5/JM3FI4jTmQ+DW0Es
        Jhn3pjBTr5a4836pZ3gmDSpZubdMknaeWnumHSkQBfN2Ew1UGBdubEUmOb3WwtdvCFPzlTf
        b+5z2L+SzU6BLa8EdBMN+v4+ybNfRs0DBwu/UG034BAR96orY/tlMPALQYpb3jvOpKS8scl
        6LrnEpNt3GK21+uhg8Lay1nKs6kd46YCeR2sbK2AuxP9YWnWuy5b+K1aOIYh8UvvseyDQfy
        iWz5TGi7CxkognQ9iSZ382ksTsglUlRNTon8ja83buicBmQscpnMwEZCPpseITOAKJ9Va8x
        V5+OlebPulROYVUtKJs11pqIszyYdbNX60QhCNGLgf0GtsqXWF2VKeWLoIkiw==
X-QQ-GoodBg: 1
From:   guanwentao <guanwentao@uniontech.com>
To:     linux@armlinux.org.uk
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, lukas.bulwahn@gmail.com,
        guanwentao <guanwentao@uniontech.com>
Subject: [PATCH] arm/configs: Update config files for removed symbols
Date:   Thu, 27 Oct 2022 15:50:36 +0800
Message-Id: <20221027075036.14865-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  just like:
  d210ee3("powerpc: Update config files for removed/renamed symbols")

  Clean up config files by:
  - removing configs that were deleted in the past

  Removed:
  - CONFIG_BLK_DEV_CRYPTOLOOP
    47e9624 ("block: remove support for cryptoloop and the xor transfer")

  - CONFIG_CRYPTO_RMD128
    b21b9a5 ("crypto: rmd128 - remove RIPE-MD 128 hash algorithm")

  - CONFIG_CRYPTO_RMD256
    c15d416 ("crypto: rmd256 - remove RIPE-MD 256 hash algorithm")

  - CONFIG_CRYPTO_RMD320
    93f6420 ("crypto: rmd320 - remove RIPE-MD 320 hash algorithm")

  - CONFIG_CRYPTO_SALSA20
    663f63e ("crypto: salsa20 - remove Salsa20 stream cipher algorithm")

  - CONFIG_CRYPTO_TGR192
    87cd723 ("crypto: tgr192 - remove Tiger 128/160/192 hash algorithms")

  - CONFIG_RAW_DRIVER
    603e492 ("remove the raw driver")

  - CONFIG_ENABLE_MUST_CHECK
    1967939 ("Compiler Attributes: remove CONFIG_ENABLE_MUST_CHECK")

  - CONFIG_NFT_COUNTER
    023223d ("netfilter: nf_tables: make counter support built-in")

  - CONFIG_NF_FLOW_TABLE_IPV4,NF_FLOW_TABLE_IPV6
    023223d ("netfilter: flowtable: remove ipv4/ipv6 modules")

Signed-off-by: guanwentao <guanwentao@uniontech.com>
---
 arch/arm/configs/bcm2835_defconfig        | 1 -
 arch/arm/configs/cns3420vb_defconfig      | 1 -
 arch/arm/configs/colibri_pxa270_defconfig | 1 -
 arch/arm/configs/eseries_pxa_defconfig    | 1 -
 arch/arm/configs/exynos_defconfig         | 2 --
 arch/arm/configs/ezx_defconfig            | 2 --
 arch/arm/configs/iop32x_defconfig         | 1 -
 arch/arm/configs/lpc18xx_defconfig        | 1 -
 arch/arm/configs/lpc32xx_defconfig        | 1 -
 arch/arm/configs/mini2440_defconfig       | 6 ------
 arch/arm/configs/moxart_defconfig         | 1 -
 arch/arm/configs/mps2_defconfig           | 1 -
 arch/arm/configs/nhk8815_defconfig        | 1 -
 arch/arm/configs/omap1_defconfig          | 1 -
 arch/arm/configs/omap2plus_defconfig      | 3 ---
 arch/arm/configs/pxa_defconfig            | 2 --
 arch/arm/configs/spear13xx_defconfig      | 1 -
 arch/arm/configs/spear3xx_defconfig       | 1 -
 arch/arm/configs/stm32_defconfig          | 1 -
 arch/arm/configs/tct_hammer_defconfig     | 1 -
 arch/arm/configs/trizeps4_defconfig       | 1 -
 21 files changed, 31 deletions(-)

diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index a51babd178c2..825627c7fcf3 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -177,7 +177,6 @@ CONFIG_PRINTK_TIME=y
 CONFIG_BOOT_PRINTK_DELAY=y
 CONFIG_DYNAMIC_DEBUG=y
 CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_LOCKUP_DETECTOR=y
 CONFIG_DEBUG_FS=y
 CONFIG_KGDB=y
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
index 8357d721c69c..04ba7a4c07d9 100644
--- a/arch/arm/configs/colibri_pxa270_defconfig
+++ b/arch/arm/configs/colibri_pxa270_defconfig
@@ -66,7 +66,6 @@ CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0x4000000
 CONFIG_MTD_NAND_DISKONCHIP_PROBE_HIGH=y
 CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE=y
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=8
diff --git a/arch/arm/configs/eseries_pxa_defconfig b/arch/arm/configs/eseries_pxa_defconfig
index b4c2e6457e04..ec914e624928 100644
--- a/arch/arm/configs/eseries_pxa_defconfig
+++ b/arch/arm/configs/eseries_pxa_defconfig
@@ -89,7 +89,6 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_CRYPTO_CBC=m
 CONFIG_CRYPTO_PCBC=m
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
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
index ef7b0a0aee3a..277567c82254 100644
--- a/arch/arm/configs/ezx_defconfig
+++ b/arch/arm/configs/ezx_defconfig
@@ -172,7 +172,6 @@ CONFIG_MTD_OTP=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_PXA2XX=y
 CONFIG_BLK_DEV_LOOP=m
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_NETDEVICES=y
@@ -366,7 +365,6 @@ CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_SHA256=m
 CONFIG_CRYPTO_SHA512=m
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_AES=m
 CONFIG_CRYPTO_ARC4=m
 CONFIG_CRYPTO_BLOWFISH=m
diff --git a/arch/arm/configs/iop32x_defconfig b/arch/arm/configs/iop32x_defconfig
index 19e30e790d35..ca081ac1c256 100644
--- a/arch/arm/configs/iop32x_defconfig
+++ b/arch/arm/configs/iop32x_defconfig
@@ -104,7 +104,6 @@ CONFIG_CRYPTO_MICHAEL_MIC=y
 CONFIG_CRYPTO_SHA1=y
 CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_SHA512=y
-CONFIG_CRYPTO_TGR192=y
 CONFIG_CRYPTO_WP512=y
 CONFIG_CRYPTO_AES=y
 CONFIG_CRYPTO_ANUBIS=y
diff --git a/arch/arm/configs/lpc18xx_defconfig b/arch/arm/configs/lpc18xx_defconfig
index 56eae6a0a311..4a7cd6a48371 100644
--- a/arch/arm/configs/lpc18xx_defconfig
+++ b/arch/arm/configs/lpc18xx_defconfig
@@ -150,7 +150,6 @@ CONFIG_JFFS2_FS=y
 CONFIG_CRC_ITU_T=y
 CONFIG_CRC7=y
 CONFIG_PRINTK_TIME=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
diff --git a/arch/arm/configs/lpc32xx_defconfig b/arch/arm/configs/lpc32xx_defconfig
index fabb66a53350..335bbf95afd0 100644
--- a/arch/arm/configs/lpc32xx_defconfig
+++ b/arch/arm/configs/lpc32xx_defconfig
@@ -48,7 +48,6 @@ CONFIG_MTD_NAND_SLC_LPC32XX=y
 CONFIG_MTD_NAND_MLC_LPC32XX=y
 CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_CRYPTOLOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=1
 CONFIG_BLK_DEV_RAM_SIZE=16384
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
diff --git a/arch/arm/configs/moxart_defconfig b/arch/arm/configs/moxart_defconfig
index ea31f116d577..5dadbedf8007 100644
--- a/arch/arm/configs/moxart_defconfig
+++ b/arch/arm/configs/moxart_defconfig
@@ -122,7 +122,6 @@ CONFIG_CRC32_BIT=y
 CONFIG_DMA_API_DEBUG=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_KGDB=y
 CONFIG_DEBUG_PAGEALLOC=y
 # CONFIG_SLUB_DEBUG is not set
diff --git a/arch/arm/configs/mps2_defconfig b/arch/arm/configs/mps2_defconfig
index 3ed73f184d83..ffcbeba9cfdb 100644
--- a/arch/arm/configs/mps2_defconfig
+++ b/arch/arm/configs/mps2_defconfig
@@ -94,7 +94,6 @@ CONFIG_NFS_V4_2=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS=y
 CONFIG_PRINTK_TIME=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_DEBUG_FS=y
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
index 70511fe4b3ec..2f277be540e0 100644
--- a/arch/arm/configs/omap1_defconfig
+++ b/arch/arm/configs/omap1_defconfig
@@ -216,7 +216,6 @@ CONFIG_NLS_ISO8859_5=y
 CONFIG_NLS_ISO8859_15=y
 CONFIG_NLS_KOI8_R=y
 CONFIG_NLS_UTF8=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_KERNEL=y
 CONFIG_SECURITY=y
 CONFIG_CRYPTO_ECB=y
diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 2a66850d3288..4a5ca2ea4b7a 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -100,7 +100,6 @@ CONFIG_NF_TABLES_INET=y
 CONFIG_NF_TABLES_NETDEV=y
 CONFIG_NFT_NUMGEN=m
 CONFIG_NFT_CT=m
-CONFIG_NFT_COUNTER=m
 CONFIG_NFT_CONNLIMIT=m
 CONFIG_NFT_LOG=m
 CONFIG_NFT_LIMIT=m
@@ -187,7 +186,6 @@ CONFIG_NETFILTER_XT_MATCH_TIME=m
 CONFIG_NETFILTER_XT_MATCH_U32=m
 CONFIG_NFT_DUP_IPV4=m
 CONFIG_NFT_FIB_IPV4=m
-CONFIG_NF_FLOW_TABLE_IPV4=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
@@ -208,7 +206,6 @@ CONFIG_IP_NF_RAW=m
 CONFIG_IP_NF_SECURITY=m
 CONFIG_NFT_DUP_IPV6=m
 CONFIG_NFT_FIB_IPV6=m
-CONFIG_NF_FLOW_TABLE_IPV6=m
 CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP6_NF_MATCH_AH=m
 CONFIG_IP6_NF_MATCH_EUI64=m
diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
index d60cc9cc4c21..9c4363e46228 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -152,7 +152,6 @@ CONFIG_MTD_SPI_NOR=m
 CONFIG_MTD_UBI=m
 CONFIG_MTD_UBI_BLOCK=y
 CONFIG_BLK_DEV_LOOP=m
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=8
@@ -657,7 +656,6 @@ CONFIG_CRYPTO_XTS=m
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_VMAC=m
 CONFIG_CRYPTO_SHA512=m
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_BLOWFISH=m
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
index 009abe1e49ef..32c12cebd2a0 100644
--- a/arch/arm/configs/trizeps4_defconfig
+++ b/arch/arm/configs/trizeps4_defconfig
@@ -80,7 +80,6 @@ CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0x4000000
 CONFIG_MTD_NAND_DISKONCHIP_PROBE_HIGH=y
 CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE=y
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=8
-- 
2.20.1

