Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A394715965
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjE3JIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjE3JIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:08:19 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01355DB;
        Tue, 30 May 2023 02:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685437698; x=1716973698;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KDOtiesl3EnNNfJv3nhJSpdEkmq96eW6+SiGHrWHxNY=;
  b=Ie5Sga7kp8NEmZjp189/ECVxqs4JwJaTxlY+jha9ARd9u0tPHyLfi+Og
   EnrqapVecTk2Civa/+k8OlanXUaEoksSyeGMKMyUb+zeb4+LFl5xsYhZg
   hn662/mlOZDf1igVuy3V4/wqywKjfpheVIzUXh31/x4EjSYTSeM6xDXFV
   Fsah+OsFLItaIlf9wfdk9qet+uv4m8leEwnWW+qYbMw8/NIqHVadwfEpm
   KO79uN47DeTRnlNzUXT8CuSP2nGCKsU5AVxs8zRU20Zlgbzi6toAtLi7x
   OgdCCYK8bvtH+3fSWv97rHOtxZBXQvz464g/Kd+JKip49GMT/LhenQqeh
   A==;
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="213680031"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 May 2023 02:08:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 30 May 2023 02:08:16 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 30 May 2023 02:08:12 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: [PATCH v3 1/3] dt-bindings: timer: atmel,at91sam9260-pit: convert to yaml
Date:   Tue, 30 May 2023 12:07:56 +0300
Message-ID: <20230530090758.1652329-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530090758.1652329-1-claudiu.beznea@microchip.com>
References: <20230530090758.1652329-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Microchip AT91 PIT bindings to YAML. Along with it clocks and
clock-names bindings were added as the drivers needs it to ensure proper
hardware functionality.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 .../devicetree/bindings/arm/atmel-sysregs.txt | 12 ---
 .../bindings/timer/atmel,at91sam9260-pit.yaml | 99 +++++++++++++++++++
 2 files changed, 99 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/atmel,at91sam9260-pit.yaml

diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
index 67a66bf74895..54d3f586403e 100644
--- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
@@ -4,18 +4,6 @@ Chipid required properties:
 - compatible: Should be "atmel,sama5d2-chipid" or "microchip,sama7g5-chipid"
 - reg : Should contain registers location and length
 
-PIT Timer required properties:
-- compatible: Should be "atmel,at91sam9260-pit"
-- reg: Should contain registers location and length
-- interrupts: Should contain interrupt for the PIT which is the IRQ line
-  shared across all System Controller members.
-
-PIT64B Timer required properties:
-- compatible: Should be "microchip,sam9x60-pit64b"
-- reg: Should contain registers location and length
-- interrupts: Should contain interrupt for PIT64B timer
-- clocks: Should contain the available clock sources for PIT64B timer.
-
 System Timer (ST) required properties:
 - compatible: Should be "atmel,at91rm9200-st", "syscon", "simple-mfd"
 - reg: Should contain registers location and length
diff --git a/Documentation/devicetree/bindings/timer/atmel,at91sam9260-pit.yaml b/Documentation/devicetree/bindings/timer/atmel,at91sam9260-pit.yaml
new file mode 100644
index 000000000000..d0f3f80db4cb
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/atmel,at91sam9260-pit.yaml
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/atmel,at91sam9260-pit.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip AT91 Periodic Interval Timer (PIT)
+
+maintainers:
+  - Claudiu Beznea <claudiu.beznea@microchip.com>
+
+description:
+  Microchip AT91 periodic interval timer provides the operating system scheduler
+  interrupt. It is designed to offer maximum accuracy and efficient management,
+  even for systems with long response time.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: microchip,sama7g5-pit64b
+          - const: microchip,sam9x60-pit64b
+      - items:
+          enum:
+            - atmel,at91sam9260-pit
+            - microchip,sam9x60-pit64b
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: atmel,at91sam9260-pit
+    then:
+      properties:
+        interrupts:
+          description:
+            Shared interrupt between all system controller members (power management
+            controller, watchdog, PIT, reset controller, real-time timer, real-time
+            clock, memory controller, debug unit, system timer).
+        clocks:
+          maxItems: 1
+
+    else:
+      properties:
+        clocks:
+          minItems: 2
+        clock-names:
+          items:
+            - const: pclk
+            - const: gclk
+      required:
+        - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    /* AT91RM9200 */
+    #include <dt-bindings/clock/at91.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    pit: timer@fffffe40 {
+        compatible = "atmel,at91sam9260-pit";
+        reg = <0xfffffe40 0x10>;
+        interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+        clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
+    };
+
+  - |
+    /* SAM9X60 */
+    #include <dt-bindings/clock/at91.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    pit64b: timer@f0028000 {
+        compatible = "microchip,sam9x60-pit64b";
+        reg = <0xf0028000 0x100>;
+        interrupts = <37 IRQ_TYPE_LEVEL_HIGH 7>;
+        clocks = <&pmc PMC_TYPE_PERIPHERAL 37>, <&pmc PMC_TYPE_GCK 37>;
+        clock-names = "pclk", "gclk";
+    };
+
+...
-- 
2.34.1

