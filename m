Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E2262EAE9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 02:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240329AbiKRBaW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 17 Nov 2022 20:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbiKRBaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 20:30:13 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B92D13F26;
        Thu, 17 Nov 2022 17:30:12 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id A74C824E00D;
        Fri, 18 Nov 2022 09:06:31 +0800 (CST)
Received: from EXMBX072.cuchost.com (172.16.6.82) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 18 Nov
 2022 09:06:31 +0800
Received: from ubuntu.localdomain (183.27.96.116) by EXMBX072.cuchost.com
 (172.16.6.82) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 18 Nov
 2022 09:06:31 +0800
From:   Hal Feng <hal.feng@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 03/14] reset: Create subdirectory for StarFive drivers
Date:   Fri, 18 Nov 2022 09:06:16 +0800
Message-ID: <20221118010627.70576-4-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118010627.70576-1-hal.feng@starfivetech.com>
References: <20221118010627.70576-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.96.116]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX072.cuchost.com
 (172.16.6.82)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emil Renner Berthing <kernel@esmil.dk>

This moves the StarFive JH7100 reset driver to a new subdirectory in
preparation for adding more StarFive reset drivers.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 MAINTAINERS                                          | 4 ++--
 drivers/reset/Kconfig                                | 8 +-------
 drivers/reset/Makefile                               | 2 +-
 drivers/reset/starfive/Kconfig                       | 8 ++++++++
 drivers/reset/starfive/Makefile                      | 2 ++
 drivers/reset/{ => starfive}/reset-starfive-jh7100.c | 0
 6 files changed, 14 insertions(+), 10 deletions(-)
 create mode 100644 drivers/reset/starfive/Kconfig
 create mode 100644 drivers/reset/starfive/Makefile
 rename drivers/reset/{ => starfive}/reset-starfive-jh7100.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index d43daa89d5f1..e6f1060e7964 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19613,11 +19613,11 @@ F:	Documentation/devicetree/bindings/pinctrl/starfive,jh7100-pinctrl.yaml
 F:	drivers/pinctrl/starfive/
 F:	include/dt-bindings/pinctrl/pinctrl-starfive-jh7100.h
 
-STARFIVE JH7100 RESET CONTROLLER DRIVER
+STARFIVE JH7100 RESET CONTROLLER DRIVERS
 M:	Emil Renner Berthing <kernel@esmil.dk>
 S:	Maintained
 F:	Documentation/devicetree/bindings/reset/starfive,jh7100-reset.yaml
-F:	drivers/reset/reset-starfive-jh7100.c
+F:	drivers/reset/starfive/
 F:	include/dt-bindings/reset/starfive-jh7100.h
 
 STATIC BRANCH/CALL
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index de176c2fbad9..1e8e1c4954cd 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -232,13 +232,6 @@ config RESET_SOCFPGA
 	  This enables the reset driver for the SoCFPGA ARMv7 platforms. This
 	  driver gets initialized early during platform init calls.
 
-config RESET_STARFIVE_JH7100
-	bool "StarFive JH7100 Reset Driver"
-	depends on SOC_STARFIVE || COMPILE_TEST
-	default SOC_STARFIVE
-	help
-	  This enables the reset controller driver for the StarFive JH7100 SoC.
-
 config RESET_SUNPLUS
 	bool "Sunplus SoCs Reset Driver" if COMPILE_TEST
 	default ARCH_SUNPLUS
@@ -320,6 +313,7 @@ config RESET_ZYNQ
 	help
 	  This enables the reset controller driver for Xilinx Zynq SoCs.
 
+source "drivers/reset/starfive/Kconfig"
 source "drivers/reset/sti/Kconfig"
 source "drivers/reset/hisilicon/Kconfig"
 source "drivers/reset/tegra/Kconfig"
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 3e7e5fd633a8..fee17a0e3a16 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y += core.o
 obj-y += hisilicon/
+obj-$(CONFIG_SOC_STARFIVE) += starfive/
 obj-$(CONFIG_ARCH_STI) += sti/
 obj-$(CONFIG_ARCH_TEGRA) += tegra/
 obj-$(CONFIG_RESET_A10SR) += reset-a10sr.o
@@ -30,7 +31,6 @@ obj-$(CONFIG_RESET_RZG2L_USBPHY_CTRL) += reset-rzg2l-usbphy-ctrl.o
 obj-$(CONFIG_RESET_SCMI) += reset-scmi.o
 obj-$(CONFIG_RESET_SIMPLE) += reset-simple.o
 obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
-obj-$(CONFIG_RESET_STARFIVE_JH7100) += reset-starfive-jh7100.o
 obj-$(CONFIG_RESET_SUNPLUS) += reset-sunplus.o
 obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
 obj-$(CONFIG_RESET_TI_SCI) += reset-ti-sci.o
diff --git a/drivers/reset/starfive/Kconfig b/drivers/reset/starfive/Kconfig
new file mode 100644
index 000000000000..cddebdba7177
--- /dev/null
+++ b/drivers/reset/starfive/Kconfig
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config RESET_STARFIVE_JH7100
+	bool "StarFive JH7100 Reset Driver"
+	depends on SOC_STARFIVE || COMPILE_TEST
+	default SOC_STARFIVE
+	help
+	  This enables the reset controller driver for the StarFive JH7100 SoC.
diff --git a/drivers/reset/starfive/Makefile b/drivers/reset/starfive/Makefile
new file mode 100644
index 000000000000..670d049423f5
--- /dev/null
+++ b/drivers/reset/starfive/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_RESET_STARFIVE_JH7100)		+= reset-starfive-jh7100.o
diff --git a/drivers/reset/reset-starfive-jh7100.c b/drivers/reset/starfive/reset-starfive-jh7100.c
similarity index 100%
rename from drivers/reset/reset-starfive-jh7100.c
rename to drivers/reset/starfive/reset-starfive-jh7100.c
-- 
2.38.1

