Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9987965477F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 21:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235520AbiLVUq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 15:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235439AbiLVUqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 15:46:19 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DAA1CB08;
        Thu, 22 Dec 2022 12:46:17 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BMKkAow025037;
        Thu, 22 Dec 2022 14:46:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1671741970;
        bh=gHkVwQnnrwNn68MiVkCVrwPM+cHCPnQEgHGo0lp75Y0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=tmc8PsKLt8PSKG8rsvXdth41JDmtYTYzein99KN6N8C0sJ2Q262xNqtNAm+tbEBEB
         7swAtfCZc/LuSrfsJncHO7y8PrxeHjyvqqtrIlaL6o6AkgDl//sggwoLCwYUlWjq+/
         H2mwqI5/1sxI5vblLH3hixt9AF31B9Znq8BcwLLY=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BMKkAhi020757
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Dec 2022 14:46:10 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 22
 Dec 2022 14:46:10 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 22 Dec 2022 14:46:10 -0600
Received: from LT5CD112GSQZ.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BMKjk7Q004121;
        Thu, 22 Dec 2022 14:46:06 -0600
From:   Apurva Nandan <a-nandan@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
CC:     Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>
Subject: [PATCH v4 4/4] arm64: dts: ti: Add support for J784S4 EVM board
Date:   Fri, 23 Dec 2022 02:15:45 +0530
Message-ID: <20221222204545.45281-5-a-nandan@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221222204545.45281-1-a-nandan@ti.com>
References: <20221222204545.45281-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

J784S4 EVM board is designed for TI J784S4 SoC. It supports the following
interfaces:
* 32 GB DDR4 RAM
* x2 Gigabit Ethernet interfaces capable of working in Switch and MAC mode
* x1 Input Audio Jack, x1 Output Audio Jack
* x1 USB2.0 Hub with two Type A host and x1 USB 3.1 Type-C Port
* x2 4L PCIe connector
* x1 UHS-1 capable micro-SD card slot
* 512 Mbit OSPI flash, 1 Gbit Octal NAND flash, 512 Mbit QSPI flash,
  UFS flash.
* x6 UART through UART-USB bridge
* XDS110 for onboard JTAG debug using USB
* Temperature sensors, user push buttons and LEDs
* 40-pin User Expansion Connector
* x2 ENET Expansion Connector, x1 GESI expander, x2 Display connector
* x1 15-pin CSI header
* x6 MCAN instances

Add basic support for J784S4-EVM.

Schematics: https://www.ti.com/lit/zip/sprr458

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Apurva Nandan <a-nandan@ti.com>
Tested-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm64/boot/dts/ti/Makefile          |   2 +
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 196 +++++++++++++++++++++++
 2 files changed, 198 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index cf7c509538a4..27b2e1f5555e 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -20,6 +20,8 @@ dtb-$(CONFIG_ARCH_K3) += k3-j7200-common-proc-board.dtb
 
 dtb-$(CONFIG_ARCH_K3) += k3-j721s2-common-proc-board.dtb
 
+dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
+
 dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
 
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
new file mode 100644
index 000000000000..8cd4a7ecc121
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ * EVM Board Schematics: https://www.ti.com/lit/zip/sprr458
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/net/ti-dp83867.h>
+#include <dt-bindings/gpio/gpio.h>
+#include "k3-j784s4.dtsi"
+
+/ {
+	compatible = "ti,j784s4-evm", "ti,j784s4";
+	model = "Texas Instruments J784S4 EVM";
+
+	chosen {
+		stdout-path = "serial2:115200n8";
+	};
+
+	aliases {
+		serial2 = &main_uart8;
+		mmc1 = &main_sdhci1;
+		i2c0 = &main_i2c0;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		/* 32G RAM */
+		reg = <0x00 0x80000000 0x00 0x80000000>,
+		      <0x08 0x80000000 0x07 0x80000000>;
+	};
+
+	reserved_memory: reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		secure_ddr: optee@9e800000 {
+			reg = <0x00 0x9e800000 0x00 0x01800000>;
+			no-map;
+		};
+	};
+
+	evm_12v0: regulator-evm12v0 {
+		/* main supply */
+		compatible = "regulator-fixed";
+		regulator-name = "evm_12v0";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vsys_3v3: regulator-vsys3v3 {
+		/* Output of LM5140 */
+		compatible = "regulator-fixed";
+		regulator-name = "vsys_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&evm_12v0>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vsys_5v0: regulator-vsys5v0 {
+		/* Output of LM5140 */
+		compatible = "regulator-fixed";
+		regulator-name = "vsys_5v0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&evm_12v0>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vdd_mmc1: regulator-sd {
+		/* Output of TPS22918 */
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_mmc1";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		enable-active-high;
+		vin-supply = <&vsys_3v3>;
+		gpio = <&exp2 2 GPIO_ACTIVE_HIGH>;
+	};
+
+	vdd_sd_dv: regulator-TLV71033 {
+		/* Output of TLV71033 */
+		compatible = "regulator-gpio";
+		regulator-name = "tlv71033";
+		pinctrl-names = "default";
+		pinctrl-0 = <&vdd_sd_dv_pins_default>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		vin-supply = <&vsys_5v0>;
+		gpios = <&main_gpio0 8 GPIO_ACTIVE_HIGH>;
+		states = <1800000 0x0>,
+			 <3300000 0x1>;
+	};
+};
+
+&main_pmx0 {
+	main_uart8_pins_default: main-uart8-pins-default {
+		pinctrl-single,pins = <
+			J784S4_IOPAD(0x040, PIN_INPUT, 14) /* (AF37) MCASP0_AXR0.UART8_CTSn */
+			J784S4_IOPAD(0x044, PIN_OUTPUT, 14) /* (AG37) MCASP0_AXR1.UART8_RTSn */
+			J784S4_IOPAD(0x0d0, PIN_INPUT, 11) /* (AP38) SPI0_CS1.UART8_RXD */
+			J784S4_IOPAD(0x0d4, PIN_OUTPUT, 11) /* (AN38) SPI0_CLK.UART8_TXD */
+		>;
+	};
+
+	main_i2c0_pins_default: main-i2c0-pins-default {
+		pinctrl-single,pins = <
+			J784S4_IOPAD(0x0e0, PIN_INPUT_PULLUP, 0) /* (AN36) I2C0_SCL */
+			J784S4_IOPAD(0x0e4, PIN_INPUT_PULLUP, 0) /* (AP37) I2C0_SDA */
+		>;
+	};
+
+	main_mmc1_pins_default: main-mmc1-pins-default {
+		pinctrl-single,pins = <
+			J784S4_IOPAD(0x104, PIN_INPUT, 0) /* (AB38) MMC1_CLK */
+			J784S4_IOPAD(0x108, PIN_INPUT, 0) /* (AB36) MMC1_CMD */
+			J784S4_IOPAD(0x100, PIN_INPUT, 0) /* (No Pin) MMC1_CLKLB */
+			J784S4_IOPAD(0x0fc, PIN_INPUT, 0) /* (AA33) MMC1_DAT0 */
+			J784S4_IOPAD(0x0f8, PIN_INPUT, 0) /* (AB34) MMC1_DAT1 */
+			J784S4_IOPAD(0x0f4, PIN_INPUT, 0) /* (AA32) MMC1_DAT2 */
+			J784S4_IOPAD(0x0f0, PIN_INPUT, 0) /* (AC38) MMC1_DAT3 */
+			J784S4_IOPAD(0x0e8, PIN_INPUT, 8) /* (AR38) TIMER_IO0.MMC1_SDCD */
+		>;
+	};
+
+	vdd_sd_dv_pins_default: vdd-sd-dv-pins-default {
+		pinctrl-single,pins = <
+			J784S4_IOPAD(0x020, PIN_INPUT, 7) /* (AJ35) MCAN15_RX.GPIO0_8 */
+		>;
+	};
+};
+
+&main_uart8 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart8_pins_default>;
+};
+
+&main_i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c0_pins_default>;
+
+	clock-frequency = <400000>;
+
+	exp1: gpio@20 {
+		compatible = "ti,tca6416";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "PCIE1_2L_MODE_SEL", "PCIE1_4L_PERSTZ", "PCIE1_2L_RC_RSTZ",
+				  "PCIE1_2L_EP_RST_EN", "PCIE0_4L_MODE_SEL", "PCIE0_4L_PERSTZ",
+				  "PCIE0_4L_RC_RSTZ", "PCIE0_4L_EP_RST_EN", "PCIE1_4L_PRSNT#",
+				  "PCIE0_4L_PRSNT#", "CDCI1_OE1/OE4", "CDCI1_OE2/OE3",
+				  "AUDIO_MUX_SEL", "EXP_MUX2", "EXP_MUX3", "GESI_EXP_PHY_RSTZ";
+	};
+
+	exp2: gpio@22 {
+		compatible = "ti,tca6424";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "R_GPIO_RGMII1_RST", "ENET2_I2CMUX_SEL", "GPIO_USD_PWR_EN",
+				  "USBC_PWR_EN", "USBC_MODE_SEL1", "USBC_MODE_SEL0",
+				  "GPIO_LIN_EN", "R_CAN_STB", "CTRL_PM_I2C_OE#",
+				  "ENET2_EXP_PWRDN", "ENET2_EXP_SPARE2", "CDCI2_RSTZ",
+				  "USB2.0_MUX_SEL", "CANUART_MUX_SEL0", "CANUART_MUX2_SEL1",
+				  "CANUART_MUX1_SEL1", "ENET1_EXP_PWRDN", "ENET1_EXP_RESETZ",
+				  "ENET1_I2CMUX_SEL", "ENET1_EXP_SPARE2", "ENET2_EXP_RESETZ",
+				  "USER_INPUT1", "USER_LED1", "USER_LED2";
+	};
+};
+
+&main_sdhci1 {
+	/* SD card */
+	status = "okay";
+	pinctrl-0 = <&main_mmc1_pins_default>;
+	pinctrl-names = "default";
+	disable-wp;
+	vmmc-supply = <&vdd_mmc1>;
+	vqmmc-supply = <&vdd_sd_dv>;
+};
+
+&main_gpio0 {
+	status = "okay";
+};
-- 
2.34.1

