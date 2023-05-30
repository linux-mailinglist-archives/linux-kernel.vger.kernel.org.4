Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94F2715972
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjE3JIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjE3JIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:08:42 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B39C106;
        Tue, 30 May 2023 02:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685437715; x=1716973715;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oJkUlU9Jd4ADpSSd4T0wXg07cVjw5hSawlz0KBTopVk=;
  b=14w9F/aSFQl8R0eZFD4CaZR0k3X8ui10QFKkaBlHB59yFvN6wwDngW3j
   Q0uAe87QWZr6L78biY0DHVZNb1LFuQUi/5gdhyoC8Y8oZ2TUp9H3Zuzka
   cXoP7fBEy7u7Bkj8WDUnQ0fEew2WHzAqjmXUSPV0OFCfxqTCpfwXiGNFa
   4xQ2220T9TyZyW3RuPCdAC1Jo9mq5qOCK+Aut4e22xShFee+d2PMoHLFM
   kaXPSAFpdlDPWya5L0MEObI954smt9r0NFDuUcP3Is8GKftcupnPmp9gA
   IlMXkt7g01uZjppag6t+aFTZ+F/t3XTv0FoyuImcRHlFVtpmj2UZkbZZZ
   A==;
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="227555122"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 May 2023 02:08:34 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 30 May 2023 02:08:27 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 30 May 2023 02:08:22 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 3/3] dt-bindings: timer: atmel,at91rm9200-st: convert to yaml
Date:   Tue, 30 May 2023 12:07:58 +0300
Message-ID: <20230530090758.1652329-4-claudiu.beznea@microchip.com>
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

Convert Microchip AT91 system timer to YAML.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/arm/atmel-sysregs.txt |  9 ---
 .../bindings/timer/atmel,at91rm9200-st.yaml   | 66 +++++++++++++++++++
 2 files changed, 66 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/atmel,at91rm9200-st.yaml

diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
index 54d3f586403e..68c0eacb01ac 100644
--- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
@@ -4,15 +4,6 @@ Chipid required properties:
 - compatible: Should be "atmel,sama5d2-chipid" or "microchip,sama7g5-chipid"
 - reg : Should contain registers location and length
 
-System Timer (ST) required properties:
-- compatible: Should be "atmel,at91rm9200-st", "syscon", "simple-mfd"
-- reg: Should contain registers location and length
-- interrupts: Should contain interrupt for the ST which is the IRQ line
-  shared across all System Controller members.
-- clocks: phandle to input clock.
-Its subnodes can be:
-- watchdog: compatible should be "atmel,at91rm9200-wdt"
-
 RAMC SDRAM/DDR Controller required properties:
 - compatible: Should be "atmel,at91rm9200-sdramc", "syscon"
 			"atmel,at91sam9260-sdramc",
diff --git a/Documentation/devicetree/bindings/timer/atmel,at91rm9200-st.yaml b/Documentation/devicetree/bindings/timer/atmel,at91rm9200-st.yaml
new file mode 100644
index 000000000000..12d0bb7bd0c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/atmel,at91rm9200-st.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/atmel,at91rm9200-st.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip AT91 System Timer (ST)
+
+maintainers:
+  - Nicolas Ferre <nicolas.ferre@microchip.com>
+  - Alexandre Belloni <alexandre.belloni@bootlin.com>
+  - Claudiu Beznea <claudiu.beznea@microchip.com>
+
+description:
+  Microchip AT91 system timer integrates a period interval timer, a watchdog
+  timer and a real-time timer.
+
+properties:
+  compatible:
+    items:
+      - const: atmel,at91rm9200-st
+      - const: syscon
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      Contain interrupt for the ST which is the IRQ line shared across all
+      system controller members (memory controller, debug unit, system timer,
+      real-time clock, power management controller).
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  watchdog:
+    $ref: ../watchdog/atmel,at91rm9200-wdt.yaml
+    description:
+      Child node describing watchdog.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    st: timer@fffffd00 {
+        compatible = "atmel,at91rm9200-st", "syscon", "simple-mfd";
+        reg = <0xfffffd00 0x100>;
+        interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+        clocks = <&slow_xtal>;
+
+        watchdog {
+            compatible = "atmel,at91rm9200-wdt";
+        };
+    };
+
+...
-- 
2.34.1

