Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B006B07C6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjCHNBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjCHNAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:00:37 -0500
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [IPv6:2001:1600:4:17::42ac])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42575C4896
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 04:59:59 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PWsg80Sv6zMrJLs;
        Wed,  8 Mar 2023 13:53:08 +0100 (CET)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PWsg743kjzMslsy;
        Wed,  8 Mar 2023 13:53:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1678279987;
        bh=0KAwqvIgg9/0Mq+uUMxM4YRpUOrpWCRDq7xH7wNe5sA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OV3MhJa0rPPLMguGAZU2jGj//1aWfyEX69f9xxQAZXV9lLSb7Rlg+n8ZlEaiaLwtH
         bQVFrxiimJeqp8DQEt3qODRaZRVUtiERLKh860NOa5tsfQ7EMeHHkfJ7qH5GIJ3bxP
         bExMTK6nnkdVLhCeceq9CwMsCndZZUeA9YU4GL18=
From:   Philippe Schenker <dev@pschenker.ch>
To:     devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 03/25] arm64: dts: colibri-imx8x: Sort properties
Date:   Wed,  8 Mar 2023 13:52:37 +0100
Message-Id: <20230308125300.58244-4-dev@pschenker.ch>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308125300.58244-1-dev@pschenker.ch>
References: <20230308125300.58244-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        UPPERCASE_50_75,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Sort properties according to the following order and inside these
alphabetically.

1. compatible
2. reg
3. standard properties
4. specific properties
5. status

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

 .../boot/dts/freescale/imx8x-colibri.dtsi     | 142 +++++++++---------
 1 file changed, 71 insertions(+), 71 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
index 12056b77d22e..6f86a83bc957 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
@@ -10,9 +10,9 @@ chosen {
 
 	reg_module_3v3: regulator-module-3v3 {
 		compatible = "regulator-fixed";
-		regulator-name = "+V3.3";
-		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "+V3.3";
 	};
 };
 
