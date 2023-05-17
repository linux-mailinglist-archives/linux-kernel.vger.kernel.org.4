Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F6B706460
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 11:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjEQJmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 05:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjEQJm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 05:42:28 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1595253;
        Wed, 17 May 2023 02:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684316544; x=1715852544;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fulgl6C4mZyo6UchjyoA3AVcKlBuE17Iss40HcwQstc=;
  b=iiUXPs8snaPXQGyFyqw4uHrjLPk4sitbSojXVnzg/F6v8y9McHQcqXDX
   oksbkp8xLtU9jeyDBkFn3VMNbkZl5W6Fe5Efw5SQIoBaQowlqSIsTkcOb
   QGXzUFJPxcEqh+7hrj8pT2FWRSpyrBLSEd4O4dP/UWRu8+zkLFnQLWRlK
   K78BSzTEIut+3VSrt/hC/Wn0Qj4uC+LiPz10nnWQzl/BFloZWlG2AnZg1
   Cop3yZFrHhG+/C1+IWabAZYodrFOUXlmKVgNT508k7cZTdQcgcQCRzGLG
   gtTFDXMv/1zauO3ujeKLXC7oig51s3sjzfMNW3m28W3zn7Q8ngi32TPDk
   A==;
X-IronPort-AV: E=Sophos;i="5.99,281,1677567600"; 
   d="scan'208";a="215853568"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 May 2023 02:42:23 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 17 May 2023 02:42:19 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Wed, 17 May 2023 02:42:16 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor.dooley@microchip.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v5 1/5] ARM: dts: at91: use clock-controller name for PMC nodes
Date:   Wed, 17 May 2023 12:41:15 +0300
Message-ID: <20230517094119.2894220-2-claudiu.beznea@microchip.com>
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

Use clock-controller generic name for PMC nodes.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91rm9200.dtsi   | 2 +-
 arch/arm/boot/dts/at91sam9260.dtsi  | 2 +-
 arch/arm/boot/dts/at91sam9261.dtsi  | 2 +-
 arch/arm/boot/dts/at91sam9263.dtsi  | 2 +-
 arch/arm/boot/dts/at91sam9g20.dtsi  | 2 +-
 arch/arm/boot/dts/at91sam9g25.dtsi  | 2 +-
 arch/arm/boot/dts/at91sam9g35.dtsi  | 2 +-
 arch/arm/boot/dts/at91sam9g45.dtsi  | 2 +-
 arch/arm/boot/dts/at91sam9n12.dtsi  | 2 +-
 arch/arm/boot/dts/at91sam9rl.dtsi   | 2 +-
 arch/arm/boot/dts/at91sam9x25.dtsi  | 2 +-
 arch/arm/boot/dts/at91sam9x35.dtsi  | 2 +-
 arch/arm/boot/dts/at91sam9x5.dtsi   | 2 +-
 arch/arm/boot/dts/sam9x60.dtsi      | 2 +-
 arch/arm/boot/dts/sama5d2.dtsi      | 2 +-
 arch/arm/boot/dts/sama5d3.dtsi      | 2 +-
 arch/arm/boot/dts/sama5d3_emac.dtsi | 2 +-
 arch/arm/boot/dts/sama5d4.dtsi      | 2 +-
 arch/arm/boot/dts/sama7g5.dtsi      | 2 +-
 19 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
index 6f9004ebf424..37b500f6f395 100644
--- a/arch/arm/boot/dts/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/at91rm9200.dtsi
@@ -102,7 +102,7 @@ ramc0: ramc@ffffff00 {
 				reg = <0xffffff00 0x100>;
 			};
 
