Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E1574670C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 04:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjGDCCr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 Jul 2023 22:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjGDCCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 22:02:46 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AB0E64;
        Mon,  3 Jul 2023 19:02:44 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 5591024E26B;
        Tue,  4 Jul 2023 10:02:43 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 4 Jul
 2023 10:02:43 +0800
Received: from localhost.localdomain (113.72.144.31) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 4 Jul
 2023 10:02:42 +0800
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        "William Qiu" <william.qiu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v6 2/7] dt-bindings: soc: starfive: Add StarFive syscon module
Date:   Tue, 4 Jul 2023 10:02:34 +0800
Message-ID: <20230704020239.288500-3-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230704020239.288500-1-xingyu.wu@starfivetech.com>
References: <20230704020239.288500-1-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.144.31]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: William Qiu <william.qiu@starfivetech.com>

Add documentation to describe StarFive System Controller Registers.

Co-developed-by: Xingyu Wu <xingyu.wu@starfivetech.com>
Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
Signed-off-by: William Qiu <william.qiu@starfivetech.com>
---
 .../soc/starfive/starfive,jh7110-syscon.yaml  | 93 +++++++++++++++++++
 MAINTAINERS                                   |  7 ++
 2 files changed, 100 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml

diff --git a/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
new file mode 100644
index 000000000000..b30383eab32c
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/starfive/starfive,jh7110-syscon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH7110 SoC system controller
+
+maintainers:
+  - William Qiu <william.qiu@starfivetech.com>
+
+description:
+  The StarFive JH7110 SoC system controller provides register information such
+  as offset, mask and shift to configure related modules such as MMC and PCIe.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: starfive,jh7110-sys-syscon
+          - const: syscon
+          - const: simple-mfd
+      - items:
+          - enum:
+              - starfive,jh7110-aon-syscon
+              - starfive,jh7110-stg-syscon
+          - const: syscon
+
+  reg:
+    maxItems: 1
+
+  clock-controller:
+    $ref: /schemas/clock/starfive,jh7110-pll.yaml#
+    type: object
+
+  "#power-domain-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: starfive,jh7110-sys-syscon
+    then:
+      required:
+        - clock-controller
+    else:
+      properties:
+        clock-controller: false
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: starfive,jh7110-aon-syscon
+    then:
+      required:
+        - "#power-domain-cells"
+    else:
+      properties:
+        "#power-domain-cells": false
+
+additionalProperties: false
+
+examples:
+  - |
+    syscon@10240000 {
+        compatible = "starfive,jh7110-stg-syscon", "syscon";
+        reg = <0x10240000 0x1000>;
+    };
+
+    syscon@13030000 {
+        compatible = "starfive,jh7110-sys-syscon", "syscon", "simple-mfd";
+        reg = <0x0 0x13030000 0x0 0x1000>;
+
+        clock-controller {
+            compatible = "starfive,jh7110-pll";
+            clocks = <&osc>;
+            #clock-cells = <1>;
+        };
+    };
+
+    syscon@17010000 {
+        compatible = "starfive,jh7110-aon-syscon", "syscon";
+        reg = <0x0 0x17010000 0x0 0x1000>;
+        #power-domain-cells = <1>;
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 35e19594640d..58ba04bd0bc8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20127,6 +20127,12 @@ S:	Supported
 F:	Documentation/devicetree/bindings/mmc/starfive*
 F:	drivers/mmc/host/dw_mmc-starfive.c
 
+STARFIVE JH7110 SYSCON
+M:	William Qiu <william.qiu@starfivetech.com>
+M:	Xingyu Wu <xingyu.wu@starfivetech.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
+
 STARFIVE JH71X0 CLOCK DRIVERS
 M:	Emil Renner Berthing <kernel@esmil.dk>
 M:	Hal Feng <hal.feng@starfivetech.com>
@@ -20164,6 +20170,7 @@ STARFIVE SOC DRIVERS
 M:	Conor Dooley <conor@kernel.org>
 S:	Maintained
 T:	git https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/
+F:	Documentation/devicetree/bindings/soc/starfive/
 F:	drivers/soc/starfive/
 
 STARFIVE TRNG DRIVER
-- 
2.25.1

