Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0DE5F0014
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 00:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiI2W1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 18:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiI2W1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 18:27:08 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA2A15E479;
        Thu, 29 Sep 2022 15:27:04 -0700 (PDT)
X-QQ-mid: bizesmtp88t1664490413t16ssqjp
Received: from localhost.localdomain ( [113.72.146.201])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Sep 2022 06:26:52 +0800 (CST)
X-QQ-SSF: 01000000002000305000B00A0000000
X-QQ-FEAT: YHTLUubWl26ZkpaLq7zsbw4d8O56YD7LwT0wcBWFjGJFdn4RvGt4in89BcWGS
        U6clL3z7tkZIWNwlFhVpyr0KfLiD+6L4Z0fsnaOfFw/ykvRIRzdXo9a4m3v4nLGj8OJ+6ro
        wYOvz1LQ7AuWSC/crvH5NIKCF1oDmolC74QTQNe7YX2te+tAYPeHVxX0X6boWdm+YILDCy5
        EGNDuwpkZufDYaJs308Z7yglt9m7hA1eOjXvVK4FqZBTPpaQbNJT9c1oSCt8c+h6GCZyVrs
        TC0oRjlfZonYAs86W/lahhg+ftUX496LzCyngeyGzZAyomv583Kz7NO4o/43WjLEUz53IWj
        W2nzW0C27gumiS9wusps+Y5af8OuauMG/u9rWp6ZGlkcSJoaLzFc94tbXu0W93b73GIXw4G
        n9xRBLJPbl/z4Lah4K4BeQ==
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
Subject: [PATCH v1 17/30] dt-bindings: clock: Add starfive,jh7110-clkgen-sys bindings
Date:   Fri, 30 Sep 2022 06:26:47 +0800
Message-Id: <20220929222647.23816-1-hal.feng@linux.starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:linux.starfivetech.com:qybglogicsvr:qybglogicsvr2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emil Renner Berthing <kernel@esmil.dk>

Add bindings for the system clock generator on the JH7110
RISC-V SoC by StarFive Technology Ltd.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
---
 .../clock/starfive,jh7110-clkgen-sys.yaml     | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-clkgen-sys.yaml

diff --git a/Documentation/devicetree/bindings/clock/starfive,jh7110-clkgen-sys.yaml b/Documentation/devicetree/bindings/clock/starfive,jh7110-clkgen-sys.yaml
new file mode 100644
index 000000000000..290b730145ab
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/starfive,jh7110-clkgen-sys.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/starfive,jh7110-clkgen-sys.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH7110 System Clock Generator
+
+maintainers:
+  - Emil Renner Berthing <kernel@esmil.dk>
+  - Xingyu Wu <xingyu.wu@linux.starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jh7110-clkgen-sys
+
+  clocks:
+    items:
+      - description: Main Oscillator (24 MHz)
+      - description: RMII reference clock
+      - description: RGMII RX clock
+      - description: I2S TX bit clock
+      - description: I2S TX left/right clock
+      - description: I2S RX bit clock
+      - description: I2S RX left/right clock
+      - description: TDM
+      - description: mclk
+
+  clock-names:
+    items:
+      - const: osc
+      - const: gmac1_rmii_refin
+      - const: gmac1_rgmii_rxin
+      - const: i2stx_bclk_ext
+      - const: i2stx_lrck_ext
+      - const: i2srx_bclk_ext
+      - const: i2srx_lrck_ext
+      - const: tdm_ext
+      - const: mclk_ext
+
+  '#clock-cells':
+    const: 1
+    description:
+      See <dt-bindings/clock/starfive-jh7110-sys.h> for valid indices.
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
+    syscrg_clk: clock-controller@13020000 {
+        compatible = "starfive,jh7110-clkgen-sys";
+        clocks = <&osc>, <&gmac1_rmii_refin>,
+                 <&gmac1_rgmii_rxin>,
+                 <&i2stx_bclk_ext>, <&i2stx_lrck_ext>,
+                 <&i2srx_bclk_ext>, <&i2srx_lrck_ext>,
+                 <&tdm_ext>, <&mclk_ext>;
+        clock-names = "osc", "gmac1_rmii_refin",
+                      "gmac1_rgmii_rxin",
+                      "i2stx_bclk_ext", "i2stx_lrck_ext",
+                      "i2srx_bclk_ext", "i2srx_lrck_ext",
+                      "tdm_ext", "mclk_ext";
+        #clock-cells = <1>;
+    };
-- 
2.17.1

