Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797BF69DA49
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 06:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbjBUFMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 00:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjBUFMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 00:12:08 -0500
X-Greylist: delayed 90 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Feb 2023 21:12:06 PST
Received: from omta001.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1706425B8E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 21:12:05 -0800 (PST)
Received: from shw-obgw-4002a.ext.cloudfilter.net ([10.228.9.250])
        by cmsmtp with ESMTP
        id UEkjpV3VWuZMSUKvCpmJdP; Tue, 21 Feb 2023 05:10:34 +0000
Received: from fanir.tuyoix.net ([68.150.218.192])
        by cmsmtp with ESMTP
        id UKvBpVXe8yAOeUKvCpnO4s; Tue, 21 Feb 2023 05:10:34 +0000
X-Authority-Analysis: v=2.4 cv=e5oV9Il/ c=1 sm=1 tr=0 ts=63f4524a
 a=LfNn7serMq+1bQZBlMsSfQ==:117 a=LfNn7serMq+1bQZBlMsSfQ==:17
 a=m04uMKEZRckA:10 a=M51BFTxLslgA:10 a=nlC_4_pT8q9DhB4Ho9EA:9 a=3I1X_3ewAAAA:8
 a=rIOp2VOyJG4mDjY_MWYA:9 a=QEXdDO2ut3YA:10 a=VG9N9RgkD3hcbI6YpJ1l:22
Received: from tuyoix.net (fanir.tuyoix.net [192.168.144.16])
        (authenticated bits=0)
        by fanir.tuyoix.net (8.17.1/8.17.1) with ESMTPSA id 31L5AW7t015539
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 20 Feb 2023 22:10:33 -0700
Date:   Mon, 20 Feb 2023 22:10:32 -0700 (MST)
From:   =?UTF-8?Q?Marc_Aur=C3=A8le_La_France?= <tsi@tuyoix.net>
To:     John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Remove orphaned CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT
Message-ID: <5c19e248-1b6b-330c-7c4c-a824688daefe@tuyoix.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463807856-701356714-1676956233=:15533"
X-CMAE-Envelope: MS4xfEugHZCcJNsa/3wJZv4XFiwQPuzomgzUlo458pV0fyY5lzip06Ee45z+ImoW2owSb3n+AN5TNBGDEX6cmcTNF3fndC5bYNOvz0J1FpnoCHsMqPKecJUJ
 s3CF946vAjGuKOhzQjYF7pdBTNC5+8U4kyPtig42Ur4ZWpvgncmL53ecMTul9mqRLqNUOV54st8DzxsGvTffIMR8jf90KYCp0LSsF2qjKRImkV1o/OUnoJAH
 lIuDD1AzavvWEegJljPB2Q==
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463807856-701356714-1676956233=:15533
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

After 93d102f094be9beab28e5afb656c188b16a3793b "printk: remove safe buffers",
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT is no longer useful.  Remove it.

This change is not eligible for stable@.

Please Reply-To-All.

Marc.

Signed-off-by: Marc Aurèle La France <tsi@tuyoix.net>

diff -aNpRruz -X /etc/diff.excludes linux-6.2.0/arch/powerpc/configs/microwatt_defconfig devel-6.2.0/arch/powerpc/configs/microwatt_defconfig
--- linux-6.2.0/arch/powerpc/configs/microwatt_defconfig	2023-02-19 15:24:22.000000000 -0700
+++ devel-6.2.0/arch/powerpc/configs/microwatt_defconfig	2023-02-20 21:39:39.057268798 -0700
@@ -4,7 +4,6 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_TICK_CPU_ACCOUNTING=y
 CONFIG_LOG_BUF_SHIFT=16
-CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=12
 CONFIG_CGROUPS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
diff -aNpRruz -X /etc/diff.excludes linux-6.2.0/arch/riscv/configs/nommu_k210_defconfig devel-6.2.0/arch/riscv/configs/nommu_k210_defconfig
--- linux-6.2.0/arch/riscv/configs/nommu_k210_defconfig	2023-02-19 15:24:22.000000000 -0700
+++ devel-6.2.0/arch/riscv/configs/nommu_k210_defconfig	2023-02-20 21:40:01.349181760 -0700
@@ -1,6 +1,5 @@
 # CONFIG_CPU_ISOLATION is not set
 CONFIG_LOG_BUF_SHIFT=13
-CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=12
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_RD_GZIP is not set
 # CONFIG_RD_BZIP2 is not set
diff -aNpRruz -X /etc/diff.excludes linux-6.2.0/arch/riscv/configs/nommu_k210_sdcard_defconfig devel-6.2.0/arch/riscv/configs/nommu_k210_sdcard_defconfig
--- linux-6.2.0/arch/riscv/configs/nommu_k210_sdcard_defconfig	2023-02-19 15:24:22.000000000 -0700
+++ devel-6.2.0/arch/riscv/configs/nommu_k210_sdcard_defconfig	2023-02-20 21:39:46.721238871 -0700
@@ -1,6 +1,5 @@
 # CONFIG_CPU_ISOLATION is not set
 CONFIG_LOG_BUF_SHIFT=13
-CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=12
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 # CONFIG_SYSFS_SYSCALL is not set
 # CONFIG_FHANDLE is not set
diff -aNpRruz -X /etc/diff.excludes linux-6.2.0/arch/riscv/configs/nommu_virt_defconfig devel-6.2.0/arch/riscv/configs/nommu_virt_defconfig
--- linux-6.2.0/arch/riscv/configs/nommu_virt_defconfig	2023-02-19 15:24:22.000000000 -0700
+++ devel-6.2.0/arch/riscv/configs/nommu_virt_defconfig	2023-02-20 21:39:55.329205262 -0700
@@ -1,6 +1,5 @@
 # CONFIG_CPU_ISOLATION is not set
 CONFIG_LOG_BUF_SHIFT=16
-CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=12
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_RD_BZIP2 is not set
 # CONFIG_RD_LZMA is not set
diff -aNpRruz -X /etc/diff.excludes linux-6.2.0/init/Kconfig devel-6.2.0/init/Kconfig
--- linux-6.2.0/init/Kconfig	2023-02-19 15:24:22.000000000 -0700
+++ devel-6.2.0/init/Kconfig	2023-02-20 21:40:23.329095967 -0700
@@ -769,30 +769,6 @@ config LOG_CPU_MAX_BUF_SHIFT
 		     13 =>   8 KB for each CPU
 		     12 =>   4 KB for each CPU

-config PRINTK_SAFE_LOG_BUF_SHIFT
-	int "Temporary per-CPU printk log buffer size (12 => 4KB, 13 => 8KB)"
-	range 10 21
-	default 13
-	depends on PRINTK
-	help
-	  Select the size of an alternate printk per-CPU buffer where messages
-	  printed from unsafe contexts are temporary stored. One example would
-	  be NMI messages, another one - printk recursion. The messages are
-	  copied to the main log buffer in a safe context to avoid a deadlock.
-	  The value defines the size as a power of 2.
-
-	  Those messages are rare and limited. The largest one is when
-	  a backtrace is printed. It usually fits into 4KB. Select
-	  8KB if you want to be on the safe side.
-
-	  Examples:
-		     17 => 128 KB for each CPU
-		     16 =>  64 KB for each CPU
-		     15 =>  32 KB for each CPU
-		     14 =>  16 KB for each CPU
-		     13 =>   8 KB for each CPU
-		     12 =>   4 KB for each CPU
-
 config PRINTK_INDEX
 	bool "Printk indexing debugfs interface"
 	depends on PRINTK && DEBUG_FS
---1463807856-701356714-1676956233=:15533--
