Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3903D68D51E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 12:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjBGLHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 06:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjBGLHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 06:07:39 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB4737F2A;
        Tue,  7 Feb 2023 03:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675768057; x=1707304057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mjHwzmjVx5AsDKi0vsPeqIFr4VuECLn5thzx9mG1050=;
  b=jG7OAO+99gFZsNpY4WOSvsQPAy5JJHWHsLEWN77u2Q/EiFfKSI5d1N7X
   NBB0BwoMeMnXRlfA/bNHLNHv/ws5/GbUELjzxZHy8XNe6uO0x+WwkXzCi
   bnd5Kb3TSkPWtXU0+SH30BGB3cf7uttiMMpCiMcgdOLvVy0qjrUYhckRk
   Ylhb/zEWRyTvIAbUWsWwS/AF0QQI3G9WidCcT6XyQPKP78jmb9Nyjpprn
   uSEcYOuvsMZ5oYFFdLDMosWIuD93vvwZvz5BTjLlY3lLbkZcLSkEbN87n
   K3Q5rZXnYZO0r8nEv8RYqzpUKgLZjgt5OySG3XAPe602fsB8mStR+nWVx
   g==;
X-IronPort-AV: E=Sophos;i="5.97,278,1669100400"; 
   d="scan'208";a="210907328"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Feb 2023 04:07:37 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 7 Feb 2023 04:07:36 -0700
Received: from che-lt-i66125lx.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Tue, 7 Feb 2023 04:07:27 -0700
From:   Durai Manickam KR <durai.manickamkr@microchip.com>
To:     <Hari.PrasathGE@microchip.com>,
        <balamanikandan.gunasundar@microchip.com>,
        <manikandan.m@microchip.com>, <varshini.rajendran@microchip.com>,
        <dharma.b@microchip.com>, <nayabbasha.sayed@microchip.com>,
        <balakrishnan.s@microchip.com>, <claudiu.beznea@microchip.com>,
        <cristian.birsan@microchip.com>, <nicolas.ferre@microchip.com>,
        <krzysztof.kozlowski@linaro.org>, <alexandre.belloni@bootlin.com>,
        <davem@davemloft.net>, <arnd@arndb.de>, <olof@lixom.net>,
        <soc@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>,
        <Horatiu.Vultur@microchip.com>, <robh+dt@kernel.org>,
        <andrew@lunn.ch>, <michael@walle.cc>, <jerry.ray@microchip.com>
CC:     Durai Manickam KR <durai.manickamkr@microchip.com>
Subject: [PATCH v6 2/8] ARM: dts: at91: sam9x60: move flexcom definitions
Date:   Tue, 7 Feb 2023 16:36:45 +0530
Message-ID: <20230207110651.197268-3-durai.manickamkr@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230207110651.197268-1-durai.manickamkr@microchip.com>
References: <20230207110651.197268-1-durai.manickamkr@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manikandan Muralidharan <manikandan.m@microchip.com>

Move the flexcom definitions from board specific DTS file
to the SoC specific DTSI file for sam9x60ek.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
Signed-off-by: Hari Prasath Gujulan Elango <Hari.PrasathGE@microchip.com>
[durai.manickamkr@microchip.com: Logical split-up of this patch and added
 missing UART5 compatibles]
Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-sam9x60ek.dts | 33 +------------------
 arch/arm/boot/dts/sam9x60.dtsi       | 49 ++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 32 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sam9x60ek.dts b/arch/arm/boot/dts/at91-sam9x60ek.dts
