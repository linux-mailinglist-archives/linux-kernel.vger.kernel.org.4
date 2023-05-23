Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA14070DE21
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 15:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237065AbjEWNy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 09:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237016AbjEWNyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 09:54:11 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F388513E;
        Tue, 23 May 2023 06:54:08 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id DF3C75FD6A;
        Tue, 23 May 2023 16:54:05 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1684850045;
        bh=tBTHQtZLBVMM1xJ2CHesO19/Ord/PD+KOb5QmIbiZGc=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=Iu3ZpARXJ5Gpfml282g/bkOzMIZG5Bl8ymZNro6hGNbTlpl/UD8JotFLG/+JMZjLt
         y2eS+LDjt/vqWLDwn9UAVwmh5t0kYuawlQaSpsclD8NCuxoPAguMT38j1d+RMrUNZA
         v5O+shzd6QqH1p0WkeOaRs78lpx+lVNuC63yU1jnaK5+30elSpNF3pJ9XfKL3VGcVS
         FkLZZnGajS0cxTqBmtpzCqQs3QzJI3Tl1H+S54uizwFXZGsKIJSe/vE/1jrjby278U
         3aeuedhmlX1YEnoKjtRW0YRkNNuZXHD5V2BQ9I96XuwCFBBJHnD82W1LsX+e9rhN54
         TgUwZ/pyMWXXw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue, 23 May 2023 16:54:05 +0300 (MSK)
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <khilman@baylibre.com>, <martin.blumenstingl@googlemail.com>
CC:     <jian.hu@amlogic.com>, <kernel@sberdevices.ru>,
        <rockosov@gmail.com>, <linux-amlogic@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: [PATCH v16 5/6] dt-bindings: clock: meson: add A1 Peripherals clock controller bindings
Date:   Tue, 23 May 2023 16:53:50 +0300
Message-ID: <20230523135351.19133-6-ddrokosov@sberdevices.ru>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20230523135351.19133-1-ddrokosov@sberdevices.ru>
References: <20230523135351.19133-1-ddrokosov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/23 12:15:00 #21372692
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation and dt bindings for the Amlogic A1 Peripherals clock
controller.
A1 PLL clock controller has references to A1 Peripherals clock
controller objects, so reflect them in the schema.

Signed-off-by: Jian Hu <jian.hu@amlogic.com>
Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
 .../clock/amlogic,a1-peripherals-clkc.yaml    |  73 +++++++++++
 .../bindings/clock/amlogic,a1-pll-clkc.yaml   |   5 +-
 .../clock/amlogic,a1-peripherals-clkc.h       | 115 ++++++++++++++++++
 3 files changed, 191 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-peripherals-clkc.yaml
 create mode 100644 include/dt-bindings/clock/amlogic,a1-peripherals-clkc.h

diff --git a/Documentation/devicetree/bindings/clock/amlogic,a1-peripherals-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a1-peripherals-clkc.yaml
new file mode 100644
index 000000000000..6d84cee1bd75
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/amlogic,a1-peripherals-clkc.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/amlogic,a1-peripherals-clkc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic A1 Peripherals Clock Control Unit
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+  - Jerome Brunet <jbrunet@baylibre.com>
+  - Jian Hu <jian.hu@jian.hu.com>
+  - Dmitry Rokosov <ddrokosov@sberdevices.ru>
+
+properties:
+  compatible:
+    const: amlogic,a1-peripherals-clkc
+
+  '#clock-cells':
+    const: 1
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: input fixed pll div2
+      - description: input fixed pll div3
+      - description: input fixed pll div5
+      - description: input fixed pll div7
+      - description: input hifi pll
+      - description: input oscillator (usually at 24MHz)
+
+  clock-names:
+    items:
+      - const: fclk_div2
+      - const: fclk_div3
+      - const: fclk_div5
+      - const: fclk_div7
+      - const: hifi_pll
+      - const: xtal
+
+required:
+  - compatible
+  - '#clock-cells'
+  - reg
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/amlogic,a1-pll-clkc.h>
+    apb {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        clock-controller@800 {
+            compatible = "amlogic,a1-peripherals-clkc";
+            reg = <0 0x800 0 0x104>;
+            #clock-cells = <1>;
+            clocks = <&clkc_pll CLKID_FCLK_DIV2>,
+                     <&clkc_pll CLKID_FCLK_DIV3>,
+                     <&clkc_pll CLKID_FCLK_DIV5>,
+                     <&clkc_pll CLKID_FCLK_DIV7>,
+                     <&clkc_pll CLKID_HIFI_PLL>,
+                     <&xtal>;
+            clock-names = "fclk_div2", "fclk_div3",
+                          "fclk_div5", "fclk_div7",
+                          "hifi_pll", "xtal";
+        };
+    };
diff --git a/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
index 5c6fa620a63c..a59b188a8bf5 100644
--- a/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
+++ b/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
@@ -43,6 +43,7 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/clock/amlogic,a1-peripherals-clkc.h>
     apb {
         #address-cells = <2>;
         #size-cells = <2>;
@@ -51,8 +52,8 @@ examples:
             compatible = "amlogic,a1-pll-clkc";
             reg = <0 0x7c80 0 0x18c>;
             #clock-cells = <1>;
-            clocks = <&clkc_periphs_fixpll_in>,
-                     <&clkc_periphs_hifipll_in>;
+            clocks = <&clkc_periphs CLKID_FIXPLL_IN>,
+                     <&clkc_periphs CLKID_HIFIPLL_IN>;
             clock-names = "fixpll_in", "hifipll_in";
         };
     };
