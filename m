Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFDE704493
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 07:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjEPFTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 01:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjEPFTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 01:19:39 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8E144B0;
        Mon, 15 May 2023 22:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684214363; x=1715750363;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N+P7ruCMFEnmOkQ7g7T72yIAucZDvB6nBLPKCGf1wns=;
  b=h2v9oZUFKUU+9bm8PCF1BXWmiICz36hWazwbksw3/6bRRM2jJGJ9lJQT
   fnMT/Ahvj1c/9JgxU/f/bE+1WSrmfdph/vlU3kfnUv5sTy2oGwKQQ5nh8
   +pnwG4Z2Rl7NBtSyrqhjVaJxoTOiO9LrtEKsvI3a5poRUXYoopu92J2ON
   RzHguPhw+vY2fEGClUjU/u3MffLFAVybmcTlc8FDsgXrltonUodCBG3dV
   YZinFNcqPalG788K3UWDdLHkyPKNsmWJerKSjCSUmKGYLutEXSUqSEfng
   Ok/N2Bu3C2xgJe+FtLSiG37LgAgbVKbjKft10CIDAJDfCNYSzEBxIxTPB
   A==;
X-IronPort-AV: E=Sophos;i="5.99,277,1677567600"; 
   d="scan'208";a="214031161"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 May 2023 22:19:15 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 15 May 2023 22:19:14 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 15 May 2023 22:19:10 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <conor.dooley@microchip.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 5/5] dt-bindings: clocks: at91sam9x5-sckc: convert to yaml
Date:   Tue, 16 May 2023 08:18:36 +0300
Message-ID: <20230516051836.2511149-6-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516051836.2511149-1-claudiu.beznea@microchip.com>
References: <20230516051836.2511149-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Atmel slow clock controller documentation to yaml.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/clock/at91-clock.txt  | 30 --------
 .../bindings/clock/atmel,at91sam9x5-sckc.yaml | 70 +++++++++++++++++++
 2 files changed, 70 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/at91-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml

diff --git a/Documentation/devicetree/bindings/clock/at91-clock.txt b/Documentation/devicetree/bindings/clock/at91-clock.txt
deleted file mode 100644
index 57394785d3b0..000000000000
--- a/Documentation/devicetree/bindings/clock/at91-clock.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-Device Tree Clock bindings for arch-at91
-
-This binding uses the common clock binding[1].
-
-[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
-
-Slow Clock controller:
-
-Required properties:
-- compatible : shall be one of the following:
-	"atmel,at91sam9x5-sckc",
-	"atmel,sama5d3-sckc",
-	"atmel,sama5d4-sckc" or
-	"microchip,sam9x60-sckc":
-		at91 SCKC (Slow Clock Controller)
-- #clock-cells : shall be 1 for "microchip,sam9x60-sckc" otherwise shall be 0.
-- clocks : shall be the input parent clock phandle for the clock.
-
-Optional properties:
-- atmel,osc-bypass : boolean property. Set this when a clock signal is directly
-  provided on XIN.
-
-For example:
-	sckc@fffffe50 {
-		compatible = "atmel,at91sam9x5-sckc";
-		reg = <0xfffffe50 0x4>;
-		clocks = <&slow_xtal>;
-		#clock-cells = <0>;
-	};
-
diff --git a/Documentation/devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml b/Documentation/devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml
new file mode 100644
index 000000000000..7be29877e6d2
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/atmel,at91sam9x5-sckc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel Slow Clock Controller (SCKC)
+
+maintainers:
+  - Claudiu Beznea <claudiu.beznea@microchip.com>
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - atmel,at91sam9x5-sckc
+          - atmel,sama5d3-sckc
+          - atmel,sama5d4-sckc
+          - microchip,sam9x60-sckc
+      - items:
+          - const: microchip,sama7g5-sckc
+          - const: microchip,sam9x60-sckc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  "#clock-cells":
+    enum: [0, 1]
+
+  atmel,osc-bypass:
+    type: boolean
+    description: set when a clock signal is directly provided on XIN
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - "#clock-cells"
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - microchip,sam9x60-sckc
+    then:
+      properties:
+        "#clock-cells":
+          const: 1
+    else:
+      properties:
+        "#clock-cells":
+          const: 0
+
+additionalProperties: false
+
+examples:
+  - |
+    clk32k: clock-controller@fffffe50 {
+        compatible = "microchip,sam9x60-sckc";
+        reg = <0xfffffe50 0x4>;
+        clocks = <&slow_xtal>;
+        #clock-cells = <1>;
+    };
+
+...
-- 
2.34.1