index cf5d786531f2..4ff84633dd43 100644
--- a/arch/arm/boot/dts/at91-sam9x60ek.dts
+++ b/arch/arm/boot/dts/at91-sam9x60ek.dts
@@ -207,15 +207,10 @@ &flx0 {
 	status = "okay";
 
 	i2c0: i2c@600 {
-		compatible = "microchip,sam9x60-i2c";
-		reg = <0x600 0x200>;
-		interrupts = <5 IRQ_TYPE_LEVEL_HIGH 7>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_flx0_default>;
-		atmel,fifo-size = <16>;
 		i2c-analog-filter;
 		i2c-digital-filter;
 		i2c-digital-filter-width-ns = <35>;
@@ -235,14 +230,8 @@ &flx4 {
 	status = "disabled";
 
 	spi4: spi@400 {
-		compatible = "microchip,sam9x60-spi", "atmel,at91rm9200-spi";
-		reg = <0x400 0x200>;
-		interrupts = <13 IRQ_TYPE_LEVEL_HIGH 7>;
-		clocks = <&pmc PMC_TYPE_PERIPHERAL 13>;
-		clock-names = "spi_clk";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_flx4_default>;
-		atmel,fifo-size = <16>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -254,23 +243,8 @@ &flx5 {
 	status = "okay";
 
 	uart5: serial@200 {
-		compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
-		reg = <0x200 0x200>;
-		atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
-		interrupts = <14 IRQ_TYPE_LEVEL_HIGH 7>;
-		dmas = <&dma0
-			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
-			 AT91_XDMAC_DT_PERID(10))>,
-		       <&dma0
-			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
-			 AT91_XDMAC_DT_PERID(11))>;
-		dma-names = "tx", "rx";
-		clocks = <&pmc PMC_TYPE_PERIPHERAL 14>;
-		clock-names = "usart";
-		pinctrl-0 = <&pinctrl_flx5_default>;
 		pinctrl-names = "default";
-		atmel,use-dma-rx;
-		atmel,use-dma-tx;
+		pinctrl-0 = <&pinctrl_flx5_default>;
 		status = "okay";
 	};
 };
@@ -280,15 +254,10 @@ &flx6 {
 	status = "okay";
 
 	i2c6: i2c@600 {
-		compatible = "microchip,sam9x60-i2c";
-		reg = <0x600 0x200>;
-		interrupts = <9 IRQ_TYPE_LEVEL_HIGH 7>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		clocks = <&pmc PMC_TYPE_PERIPHERAL 9>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_flx6_default>;
-		atmel,fifo-size = <16>;
 		i2c-analog-filter;
 		i2c-digital-filter;
 		i2c-digital-filter-width-ns = <35>;
diff --git a/arch/arm/boot/dts/sam9x60.dtsi b/arch/arm/boot/dts/sam9x60.dtsi
index 8f5477e307dd..ee6cc4329ae4 100644
--- a/arch/arm/boot/dts/sam9x60.dtsi
+++ b/arch/arm/boot/dts/sam9x60.dtsi
@@ -170,6 +170,16 @@ flx4: flexcom@f0000000 {
 				#size-cells = <1>;
 				ranges = <0x0 0xf0000000 0x800>;
 				status = "disabled";
+
+				spi4: spi@400 {
+					compatible = "microchip,sam9x60-spi", "atmel,at91rm9200-spi";
+					reg = <0x400 0x200>;
+					interrupts = <13 IRQ_TYPE_LEVEL_HIGH 7>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 13>;
+					clock-names = "spi_clk";
+					atmel,fifo-size = <16>;
+					status = "disabled";
+				};
 			};
 
 			flx5: flexcom@f0004000 {
@@ -180,6 +190,27 @@ flx5: flexcom@f0004000 {
 				#size-cells = <1>;
 				ranges = <0x0 0xf0004000 0x800>;
 				status = "disabled";
+
+				uart5: serial@200 {
+					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
+					reg = <0x200 0x200>;
+					atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
+					interrupts = <14 IRQ_TYPE_LEVEL_HIGH 7>;
+					dmas = <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(10))>,
+						<&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(11))>;
+					dma-names = "tx", "rx";
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 14>;
+					clock-names = "usart";
+					atmel,use-dma-rx;
+					atmel,use-dma-tx;
+					status = "disabled";
+				};
 			};
 
 			dma0: dma-controller@f0008000 {
@@ -379,6 +410,15 @@ flx6: flexcom@f8010000 {
 				#size-cells = <1>;
 				ranges = <0x0 0xf8010000 0x800>;
 				status = "disabled";
+
+				i2c6: i2c@600 {
+					compatible = "microchip,sam9x60-i2c";
+					reg = <0x600 0x200>;
+					interrupts = <9 IRQ_TYPE_LEVEL_HIGH 7>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 9>;
+					atmel,fifo-size = <16>;
+					status = "disabled";
+				};
 			};
 
 			flx7: flexcom@f8014000 {
@@ -409,6 +449,15 @@ flx0: flexcom@f801c000 {
 				#size-cells = <1>;
 				ranges = <0x0 0xf801c000 0x800>;
 				status = "disabled";
+
+				i2c0: i2c@600 {
+					compatible = "microchip,sam9x60-i2c";
+					reg = <0x600 0x200>;
+					interrupts = <5 IRQ_TYPE_LEVEL_HIGH 7>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
+					atmel,fifo-size = <16>;
+					status = "disabled";
+				};
 			};
 
 			flx1: flexcom@f8020000 {
-- 
2.25.1

