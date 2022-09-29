Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089BD5EF334
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbiI2KPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235367AbiI2KPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:15:11 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66531D07AD;
        Thu, 29 Sep 2022 03:14:56 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x18so1407702wrm.7;
        Thu, 29 Sep 2022 03:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Eacrn3y9cEv/xcKhNqIqfAPghgiQw+eqox3ZgmJtSP0=;
        b=pqHmYBkgX9Vw1klfYK8IMhqmtjYz+randCagHvVe/oeKPJoGU6uIYJZO08kdbxXkt9
         aXbJpc81EQ3W6YswiVkVn+OtJ83WTehLuczPgxzUmWT62mvtBUJesDX5Kpa9sSPFmwCg
         BMyQZXJmsR3pwv6XC4Am5cy/996OQHemsCNgS4XQlvunyP8x5/VsKFMOzvl5tD7+h7R6
         yNY6cC+1wB2YoPTxqzh22zwTnN9IG+8jS5MRdcTMqvk/jkaUgI7bKxjvPzIzzy14yKZZ
         25wW3v3g4CySSlYMhfCyikgIbZF4T4yzvLbHhJWt/0y0/dGG5Pxb8mGSS7dd8JiY39ia
         AZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Eacrn3y9cEv/xcKhNqIqfAPghgiQw+eqox3ZgmJtSP0=;
        b=NDWo20i7LH+0iGBcAJeEZhk5PMpzDdIhhoq2TSSQqVHdhrvffx1+CiNa78nIAhAMD7
         q8eWO1J73jbc3g3iF8v1YUksbY2LtIav08sU6O092VkRv+A3FHR/5y3c/7LeM7teTzob
         JradKm5m+vf8dPY/DD+Xmwsjn0807gN5h+GtvIHvMHour8CiTsORPUwJl6TfKEiZgF7m
         IL7LEcveaFMtG1/deFv+q9DHVDYZEExnnpUZ7ei4LWHiI9N+iRY9v2w/G3ezaTacoxZ8
         ko69p+MG78GtC7f9FiojkQRpoJt81zgJTOe4OqgtzIK+Nmr5DlDnAegTM8xlWI/hN6Vl
         2x6g==
X-Gm-Message-State: ACrzQf2hKosDlFbYqQaWL3uHLBBSnnJmK3UAQOYF8+MBVeqdyDTVYvC1
        Mf8R8kzfKaaQd1fyhLeypJvRi0wTMhw=
X-Google-Smtp-Source: AMsMyM7lOPOEBWsmzNfFRAaxlNJuT7nnKKin4ytjU/t3yA2JKp/cGbQMjTTBgH4pZLX8vLtVxFQfHQ==
X-Received: by 2002:adf:fe08:0:b0:22b:311:afcd with SMTP id n8-20020adffe08000000b0022b0311afcdmr1642835wrr.629.1664446494491;
        Thu, 29 Sep 2022 03:14:54 -0700 (PDT)
Received: from felia.fritz.box (200116b826e11200b190ebfd45660ea6.dip.versatel-1u1.de. [2001:16b8:26e1:1200:b190:ebfd:4566:ea6])
        by smtp.gmail.com with ESMTPSA id n22-20020a05600c4f9600b003b4cba4ef71sm4345770wmq.41.2022.09.29.03.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 03:14:54 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] mips: update config files
Date:   Thu, 29 Sep 2022 12:14:51 +0200
Message-Id: <20220929101451.32267-1-lukas.bulwahn@gmail.com>
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
 arch/mips/configs/ar7_defconfig               |  4 ----
 arch/mips/configs/ath25_defconfig             |  4 ----
 arch/mips/configs/ath79_defconfig             | 10 --------
 arch/mips/configs/bcm63xx_defconfig           |  3 ---
 arch/mips/configs/bigsur_defconfig            |  9 --------
 arch/mips/configs/bmips_be_defconfig          |  3 ---
 arch/mips/configs/bmips_stb_defconfig         | 23 ++-----------------
 arch/mips/configs/cavium_octeon_defconfig     |  1 -
 arch/mips/configs/db1xxx_defconfig            |  1 -
 arch/mips/configs/decstation_64_defconfig     | 10 --------
 arch/mips/configs/decstation_defconfig        | 10 --------
 arch/mips/configs/decstation_r4k_defconfig    | 10 --------
 arch/mips/configs/fuloong2e_defconfig         |  9 --------
 arch/mips/configs/generic/board-ocelot.config |  1 -
 arch/mips/configs/gpr_defconfig               |  8 -------
 arch/mips/configs/ip22_defconfig              | 10 --------
 arch/mips/configs/ip27_defconfig              | 19 ---------------
 arch/mips/configs/ip28_defconfig              |  3 ---
 arch/mips/configs/ip32_defconfig              |  2 --
 arch/mips/configs/jazz_defconfig              |  1 -
 arch/mips/configs/lemote2f_defconfig          |  9 --------
 arch/mips/configs/loongson1b_defconfig        |  4 ----
 arch/mips/configs/loongson1c_defconfig        |  4 ----
 arch/mips/configs/loongson2k_defconfig        |  3 ---
 arch/mips/configs/loongson3_defconfig         |  2 --
 arch/mips/configs/malta_defconfig             |  5 ----
 arch/mips/configs/malta_kvm_defconfig         |  5 ----
 arch/mips/configs/malta_qemu_32r6_defconfig   |  3 ---
 arch/mips/configs/maltaaprp_defconfig         |  3 ---
 arch/mips/configs/maltasmvp_defconfig         |  3 ---
 arch/mips/configs/maltasmvp_eva_defconfig     |  3 ---
 arch/mips/configs/maltaup_defconfig           |  3 ---
 arch/mips/configs/maltaup_xpa_defconfig       |  5 ----
 arch/mips/configs/mtx1_defconfig              | 10 --------
 arch/mips/configs/omega2p_defconfig           |  3 ---
 arch/mips/configs/pic32mzda_defconfig         |  1 -
 arch/mips/configs/rb532_defconfig             |  4 ----
 arch/mips/configs/rbtx49xx_defconfig          |  7 ------
 arch/mips/configs/rm200_defconfig             |  7 ------
 arch/mips/configs/rt305x_defconfig            |  4 ----
 arch/mips/configs/sb1250_swarm_defconfig      |  2 --
 arch/mips/configs/vocore2_defconfig           |  3 ---
 arch/mips/configs/xway_defconfig              |  4 ----
 43 files changed, 2 insertions(+), 236 deletions(-)

diff --git a/arch/mips/configs/ar7_defconfig b/arch/mips/configs/ar7_defconfig
index cf9c6329b807..ed4a6388791e 100644
--- a/arch/mips/configs/ar7_defconfig
+++ b/arch/mips/configs/ar7_defconfig
@@ -32,9 +32,6 @@ CONFIG_IP_ROUTE_MULTIPATH=y
 CONFIG_IP_ROUTE_VERBOSE=y
 CONFIG_IP_MROUTE=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 CONFIG_TCP_CONG_ADVANCED=y
 # CONFIG_TCP_CONG_BIC is not set
@@ -117,7 +114,6 @@ CONFIG_JFFS2_SUMMARY=y
 CONFIG_JFFS2_COMPRESSION_OPTIONS=y
 CONFIG_SQUASHFS=y
 # CONFIG_CRYPTO_HW is not set
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_DEBUG_FS=y
 CONFIG_CMDLINE_BOOL=y
diff --git a/arch/mips/configs/ath25_defconfig b/arch/mips/configs/ath25_defconfig
index 7143441f5476..afd1c16242e9 100644
--- a/arch/mips/configs/ath25_defconfig
+++ b/arch/mips/configs/ath25_defconfig
@@ -29,9 +29,6 @@ CONFIG_UNIX=y
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
 CONFIG_IP_ADVANCED_ROUTER=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_IPV6 is not set
 CONFIG_CFG80211=m
 CONFIG_MAC80211=m
