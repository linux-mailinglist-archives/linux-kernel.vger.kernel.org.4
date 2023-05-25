Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFA0710C9C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 14:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241142AbjEYM5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 08:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbjEYM5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 08:57:17 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A017D1A6;
        Thu, 25 May 2023 05:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685019423; x=1716555423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UikTxPTMS4kWoru+c9xlmXkh9gf6wCiMAK/SmT/FiLU=;
  b=oOaZZSToF8rFTADuFnWLFkVyTH8G/hRjC83vHPpYZ6JmlIpquS20JqQh
   Rp85IKz4Llyz9t9xXFAqkYvM+cG45N9465y7b501ZD4CSHyjmhtEgyHCf
   hRwyHJXDzIsusc7vXXidtf9K0kAwLFXqdgAMROFbcpjnWxRU206cdW5aX
   r70gqFKpLK1srNX06H12Y1PxH1iRNHHHj0abgRHOb6Zfexlor5J2NO0wS
   2nRYHWtKTsXfmstbZ1F3taJ1VV9ZQrN7L0yqbVtQYeCGCq/plA8cH2sTj
   0xv7zxYpLRB3MNvbS5SfShOy1Ccbqb46aD3GGGP2Sc3lsLmyyluQO/W16
   A==;
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="scan'208";a="217255331"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 May 2023 05:56:58 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 25 May 2023 05:56:56 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 25 May 2023 05:56:50 -0700
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
Subject: [PATCH 1/5] dt-bindings: timer: atmel,at91sam9260-pit: convert to yaml
Date:   Thu, 25 May 2023 15:55:58 +0300
Message-ID: <20230525125602.640855-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525125602.640855-1-claudiu.beznea@microchip.com>
References: <20230525125602.640855-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Atmel PIT to YAML. Along with it clock binding has been added as
the driver enables it to ensure proper hardware functionality.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 .../devicetree/bindings/arm/atmel-sysregs.txt |  6 ---
 .../bindings/timer/atmel,at91sam9260-pit.yaml | 51 +++++++++++++++++++
 2 files changed, 51 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/atmel,at91sam9260-pit.yaml

diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
index 67a66bf74895..7024839c5da2 100644
--- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
@@ -4,12 +4,6 @@ Chipid required properties:
 - compatible: Should be "atmel,sama5d2-chipid" or "microchip,sama7g5-chipid"
 - reg : Should contain registers location and length
 
-PIT Timer required properties:
-- compatible: Should be "atmel,at91sam9260-pit"
-- reg: Should contain registers location and length
-- interrupts: Should contain interrupt for the PIT which is the IRQ line
-  shared across all System Controller members.
-
 PIT64B Timer required properties:
 - compatible: Should be "microchip,sam9x60-pit64b"
 - reg: Should contain registers location and length
diff --git a/Documentation/devicetree/bindings/timer/atmel,at91sam9260-pit.yaml b/Documentation/devicetree/bindings/timer/atmel,at91sam9260-pit.yaml
new file mode 100644
index 000000000000..f304cd68acd5
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/atmel,at91sam9260-pit.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/atmel,at91sam9260-pit.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel Periodic Interval Timer (PIT)
+
+maintainers:
+  - Claudiu Beznea <claudiu.beznea@microchip.com>
+
+description:
+  Atmel periodic interval timer provides the operating system’s scheduler
+  interrupt. It is designed to offer maximum accuracy and efficient management,
+  even for systems with long response time.
+
+properties:
+  compatible:
+    const: atmel,at91sam9260-pit
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      Contain interrupt for the PIT which is the IRQ line shared across all
+      System Controller members.
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
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
+    #include <dt-bindings/clock/at91.h>
+
+    pit: timer@fffffe40 {
+        compatible = "atmel,at91sam9260-pit";
+        reg = <0xfffffe40 0x10>;
+        interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+        clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
+    };
+...
-- 
2.34.1

