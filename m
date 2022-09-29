Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA465EF325
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbiI2KOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235259AbiI2KOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:14:42 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07461C104;
        Thu, 29 Sep 2022 03:14:39 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 130-20020a1c0288000000b003b494ffc00bso2387973wmc.0;
        Thu, 29 Sep 2022 03:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=12eQhE2PY0OlduRrQeOAHEPmadytun891QhnQWUKARo=;
        b=In7gcwx2oRj7FOh5UaUT4AiM9oZqR5yhFHDZ5CxelJTZpu4ryf4yMCXHCQeE2ppI4t
         vrYduSGEosVdvW0CCrOon3vlC/iSkfIVjHs4j3qvYmwWsRZuAYeSOlTuM6TEqr1H759a
         YV4M8IP2uYGWvr3XIip7Bi+oqbM4pX91k/3/IuAzfJCPb2snkD2jYy7sH9Xj8gEMpVsL
         4YiTA2dWruS5Md6VyWkMEAH4DDRSYomtXEoTnpslMI5+a0GZjM2ssse3Gc0h4H7SjaWp
         Rp1YEr5wQHUHUCwxILffa5QBxp7NAr6IYwpnDDYWp/ee5TDm37h7vZGSpZWeotVcSzHR
         t0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=12eQhE2PY0OlduRrQeOAHEPmadytun891QhnQWUKARo=;
        b=M0id6lWgnb+lLgWEX4a0XsCYVV9J3Mc2pIwHox6XDXbnkDRMgHZ4DVjWzaOC7AxrBS
         ME9s3mZ3n1RBiKh8xU4HKXTV6OscLRaAqL0+u6Lrz0P+2eyafNDfS+nD+MJhVfu8xyfl
         zqCE+7666c2Ykk6G+WeYzlW/NDqa2dHoFX0d4U7sRn87tvUjGXQNZIcBYo04XrQ2kf+1
         FCgI5+ITuH61lT7ekmi1LfT27r/8BEZS4gJEVnYdJpNYIVo+ZTQptaaaj9ltwNWd8Qeu
         sCsteY6nyzEXl38bse+40lO9Bn16+dove6hoeLNwWtlW4COFwZCIFUVWwhgk54vbqCof
         8Qhw==
X-Gm-Message-State: ACrzQf01NwFOvIr9MZKV89jeqzZevpPpDNoBX/PEHtMaG4GZ5fSVsLoJ
        KleGnx5SKFTvtZnJxm6zlqIG5iMtun8=
X-Google-Smtp-Source: AMsMyM4yu7i7f21/RisYXNYU33L7DSjERybpxGpuWdGGtQo9R8DqVaTE2DucLprr6xGNff4B1yNk1g==
X-Received: by 2002:a05:600c:5014:b0:3b5:889:58a5 with SMTP id n20-20020a05600c501400b003b5088958a5mr1660328wmr.140.1664446477349;
        Thu, 29 Sep 2022 03:14:37 -0700 (PDT)
Received: from felia.fritz.box (200116b826e11200b190ebfd45660ea6.dip.versatel-1u1.de. [2001:16b8:26e1:1200:b190:ebfd:4566:ea6])
        by smtp.gmail.com with ESMTPSA id u5-20020a5d4685000000b0022a3a887ceasm6313592wrq.49.2022.09.29.03.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 03:14:36 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] config: android: update config files
Date:   Thu, 29 Sep 2022 12:14:33 +0200
Message-Id: <20220929101433.31801-1-lukas.bulwahn@gmail.com>
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
  - removing configs that are not in tree withot recently pending patches
  - adding new configs that are replacements for old configs in the file

For some detailed information, see Link.

Link: https://lore.kernel.org/kernel-janitors/20220929090645.1389-1-lukas.bulwahn@gmail.com/

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 kernel/configs/android-base.config        | 9 ---------
 kernel/configs/android-recommended.config | 5 -----
 2 files changed, 14 deletions(-)

diff --git a/kernel/configs/android-base.config b/kernel/configs/android-base.config
index 44b0f0146a3f..07b45571a8ff 100644
--- a/kernel/configs/android-base.config
+++ b/kernel/configs/android-base.config
@@ -1,7 +1,6 @@
 #  KEEP ALPHABETICALLY SORTED
 # CONFIG_DEVMEM is not set
 # CONFIG_FHANDLE is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_NFSD is not set
 # CONFIG_NFS_FS is not set
 # CONFIG_OABI_COMPAT is not set