-			pmc: pmc@fffffc00 {
+			pmc: clock-controller@fffffc00 {
 				compatible = "atmel,at91rm9200-pmc", "syscon";
 				reg = <0xfffffc00 0x100>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 789fe356dbf6..16e3b24b4ddd 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -115,7 +115,7 @@ matrix: matrix@ffffee00 {
 				reg = <0xffffee00 0x200>;
 			};
 
-			pmc: pmc@fffffc00 {
+			pmc: clock-controller@fffffc00 {
 				compatible = "atmel,at91sam9260-pmc", "syscon";
 				reg = <0xfffffc00 0x100>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
index ee0bd1aceb3f..fe9ead867e2a 100644
--- a/arch/arm/boot/dts/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/at91sam9261.dtsi
@@ -599,7 +599,7 @@ pioC: gpio@fffff800 {
 				};
 			};
 
-			pmc: pmc@fffffc00 {
+			pmc: clock-controller@fffffc00 {
 				compatible = "atmel,at91sam9261-pmc", "syscon";
 				reg = <0xfffffc00 0x100>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index 3ce9ea987312..ee5e6ed44dd4 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -101,7 +101,7 @@ aic: interrupt-controller@fffff000 {
 				atmel,external-irqs = <30 31>;
 			};
 
-			pmc: pmc@fffffc00 {
+			pmc: clock-controller@fffffc00 {
 				compatible = "atmel,at91sam9263-pmc", "syscon";
 				reg = <0xfffffc00 0x100>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
index 708e1646b7f4..738a43ffd228 100644
--- a/arch/arm/boot/dts/at91sam9g20.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20.dtsi
@@ -41,7 +41,7 @@ adc0: adc@fffe0000 {
 				atmel,adc-startup-time = <40>;
 			};
 
-			pmc: pmc@fffffc00 {
+			pmc: clock-controller@fffffc00 {
 				compatible = "atmel,at91sam9g20-pmc", "atmel,at91sam9260-pmc", "syscon";
 			};
 		};
diff --git a/arch/arm/boot/dts/at91sam9g25.dtsi b/arch/arm/boot/dts/at91sam9g25.dtsi
index d2f13afb35ea..ec3c77221881 100644
--- a/arch/arm/boot/dts/at91sam9g25.dtsi
+++ b/arch/arm/boot/dts/at91sam9g25.dtsi
@@ -26,7 +26,7 @@ pinctrl@fffff400 {
 				      >;
 			};
 
-			pmc: pmc@fffffc00 {
+			pmc: clock-controller@fffffc00 {
 				compatible = "atmel,at91sam9g25-pmc", "atmel,at91sam9x5-pmc", "syscon";
 			};
 		};
diff --git a/arch/arm/boot/dts/at91sam9g35.dtsi b/arch/arm/boot/dts/at91sam9g35.dtsi
index 48c2bc4a7753..c9cfb93092ee 100644
--- a/arch/arm/boot/dts/at91sam9g35.dtsi
+++ b/arch/arm/boot/dts/at91sam9g35.dtsi
@@ -25,7 +25,7 @@ pinctrl@fffff400 {
 				      >;
 			};
 
-			pmc: pmc@fffffc00 {
+			pmc: clock-controller@fffffc00 {
 				compatible = "atmel,at91sam9g35-pmc", "atmel,at91sam9x5-pmc", "syscon";
 			};
 		};
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 95f5d76234db..76afeb31b7f5 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -129,7 +129,7 @@ matrix: matrix@ffffea00 {
 				reg = <0xffffea00 0x200>;
 			};
 
-			pmc: pmc@fffffc00 {
+			pmc: clock-controller@fffffc00 {
 				compatible = "atmel,at91sam9g45-pmc", "syscon";
 				reg = <0xfffffc00 0x100>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 83114d26f10d..c2e7460fb7ff 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -118,7 +118,7 @@ smc: smc@ffffea00 {
 				reg = <0xffffea00 0x200>;
 			};
 
-			pmc: pmc@fffffc00 {
+			pmc: clock-controller@fffffc00 {
 				compatible = "atmel,at91sam9n12-pmc", "syscon";
 				reg = <0xfffffc00 0x200>;
 				#clock-cells = <2>;
diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
index 364a2ff0a763..a12e6c419fe3 100644
--- a/arch/arm/boot/dts/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/at91sam9rl.dtsi
@@ -763,7 +763,7 @@ pioD: gpio@fffffa00 {
 				};
 			};
 
-			pmc: pmc@fffffc00 {
+			pmc: clock-controller@fffffc00 {
 				compatible = "atmel,at91sam9rl-pmc", "syscon";
 				reg = <0xfffffc00 0x100>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
diff --git a/arch/arm/boot/dts/at91sam9x25.dtsi b/arch/arm/boot/dts/at91sam9x25.dtsi
index 0fe8802e1242..7036f5f04571 100644
--- a/arch/arm/boot/dts/at91sam9x25.dtsi
+++ b/arch/arm/boot/dts/at91sam9x25.dtsi
@@ -27,7 +27,7 @@ pinctrl@fffff400 {
 				      >;
 			};
 
-			pmc: pmc@fffffc00 {
+			pmc: clock-controller@fffffc00 {
 				compatible = "atmel,at91sam9x25-pmc", "atmel,at91sam9x5-pmc", "syscon";
 			};
 		};
diff --git a/arch/arm/boot/dts/at91sam9x35.dtsi b/arch/arm/boot/dts/at91sam9x35.dtsi
index 0bfa21f18f87..eb03b0497e37 100644
--- a/arch/arm/boot/dts/at91sam9x35.dtsi
+++ b/arch/arm/boot/dts/at91sam9x35.dtsi
@@ -26,7 +26,7 @@ pinctrl@fffff400 {
 				      >;
 			};
 
-			pmc: pmc@fffffc00 {
+			pmc: clock-controller@fffffc00 {
 				compatible = "atmel,at91sam9x35-pmc", "atmel,at91sam9x5-pmc", "syscon";
 			};
 		};
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 0c26c925761b..af19ef2a875c 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -126,7 +126,7 @@ smc: smc@ffffea00 {
 				reg = <0xffffea00 0x200>;
 			};
 
-			pmc: pmc@fffffc00 {
+			pmc: clock-controller@fffffc00 {
 				compatible = "atmel,at91sam9x5-pmc", "syscon";
 				reg = <0xfffffc00 0x200>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
diff --git a/arch/arm/boot/dts/sam9x60.dtsi b/arch/arm/boot/dts/sam9x60.dtsi
index 8f5477e307dd..6f5177df01bc 100644
--- a/arch/arm/boot/dts/sam9x60.dtsi
+++ b/arch/arm/boot/dts/sam9x60.dtsi
@@ -660,7 +660,7 @@ pioD: gpio@fffffa00 {
 				};
 			};
 
-			pmc: pmc@fffffc00 {
+			pmc: clock-controller@fffffc00 {
 				compatible = "microchip,sam9x60-pmc", "syscon";
 				reg = <0xfffffc00 0x200>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 14c35c12a115..86009dd28e62 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -284,7 +284,7 @@ dma1: dma-controller@f0004000 {
 				clock-names = "dma_clk";
 			};
 
-			pmc: pmc@f0014000 {
+			pmc: clock-controller@f0014000 {
 				compatible = "atmel,sama5d2-pmc", "syscon";
 				reg = <0xf0014000 0x160>;
 				interrupts = <74 IRQ_TYPE_LEVEL_HIGH 7>;
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index bde8e92d60bb..4524a16322d1 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -1001,7 +1001,7 @@ pioE: gpio@fffffa00 {
 				};
 			};
 
-			pmc: pmc@fffffc00 {
+			pmc: clock-controller@fffffc00 {
 				compatible = "atmel,sama5d3-pmc", "syscon";
 				reg = <0xfffffc00 0x120>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
diff --git a/arch/arm/boot/dts/sama5d3_emac.dtsi b/arch/arm/boot/dts/sama5d3_emac.dtsi
index 45226108850d..5d7ce13de8cc 100644
--- a/arch/arm/boot/dts/sama5d3_emac.dtsi
+++ b/arch/arm/boot/dts/sama5d3_emac.dtsi
@@ -30,7 +30,7 @@ AT91_PIOC 8 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PC8 periph A EMDC, conflicts with
 				};
 			};
 
-			pmc: pmc@fffffc00 {
+			pmc: clock-controller@fffffc00 {
 			};
 
 			macb1: ethernet@f802c000 {
diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index af62157ae214..e94f3a661f4b 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -250,7 +250,7 @@ dma0: dma-controller@f0014000 {
 				clock-names = "dma_clk";
 			};
 
-			pmc: pmc@f0018000 {
+			pmc: clock-controller@f0018000 {
 				compatible = "atmel,sama5d4-pmc", "syscon";
 				reg = <0xf0018000 0x120>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
index ab131762ecb5..f0478a43edc2 100644
--- a/arch/arm/boot/dts/sama7g5.dtsi
+++ b/arch/arm/boot/dts/sama7g5.dtsi
@@ -241,7 +241,7 @@ pioA: pinctrl@e0014000 {
 			clocks = <&pmc PMC_TYPE_PERIPHERAL 11>;
 		};
 
-		pmc: pmc@e0018000 {
+		pmc: clock-controller@e0018000 {
 			compatible = "microchip,sama7g5-pmc", "syscon";
 			reg = <0xe0018000 0x200>;
 			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.34.1

