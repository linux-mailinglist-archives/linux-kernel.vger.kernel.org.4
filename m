Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B692706467
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 11:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjEQJmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 05:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjEQJmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 05:42:39 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E595270;
        Wed, 17 May 2023 02:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684316555; x=1715852555;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZjqOgyYB1rM9n+lVWekEwRaDSBNSqYRERlNV+iLbYn0=;
  b=P12ONL9NZDznvvsRvWeM9eLOIs4Z8Ch2SNpg88sZASnz+o1geVsHiv2b
   n9FZ4ko4IJpYpSQ8nu8KbfJWufc7IhizVrWnufTX87493qcVzSdcuMStx
   EGZjTslhzGQJxIrJxRM/lL9zwIMoMYK8dlHgrVY6j6ZfGcU70pHV+XC8d
   SYkZsxiuZlXiC9h2+bkvzMjgcHT750mWPb0aRy11RMa+oY5h9nXzzjM8i
   McdbuLRQJXCXRswUV/0gH82MMM+9DyUbftxlQxWaRlYK7P+A1vis4xXVy
   6dGreB/Gt00d1zufpGaKHUixG6TrzIELHKA4or3msG0XAG4y/0hZyaEhq
   A==;
X-IronPort-AV: E=Sophos;i="5.99,281,1677567600"; 
   d="scan'208";a="214255394"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 May 2023 02:42:35 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 17 May 2023 02:42:33 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Wed, 17 May 2023 02:42:29 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor.dooley@microchip.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v5 4/5] ARM: dts: at91: use clock-controller name for sckc nodes
Date:   Wed, 17 May 2023 12:41:18 +0300
Message-ID: <20230517094119.2894220-5-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517094119.2894220-1-claudiu.beznea@microchip.com>
References: <20230517094119.2894220-1-claudiu.beznea@microchip.com>
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

Use clock-controller generic name for slow clock controller nodes.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91sam9g45.dtsi | 2 +-
 arch/arm/boot/dts/at91sam9rl.dtsi  | 2 +-
 arch/arm/boot/dts/at91sam9x5.dtsi  | 2 +-
 arch/arm/boot/dts/sam9x60.dtsi     | 2 +-
 arch/arm/boot/dts/sama5d2.dtsi     | 2 +-
 arch/arm/boot/dts/sama5d3.dtsi     | 2 +-
 arch/arm/boot/dts/sama5d4.dtsi     | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 76afeb31b7f5..498cb92b29f9 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -923,7 +923,7 @@ usb2: gadget@fff78000 {
 				status = "disabled";
 			};
 
-			clk32k: sckc@fffffd50 {
+			clk32k: clock-controller@fffffd50 {
 				compatible = "atmel,at91sam9x5-sckc";
 				reg = <0xfffffd50 0x4>;
 				clocks = <&slow_xtal>;
diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
index a12e6c419fe3..d7e8a115c916 100644
--- a/arch/arm/boot/dts/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/at91sam9rl.dtsi
@@ -799,7 +799,7 @@ watchdog@fffffd40 {
 				status = "disabled";
 			};
 
-			clk32k: sckc@fffffd50 {
+			clk32k: clock-controller@fffffd50 {
 				compatible = "atmel,at91sam9x5-sckc";
 				reg = <0xfffffd50 0x4>;
 				clocks = <&slow_xtal>;
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index af19ef2a875c..0123ee47151c 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -154,7 +154,7 @@ pit: timer@fffffe30 {
 				clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
 			};
 
-			clk32k: sckc@fffffe50 {
+			clk32k: clock-controller@fffffe50 {
 				compatible = "atmel,at91sam9x5-sckc";
 				reg = <0xfffffe50 0x4>;
 				clocks = <&slow_xtal>;
diff --git a/arch/arm/boot/dts/sam9x60.dtsi b/arch/arm/boot/dts/sam9x60.dtsi
index 6f5177df01bc..933d73505a8b 100644
--- a/arch/arm/boot/dts/sam9x60.dtsi
+++ b/arch/arm/boot/dts/sam9x60.dtsi
@@ -700,7 +700,7 @@ pit: timer@fffffe40 {
 				clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
 			};
 
-			clk32k: sckc@fffffe50 {
+			clk32k: clock-controller@fffffe50 {
 				compatible = "microchip,sam9x60-sckc";
 				reg = <0xfffffe50 0x4>;
 				clocks = <&slow_xtal>;
diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 86009dd28e62..5f632e3f039e 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -704,7 +704,7 @@ watchdog: watchdog@f8048040 {
 				status = "disabled";
 			};
 
-			clk32k: sckc@f8048050 {
+			clk32k: clock-controller@f8048050 {
 				compatible = "atmel,sama5d4-sckc";
 				reg = <0xf8048050 0x4>;
 
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 4524a16322d1..0eebf6c760b3 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -1040,7 +1040,7 @@ watchdog: watchdog@fffffe40 {
 				status = "disabled";
 			};
 
-			clk32k: sckc@fffffe50 {
+			clk32k: clock-controller@fffffe50 {
 				compatible = "atmel,sama5d3-sckc";
 				reg = <0xfffffe50 0x4>;
 				clocks = <&slow_xtal>;
diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index e94f3a661f4b..de6c82969232 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -761,7 +761,7 @@ watchdog: watchdog@fc068640 {
 				status = "disabled";
 			};
 
-			clk32k: sckc@fc068650 {
+			clk32k: clock-controller@fc068650 {
 				compatible = "atmel,sama5d4-sckc";
 				reg = <0xfc068650 0x4>;
 				#clock-cells = <0>;
-- 
2.34.1