@@ -9,9 +8,7 @@
 # CONFIG_USELIB is not set
 CONFIG_ANDROID_BINDER_IPC=y
 CONFIG_ANDROID_BINDER_DEVICES=binder,hwbinder,vndbinder
-CONFIG_ANDROID_LOW_MEMORY_KILLER=y
 CONFIG_ARMV8_DEPRECATED=y
-CONFIG_ASHMEM=y
 CONFIG_AUDIT=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_CGROUPS=y
@@ -34,7 +31,6 @@ CONFIG_INET6_IPCOMP=y
 CONFIG_INET=y
 CONFIG_INET_DIAG_DESTROY=y
 CONFIG_INET_ESP=y
-CONFIG_INET_XFRM_MODE_TUNNEL=y
 CONFIG_IP6_NF_FILTER=y
 CONFIG_IP6_NF_IPTABLES=y
 CONFIG_IP6_NF_MANGLE=y
@@ -71,7 +67,6 @@ CONFIG_MODVERSIONS=y
 CONFIG_NET=y
 CONFIG_NETDEVICES=y
 CONFIG_NETFILTER=y
-CONFIG_NETFILTER_TPROXY=y
 CONFIG_NETFILTER_XT_MATCH_COMMENT=y
 CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=y
 CONFIG_NETFILTER_XT_MATCH_CONNMARK=y
@@ -115,8 +110,6 @@ CONFIG_NF_CONNTRACK_AMANDA=y
 CONFIG_NF_CONNTRACK_EVENTS=y
 CONFIG_NF_CONNTRACK_FTP=y
 CONFIG_NF_CONNTRACK_H323=y
-CONFIG_NF_CONNTRACK_IPV4=y
-CONFIG_NF_CONNTRACK_IPV6=y
 CONFIG_NF_CONNTRACK_IRC=y
 CONFIG_NF_CONNTRACK_NETBIOS_NS=y
 CONFIG_NF_CONNTRACK_PPTP=y
@@ -148,12 +141,10 @@ CONFIG_SECURITY_SELINUX=y
 CONFIG_SETEND_EMULATION=y
 CONFIG_STAGING=y
 CONFIG_SWP_EMULATION=y
-CONFIG_SYNC=y
 CONFIG_TUN=y
 CONFIG_UNIX=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_CONFIGFS=y
 CONFIG_USB_CONFIGFS_F_FS=y
 CONFIG_USB_CONFIGFS_F_MIDI=y
-CONFIG_USB_OTG_WAKELOCK=y
 CONFIG_XFRM_USER=y
diff --git a/kernel/configs/android-recommended.config b/kernel/configs/android-recommended.config
index e400fbbc8aba..fae090812da6 100644
--- a/kernel/configs/android-recommended.config
+++ b/kernel/configs/android-recommended.config
@@ -7,7 +7,6 @@
 # CONFIG_PM_WAKELOCKS_GC is not set
 # CONFIG_VT is not set
 CONFIG_ARM64_SW_TTBR0_PAN=y
-CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_BLK_DEV_DM=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
@@ -76,7 +75,6 @@ CONFIG_HID_WIIMOTE=y
 CONFIG_HID_ZEROPLUS=y
 CONFIG_HID_ZYDACRON=y
 CONFIG_INPUT_EVDEV=y
-CONFIG_INPUT_GPIO=y
 CONFIG_INPUT_JOYSTICK=y
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_TABLET=y
@@ -96,7 +94,6 @@ CONFIG_PANIC_TIMEOUT=5
 CONFIG_PANTHERLORD_FF=y
 CONFIG_PERF_EVENTS=y
 CONFIG_PM_DEBUG=y
-CONFIG_PM_RUNTIME=y
 CONFIG_PM_WAKELOCKS_LIMIT=0
 CONFIG_POWER_SUPPLY=y
 CONFIG_PSTORE=y
@@ -107,7 +104,6 @@ CONFIG_SMARTJOYPLUS_FF=y
 CONFIG_SND=y
 CONFIG_SOUND=y
 CONFIG_STRICT_KERNEL_RWX=y
-CONFIG_SUSPEND_TIME=y
 CONFIG_TABLET_USB_ACECAD=y
 CONFIG_TABLET_USB_AIPTEK=y
 CONFIG_TABLET_USB_HANWANG=y
@@ -116,7 +112,6 @@ CONFIG_TASKSTATS=y
 CONFIG_TASK_DELAY_ACCT=y
 CONFIG_TASK_IO_ACCOUNTING=y
 CONFIG_TASK_XACCT=y
-CONFIG_TIMER_STATS=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_UHID=y
-- 
2.17.1

