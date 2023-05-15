Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6131703CC6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244080AbjEOSfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243502AbjEOSf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:35:28 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3258414910;
        Mon, 15 May 2023 11:35:26 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34FIZJBd036911;
        Mon, 15 May 2023 13:35:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684175719;
        bh=wshxfEHZ418+3SVJM4s+YqSXSrYFTAwPpX1FMzbBGNw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=YBi4BoQuU6PAEjEQuPkR/3fHWkefP0xdIJTCaRFthHuHcGhwWCLkfZ1UBUmn/GZL0
         8Dy17RbiDTqWnPxvNHqRxs00q8d2xbxmY2GMeg6IjTTQLoliidzeQS2CxAscqfPVWp
         2cX/DwSdRWiuZe4lGMj5Mml/4jQ0KClBPFxPVx3M=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34FIZJqH076365
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 May 2023 13:35:19 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 May 2023 13:35:19 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 May 2023 13:35:18 -0500
Received: from lelv0327.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34FIZGXR103396;
        Mon, 15 May 2023 13:35:18 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH 5/5] ARM: dts: keystone: Do not capitalize hex digits
Date:   Mon, 15 May 2023 13:35:15 -0500
Message-ID: <20230515183515.509371-5-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515183515.509371-1-afd@ti.com>
References: <20230515183515.509371-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/boot/dts/keystone-k2e-evm.dts    |  2 +-
 arch/arm/boot/dts/keystone-k2e-netcp.dtsi |  2 +-
 arch/arm/boot/dts/keystone-k2g-evm.dts    | 12 ++++++------
 arch/arm/boot/dts/keystone-k2g-ice.dts    | 14 +++++++-------
 arch/arm/boot/dts/keystone-k2g.dtsi       |  6 +++---
 arch/arm/boot/dts/keystone-k2l-evm.dts    |  2 +-
 arch/arm/boot/dts/keystone-k2l.dtsi       | 10 +++++-----
 arch/arm/boot/dts/keystone.dtsi           |  6 +++---
 8 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/arm/boot/dts/keystone-k2e-evm.dts b/arch/arm/boot/dts/keystone-k2e-evm.dts
index 04e0759a2527..6978d6a362f3 100644
--- a/arch/arm/boot/dts/keystone-k2e-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2e-evm.dts
@@ -130,7 +130,7 @@ partition@100000 {
 
 			partition@180000 {
 				label = "ubifs";
-				reg = <0x180000 0x1FE80000>;
+				reg = <0x180000 0x1fe80000>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/keystone-k2e-netcp.dtsi b/arch/arm/boot/dts/keystone-k2e-netcp.dtsi
index 42cf74db673c..bff73a0ed10b 100644
--- a/arch/arm/boot/dts/keystone-k2e-netcp.dtsi
+++ b/arch/arm/boot/dts/keystone-k2e-netcp.dtsi
@@ -167,7 +167,7 @@ cpts_refclk_mux: cpts-refclk-mux {
 						 <&tsipclka>, <&tsrefclk>,
 						 <&tsipclkb>;
 					ti,mux-tbl = <0x0>, <0x1>, <0x2>,
-						<0x3>, <0x4>, <0x8>, <0xC>;
+						<0x3>, <0x4>, <0x8>, <0xc>;
 					assigned-clocks = <&cpts_refclk_mux>;
 					assigned-clock-parents = <&chipclk12>;
 				};
diff --git a/arch/arm/boot/dts/keystone-k2g-evm.dts b/arch/arm/boot/dts/keystone-k2g-evm.dts
index 3a87b7943c70..403eb1854ffe 100644
--- a/arch/arm/boot/dts/keystone-k2g-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2g-evm.dts
@@ -218,16 +218,16 @@ K2G_CORE_IOPAD(0x1228) (BUFFER_CLASS_B | PIN_PULLDOWN  | MUX_MODE1)	/* qspicsn3.
 
 	emac_pins: pinmux_emac_pins {
 		pinctrl-single,pins = <
-			K2G_CORE_IOPAD(0x113C) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_RXD1.RGMII_RXD1 */
+			K2G_CORE_IOPAD(0x113c) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_RXD1.RGMII_RXD1 */
 			K2G_CORE_IOPAD(0x1138) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_RXD2.RGMII_RXD2 */
 			K2G_CORE_IOPAD(0x1134) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_RXD3.RGMII_RXD3 */
 			K2G_CORE_IOPAD(0x1140) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_RXD0.RGMII_RXD0 */
 			K2G_CORE_IOPAD(0x1178) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_TXD0.RGMII_TXD0 */
 			K2G_CORE_IOPAD(0x1174) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_TXD1.RGMII_TXD1 */
 			K2G_CORE_IOPAD(0x1170) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_TXD2.RGMII_TXD2 */
-			K2G_CORE_IOPAD(0x116C) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_TXD3.RGMII_TXD3 */
+			K2G_CORE_IOPAD(0x116c) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_TXD3.RGMII_TXD3 */
 			K2G_CORE_IOPAD(0x1154) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_TXCLK.RGMII_TXC */
-			K2G_CORE_IOPAD(0x117C) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_TXEN.RGMII_TXCTL */
+			K2G_CORE_IOPAD(0x117c) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_TXEN.RGMII_TXCTL */
 			K2G_CORE_IOPAD(0x1120) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_RXCLK.RGMII_RXC */
 			K2G_CORE_IOPAD(0x1144) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_RXDV.RGMII_RXCTL */
 		>;
@@ -235,7 +235,7 @@ K2G_CORE_IOPAD(0x1144) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_RXDV.R
 
 	mdio_pins: pinmux_mdio_pins {
 		pinctrl-single,pins = <
-			K2G_CORE_IOPAD(0x118C) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0)	/* MDIO_CLK.MDIO_CLK */
+			K2G_CORE_IOPAD(0x118c) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0)	/* MDIO_CLK.MDIO_CLK */
 			K2G_CORE_IOPAD(0x1188) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0)	/* MDIO_DATA.MDIO_DATA */
 		>;
 	};
