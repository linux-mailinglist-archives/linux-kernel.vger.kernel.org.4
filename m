Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6880E650975
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 10:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbiLSJm7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 19 Dec 2022 04:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiLSJmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 04:42:46 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AFA959C;
        Mon, 19 Dec 2022 01:42:43 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 9324C24E137;
        Mon, 19 Dec 2022 17:42:40 +0800 (CST)
Received: from EXMBX161.cuchost.com (172.16.6.71) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 19 Dec
 2022 17:42:40 +0800
Received: from localhost.localdomain (183.27.97.120) by EXMBX161.cuchost.com
 (172.16.6.71) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 19 Dec
 2022 17:42:39 +0800
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        Samin Guo <samin.guo@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: watchdog: Add watchdog for StarFive JH7110
Date:   Mon, 19 Dec 2022 17:42:31 +0800
Message-ID: <20221219094233.179153-2-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221219094233.179153-1-xingyu.wu@starfivetech.com>
References: <20221219094233.179153-1-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.97.120]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX161.cuchost.com
 (172.16.6.71)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings to describe the watchdog for the StarFive JH7110 SoC.

Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 .../watchdog/starfive,jh7110-wdt.yaml         | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/starfive,jh7110-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/starfive,jh7110-wdt.yaml b/Documentation/devicetree/bindings/watchdog/starfive,jh7110-wdt.yaml
new file mode 100644
index 000000000000..a7bfe0751928
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/starfive,jh7110-wdt.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/starfive,jh7110-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive Watchdog
+
+maintainers:
+  - Samin Guo <samin.guo@starfivetech.com>
+  - Xingyu Wu <xingyu.wu@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jh7110-wdt
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: APB clock
+      - description: Core clock
+
+  clock-names:
+    items:
+      - const: apb
+      - const: core
+
+  resets:
+    items:
+      - description: APB reset
+      - description: Core reset
+
+  reset-names:
+    items:
+      - const: apb
+      - const: core
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+
+additionalProperties: false
+
+examples:
+  - |
+    watchdog@13070000 {
+        compatible = "starfive,jh7110-wdt";
+        reg = <0x13070000 0x10000>;
+        clocks = <&clk 122>,
+                 <&clk 123>;
+        clock-names = "apb", "core";
+        resets = <&rst 109>,
+                 <&rst 110>;
+        reset-names = "apb", "core";
+    };
-- 
2.25.1

