Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7140C5EF32E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234957AbiI2KPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235232AbiI2KOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:14:50 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37644476C8;
        Thu, 29 Sep 2022 03:14:46 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id l18so1390551wrw.9;
        Thu, 29 Sep 2022 03:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=AmmYiaVo4AuI9eZI1ByQy3rUmn06Pzei7F4Lq2FTzy4=;
        b=MTMIkxcITs8swkaF1ju0/WIAsEer2IQgoTgztzIo3Mv68a+np6CkNa6t32s0iCZzvD
         66qOECMm7u3p6+AT9EhWli7Op1zAg+MvG+PdEKsXQEXkQ53l1vE3Pf4WvUzCbAkAi6Wv
         m4Nagnk9tkou1IDiPUKsreLwslT6HnaBpeEvydMh4GZCxLHwpjBuOUyVhQGfW4xaKNIs
         3sUQ65e3HXelodn0/JhHzj+W91JSQBHYNwWJFhlPkCc7NMl8tZCu92vswpTYOZJ49eGv
         U6MdGMgRF6MUrrS+a023vYkZl73ObQOqrKqPb5co2SwuKa+/C+KLx68JfrjOoaMuZJWN
         7j5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=AmmYiaVo4AuI9eZI1ByQy3rUmn06Pzei7F4Lq2FTzy4=;
        b=tB6eHe1jDXGncbRFOQ0TlxBKoNffcPhT7pSsFu244Q8P4gThg/y4fUz4sBjlXH/6N3
         uRIjZAKKNZIlCg7njVnwu4TOYrgIumQ2iMYwZV56Xull4HlfLqCqTBwGKIJ93LmYuynT
         Co/OK221uYd2NW4Z7j2GvAZVw3j82YgfvHfVdq6odVsVlgoDU9sTqUivcMEdXdhIZeXe
         rvOXh6SPuz8LOGGhlsrgZ8M8MasiYI/C3iUoo0PVB4+KxnTRLmTFCK8ZHkqX7FutUDqp
         ri2GWLG6jVrLrpKaf41ZXWjGwx1wZFHpAm8hpZXw/LpCnoTZgyuJTTA0+H55PiXMM2DX
         3MQQ==
X-Gm-Message-State: ACrzQf1uXMN8BposoNjmbQlIF0+zLBW0lZWQKK0Mg4TMzVR+vP6//XCV
        VYMsA9adnPMuFyRzyvgmkFltYPEB/TQ=
X-Google-Smtp-Source: AMsMyM596HI/Rof0pxBZLTikL+M2ieHgIvm1CvuzhsF7gRrXTRvZ7VdH5QNSYGcE9dXQ3hVsYDrJ8Q==
X-Received: by 2002:a5d:4704:0:b0:22c:a4e6:9621 with SMTP id y4-20020a5d4704000000b0022ca4e69621mr1625827wrq.89.1664446484768;
        Thu, 29 Sep 2022 03:14:44 -0700 (PDT)
Received: from felia.fritz.box (200116b826e11200b190ebfd45660ea6.dip.versatel-1u1.de. [2001:16b8:26e1:1200:b190:ebfd:4566:ea6])
        by smtp.gmail.com with ESMTPSA id w1-20020a5d5441000000b0022cc0a2cbecsm5948756wrv.15.2022.09.29.03.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 03:14:44 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ia64@vger.kernel.org
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] ia64: update config files
Date:   Thu, 29 Sep 2022 12:14:41 +0200
Message-Id: <20220929101441.32009-1-lukas.bulwahn@gmail.com>
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
 arch/ia64/configs/bigsur_defconfig    | 2 --
 arch/ia64/configs/generic_defconfig   | 2 --
 arch/ia64/configs/gensparse_defconfig | 3 ---
 arch/ia64/configs/tiger_defconfig     | 2 --
 arch/ia64/configs/zx1_defconfig       | 1 -
 5 files changed, 10 deletions(-)