@@ -108,7 +105,6 @@ CONFIG_SQUASHFS_XZ=y
 # CONFIG_XZ_DEC_ARMTHUMB is not set
 # CONFIG_XZ_DEC_SPARC is not set
 CONFIG_PRINTK_TIME=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_DEBUG_FS=y
 # CONFIG_SCHED_DEBUG is not set
diff --git a/arch/mips/configs/ath79_defconfig b/arch/mips/configs/ath79_defconfig
index 96622a2ad333..0b741716c852 100644
--- a/arch/mips/configs/ath79_defconfig
+++ b/arch/mips/configs/ath79_defconfig
@@ -10,12 +10,6 @@ CONFIG_EMBEDDED=y
 # CONFIG_SLUB_DEBUG is not set
 # CONFIG_COMPAT_BRK is not set
 CONFIG_ATH79=y
-CONFIG_ATH79_MACH_AP121=y
-CONFIG_ATH79_MACH_AP136=y
-CONFIG_ATH79_MACH_AP81=y
-CONFIG_ATH79_MACH_DB120=y
-CONFIG_ATH79_MACH_PB44=y
-CONFIG_ATH79_MACH_UBNT_XM=y
 CONFIG_HZ_100=y
 # CONFIG_SECCOMP is not set
 CONFIG_PCI=y
@@ -29,9 +23,6 @@ CONFIG_UNIX=y
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
 CONFIG_IP_ADVANCED_ROUTER=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_IPV6 is not set
 CONFIG_CFG80211=m
 CONFIG_MAC80211=m
@@ -92,7 +83,6 @@ CONFIG_LEDS_GPIO=y
 # CONFIG_DNOTIFY is not set
 # CONFIG_PROC_PAGE_MONITOR is not set
 CONFIG_CRC_ITU_T=m
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_DEBUG_FS=y
 # CONFIG_SCHED_DEBUG is not set
diff --git a/arch/mips/configs/bcm63xx_defconfig b/arch/mips/configs/bcm63xx_defconfig
index 861f680184b9..34d0ca638ef0 100644
--- a/arch/mips/configs/bcm63xx_defconfig
+++ b/arch/mips/configs/bcm63xx_defconfig
@@ -24,9 +24,6 @@ CONFIG_PCMCIA_BCM63XX=y
 CONFIG_NET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 CONFIG_CFG80211=y
diff --git a/arch/mips/configs/bigsur_defconfig b/arch/mips/configs/bigsur_defconfig
index d83e7d600b0a..d15961f00ece 100644
--- a/arch/mips/configs/bigsur_defconfig
+++ b/arch/mips/configs/bigsur_defconfig
@@ -49,8 +49,6 @@ CONFIG_IP_PIMSM_V2=y
 CONFIG_INET_AH=m
 CONFIG_INET_ESP=m
 CONFIG_INET_IPCOMP=m
-CONFIG_INET_XFRM_MODE_TRANSPORT=m
-CONFIG_INET_XFRM_MODE_TUNNEL=m
 CONFIG_TCP_MD5SIG=y
 CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_IPV6_ROUTE_INFO=y
@@ -59,7 +57,6 @@ CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
 CONFIG_INET6_IPCOMP=m
 CONFIG_IPV6_MIP6=m
-CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=m
 CONFIG_IPV6_SIT_6RD=y
 CONFIG_IPV6_TUNNEL=m
 CONFIG_IPV6_MULTIPLE_TABLES=y
@@ -101,7 +98,6 @@ CONFIG_BAYCOM_SER_HDX=m
 CONFIG_YAM=m
 CONFIG_FW_LOADER=m
 CONFIG_BLK_DEV_LOOP=m
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_EEPROM_LEGACY=y
 CONFIG_EEPROM_MAX6875=y
@@ -230,12 +226,8 @@ CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_VMAC=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_RMD128=m
 CONFIG_CRYPTO_RMD160=m
-CONFIG_CRYPTO_RMD256=m
-CONFIG_CRYPTO_RMD320=m
 CONFIG_CRYPTO_SHA512=m
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_BLOWFISH=m
@@ -243,7 +235,6 @@ CONFIG_CRYPTO_CAMELLIA=m
 CONFIG_CRYPTO_CAST6=m
 CONFIG_CRYPTO_FCRYPT=m
 CONFIG_CRYPTO_KHAZAD=m
-CONFIG_CRYPTO_SALSA20=m
 CONFIG_CRYPTO_SEED=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
diff --git a/arch/mips/configs/bmips_be_defconfig b/arch/mips/configs/bmips_be_defconfig
index 032bb51defe8..daef132d000b 100644
--- a/arch/mips/configs/bmips_be_defconfig
+++ b/arch/mips/configs/bmips_be_defconfig
@@ -17,9 +17,6 @@ CONFIG_PACKET=y
 CONFIG_PACKET_DIAG=y
 CONFIG_UNIX=y
 CONFIG_INET=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 CONFIG_CFG80211=y
 CONFIG_NL80211_TESTMODE=y
diff --git a/arch/mips/configs/bmips_stb_defconfig b/arch/mips/configs/bmips_stb_defconfig
index 5956fb95c19f..cd0dc37c3d84 100644
--- a/arch/mips/configs/bmips_stb_defconfig
+++ b/arch/mips/configs/bmips_stb_defconfig
@@ -12,7 +12,6 @@ CONFIG_HIGHMEM=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=4
-CONFIG_CC_STACKPROTECTOR_STRONG=y
 # CONFIG_SECCOMP is not set
 CONFIG_MIPS_O32_FP64_SUPPORT=y
 # CONFIG_RD_GZIP is not set
@@ -21,8 +20,6 @@ CONFIG_MIPS_O32_FP64_SUPPORT=y
 CONFIG_RD_XZ=y
 # CONFIG_RD_LZO is not set
 # CONFIG_RD_LZ4 is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
 CONFIG_PCIEASPM_POWERSAVE=y
@@ -30,7 +27,6 @@ CONFIG_PCIEPORTBUS=y
 CONFIG_PCIE_BRCMSTB=y
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_STAT=y
-CONFIG_CPU_FREQ_STAT_DETAILS=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
 CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
 CONFIG_CPU_FREQ_GOV_POWERSAVE=y
@@ -44,15 +40,11 @@ CONFIG_PACKET=y
 CONFIG_PACKET_DIAG=y
 CONFIG_UNIX=y
 CONFIG_INET=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 CONFIG_CFG80211=y
 CONFIG_NL80211_TESTMODE=y
 CONFIG_WIRELESS=y
 CONFIG_MAC80211=y
-CONFIG_NL80211=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_STANDALONE is not set
@@ -70,10 +62,6 @@ CONFIG_IP_PNP_RARP=y
 CONFIG_IP_MROUTE=y
 CONFIG_IP_PIMSM_V1=y
 CONFIG_IP_PIMSM_V2=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 CONFIG_INET_UDP_DIAG=y
 CONFIG_TCP_CONG_ADVANCED=y
 CONFIG_TCP_CONG_BIC=y
@@ -93,7 +81,6 @@ CONFIG_NET_SWITCHDEV=y
 CONFIG_DMA_CMA=y
 CONFIG_CMA_ALIGNMENT=12
 CONFIG_SPI=y
-CONFIG_SPI_BRCMSTB=y
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
@@ -105,14 +92,11 @@ CONFIG_MTD_CFI_STAA=y
 CONFIG_MTD_ROM=y
 CONFIG_MTD_ABSENT=y
 CONFIG_MTD_PHYSMAP_OF=y
-CONFIG_MTD_M25P80=y
-CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_BRCMNAND=y
 CONFIG_MTD_SPI_NOR=y
 # CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
 CONFIG_MTD_UBI=y
 CONFIG_MTD_UBI_GLUEBI=y
-CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=8192
@@ -120,7 +104,6 @@ CONFIG_BLK_DEV_RAM_SIZE=8192
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_SG=y
-CONFIG_SCSI_MULTI_LUN=y
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_NETDEVICES=y
 CONFIG_VLAN_8021Q=y
