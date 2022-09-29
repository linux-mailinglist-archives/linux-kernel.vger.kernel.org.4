Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DAD5EF323
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbiI2KOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235253AbiI2KOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:14:36 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F024149D22;
        Thu, 29 Sep 2022 03:14:30 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r6so1397140wru.8;
        Thu, 29 Sep 2022 03:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ykrnpuTEGllYEKTmGrNX9+HIF9vIBHuy8P5QqnXpQnk=;
        b=Y6Z9r5+4cL4qCkzJ1q45Su+Or7/MFGhUlA0RYLv4Zn7nwe2eXIkKJJ3MFxpFAFpr9X
         1SWIPATSMRTUBLicrIaN3Mt3plnsdF0T3/Wl8GXRt9JLxrQtwh1VE8WWLYOHLXxBd+Fg
         H1601aDfLCXbrTBSKRhTkndy8iStzEj3AcEylV1rYlkuMejTazWuYfKhAtKQrpTbaFpU
         UCsmqMFfMJoIGEiG8VUUJNknr/W/GMeBOhY1nXp/WutuVMP6+WBSuGoaBlaskRM6v2pa
         4SPxUpZc+wUzDV00lyvs2Kkwfq60xGEw2mWbXo6wXrl0woSF6LUnTvpbMnmosZNwplbd
         9izQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ykrnpuTEGllYEKTmGrNX9+HIF9vIBHuy8P5QqnXpQnk=;
        b=eOk2BkgvP9ibAZLe3dY7gm8PajUuPBWlGB0C5o1u5STJ9r/Jid2xyC0/OD8y/5Axb1
         qUIaBttsUkzRNxBVupRYRSrKmNK/fK0YY0qHy88815VaJ5oizxKrWhiOaGbLa3Y33cv/
         85R+C/AzgslNczY1SWNAbdW1Khx17UfN8joHPlcBynXkv+zE8ZmhhJUvFIwTKlUbtnTn
         if+8/PXf7soROigeZIgY4cs0Z6wxCBOSCPgtHe4lfskt/Qsr6grW1m7S9a3tcZVExsml
         vb3J6ft9G1dY47ss+AI4Csb1fUS74BlBqfq49JohjZU0SfC6gmTyIB+TAY1fG0G4WJZZ
         2EBA==
X-Gm-Message-State: ACrzQf07o8XH850DCQqFom8UTFFLDdnJgL2XnwHS7h8R8VvZAY6SzWPV
        C43lzgLVKCtDYtV5lK0bakCN0V6XQfc=
X-Google-Smtp-Source: AMsMyM6dHzKBCbeL8s6QCcGUPZeeePXhY4nB6PwkRFWUcxJ3Q+aO+KI6VmZl7bmkmNYzL+BBaensUA==
X-Received: by 2002:a5d:6d4e:0:b0:22c:9dfd:4159 with SMTP id k14-20020a5d6d4e000000b0022c9dfd4159mr1564699wri.307.1664446468582;
        Thu, 29 Sep 2022 03:14:28 -0700 (PDT)
Received: from felia.fritz.box (200116b826e11200b190ebfd45660ea6.dip.versatel-1u1.de. [2001:16b8:26e1:1200:b190:ebfd:4566:ea6])
        by smtp.gmail.com with ESMTPSA id d3-20020a05600c3ac300b003a844885f88sm3856721wms.22.2022.09.29.03.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 03:14:28 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Gupta <vgupta@kernel.org>,
        linux-snps-arc@lists.infradead.org
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] arc: update config files
Date:   Thu, 29 Sep 2022 12:14:21 +0200
Message-Id: <20220929101421.31590-1-lukas.bulwahn@gmail.com>
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
 arch/arc/configs/axs101_defconfig          | 4 ----
 arch/arc/configs/axs103_defconfig          | 4 ----
 arch/arc/configs/axs103_smp_defconfig      | 4 ----
 arch/arc/configs/haps_hs_defconfig         | 1 -
 arch/arc/configs/haps_hs_smp_defconfig     | 1 -
 arch/arc/configs/hsdk_defconfig            | 1 -
 arch/arc/configs/nsim_700_defconfig        | 1 -
 arch/arc/configs/nsimosci_defconfig        | 1 -
 arch/arc/configs/nsimosci_hs_defconfig     | 1 -
 arch/arc/configs/nsimosci_hs_smp_defconfig | 6 +-----
 arch/arc/configs/tb10x_defconfig           | 7 +------
 arch/arc/configs/vdk_hs38_defconfig        | 3 ---
 arch/arc/configs/vdk_hs38_smp_defconfig    | 1 -
 13 files changed, 2 insertions(+), 33 deletions(-)