diff --git a/arch/ia64/configs/bigsur_defconfig b/arch/ia64/configs/bigsur_defconfig
index a3724882295c..3e1337aceb37 100644
--- a/arch/ia64/configs/bigsur_defconfig
+++ b/arch/ia64/configs/bigsur_defconfig
@@ -20,7 +20,6 @@ CONFIG_UNIX=y
 CONFIG_INET=y
 # CONFIG_IPV6 is not set
 CONFIG_BLK_DEV_LOOP=m
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=m
 CONFIG_ATA=m
@@ -91,7 +90,6 @@ CONFIG_NFS_V4=m
 CONFIG_NFSD=m
 CONFIG_NFSD_V4=y
 CONFIG_CIFS=m
-CONFIG_CIFS_STATS=y
 CONFIG_CIFS_XATTR=y
 CONFIG_CIFS_POSIX=y
 CONFIG_NLS_CODEPAGE_437=y
diff --git a/arch/ia64/configs/generic_defconfig b/arch/ia64/configs/generic_defconfig
index a3dff482a3d7..f8033bacea89 100644
--- a/arch/ia64/configs/generic_defconfig
+++ b/arch/ia64/configs/generic_defconfig
@@ -39,7 +39,6 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_CONNECTOR=y
 # CONFIG_PNP_DEBUG_MESSAGES is not set
 CONFIG_BLK_DEV_LOOP=m
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_SGI_XP=m
@@ -91,7 +90,6 @@ CONFIG_SERIAL_8250_SHARE_IRQ=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_EFI=y
-CONFIG_RAW_DRIVER=m
 CONFIG_HPET=y
 CONFIG_AGP=m
 CONFIG_AGP_I460=m
diff --git a/arch/ia64/configs/gensparse_defconfig b/arch/ia64/configs/gensparse_defconfig
index 4cd46105b020..ffebe6c503f5 100644
--- a/arch/ia64/configs/gensparse_defconfig
+++ b/arch/ia64/configs/gensparse_defconfig
@@ -31,11 +31,9 @@ CONFIG_IP_MULTICAST=y
 CONFIG_SYN_COOKIES=y
 # CONFIG_IPV6 is not set
 CONFIG_BLK_DEV_LOOP=m
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_ATA=y
-CONFIG_BLK_DEV_IDECD=y
 CONFIG_ATA_GENERIC=y
 CONFIG_PATA_CMD64X=y
 CONFIG_ATA_PIIX=y
@@ -81,7 +79,6 @@ CONFIG_SERIAL_8250_SHARE_IRQ=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_EFI=y
-CONFIG_RAW_DRIVER=m
 CONFIG_HPET=y
 CONFIG_AGP=m
 CONFIG_AGP_I460=m
diff --git a/arch/ia64/configs/tiger_defconfig b/arch/ia64/configs/tiger_defconfig
index a2045d73adfa..45f5d6e2da0a 100644
--- a/arch/ia64/configs/tiger_defconfig
+++ b/arch/ia64/configs/tiger_defconfig
@@ -36,7 +36,6 @@ CONFIG_IP_MULTICAST=y
 CONFIG_SYN_COOKIES=y
 # CONFIG_IPV6 is not set
 CONFIG_BLK_DEV_LOOP=m
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_ATA=y
@@ -85,7 +84,6 @@ CONFIG_SERIAL_8250_SHARE_IRQ=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_EFI=y
-CONFIG_RAW_DRIVER=m
 CONFIG_HPET=y
 CONFIG_AGP=m
 CONFIG_AGP_I460=m
diff --git a/arch/ia64/configs/zx1_defconfig b/arch/ia64/configs/zx1_defconfig
index 99f8b2a0332b..ed104550d0d5 100644
--- a/arch/ia64/configs/zx1_defconfig
+++ b/arch/ia64/configs/zx1_defconfig
@@ -30,7 +30,6 @@ CONFIG_PATA_CMD64X=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=y
-CONFIG_CHR_DEV_OSST=y
 CONFIG_BLK_DEV_SR=y
 CONFIG_CHR_DEV_SG=y
 CONFIG_SCSI_CONSTANTS=y
-- 
2.17.1