@@ -135,7 +118,6 @@ CONFIG_INPUT_UINPUT=y
 # CONFIG_SERIO is not set
 CONFIG_VT=y
 CONFIG_VT_HW_CONSOLE_BINDING=y
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_8250=y
 # CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
 CONFIG_SERIAL_8250_CONSOLE=y
@@ -203,17 +185,14 @@ CONFIG_CMDLINE="earlycon"
 CONFIG_MIPS_CMDLINE_DTB_EXTEND=y
 # CONFIG_MIPS_CMDLINE_FROM_BOOTLOADER is not set
 # CONFIG_CRYPTO_HW is not set
-CONFIG_DT_BCM974XX=y
 CONFIG_FW_CFE=y
 CONFIG_ATA=y
 CONFIG_SATA_AHCI_PLATFORM=y
-CONFIG_AHCI_BRCMSTB=y
 CONFIG_GENERIC_PHY=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_PHY_BRCM_USB=y
 CONFIG_PHY_BRCM_SATA=y
-CONFIG_PM_RUNTIME=y
 CONFIG_PM_DEBUG=y
 CONFIG_SYSVIPC=y
 CONFIG_FUNCTION_GRAPH_TRACER=y
@@ -227,3 +206,5 @@ CONFIG_FTRACE_SYSCALLS=y
 CONFIG_TRACER_SNAPSHOT=y
 CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
 CONFIG_STACK_TRACER=y
+CONFIG_AHCI_BRCM=y
+CONFIG_MTD_RAW_NAND=y
diff --git a/arch/mips/configs/cavium_octeon_defconfig b/arch/mips/configs/cavium_octeon_defconfig
index 7f021a327566..0bc2e3cc573b 100644
--- a/arch/mips/configs/cavium_octeon_defconfig
+++ b/arch/mips/configs/cavium_octeon_defconfig
@@ -71,7 +71,6 @@ CONFIG_NETDEVICES=y
 # CONFIG_NET_VENDOR_DEC is not set
 # CONFIG_NET_VENDOR_DLINK is not set
 # CONFIG_NET_VENDOR_EMULEX is not set
-# CONFIG_NET_VENDOR_HP is not set
 # CONFIG_NET_VENDOR_INTEL is not set
 # CONFIG_NET_VENDOR_MARVELL is not set
 # CONFIG_NET_VENDOR_MELLANOX is not set
diff --git a/arch/mips/configs/db1xxx_defconfig b/arch/mips/configs/db1xxx_defconfig
index 83cbdecb27e6..af070be1b583 100644
--- a/arch/mips/configs/db1xxx_defconfig
+++ b/arch/mips/configs/db1xxx_defconfig
@@ -60,7 +60,6 @@ CONFIG_INET6_AH=y
 CONFIG_INET6_ESP=y
 CONFIG_INET6_IPCOMP=y
 CONFIG_IPV6_MIP6=y
-CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=y
 CONFIG_IPV6_VTI=y
 CONFIG_IPV6_SIT_6RD=y
 CONFIG_IPV6_GRE=y
diff --git a/arch/mips/configs/decstation_64_defconfig b/arch/mips/configs/decstation_64_defconfig
index 4044f2829759..49ec1575234e 100644
--- a/arch/mips/configs/decstation_64_defconfig
+++ b/arch/mips/configs/decstation_64_defconfig
@@ -37,9 +37,6 @@ CONFIG_SYN_COOKIES=y
 CONFIG_INET_AH=m
 CONFIG_INET_ESP=m
 CONFIG_INET_IPCOMP=m
-CONFIG_INET_XFRM_MODE_TRANSPORT=m
-CONFIG_INET_XFRM_MODE_TUNNEL=m
-CONFIG_INET_XFRM_MODE_BEET=m
 CONFIG_TCP_MD5SIG=y
 CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_IPV6_ROUTE_INFO=y
@@ -47,7 +44,6 @@ CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
 CONFIG_INET6_IPCOMP=m
 CONFIG_IPV6_MIP6=m
-CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=m
 CONFIG_IPV6_MULTIPLE_TABLES=y
 CONFIG_IPV6_SUBTREES=y
 CONFIG_NETWORK_SECMARK=y
@@ -77,7 +73,6 @@ CONFIG_NETDEVICES=y
 CONFIG_DECLANCE=y
 # CONFIG_NET_VENDOR_AQUANTIA is not set
 # CONFIG_NET_VENDOR_ARC is not set
-# CONFIG_NET_VENDOR_AURORA is not set
 # CONFIG_NET_VENDOR_BROADCOM is not set
 # CONFIG_NET_VENDOR_CADENCE is not set
 # CONFIG_NET_VENDOR_CAVIUM is not set
@@ -191,12 +186,8 @@ CONFIG_CRYPTO_CRC32=m
 CONFIG_CRYPTO_CRCT10DIF=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_RMD128=m
 CONFIG_CRYPTO_RMD160=m
-CONFIG_CRYPTO_RMD256=m
-CONFIG_CRYPTO_RMD320=m
 CONFIG_CRYPTO_SHA512=m
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_ARC4=m
@@ -206,7 +197,6 @@ CONFIG_CRYPTO_CAST5=m
 CONFIG_CRYPTO_CAST6=m
 CONFIG_CRYPTO_FCRYPT=m
 CONFIG_CRYPTO_KHAZAD=m
-CONFIG_CRYPTO_SALSA20=m
 CONFIG_CRYPTO_SEED=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
diff --git a/arch/mips/configs/decstation_defconfig b/arch/mips/configs/decstation_defconfig
index 157fc57520a7..5cec4c096e2c 100644
--- a/arch/mips/configs/decstation_defconfig
+++ b/arch/mips/configs/decstation_defconfig
@@ -33,9 +33,6 @@ CONFIG_SYN_COOKIES=y
 CONFIG_INET_AH=m
 CONFIG_INET_ESP=m
 CONFIG_INET_IPCOMP=m
-CONFIG_INET_XFRM_MODE_TRANSPORT=m
-CONFIG_INET_XFRM_MODE_TUNNEL=m
-CONFIG_INET_XFRM_MODE_BEET=m
 CONFIG_TCP_MD5SIG=y
 CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_IPV6_ROUTE_INFO=y
@@ -43,7 +40,6 @@ CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
 CONFIG_INET6_IPCOMP=m
 CONFIG_IPV6_MIP6=m
-CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=m
 CONFIG_IPV6_MULTIPLE_TABLES=y
 CONFIG_IPV6_SUBTREES=y
 CONFIG_NETWORK_SECMARK=y
@@ -73,7 +69,6 @@ CONFIG_NETDEVICES=y
 CONFIG_DECLANCE=y
 # CONFIG_NET_VENDOR_AQUANTIA is not set
 # CONFIG_NET_VENDOR_ARC is not set
-# CONFIG_NET_VENDOR_AURORA is not set
 # CONFIG_NET_VENDOR_BROADCOM is not set
 # CONFIG_NET_VENDOR_CADENCE is not set
 # CONFIG_NET_VENDOR_CAVIUM is not set
@@ -186,12 +181,8 @@ CONFIG_CRYPTO_CRC32=m
 CONFIG_CRYPTO_CRCT10DIF=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_RMD128=m
 CONFIG_CRYPTO_RMD160=m
-CONFIG_CRYPTO_RMD256=m
-CONFIG_CRYPTO_RMD320=m
 CONFIG_CRYPTO_SHA512=m
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_ARC4=m
@@ -201,7 +192,6 @@ CONFIG_CRYPTO_CAST5=m
 CONFIG_CRYPTO_CAST6=m
 CONFIG_CRYPTO_FCRYPT=m
 CONFIG_CRYPTO_KHAZAD=m
-CONFIG_CRYPTO_SALSA20=m
 CONFIG_CRYPTO_SEED=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