diff --git a/arch/arc/configs/axs101_defconfig b/arch/arc/configs/axs101_defconfig
index e31a8ebc3ecc..81764160451f 100644
--- a/arch/arc/configs/axs101_defconfig
+++ b/arch/arc/configs/axs101_defconfig
@@ -35,9 +35,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_IP_PNP_RARP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_IPV6 is not set
 CONFIG_DEVTMPFS=y
 # CONFIG_STANDALONE is not set
@@ -99,7 +96,6 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_SOFTLOCKUP_DETECTOR=y
 CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=10
diff --git a/arch/arc/configs/axs103_defconfig b/arch/arc/configs/axs103_defconfig
index e0e8567f0d75..d5181275490e 100644
--- a/arch/arc/configs/axs103_defconfig
+++ b/arch/arc/configs/axs103_defconfig
@@ -34,9 +34,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_IP_PNP_RARP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_IPV6 is not set
 CONFIG_DEVTMPFS=y
 # CONFIG_STANDALONE is not set
@@ -97,7 +94,6 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_SOFTLOCKUP_DETECTOR=y
 CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=10
diff --git a/arch/arc/configs/axs103_smp_defconfig b/arch/arc/configs/axs103_smp_defconfig
index fcbc952bc75b..2f336d99a8cf 100644
--- a/arch/arc/configs/axs103_smp_defconfig
+++ b/arch/arc/configs/axs103_smp_defconfig
@@ -35,9 +35,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_IP_PNP_RARP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_IPV6 is not set
 CONFIG_DEVTMPFS=y
 # CONFIG_STANDALONE is not set
@@ -100,7 +97,6 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_SOFTLOCKUP_DETECTOR=y
 CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=10
diff --git a/arch/arc/configs/haps_hs_defconfig b/arch/arc/configs/haps_hs_defconfig
index d87ad7e88d62..899b2fd5c71d 100644
--- a/arch/arc/configs/haps_hs_defconfig
+++ b/arch/arc/configs/haps_hs_defconfig
@@ -59,6 +59,5 @@ CONFIG_EXT2_FS_XATTR=y
 CONFIG_TMPFS=y
 # CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_NFS_FS=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_MEMORY_INIT=y
 # CONFIG_DEBUG_PREEMPT is not set
diff --git a/arch/arc/configs/haps_hs_smp_defconfig b/arch/arc/configs/haps_hs_smp_defconfig
index 8d82cdb7f86a..0d32aac8069f 100644
--- a/arch/arc/configs/haps_hs_smp_defconfig
+++ b/arch/arc/configs/haps_hs_smp_defconfig
@@ -59,6 +59,5 @@ CONFIG_EXT2_FS_XATTR=y
 CONFIG_TMPFS=y
 # CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_NFS_FS=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_SOFTLOCKUP_DETECTOR=y
 # CONFIG_DEBUG_PREEMPT is not set
diff --git a/arch/arc/configs/hsdk_defconfig b/arch/arc/configs/hsdk_defconfig
index f856b03e0fb5..d18378d2c2a6 100644
--- a/arch/arc/configs/hsdk_defconfig
+++ b/arch/arc/configs/hsdk_defconfig
@@ -85,7 +85,6 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_SOFTLOCKUP_DETECTOR=y
 CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=10
diff --git a/arch/arc/configs/nsim_700_defconfig b/arch/arc/configs/nsim_700_defconfig
index a1ce12bf5b16..3e9829775992 100644
--- a/arch/arc/configs/nsim_700_defconfig
+++ b/arch/arc/configs/nsim_700_defconfig
@@ -56,5 +56,4 @@ CONFIG_EXT2_FS_XATTR=y
 CONFIG_TMPFS=y
 # CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_NFS_FS=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_DEBUG_PREEMPT is not set
diff --git a/arch/arc/configs/nsimosci_defconfig b/arch/arc/configs/nsimosci_defconfig
index ca10f4a2c823..502c87f351c8 100644
--- a/arch/arc/configs/nsimosci_defconfig
+++ b/arch/arc/configs/nsimosci_defconfig
@@ -65,4 +65,3 @@ CONFIG_TMPFS=y
 # CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3_ACL=y
