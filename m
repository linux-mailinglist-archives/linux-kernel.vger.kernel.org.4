Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081BF64B11D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 09:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbiLMI0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 03:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234763AbiLMIZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 03:25:13 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3930013DF1;
        Tue, 13 Dec 2022 00:25:09 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 13 Dec 2022 17:25:05 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 78BC52058442;
        Tue, 13 Dec 2022 17:25:05 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 13 Dec 2022 17:25:05 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 1F568A855C;
        Tue, 13 Dec 2022 17:25:05 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 12/17] dt-bindings: soc: socionext: Add UniPhier peripheral block
Date:   Tue, 13 Dec 2022 17:24:44 +0900
Message-Id: <20221213082449.2721-13-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221213082449.2721-1-hayashi.kunihiko@socionext.com>
References: <20221213082449.2721-1-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding schema for the peripheral block implemented on
Socionext Uniphier SoCs.

Peripheral block implemented on Socionext UniPhier SoCs is an integrated
component of the peripherals including UART, I2C/FI2C, and SCSSI.

Peripheral block has some function logics to control the component.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../socionext,uniphier-perictrl.yaml          | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-perictrl.yaml

diff --git a/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-perictrl.yaml b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-perictrl.yaml
new file mode 100644
index 000000000000..0adcffe859ab
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-perictrl.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/socionext/socionext,uniphier-perictrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Socionext UniPhier peripheral block controller
+
+maintainers:
+  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+
+description: |+
+  Peripheral block implemented on Socionext UniPhier SoCs is an integrated
+  component of the peripherals including UART, I2C/FI2C, and SCSSI.
+  Peripheral block controller is a logic to control the component.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - socionext,uniphier-ld4-perictrl
+          - socionext,uniphier-pro4-perictrl
+          - socionext,uniphier-pro5-perictrl
+          - socionext,uniphier-pxs2-perictrl
+          - socionext,uniphier-sld8-perictrl
+          - socionext,uniphier-ld11-perictrl
+          - socionext,uniphier-ld20-perictrl
+          - socionext,uniphier-pxs3-perictrl
+          - socionext,uniphier-nx1-perictrl
+      - const: simple-mfd
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  clock-controller:
+    $ref: /schemas/clock/socionext,uniphier-clock.yaml#
+
+  reset-controller:
+    $ref: /schemas/reset/socionext,uniphier-reset.yaml#
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    syscon@59820000 {
+        compatible = "socionext,uniphier-ld20-perictrl",
+                     "simple-mfd", "syscon";
+        reg = <0x59820000 0x200>;
+
+        clock-controller {
+            compatible = "socionext,uniphier-ld20-peri-clock";
+            #clock-cells = <1>;
+        };
+
+        reset-controller {
+            compatible = "socionext,uniphier-ld20-peri-reset";
+            #reset-cells = <1>;
+        };
+    };
-- 
2.25.1

