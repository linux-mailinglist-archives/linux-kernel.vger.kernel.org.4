Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE5464B114
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 09:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbiLMIZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 03:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234733AbiLMIZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 03:25:08 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D34713CEE;
        Tue, 13 Dec 2022 00:25:06 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 13 Dec 2022 17:25:05 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 78A672058B4F;
        Tue, 13 Dec 2022 17:25:05 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 13 Dec 2022 17:25:05 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id EF303A855F;
        Tue, 13 Dec 2022 17:25:04 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 11/17] dt-bindings: soc: socionext: Add UniPhier SoC-glue logic debug part
Date:   Tue, 13 Dec 2022 17:24:43 +0900
Message-Id: <20221213082449.2721-12-hayashi.kunihiko@socionext.com>
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

Add devicetree binding schema for the SoC-glue logic debug part
implemented on Socionext Uniphier SoCs.

This SoC-glue logic debug part is a set of miscellaneous function
registers handling signals for specific devices outside system
components, and also has multiple functions such as efuse, debug unit,
several monitors for specific SoC, and so on.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../socionext,uniphier-soc-glue-debug.yaml    | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue-debug.yaml

diff --git a/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue-debug.yaml b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue-debug.yaml
new file mode 100644
index 000000000000..1341544d1df5
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue-debug.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/socionext/socionext,uniphier-soc-glue-debug.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Socionext UniPhier SoC-glue logic debug part
+
+maintainers:
+  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+
+description: |+
+  SoC-glue logic debug part implemented on Socionext UniPhier SoCs is
+  a collection of miscellaneous function registers handling signals outside
+  system components for debug and monitor use.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - socionext,uniphier-ld4-soc-glue-debug
+          - socionext,uniphier-pro4-soc-glue-debug
+          - socionext,uniphier-pro5-soc-glue-debug
+          - socionext,uniphier-pxs2-soc-glue-debug
+          - socionext,uniphier-sld8-soc-glue-debug
+          - socionext,uniphier-ld11-soc-glue-debug
+          - socionext,uniphier-ld20-soc-glue-debug
+          - socionext,uniphier-pxs3-soc-glue-debug
+          - socionext,uniphier-nx1-soc-glue-debug
+      - const: simple-mfd
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  ranges: true
+
+patternProperties:
+  "^efuse@[0-9a-f]+$":
+    $ref: /schemas/nvmem/socionext,uniphier-efuse.yaml#
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    syscon@5f900000 {
+        compatible = "socionext,uniphier-pxs2-soc-glue-debug",
+                     "simple-mfd", "syscon";
+        reg = <0x5f900000 0x2000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0 0x5f900000 0x2000>;
+
+        efuse@100 {
+            compatible = "socionext,uniphier-efuse";
+            reg = <0x100 0x28>;
+        };
+    };
-- 
2.25.1

