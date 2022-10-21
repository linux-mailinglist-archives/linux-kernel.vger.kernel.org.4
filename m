Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0707760803B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJUUu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJUUuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:50:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE3DFC1E0;
        Fri, 21 Oct 2022 13:50:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CED34B80C82;
        Fri, 21 Oct 2022 20:50:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F655C433D6;
        Fri, 21 Oct 2022 20:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666385400;
        bh=kYmXdlJCPhtt4uIiTfM2YwsKyRkHie/QI7iUSviGI7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HOY8GsWX/MBlmsU4NQ/Kcf6mjvd95DH3jHkfK3d7HxPS2m0Uu2779N0+EFYiHV7Mp
         ARhZZuD2f0LqZsKfkYOHAHpiA0xfSuTI+cwW+Ga5+a3kXZIyZKbUkGPlZy7yVP29r7
         uLOU8PJYQWHFQp+vw287RbAa8tnS7Ey7ro05EfmsXMU2QZH/05IapM/0gqehybpA1H
         CfTyg90T7/PABTi44q83w5NxI7CZhxGAtW5BM/rBVEC/OEbtY0/7vJH5lwBs+QxR6C
         kRile9AbSnwhfw5Dfsc951wp3EvsWtqsaC9hXUNbB3cAzAZtTgQQVV5w3CmSH75plv
         +oeG0Tlw7m6jw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH 15/21] cpufreq: remove s3c24xx drivers
Date:   Fri, 21 Oct 2022 22:27:48 +0200
Message-Id: <20221021203329.4143397-15-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221021202254.4142411-1-arnd@kernel.org>
References: <20221021202254.4142411-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

All s3c24xx platforms were removed, so these five drivers are all
obsolete now.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/cpufreq/Kconfig.arm                  |  78 ---
 drivers/cpufreq/Makefile                     |   6 -
 drivers/cpufreq/s3c2410-cpufreq.c            | 155 -----
 drivers/cpufreq/s3c2412-cpufreq.c            | 240 -------
 drivers/cpufreq/s3c2416-cpufreq.c            | 492 --------------
 drivers/cpufreq/s3c2440-cpufreq.c            | 321 ---------
 drivers/cpufreq/s3c24xx-cpufreq-debugfs.c    | 163 -----
 drivers/cpufreq/s3c24xx-cpufreq.c            | 648 -------------------
 include/linux/soc/samsung/s3c-cpufreq-core.h | 299 ---------
 9 files changed, 2402 deletions(-)
 delete mode 100644 drivers/cpufreq/s3c2410-cpufreq.c
 delete mode 100644 drivers/cpufreq/s3c2412-cpufreq.c
 delete mode 100644 drivers/cpufreq/s3c2416-cpufreq.c
 delete mode 100644 drivers/cpufreq/s3c2440-cpufreq.c
 delete mode 100644 drivers/cpufreq/s3c24xx-cpufreq-debugfs.c
 delete mode 100644 drivers/cpufreq/s3c24xx-cpufreq.c
 delete mode 100644 include/linux/soc/samsung/s3c-cpufreq-core.h

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 8f7a1065f344..e3e0367305ec 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -180,84 +180,6 @@ config ARM_RASPBERRYPI_CPUFREQ
 
 	  If in doubt, say N.
 
