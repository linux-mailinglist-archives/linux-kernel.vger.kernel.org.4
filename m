Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08D16453B9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 06:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiLGFzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 00:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiLGFyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 00:54:37 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3431458BCF;
        Tue,  6 Dec 2022 21:54:33 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 07 Dec 2022 14:54:31 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id CB13C2059054;
        Wed,  7 Dec 2022 14:54:31 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 7 Dec 2022 14:54:31 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 5BCCB1DA5;
        Wed,  7 Dec 2022 14:54:31 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 10/16] dt-bindings: soc: socionext: Add UniPhier SoC-glue logic debug part
Date:   Wed,  7 Dec 2022 14:53:59 +0900
Message-Id: <20221207055405.30940-11-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221207055405.30940-1-hayashi.kunihiko@socionext.com>
References: <20221207055405.30940-1-hayashi.kunihiko@socionext.com>
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
 .../socionext,uniphier-soc-glue-debug.yaml    | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue-debug.yaml

diff --git a/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue-debug.yaml b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue-debug.yaml
new file mode 100644
index 000000000000..db13c56b77b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue-debug.yaml
@@ -0,0 +1,73 @@
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
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+  ranges: true
+
+patternProperties:
+  "^efuse(@[0-9a-f]+)?$":
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
+
+        efuse@200 {
+            compatible = "socionext,uniphier-efuse";
+            reg = <0x200 0x58>;
+        };
+    };
-- 
2.25.1

