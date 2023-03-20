Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BBD6C09EE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 06:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjCTFOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 01:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjCTFOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 01:14:00 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44423222D9;
        Sun, 19 Mar 2023 22:13:57 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32K5DlKI051544;
        Mon, 20 Mar 2023 00:13:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679289228;
        bh=qFxsqHZywSfXhhWUk0/2j4PWt/VUi667dbIfaTP3Twk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=N+w7NMEo9lE6QVIGN8eL0pckOsbwMIM4Umr0HuUc7TkwGSCfCTl6T9E/eAihrcwAw
         INZQB9Z/kce0ZsGCGwZyo2ZgyjFgpOGizW9wvMzbWifLZNAPHGlZJTalVcUeFrQrGE
         UB195N0+hAgCBVZxl85aIWOAnWF1IV6x2S4UXqHQ=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32K5DlLW077517
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Mar 2023 00:13:47 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 20
 Mar 2023 00:13:47 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 20 Mar 2023 00:13:47 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32K5Ddsr046592;
        Mon, 20 Mar 2023 00:13:45 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] arm64: dts: ti: Refractor AM625 SK dts
Date:   Mon, 20 Mar 2023 10:43:03 +0530
Message-ID: <20230320051304.2730692-3-vigneshr@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230320051304.2730692-1-vigneshr@ti.com>
References: <20230320051304.2730692-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anand Gadiyar <gadiyar@ti.com>

To prepare for upcoming derivative boards based on the AM625 SK,
refactor the dts file for this board into a common dtsi file that the
derivative boards will inherit and retain only those parts that are
different in the current dts file.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am625-sk.dts        | 237 +--------------
 .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 274 ++++++++++++++++++
 2 files changed, 275 insertions(+), 236 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
index 6bc7d63cf52f..cdc0858dd1b2 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
@@ -7,32 +7,12 @@
 
 /dts-v1/;
 
