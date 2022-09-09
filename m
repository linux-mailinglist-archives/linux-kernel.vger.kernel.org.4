Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22B95B3D05
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 18:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbiIIQan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 12:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbiIIQag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 12:30:36 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B7C558DF;
        Fri,  9 Sep 2022 09:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662741035; x=1694277035;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version;
  bh=9SBK7Qs92D8mgVe5Pup/T54FTkXsVMWiqK5v7nCQ0Xo=;
  b=oHwbhWtoEwp/tTMmhtt12o2wiTx1CygFWphgITOkh1Ns+9W/ExdZyzpp
   FbZEpraoyO9HXZubHFL5nTX3JEj4z4XrA4qR9RXnz7q2BE3NJuFIS3Ob1
   pw9w+By0vJFiEGVAoc8ID6/52SESCu8PHv1Q79HAqU9blfNq2Eg2xMSfk
   V3FxND1HDTmJNqKmAuiwTAzbcQY9AoYNi12DfIa7/mUtgsYhP8a5RZdAE
   hF9ZAGscRrQIEwedf4Wh3ME7lLdW82wwKv32jXZzDdMDJbmPK+psvaygX
   MA6fNkwyPNoSla0bC8lw/ZFDWuMcq76WWlNJX3ykpHCRI4zRml6UDjKB0
   w==;
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="179880013"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Sep 2022 09:30:35 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 9 Sep 2022 09:30:24 -0700
Received: from AUS-LT-C33025.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Fri, 9 Sep 2022 09:30:24 -0700
From:   Jerry Ray <jerry.ray@microchip.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Jerry Ray" <jerry.ray@microchip.com>
Subject: [linux][PATCH v9 2/2] dts: arm: at91: Add SAMA5D3-EDS Board
Date:   Fri, 9 Sep 2022 11:30:22 -0500
Message-ID: <20220909163022.13022-2-jerry.ray@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220909163022.13022-1-jerry.ray@microchip.com>
References: <20220909163022.13022-1-jerry.ray@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SAMA5D3-EDS board is an Ethernet Development Platform allowing for
evaluating many Microchip ethernet switch and PHY products.  Various
daughter cards can connect via an RGMII connector or an RMII connector.

The EDS board is not intended for stand-alone use and has no ethernet
capabilities when no daughter board is connected.  As such, this device
tree is intended to be used with a DT overlay defining the add-on board.
To better ensure consistency, some items are defined here as a form of
documentation so that all add-on overlays will use the same terms.

Link: https://www.microchip.com/en-us/development-tool/SAMA5D3-ETHERNET-DEVELOPMENT-SYSTEM
Signed-off-by: Jerry Ray <jerry.ray@microchip.com>
---
v8->v9:
 - Changed node name from gpio to gpio-inputs
v7->v8:
 - correcting patch subject line.
v6->v7:
 - Renamed regulators, making things more consistent.
 - Made slow_xtal and main_xtal entries direct overrides.
v5->v6:
 - Replaced underscores in names where I can, improving naming.
v4->v5:
 - patch now applies to v6.0-rc2
v3->v4:
 - Fixed regulators as necessary to get the board to boot from SD Card.
v2->v3:
 - Alphabetized pinctrl entries.
 - cleaned up a warning in the regulators section.
 - License tweaked to 'OR MIT'
 - Included Makefile change
v1->v2:
 - Modified the compatible field in the device tree to reflect Microchip
   Ethernet Development System Board.
---
 arch/arm/boot/dts/Makefile             |   1 +
 arch/arm/boot/dts/at91-sama5d3_eds.dts | 307 +++++++++++++++++++++++++
 2 files changed, 308 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91-sama5d3_eds.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 05d8aef6e5d2..e92e639a2dc3 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -61,6 +61,7 @@ dtb-$(CONFIG_SOC_SAM_V7) += \
 	at91-sama5d2_icp.dtb \
 	at91-sama5d2_ptc_ek.dtb \
 	at91-sama5d2_xplained.dtb \
+	at91-sama5d3_eds.dtb \
 	at91-sama5d3_ksz9477_evb.dtb \
 	at91-sama5d3_xplained.dtb \
 	at91-dvk_som60.dtb \
