Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3FA70D3BD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 08:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbjEWGPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 02:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235084AbjEWGPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 02:15:37 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1CF11A;
        Mon, 22 May 2023 23:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684822535; x=1716358535;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1psguHKx0oQ0y6s21WTEH9L/+VM2GUonEI7BLTQJk3Q=;
  b=0YTKgFMPJUy+p2cllGgkjXCo1cFA8ZMuCG3oUnJuusRrkXudbTcJ7PIf
   uA4b4TW0vCmc4sYH9VjDv8YqWLBn2AuoeC9YZgX6GtwZYrS28LeKwqusB
   9c1r/QPozgkP0ow6m8s83v5aqDTKZMZOWd+7xFeImKWcg+Q2YXd/IvVEx
   5A8ZfURhBqHTGa7+gWPE79WsP773tjUu43ecYYK0UcWFX5/hLXIsXL5G9
   T+MmRZshOkOzgL1iD9X1RkQhlcQZzlp5KzEA+0Zij6lbP75FOmst+X7tj
   hGnftGdfTd2Cp0lmLFOk7ssTf/iBH4U2oP/FV4A9J7l53Z3HwM1dqGPeF
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="153433853"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 May 2023 23:15:34 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 22 May 2023 23:15:33 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 22 May 2023 23:15:30 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor.dooley@microchip.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <sre@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/4] dt-bindings: power: reset: atmel,at91sam9260-shdwc: convert to yaml
Date:   Tue, 23 May 2023 09:15:10 +0300
Message-ID: <20230523061512.195271-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523061512.195271-1-claudiu.beznea@microchip.com>
References: <20230523061512.195271-1-claudiu.beznea@microchip.com>
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

Convert Atmel shutdown controller to YAML.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 .../devicetree/bindings/arm/atmel-sysregs.txt | 31 -------
 .../power/reset/atmel,at91sam9260-shdwc.yaml  | 81 +++++++++++++++++++
 2 files changed, 81 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/reset/atmel,at91sam9260-shdwc.yaml

diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
index ab1b352344ae..e6b2fb291b45 100644
--- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
@@ -52,37 +52,6 @@ Example:
 		reg = <0xe3804000 0x1000>;
 };
 
-SHDWC Shutdown Controller
-
-required properties:
-- compatible: Should be "atmel,<chip>-shdwc".
-  <chip> can be "at91sam9260", "at91sam9rl" or "at91sam9x5".
-- reg: Should contain registers location and length
-- clocks: phandle to input clock.
-
-optional properties:
-- atmel,wakeup-mode: String, operation mode of the wakeup mode.
-  Supported values are: "none", "high", "low", "any".
-- atmel,wakeup-counter: Counter on Wake-up 0 (between 0x0 and 0xf).
-
-optional at91sam9260 properties:
-- atmel,wakeup-rtt-timer: boolean to enable Real-time Timer Wake-up.
-
-optional at91sam9rl properties:
-- atmel,wakeup-rtc-timer: boolean to enable Real-time Clock Wake-up.
-- atmel,wakeup-rtt-timer: boolean to enable Real-time Timer Wake-up.
-
-optional at91sam9x5 properties:
-- atmel,wakeup-rtc-timer: boolean to enable Real-time Clock Wake-up.
-
-Example:
-
-	shdwc@fffffd10 {
-		compatible = "atmel,at91sam9260-shdwc";
-		reg = <0xfffffd10 0x10>;
-		clocks = <&clk32k>;
-	};
-
 SHDWC SAMA5D2-Compatible Shutdown Controller
 
 1) shdwc node
diff --git a/Documentation/devicetree/bindings/power/reset/atmel,at91sam9260-shdwc.yaml b/Documentation/devicetree/bindings/power/reset/atmel,at91sam9260-shdwc.yaml
new file mode 100644
index 000000000000..3b3162677db3
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/atmel,at91sam9260-shdwc.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/reset/atmel,at91sam9260-shdwc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel SHDWC Shutdown Controller
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
+    enum:
+      - atmel,at91sam9260-shdwc
+      - atmel,at91sam9rl-shdwc
+      - atmel,at91sam9x5-shdwc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  atmel,wakeup-mode:
+    description: operation mode of the wakeup mode
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [ none, high, low, any ]
+
+  atmel,wakeup-counter:
+    description: counter on wake-up 0
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 ]
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
+              - atmel,at91sam9260-shdwc
+              - atmel,at91sam9rl-shdwc
+    then:
+      properties:
+        atmel,wakeup-rtt-timer:
+          description: enable real-time timer wake-up
+          type: boolean
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - atmel,at91sam9rl-shdwc
+              - atmel,at91sam9x5-shdwc
+    then:
+      properties:
+        atmel,wakeup-rtc-timer:
+          description: enable real-time clock wake-up
+          type: boolean
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    shdwc: poweroff@fffffd10 {
+        compatible = "atmel,at91sam9260-shdwc";
+        reg = <0xfffffd10 0x10>;
+        clocks = <&clk32k>;
+    };
+
+...
-- 
2.34.1