-#include <dt-bindings/leds/common.h>
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/net/ti-dp83867.h>
-#include "k3-am625.dtsi"
+#include "k3-am62x-sk-common.dtsi"
 
 / {
 	compatible = "ti,am625-sk", "ti,am625";
 	model = "Texas Instruments AM625 SK";
 
-	aliases {
-		serial2 = &main_uart0;
-		mmc0 = &sdhci0;
-		mmc1 = &sdhci1;
-		mmc2 = &sdhci2;
-		spi0 = &ospi0;
-		ethernet0 = &cpsw_port1;
-		ethernet1 = &cpsw_port2;
-		usb0 = &usb0;
-		usb1 = &usb1;
-	};
-
-	chosen {
-		stdout-path = "serial2:115200n8";
-		bootargs = "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x02800000";
-	};
-
 	opp-table {
 		/* Add 1.4GHz OPP for am625-sk board. Requires VDD_CORE to be at 0.85V */
 		opp-1400000000 {
@@ -49,39 +29,6 @@ memory@80000000 {
 
 	};
 
-	reserved-memory {
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		ramoops@9ca00000 {
-			compatible = "ramoops";
-			reg = <0x00 0x9ca00000 0x00 0x00100000>;
-			record-size = <0x8000>;
-			console-size = <0x8000>;
-			ftrace-size = <0x00>;
-			pmsg-size = <0x8000>;
-		};
-
-		secure_tfa_ddr: tfa@9e780000 {
-			reg = <0x00 0x9e780000 0x00 0x80000>;
-			alignment = <0x1000>;
-			no-map;
-		};
-
-		secure_ddr: optee@9e800000 {
-			reg = <0x00 0x9e800000 0x00 0x01800000>; /* for OP-TEE */
-			alignment = <0x1000>;
-			no-map;
-		};
-
-		wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9db00000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x9db00000 0x00 0xc00000>;
-			no-map;
-		};
-	};
-
 	vmain_pd: regulator-0 {
 		/* TPS65988 PD CONTROLLER OUTPUT */
 		compatible = "regulator-fixed";
@@ -140,108 +87,9 @@ vdd_sd_dv: regulator-4 {
 		states = <1800000 0x0>,
 			 <3300000 0x1>;
 	};
-
-	leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&usr_led_pins_default>;
-
-		led-0 {
-			label = "am62-sk:green:heartbeat";
-			gpios = <&main_gpio1 49 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "heartbeat";
-			function = LED_FUNCTION_HEARTBEAT;
-			default-state = "off";
-		};
-	};
 };
 
 &main_pmx0 {
-	main_uart0_pins_default: main-uart0-pins-default {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x1c8, PIN_INPUT, 0) /* (D14) UART0_RXD */
-			AM62X_IOPAD(0x1cc, PIN_OUTPUT, 0) /* (E14) UART0_TXD */
-		>;
-	};
-
-	main_i2c0_pins_default: main-i2c0-pins-default {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x1e0, PIN_INPUT_PULLUP, 0) /* (B16) I2C0_SCL */
-			AM62X_IOPAD(0x1e4, PIN_INPUT_PULLUP, 0) /* (A16) I2C0_SDA */
-		>;
-	};
-
-	main_i2c1_pins_default: main-i2c1-pins-default {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x1e8, PIN_INPUT_PULLUP, 0) /* (B17) I2C1_SCL */
-			AM62X_IOPAD(0x1ec, PIN_INPUT_PULLUP, 0) /* (A17) I2C1_SDA */
-		>;
-	};
-
-	main_i2c2_pins_default: main-i2c2-pins-default {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x0b0, PIN_INPUT_PULLUP, 1) /* (K22) GPMC0_CSn2.I2C2_SCL */
-			AM62X_IOPAD(0x0b4, PIN_INPUT_PULLUP, 1) /* (K24) GPMC0_CSn3.I2C2_SDA */
-		>;
-	};
-
-	main_mmc0_pins_default: main-mmc0-pins-default {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x220, PIN_INPUT, 0) /* (Y3) MMC0_CMD */
-			AM62X_IOPAD(0x218, PIN_INPUT, 0) /* (AB1) MMC0_CLK */
-			AM62X_IOPAD(0x214, PIN_INPUT, 0) /* (AA2) MMC0_DAT0 */
-			AM62X_IOPAD(0x210, PIN_INPUT, 0) /* (AA1) MMC0_DAT1 */
-			AM62X_IOPAD(0x20c, PIN_INPUT, 0) /* (AA3) MMC0_DAT2 */
-			AM62X_IOPAD(0x208, PIN_INPUT, 0) /* (Y4) MMC0_DAT3 */
-			AM62X_IOPAD(0x204, PIN_INPUT, 0) /* (AB2) MMC0_DAT4 */
-			AM62X_IOPAD(0x200, PIN_INPUT, 0) /* (AC1) MMC0_DAT5 */
-			AM62X_IOPAD(0x1fc, PIN_INPUT, 0) /* (AD2) MMC0_DAT6 */
-			AM62X_IOPAD(0x1f8, PIN_INPUT, 0) /* (AC2) MMC0_DAT7 */
-		>;
-	};
-
-	main_mmc1_pins_default: main-mmc1-pins-default {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x23c, PIN_INPUT, 0) /* (A21) MMC1_CMD */
-			AM62X_IOPAD(0x234, PIN_INPUT, 0) /* (B22) MMC1_CLK */
-			AM62X_IOPAD(0x230, PIN_INPUT, 0) /* (A22) MMC1_DAT0 */
-			AM62X_IOPAD(0x22c, PIN_INPUT, 0) /* (B21) MMC1_DAT1 */
-			AM62X_IOPAD(0x228, PIN_INPUT, 0) /* (C21) MMC1_DAT2 */
-			AM62X_IOPAD(0x224, PIN_INPUT, 0) /* (D22) MMC1_DAT3 */
-			AM62X_IOPAD(0x240, PIN_INPUT, 0) /* (D17) MMC1_SDCD */
-		>;
-	};
-
-	usr_led_pins_default: usr-led-pins-default {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x244, PIN_OUTPUT, 7) /* (C17) MMC1_SDWP.GPIO1_49 */
-		>;
-	};
-
-	main_mdio1_pins_default: main-mdio1-pins-default {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x160, PIN_OUTPUT, 0) /* (AD24) MDIO0_MDC */
-			AM62X_IOPAD(0x15c, PIN_INPUT, 0) /* (AB22) MDIO0_MDIO */
-		>;
-	};
-
-	main_rgmii1_pins_default: main-rgmii1-pins-default {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x14c, PIN_INPUT, 0) /* (AB17) RGMII1_RD0 */
-			AM62X_IOPAD(0x150, PIN_INPUT, 0) /* (AC17) RGMII1_RD1 */
-			AM62X_IOPAD(0x154, PIN_INPUT, 0) /* (AB16) RGMII1_RD2 */
-			AM62X_IOPAD(0x158, PIN_INPUT, 0) /* (AA15) RGMII1_RD3 */
-			AM62X_IOPAD(0x148, PIN_INPUT, 0) /* (AD17) RGMII1_RXC */
-			AM62X_IOPAD(0x144, PIN_INPUT, 0) /* (AE17) RGMII1_RX_CTL */
-			AM62X_IOPAD(0x134, PIN_OUTPUT, 0) /* (AE20) RGMII1_TD0 */
-			AM62X_IOPAD(0x138, PIN_OUTPUT, 0) /* (AD20) RGMII1_TD1 */
-			AM62X_IOPAD(0x13c, PIN_OUTPUT, 0) /* (AE18) RGMII1_TD2 */
-			AM62X_IOPAD(0x140, PIN_OUTPUT, 0) /* (AD18) RGMII1_TD3 */
-			AM62X_IOPAD(0x130, PIN_OUTPUT, 0) /* (AE19) RGMII1_TXC */
-			AM62X_IOPAD(0x12c, PIN_OUTPUT, 0) /* (AD19) RGMII1_TX_CTL */
-		>;
-	};
-
 	main_rgmii2_pins_default: main-rgmii2-pins-default {
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x184, PIN_INPUT, 0) /* (AE23) RGMII2_RD0 */
@@ -286,43 +134,9 @@ main_gpio1_ioexp_intr_pins_default: main-gpio1-ioexp-intr-pins-default {
 			AM62X_IOPAD(0x01d4, PIN_INPUT, 7) /* (B15) UART0_RTSn.GPIO1_23 */
 		>;
 	};
