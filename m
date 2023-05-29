Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052437144D3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 08:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjE2G24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 02:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbjE2G1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 02:27:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B21D120;
        Sun, 28 May 2023 23:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685341637; x=1716877637;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pZDeHAwx+WHaBXQtS6jEEcIeL2CywxswjLJT4bjmOYA=;
  b=U+3jvR9wdtPqf9oawf4bQvhu3aPokHAkklFH2rB23/FLZjfuYt7Z020A
   ZuzbFecwEtdkKqoPGjMqvwWS2iceyq4IvNaJI4G8qRG0lOnFHWdoyYhCX
   9+Cb0UKVUawqMLot5o7mVihwa7sTbwhxD2GFgeKs+Mmf5ag3KEQby3uKc
   j+xMVwVZb2gwCqNz9QXYL5vkOCNBmDhUV1UCOWQofgr2YqIHVq5xOWXZ0
   ++K5zOXdcfuogpJehVMQBtIyBYuAPbHPRcyZT4jRV//9+mnXzjSFmamL2
   w4oMv1InB1Lt2NFNaudW+hYBYajKR9st8ZZT0WKWsN3XHmr9lBU3CgxOP
   g==;
X-IronPort-AV: E=Sophos;i="6.00,200,1681196400"; 
   d="scan'208";a="213501744"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 May 2023 23:26:33 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 28 May 2023 23:26:31 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Sun, 28 May 2023 23:26:27 -0700
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
Subject: [PATCH v2 2/4] dt-bindings: timer: atmel,at91sam9260-pit: convert to yaml
Date:   Mon, 29 May 2023 09:26:02 +0300
Message-ID: <20230529062604.1498052-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230529062604.1498052-1-claudiu.beznea@microchip.com>
References: <20230529062604.1498052-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 .../bindings/timer/atmel,at91sam9260-pit.yaml | 96 +++++++++++++++++++
 2 files changed, 96 insertions(+), 12 deletions(-)
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
index 000000000000..1cc7b7494e4b
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/atmel,at91sam9260-pit.yaml
@@ -0,0 +1,96 @@
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
+    enum:
+      - atmel,at91sam9260-pit
+      - microchip,sam9x60-pit64b
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
+            Contain interrupt for the PIT which is the IRQ line shared across all
+            System Controller members.
+        clocks:
+          maxItems: 1
+
+    else:
+      properties:
+        interrupts:
+          description:
+            PIT64B peripheral interrupt identifier.
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

