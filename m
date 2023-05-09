Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077FB6FBEAC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 07:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbjEIF2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 01:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjEIF20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 01:28:26 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EF99EE2;
        Mon,  8 May 2023 22:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683610105; x=1715146105;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bENAJzvRNkr5XYz6N1cM2JkYR0rONMRzvQ2PM5HkuSg=;
  b=lh/wxEJs0JMKi1CWenw3vY82l6EezX/DIUYutyebSKNaHDGiu48b4cAt
   gZROnGZr3uPCqPVls6Cz+1anPanpdNiWYtFSzIeBEmMa1zTYYIuAseDQG
   gmY37YK1hgp6O5WQ56Iywq0AsL9F3FLafnSSEnyc0P/FjCmsgtIpiOoT+
   HifOgSPCDpPscf2aDPm6/unl/ZmPVjqVtyRfyCPBWMCyaHlNJg/y6jmFs
   f8+/Hs2T68FnENL1lBLMo8nTsmqIQTAErWH4xkMlfdhcp8bQc2sMiu9/B
   WFIKuktuE5JsTL2X/l76WIOCRZ1scHBI9rwqbguAKnBMLFHCO7sqK9re9
   w==;
X-IronPort-AV: E=Sophos;i="5.99,261,1677567600"; 
   d="scan'208";a="210291735"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 May 2023 22:28:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 8 May 2023 22:28:23 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 8 May 2023 22:28:18 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 2/5] dt-bindings: clocks: atmel,at91rm9200-pmc: convert to yaml
Date:   Tue, 9 May 2023 08:27:54 +0300
Message-ID: <20230509052757.539274-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230509052757.539274-1-claudiu.beznea@microchip.com>
References: <20230509052757.539274-1-claudiu.beznea@microchip.com>
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

Convert Atmel PMC documentation to yaml. Along with it clock names
were adapted according to the current available device trees as
different controller versions accept different clocks (some of them
have 3 clocks as input, some has 2 clocks as inputs and some with 2
input clocks uses different clock names).

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 .../devicetree/bindings/clock/at91-clock.txt  |  28 ----
 .../bindings/clock/atmel,at91rm9200-pmc.yaml  | 152 ++++++++++++++++++
 2 files changed, 152 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml

diff --git a/Documentation/devicetree/bindings/clock/at91-clock.txt b/Documentation/devicetree/bindings/clock/at91-clock.txt
index 13f45db3b66d..57394785d3b0 100644
--- a/Documentation/devicetree/bindings/clock/at91-clock.txt
+++ b/Documentation/devicetree/bindings/clock/at91-clock.txt
@@ -28,31 +28,3 @@ For example:
 		#clock-cells = <0>;
 	};
 
-Power Management Controller (PMC):
-
-Required properties:
-- compatible : shall be "atmel,<chip>-pmc", "syscon" or
-	"microchip,sam9x60-pmc"
-	<chip> can be: at91rm9200, at91sam9260, at91sam9261,
-	at91sam9263, at91sam9g45, at91sam9n12, at91sam9rl, at91sam9g15,
-	at91sam9g25, at91sam9g35, at91sam9x25, at91sam9x35, at91sam9x5,
-	sama5d2, sama5d3 or sama5d4.
-- #clock-cells : from common clock binding; shall be set to 2. The first entry
-  is the type of the clock (core, system, peripheral or generated) and the
-  second entry its index as provided by the datasheet
-- clocks : Must contain an entry for each entry in clock-names.
-- clock-names: Must include the following entries: "slow_clk", "main_xtal"
-
-Optional properties:
-- atmel,osc-bypass : boolean property. Set this when a clock signal is directly
-  provided on XIN.
-
-For example:
-	pmc: pmc@f0018000 {
-		compatible = "atmel,sama5d4-pmc", "syscon";
-		reg = <0xf0018000 0x120>;
-		interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
-		#clock-cells = <2>;
-		clocks = <&clk32k>, <&main_xtal>;
-		clock-names = "slow_clk", "main_xtal";
-	};
diff --git a/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml b/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
new file mode 100644
index 000000000000..aa727dee6729
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
@@ -0,0 +1,152 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/atmel,at91rm9200-pmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel Power Management Controller (PMC)
+
+maintainers:
+  - Claudiu Beznea <claudiu.beznea@microchip.com>
+
+description:
+  The power management controller optimizes power consumption by controlling all
+  system and user peripheral clocks. The PMC enables/disables the clock inputs
+  to many of the peripherals and to the processor.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - atmel,at91sam9g15-pmc
+              - atmel,at91sam9g20-pmc
+              - atmel,at91sam9g25-pmc
+              - atmel,at91sam9g35-pmc
+              - atmel,at91sam9x25-pmc
+              - atmel,at91sam9x35-pmc
+          - enum:
+              - atmel,at91sam9260-pmc
+              - atmel,at91sam9x5-pmc
+          - const: syscon
+      - items:
+          - enum:
+              - atmel,at91rm9200-pmc
+              - atmel,at91sam9260-pmc
+              - atmel,at91sam9g45-pmc
+              - atmel,at91sam9n12-pmc
+              - atmel,at91sam9rl-pmc
+              - atmel,sama5d2-pmc
+              - atmel,sama5d3-pmc
+              - atmel,sama5d4-pmc
+              - microchip,sam9x60-pmc
+              - microchip,sama7g5-pmc
+          - const: syscon
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  "#clock-cells":
+    description: |
+      - 1st cell is the clock type, one of PMC_TYPE_CORE, PMC_TYPE_SYSTEM,
+        PMC_TYPE_PERIPHERAL, PMC_TYPE_GCK, PMC_TYPE_PROGRAMMABLE (as defined
+        in <dt-bindings/clock/at91.h>)
+      - 2nd cell is the clock identifier as defined in <dt-bindings/clock/at91.h
+        (for core clocks) or as defined in datasheet (for system, peripheral,
+        gck and programmable clocks).
+    const: 2
+
+  clocks:
+    minItems: 2
+    maxItems: 3
+
+  clock-names:
+    minItems: 2
+    maxItems: 3
+
+  atmel,osc-bypass:
+    description: set when a clock signal is directly provided on XIN
+    type: boolean
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - "#clock-cells"
+  - clocks
+  - clock-names
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - microchip,sam9x60-pmc
+              - microchip,sama7g5-pmc
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 3
+        clock-names:
+          items:
+            - const: td_slck
+            - const: md_slck
+            - const: main_xtal
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - atmel,at91rm9200-pmc
+              - atmel,at91sam9260-pmc
+              - atmel,at91sam9g20-pmc
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          items:
+            - const: slow_xtal
+            - const: main_xtal
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - atmel,sama5d2-pmc
+              - atmel,sama5d3-pmc
+              - atmel,sama5d4-pmc
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          items:
+            - const: slow_clk
+            - const: main_xtal
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    pmc: clock-controller@f0018000 {
+        compatible = "atmel,sama5d4-pmc", "syscon";
+        reg = <0xf0018000 0x120>;
+        interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+        #clock-cells = <2>;
+        clocks = <&clk32k>, <&main_xtal>;
+        clock-names = "slow_clk", "main_xtal";
+    };
+
+...
-- 
2.34.1