diff --git a/arch/mips/configs/decstation_r4k_defconfig b/arch/mips/configs/decstation_r4k_defconfig
index f73c26ebfc83..af37e26d9b5b 100644
--- a/arch/mips/configs/decstation_r4k_defconfig
+++ b/arch/mips/configs/decstation_r4k_defconfig
@@ -32,9 +32,6 @@ CONFIG_SYN_COOKIES=y
 CONFIG_INET_AH=m
 CONFIG_INET_ESP=m
 CONFIG_INET_IPCOMP=m
-CONFIG_INET_XFRM_MODE_TRANSPORT=m
-CONFIG_INET_XFRM_MODE_TUNNEL=m
-CONFIG_INET_XFRM_MODE_BEET=m
 CONFIG_TCP_MD5SIG=y
 CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_IPV6_ROUTE_INFO=y
@@ -42,7 +39,6 @@ CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
 CONFIG_INET6_IPCOMP=m
 CONFIG_IPV6_MIP6=m
-CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=m
 CONFIG_IPV6_MULTIPLE_TABLES=y
 CONFIG_IPV6_SUBTREES=y
 CONFIG_NETWORK_SECMARK=y
@@ -72,7 +68,6 @@ CONFIG_NETDEVICES=y
 CONFIG_DECLANCE=y
 # CONFIG_NET_VENDOR_AQUANTIA is not set
 # CONFIG_NET_VENDOR_ARC is not set
-# CONFIG_NET_VENDOR_AURORA is not set
 # CONFIG_NET_VENDOR_BROADCOM is not set
 # CONFIG_NET_VENDOR_CADENCE is not set
 # CONFIG_NET_VENDOR_CAVIUM is not set
@@ -186,12 +181,8 @@ CONFIG_CRYPTO_CRC32=m
 CONFIG_CRYPTO_CRCT10DIF=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_RMD128=m
 CONFIG_CRYPTO_RMD160=m
-CONFIG_CRYPTO_RMD256=m
-CONFIG_CRYPTO_RMD320=m
 CONFIG_CRYPTO_SHA512=m
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_ARC4=m
@@ -201,7 +192,6 @@ CONFIG_CRYPTO_CAST5=m
 CONFIG_CRYPTO_CAST6=m
 CONFIG_CRYPTO_FCRYPT=m
 CONFIG_CRYPTO_KHAZAD=m
-CONFIG_CRYPTO_SALSA20=m
 CONFIG_CRYPTO_SEED=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
diff --git a/arch/mips/configs/fuloong2e_defconfig b/arch/mips/configs/fuloong2e_defconfig
index ba47c5e929b7..843d6a5a4f61 100644
--- a/arch/mips/configs/fuloong2e_defconfig
+++ b/arch/mips/configs/fuloong2e_defconfig
@@ -35,8 +35,6 @@ CONFIG_IP_MULTICAST=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_NET_IPIP=m
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 CONFIG_NETFILTER=y
@@ -92,7 +90,6 @@ CONFIG_MTD_CFI_AMDSTD=m
 CONFIG_MTD_CFI_STAA=m
 CONFIG_MTD_PHYSMAP=m
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_RAM=m
 CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
@@ -159,7 +156,6 @@ CONFIG_USB_MOUSE=y
 CONFIG_USB=y
 CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
 CONFIG_USB_OTG_PRODUCTLIST=y
-CONFIG_USB_WUSB_CBAF=m
 CONFIG_USB_C67X00_HCD=m
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_ROOT_HUB_TT=y
@@ -219,15 +215,10 @@ CONFIG_CRYPTO_CTS=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_XTS=m
 CONFIG_CRYPTO_HMAC=y
-CONFIG_CRYPTO_RMD128=m
 CONFIG_CRYPTO_RMD160=m
-CONFIG_CRYPTO_RMD256=m
-CONFIG_CRYPTO_RMD320=m
-CONFIG_CRYPTO_SALSA20=m
 CONFIG_CRYPTO_SEED=m
 CONFIG_CRYPTO_DEFLATE=m
 CONFIG_CRYPTO_LZO=m
 # CONFIG_CRYPTO_HW is not set
 CONFIG_CRC_CCITT=y
 CONFIG_CRC7=m
-# CONFIG_ENABLE_MUST_CHECK is not set
diff --git a/arch/mips/configs/generic/board-ocelot.config b/arch/mips/configs/generic/board-ocelot.config
index 510709565404..8cfbafa532e0 100644
--- a/arch/mips/configs/generic/board-ocelot.config
+++ b/arch/mips/configs/generic/board-ocelot.config
@@ -25,7 +25,6 @@ CONFIG_NETDEVICES=y
 CONFIG_NET_SWITCHDEV=y
 CONFIG_NET_DSA=y
 CONFIG_MSCC_OCELOT_SWITCH=y
-CONFIG_MSCC_OCELOT_SWITCH_OCELOT=y
 CONFIG_MDIO_MSCC_MIIM=y
 CONFIG_MICROSEMI_PHY=y
 
diff --git a/arch/mips/configs/gpr_defconfig b/arch/mips/configs/gpr_defconfig
index ce8a444957c1..eb755650f821 100644
--- a/arch/mips/configs/gpr_defconfig
+++ b/arch/mips/configs/gpr_defconfig
@@ -29,9 +29,6 @@ CONFIG_IP_ROUTE_VERBOSE=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_IPV6 is not set
 CONFIG_NETWORK_SECMARK=y
 CONFIG_NETFILTER=y
@@ -218,9 +215,6 @@ CONFIG_HDLC_X25=m
 CONFIG_PCI200SYN=m
 CONFIG_WANXL=m
 CONFIG_FARSYNC=m
-CONFIG_DSCC4=m
-CONFIG_DSCC4_PCISYNC=y
-CONFIG_DSCC4_PCI_RST=y
 CONFIG_LAPBETHER=m
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
@@ -286,7 +280,6 @@ CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_SHA512=m
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_BLOWFISH=m
@@ -297,7 +290,6 @@ CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_DEFLATE=m
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="console=ttyS0,115200 root=/dev/nfs rw ip=auto"
diff --git a/arch/mips/configs/ip22_defconfig b/arch/mips/configs/ip22_defconfig
index 70a4ba90f491..13df29901237 100644
--- a/arch/mips/configs/ip22_defconfig
+++ b/arch/mips/configs/ip22_defconfig
@@ -36,9 +36,6 @@ CONFIG_IP_PNP_BOOTP=y
 CONFIG_INET_AH=m
 CONFIG_INET_ESP=m
 CONFIG_INET_IPCOMP=m
-CONFIG_INET_XFRM_MODE_TRANSPORT=m
-CONFIG_INET_XFRM_MODE_TUNNEL=m
-CONFIG_INET_XFRM_MODE_BEET=m
 CONFIG_TCP_MD5SIG=y
 CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_IPV6_ROUTE_INFO=y
@@ -47,7 +44,6 @@ CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
 CONFIG_INET6_IPCOMP=m
 CONFIG_IPV6_MIP6=m
-CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=m
 CONFIG_IPV6_TUNNEL=m
 CONFIG_IPV6_MULTIPLE_TABLES=y
 CONFIG_IPV6_SUBTREES=y
@@ -226,7 +222,6 @@ CONFIG_SERIO_RAW=m
 CONFIG_VT_HW_CONSOLE_BINDING=y
 CONFIG_SERIAL_IP22_ZILOG=m
 # CONFIG_HW_RANDOM is not set
-CONFIG_RAW_DRIVER=m
 # CONFIG_HWMON is not set
 CONFIG_THERMAL=y
 CONFIG_WATCHDOG=y
@@ -320,11 +315,7 @@ CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_XTS=m
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_XCBC=m
-CONFIG_CRYPTO_RMD128=m
 CONFIG_CRYPTO_RMD160=m
