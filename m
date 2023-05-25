Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32354710CA2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 14:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241184AbjEYM5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 08:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241192AbjEYM5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 08:57:31 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB0019A;
        Thu, 25 May 2023 05:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685019432; x=1716555432;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EVnSI9LJi2wDVScFuluBr8cQysoQrwP3wKw1ykii7jI=;
  b=LXgbeZRpZqZxpnY0UjHY3tWwaGO0haU8/sWKmq4A1dhWp+fU6h1EfYy2
   j92nPTjY57/A1/dt+fUO8nbQCnBBC79Fnj3FZhQWXeiiPOuEcXbbsj5KC
   fS3jqFLc5GGC6lTzBSEmOw2Xgf+C42K7bmN3TT5DrjWphyG4Osp/X2eUn
   2GATC6RmfYPa/MwaNXb5pVYo2w1V0/XTvQl8uuunGlbrliDNzjFBHgzcC
   rFuPHKCGw/CY209wIo3QyZLwPzFtUFmSYGElB+weKmVXm0nzMwZtdKSSA
   5epkaTXCiHlEnhKpgtNZticeyYadCPqJFSiBC4V6NjJiaX+j3HBtb9Wr5
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="scan'208";a="214859631"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 May 2023 05:57:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 25 May 2023 05:57:11 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 25 May 2023 05:57:07 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <sebastian.reichel@collabora.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: [PATCH 3/5] dt-bindings: timer: microchip,sam9x60-pit64b: convert to yaml
Date:   Thu, 25 May 2023 15:56:00 +0300
Message-ID: <20230525125602.640855-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525125602.640855-1-claudiu.beznea@microchip.com>
References: <20230525125602.640855-1-claudiu.beznea@microchip.com>
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

Convert Microchip PIT64B to YAML. Along with it clock-names binding has
been added as the driver needs it to get PIT64B clocks.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 .../devicetree/bindings/arm/atmel-sysregs.txt |  6 --
 .../timer/microchip,sam9x60-pit64b.yaml       | 56 +++++++++++++++++++
 2 files changed, 56 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/microchip,sam9x60-pit64b.yaml

diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
index 7024839c5da2..54d3f586403e 100644
--- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
@@ -4,12 +4,6 @@ Chipid required properties:
 - compatible: Should be "atmel,sama5d2-chipid" or "microchip,sama7g5-chipid"
 - reg : Should contain registers location and length
 
-PIT64B Timer required properties:
-- compatible: Should be "microchip,sam9x60-pit64b"
-- reg: Should contain registers location and length
-- interrupts: Should contain interrupt for PIT64B timer
-- clocks: Should contain the available clock sources for PIT64B timer.
-
 System Timer (ST) required properties:
 - compatible: Should be "atmel,at91rm9200-st", "syscon", "simple-mfd"
 - reg: Should contain registers location and length
diff --git a/Documentation/devicetree/bindings/timer/microchip,sam9x60-pit64b.yaml b/Documentation/devicetree/bindings/timer/microchip,sam9x60-pit64b.yaml
new file mode 100644
index 000000000000..9378eca38138
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/microchip,sam9x60-pit64b.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/microchip,sam9x60-pit64b.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip 64-bit Periodic Interval Timer (PIT64B)
+
+maintainers:
+  - Claudiu Beznea <claudiu.beznea@microchip.com>
+
+description:
+  The 64-bit periodic interval timer provides the operating system scheduler
+  interrupt. It is designed to offer maximum accuracy and efficient management,
+  even for systems with long response times.
+
+properties:
+  compatible:
+    const: microchip,sam9x60-pit64b
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: gclk
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/at91.h>
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

