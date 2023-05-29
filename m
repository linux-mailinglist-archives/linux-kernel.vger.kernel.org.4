Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295697144CF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 08:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjE2G14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 02:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbjE2G1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 02:27:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21D3DE;
        Sun, 28 May 2023 23:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685341637; x=1716877637;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tSQUnslAhMfFgaCfiyHY/+VYMnOWOgn2z8cAN4rX8QA=;
  b=C+DtTg1FeOyeGlAzVZ+5553XSWubnF+OTBPx9mvtc4rpnp8v9f7qenhI
   tayGUitpOP3otI4ewlYCy5PZj3CTxxQhYuWxLSVG8s3xPAASejfpkGxJ3
   ppATLcMhaIueAhQkNFFg0EgUzEsTT+iDXJRHptVFRmaPUdGrG7wGI9b/w
   QLe8TAMNooc0jfR1X2xpvENVFO4QpiNKGg282Aep3umSWZouN2lR6zvE7
   m1UCvfWcFL2R9g/JhjW0Ct4+gzqSX02RGk3qRJK5BUn6v7qLrqAm+5Bc0
   VxApk/1ShHx9pkbJCQJwkA6cvK2j9L1ou73Ajawrnm6mEKqGwHUlxN4xa
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,200,1681196400"; 
   d="scan'208";a="227402341"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 May 2023 23:26:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 28 May 2023 23:26:36 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Sun, 28 May 2023 23:26:31 -0700
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
Subject: [PATCH v2 3/4] dt-bindings: watchdog: atmel,at91rm9200-wdt: convert to yaml
Date:   Mon, 29 May 2023 09:26:03 +0300
Message-ID: <20230529062604.1498052-4-claudiu.beznea@microchip.com>
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

Convert Microchip AT91RM9200 system timer watchdog bindings to YAML.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 .../watchdog/atmel,at91rm9200-wdt.yaml        | 29 +++++++++++++++++++
 .../watchdog/atmel-at91rm9200-wdt.txt         |  9 ------
 2 files changed, 29 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/atmel,at91rm9200-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/atmel,at91rm9200-wdt.yaml b/Documentation/devicetree/bindings/watchdog/atmel,at91rm9200-wdt.yaml
new file mode 100644
index 000000000000..592e797df4c2
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/atmel,at91rm9200-wdt.yaml
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/atmel,at91rm9200-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip AT91RM9200 System Timer Watchdog
+
+maintainers:
+  - Nicolas Ferre <nicolas.ferre@microchip.com>
+  - Alexandre Belloni <alexandre.belloni@bootlin.com>
+  - Claudiu Beznea <claudiu.beznea@microchip.coam>
+
+properties:
+  compatible:
+    const: atmel,at91rm9200-wdt
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    watchdog {
+        compatible = "atmel,at91rm9200-wdt";
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-wdt.txt b/Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-wdt.txt
deleted file mode 100644
index d4d86cf8f9eb..000000000000
--- a/Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-wdt.txt
+++ /dev/null
@@ -1,9 +0,0 @@
-Atmel AT91RM9200 System Timer Watchdog
-
-Required properties:
-- compatible: must be "atmel,at91sam9260-wdt".
-
-Example:
-	watchdog@fffffd00 {
-		compatible = "atmel,at91rm9200-wdt";
-	};
-- 
2.34.1

