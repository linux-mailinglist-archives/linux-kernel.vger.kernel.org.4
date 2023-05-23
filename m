Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92ED70D3C5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 08:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbjEWGPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 02:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbjEWGPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 02:15:41 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706D3129;
        Mon, 22 May 2023 23:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684822540; x=1716358540;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B6ogvYvBGrrc5/DBPkLgD1u82vMdLt29VA39gaBblow=;
  b=Tf/pkXjyd/dXMwutCC4Bw83hd0k7htUcWxP5/L3U4wCpSsbN51s6JxCa
   32HegZgwWvsY2OtVvx7sSws5UQvAkk+KAwPIrYNTkW8FSMGZKruKjbh9n
   VZvBR2JKZgqf/3N4+iSQ/LlaE31Q7X3CTbZ/Onm/0ahU4U2zUt9SIsn+t
   54uyPLGEEFXH9rUYPkE+9wri/tlaULg9nrWEprjosQlSEVBuwVnqEjzL9
   28hhrKkGW9yShqw0dBr10V2EE/WupUX/pZfxouXlpVCawUS8UtCX77Bvx
   4acSbf3wGJ+CQPaKf8WHpu0TmwG1/prbsC5q3Lo+PbuqLDNoHE0IhtVM7
   A==;
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="226538541"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 May 2023 23:15:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 22 May 2023 23:15:38 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 22 May 2023 23:15:34 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor.dooley@microchip.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <sre@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 3/4] dt-bindings: power: reset: atmel,sama5d2-shdwc: convert to yaml
Date:   Tue, 23 May 2023 09:15:11 +0300
Message-ID: <20230523061512.195271-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523061512.195271-1-claudiu.beznea@microchip.com>
References: <20230523061512.195271-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Atmel SAMA5D2 shutdown controller to YAML.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 .../devicetree/bindings/arm/atmel-sysregs.txt |  63 ----------
 .../power/reset/atmel,sama5d2-shdwc.yaml      | 114 ++++++++++++++++++
 2 files changed, 114 insertions(+), 63 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml

diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
index e6b2fb291b45..67a66bf74895 100644
--- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
@@ -52,69 +52,6 @@ Example:
 		reg = <0xe3804000 0x1000>;
 };
 
-SHDWC SAMA5D2-Compatible Shutdown Controller
-
-1) shdwc node
-
-required properties:
-- compatible: should be "atmel,sama5d2-shdwc", "microchip,sam9x60-shdwc" or
-  "microchip,sama7g5-shdwc"
-- reg: should contain registers location and length
-- clocks: phandle to input clock.
-- #address-cells: should be one. The cell is the wake-up input index.
-- #size-cells: should be zero.
-
-optional properties:
-
-- debounce-delay-us: minimum wake-up inputs debouncer period in
-  microseconds. It's usually a board-related property.
-- atmel,wakeup-rtc-timer: boolean to enable Real-Time Clock wake-up.
-
-optional microchip,sam9x60-shdwc or microchip,sama7g5-shdwc properties:
-- atmel,wakeup-rtt-timer: boolean to enable Real-time Timer Wake-up.
-
-The node contains child nodes for each wake-up input that the platform uses.
-
-2) input nodes
-
-Wake-up input nodes are usually described in the "board" part of the Device
-Tree. Note also that input 0 is linked to the wake-up pin and is frequently
-used.
-
-Required properties:
-- reg: should contain the wake-up input index [0 - 15].
-
-Optional properties:
-- atmel,wakeup-active-high: boolean, the corresponding wake-up input described
-  by the child, forces the wake-up of the core power supply on a high level.
-  The default is to be active low.
-
-Example:
-
-On the SoC side:
-	shdwc@f8048010 {
-		compatible = "atmel,sama5d2-shdwc";
-		reg = <0xf8048010 0x10>;
-		clocks = <&clk32k>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		atmel,wakeup-rtc-timer;
-	};
-
-On the board side:
-	shdwc@f8048010 {
-		debounce-delay-us = <976>;
-
-		input@0 {
-			reg = <0>;
-		};
-
-		input@1 {
-			reg = <1>;
-			atmel,wakeup-active-high;
-		};
-	};
-
 Special Function Registers (SFR)
 
 Special Function Registers (SFR) manage specific aspects of the integrated
diff --git a/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml b/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
new file mode 100644
index 000000000000..613668d6099b
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
@@ -0,0 +1,114 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/reset/atmel,sama5d2-shdwc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel SAMA5D2 SHDWC Shutdown Controller
+
+maintainers:
+  - Claudiu Beznea <claudiu.beznea@microchip.com>
+
+description: |
+  Atmel SHDWC shutdown controller controls the power supplies VDDIO and VDDCORE
+  and the wake-up detection on debounced input lines.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: microchip,sama7g5-shdwc
+          - const: syscon
+      - items:
+          enum:
+            - atmel,sama5d2-shdwc
+            - microchip,sam9x60-shdwc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  debounce-delay-us:
+    description: |
+      Minimum wake-up inputs debouncer period in microseconds. It is usually a
+      board-related property.
+
+  atmel,wakeup-rtc-timer:
+    description: enable real-time clock wake-up
+    type: boolean
+
+patternProperties:
+  "^input@[0-15]$":
+    description: |
+      Wake-up input nodes. These are usually described in the "board" part of
+      the Device Tree. Note also that input 0 is linked to the wake-up pin and
+      is frequently used.
+    type: object
+    properties:
+      reg:
+        description: contains the wake-up input index
+        enum: [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 ]
+
+      atmel,wakeup-active-high:
+        description: |
+          The corresponding wake-up input described by the child forces the
+          wake-up of the core power supply on a high level. The default is to
+          be active low.
+        type: boolean
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - microchip,sam9x60-shdwc
+              - microchip,sama7g5-shdwc
+    then:
+      properties:
+        atmel,wakeup-rtt-timer:
+          description: enable real-time timer wake-up
+          type: boolean
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    shdwc: poweroff@f8048010 {
+        compatible = "atmel,sama5d2-shdwc";
+        reg = <0xf8048010 0x10>;
+        clocks = <&clk32k>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        atmel,wakeup-rtc-timer;
+        debounce-delay-us = <976>;
+
+        input@0 {
+            reg = <0>;
+        };
+
+        input@1 {
+            reg = <1>;
+            atmel,wakeup-active-high;
+        };
+    };
+
+...
-- 
2.34.1