-# CONFIG_ENABLE_MUST_CHECK is not set
diff --git a/arch/arc/configs/nsimosci_hs_defconfig b/arch/arc/configs/nsimosci_hs_defconfig
index 31b6ec3683c6..f721cc3997d0 100644
--- a/arch/arc/configs/nsimosci_hs_defconfig
+++ b/arch/arc/configs/nsimosci_hs_defconfig
@@ -63,4 +63,3 @@ CONFIG_TMPFS=y
 # CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3_ACL=y
-# CONFIG_ENABLE_MUST_CHECK is not set
diff --git a/arch/arc/configs/nsimosci_hs_smp_defconfig b/arch/arc/configs/nsimosci_hs_smp_defconfig
index 41a0037f48a5..1419fc946a08 100644
--- a/arch/arc/configs/nsimosci_hs_smp_defconfig
+++ b/arch/arc/configs/nsimosci_hs_smp_defconfig
@@ -26,9 +26,6 @@ CONFIG_UNIX=y
 CONFIG_UNIX_DIAG=y
 CONFIG_NET_KEY=y
 CONFIG_INET=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_IPV6 is not set
 # CONFIG_WIRELESS is not set
 CONFIG_DEVTMPFS=y
@@ -37,7 +34,6 @@ CONFIG_DEVTMPFS=y
 # CONFIG_BLK_DEV is not set
 CONFIG_NETDEVICES=y
 # CONFIG_NET_VENDOR_ARC is not set
-# CONFIG_NET_CADENCE is not set
 # CONFIG_NET_VENDOR_BROADCOM is not set
 CONFIG_EZCHIP_NPS_MANAGEMENT_ENET=y
 # CONFIG_NET_VENDOR_INTEL is not set
@@ -74,5 +70,5 @@ CONFIG_TMPFS=y
 # CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3_ACL=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_FTRACE=y
+# CONFIG_NET_VENDOR_CADENCE is not set
diff --git a/arch/arc/configs/tb10x_defconfig b/arch/arc/configs/tb10x_defconfig
index 4a94d1684ed6..6f0d2be9d926 100644
--- a/arch/arc/configs/tb10x_defconfig
+++ b/arch/arc/configs/tb10x_defconfig
@@ -35,15 +35,11 @@ CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 # CONFIG_WIRELESS is not set
 CONFIG_DEVTMPFS=y
 CONFIG_NETDEVICES=y
-# CONFIG_NET_CADENCE is not set
 # CONFIG_NET_VENDOR_BROADCOM is not set
 # CONFIG_NET_VENDOR_INTEL is not set
 # CONFIG_NET_VENDOR_MARVELL is not set
@@ -94,12 +90,11 @@ CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_DEBUG_FS=y
 CONFIG_HEADERS_INSTALL=y
-CONFIG_HEADERS_CHECK=y
 CONFIG_DEBUG_SECTION_MISMATCH=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_MEMORY_INIT=y
 CONFIG_DEBUG_STACKOVERFLOW=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_SCHEDSTATS=y
-CONFIG_TIMER_STATS=y
 # CONFIG_CRYPTO_HW is not set
+# CONFIG_NET_VENDOR_CADENCE is not set
diff --git a/arch/arc/configs/vdk_hs38_defconfig b/arch/arc/configs/vdk_hs38_defconfig
index 0c3b21416819..d3ef189c75f8 100644
--- a/arch/arc/configs/vdk_hs38_defconfig
+++ b/arch/arc/configs/vdk_hs38_defconfig
@@ -58,8 +58,6 @@ CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_HW_RANDOM is not set
 # CONFIG_HWMON is not set
 CONFIG_FB=y
-CONFIG_ARCPGU_RGB888=y
-CONFIG_ARCPGU_DISPTYPE=0
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
@@ -87,7 +85,6 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_DEBUG_SHIRQ=y
 CONFIG_SOFTLOCKUP_DETECTOR=y
diff --git a/arch/arc/configs/vdk_hs38_smp_defconfig b/arch/arc/configs/vdk_hs38_smp_defconfig
index f9ad9d3ee702..944b347025fd 100644
--- a/arch/arc/configs/vdk_hs38_smp_defconfig
+++ b/arch/arc/configs/vdk_hs38_smp_defconfig
@@ -91,7 +91,6 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_DEBUG_SHIRQ=y
 CONFIG_SOFTLOCKUP_DETECTOR=y
-- 
2.17.1

