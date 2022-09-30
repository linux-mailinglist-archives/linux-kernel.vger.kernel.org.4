Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858025F0461
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 07:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiI3F46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 01:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiI3F4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 01:56:49 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D004E16DDCB;
        Thu, 29 Sep 2022 22:56:45 -0700 (PDT)
X-QQ-mid: bizesmtp89t1664517395tl46psyh
Received: from ubuntu.localdomain ( [113.72.146.201])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Sep 2022 13:56:33 +0800 (CST)
X-QQ-SSF: 01000000000000305000000A0000000
X-QQ-FEAT: bQsUcYFpAAbYh5IE5ZQJa21f+7RzMKXkTWoGjOTn9RYsMgEYDgMtGTVoiYE0X
        950t0angog4i0EbjIImNUPmJSYyEjYeqTDfjglx1tBLSGnLqME7PIvImRR9KhNW961IXGUT
        A6wJDFItRdELl+XBJQbrMy09GJf+hc45Hbb+kvLJuSuoTaElzuojk8hhGzO/ssgHQexgBM9
        SXcvfyvAYFMiiUP0CeRJIMwXonhn1a1U6F4r+79b7YHnIAu1XO2/Xl/8z7t9OqtJUtDdqTH
        y8iVVk+Qokja6Vojt3dqGGaHKYr1LPgIXQBYFyt4eYivjul2LpLK5In5s1OxsD+cI+Bgb4R
        FZ3yRuVJyFRhfYvDIyIgsoLX78xR5chr11v7/YuBjfPa4XSkOfFZgAFMSNYemIc/NZaCFML
        /t8NBeRSD5WLFEhW1CYz1w==
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
Subject: [PATCH v1 20/30] dt-bindings: clock: Add starfive,jh7110-clkgen-aon bindings
Date:   Fri, 30 Sep 2022 13:56:32 +0800
Message-Id: <20220930055632.5136-1-hal.feng@linux.starfivetech.com>
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

From: Emil Renner Berthing <kernel@esmil.dk>

Add bindings for the always-on clock generator on the JH7110
RISC-V SoC by StarFive Technology Ltd.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
---
 .../clock/starfive,jh7110-clkgen-aon.yaml     | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-clkgen-aon.yaml

diff --git a/Documentation/devicetree/bindings/clock/starfive,jh7110-clkgen-aon.yaml b/Documentation/devicetree/bindings/clock/starfive,jh7110-clkgen-aon.yaml
new file mode 100644
index 000000000000..029ff57b9e3e
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/starfive,jh7110-clkgen-aon.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/starfive,jh7110-clkgen-aon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH7110 Always-On Clock Generator
+
+maintainers:
+  - Emil Renner Berthing <kernel@esmil.dk>
+  - Xingyu Wu <xingyu.wu@linux.starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jh7110-clkgen-aon
+
+  clocks:
+    items:
+      - description: Main Oscillator
+      - description: RTC clock
+      - description: RMII reference clock
+      - description: RGMII RX clock
+      - description: STG AXI/AHB clock
+      - description: APB Bus clock
+
+  clock-names:
+    items:
+      - const: osc
+      - const: clk_rtc
+      - const: gmac0_rmii_refin
+      - const: gmac0_rgmii_rxin
+      - const: stg_axiahb
+      - const: apb_bus_func
+
+  '#clock-cells':
+    const: 1
+    description:
+      See <dt-bindings/clock/starfive-jh7110-aon.h> for valid indices.
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/starfive-jh7110-sys.h>
+
+    aoncrg: clock-controller@17000000 {
+        compatible = "starfive,jh7110-aoncrg";
+        clocks = <&osc>, <&clk_rtc>,
+                 <&gmac0_rmii_refin>, <&gmac0_rgmii_rxin>,
+                 <&syscrg JH7110_SYSCLK_STG_AXIAHB>,
+                 <&syscrg JH7110_SYSCLK_APB_BUS_FUNC>;
+        clock-names = "osc", "clk_rtc",
+                      "gmac0_rmii_refin", "gmac0_rgmii_rxin",
+                      "stg_axiahb", "apb_bus_func";
+        #clock-cells = <1>;
+    };
-- 
2.17.1