diff --git a/arch/arm/boot/dts/at91-sama5d3_eds.dts b/arch/arm/boot/dts/at91-sama5d3_eds.dts
new file mode 100644
index 000000000000..bae6819217e0
--- /dev/null
+++ b/arch/arm/boot/dts/at91-sama5d3_eds.dts
@@ -0,0 +1,307 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * at91-sama5d3_eds.dts - Device Tree file for the SAMA5D3 Ethernet
+ *    Development System board.
+ *
+ * Copyright (C) 2022 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Jerry Ray <jerry.ray@microchip.com>
+ */
+/dts-v1/;
+#include "sama5d36.dtsi"
+
+/ {
+	model = "SAMA5D3 Ethernet Development System";
+	compatible = "microchip,sama5d3-eds", "atmel,sama5d36",
+		     "atmel,sama5d3", "atmel,sama5";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	gpio-inputs {
+		compatible = "gpio-keys";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_key_gpio>;
+
+		button-3 {
+			label = "PB_USER";
+			gpios = <&pioE 29 GPIO_ACTIVE_LOW>;
+			linux,code = <0x104>;
+			wakeup-source;
+		};
+	};
+
+	memory@20000000 {
+		reg = <0x20000000 0x10000000>;
+	};
+
+	vcc_3v3_reg: regulator-1 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	vcc_2v5_reg: regulator-2 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_2V5";
+		regulator-min-microvolt = <2500000>;
+		regulator-max-microvolt = <2500000>;
+		regulator-always-on;
+		vin-supply = <&vcc_3v3_reg>;
+	};
+
+	vcc_1v8_reg: regulator-3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		vin-supply = <&vcc_3v3_reg>;
+	};
+
+	vcc_1v2_reg: regulator-4 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_1V2";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		regulator-always-on;
+	};
+
+	vcc_mmc0_reg: regulator-5 {
+		compatible = "regulator-fixed";
+		regulator-name = "mmc0-card-supply";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_vcc_mmc0_reg_gpio>;
+		gpio = <&pioE 2 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&can0 {
+	status = "okay";
+};
+
+&dbgu {
+	status = "okay";
+};
+
+&ebi {
+	pinctrl-0 = <&pinctrl_ebi_nand_addr>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	nand_controller: nand-controller {
+		status = "okay";
+
+		nand@3 {
+			reg = <0x3 0x0 0x2>;
+			atmel,rb = <0>;
+			nand-bus-width = <8>;
+			nand-ecc-mode = "hw";
+			nand-ecc-strength = <4>;
+			nand-ecc-step-size = <512>;
+			nand-on-flash-bbt;
+			label = "atmel_nand";
+
+			partitions {
+				compatible = "fixed-partitions";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				at91bootstrap@0 {
+					label = "at91bootstrap";
+					reg = <0x0 0x40000>;
+				};
+
+				bootloader@40000 {
+					label = "bootloader";
+					reg = <0x40000 0xc0000>;
+				};
+
+				bootloaderenvred@100000 {
+					label = "bootloader env redundant";
+					reg = <0x100000 0x40000>;
+				};
+
+				bootloaderenv@140000 {
+					label = "bootloader env";
+					reg = <0x140000 0x40000>;
+				};
+
+				dtb@180000 {
+					label = "device tree";
+					reg = <0x180000 0x80000>;
+				};
+
+				kernel@200000 {
+					label = "kernel";
+					reg = <0x200000 0x600000>;
+				};
+
+				rootfs@800000 {
+					label = "rootfs";
+					reg = <0x800000 0x0f800000>;
+				};
+			};
+		};
+	};
+};
+
+&i2c0 {
+	pinctrl-0 = <&pinctrl_i2c0_pu>;
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c2 {
+	pinctrl-0 = <&pinctrl_i2c2_pu>;
+	status = "okay";
+};
+
+&main_xtal {
+	clock-frequency = <12000000>;
+};
+
+&mmc0 {
+	pinctrl-0 = <&pinctrl_mmc0_clk_cmd_dat0 &pinctrl_mmc0_dat1_3
+		     &pinctrl_mmc0_dat4_7 &pinctrl_mmc0_cd>;
+	vmmc-supply = <&vcc_mmc0_reg>;
+	vqmmc-supply = <&vcc_3v3_reg>;
+	status = "okay";
+	slot@0 {
+		reg = <0>;
+		bus-width = <8>;
+		cd-gpios = <&pioE 0 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&pinctrl {
+	board {
+		pinctrl_i2c0_pu: i2c0-pu {
+			atmel,pins =
+				<AT91_PIOA 30 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>,
+				<AT91_PIOA 31 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
+		};
+
+		pinctrl_i2c2_pu: i2c2-pu {
+			atmel,pins =
+				<AT91_PIOA 18 AT91_PERIPH_B AT91_PINCTRL_PULL_UP>,
+				<AT91_PIOA 19 AT91_PERIPH_B AT91_PINCTRL_PULL_UP>;
+		};
+
+		pinctrl_key_gpio: key-gpio-0 {
+			atmel,pins =
+				<AT91_PIOE 29 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>;
+		};
+
+		pinctrl_mmc0_cd: mmc0-cd {
+			atmel,pins =
+				<AT91_PIOE 0 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>;
+		};
+
+		/* Reserved for reset signal to the RGMII connector. */
+		pinctrl_rgmii_rstn: rgmii-rstn {
+			atmel,pins =
+				<AT91_PIOD 18 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>;
+		};
+
+		/* Reserved for an interrupt line from the RMII and RGMII connectors. */
+		pinctrl_spi_irqn: spi-irqn {
+			atmel,pins =
+				<AT91_PIOB 28 AT91_PERIPH_GPIO AT91_PINCTRL_DEGLITCH>;
+		};
+
+		pinctrl_spi0_cs: spi0-cs-default {
+			atmel,pins =
+				<AT91_PIOD 13 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
+				 AT91_PIOD 16 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+		};
+
+		pinctrl_spi1_cs: spi1-cs-default {
+			atmel,pins = <AT91_PIOC 25 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
+				      AT91_PIOC 28 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+		};
+
+		pinctrl_usba_vbus: usba-vbus {
+			atmel,pins =
+				<AT91_PIOE 9 AT91_PERIPH_GPIO AT91_PINCTRL_DEGLITCH>;
+		};
+
+		pinctrl_usb_default: usb-default {
+			atmel,pins =
+				<AT91_PIOE 3 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
+				 AT91_PIOE 4 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+		};
+
+		/* Reserved for VBUS fault interrupt. */
+		pinctrl_vbusfault_irqn: vbusfault-irqn {
+			atmel,pins =
+				<AT91_PIOE 5 AT91_PERIPH_GPIO AT91_PINCTRL_DEGLITCH>;
+		};
+
+		pinctrl_vcc_mmc0_reg_gpio: vcc-mmc0-reg-gpio-default {
+			atmel,pins = <AT91_PIOE 2 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
+		};
+	};
+};
+
+&slow_xtal {
+	clock-frequency = <32768>;
+};
+
+&spi0 {
+	pinctrl-names = "default", "cs";
+	pinctrl-1 = <&pinctrl_spi0_cs>;
+	cs-gpios = <&pioD 13 0>, <0>, <0>, <&pioD 16 0>;
+	status = "okay";
+};
+
+&spi1 {
+	pinctrl-names = "default", "cs";
+	pinctrl-1 = <&pinctrl_spi1_cs>;
+	cs-gpios = <&pioC 25 0>, <0>, <0>, <&pioC 28 0>;
+	status = "okay";
+};
+
+&tcb0 {
+	timer0: timer@0 {
+		compatible = "atmel,tcb-timer";
+		reg = <0>;
+	};
+
+	timer1: timer@1 {
+		compatible = "atmel,tcb-timer";
+		reg = <1>;
+	};
+};
+
+&usb0 {	/* USB Device port with VBUS detection. */
+	atmel,vbus-gpio = <&pioE 9 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usba_vbus>;
+	status = "okay";
+};
+
+&usb1 {	/* 3-port Host. First port is unused. */
+	atmel,vbus-gpio = <0
+			   &pioE 3 GPIO_ACTIVE_HIGH
+			   &pioE 4 GPIO_ACTIVE_HIGH
+			  >;
+	num-ports = <3>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb_default>;
+	status = "okay";
+};
+
+&usb2 {
+	status = "okay";
+};
-- 
2.17.1