-config ARM_S3C_CPUFREQ
-	bool
-	help
-	  Internal configuration node for common cpufreq on Samsung SoC
-
-config ARM_S3C24XX_CPUFREQ
-	bool "CPUfreq driver for Samsung S3C24XX series CPUs (EXPERIMENTAL)"
-	depends on ARCH_S3C24XX
-	select ARM_S3C_CPUFREQ
-	help
-	  This enables the CPUfreq driver for the Samsung S3C24XX family
-	  of CPUs.
-
-	  For details, take a look at <file:Documentation/cpu-freq>.
-
-	  If in doubt, say N.
-
-config ARM_S3C24XX_CPUFREQ_DEBUG
-	bool "Debug CPUfreq Samsung driver core"
-	depends on ARM_S3C24XX_CPUFREQ
-	help
-	  Enable s3c_freq_dbg for the Samsung S3C CPUfreq core
-
-config ARM_S3C24XX_CPUFREQ_IODEBUG
-	bool "Debug CPUfreq Samsung driver IO timing"
-	depends on ARM_S3C24XX_CPUFREQ
-	help
-	  Enable s3c_freq_iodbg for the Samsung S3C CPUfreq core
-
-config ARM_S3C24XX_CPUFREQ_DEBUGFS
-	bool "Export debugfs for CPUFreq"
-	depends on ARM_S3C24XX_CPUFREQ && DEBUG_FS
-	help
-	  Export status information via debugfs.
-
-config ARM_S3C2410_CPUFREQ
-	bool
-	depends on ARM_S3C24XX_CPUFREQ && CPU_S3C2410
-	help
-	  CPU Frequency scaling support for S3C2410
-
-config ARM_S3C2412_CPUFREQ
-	bool
-	depends on ARM_S3C24XX_CPUFREQ && CPU_S3C2412
-	default y
-	select S3C2412_IOTIMING
-	help
-	  CPU Frequency scaling support for S3C2412 and S3C2413 SoC CPUs.
-
-config ARM_S3C2416_CPUFREQ
-	bool "S3C2416 CPU Frequency scaling support"
-	depends on CPU_S3C2416
-	help
-	  This adds the CPUFreq driver for the Samsung S3C2416 and
-	  S3C2450 SoC. The S3C2416 supports changing the rate of the
-	  armdiv clock source and also entering a so called dynamic
-	  voltage scaling mode in which it is possible to reduce the
-	  core voltage of the CPU.
-
-	  If in doubt, say N.
-
-config ARM_S3C2416_CPUFREQ_VCORESCALE
-	bool "Allow voltage scaling for S3C2416 arm core"
-	depends on ARM_S3C2416_CPUFREQ && REGULATOR
-	help
-	  Enable CPU voltage scaling when entering the dvs mode.
-	  It uses information gathered through existing hardware and
-	  tests but not documented in any datasheet.
-
-	  If in doubt, say N.
-
-config ARM_S3C2440_CPUFREQ
-	bool "S3C2440/S3C2442 CPU Frequency scaling support"
-	depends on ARM_S3C24XX_CPUFREQ && (CPU_S3C2440 || CPU_S3C2442)
-	default y
-	help
-	  CPU Frequency scaling support for S3C2440 and S3C2442 SoC CPUs.
-
 config ARM_S3C64XX_CPUFREQ
 	bool "Samsung S3C64XX"
 	depends on CPU_S3C6410
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 8de99b213146..692c16e4ee55 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -70,13 +70,7 @@ obj-$(CONFIG_PXA3xx)			+= pxa3xx-cpufreq.o
 obj-$(CONFIG_ARM_QCOM_CPUFREQ_HW)	+= qcom-cpufreq-hw.o
 obj-$(CONFIG_ARM_QCOM_CPUFREQ_NVMEM)	+= qcom-cpufreq-nvmem.o
 obj-$(CONFIG_ARM_RASPBERRYPI_CPUFREQ) 	+= raspberrypi-cpufreq.o
-obj-$(CONFIG_ARM_S3C2410_CPUFREQ)	+= s3c2410-cpufreq.o
-obj-$(CONFIG_ARM_S3C2412_CPUFREQ)	+= s3c2412-cpufreq.o
-obj-$(CONFIG_ARM_S3C2416_CPUFREQ)	+= s3c2416-cpufreq.o
-obj-$(CONFIG_ARM_S3C2440_CPUFREQ)	+= s3c2440-cpufreq.o
 obj-$(CONFIG_ARM_S3C64XX_CPUFREQ)	+= s3c64xx-cpufreq.o
-obj-$(CONFIG_ARM_S3C24XX_CPUFREQ)	+= s3c24xx-cpufreq.o
-obj-$(CONFIG_ARM_S3C24XX_CPUFREQ_DEBUGFS) += s3c24xx-cpufreq-debugfs.o
 obj-$(CONFIG_ARM_S5PV210_CPUFREQ)	+= s5pv210-cpufreq.o
 obj-$(CONFIG_ARM_SA1110_CPUFREQ)	+= sa1110-cpufreq.o
 obj-$(CONFIG_ARM_SCMI_CPUFREQ)		+= scmi-cpufreq.o
diff --git a/drivers/cpufreq/s3c2410-cpufreq.c b/drivers/cpufreq/s3c2410-cpufreq.c
deleted file mode 100644
index 5dcfbf0bfb74..000000000000
diff --git a/drivers/cpufreq/s3c2412-cpufreq.c b/drivers/cpufreq/s3c2412-cpufreq.c
deleted file mode 100644
index 5945945ead7c..000000000000
diff --git a/drivers/cpufreq/s3c2416-cpufreq.c b/drivers/cpufreq/s3c2416-cpufreq.c
deleted file mode 100644
index 5c221bc90210..000000000000
diff --git a/drivers/cpufreq/s3c2440-cpufreq.c b/drivers/cpufreq/s3c2440-cpufreq.c
deleted file mode 100644
index 2011fb9c03a4..000000000000
diff --git a/drivers/cpufreq/s3c24xx-cpufreq-debugfs.c b/drivers/cpufreq/s3c24xx-cpufreq-debugfs.c
deleted file mode 100644
index 93971dfe7c75..000000000000
diff --git a/drivers/cpufreq/s3c24xx-cpufreq.c b/drivers/cpufreq/s3c24xx-cpufreq.c
deleted file mode 100644
index 7380c32b238e..000000000000
diff --git a/include/linux/soc/samsung/s3c-cpufreq-core.h b/include/linux/soc/samsung/s3c-cpufreq-core.h
deleted file mode 100644
index 3b278afb769b..000000000000
-- 
2.29.2