-
-	main_usb1_pins_default: main-usb1-pins-default {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x0258, PIN_OUTPUT, 0) /* (F18) USB1_DRVVBUS */
-		>;
-	};
-};
-
-&wkup_uart0 {
-	/* WKUP UART0 is used by DM firmware */
-	status = "reserved";
-};
-
-&main_uart0 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_uart0_pins_default>;
-};
-
-&main_uart1 {
-	/* Main UART1 is used by TIFS firmware */
-	status = "reserved";
-};
-
-&main_i2c0 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_i2c0_pins_default>;
-	clock-frequency = <400000>;
 };
 
 &main_i2c1 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_i2c1_pins_default>;
-	clock-frequency = <400000>;
-
 	exp1: gpio@22 {
 		compatible = "ti,tca6424";
 		reg = <0x22>;
@@ -351,23 +165,9 @@ exp1: gpio@22 {
 	};
 };
 
-&sdhci0 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_mmc0_pins_default>;
-	ti,driver-strength-ohm = <50>;
-	disable-wp;
-};
-
 &sdhci1 {
-	/* SD/MMC */
-	status = "okay";
 	vmmc-supply = <&vdd_mmc1>;
 	vqmmc-supply = <&vdd_sd_dv>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_mmc1_pins_default>;
-	ti,driver-strength-ohm = <50>;
-	disable-wp;
 };
 
 &cpsw3g {
@@ -376,28 +176,12 @@ &cpsw3g {
 		     &main_rgmii2_pins_default>;
 };
 
-&cpsw_port1 {
-	phy-mode = "rgmii-rxid";
-	phy-handle = <&cpsw3g_phy0>;
-};
-
 &cpsw_port2 {
 	phy-mode = "rgmii-rxid";
 	phy-handle = <&cpsw3g_phy1>;
 };
 
 &cpsw3g_mdio {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_mdio1_pins_default>;
-
-	cpsw3g_phy0: ethernet-phy@0 {
-		reg = <0>;
-		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
-		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
-		ti,min-output-impedance;
-	};
-
 	cpsw3g_phy1: ethernet-phy@1 {
 		reg = <1>;
 		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
@@ -472,22 +256,3 @@ partition@3fc0000 {
 		};
 	};
 };
-
-&usbss0 {
-	status = "okay";
-	ti,vbus-divider;
-};
-
-&usbss1 {
-	status = "okay";
-};
-
-&usb0 {
-	dr_mode = "peripheral";
-};
-
-&usb1 {
-	dr_mode = "host";
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_usb1_pins_default>;
-};
diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
new file mode 100644
index 000000000000..54318a07d50c
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -0,0 +1,274 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Common dtsi for AM62x SK and derivatives
+ *
+ * Copyright (C) 2021-2023 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/net/ti-dp83867.h>
+#include "k3-am625.dtsi"
+
+/ {
+	aliases {
+		serial2 = &main_uart0;
+		mmc0 = &sdhci0;
+		mmc1 = &sdhci1;
+		mmc2 = &sdhci2;
+		spi0 = &ospi0;
+		ethernet0 = &cpsw_port1;
+		ethernet1 = &cpsw_port2;
+		usb0 = &usb0;
+		usb1 = &usb1;
+	};
+
+	chosen {
+		stdout-path = "serial2:115200n8";
+		bootargs = "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x02800000";
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		/* 2G RAM */
+		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
+
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		ramoops@9ca00000 {
+			compatible = "ramoops";
+			reg = <0x00 0x9ca00000 0x00 0x00100000>;
+			record-size = <0x8000>;
+			console-size = <0x8000>;
+			ftrace-size = <0x00>;
+			pmsg-size = <0x8000>;
+		};
+
+		secure_tfa_ddr: tfa@9e780000 {
+			reg = <0x00 0x9e780000 0x00 0x80000>;
+			alignment = <0x1000>;
+			no-map;
+		};
+
+		secure_ddr: optee@9e800000 {
+			reg = <0x00 0x9e800000 0x00 0x01800000>; /* for OP-TEE */
+			alignment = <0x1000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9db00000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9db00000 0x00 0xc00000>;
+			no-map;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&usr_led_pins_default>;
+
+		led-0 {
+			label = "am62-sk:green:heartbeat";
+			gpios = <&main_gpio1 49 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+			function = LED_FUNCTION_HEARTBEAT;
+			default-state = "off";
+		};
+	};
+};
+
+&main_pmx0 {
+	/* First pad number is ALW package and second is AMC package */
+	main_uart0_pins_default: main-uart0-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x1c8, PIN_INPUT, 0) /* (D14/A13) UART0_RXD */
+			AM62X_IOPAD(0x1cc, PIN_OUTPUT, 0) /* (E14/E11) UART0_TXD */
+		>;
+	};
+
+	main_i2c0_pins_default: main-i2c0-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x1e0, PIN_INPUT_PULLUP, 0) /* (B16/E12) I2C0_SCL */
+			AM62X_IOPAD(0x1e4, PIN_INPUT_PULLUP, 0) /* (A16/D14) I2C0_SDA */
+		>;
+	};
+
+	main_i2c1_pins_default: main-i2c1-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x1e8, PIN_INPUT_PULLUP, 0) /* (B17/A17) I2C1_SCL */
+			AM62X_IOPAD(0x1ec, PIN_INPUT_PULLUP, 0) /* (A17/A16) I2C1_SDA */
+		>;
+	};
+
+	main_i2c2_pins_default: main-i2c2-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x0b0, PIN_INPUT_PULLUP, 1) /* (K22/H18) GPMC0_CSn2.I2C2_SCL */
+			AM62X_IOPAD(0x0b4, PIN_INPUT_PULLUP, 1) /* (K24/H19) GPMC0_CSn3.I2C2_SDA */
+		>;
+	};
+
+	main_mmc0_pins_default: main-mmc0-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x220, PIN_INPUT, 0) /* (Y3/V3) MMC0_CMD */
+			AM62X_IOPAD(0x218, PIN_INPUT, 0) /* (AB1/Y1) MMC0_CLK */
+			AM62X_IOPAD(0x214, PIN_INPUT, 0) /* (AA2/V2) MMC0_DAT0 */
+			AM62X_IOPAD(0x210, PIN_INPUT, 0) /* (AA1/V1) MMC0_DAT1 */
+			AM62X_IOPAD(0x20c, PIN_INPUT, 0) /* (AA3/W2) MMC0_DAT2 */
+			AM62X_IOPAD(0x208, PIN_INPUT, 0) /* (Y4/W1) MMC0_DAT3 */
+			AM62X_IOPAD(0x204, PIN_INPUT, 0) /* (AB2/Y2) MMC0_DAT4 */
+			AM62X_IOPAD(0x200, PIN_INPUT, 0) /* (AC1/W3) MMC0_DAT5 */
+			AM62X_IOPAD(0x1fc, PIN_INPUT, 0) /* (AD2/W4) MMC0_DAT6 */
+			AM62X_IOPAD(0x1f8, PIN_INPUT, 0) /* (AC2/V4) MMC0_DAT7 */
+		>;
+	};
+
+	main_mmc1_pins_default: main-mmc1-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x23c, PIN_INPUT, 0) /* (A21/C18) MMC1_CMD */
+			AM62X_IOPAD(0x234, PIN_INPUT, 0) /* (B22/A20) MMC1_CLK */
+			AM62X_IOPAD(0x230, PIN_INPUT, 0) /* (A22/A19) MMC1_DAT0 */
+			AM62X_IOPAD(0x22c, PIN_INPUT, 0) /* (B21/B19) MMC1_DAT1 */
+			AM62X_IOPAD(0x228, PIN_INPUT, 0) /* (C21/B20) MMC1_DAT2 */
+			AM62X_IOPAD(0x224, PIN_INPUT, 0) /* (D22/C19) MMC1_DAT3 */
+			AM62X_IOPAD(0x240, PIN_INPUT, 0) /* (D17/C15) MMC1_SDCD */
+		>;
+	};
+
+	usr_led_pins_default: usr-led-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x244, PIN_OUTPUT, 7) /* (C17/B15) MMC1_SDWP.GPIO1_49 */
+		>;
+	};
+
+	main_mdio1_pins_default: main-mdio1-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x160, PIN_OUTPUT, 0) /* (AD24/V17) MDIO0_MDC */
+			AM62X_IOPAD(0x15c, PIN_INPUT, 0) /* (AB22/U16) MDIO0_MDIO */
+		>;
+	};
+
+	main_rgmii1_pins_default: main-rgmii1-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x14c, PIN_INPUT, 0) /* (AB17/W15) RGMII1_RD0 */
+			AM62X_IOPAD(0x150, PIN_INPUT, 0) /* (AC17/Y16) RGMII1_RD1 */
+			AM62X_IOPAD(0x154, PIN_INPUT, 0) /* (AB16/AA17) RGMII1_RD2 */
+			AM62X_IOPAD(0x158, PIN_INPUT, 0) /* (AA15/Y15) RGMII1_RD3 */
+			AM62X_IOPAD(0x148, PIN_INPUT, 0) /* (AD17/AA16) RGMII1_RXC */
+			AM62X_IOPAD(0x144, PIN_INPUT, 0) /* (AE17/W14) RGMII1_RX_CTL */
+			AM62X_IOPAD(0x134, PIN_OUTPUT, 0) /* (AE20/U14) RGMII1_TD0 */
+			AM62X_IOPAD(0x138, PIN_OUTPUT, 0) /* (AD20/AA19) RGMII1_TD1 */
+			AM62X_IOPAD(0x13c, PIN_OUTPUT, 0) /* (AE18/Y17) RGMII1_TD2 */
+			AM62X_IOPAD(0x140, PIN_OUTPUT, 0) /* (AD18/AA18) RGMII1_TD3 */
+			AM62X_IOPAD(0x130, PIN_OUTPUT, 0) /* (AE19/W16) RGMII1_TXC */
+			AM62X_IOPAD(0x12c, PIN_OUTPUT, 0) /* (AD19/V15) RGMII1_TX_CTL */
+		>;
+	};
+
+	main_usb1_pins_default: main-usb1-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x0258, PIN_OUTPUT, 0) /* (F18/E16) USB1_DRVVBUS */
+		>;
+	};
+};
+
+&wkup_uart0 {
+	/* WKUP UART0 is used by DM firmware */
+	status = "reserved";
+};
+
+&main_uart0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart0_pins_default>;
+};
+
+&main_uart1 {
+	/* Main UART1 is used by TIFS firmware */
+	status = "reserved";
+};
+
+&main_i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c0_pins_default>;
+	clock-frequency = <400000>;
+};
+
+&main_i2c1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c1_pins_default>;
+	clock-frequency = <400000>;
+};
+
+&sdhci0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mmc0_pins_default>;
+	ti,driver-strength-ohm = <50>;
+	disable-wp;
+};
+
+&sdhci1 {
+	/* SD/MMC */
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mmc1_pins_default>;
+	ti,driver-strength-ohm = <50>;
+	disable-wp;
+};
+
+&cpsw3g {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_rgmii1_pins_default>;
+};
+
+&cpsw_port1 {
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&cpsw3g_phy0>;
+};
+
+&cpsw3g_mdio {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mdio1_pins_default>;
+
+	cpsw3g_phy0: ethernet-phy@0 {
+		reg = <0>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		ti,min-output-impedance;
+	};
+};
+
+&mailbox0_cluster0 {
+	mbox_m4_0: mbox-m4-0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+};
+
+&usbss0 {
+	status = "okay";
+	ti,vbus-divider;
+};
+
+&usbss1 {
+	status = "okay";
+};
+
+&usb0 {
+	dr_mode = "peripheral";
+};
+
+&usb1 {
+	dr_mode = "host";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_usb1_pins_default>;
+};
-- 
2.40.0

