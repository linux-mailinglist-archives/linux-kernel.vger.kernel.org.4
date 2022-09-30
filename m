Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9FA5F04A0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 08:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiI3GO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 02:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiI3GOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 02:14:21 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEFA110B1D;
        Thu, 29 Sep 2022 23:14:17 -0700 (PDT)
X-QQ-mid: bizesmtp84t1664518447t5nbwklp
Received: from ubuntu.localdomain ( [113.72.146.201])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Sep 2022 14:14:05 +0800 (CST)
X-QQ-SSF: 01000000000000305000000A0000000
X-QQ-FEAT: /6HprbRdZNmmKnhc/OIjuYalvxt80YyvkW0RSScpmHj1x5NDZp5mG4ufRVjgT
        CKfOfzBYh1Sqhw2AKMFwo3AMv5GTNHjJigy3k+T0i9oiEMxCHv0ZQtMRONsYfG/5G9BHPb3
        LBIAVIjpLZmdlHKQ+gtZIBi7igNP3IniMCCtDgWd48Nd9cIvMzUicmUxP2fbEI+QGluQwMQ
        98yRPgv1VyAcU/LEjXPwJFupP11fCHy7qE0vqnCKxC+ekwiLGiVEqoIXTPj32EiePYUo676
        OsG1Sz4FU/OHnUuQxARyjadHZiaD7XaY/qam8SafNQuyA3mtId5hF3/Vg3NiO0WiJmq8v8u
        c/Pot5NamA5fW2+HdE3zhFE0xAg+xqS8ri4P3FaQA0H5Lmi3shprZeQ7nJi03oRHbFlPbZv
        iISNL3Oy7pg=
X-QQ-GoodBg: 0
From:   Hal Feng <hal.feng@linux.starfivetech.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@linux.starfivetech.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 23/30] pinctrl: starfive: Rename "pinctrl-starfive" to "pinctrl-starfive-jh7100"
Date:   Fri, 30 Sep 2022 14:14:04 +0800
Message-Id: <20220930061404.5418-1-hal.feng@linux.starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:linux.starfivetech.com:qybglogicsvr:qybglogicsvr2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jianlong Huang <jianlong.huang@starfivetech.com>

Add the SoC name to make it more clear. Also the next generation StarFive
SoCs will use "pinctrl-starfive" as the core of StarFive pinctrl driver.
No functional change.

Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
---
 .../bindings/pinctrl/starfive,jh7100-pinctrl.yaml           | 2 +-
 arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts   | 2 +-
 drivers/pinctrl/starfive/Kconfig                            | 2 +-
 drivers/pinctrl/starfive/Makefile                           | 2 +-
 .../{pinctrl-starfive.c => pinctrl-starfive-jh7100.c}       | 2 +-
 .../{pinctrl-starfive.h => pinctrl-starfive-jh7100.h}       | 6 +++---
 6 files changed, 8 insertions(+), 8 deletions(-)
 rename drivers/pinctrl/starfive/{pinctrl-starfive.c => pinctrl-starfive-jh7100.c} (99%)
 rename include/dt-bindings/pinctrl/{pinctrl-starfive.h => pinctrl-starfive-jh7100.h} (98%)

diff --git a/Documentation/devicetree/bindings/pinctrl/starfive,jh7100-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/starfive,jh7100-pinctrl.yaml
index 92963604422f..a6140dddd39a 100644
--- a/Documentation/devicetree/bindings/pinctrl/starfive,jh7100-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/starfive,jh7100-pinctrl.yaml
@@ -165,7 +165,7 @@ examples:
   - |
     #include <dt-bindings/clock/starfive-jh7100.h>
     #include <dt-bindings/reset/starfive-jh7100.h>
-    #include <dt-bindings/pinctrl/pinctrl-starfive.h>
+    #include <dt-bindings/pinctrl/pinctrl-starfive-jh7100.h>
 
     soc {
         #address-cells = <2>;
diff --git a/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts b/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts
index c9af67f7a0d2..f7a230110512 100644
--- a/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts
+++ b/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts
@@ -8,7 +8,7 @@
 #include "jh7100.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/leds/common.h>
-#include <dt-bindings/pinctrl/pinctrl-starfive.h>
+#include <dt-bindings/pinctrl/pinctrl-starfive-jh7100.h>
 
 / {
 	model = "BeagleV Starlight Beta";
diff --git a/drivers/pinctrl/starfive/Kconfig b/drivers/pinctrl/starfive/Kconfig
index ed8c6a920886..5cedb546f93d 100644
--- a/drivers/pinctrl/starfive/Kconfig
+++ b/drivers/pinctrl/starfive/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-config PINCTRL_STARFIVE
+config PINCTRL_STARFIVE_JH7100
 	tristate "Pinctrl and GPIO driver for the StarFive JH7100 SoC"
 	depends on SOC_STARFIVE || COMPILE_TEST
 	depends on OF
diff --git a/drivers/pinctrl/starfive/Makefile b/drivers/pinctrl/starfive/Makefile
index 4c96e2f86292..0293f26a0a99 100644
--- a/drivers/pinctrl/starfive/Makefile
+++ b/drivers/pinctrl/starfive/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-$(CONFIG_PINCTRL_STARFIVE)	+= pinctrl-starfive.o
+obj-$(CONFIG_PINCTRL_STARFIVE_JH7100)	+= pinctrl-starfive-jh7100.o
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
similarity index 99%
rename from drivers/pinctrl/starfive/pinctrl-starfive.c
rename to drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
index 74a084740e8c..5b544fb7f3d8 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive.c
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
@@ -20,7 +20,7 @@
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
 
-#include <dt-bindings/pinctrl/pinctrl-starfive.h>
+#include <dt-bindings/pinctrl/pinctrl-starfive-jh7100.h>
 
 #include "../core.h"
 #include "../pinctrl-utils.h"
diff --git a/include/dt-bindings/pinctrl/pinctrl-starfive.h b/include/dt-bindings/pinctrl/pinctrl-starfive-jh7100.h
similarity index 98%
rename from include/dt-bindings/pinctrl/pinctrl-starfive.h
rename to include/dt-bindings/pinctrl/pinctrl-starfive-jh7100.h
index de4f75c2c9e8..a200f546d078 100644
--- a/include/dt-bindings/pinctrl/pinctrl-starfive.h
+++ b/include/dt-bindings/pinctrl/pinctrl-starfive-jh7100.h
@@ -3,8 +3,8 @@
  * Copyright (C) 2021 Emil Renner Berthing <kernel@esmil.dk>
  */
 
-#ifndef __DT_BINDINGS_PINCTRL_STARFIVE_H__
-#define __DT_BINDINGS_PINCTRL_STARFIVE_H__
+#ifndef __DT_BINDINGS_PINCTRL_STARFIVE_JH7100_H__
+#define __DT_BINDINGS_PINCTRL_STARFIVE_JH7100_H__
 
 #define PAD_GPIO_OFFSET		0
 #define PAD_FUNC_SHARE_OFFSET	64
@@ -272,4 +272,4 @@
 
 #define GPI_NONE				0xff
 
-#endif /* __DT_BINDINGS_PINCTRL_STARFIVE_H__ */
+#endif /* __DT_BINDINGS_PINCTRL_STARFIVE_JH7100_H__ */
-- 
2.17.1

