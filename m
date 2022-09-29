Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D688A5EF344
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235557AbiI2KQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbiI2KQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:16:11 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D875C37C;
        Thu, 29 Sep 2022 03:15:36 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l8so624989wmi.2;
        Thu, 29 Sep 2022 03:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=MwhTjVOZHMPf1k5cZzrO849861cweN04oye9bzpF/64=;
        b=GjFOaCOwDnSzLov14NvvQRlfawxYlXUfXUstflu54DhXqLDHRfPTV6QaJJwru46N/1
         0MghmN0jqnRldHMaAWCm8ZFpoQWqTsZvZGQ9aqMcnf5F3GME/WUUgXLoTGQQOqvSkfZt
         u3jdBxUHMEkCxSHgjjJ0rFJ12g8Fb3Tv4ac2OZq1/HLkLpElrZNbRNadF9j0As9SAFAQ
         9Hw83PIa4kyuIIEdL4zLUvKTr+5JjxkaMAuXNMp/2x2CpU3EiAVZQhYRkONE0HSoPAoe
         zqq0KfP3If1GUGF3URhQlsMy0CU1VFxFxDnsJJIJ0Zjv8kL5HQ1CU57t8BC57kz9FWkW
         NrTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=MwhTjVOZHMPf1k5cZzrO849861cweN04oye9bzpF/64=;
        b=xu/Jit/6gRepVvjh6s1tl4UBQgOG7Z4ygbX7hKKixR6v18fuTY30gd1OwMnqoMoXCg
         dAqK+x1zRwvFeF+Cqk21Ldtim9ZHEBe70JZiD/vA3JtUvZfw0Sgtpv8A1pWmZiQ1vI8C
         rmGdGFLIgE5V9PuCjxyiKOeE+6+cDobCvN0PjSJq37ttguSQejq3wpEeSy529gMSCVsa
         pR0uCOh9/Zs6A0D+nEL1lUeLHhaYHoaHXRIDAxqapmEkVL+9hfORU6RMpSQF7aRkJ6qV
         AHzvjSN904Is1kZMBRj6ZzyrcRDD56gKEnCwzlOgnlQuWvMX6IlsXIgyTEMNdL6SZI5v
         GMlw==
X-Gm-Message-State: ACrzQf0bl840Zyv+n8OGqrkrIZtqTVIs5wrtpjaOcYgim3DMNoYL++HK
        nat2xHLOWVGlYRA6XOUA0i/M5wzl7BZpqw==
X-Google-Smtp-Source: AMsMyM42XUzu4HwnWXgVekQ8yzrBDMY2RajndEDZmKrKP+UQgOqIMcr9qLVSOnCNmZD0xSR2z7Ax6Q==
X-Received: by 2002:a05:600c:1d25:b0:3b4:92de:fb28 with SMTP id l37-20020a05600c1d2500b003b492defb28mr1718832wms.202.1664446518529;
        Thu, 29 Sep 2022 03:15:18 -0700 (PDT)
Received: from felia.fritz.box (200116b826e11200b190ebfd45660ea6.dip.versatel-1u1.de. [2001:16b8:26e1:1200:b190:ebfd:4566:ea6])
        by smtp.gmail.com with ESMTPSA id z14-20020a5d44ce000000b0022ccae2fa62sm1495192wrr.22.2022.09.29.03.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 03:15:17 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] xtensa: update config files
Date:   Thu, 29 Sep 2022 12:15:15 +0200
Message-Id: <20220929101515.354-1-lukas.bulwahn@gmail.com>
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
 arch/xtensa/configs/audio_kc705_defconfig   | 1 -
 arch/xtensa/configs/cadence_csp_defconfig   | 4 ----
 arch/xtensa/configs/generic_kc705_defconfig | 1 -
 arch/xtensa/configs/nommu_kc705_defconfig   | 1 -
 arch/xtensa/configs/smp_lx200_defconfig     | 1 -
 arch/xtensa/configs/xip_kc705_defconfig     | 1 -
 6 files changed, 9 deletions(-)

