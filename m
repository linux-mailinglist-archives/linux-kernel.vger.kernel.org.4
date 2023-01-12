Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AF56670A2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 12:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbjALLMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 06:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234574AbjALLLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 06:11:32 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9E354D93;
        Thu, 12 Jan 2023 03:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1673521414; x=1705057414;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7gEu6I36i1hzbcgZIGRY2LYU3oYqD4nh5FMSzlezAh8=;
  b=AZm/bmkJeVY1ZdkI79OEi1FCK/exWSqfaTx1vvoo0+BfI7yFGroPg2Jl
   9xeZanJMLi4PrDIPR4eZ1/rL1X69eFC38HWboRGqgI8/h+YSR95yo6dVo
   BBa/Afr4wk65o7IBxJ+EIVD7l22XCPQLUlWJ/Wq46HMm1mak0Mh9DMJt8
   OneeIDFnuu6UH9Z4jd13Y+is5ZsoOUAQQ1riWVN7idejRBGDCj+uD+0c4
   imL/nGREfStsp2+0epkzSXPA41EvFzNhtjdpJQ+NL2DsPOlfehqgx6css
   48NQdzGZ2wLZ+039OIg4sBniJgQhEqHQDPa5LJTkiyP7MgBk3MSbfQHlF
   g==;
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="195432661"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jan 2023 04:03:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 12 Jan 2023 04:03:32 -0700
Received: from che-lt-i66125lx.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Thu, 12 Jan 2023 04:03:24 -0700
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
Subject: [PATCH v4 5/8] ARM: dts: at91: sam9x60: Add DMA bindings for the flexcom nodes
Date:   Thu, 12 Jan 2023 16:32:05 +0530
Message-ID: <20230112110208.97946-6-durai.manickamkr@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230112110208.97946-1-durai.manickamkr@microchip.com>
References: <20230112110208.97946-1-durai.manickamkr@microchip.com>
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

Add dma bindings for flexcom nodes in the soc dtsi file. Users those who
don't wish to use the DMA function for their flexcom functions can
overwrite the dma bindings in the board device tree file.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
[durai.manickamkr@microchip.com: fixed code indentation and updated commit log]
Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
---
 arch/arm/boot/dts/at91-sam9x60ek.dts |  3 +++
 arch/arm/boot/dts/sam9x60.dtsi       | 27 +++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sam9x60ek.dts b/arch/arm/boot/dts/at91-sam9x60ek.dts
index 6b6391d5041e..180e4b1aa2f6 100644
--- a/arch/arm/boot/dts/at91-sam9x60ek.dts
+++ b/arch/arm/boot/dts/at91-sam9x60ek.dts
@@ -209,6 +209,7 @@ &flx0 {
 	i2c0: i2c@600 {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		dmas = <0>, <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_flx0_default>;
 		i2c-analog-filter;
@@ -230,6 +231,7 @@ &flx4 {
 	status = "disabled";
 
 	spi4: spi@400 {
+		dmas = <0>, <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_flx4_default>;
 		status = "disabled";
@@ -254,6 +256,7 @@ &flx6 {
 	i2c6: i2c@600 {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		dmas = <0>, <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_flx6_default>;
 		i2c-analog-filter;
diff --git a/arch/arm/boot/dts/sam9x60.dtsi b/arch/arm/boot/dts/sam9x60.dtsi
index fbdde3ab1086..8f44854dd8fa 100644
--- a/arch/arm/boot/dts/sam9x60.dtsi
+++ b/arch/arm/boot/dts/sam9x60.dtsi
@@ -177,6 +177,15 @@ spi4: spi@400 {
 					interrupts = <13 IRQ_TYPE_LEVEL_HIGH 7>;
 					clocks = <&pmc PMC_TYPE_PERIPHERAL 13>;
 					clock-names = "spi_clk";
+					dmas = <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(8))>,
+						<&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(9))>;
+					dma-names = "tx", "rx";
 					atmel,fifo-size = <16>;
 					status = "disabled";
 				};
@@ -417,6 +426,15 @@ i2c6: i2c@600 {
 					reg = <0x600 0x200>;
 					interrupts = <9 IRQ_TYPE_LEVEL_HIGH 7>;
 					clocks = <&pmc PMC_TYPE_PERIPHERAL 9>;
+					dmas = <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(12))>,
+						<&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(13))>;
+					dma-names = "tx", "rx";
 					atmel,fifo-size = <16>;
 					status = "disabled";
 				};
@@ -456,6 +474,15 @@ i2c0: i2c@600 {
 					reg = <0x600 0x200>;
 					interrupts = <5 IRQ_TYPE_LEVEL_HIGH 7>;
 					clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
+					dmas = <&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(0))>,
+						<&dma0
+						(AT91_XDMAC_DT_MEM_IF(0) |
+						 AT91_XDMAC_DT_PER_IF(1) |
+						 AT91_XDMAC_DT_PERID(1))>;
+					dma-names = "tx", "rx";
 					atmel,fifo-size = <16>;
 					status = "disabled";
 				};
-- 
2.25.1

