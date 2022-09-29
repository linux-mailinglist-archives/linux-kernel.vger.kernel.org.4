Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DCE5EF347
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbiI2KQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbiI2KQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:16:11 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8861214C05D;
        Thu, 29 Sep 2022 03:15:35 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id n10so1382324wrw.12;
        Thu, 29 Sep 2022 03:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=hiTLUzBH9NabdIdrMblSr5toDJeyRZBWqlANn91ZmPc=;
        b=SnrozexK3kkeucQ5JB/KUpuMl6PzSie6B7cANwbz9RiYm1YAISMghljDoah6VMZv6S
         eYtxCG/1GTSGdttZkyQu4CEZJVqOMLjE8jt+AxudSdmSUl+FNI5wfI3C4PUVTvGTK7hq
         4Vpgza3Beauw9yc5F73gkxQT73Y8yjVDW5RzVmXuKehCJqqiB3ltBGHzw+KEyX7QzSzD
         WTgUk9moQt0G/SEPeSi0eqF3Rs9nzw6FRmqXiuy604FCAe2lMIfvsuEF7HEpIG9x7L30
         mcsucjr0VMnE+OMyDIJl+p7H60yaJ3Ne8HSLCxbAMucAHc9D9p+YP28p4KFGrOqz0YE6
         Zcew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hiTLUzBH9NabdIdrMblSr5toDJeyRZBWqlANn91ZmPc=;
        b=6Vkp8OGXdNrbF2NgJ5ONvrwgL3jwUIKZnMVS29dEb6dhSjR7GEMu6hLrj/CkZdSd+C
         FUpH/kyPnpDWLxarNsb0KiWH2w6eCSvMcokD4K2ZlmK9BkmVv0U0broZyNmkUs0Ds0d9
         e/sZw31hvuqod5NIB/MbJ9EE8YMlnYoUXaTUZQJtkFwMIA6ltr1Uh+X3AlZC5GIYJhYm
         4O9+lDSyOfg2coOt5xJIUlw60hecEEbOysgurz4wT0f3a7F2Uf3wXpuLVWJxQpjo5fGg
         5rozJwFfjl4kgdksoRQVwyWlXJbwKsSxhmGTXd1qGgMW51eESLzxuTgDK/xa0PJyC8Tj
         kbOw==
X-Gm-Message-State: ACrzQf3pXuxXk3z2OoUojE8/ysGCFakiqmvKd4zH+rmx3tG0NqVY7Izu
        rNDw+NmLXDvsaj7TsxhPV2kE8U6Ue9S0wg==
X-Google-Smtp-Source: AMsMyM49u8aANveee+wEbCasP72TSl0qluzgM/54D0Q5GBM7dM6EnH+mysJdsWHkK95FNhSF65/Gkw==
X-Received: by 2002:a5d:6982:0:b0:22c:bde2:d6f2 with SMTP id g2-20020a5d6982000000b0022cbde2d6f2mr1638647wru.714.1664446514850;
        Thu, 29 Sep 2022 03:15:14 -0700 (PDT)
Received: from felia.fritz.box (200116b826e11200b190ebfd45660ea6.dip.versatel-1u1.de. [2001:16b8:26e1:1200:b190:ebfd:4566:ea6])
        by smtp.gmail.com with ESMTPSA id g2-20020adff402000000b0022860e8ae7csm6425224wro.77.2022.09.29.03.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 03:15:14 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] sparc: update config files
Date:   Thu, 29 Sep 2022 12:15:11 +0200
Message-Id: <20220929101511.32749-1-lukas.bulwahn@gmail.com>
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
 arch/sparc/configs/sparc32_defconfig | 3 ---
 arch/sparc/configs/sparc64_defconfig | 8 --------
 2 files changed, 11 deletions(-)

diff --git a/arch/sparc/configs/sparc32_defconfig b/arch/sparc/configs/sparc32_defconfig
index 7b3efe5edc1a..b283f4c51a21 100644
--- a/arch/sparc/configs/sparc32_defconfig
+++ b/arch/sparc/configs/sparc32_defconfig
@@ -28,7 +28,6 @@ CONFIG_INET6_IPCOMP=m
 CONFIG_IPV6_TUNNEL=m
 CONFIG_NET_PKTGEN=m
 CONFIG_BLK_DEV_LOOP=m
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
@@ -38,7 +37,6 @@ CONFIG_SCSI_QLOGICPTI=m
 CONFIG_SCSI_SUNESP=y
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=m
-CONFIG_NET_ETHERNET=y
 CONFIG_MII=m
 CONFIG_SUNLANCE=y
 CONFIG_HAPPYMEAL=m
@@ -60,7 +58,6 @@ CONFIG_SERIAL_SUNSU=y
 CONFIG_SERIAL_SUNSU_CONSOLE=y
 CONFIG_SPI=y
 CONFIG_SPI_XILINX=m
-CONFIG_SPI_XILINX_PLTFM=m
 CONFIG_SUN_OPENPROMIO=m
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
diff --git a/arch/sparc/configs/sparc64_defconfig b/arch/sparc/configs/sparc64_defconfig
index 18099099583e..64f983569a43 100644
--- a/arch/sparc/configs/sparc64_defconfig
+++ b/arch/sparc/configs/sparc64_defconfig
@@ -41,7 +41,6 @@ CONFIG_NET_IPGRE_BROADCAST=y
 CONFIG_IP_MROUTE=y
 CONFIG_IP_PIMSM_V1=y
 CONFIG_IP_PIMSM_V2=y
-CONFIG_ARPD=y
 CONFIG_SYN_COOKIES=y
 CONFIG_INET_AH=y
 CONFIG_INET_ESP=y
@@ -55,11 +54,9 @@ CONFIG_INET6_IPCOMP=m
 CONFIG_IPV6_TUNNEL=m
 CONFIG_VLAN_8021Q=m
 CONFIG_NET_PKTGEN=m
-CONFIG_NET_TCPPROBE=m
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
 CONFIG_CONNECTOR=m
 CONFIG_BLK_DEV_LOOP=m
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_CDROM_PKTCDVD=m
 CONFIG_CDROM_PKTCDVD_WCACHE=y
@@ -72,7 +69,6 @@ CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=m
 CONFIG_CHR_DEV_SG=m
-CONFIG_SCSI_MULTI_LUN=y
 CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_SPI_ATTRS=y
 CONFIG_SCSI_FC_ATTRS=y
@@ -90,14 +86,12 @@ CONFIG_DM_SNAPSHOT=m
 CONFIG_DM_MIRROR=m
 CONFIG_DM_ZERO=m
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_MII=m
 CONFIG_SUNLANCE=m
 CONFIG_HAPPYMEAL=y
 CONFIG_SUNGEM=m
 CONFIG_SUNVNET=m
 CONFIG_LDMVSW=m
-CONFIG_NET_PCI=y
 CONFIG_E1000=m
 CONFIG_E1000E=m
 CONFIG_TIGON3=m
@@ -189,7 +183,6 @@ CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_EXT3_FS_POSIX_ACL=y
 CONFIG_EXT3_FS_SECURITY=y
 CONFIG_PROC_KCORE=y
@@ -215,7 +208,6 @@ CONFIG_CRYPTO_MD4=y
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_SHA256=m
 CONFIG_CRYPTO_SHA512=m
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_AES=m
 CONFIG_CRYPTO_ANUBIS=m
-- 
2.17.1

