Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9947563BE0A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 11:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbiK2KfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 05:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbiK2KfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 05:35:18 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5786AB97;
        Tue, 29 Nov 2022 02:35:17 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 29 Nov 2022 19:35:17 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 1A6132059054;
        Tue, 29 Nov 2022 19:35:17 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 29 Nov 2022 19:35:17 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id A2F8CA8556;
        Tue, 29 Nov 2022 19:35:16 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 2/8] dt-bindings: soc: socionext: Add UniPhier SoC-glue logic
Date:   Tue, 29 Nov 2022 19:35:03 +0900
Message-Id: <20221129103509.9958-3-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221129103509.9958-1-hayashi.kunihiko@socionext.com>
References: <20221129103509.9958-1-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding schema for the SoC-glue logic implemented on
Socionext Uniphier SoCs.

This SoC-glue logic is a set of miscellaneous function registers
handling signals for specific devices outside system components,
and also has multiple functions such as I/O pinmux, usb-phy, debug,
clock-mux for a specific SoC, and so on.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../socionext,uniphier-soc-glue.yaml          | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue.yaml

diff --git a/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue.yaml b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue.yaml
new file mode 100644
index 000000000000..3f571e3e1339
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/socionext/socionext,uniphier-soc-glue.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Socionext UniPhier SoC-glue logic
+
+maintainers:
+  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+
+description: |+
+  SoC-glue logic implemented on Socionext UniPhier SoCs is a collection of
+  miscellaneous function registers handling signals outside system components.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - socionext,uniphier-ld4-soc-glue
+          - socionext,uniphier-pro4-soc-glue
+          - socionext,uniphier-pro5-soc-glue
+          - socionext,uniphier-pxs2-soc-glue
+          - socionext,uniphier-ld6b-soc-glue
+          - socionext,uniphier-sld8-soc-glue
+          - socionext,uniphier-ld11-soc-glue
+          - socionext,uniphier-ld20-soc-glue
+          - socionext,uniphier-pxs3-soc-glue
+          - socionext,uniphier-nx1-soc-glue
+          - socionext,uniphier-soc-glue
+      - const: simple-mfd
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+patternProperties:
+  "^pinctrl(@[0-9a-f]+)?$":
+    $ref: /schemas/pinctrl/socionext,uniphier-pinctrl.yaml#
+
+  "^usb-controller(@[0-9a-f]+)?$":
+    $ref: /schemas/phy/socionext,uniphier-usb2-phy.yaml#
+
+  "^clock-controller(@[0-9a-f]+)?$":
+    $ref: /schemas/clock/socionext,uniphier-clock.yaml#
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    syscon@5f800000 {
+        compatible = "socionext,uniphier-pro4-soc-glue",
+                     "simple-mfd", "syscon";
+        reg = <0x5f800000 0x2000>;
+
+        pinctrl {
+            compatible = "socionext,uniphier-pro4-pinctrl";
+        };
+
+        usb-controller {
+            compatible = "socionext,uniphier-pro4-usb2-phy";
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            phy@0 {
+                reg = <0>;
+                #phy-cells = <0>;
+            };
+
+            phy@1 {
+                reg = <1>;
+                #phy-cells = <0>;
+            };
+
+            phy@2 {
+                reg = <2>;
+                #phy-cells = <0>;
+            };
+
+            phy@3 {
+                reg = <3>;
+                #phy-cells = <0>;
+            };
+        };
+
+        clock-controller {
+            compatible = "socionext,uniphier-pro4-sg-clock";
+            #clock-cells = <1>;
+        };
+    };
-- 
2.25.1

