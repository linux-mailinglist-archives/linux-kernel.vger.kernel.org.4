Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD72732D47
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343550AbjFPKRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245041AbjFPKRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:17:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1064194;
        Fri, 16 Jun 2023 03:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686910653; x=1718446653;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+itgrmjpDD4dmlQNoVGQSgWLyaU0TMa+bBpShhgvWTE=;
  b=bGPiJyvyQR7U02P2hkq/yghgu1mOdNzlMswIGkz+da9mBXLfF0pOqb8V
   R1WV4vScKVpjNKPbokE+/XQFVRlftIVQunMnktn0JfmbB6GpFZR1MWIaO
   1YpGpSToifs5mtztQN0SXBjxkva+wyYlPWfId2W0kX1wEzIZaeuKLvcU2
   UOgr8INI18VYsvhQvMJEpRfKuO3J53UCIvIoYVcIbxInMveBA/8/Frp33
   ltcFeH9DwGTq5WIx+NrRKu1wcnv0YAdkfhLeDy4DiXAvsbAxdmSUSSNau
   mUjjrDE8ldPjh6RJ1sFef0I5WKPi3XtHIKDZqI+5672MkpHuLNOh8FBpM
   A==;
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="220582857"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jun 2023 03:17:32 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 16 Jun 2023 03:17:11 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 16 Jun 2023 03:17:07 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <sre@kernel.org>, <conor+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 2/4] dt-bindings: power: reset: atmel,at91sam9260-shdwc: convert to yaml
Date:   Fri, 16 Jun 2023 13:16:44 +0300
Message-ID: <20230616101646.879480-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616101646.879480-1-claudiu.beznea@microchip.com>
References: <20230616101646.879480-1-claudiu.beznea@microchip.com>
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

Convert Microchip AT91 shutdown controller to YAML.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 .../devicetree/bindings/arm/atmel-sysregs.txt | 31 -------
 .../power/reset/atmel,at91sam9260-shdwc.yaml  | 82 +++++++++++++++++++
 2 files changed, 82 insertions(+), 31 deletions(-)
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
index 000000000000..f559a2cfd82e
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/atmel,at91sam9260-shdwc.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/reset/atmel,at91sam9260-shdwc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip AT91 SHDWC Shutdown Controller
+
+maintainers:
+  - Claudiu Beznea <claudiu.beznea@microchip.com>
+
+description: |
+  Microchip AT91 SHDWC shutdown controller controls the power supplies VDDIO
+  and VDDCORE and the wake-up detection on debounced input lines.
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
+    minimum: 0
+    maximum: 15
+
+  atmel,wakeup-rtt-timer:
+    description: enable real-time timer wake-up
+    type: boolean
+
+  atmel,wakeup-rtc-timer:
+    description: enable real-time clock wake-up
+    type: boolean
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
+            const: atmel,at91sam9x5-shdwc
+    then:
+      properties:
+        atmel,wakeup-rtt-timer: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: atmel,at91sam9260-shdwc
+    then:
+      properties:
+        atmel,wakeup-rtc-timer: false
+
+additionalProperties: false
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

