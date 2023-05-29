Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745FC7144D0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 08:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjE2G2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 02:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbjE2G2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 02:28:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520911BC;
        Sun, 28 May 2023 23:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685341689; x=1716877689;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dh0EL4hNH/yV6+3G0mpHZLbVKP4ILEfFeFyXC+i3GrQ=;
  b=2NmnZp6HaVGmrA1AEITvTv7CHjLplUFnxV2vJ07Uz/CNJZt6bKSPZNMc
   QrBxFPndnvvnwko9++CuagztkyIwGIrcPdg67aozo5Ue2VPxSaTzxEwwb
   6BJERPcCJsvZZEFW3gu7FoK7DNfb1OOGWoQajTTgpb5glPJaH9iORJ6s0
   hfohjILa/pyL62kUlML4ENDpuFG/IeUHktcPtY1m59lx4AtXAMij/668H
   v2lg7H/l6kgvcZTG/1NSOqLsEjA0Y9iYsIdxG9W4BmBT16tRVYg+Rakw5
   EdHg/sNLwr2O4JM0m+JvUqUGw2siqaOLgu+hjC8iVGAQnEU4PUMf+FZKy
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,200,1681196400"; 
   d="scan'208";a="215861693"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 May 2023 23:26:44 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 28 May 2023 23:26:42 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Sun, 28 May 2023 23:26:37 -0700
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
Subject: [PATCH v2 4/4] dt-bindings: timer: atmel,at91rm9200-st: convert to yaml
Date:   Mon, 29 May 2023 09:26:04 +0300
Message-ID: <20230529062604.1498052-5-claudiu.beznea@microchip.com>
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

Convert Microchip AT91 system timer to YAML.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 .../devicetree/bindings/arm/atmel-sysregs.txt |  9 ---
 .../bindings/timer/atmel,at91rm9200-st.yaml   | 65 +++++++++++++++++++
 2 files changed, 65 insertions(+), 9 deletions(-)
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
index 000000000000..a75644e1a2fe
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/atmel,at91rm9200-st.yaml
@@ -0,0 +1,65 @@
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
+  - Alexandre Belloni <alexandre.belloni@microchip.com>
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
+      system controller members.
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