@@ -424,11 +424,11 @@ partition@3 {
 		};
 		partition@4 {
 			label = "QSPI.kernel";
-			reg = <0x001C0000 0x0800000>;
+			reg = <0x001c0000 0x0800000>;
 		};
 		partition@5 {
 			label = "QSPI.file-system";
-			reg = <0x009C0000 0x3640000>;
+			reg = <0x009c0000 0x3640000>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/keystone-k2g-ice.dts b/arch/arm/boot/dts/keystone-k2g-ice.dts
index bd84d7f0f2fe..b94615521172 100644
--- a/arch/arm/boot/dts/keystone-k2g-ice.dts
+++ b/arch/arm/boot/dts/keystone-k2g-ice.dts
@@ -239,15 +239,15 @@ K2G_CORE_IOPAD(0x121c) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0) /* qspi_csn0.
 
 	mmc1_pins: pinmux_mmc1_pins {
 		pinctrl-single,pins = <
-			K2G_CORE_IOPAD(0x10FC) (BUFFER_CLASS_B | PIN_PULLUP | MUX_MODE0)	/* mmc1_dat3.mmc1_dat3 */
+			K2G_CORE_IOPAD(0x10fc) (BUFFER_CLASS_B | PIN_PULLUP | MUX_MODE0)	/* mmc1_dat3.mmc1_dat3 */
 			K2G_CORE_IOPAD(0x1100) (BUFFER_CLASS_B | PIN_PULLUP | MUX_MODE0)	/* mmc1_dat2.mmc1_dat2 */
 			K2G_CORE_IOPAD(0x1104) (BUFFER_CLASS_B | PIN_PULLUP | MUX_MODE0)	/* mmc1_dat1.mmc1_dat1 */
 			K2G_CORE_IOPAD(0x1108) (BUFFER_CLASS_B | PIN_PULLUP | MUX_MODE0)	/* mmc1_dat0.mmc1_dat0 */
-			K2G_CORE_IOPAD(0x110C) (BUFFER_CLASS_B | PIN_PULLUP | MUX_MODE0)	/* mmc1_clk.mmc1_clk */
+			K2G_CORE_IOPAD(0x110c) (BUFFER_CLASS_B | PIN_PULLUP | MUX_MODE0)	/* mmc1_clk.mmc1_clk */
 			K2G_CORE_IOPAD(0x1110) (BUFFER_CLASS_B | PIN_PULLUP | MUX_MODE0)	/* mmc1_cmd.mmc1_cmd */
 			K2G_CORE_IOPAD(0x1114) (BUFFER_CLASS_B | PIN_PULLUP | MUX_MODE3)	/* mmc1_sdcd.gpio0_69 */
 			K2G_CORE_IOPAD(0x1118) (BUFFER_CLASS_B | PIN_PULLUP | MUX_MODE0)	/* mmc1_sdwp.mmc1_sdwp */
