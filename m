Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EE86A4318
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 14:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjB0Nlg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Feb 2023 08:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjB0Nlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 08:41:32 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C24B83FA;
        Mon, 27 Feb 2023 05:41:31 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 172F324E1AB;
        Mon, 27 Feb 2023 21:41:30 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 27 Feb
 2023 21:41:29 +0800
Received: from ubuntu.localdomain (113.72.145.171) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 27 Feb
 2023 21:41:28 +0800
From:   Hal Feng <hal.feng@starfivetech.com>
To:     <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Samin Guo <samin.guo@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 1/2] dt-bindings: hwmon: Add starfive,jh71x0-temp
Date:   Mon, 27 Feb 2023 21:41:24 +0800
Message-ID: <20230227134125.120638-2-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230227134125.120638-1-hal.feng@starfivetech.com>
References: <20230227134125.120638-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.145.171]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emil Renner Berthing <kernel@esmil.dk>

Add bindings for the temperature sensor on the StarFive JH7100 and
JH7110 SoCs.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/hwmon/starfive,jh71x0-temp.yaml  | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/starfive,jh71x0-temp.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/starfive,jh71x0-temp.yaml b/Documentation/devicetree/bindings/hwmon/starfive,jh71x0-temp.yaml
new file mode 100644
index 000000000000..f5b34528928d
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/starfive,jh71x0-temp.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/starfive,jh71x0-temp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH71x0 Temperature Sensor
+
+maintainers:
+  - Emil Renner Berthing <kernel@esmil.dk>
+
+description: |
+  StarFive Technology Co. JH71x0 embedded temperature sensor
+
+properties:
+  compatible:
+    enum:
+      - starfive,jh7100-temp
+      - starfive,jh7110-temp
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 2
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: "sense"
+      - const: "bus"
+
+  '#thermal-sensor-cells':
+    const: 0
+
+  resets:
+    minItems: 2
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: "sense"
+      - const: "bus"
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
+    #include <dt-bindings/clock/starfive-jh7100.h>
+    #include <dt-bindings/reset/starfive-jh7100.h>
+
+    temperature-sensor@124a0000 {
+        compatible = "starfive,jh7100-temp";
+        reg = <0x124a0000 0x10000>;
+        clocks = <&clkgen JH7100_CLK_TEMP_SENSE>,
+                 <&clkgen JH7100_CLK_TEMP_APB>;
+        clock-names = "sense", "bus";
+        #thermal-sensor-cells = <0>;
+        resets = <&rstgen JH7100_RSTN_TEMP_SENSE>,
+                 <&rstgen JH7100_RSTN_TEMP_APB>;
+        reset-names = "sense", "bus";
+    };
-- 
2.38.1