-CONFIG_CRYPTO_RMD256=m
-CONFIG_CRYPTO_RMD320=m
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_BLOWFISH=m
@@ -333,7 +324,6 @@ CONFIG_CRYPTO_CAST5=m
 CONFIG_CRYPTO_CAST6=m
 CONFIG_CRYPTO_FCRYPT=m
 CONFIG_CRYPTO_KHAZAD=m
-CONFIG_CRYPTO_SALSA20=m
 CONFIG_CRYPTO_SEED=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
diff --git a/arch/mips/configs/ip27_defconfig b/arch/mips/configs/ip27_defconfig
index 821630ac1be7..3e86f8106ba0 100644
--- a/arch/mips/configs/ip27_defconfig
+++ b/arch/mips/configs/ip27_defconfig
@@ -33,9 +33,6 @@ CONFIG_NET_KEY_MIGRATE=y
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
 CONFIG_IP_PNP=y
-CONFIG_INET_XFRM_MODE_TRANSPORT=m
-CONFIG_INET_XFRM_MODE_TUNNEL=m
-CONFIG_INET_XFRM_MODE_BEET=m
 CONFIG_TCP_MD5SIG=y
 CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_IPV6_ROUTE_INFO=y
@@ -44,10 +41,6 @@ CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
 CONFIG_INET6_IPCOMP=m
 CONFIG_IPV6_MIP6=m
-CONFIG_INET6_XFRM_MODE_TRANSPORT=m
-CONFIG_INET6_XFRM_MODE_TUNNEL=m
-CONFIG_INET6_XFRM_MODE_BEET=m
-CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=m
 CONFIG_IPV6_SIT=m
 CONFIG_IPV6_SIT_6RD=y
 CONFIG_IPV6_TUNNEL=m
@@ -92,7 +85,6 @@ CONFIG_CFG80211=m
 CONFIG_MAC80211=m
 CONFIG_RFKILL=m
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_SCSI=y
@@ -115,7 +107,6 @@ CONFIG_SCSI_AIC94XX=m
 # CONFIG_AIC94XX_DEBUG is not set
 CONFIG_SCSI_MVSAS=m
 # CONFIG_SCSI_MVSAS_DEBUG is not set
-CONFIG_SCSI_DPT_I2O=m
 CONFIG_SCSI_MPT2SAS=m
 CONFIG_LIBFC=m
 CONFIG_SCSI_QLOGIC_1280=y
@@ -126,8 +117,6 @@ CONFIG_SCSI_DH_RDAC=m
 CONFIG_SCSI_DH_HP_SW=m
 CONFIG_SCSI_DH_EMC=m
 CONFIG_SCSI_DH_ALUA=m
-CONFIG_SCSI_OSD_INITIATOR=m
-CONFIG_SCSI_OSD_ULD=m
 CONFIG_MD=y
 CONFIG_BLK_DEV_MD=y
 CONFIG_MD_LINEAR=m
@@ -166,7 +155,6 @@ CONFIG_JME=m
 CONFIG_MLX4_EN=m
 # CONFIG_MLX4_DEBUG is not set
 CONFIG_KS8851_MLL=m
-CONFIG_VXGE=m
 CONFIG_AX88796=m
 CONFIG_AX88796_93CX6=y
 CONFIG_ETHOC=m
@@ -264,7 +252,6 @@ CONFIG_I2C_VIAPRO=m
 CONFIG_I2C_OCORES=m
 CONFIG_I2C_PCA_PLATFORM=m
 CONFIG_I2C_SIMTEC=m
-CONFIG_I2C_PARPORT_LIGHT=m
 CONFIG_I2C_TAOS_EVM=m
 CONFIG_I2C_STUB=m
 # CONFIG_HWMON is not set
@@ -309,7 +296,6 @@ CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_SQUASHFS=m
 CONFIG_OMFS_FS=m
-CONFIG_EXOFS_FS=m
 CONFIG_NFS_FS=y
 CONFIG_SECURITYFS=y
 CONFIG_CRYPTO_CRYPTD=m
@@ -321,12 +307,8 @@ CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_VMAC=m
 CONFIG_CRYPTO_MD4=m
-CONFIG_CRYPTO_RMD128=m
 CONFIG_CRYPTO_RMD160=m
-CONFIG_CRYPTO_RMD256=m
-CONFIG_CRYPTO_RMD320=m
 CONFIG_CRYPTO_SHA512=m
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_BLOWFISH=m
@@ -335,7 +317,6 @@ CONFIG_CRYPTO_CAST5=m
 CONFIG_CRYPTO_CAST6=m
 CONFIG_CRYPTO_FCRYPT=m
 CONFIG_CRYPTO_KHAZAD=m
-CONFIG_CRYPTO_SALSA20=m
 CONFIG_CRYPTO_SEED=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
diff --git a/arch/mips/configs/ip28_defconfig b/arch/mips/configs/ip28_defconfig
index 0921ef38e9fb..ba13eea0509f 100644
--- a/arch/mips/configs/ip28_defconfig
+++ b/arch/mips/configs/ip28_defconfig
@@ -29,9 +29,6 @@ CONFIG_IP_MULTICAST=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 CONFIG_TCP_MD5SIG=y
 # CONFIG_IPV6 is not set
 CONFIG_SCSI=y
diff --git a/arch/mips/configs/ip32_defconfig b/arch/mips/configs/ip32_defconfig
index 74020aa3440b..8ced2224c328 100644
--- a/arch/mips/configs/ip32_defconfig
+++ b/arch/mips/configs/ip32_defconfig
@@ -43,7 +43,6 @@ CONFIG_IPV6_TUNNEL=m
 CONFIG_NETWORK_SECMARK=y
 CONFIG_CONNECTOR=y
 CONFIG_BLK_DEV_LOOP=m
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_RAID_ATTRS=y
 CONFIG_SCSI=y
@@ -165,7 +164,6 @@ CONFIG_CRYPTO_MICHAEL_MIC=y
 CONFIG_CRYPTO_SHA1=y
 CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_SHA512=y
-CONFIG_CRYPTO_TGR192=y
 CONFIG_CRYPTO_WP512=y
 CONFIG_CRYPTO_ANUBIS=y
 CONFIG_CRYPTO_ARC4=y
diff --git a/arch/mips/configs/jazz_defconfig b/arch/mips/configs/jazz_defconfig
index 843f360da5f2..106b21cb677f 100644
--- a/arch/mips/configs/jazz_defconfig
+++ b/arch/mips/configs/jazz_defconfig
@@ -32,7 +32,6 @@ CONFIG_PARPORT_1284=y
 CONFIG_DEVTMPFS=y
 CONFIG_BLK_DEV_FD=m
 CONFIG_BLK_DEV_LOOP=m
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=m
 CONFIG_CDROM_PKTCDVD=m
diff --git a/arch/mips/configs/lemote2f_defconfig b/arch/mips/configs/lemote2f_defconfig
index 791894c4d8fb..7e598d338979 100644
--- a/arch/mips/configs/lemote2f_defconfig
+++ b/arch/mips/configs/lemote2f_defconfig
@@ -43,9 +43,6 @@ CONFIG_IP_MROUTE=y
 CONFIG_IP_PIMSM_V1=y
 CONFIG_IP_PIMSM_V2=y
 CONFIG_SYN_COOKIES=y
-CONFIG_INET_XFRM_MODE_TRANSPORT=m
-CONFIG_INET_XFRM_MODE_TUNNEL=m
-CONFIG_INET_XFRM_MODE_BEET=m
 CONFIG_TCP_CONG_ADVANCED=y
 CONFIG_TCP_CONG_BIC=y
 CONFIG_DEFAULT_BIC=y
@@ -77,7 +74,6 @@ CONFIG_MAC80211_LEDS=y
 CONFIG_RFKILL=m
 CONFIG_RFKILL_INPUT=y
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=8192
 CONFIG_BLK_DEV_SD=y
@@ -312,12 +308,8 @@ CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_XTS=m
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_RMD128=m
 CONFIG_CRYPTO_RMD160=m