diff --git a/arch/xtensa/configs/audio_kc705_defconfig b/arch/xtensa/configs/audio_kc705_defconfig
index ef0ebcfbccf9..436b7cac9694 100644
--- a/arch/xtensa/configs/audio_kc705_defconfig
+++ b/arch/xtensa/configs/audio_kc705_defconfig
@@ -125,7 +125,6 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_LOCKUP_DETECTOR=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_SCHEDSTATS=y
-CONFIG_TIMER_STATS=y
 CONFIG_DEBUG_RT_MUTEXES=y
 CONFIG_DEBUG_SPINLOCK=y
 CONFIG_DEBUG_MUTEXES=y
diff --git a/arch/xtensa/configs/cadence_csp_defconfig b/arch/xtensa/configs/cadence_csp_defconfig
index 2665962d247a..8c66b9307f34 100644
--- a/arch/xtensa/configs/cadence_csp_defconfig
+++ b/arch/xtensa/configs/cadence_csp_defconfig
@@ -48,9 +48,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_IP_PNP_RARP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 # CONFIG_WIRELESS is not set
@@ -105,7 +102,6 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_LOCKUP_DETECTOR=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_SCHEDSTATS=y
-CONFIG_TIMER_STATS=y
 CONFIG_DEBUG_RT_MUTEXES=y
 CONFIG_PROVE_LOCKING=y
 CONFIG_DEBUG_ATOMIC_SLEEP=y
diff --git a/arch/xtensa/configs/generic_kc705_defconfig b/arch/xtensa/configs/generic_kc705_defconfig
index 236c7f23cc10..e376238bc5ca 100644
--- a/arch/xtensa/configs/generic_kc705_defconfig
+++ b/arch/xtensa/configs/generic_kc705_defconfig
@@ -112,7 +112,6 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_LOCKUP_DETECTOR=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_SCHEDSTATS=y
-CONFIG_TIMER_STATS=y
 CONFIG_DEBUG_RT_MUTEXES=y
 CONFIG_DEBUG_SPINLOCK=y
 CONFIG_DEBUG_MUTEXES=y
diff --git a/arch/xtensa/configs/nommu_kc705_defconfig b/arch/xtensa/configs/nommu_kc705_defconfig
index 8263da9e078d..c2ab4306ee20 100644
--- a/arch/xtensa/configs/nommu_kc705_defconfig
+++ b/arch/xtensa/configs/nommu_kc705_defconfig
@@ -113,7 +113,6 @@ CONFIG_DEBUG_NOMMU_REGIONS=y
 CONFIG_DEBUG_SHIRQ=y
 CONFIG_LOCKUP_DETECTOR=y
 CONFIG_SCHEDSTATS=y
-CONFIG_TIMER_STATS=y
 CONFIG_DEBUG_RT_MUTEXES=y
 CONFIG_DEBUG_SPINLOCK=y
 CONFIG_DEBUG_MUTEXES=y
diff --git a/arch/xtensa/configs/smp_lx200_defconfig b/arch/xtensa/configs/smp_lx200_defconfig
index 7bdffa3a69c6..63b56ce79f83 100644
--- a/arch/xtensa/configs/smp_lx200_defconfig
+++ b/arch/xtensa/configs/smp_lx200_defconfig
@@ -116,7 +116,6 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_VM=y
 CONFIG_LOCKUP_DETECTOR=y
 CONFIG_SCHEDSTATS=y
-CONFIG_TIMER_STATS=y
 CONFIG_DEBUG_RT_MUTEXES=y
 CONFIG_DEBUG_SPINLOCK=y
 CONFIG_DEBUG_MUTEXES=y
diff --git a/arch/xtensa/configs/xip_kc705_defconfig b/arch/xtensa/configs/xip_kc705_defconfig
index 1c3cebaaa71b..165652c45b85 100644
--- a/arch/xtensa/configs/xip_kc705_defconfig
+++ b/arch/xtensa/configs/xip_kc705_defconfig
@@ -55,7 +55,6 @@ CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_NETDEVICES=y
 # CONFIG_NET_VENDOR_ARC is not set
-# CONFIG_NET_VENDOR_AURORA is not set
 # CONFIG_NET_VENDOR_BROADCOM is not set
 # CONFIG_NET_VENDOR_INTEL is not set
 # CONFIG_NET_VENDOR_MARVELL is not set
-- 
2.17.1

