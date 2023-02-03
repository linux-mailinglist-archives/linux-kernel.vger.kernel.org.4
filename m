Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED9068920E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 09:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbjBCIVc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 3 Feb 2023 03:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbjBCIVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 03:21:09 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52A22822D;
        Fri,  3 Feb 2023 00:19:40 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 86E4024E1D4;
        Fri,  3 Feb 2023 16:19:15 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 3 Feb
 2023 16:19:15 +0800
Received: from williamqiu-virtual-machine.starfivetech.com (171.223.208.138)
 by EXMBX168.cuchost.com (172.16.6.78) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Fri, 3 Feb 2023 16:19:14 +0800
From:   William Qiu <william.qiu@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        William Qiu <william.qiu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/3] dt-bindings: mmc: Add StarFive MMC module
Date:   Fri, 3 Feb 2023 16:19:11 +0800
Message-ID: <20230203081913.81968-2-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230203081913.81968-1-william.qiu@starfivetech.com>
References: <20230203081913.81968-1-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe StarFive designware mobile storage
host controller driver.

Signed-off-by: William Qiu <william.qiu@starfivetech.com>
---
 .../bindings/mmc/starfive,jh7110-mmc.yaml     | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml

diff --git a/Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml b/Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml
new file mode 100644
index 000000000000..deacf8e9cfb2
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/starfive,jh7110-mmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive Designware Mobile Storage Host Controller
+
+description:
+  StarFive uses the Synopsys designware mobile storage host controller
+  to interface a SoC with storage medium such as eMMC or SD/MMC cards.
+
+allOf:
+  - $ref: synopsys-dw-mshc-common.yaml#
+
+maintainers:
+  - William Qiu <william.qiu@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jh7110-mmc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: biu clock
+      - description: ciu clock
+
+  clock-names:
+    items:
+      - const: biu
+      - const: ciu
+
+  interrupts:
+    maxItems: 1
+
+  starfive,sysreg:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to System Register Controller syscon node
+          - description: offset of SYS_SYSCONSAIF__SYSCFG register for MMC controller
+          - description: shift of SYS_SYSCONSAIF__SYSCFG register for MMC controller
+          - description: mask of SYS_SYSCONSAIF__SYSCFG register for MMC controller
+    description:
+      Should be four parameters, the phandle to System Register Controller
+      syscon node and the offset/shift/mask of SYS_SYSCONSAIF__SYSCFG register
+      for MMC controller.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - starfive,sysreg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mmc@16010000 {
+        compatible = "starfive,jh7110-mmc";
+        reg = <0x16010000 0x10000>;
+        clocks = <&syscrg 91>,
+                 <&syscrg 93>;
+        clock-names = "biu","ciu";
+        resets = <&syscrg 64>;
+        reset-names = "reset";
+        interrupts = <74>;
+        fifo-depth = <32>;
+        fifo-watermark-aligned;
+        data-addr = <0>;
+        starfive,sysreg = <&sysreg 0x14 0x1a 0x7c000000>;
+    };
-- 
2.34.1