-CONFIG_CRYPTO_RMD256=m
-CONFIG_CRYPTO_RMD320=m
 CONFIG_CRYPTO_SHA1=m
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_BLOWFISH=m
@@ -326,7 +318,6 @@ CONFIG_CRYPTO_CAST5=m
 CONFIG_CRYPTO_CAST6=m
 CONFIG_CRYPTO_FCRYPT=m
 CONFIG_CRYPTO_KHAZAD=m
-CONFIG_CRYPTO_SALSA20=m
 CONFIG_CRYPTO_SEED=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
diff --git a/arch/mips/configs/loongson1b_defconfig b/arch/mips/configs/loongson1b_defconfig
index 25e70423e17d..68207b31dc20 100644
--- a/arch/mips/configs/loongson1b_defconfig
+++ b/arch/mips/configs/loongson1b_defconfig
@@ -28,9 +28,6 @@ CONFIG_INET=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 # CONFIG_WIRELESS is not set
@@ -115,7 +112,6 @@ CONFIG_NLS_ISO8859_1=m
 # CONFIG_CRYPTO_ECHAINIV is not set
 # CONFIG_CRYPTO_HW is not set
 CONFIG_DYNAMIC_DEBUG=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHED_DEBUG is not set
diff --git a/arch/mips/configs/loongson1c_defconfig b/arch/mips/configs/loongson1c_defconfig
index 3a158d4d2fab..c3910a9dee9e 100644
--- a/arch/mips/configs/loongson1c_defconfig
+++ b/arch/mips/configs/loongson1c_defconfig
@@ -29,9 +29,6 @@ CONFIG_INET=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 # CONFIG_WIRELESS is not set
@@ -116,7 +113,6 @@ CONFIG_NLS_ISO8859_1=m
 # CONFIG_CRYPTO_ECHAINIV is not set
 # CONFIG_CRYPTO_HW is not set
 CONFIG_DYNAMIC_DEBUG=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHED_DEBUG is not set
diff --git a/arch/mips/configs/loongson2k_defconfig b/arch/mips/configs/loongson2k_defconfig
index e948ca487e2d..728bef666f7a 100644
--- a/arch/mips/configs/loongson2k_defconfig
+++ b/arch/mips/configs/loongson2k_defconfig
@@ -95,7 +95,6 @@ CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=m
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_CRYPTOLOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=8192
 CONFIG_RAID_ATTRS=m
@@ -229,7 +228,6 @@ CONFIG_SERIAL_8250_RSA=y
 CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_HW_RANDOM=y
-CONFIG_RAW_DRIVER=m
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_PIIX4=y
 CONFIG_GPIO_LOONGSON=y
@@ -336,7 +334,6 @@ CONFIG_DEFAULT_SECURITY_DAC=y
 CONFIG_CRYPTO_SEQIV=m
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_MD5=y
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_CAST5=m
diff --git a/arch/mips/configs/loongson3_defconfig b/arch/mips/configs/loongson3_defconfig
index 25ecd15bc952..aca66a5f330d 100644
--- a/arch/mips/configs/loongson3_defconfig
+++ b/arch/mips/configs/loongson3_defconfig
@@ -143,7 +143,6 @@ CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=m
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_CRYPTOLOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=8192
 CONFIG_VIRTIO_BLK=y
@@ -268,7 +267,6 @@ CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM=y
-CONFIG_RAW_DRIVER=m
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_PIIX4=y
 CONFIG_GPIO_LOONGSON=y
diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
index 7a5bdd236a2a..265d38dffbf6 100644
--- a/arch/mips/configs/malta_defconfig
+++ b/arch/mips/configs/malta_defconfig
@@ -42,8 +42,6 @@ CONFIG_SYN_COOKIES=y
 CONFIG_INET_AH=m
 CONFIG_INET_ESP=m
 CONFIG_INET_IPCOMP=m
-CONFIG_INET_XFRM_MODE_TRANSPORT=m
-CONFIG_INET_XFRM_MODE_TUNNEL=m
 CONFIG_TCP_MD5SIG=y
 CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_IPV6_ROUTE_INFO=y
@@ -229,7 +227,6 @@ CONFIG_MTD_UBI=m
 CONFIG_MTD_UBI_GLUEBI=m
 CONFIG_BLK_DEV_FD=m
 CONFIG_BLK_DEV_LOOP=m
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_CDROM_PKTCDVD=m
@@ -237,7 +234,6 @@ CONFIG_ATA_OVER_ETH=m
 CONFIG_RAID_ATTRS=m
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=m
-CONFIG_CHR_DEV_OSST=m
 CONFIG_BLK_DEV_SR=y
 CONFIG_CHR_DEV_SG=m
 CONFIG_SCSI_CONSTANTS=y
@@ -408,7 +404,6 @@ CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_SHA512=m
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_BLOWFISH=m
diff --git a/arch/mips/configs/malta_kvm_defconfig b/arch/mips/configs/malta_kvm_defconfig
index b5ba08d7ab57..1d2b248c7cd3 100644
--- a/arch/mips/configs/malta_kvm_defconfig
+++ b/arch/mips/configs/malta_kvm_defconfig
@@ -46,8 +46,6 @@ CONFIG_SYN_COOKIES=y
 CONFIG_INET_AH=m
 CONFIG_INET_ESP=m
 CONFIG_INET_IPCOMP=m
-CONFIG_INET_XFRM_MODE_TRANSPORT=m
-CONFIG_INET_XFRM_MODE_TUNNEL=m
 CONFIG_TCP_MD5SIG=y
 CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_IPV6_ROUTE_INFO=y
@@ -233,7 +231,6 @@ CONFIG_MTD_UBI=m
 CONFIG_MTD_UBI_GLUEBI=m
 CONFIG_BLK_DEV_FD=m
 CONFIG_BLK_DEV_LOOP=m
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_CDROM_PKTCDVD=m
@@ -241,7 +238,6 @@ CONFIG_ATA_OVER_ETH=m
 CONFIG_RAID_ATTRS=m
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=m
-CONFIG_CHR_DEV_OSST=m
 CONFIG_BLK_DEV_SR=y
 CONFIG_CHR_DEV_SG=m
 CONFIG_SCSI_CONSTANTS=y
@@ -415,7 +411,6 @@ CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_SHA512=m
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_BLOWFISH=m
diff --git a/arch/mips/configs/malta_qemu_32r6_defconfig b/arch/mips/configs/malta_qemu_32r6_defconfig
index 6fb9bc29f4a0..fd63a2b152f6 100644
--- a/arch/mips/configs/malta_qemu_32r6_defconfig
+++ b/arch/mips/configs/malta_qemu_32r6_defconfig
@@ -76,7 +76,6 @@ CONFIG_NET_ACT_POLICE=y
 # CONFIG_WIRELESS is not set
 CONFIG_DEVTMPFS=y
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_SG=y
 # CONFIG_SCSI_LOWLEVEL is not set
@@ -98,7 +97,6 @@ CONFIG_PCNET32=y
 # CONFIG_NET_VENDOR_DEC is not set
 # CONFIG_NET_VENDOR_DLINK is not set
 # CONFIG_NET_VENDOR_EMULEX is not set
-# CONFIG_NET_VENDOR_HP is not set
 # CONFIG_NET_VENDOR_INTEL is not set
 # CONFIG_NET_VENDOR_MARVELL is not set
 # CONFIG_NET_VENDOR_MELLANOX is not set
@@ -172,7 +170,6 @@ CONFIG_NLS_ISO8859_1=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_BLOWFISH=m
diff --git a/arch/mips/configs/maltaaprp_defconfig b/arch/mips/configs/maltaaprp_defconfig
index eb72df528243..1f07e354c954 100644
--- a/arch/mips/configs/maltaaprp_defconfig
+++ b/arch/mips/configs/maltaaprp_defconfig
@@ -78,7 +78,6 @@ CONFIG_NET_ACT_POLICE=y
 # CONFIG_WIRELESS is not set
 CONFIG_DEVTMPFS=y
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_SG=y
 # CONFIG_SCSI_LOWLEVEL is not set