-			K2G_CORE_IOPAD(0x111C) (BUFFER_CLASS_B | PIN_PULLUP | MUX_MODE0)	/* mmc1_pow.mmc1_pow */
+			K2G_CORE_IOPAD(0x111c) (BUFFER_CLASS_B | PIN_PULLUP | MUX_MODE0)	/* mmc1_pow.mmc1_pow */
 		>;
 	};
 
@@ -285,16 +285,16 @@ K2G_CORE_IOPAD(0x11bc) (BUFFER_CLASS_B | PIN_PULLUP | MUX_MODE3)	/* spi2_scsn1.g
 
 	emac_pins: pinmux_emac_pins {
 		pinctrl-single,pins = <
-			K2G_CORE_IOPAD(0x113C) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_RXD1.RGMII_RXD1 */
+			K2G_CORE_IOPAD(0x113c) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_RXD1.RGMII_RXD1 */
 			K2G_CORE_IOPAD(0x1138) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_RXD2.RGMII_RXD2 */
 			K2G_CORE_IOPAD(0x1134) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_RXD3.RGMII_RXD3 */
 			K2G_CORE_IOPAD(0x1140) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_RXD0.RGMII_RXD0 */
 			K2G_CORE_IOPAD(0x1178) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_TXD0.RGMII_TXD0 */
 			K2G_CORE_IOPAD(0x1174) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_TXD1.RGMII_TXD1 */
 			K2G_CORE_IOPAD(0x1170) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_TXD2.RGMII_TXD2 */
-			K2G_CORE_IOPAD(0x116C) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_TXD3.RGMII_TXD3 */
+			K2G_CORE_IOPAD(0x116c) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_TXD3.RGMII_TXD3 */
 			K2G_CORE_IOPAD(0x1154) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_TXCLK.RGMII_TXC */
-			K2G_CORE_IOPAD(0x117C) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_TXEN.RGMII_TXCTL */
+			K2G_CORE_IOPAD(0x117c) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_TXEN.RGMII_TXCTL */
 			K2G_CORE_IOPAD(0x1120) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_RXCLK.RGMII_RXC */
 			K2G_CORE_IOPAD(0x1144) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_RXDV.RGMII_RXCTL */
 		>;
@@ -302,7 +302,7 @@ K2G_CORE_IOPAD(0x1144) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_RXDV.R
 
 	mdio_pins: pinmux_mdio_pins {
 		pinctrl-single,pins = <
-			K2G_CORE_IOPAD(0x118C) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0)	/* MDIO_CLK.MDIO_CLK */
+			K2G_CORE_IOPAD(0x118c) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0)	/* MDIO_CLK.MDIO_CLK */
 			K2G_CORE_IOPAD(0x1188) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0)	/* MDIO_DATA.MDIO_DATA */
 		>;
 	};
diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
index 380dd9d637ee..102d59694d90 100644
--- a/arch/arm/boot/dts/keystone-k2g.dtsi
+++ b/arch/arm/boot/dts/keystone-k2g.dtsi
@@ -177,7 +177,7 @@ uart2: serial@2531400 {
 
 		dcan0: can@260b200 {
 			compatible = "ti,am4372-d_can", "ti,am3352-d_can";
-			reg = <0x0260B200 0x200>;
+			reg = <0x0260b200 0x200>;
 			interrupts = <GIC_SPI 190 IRQ_TYPE_EDGE_RISING>;
 			status = "disabled";
 			power-domains = <&k2g_pds 0x0008>;
@@ -186,7 +186,7 @@ dcan0: can@260b200 {
 
 		dcan1: can@260b400 {
 			compatible = "ti,am4372-d_can", "ti,am3352-d_can";
-			reg = <0x0260B400 0x200>;
+			reg = <0x0260b400 0x200>;
 			interrupts = <GIC_SPI 193 IRQ_TYPE_EDGE_RISING>;
 			status = "disabled";
 			power-domains = <&k2g_pds 0x0009>;
@@ -593,7 +593,7 @@ spi1: spi@21805800 {
 
 		spi2: spi@21805c00 {
 			compatible = "ti,keystone-spi";
-			reg = <0x21805C00 0x200>;
+			reg = <0x21805c00 0x200>;
 			num-cs = <4>;
 			ti,davinci-spi-intr-line = <0>;
 			interrupts = <GIC_SPI 68 IRQ_TYPE_EDGE_RISING>;
diff --git a/arch/arm/boot/dts/keystone-k2l-evm.dts b/arch/arm/boot/dts/keystone-k2l-evm.dts
index 8e15a26a3a7e..be619e39a16f 100644
--- a/arch/arm/boot/dts/keystone-k2l-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2l-evm.dts
@@ -103,7 +103,7 @@ partition@100000 {
 
 			partition@180000 {
 				label = "ubifs";
-				reg = <0x180000 0x7FE80000>;
+				reg = <0x180000 0x7fe80000>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/keystone-k2l.dtsi b/arch/arm/boot/dts/keystone-k2l.dtsi
index 421a02bbc9d3..084de2ce03e7 100644
--- a/arch/arm/boot/dts/keystone-k2l.dtsi
+++ b/arch/arm/boot/dts/keystone-k2l.dtsi
@@ -170,7 +170,7 @@ gpio_emu_pins: pinmux_gpio_emu_pins {
 				 * GPIO_EMU_SEL[18]: 0-GPIO18, 1-EMU20
 				 * GPIO_EMU_SEL[17]: 0-GPIO17, 1-EMU19
 				 */
-					0x4 0x0000 0xFFFE0000
+					0x4 0x0000 0xfffe0000
 				>;
 			};
 
@@ -190,7 +190,7 @@ gpio_timio_pins: pinmux_gpio_timio_pins {
 				 * GPIO_TIMIO_SEL[5]: 0-GPIO5, 1-TIMI3
 				 * GPIO_TIMIO_SEL[4]: 0-GPIO4, 1-TIMI2
 				 */
-					0x4 0x0 0xFFF0
+					0x4 0x0 0xfff0
 				>;
 			};
 
@@ -202,7 +202,7 @@ gpio_spi2cs_pins: pinmux_gpio_spi2cs_pins {
 				 * GPIO_SPI2CS_SEL[1]: 0-GPIO1, 1-SPI2CS2
 				 * GPIO_SPI2CS_SEL[0]: 0-GPIO0, 1-SPI2CS1
 				 */
-					0x4 0x0 0xF
+					0x4 0x0 0xf
 				>;
 			};
 
@@ -226,7 +226,7 @@ gpio_dfeio_pins: pinmux_gpio_dfeio_pins {
 				 * GPIO_DFEIO_SEL[17]: 0-DFEIO3, 1-GPIO49
 				 * GPIO_DFEIO_SEL[16]: 0-DFEIO2, 1-GPIO48
 				 */
-					0x8 0x0 0xFFFF0000
+					0x8 0x0 0xffff0000
 				>;
 			};
 
@@ -250,7 +250,7 @@ gpio_emifa_pins: pinmux_gpio_emifa_pins {
 				 * GPIO_EMIFA_SEL[1]: 0-EMIFA1, 1-GPIO33
 				 * GPIO_EMIFA_SEL[0]: 0-EMIFA0, 1-GPIO32
 				 */
-					0x8 0x0 0xFFFF
+					0x8 0x0 0xffff
 				>;
 			};
 		};
diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index 552ecd546cfd..1fd04bb37a15 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -282,7 +282,7 @@ gpio0: gpio@260bf00 {
 			ti,davinci-gpio-unbanked = <32>;
 		};
 
-		aemif: aemif@21000A00 {
+		aemif: aemif@21000a00 {
 			compatible = "ti,keystone-aemif", "ti,davinci-aemif";
 			#address-cells = <2>;
 			#size-cells = <1>;
@@ -290,9 +290,9 @@ aemif: aemif@21000A00 {
 			clock-names = "aemif";
 			clock-ranges;
 
-			reg = <0x21000A00 0x00000100>;
+			reg = <0x21000a00 0x00000100>;
 			ranges = <0 0 0x30000000 0x10000000
-				  1 0 0x21000A00 0x00000100>;
+				  1 0 0x21000a00 0x00000100>;
 		};
 
 		pcie0: pcie@21800000 {
-- 
2.39.2