@@ -20,26 +20,26 @@ reg_module_3v3: regulator-module-3v3 {
 &i2c0 {
 	#address-cells = <1>;
 	#size-cells = <0>;
-	clock-frequency = <100000>;
-	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c0>, <&pinctrl_sgtl5000_usb_clk>;
+	pinctrl-names = "default";
+	clock-frequency = <100000>;
 	status = "okay";
 
 	/* Touch controller */
 	touchscreen@2c {
 		compatible = "adi,ad7879-1";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_ad7879_int>;
 		reg = <0x2c>;
 		interrupt-parent = <&lsio_gpio3>;
 		interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
-		touchscreen-max-pressure = <4096>;
-		adi,resistance-plate-x = <120>;
-		adi,first-conversion-delay = /bits/ 8 <3>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ad7879_int>;
 		adi,acquisition-time = /bits/ 8 <1>;
-		adi,median-filter-size = /bits/ 8 <2>;
 		adi,averaging = /bits/ 8 <1>;
 		adi,conversion-interval = /bits/ 8 <255>;
+		adi,first-conversion-delay = /bits/ 8 <3>;
+		adi,median-filter-size = /bits/ 8 <2>;
+		adi,resistance-plate-x = <120>;
+		touchscreen-max-pressure = <4096>;
 	};
 };
 
@@ -47,9 +47,9 @@ touchscreen@2c {
 &i2c1 {
 	#address-cells = <1>;
 	#size-cells = <0>;
-	clock-frequency = <100000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c1>;
+	clock-frequency = <100000>;
 };
 
 /* Colibri UART_B */
@@ -75,9 +75,9 @@ &fec1 {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&pinctrl_fec1>;
 	pinctrl-1 = <&pinctrl_fec1_sleep>;
-	phy-mode = "rmii";
-	phy-handle = <&ethphy0>;
 	fsl,magic-packet;
+	phy-handle = <&ethphy0>;
+	phy-mode = "rmii";
 
 	mdio {
 		#address-cells = <1>;
@@ -85,36 +85,36 @@ mdio {
 
 		ethphy0: ethernet-phy@2 {
 			compatible = "ethernet-phy-ieee802.3-c22";
-			max-speed = <100>;
 			reg = <2>;
+			max-speed = <100>;
 		};
 	};
 };
 
 /* On-module eMMC */
 &usdhc1 {
-	bus-width = <8>;
-	non-removable;
-	no-sd;
-	no-sdio;
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc1>;
 	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
 	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	bus-width = <8>;
+	no-sd;
+	no-sdio;
+	non-removable;
 	status = "okay";
 };
 
 /* Colibri SD/MMC Card */
 &usdhc2 {
-	bus-width = <4>;
-	cd-gpios = <&lsio_gpio3 9 GPIO_ACTIVE_LOW>;
-	vmmc-supply = <&reg_module_3v3>;
 	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
 	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
 	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
 	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
 	pinctrl-3 = <&pinctrl_usdhc2_sleep>, <&pinctrl_usdhc2_gpio_sleep>;
+	bus-width = <4>;
+	cd-gpios = <&lsio_gpio3 9 GPIO_ACTIVE_LOW>;
 	disable-wp;
+	vmmc-supply = <&reg_module_3v3>;
 };
 
 &iomuxc {
@@ -162,14 +162,14 @@ pinctrl_fec1: fec1grp {
 		fsl,pins = <
 			IMX8QXP_ENET0_MDC_CONN_ENET0_MDC			0x06000020
 			IMX8QXP_ENET0_MDIO_CONN_ENET0_MDIO			0x06000020
-			IMX8QXP_ENET0_RGMII_TX_CTL_CONN_ENET0_RGMII_TX_CTL	0x61
-			IMX8QXP_ENET0_RGMII_TXC_CONN_ENET0_RCLK50M_OUT		0x06000061
-			IMX8QXP_ENET0_RGMII_TXD0_CONN_ENET0_RGMII_TXD0		0x61
-			IMX8QXP_ENET0_RGMII_TXD1_CONN_ENET0_RGMII_TXD1		0x61
 			IMX8QXP_ENET0_RGMII_RX_CTL_CONN_ENET0_RGMII_RX_CTL	0x61
 			IMX8QXP_ENET0_RGMII_RXD0_CONN_ENET0_RGMII_RXD0		0x61
 			IMX8QXP_ENET0_RGMII_RXD1_CONN_ENET0_RGMII_RXD1		0x61
 			IMX8QXP_ENET0_RGMII_RXD2_CONN_ENET0_RMII_RX_ER		0x61
+			IMX8QXP_ENET0_RGMII_TX_CTL_CONN_ENET0_RGMII_TX_CTL	0x61
+			IMX8QXP_ENET0_RGMII_TXC_CONN_ENET0_RCLK50M_OUT		0x06000061
+			IMX8QXP_ENET0_RGMII_TXD0_CONN_ENET0_RGMII_TXD0		0x61
+			IMX8QXP_ENET0_RGMII_TXD1_CONN_ENET0_RGMII_TXD1		0x61
 		>;
 	};
 
@@ -177,38 +177,38 @@ pinctrl_fec1_sleep: fec1slpgrp {
 		fsl,pins = <
 			IMX8QXP_ENET0_MDC_LSIO_GPIO5_IO11		0x06000041
 			IMX8QXP_ENET0_MDIO_LSIO_GPIO5_IO10		0x06000041
-			IMX8QXP_ENET0_RGMII_TX_CTL_LSIO_GPIO4_IO30	0x41
-			IMX8QXP_ENET0_RGMII_TXC_LSIO_GPIO4_IO29		0x41
-			IMX8QXP_ENET0_RGMII_TXD0_LSIO_GPIO4_IO31	0x41
-			IMX8QXP_ENET0_RGMII_TXD1_LSIO_GPIO5_IO00	0x41
 			IMX8QXP_ENET0_RGMII_RX_CTL_LSIO_GPIO5_IO04	0x41
 			IMX8QXP_ENET0_RGMII_RXD0_LSIO_GPIO5_IO05	0x41
 			IMX8QXP_ENET0_RGMII_RXD1_LSIO_GPIO5_IO06	0x41
 			IMX8QXP_ENET0_RGMII_RXD2_LSIO_GPIO5_IO07	0x41
+			IMX8QXP_ENET0_RGMII_TX_CTL_LSIO_GPIO4_IO30	0x41
+			IMX8QXP_ENET0_RGMII_TXC_LSIO_GPIO4_IO29		0x41
+			IMX8QXP_ENET0_RGMII_TXD0_LSIO_GPIO4_IO31	0x41
+			IMX8QXP_ENET0_RGMII_TXD1_LSIO_GPIO5_IO00	0x41
 		>;
 	};
 
 	/* Colibri optional CAN on UART_B RTS/CTS */
 	pinctrl_flexcan1: flexcan0grp {
 		fsl,pins = <
-			IMX8QXP_FLEXCAN0_TX_ADMA_FLEXCAN0_TX		0x21		/* SODIMM  32 */
 			IMX8QXP_FLEXCAN0_RX_ADMA_FLEXCAN0_RX		0x21		/* SODIMM  34 */
+			IMX8QXP_FLEXCAN0_TX_ADMA_FLEXCAN0_TX		0x21		/* SODIMM  32 */
 		>;
 	};
 
 	/* Colibri optional CAN on PS2 */
 	pinctrl_flexcan2: flexcan1grp {
 		fsl,pins = <
-			IMX8QXP_FLEXCAN1_TX_ADMA_FLEXCAN1_TX		0x21		/* SODIMM  55 */
 			IMX8QXP_FLEXCAN1_RX_ADMA_FLEXCAN1_RX		0x21		/* SODIMM  63 */
+			IMX8QXP_FLEXCAN1_TX_ADMA_FLEXCAN1_TX		0x21		/* SODIMM  55 */
 		>;
 	};
 
 	/* Colibri optional CAN on UART_A TXD/RXD */
 	pinctrl_flexcan3: flexcan2grp {
 		fsl,pins = <
-			IMX8QXP_FLEXCAN2_TX_ADMA_FLEXCAN2_TX		0x21		/* SODIMM  35 */
 			IMX8QXP_FLEXCAN2_RX_ADMA_FLEXCAN2_RX		0x21		/* SODIMM  33 */
+			IMX8QXP_FLEXCAN2_TX_ADMA_FLEXCAN2_TX		0x21		/* SODIMM  35 */
 		>;
 	};
 
@@ -227,32 +227,32 @@ IMX8QXP_QSPI0A_DATA1_LSIO_GPIO3_IO10		0x06700041	/* SODIMM  45 */
 
 	pinctrl_hog0: hog0grp {
 		fsl,pins = <
-			IMX8QXP_ENET0_RGMII_TXD3_LSIO_GPIO5_IO02	0x06000020	/* SODIMM  65 */
-			IMX8QXP_CSI_D07_CI_PI_D09			0x61		/* SODIMM  65 */
-			IMX8QXP_QSPI0A_DATA2_LSIO_GPIO3_IO11		0x20		/* SODIMM  69 */
-			IMX8QXP_SAI0_TXC_LSIO_GPIO0_IO26		0x20		/* SODIMM  79 */
+			IMX8QXP_CSI_D00_CI_PI_D02			0x61		/* SODIMM 101 */
+			IMX8QXP_CSI_D01_CI_PI_D03			0x61		/* SODIMM 103 */
 			IMX8QXP_CSI_D02_CI_PI_D04			0x61		/* SODIMM  79 */
-			IMX8QXP_ENET0_RGMII_RXC_LSIO_GPIO5_IO03		0x06000020	/* SODIMM  85 */
-			IMX8QXP_CSI_D06_CI_PI_D08			0x61		/* SODIMM  85 */
-			IMX8QXP_QSPI0B_SCLK_LSIO_GPIO3_IO17		0x20		/* SODIMM  95 */
-			IMX8QXP_SAI0_RXD_LSIO_GPIO0_IO27		0x20		/* SODIMM  97 */
 			IMX8QXP_CSI_D03_CI_PI_D05			0x61		/* SODIMM  97 */
+			IMX8QXP_CSI_D06_CI_PI_D08			0x61		/* SODIMM  85 */
+			IMX8QXP_CSI_D07_CI_PI_D09			0x61		/* SODIMM  65 */
+			IMX8QXP_CSI_PCLK_LSIO_GPIO3_IO00		0x20		/* SODIMM  96 */
+			IMX8QXP_ENET0_RGMII_RXC_LSIO_GPIO5_IO03		0x06000020	/* SODIMM  85 */
+			IMX8QXP_ENET0_RGMII_TXD3_LSIO_GPIO5_IO02	0x06000020	/* SODIMM  65 */
+			IMX8QXP_QSPI0A_DATA2_LSIO_GPIO3_IO11		0x20		/* SODIMM  69 */
 			IMX8QXP_QSPI0B_DATA0_LSIO_GPIO3_IO18		0x20		/* SODIMM  99 */
-			IMX8QXP_SAI0_TXFS_LSIO_GPIO0_IO28		0x20		/* SODIMM 101 */
-			IMX8QXP_CSI_D00_CI_PI_D02			0x61		/* SODIMM 101 */
-			IMX8QXP_SAI0_TXD_LSIO_GPIO0_IO25		0x20		/* SODIMM 103 */
-			IMX8QXP_CSI_D01_CI_PI_D03			0x61		/* SODIMM 103 */
 			IMX8QXP_QSPI0B_DATA1_LSIO_GPIO3_IO19		0x20		/* SODIMM 105 */
 			IMX8QXP_QSPI0B_DATA2_LSIO_GPIO3_IO20		0x20		/* SODIMM 107 */
-			IMX8QXP_USB_SS3_TC2_LSIO_GPIO4_IO05		0x20		/* SODIMM 127 */
-			IMX8QXP_USB_SS3_TC3_LSIO_GPIO4_IO06		0x20		/* SODIMM 131 */
-			IMX8QXP_USB_SS3_TC1_LSIO_GPIO4_IO04		0x20		/* SODIMM 133 */
-			IMX8QXP_CSI_PCLK_LSIO_GPIO3_IO00		0x20		/* SODIMM  96 */
 			IMX8QXP_QSPI0B_DATA3_LSIO_GPIO3_IO21		0x20		/* SODIMM  98 */
-			IMX8QXP_SAI1_RXFS_LSIO_GPIO0_IO31		0x20		/* SODIMM 100 */
 			IMX8QXP_QSPI0B_DQS_LSIO_GPIO3_IO22		0x20		/* SODIMM 102 */
+			IMX8QXP_QSPI0B_SCLK_LSIO_GPIO3_IO17		0x20		/* SODIMM  95 */
 			IMX8QXP_QSPI0B_SS0_B_LSIO_GPIO3_IO23		0x20		/* SODIMM 104 */
 			IMX8QXP_QSPI0B_SS1_B_LSIO_GPIO3_IO24		0x20		/* SODIMM 106 */
+			IMX8QXP_SAI0_RXD_LSIO_GPIO0_IO27		0x20		/* SODIMM  97 */
+			IMX8QXP_SAI0_TXC_LSIO_GPIO0_IO26		0x20		/* SODIMM  79 */
+			IMX8QXP_SAI0_TXD_LSIO_GPIO0_IO25		0x20		/* SODIMM 103 */
+			IMX8QXP_SAI0_TXFS_LSIO_GPIO0_IO28		0x20		/* SODIMM 101 */
+			IMX8QXP_SAI1_RXFS_LSIO_GPIO0_IO31		0x20		/* SODIMM 100 */
+			IMX8QXP_USB_SS3_TC1_LSIO_GPIO4_IO04		0x20		/* SODIMM 133 */
+			IMX8QXP_USB_SS3_TC2_LSIO_GPIO4_IO05		0x20		/* SODIMM 127 */
+			IMX8QXP_USB_SS3_TC3_LSIO_GPIO4_IO06		0x20		/* SODIMM 131 */
 		>;
 	};
 
@@ -308,13 +308,8 @@ IMX8QXP_MIPI_DSI0_GPIO0_01_ADMA_I2C1_SDA	0x06000021	/* SODIMM 194 */
 	/* Colibri Parallel RGB LCD Interface */
 	pinctrl_lcdif: lcdifgrp {
 		fsl,pins = <
-			IMX8QXP_MCLK_OUT0_ADMA_LCDIF_CLK		0x60		/* SODIMM  56 */
-			IMX8QXP_SPI3_CS0_ADMA_LCDIF_HSYNC		0x60		/* SODIMM  68 */
-			IMX8QXP_MCLK_IN0_ADMA_LCDIF_VSYNC		0x60		/* SODIMM  82 */
-			IMX8QXP_MCLK_IN1_ADMA_LCDIF_EN			0x60		/* SODIMM  44 */
-			IMX8QXP_USDHC1_RESET_B_LSIO_GPIO4_IO19		0x60		/* SODIMM  44 */
+			IMX8QXP_ENET0_RGMII_TXD2_LSIO_GPIO5_IO01	0x60		/* SODIMM  57 */
 			IMX8QXP_ESAI0_FSR_ADMA_LCDIF_D00		0x60		/* SODIMM  76 */
-			IMX8QXP_USDHC1_WP_LSIO_GPIO4_IO21		0x60		/* SODIMM  76 */
 			IMX8QXP_ESAI0_FST_ADMA_LCDIF_D01		0x60		/* SODIMM  70 */
 			IMX8QXP_ESAI0_SCKR_ADMA_LCDIF_D02		0x60		/* SODIMM  60 */
 			IMX8QXP_ESAI0_SCKT_ADMA_LCDIF_D03		0x60		/* SODIMM  58 */
@@ -324,15 +319,20 @@ IMX8QXP_ESAI0_TX2_RX3_ADMA_LCDIF_D06		0x60		/* SODIMM  80 */
 			IMX8QXP_ESAI0_TX3_RX2_ADMA_LCDIF_D07		0x60		/* SODIMM  46 */
 			IMX8QXP_ESAI0_TX4_RX1_ADMA_LCDIF_D08		0x60		/* SODIMM  62 */
 			IMX8QXP_ESAI0_TX5_RX0_ADMA_LCDIF_D09		0x60		/* SODIMM  48 */
+			IMX8QXP_MCLK_IN0_ADMA_LCDIF_VSYNC		0x60		/* SODIMM  82 */
+			IMX8QXP_MCLK_IN1_ADMA_LCDIF_EN			0x60		/* SODIMM  44 */
+			IMX8QXP_MCLK_OUT0_ADMA_LCDIF_CLK		0x60		/* SODIMM  56 */
+			IMX8QXP_SPDIF0_EXT_CLK_ADMA_LCDIF_D12		0x60		/* SODIMM  52 */
 			IMX8QXP_SPDIF0_RX_ADMA_LCDIF_D10		0x60		/* SODIMM  74 */
 			IMX8QXP_SPDIF0_TX_ADMA_LCDIF_D11		0x60		/* SODIMM  50 */
-			IMX8QXP_SPDIF0_EXT_CLK_ADMA_LCDIF_D12		0x60		/* SODIMM  52 */
+			IMX8QXP_SPI3_CS0_ADMA_LCDIF_HSYNC		0x60		/* SODIMM  68 */
+			IMX8QXP_SPI3_CS1_ADMA_LCDIF_D16			0x60		/* SODIMM  57 */
 			IMX8QXP_SPI3_SCK_ADMA_LCDIF_D13			0x60		/* SODIMM  54 */
-			IMX8QXP_SPI3_SDO_ADMA_LCDIF_D14			0x60		/* SODIMM  66 */
 			IMX8QXP_SPI3_SDI_ADMA_LCDIF_D15			0x60		/* SODIMM  64 */
-			IMX8QXP_SPI3_CS1_ADMA_LCDIF_D16			0x60		/* SODIMM  57 */
-			IMX8QXP_ENET0_RGMII_TXD2_LSIO_GPIO5_IO01	0x60		/* SODIMM  57 */
+			IMX8QXP_SPI3_SDO_ADMA_LCDIF_D14			0x60		/* SODIMM  66 */
 			IMX8QXP_UART1_CTS_B_ADMA_LCDIF_D17		0x60		/* SODIMM  61 */
+			IMX8QXP_USDHC1_RESET_B_LSIO_GPIO4_IO19		0x60		/* SODIMM  44 */
+			IMX8QXP_USDHC1_WP_LSIO_GPIO4_IO21		0x60		/* SODIMM  76 */
 		>;
 	};
 
@@ -340,19 +340,19 @@ IMX8QXP_UART1_CTS_B_ADMA_LCDIF_D17		0x60		/* SODIMM  61 */
 	pinctrl_lpspi2: lpspi2grp {
 		fsl,pins = <
 			IMX8QXP_SPI2_CS0_LSIO_GPIO1_IO00		0x21		/* SODIMM  86 */
-			IMX8QXP_SPI2_SDO_ADMA_SPI2_SDO			0x06000040	/* SODIMM  92 */
-			IMX8QXP_SPI2_SDI_ADMA_SPI2_SDI			0x06000040	/* SODIMM  90 */
 			IMX8QXP_SPI2_SCK_ADMA_SPI2_SCK			0x06000040	/* SODIMM  88 */
+			IMX8QXP_SPI2_SDI_ADMA_SPI2_SDI			0x06000040	/* SODIMM  90 */
+			IMX8QXP_SPI2_SDO_ADMA_SPI2_SDO			0x06000040	/* SODIMM  92 */
 		>;
 	};
 
 	/* Colibri UART_B */
 	pinctrl_lpuart0: lpuart0grp {
 		fsl,pins = <
-			IMX8QXP_UART0_RX_ADMA_UART0_RX			0x06000020	/* SODIMM  36 */
-			IMX8QXP_UART0_TX_ADMA_UART0_TX			0x06000020	/* SODIMM  38 */
 			IMX8QXP_FLEXCAN0_RX_ADMA_UART0_RTS_B		0x06000020	/* SODIMM  34 */
 			IMX8QXP_FLEXCAN0_TX_ADMA_UART0_CTS_B		0x06000020	/* SODIMM  32 */
+			IMX8QXP_UART0_RX_ADMA_UART0_RX			0x06000020	/* SODIMM  36 */
+			IMX8QXP_UART0_TX_ADMA_UART0_TX			0x06000020	/* SODIMM  38 */
 		>;
 	};
 
@@ -375,12 +375,12 @@ IMX8QXP_FLEXCAN2_TX_ADMA_UART3_TX		0x06000020	/* SODIMM  35 */
 	/* Colibri UART_A Control */
 	pinctrl_lpuart3_ctrl: lpuart3ctrlgrp {
 		fsl,pins = <
+			IMX8QXP_CSI_EN_LSIO_GPIO3_IO02			0x20		/* SODIMM  37 */
+			IMX8QXP_CSI_RESET_LSIO_GPIO3_IO03		0x20		/* SODIMM  29 */
 			IMX8QXP_MIPI_DSI1_GPIO0_01_LSIO_GPIO2_IO00	0x20		/* SODIMM  23 */
-			IMX8QXP_SAI1_RXD_LSIO_GPIO0_IO29		0x20		/* SODIMM  25 */
 			IMX8QXP_SAI1_RXC_LSIO_GPIO0_IO30		0x20		/* SODIMM  27 */
-			IMX8QXP_CSI_RESET_LSIO_GPIO3_IO03		0x20		/* SODIMM  29 */
+			IMX8QXP_SAI1_RXD_LSIO_GPIO0_IO29		0x20		/* SODIMM  25 */
 			IMX8QXP_USDHC1_CD_B_LSIO_GPIO4_IO22		0x20		/* SODIMM  31 */
-			IMX8QXP_CSI_EN_LSIO_GPIO3_IO02			0x20		/* SODIMM  37 */
 		>;
 	};
 
@@ -388,8 +388,8 @@ IMX8QXP_CSI_EN_LSIO_GPIO3_IO02			0x20		/* SODIMM  37 */
 	pinctrl_pcieb: pciebgrp {
 		fsl,pins = <
 			IMX8QXP_PCIE_CTRL0_CLKREQ_B_LSIO_GPIO4_IO01	0x04000061	/* SODIMM 178 */
-			IMX8QXP_PCIE_CTRL0_WAKE_B_LSIO_GPIO4_IO02	0x04000061	/* SODIMM  94 */
 			IMX8QXP_PCIE_CTRL0_PERST_B_LSIO_GPIO4_IO00	0x60		/* SODIMM  81 */
+			IMX8QXP_PCIE_CTRL0_WAKE_B_LSIO_GPIO4_IO02	0x04000061	/* SODIMM  94 */
 		>;
 	};
 
@@ -428,9 +428,9 @@ IMX8QXP_UART1_RTS_B_LSIO_PWM2_OUT		0x60		/* SODIMM  67 */
 	/* On-module I2S */
 	pinctrl_sai0: sai0grp {
 		fsl,pins = <
-			IMX8QXP_SPI0_SDI_ADMA_SAI0_TXD			0x06000040
 			IMX8QXP_SPI0_CS0_ADMA_SAI0_RXD			0x06000040
 			IMX8QXP_SPI0_SCK_ADMA_SAI0_TXC			0x06000040
+			IMX8QXP_SPI0_SDI_ADMA_SAI0_TXD			0x06000040
 			IMX8QXP_SPI0_SDO_ADMA_SAI0_TXFS			0x06000040
 		>;
 	};
@@ -484,8 +484,8 @@ IMX8QXP_EMMC0_DATA4_CONN_EMMC0_DATA4		0x21
 			IMX8QXP_EMMC0_DATA5_CONN_EMMC0_DATA5		0x21
 			IMX8QXP_EMMC0_DATA6_CONN_EMMC0_DATA6		0x21
 			IMX8QXP_EMMC0_DATA7_CONN_EMMC0_DATA7		0x21
-			IMX8QXP_EMMC0_STROBE_CONN_EMMC0_STROBE		0x41
 			IMX8QXP_EMMC0_RESET_B_CONN_EMMC0_RESET_B	0x21
+			IMX8QXP_EMMC0_STROBE_CONN_EMMC0_STROBE		0x41
 		>;
 	};
 
@@ -501,8 +501,8 @@ IMX8QXP_EMMC0_DATA4_CONN_EMMC0_DATA4		0x21
 			IMX8QXP_EMMC0_DATA5_CONN_EMMC0_DATA5		0x21
 			IMX8QXP_EMMC0_DATA6_CONN_EMMC0_DATA6		0x21
 			IMX8QXP_EMMC0_DATA7_CONN_EMMC0_DATA7		0x21
-			IMX8QXP_EMMC0_STROBE_CONN_EMMC0_STROBE		0x41
 			IMX8QXP_EMMC0_RESET_B_CONN_EMMC0_RESET_B	0x21
+			IMX8QXP_EMMC0_STROBE_CONN_EMMC0_STROBE		0x41
 		>;
 	};
 
@@ -518,8 +518,8 @@ IMX8QXP_EMMC0_DATA4_CONN_EMMC0_DATA4		0x21
 			IMX8QXP_EMMC0_DATA5_CONN_EMMC0_DATA5		0x21
 			IMX8QXP_EMMC0_DATA6_CONN_EMMC0_DATA6		0x21
 			IMX8QXP_EMMC0_DATA7_CONN_EMMC0_DATA7		0x21
-			IMX8QXP_EMMC0_STROBE_CONN_EMMC0_STROBE		0x41
 			IMX8QXP_EMMC0_RESET_B_CONN_EMMC0_RESET_B	0x21
+			IMX8QXP_EMMC0_STROBE_CONN_EMMC0_STROBE		0x41
 		>;
 	};
 
-- 
2.39.2