@@ -100,7 +99,6 @@ CONFIG_PCNET32=y
 # CONFIG_NET_VENDOR_DEC is not set
 # CONFIG_NET_VENDOR_DLINK is not set
 # CONFIG_NET_VENDOR_EMULEX is not set
-# CONFIG_NET_VENDOR_HP is not set
 # CONFIG_NET_VENDOR_INTEL is not set
 # CONFIG_NET_VENDOR_MARVELL is not set
 # CONFIG_NET_VENDOR_MELLANOX is not set
@@ -173,7 +171,6 @@ CONFIG_NLS_ISO8859_1=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_BLOWFISH=m
diff --git a/arch/mips/configs/maltasmvp_defconfig b/arch/mips/configs/maltasmvp_defconfig
index 1fb40d310f49..5cd3eca236de 100644
--- a/arch/mips/configs/maltasmvp_defconfig
+++ b/arch/mips/configs/maltasmvp_defconfig
@@ -79,7 +79,6 @@ CONFIG_NET_ACT_POLICE=y
 # CONFIG_WIRELESS is not set
 CONFIG_DEVTMPFS=y
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_SG=y
 # CONFIG_SCSI_LOWLEVEL is not set
@@ -99,7 +98,6 @@ CONFIG_PCNET32=y
 # CONFIG_NET_VENDOR_DEC is not set
 # CONFIG_NET_VENDOR_DLINK is not set
 # CONFIG_NET_VENDOR_EMULEX is not set
-# CONFIG_NET_VENDOR_HP is not set
 # CONFIG_NET_VENDOR_INTEL is not set
 # CONFIG_NET_VENDOR_MARVELL is not set
 # CONFIG_NET_VENDOR_MELLANOX is not set
@@ -174,7 +172,6 @@ CONFIG_NLS_ISO8859_1=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_BLOWFISH=m
diff --git a/arch/mips/configs/maltasmvp_eva_defconfig b/arch/mips/configs/maltasmvp_eva_defconfig
index 75cb778c6149..45688e742a15 100644
--- a/arch/mips/configs/maltasmvp_eva_defconfig
+++ b/arch/mips/configs/maltasmvp_eva_defconfig
@@ -80,7 +80,6 @@ CONFIG_NET_ACT_POLICE=y
 # CONFIG_WIRELESS is not set
 CONFIG_DEVTMPFS=y
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_SG=y
 # CONFIG_SCSI_LOWLEVEL is not set
@@ -102,7 +101,6 @@ CONFIG_PCNET32=y
 # CONFIG_NET_VENDOR_DEC is not set
 # CONFIG_NET_VENDOR_DLINK is not set
 # CONFIG_NET_VENDOR_EMULEX is not set
-# CONFIG_NET_VENDOR_HP is not set
 # CONFIG_NET_VENDOR_INTEL is not set
 # CONFIG_NET_VENDOR_MARVELL is not set
 # CONFIG_NET_VENDOR_MELLANOX is not set
@@ -176,7 +174,6 @@ CONFIG_NLS_ISO8859_1=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_BLOWFISH=m
diff --git a/arch/mips/configs/maltaup_defconfig b/arch/mips/configs/maltaup_defconfig
index 7b4f247dc60c..136f965784db 100644
--- a/arch/mips/configs/maltaup_defconfig
+++ b/arch/mips/configs/maltaup_defconfig
@@ -77,7 +77,6 @@ CONFIG_NET_ACT_POLICE=y
 # CONFIG_WIRELESS is not set
 CONFIG_DEVTMPFS=y
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_SG=y
 # CONFIG_SCSI_LOWLEVEL is not set
@@ -99,7 +98,6 @@ CONFIG_PCNET32=y
 # CONFIG_NET_VENDOR_DEC is not set
 # CONFIG_NET_VENDOR_DLINK is not set
 # CONFIG_NET_VENDOR_EMULEX is not set
-# CONFIG_NET_VENDOR_HP is not set
 # CONFIG_NET_VENDOR_INTEL is not set
 # CONFIG_NET_VENDOR_MARVELL is not set
 # CONFIG_NET_VENDOR_MELLANOX is not set
@@ -172,7 +170,6 @@ CONFIG_NLS_ISO8859_1=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_BLOWFISH=m
diff --git a/arch/mips/configs/maltaup_xpa_defconfig b/arch/mips/configs/maltaup_xpa_defconfig
index 8d58653f1b4e..75b8da8d9927 100644
--- a/arch/mips/configs/maltaup_xpa_defconfig
+++ b/arch/mips/configs/maltaup_xpa_defconfig
@@ -45,8 +45,6 @@ CONFIG_SYN_COOKIES=y
 CONFIG_INET_AH=m
 CONFIG_INET_ESP=m
 CONFIG_INET_IPCOMP=m
-CONFIG_INET_XFRM_MODE_TRANSPORT=m
-CONFIG_INET_XFRM_MODE_TUNNEL=m
 CONFIG_TCP_MD5SIG=y
 CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_IPV6_ROUTE_INFO=y
@@ -231,7 +229,6 @@ CONFIG_MTD_UBI=m
 CONFIG_MTD_UBI_GLUEBI=m
 CONFIG_BLK_DEV_FD=m
 CONFIG_BLK_DEV_LOOP=m
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_CDROM_PKTCDVD=m
@@ -239,7 +236,6 @@ CONFIG_ATA_OVER_ETH=m
 CONFIG_RAID_ATTRS=m
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=m
-CONFIG_CHR_DEV_OSST=m
 CONFIG_BLK_DEV_SR=y
 CONFIG_CHR_DEV_SG=m
 CONFIG_SCSI_CONSTANTS=y
@@ -414,7 +410,6 @@ CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_SHA512=m
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_BLOWFISH=m
diff --git a/arch/mips/configs/mtx1_defconfig b/arch/mips/configs/mtx1_defconfig
index 1339c062a042..edf9634aa8ee 100644
--- a/arch/mips/configs/mtx1_defconfig
+++ b/arch/mips/configs/mtx1_defconfig
@@ -58,13 +58,9 @@ CONFIG_SYN_COOKIES=y
 CONFIG_INET_AH=m
 CONFIG_INET_ESP=m
 CONFIG_INET_IPCOMP=m
-CONFIG_INET_XFRM_MODE_TRANSPORT=m
-CONFIG_INET_XFRM_MODE_TUNNEL=m
-CONFIG_INET_XFRM_MODE_BEET=m
 CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
 CONFIG_INET6_IPCOMP=m
-CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=m
 CONFIG_IPV6_TUNNEL=m
 CONFIG_NETWORK_SECMARK=y
 CONFIG_NETFILTER=y
@@ -282,7 +278,6 @@ CONFIG_PCMCIA_XIRCOM=m
 CONFIG_DL2K=m
 CONFIG_SUNDANCE=m
 CONFIG_PCMCIA_FMVJ18X=m
-CONFIG_HP100=m
 CONFIG_E100=m
 CONFIG_E1000=m
 CONFIG_IXGB=m
@@ -366,9 +361,6 @@ CONFIG_HDLC_X25=m
 CONFIG_PCI200SYN=m
 CONFIG_WANXL=m
 CONFIG_FARSYNC=m
-CONFIG_DSCC4=m
-CONFIG_DSCC4_PCISYNC=y
-CONFIG_DSCC4_PCI_RST=y
 CONFIG_LAPBETHER=m
 # CONFIG_KEYBOARD_ATKBD is not set
 CONFIG_KEYBOARD_GPIO=y