diff --git a/include/dt-bindings/clock/amlogic,a1-peripherals-clkc.h b/include/dt-bindings/clock/amlogic,a1-peripherals-clkc.h
new file mode 100644
index 000000000000..ff2730f398a6
--- /dev/null
+++ b/include/dt-bindings/clock/amlogic,a1-peripherals-clkc.h
@@ -0,0 +1,115 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
+ * Author: Jian Hu <jian.hu@amlogic.com>
+ *
+ * Copyright (c) 2023, SberDevices. All Rights Reserved.
+ * Author: Dmitry Rokosov <ddrokosov@sberdevices.ru>
+ */
+
+#ifndef __A1_PERIPHERALS_CLKC_H
+#define __A1_PERIPHERALS_CLKC_H
+
+#define CLKID_FIXPLL_IN		1
+#define CLKID_USB_PHY_IN	2
+#define CLKID_USB_CTRL_IN	3
+#define CLKID_HIFIPLL_IN	4
+#define CLKID_SYSPLL_IN		5
+#define CLKID_DDS_IN		6
+#define CLKID_SYS		7
+#define CLKID_CLKTREE		8
+#define CLKID_RESET_CTRL	9
+#define CLKID_ANALOG_CTRL	10
+#define CLKID_PWR_CTRL		11
+#define CLKID_PAD_CTRL		12
+#define CLKID_SYS_CTRL		13
+#define CLKID_TEMP_SENSOR	14
+#define CLKID_AM2AXI_DIV	15
+#define CLKID_SPICC_B		16
+#define CLKID_SPICC_A		17
+#define CLKID_MSR		18
+#define CLKID_AUDIO		19
+#define CLKID_JTAG_CTRL		20
+#define CLKID_SARADC_EN		21
+#define CLKID_PWM_EF		22
+#define CLKID_PWM_CD		23
+#define CLKID_PWM_AB		24
+#define CLKID_CEC		25
+#define CLKID_I2C_S		26
+#define CLKID_IR_CTRL		27
+#define CLKID_I2C_M_D		28
+#define CLKID_I2C_M_C		29
+#define CLKID_I2C_M_B		30
+#define CLKID_I2C_M_A		31
+#define CLKID_ACODEC		32
+#define CLKID_OTP		33
+#define CLKID_SD_EMMC_A		34
+#define CLKID_USB_PHY		35
+#define CLKID_USB_CTRL		36
+#define CLKID_SYS_DSPB		37
+#define CLKID_SYS_DSPA		38
+#define CLKID_DMA		39
+#define CLKID_IRQ_CTRL		40
+#define CLKID_NIC		41
+#define CLKID_GIC		42
+#define CLKID_UART_C		43
+#define CLKID_UART_B		44
+#define CLKID_UART_A		45
+#define CLKID_SYS_PSRAM		46
+#define CLKID_RSA		47
+#define CLKID_CORESIGHT		48
+#define CLKID_AM2AXI_VAD	49
+#define CLKID_AUDIO_VAD		50
+#define CLKID_AXI_DMC		51
+#define CLKID_AXI_PSRAM		52
+#define CLKID_RAMB		53
+#define CLKID_RAMA		54
+#define CLKID_AXI_SPIFC		55
+#define CLKID_AXI_NIC		56
+#define CLKID_AXI_DMA		57
+#define CLKID_CPU_CTRL		58
+#define CLKID_ROM		59
+#define CLKID_PROC_I2C		60
+#define CLKID_DSPA_EN		63
+#define CLKID_DSPA_EN_NIC	64
+#define CLKID_DSPB_EN		65
+#define CLKID_DSPB_EN_NIC	66
+#define CLKID_RTC		67
+#define CLKID_CECA_32K		68
+#define CLKID_CECB_32K		69
+#define CLKID_24M		70
+#define CLKID_12M		71
+#define CLKID_FCLK_DIV2_DIVN	72
+#define CLKID_GEN		73
+#define CLKID_SARADC		75
+#define CLKID_PWM_A		76
+#define CLKID_PWM_B		77
+#define CLKID_PWM_C		78
+#define CLKID_PWM_D		79
+#define CLKID_PWM_E		80
+#define CLKID_PWM_F		81
+#define CLKID_SPICC		82
+#define CLKID_TS		83
+#define CLKID_SPIFC		84
+#define CLKID_USB_BUS		85
+#define CLKID_SD_EMMC		86
+#define CLKID_PSRAM		87
+#define CLKID_DMC		88
+#define CLKID_DSPA_A_SEL	95
+#define CLKID_DSPA_B_SEL	98
+#define CLKID_DSPB_A_SEL	101
+#define CLKID_DSPB_B_SEL	104
+#define CLKID_CECB_32K_SEL_PRE	113
+#define CLKID_CECB_32K_SEL	114
+#define CLKID_CECA_32K_SEL_PRE	117
+#define CLKID_CECA_32K_SEL	118
+#define CLKID_GEN_SEL		121
+#define CLKID_PWM_A_SEL		124
+#define CLKID_PWM_B_SEL		126
+#define CLKID_PWM_C_SEL		128
+#define CLKID_PWM_D_SEL		130
+#define CLKID_PWM_E_SEL		132
+#define CLKID_PWM_F_SEL		134
+#define CLKID_SD_EMMC_SEL2	147
+
+#endif /* __A1_PERIPHERALS_CLKC_H */
-- 
2.36.0

