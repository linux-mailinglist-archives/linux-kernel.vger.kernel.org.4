Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39F0654EDD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 10:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiLWJyg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Dec 2022 04:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236235AbiLWJyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 04:54:06 -0500
Received: from ex01.ufhost.com (unknown [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892DC37F9F;
        Fri, 23 Dec 2022 01:48:19 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id BCEEE24E2A1;
        Fri, 23 Dec 2022 17:48:03 +0800 (CST)
Received: from EXMBX161.cuchost.com (172.16.6.71) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 23 Dec
 2022 17:48:03 +0800
Received: from localhost.localdomain (183.27.97.120) by EXMBX161.cuchost.com
 (172.16.6.71) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 23 Dec
 2022 17:48:02 +0800
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        Samin Guo <samin.guo@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/3] dt-bindings: timer: Add timer for StarFive JH7110 SoC
Date:   Fri, 23 Dec 2022 17:47:59 +0800
Message-ID: <20221223094801.181315-2-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221223094801.181315-1-xingyu.wu@starfivetech.com>
References: <20221223094801.181315-1-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.97.120]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX161.cuchost.com
 (172.16.6.71)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the timer on the JH7110
RISC-V SoC by StarFive Technology Ltd.

Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 .../timer/starfive,jh7110-timers.yaml         | 105 ++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/starfive,jh7110-timers.yaml

diff --git a/Documentation/devicetree/bindings/timer/starfive,jh7110-timers.yaml b/Documentation/devicetree/bindings/timer/starfive,jh7110-timers.yaml
new file mode 100644
index 000000000000..fe58dc056313
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/starfive,jh7110-timers.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/starfive,jh7110-timers.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive Timers
+
+maintainers:
+  - Samin Guo <samin.guo@starfivetech.com>
+  - Xingyu Wu <xingyu.wu@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jh7110-timers
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: timer channel 0 interrupt
+      - description: timer channel 1 interrupt
+      - description: timer channel 2 interrupt
+      - description: timer channel 3 interrupt
+
+  interrupt-names:
+    items:
+      - const: timer0
+      - const: timer1
+      - const: timer2
+      - const: timer3
+
+  clocks:
+    items:
+      - description: timer channel 0 clock
+      - description: timer channel 1 clock
+      - description: timer channel 2 clock
+      - description: timer channel 3 clock
+      - description: APB clock
+
+  clock-names:
+    items:
+      - const: timer0
+      - const: timer1
+      - const: timer2
+      - const: timer3
+      - const: apb
+
+  resets:
+    items:
+      - description: timer channel 0 reset
+      - description: timer channel 1 reset
+      - description: timer channel 2 reset
+      - description: timer channel 3 reset
+      - description: APB reset
+
+  reset-names:
+    items:
+      - const: timer0
+      - const: timer1
+      - const: timer2
+      - const: timer3
+      - const: apb
+
+  clock-frequency:
+    description: The frequency of the clock that drives the counter, in Hz.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - clock-frequency
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    timer@13050000 {
+        compatible = "starfive,jh7110-timers";
+        reg = <0x13050000 0x10000>;
+        interrupts = <69>, <70>, <71> ,<72>;
+        interrupt-names = "timer0", "timer1", "timer2", "timer3";
+        clocks = <&clk 125>,
+                 <&clk 126>,
+                 <&clk 127>,
+                 <&clk 128>,
+                 <&clk 124>;
+        clock-names = "timer0", "timer1",
+                      "timer2", "timer3", "apb";
+        resets = <&rst 118>,
+                 <&rst 119>,
+                 <&rst 120>,
+                 <&rst 121>,
+                 <&rst 117>;
+        reset-names = "timer0", "timer1",
+                      "timer2", "timer3", "apb";
+        clock-frequency = <24000000>;
+    };
+
-- 
2.25.1