@@ -681,7 +673,6 @@ CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_BLOWFISH=m
@@ -690,5 +681,4 @@ CONFIG_CRYPTO_KHAZAD=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_MAGIC_SYSRQ=y
diff --git a/arch/mips/configs/omega2p_defconfig b/arch/mips/configs/omega2p_defconfig
index 6a5cb2d6de6b..91fe2822f897 100644
--- a/arch/mips/configs/omega2p_defconfig
+++ b/arch/mips/configs/omega2p_defconfig
@@ -35,9 +35,6 @@ CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 # CONFIG_WIRELESS is not set
diff --git a/arch/mips/configs/pic32mzda_defconfig b/arch/mips/configs/pic32mzda_defconfig
index fd567247adc7..48dd02d01ac1 100644
--- a/arch/mips/configs/pic32mzda_defconfig
+++ b/arch/mips/configs/pic32mzda_defconfig
@@ -45,7 +45,6 @@ CONFIG_KEYBOARD_GPIO_POLLED=m
 CONFIG_SERIAL_PIC32=y
 CONFIG_SERIAL_PIC32_CONSOLE=y
 CONFIG_HW_RANDOM=y
-CONFIG_RAW_DRIVER=m
 CONFIG_GPIO_SYSFS=y
 # CONFIG_HWMON is not set
 CONFIG_HIDRAW=y
diff --git a/arch/mips/configs/rb532_defconfig b/arch/mips/configs/rb532_defconfig
index 252d472387aa..93306f5e045b 100644
--- a/arch/mips/configs/rb532_defconfig
+++ b/arch/mips/configs/rb532_defconfig
@@ -33,9 +33,6 @@ CONFIG_IP_MULTIPLE_TABLES=y
 CONFIG_IP_ROUTE_MULTIPATH=y
 CONFIG_IP_ROUTE_VERBOSE=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 CONFIG_INET_DIAG=m
 CONFIG_TCP_CONG_ADVANCED=y
 CONFIG_TCP_CONG_CUBIC=m
@@ -162,5 +159,4 @@ CONFIG_SQUASHFS=y
 CONFIG_CRYPTO_TEST=m
 # CONFIG_CRYPTO_HW is not set
 CONFIG_CRC16=m
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_STRIP_ASM_SYMS=y
diff --git a/arch/mips/configs/rbtx49xx_defconfig b/arch/mips/configs/rbtx49xx_defconfig
index f8212a813be7..30c195f28278 100644
--- a/arch/mips/configs/rbtx49xx_defconfig
+++ b/arch/mips/configs/rbtx49xx_defconfig
@@ -21,9 +21,6 @@ CONFIG_UNIX=y
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
 CONFIG_IP_PNP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_IPV6 is not set
 # CONFIG_WIRELESS is not set
 CONFIG_MTD=y
@@ -51,7 +48,6 @@ CONFIG_TC35815=y
 CONFIG_SERIAL_TXX9_CONSOLE=y
 CONFIG_SERIAL_TXX9_STDSERIAL=y
 CONFIG_SPI=y
-CONFIG_SPI_TXX9=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
 CONFIG_TXX9_WDT=m
@@ -65,8 +61,6 @@ CONFIG_SND=m
 # CONFIG_SND_SPI is not set
 # CONFIG_SND_MIPS is not set
 CONFIG_SND_SOC=m
-CONFIG_SND_SOC_TXX9ACLC=m
-CONFIG_SND_SOC_TXX9ACLC_GENERIC=m
 # CONFIG_USB_SUPPORT is not set
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
@@ -78,7 +72,6 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_INTF_DEV_UIE_EMUL=y
 CONFIG_RTC_DRV_RS5C348=y
 CONFIG_RTC_DRV_DS1742=y
-CONFIG_RTC_DRV_TX4939=y
 CONFIG_DMADEVICES=y
 CONFIG_TXX9_DMAC=m
 # CONFIG_DNOTIFY is not set
diff --git a/arch/mips/configs/rm200_defconfig b/arch/mips/configs/rm200_defconfig
index 04c681bd716e..9932a593e3c3 100644
--- a/arch/mips/configs/rm200_defconfig
+++ b/arch/mips/configs/rm200_defconfig
@@ -29,9 +29,6 @@ CONFIG_NET_IPIP=m
 CONFIG_IP_MROUTE=y
 CONFIG_IP_PIMSM_V1=y
 CONFIG_IP_PIMSM_V2=y
-CONFIG_INET_XFRM_MODE_TRANSPORT=m
-CONFIG_INET_XFRM_MODE_TUNNEL=m
-CONFIG_INET_XFRM_MODE_BEET=m
 CONFIG_TCP_MD5SIG=y
 CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_IPV6_ROUTE_INFO=y
@@ -39,7 +36,6 @@ CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
 CONFIG_INET6_IPCOMP=m
 CONFIG_IPV6_MIP6=m
-CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=m
 CONFIG_IPV6_TUNNEL=m
 CONFIG_IPV6_MULTIPLE_TABLES=y
 CONFIG_IPV6_SUBTREES=y
@@ -190,9 +186,7 @@ CONFIG_PARIDE_KTTI=m
 CONFIG_PARIDE_ON20=m
 CONFIG_PARIDE_ON26=m
 CONFIG_BLK_DEV_LOOP=m
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
-CONFIG_BLK_DEV_SX8=m
 CONFIG_BLK_DEV_RAM=m
 CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
@@ -398,7 +392,6 @@ CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_BLOWFISH=m
diff --git a/arch/mips/configs/rt305x_defconfig b/arch/mips/configs/rt305x_defconfig
index eb359db15dba..bf017d493002 100644
--- a/arch/mips/configs/rt305x_defconfig
+++ b/arch/mips/configs/rt305x_defconfig
@@ -35,9 +35,6 @@ CONFIG_IP_ROUTE_VERBOSE=y
 CONFIG_IP_MROUTE=y
 CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 CONFIG_TCP_CONG_ADVANCED=y
 # CONFIG_TCP_CONG_BIC is not set
@@ -140,7 +137,6 @@ CONFIG_CRC32_SARWATE=y
 # CONFIG_XZ_DEC_ARMTHUMB is not set
 # CONFIG_XZ_DEC_SPARC is not set
 CONFIG_PRINTK_TIME=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
diff --git a/arch/mips/configs/sb1250_swarm_defconfig b/arch/mips/configs/sb1250_swarm_defconfig
index de94bf756a93..030186f89501 100644
--- a/arch/mips/configs/sb1250_swarm_defconfig
+++ b/arch/mips/configs/sb1250_swarm_defconfig
@@ -88,7 +88,6 @@ CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_SHA512=m
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_CAMELLIA=m
@@ -96,7 +95,6 @@ CONFIG_CRYPTO_CAST5=m
 CONFIG_CRYPTO_CAST6=m
 CONFIG_CRYPTO_DES=m
 CONFIG_CRYPTO_FCRYPT=m
-CONFIG_CRYPTO_SALSA20=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_DEFLATE=m
diff --git a/arch/mips/configs/vocore2_defconfig b/arch/mips/configs/vocore2_defconfig
index 302cab9bd7bd..e47d4cc3353b 100644
--- a/arch/mips/configs/vocore2_defconfig
+++ b/arch/mips/configs/vocore2_defconfig
@@ -35,9 +35,6 @@ CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 # CONFIG_WIRELESS is not set
diff --git a/arch/mips/configs/xway_defconfig b/arch/mips/configs/xway_defconfig
index eeb689f715cb..eb5acf1f24ae 100644
--- a/arch/mips/configs/xway_defconfig
+++ b/arch/mips/configs/xway_defconfig
@@ -37,9 +37,6 @@ CONFIG_IP_ROUTE_VERBOSE=y
 CONFIG_IP_MROUTE=y
 CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 CONFIG_TCP_CONG_ADVANCED=y
 # CONFIG_TCP_CONG_BIC is not set
@@ -146,7 +143,6 @@ CONFIG_CRYPTO_ARC4=m
 CONFIG_CRC_ITU_T=m
 CONFIG_CRC32_SARWATE=y
 CONFIG_PRINTK_TIME=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
-- 
2.17.1

