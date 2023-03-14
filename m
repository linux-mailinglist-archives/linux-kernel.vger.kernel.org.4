Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF0B6B9DE4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjCNSG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjCNSGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:06:45 -0400
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987199FE4C;
        Tue, 14 Mar 2023 11:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1678817198;
        bh=rmg4A4W1CbRV9wINKTLQBgaKx+M5KB6pWdhp232zNHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e2L30ObWdcSeABDz5g2kiIuXSg6X2asFrpo2O/wNTu1xYCdFRiVDM4CCXPLjBvxit
         mm41L1iNSLjn/o8JEVgF8AIHf8cFsrLfL18DGyo0V1xp1MPnuoTu+mlxcUnpMKfeAy
         yulJ7GcUhbMPmWCxjUJLYye5dDgxhNrSSKOfjRuc=
Received: from vokac-Latitude-7410.ysoft.local (unknown [10.0.30.161])
        by uho.ysoft.cz (Postfix) with ESMTP id 86D46A05E5;
        Tue, 14 Mar 2023 19:06:38 +0100 (CET)
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH v2 5/5] =?UTF-8?q?ARM:=20dts:=20imx6dl-yapp43:=20Add=20sup?= =?UTF-8?q?port=20for=20new=20HW=20revision=20of=20the=20IOTA=C2=A0board?=
Date:   Tue, 14 Mar 2023 19:06:08 +0100
Message-Id: <20230314180608.44482-6-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230314180608.44482-1-michal.vokac@ysoft.com>
References: <20230314180608.44482-1-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PCB used for all the current boards (Ursa, Draco, Hydra, Orion, Crux)
was slightly redesigned and delivers some new features while some unused
components were removed.

- External RTC chip with supercap added.
- Secure element added.
- LCD display power supply enable/disable signal added.
- Touch keyboard reset and interrupt signals added.
- Factory reset GPIO button added.
- Audio codec LM49350 (EoL) removed and replaced by PWM audio output.
- QCA8334 switch was replaced by Marvell 88E6141.
- PCIe completely removed.
- uSD card removed and replaced by board-to-board expansion connector.

There are four configuration variants of the new board:

1. Pegasus
The board configuration is based on Orion with the following major changes:

- Quad core SoC
- 4GB of RAM
- RTC with supercap added
- Secure element added

2. Pegasus+
This is the very same board as Pegasus but uses the i.MX6QuadPlus SoC.

3. Lynx
The board configuration is based on Draco with the following major changes:

- DualLite SoC
- 1GB of RAM
- RTC with supercap added
- Secure element added

4. Phoenix
The board configuration is based on Ursa with the following major changes:

- DualLite Soc
- 1GB of RAM
- RTC with supercap added
- Secure element added
- LCD display support removed
- UART2 removed
- Factory reset GPIO button added

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
Changes in v2:
- properly sorted entry for imx6q-yapp4-pegasus.dtb in Makefile
- dropped deprecated fec binding for phy-reset-duration and
  phy-reset-gpios. Reset moved to mdio switch subnode.
- moved status property to the end in led-controlled device node
- removed status = "okay" where not needed

 arch/arm/boot/dts/Makefile                    |   4 +
 arch/arm/boot/dts/imx6dl-yapp4-lynx.dts       |  58 ++
 arch/arm/boot/dts/imx6dl-yapp4-phoenix.dts    |  42 ++
 arch/arm/boot/dts/imx6dl-yapp43-common.dtsi   | 615 ++++++++++++++++++
 arch/arm/boot/dts/imx6q-yapp4-pegasus.dts     |  58 ++
 .../boot/dts/imx6qp-yapp4-pegasus-plus.dts    |  58 ++
 6 files changed, 835 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-yapp4-lynx.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-yapp4-phoenix.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-yapp43-common.dtsi
 create mode 100644 arch/arm/boot/dts/imx6q-yapp4-pegasus.dts
 create mode 100644 arch/arm/boot/dts/imx6qp-yapp4-pegasus-plus.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index efe4152e5846..4f58dba50f0d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -561,7 +561,9 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-wandboard-revd1.dtb \
 	imx6dl-yapp4-draco.dtb \
 	imx6dl-yapp4-hydra.dtb \
+	imx6dl-yapp4-lynx.dtb \
 	imx6dl-yapp4-orion.dtb \
+	imx6dl-yapp4-phoenix.dtb \
 	imx6dl-yapp4-ursa.dtb \
 	imx6q-apalis-eval.dtb \
 	imx6q-apalis-ixora.dtb \
@@ -668,6 +670,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6q-wandboard-revb1.dtb \
 	imx6q-wandboard-revd1.dtb \
 	imx6q-yapp4-crux.dtb \
+	imx6q-yapp4-pegasus.dtb \
 	imx6q-zii-rdu2.dtb \
 	imx6qp-mba6b.dtb \
 	imx6qp-nitrogen6_max.dtb \
@@ -683,6 +686,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6qp-vicutp.dtb \
 	imx6qp-wandboard-revd1.dtb \
 	imx6qp-yapp4-crux-plus.dtb \
+	imx6qp-yapp4-pegasus-plus.dtb \
 	imx6qp-zii-rdu2.dtb \
 	imx6s-dhcom-drc02.dtb
 dtb-$(CONFIG_SOC_IMX6SL) += \
diff --git a/arch/arm/boot/dts/imx6dl-yapp4-lynx.dts b/arch/arm/boot/dts/imx6dl-yapp4-lynx.dts
new file mode 100644
index 000000000000..5c2cd517589b
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-yapp4-lynx.dts
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2021 Y Soft Corporation, a.s.
+
+/dts-v1/;
+
+#include "imx6dl.dtsi"
+#include "imx6dl-yapp43-common.dtsi"
+
+/ {
+	model = "Y Soft IOTA Lynx i.MX6DualLite board";
+	compatible = "ysoft,imx6dl-yapp4-lynx", "fsl,imx6dl";
+
+	memory@10000000 {
+		device_type = "memory";
+		reg = <0x10000000 0x40000000>;
+	};
+};
+
+&backlight {
+	status = "okay";
+};
+
+&lcd_display {
+	status = "okay";
+};
+
+&leds {
+	status = "okay";
+};
+
+&panel {
+	status = "okay";
+};
+
+&pwm1 {
+	status = "okay";
+};
+
+&reg_usb_h1_vbus {
+	status = "okay";
+};
+
+&touchscreen {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&usbh1 {
+	status = "okay";
+};
+
+&usbphy2 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6dl-yapp4-phoenix.dts b/arch/arm/boot/dts/imx6dl-yapp4-phoenix.dts
new file mode 100644
index 000000000000..e0292f11d03e
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-yapp4-phoenix.dts
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2021 Y Soft Corporation, a.s.
+
+/dts-v1/;
+
+#include "imx6dl.dtsi"
+#include "imx6dl-yapp43-common.dtsi"
+
+/ {
+	model = "Y Soft IOTA Phoenix i.MX6DualLite board";
+	compatible = "ysoft,imx6dl-yapp4-phoenix", "fsl,imx6dl";
+
+	memory@10000000 {
+		device_type = "memory";
+		reg = <0x10000000 0x40000000>;
+	};
+};
+
+&aliases {
+	/delete-property/ ethernet1;
+};
+
+&gpio_keys {
+	status = "okay";
+};
+
+&reg_usb_h1_vbus {
+	status = "okay";
+};
+
+&switch_ports {
+	/delete-node/ port@2;
+};
+
+&usbh1 {
+	status = "okay";
+};
+
+&usbphy2 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6dl-yapp43-common.dtsi b/arch/arm/boot/dts/imx6dl-yapp43-common.dtsi
new file mode 100644
index 000000000000..52a0f6ee426f
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-yapp43-common.dtsi
@@ -0,0 +1,615 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2021 Y Soft Corporation, a.s.
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/pwm/pwm.h>
+
+/ {
+	aliases: aliases {
+		ethernet1 = &eth1;
+		ethernet2 = &eth2;
+		mmc0 = &usdhc3;
+		mmc1 = &usdhc4;
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm1 0 500000 PWM_POLARITY_INVERTED>;
+		brightness-levels = <0 32 64 128 255>;
+		default-brightness-level = <32>;
+		num-interpolated-steps = <8>;
+		power-supply = <&sw2_reg>;
+		status = "disabled";
+	};
+
+	gpio_keys: gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_keys>;
+		status = "disabled";
+
+		button {
+			label = "Factory RESET";
+			linux,code = <BTN_0>;
+			gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	lcd_display: display {
+		compatible = "fsl,imx-parallel-display";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interface-pix-fmt = "rgb24";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ipu1>;
+		status = "disabled";
+
+		port@0 {
+			reg = <0>;
+
+			lcd_display_in: endpoint {
+				remote-endpoint = <&ipu1_di0_disp0>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+
+			lcd_display_out: endpoint {
+				remote-endpoint = <&lcd_panel_in>;
+			};
+		};
+	};
+
+	panel: panel {
+		compatible = "dataimage,scf0700c48ggu18";
+		power-supply = <&sw2_reg>;
+		backlight = <&backlight>;
+		enable-gpios = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		status = "disabled";
+
+		port {
+			lcd_panel_in: endpoint {
+				remote-endpoint = <&lcd_display_out>;
+			};
+		};
+	};
+
+	reg_usb_h1_vbus: regulator-usb-h1-vbus {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbh1_vbus>;
+		regulator-name = "usb_h1_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio1 29 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		status = "disabled";
+	};
+
+	reg_usb_otg_vbus: regulator-usb-otg-vbus {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbotg_vbus>;
+		regulator-name = "usb_otg_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet>;
+	phy-mode = "rgmii-id";
+	phy-supply = <&sw2_reg>;
+	status = "okay";
+
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+	};
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		switch@0 {
+			compatible = "marvell,mv88e6085";
+			reg = <0>;
+			reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
+
+			switch_ports: ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				ethphy0: port@0 {
+					reg = <0>;
+					label = "cpu";
+					phy-mode = "rgmii-id";
+					ethernet = <&fec>;
+
+					fixed-link {
+						speed = <1000>;
+						full-duplex;
+					};
+				};
+
+				eth2: port@1 {
+					reg = <1>;
+					label = "eth2";
+					phy-handle = <&phy_port1>;
+				};
+
+				eth1: port@2 {
+					reg = <2>;
+					label = "eth1";
+					phy-handle = <&phy_port2>;
+				};
+			};
+
+			mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				phy_port1: switchphy@11 {
+					reg = <0x11>;
+				};
+
+				phy_port2: switchphy@12 {
+					reg = <0x12>;
+				};
+			};
+		};
+	};
+};
+
+&i2c2 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	pmic@8 {
+		compatible = "fsl,pfuze200";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pmic>;
+		reg = <0x8>;
+
+		regulators {
+			sw1a_reg: sw1ab {
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1875000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <6250>;
+			};
+
+			sw2_reg: sw2 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw3a_reg: sw3a {
+				regulator-min-microvolt = <400000>;
+				regulator-max-microvolt = <1975000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw3b_reg: sw3b {
+				regulator-min-microvolt = <400000>;
+				regulator-max-microvolt = <1975000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			swbst_reg: swbst {
+				regulator-min-microvolt = <5000000>;
+				regulator-max-microvolt = <5150000>;
+			};
+
+			vgen1_reg: vgen1 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1550000>;
+			};
+
+			vgen2_reg: vgen2 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1550000>;
+			};
+
+			vgen3_reg: vgen3 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen4_reg: vgen4 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen5_reg: vgen5 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen6_reg: vgen6 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vref_reg: vrefddr {
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vsnvs_reg: vsnvs {
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+
+	leds: led-controller@30 {
+		compatible = "ti,lp5562";
+		reg = <0x30>;
+		clock-mode = /bits/ 8 <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+
+		led@0 {
+			chan-name = "R";
+			led-cur = /bits/ 8 <0x20>;
+			max-cur = /bits/ 8 <0x60>;
+			reg = <0>;
+			color = <LED_COLOR_ID_RED>;
+		};
+
+		led@1 {
+			chan-name = "G";
+			led-cur = /bits/ 8 <0x20>;
+			max-cur = /bits/ 8 <0x60>;
+			reg = <1>;
+			color = <LED_COLOR_ID_GREEN>;
+		};
+
+		led@2 {
+			chan-name = "B";
+			led-cur = /bits/ 8 <0x20>;
+			max-cur = /bits/ 8 <0x60>;
+			reg = <2>;
+			color = <LED_COLOR_ID_BLUE>;
+		};
+	};
+
+	eeprom@57 {
+		compatible = "atmel,24c128";
+		reg = <0x57>;
+		pagesize = <64>;
+	};
+
+	touchscreen: touchscreen@5c {
+		compatible = "pixcir,pixcir_tangoc";
+		reg = <0x5c>;
+		pinctrl-0 = <&pinctrl_touch>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
+		attb-gpio = <&gpio4 5 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
+		touchscreen-size-x = <800>;
+		touchscreen-size-y = <480>;
+		status = "disabled";
+	};
+
+	rtc: rtc@68 {
+		compatible = "dallas,ds1341";
+		reg = <0x68>;
+	};
+};
+
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "disabled";
+
+	oled_1309: oled@3c {
+		compatible = "solomon,ssd1309fb-i2c";
+		reg = <0x3c>;
+		solomon,height = <64>;
+		solomon,width = <128>;
+		solomon,page-offset = <0>;
+		solomon,segment-no-remap;
+		solomon,prechargep2 = <15>;
+		reset-gpios = <&gpio_oled 1 GPIO_ACTIVE_LOW>;
+		vbat-supply = <&sw2_reg>;
+		status = "disabled";
+	};
+
+	oled_1305: oled@3d {
+		compatible = "solomon,ssd1305fb-i2c";
+		reg = <0x3d>;
+		solomon,height = <64>;
+		solomon,width = <128>;
+		solomon,page-offset = <0>;
+		solomon,col-offset = <4>;
+		solomon,prechargep2 = <15>;
+		reset-gpios = <&gpio_oled 1 GPIO_ACTIVE_LOW>;
+		vbat-supply = <&sw2_reg>;
+		status = "disabled";
+	};
+
+	gpio_oled: gpio@41 {
+		compatible = "nxp,pca9536";
+		gpio-controller;
+		#gpio-cells = <2>;
+		reg = <0x41>;
+		vcc-supply = <&sw2_reg>;
+		status = "disabled";
+	};
+
+	touchkeys: keys@5a {
+		compatible = "fsl,mpr121-touchkey";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_touchkeys>;
+		reg = <0x5a>;
+		vdd-supply = <&sw2_reg>;
+		autorepeat;
+		linux,keycodes = <KEY_1>, <KEY_2>, <KEY_3>, <KEY_4>, <KEY_5>,
+				<KEY_6>, <KEY_7>, <KEY_8>, <KEY_9>,
+				<KEY_BACKSPACE>, <KEY_0>, <KEY_ENTER>;
+		poll-interval = <50>;
+		status = "disabled";
+	};
+};
+
+&iomuxc {
+	pinctrl_enet: enetgrp {
+		fsl,pins = <
+			MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b020
+			MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b020
+			MX6QDL_PAD_RGMII_TXC__RGMII_TXC		0x1b020
+			MX6QDL_PAD_RGMII_TD0__RGMII_TD0		0x1b020
+			MX6QDL_PAD_RGMII_TD1__RGMII_TD1		0x1b020
+			MX6QDL_PAD_RGMII_TD2__RGMII_TD2		0x1b020
+			MX6QDL_PAD_RGMII_TD3__RGMII_TD3		0x1b020
+			MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL	0x1b020
+			MX6QDL_PAD_RGMII_RXC__RGMII_RXC		0x1b020
+			MX6QDL_PAD_RGMII_RD0__RGMII_RD0		0x1b020
+			MX6QDL_PAD_RGMII_RD1__RGMII_RD1		0x1b020
+			MX6QDL_PAD_RGMII_RD2__RGMII_RD2		0x1b020
+			MX6QDL_PAD_RGMII_RD3__RGMII_RD3		0x1b020
+			MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x1b020
+			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK	0x1b010
+			MX6QDL_PAD_GPIO_16__ENET_REF_CLK	0x1b010
+			MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25	0x1b098
+		>;
+	};
+
+	pinctrl_gpio_keys: gpiokeysgrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_0__GPIO1_IO00	0x1b0b0
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_COL3__I2C2_SCL	0x4001b899
+			MX6QDL_PAD_KEY_ROW3__I2C2_SDA	0x4001b899
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_3__I2C3_SCL	0x4001b899
+			MX6QDL_PAD_GPIO_6__I2C3_SDA	0x4001b899
+		>;
+	};
+
+	pinctrl_ipu1: ipu1grp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_DA7__GPIO3_IO07                  0x1b0b0
+			MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK	0x10
+			MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02		0x10
+			MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03		0x10
+			MX6QDL_PAD_DISP0_DAT0__IPU1_DISP0_DATA00	0x10
+			MX6QDL_PAD_DISP0_DAT1__IPU1_DISP0_DATA01	0x10
+			MX6QDL_PAD_DISP0_DAT2__IPU1_DISP0_DATA02	0x10
+			MX6QDL_PAD_DISP0_DAT3__IPU1_DISP0_DATA03	0x10
+			MX6QDL_PAD_DISP0_DAT4__IPU1_DISP0_DATA04	0x10
+			MX6QDL_PAD_DISP0_DAT5__IPU1_DISP0_DATA05	0x10
+			MX6QDL_PAD_DISP0_DAT6__IPU1_DISP0_DATA06	0x10
+			MX6QDL_PAD_DISP0_DAT7__IPU1_DISP0_DATA07	0x10
+			MX6QDL_PAD_DISP0_DAT8__IPU1_DISP0_DATA08	0x10
+			MX6QDL_PAD_DISP0_DAT9__IPU1_DISP0_DATA09	0x10
+			MX6QDL_PAD_DISP0_DAT10__IPU1_DISP0_DATA10	0x10
+			MX6QDL_PAD_DISP0_DAT11__IPU1_DISP0_DATA11	0x10
+			MX6QDL_PAD_DISP0_DAT12__IPU1_DISP0_DATA12	0x10
+			MX6QDL_PAD_DISP0_DAT13__IPU1_DISP0_DATA13	0x10
+			MX6QDL_PAD_DISP0_DAT14__IPU1_DISP0_DATA14	0x10
+			MX6QDL_PAD_DISP0_DAT15__IPU1_DISP0_DATA15	0x10
+			MX6QDL_PAD_DISP0_DAT16__IPU1_DISP0_DATA16	0x10
+			MX6QDL_PAD_DISP0_DAT17__IPU1_DISP0_DATA17	0x10
+			MX6QDL_PAD_DISP0_DAT18__IPU1_DISP0_DATA18	0x10
+			MX6QDL_PAD_DISP0_DAT19__IPU1_DISP0_DATA19	0x10
+			MX6QDL_PAD_DISP0_DAT20__IPU1_DISP0_DATA20	0x10
+			MX6QDL_PAD_DISP0_DAT21__IPU1_DISP0_DATA21	0x10
+			MX6QDL_PAD_DISP0_DAT22__IPU1_DISP0_DATA22	0x10
+			MX6QDL_PAD_DISP0_DAT23__IPU1_DISP0_DATA23	0x10
+		>;
+	};
+
+	pinctrl_pmic: pmicgrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_18__GPIO7_IO13	0x1b098
+		>;
+	};
+
+	pinctrl_pwm1: pwm1grp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_9__PWM1_OUT	0x8
+		>;
+	};
+
+	pinctrl_touch: touchgrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_19__GPIO4_IO05	0x1b098
+			MX6QDL_PAD_GPIO_2__GPIO1_IO02	0x1b098
+		>;
+	};
+
+	pinctrl_touchkeys: touchkeysgrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_17__GPIO7_IO12	0x1b098
+			MX6QDL_PAD_GPIO_5__GPIO1_IO05	0x1b098
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA	0x1b0a8
+			MX6QDL_PAD_CSI0_DAT11__UART1_RX_DATA	0x1b0a8
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_7__UART2_TX_DATA	0x1b098
+			MX6QDL_PAD_GPIO_8__UART2_RX_DATA	0x1b098
+		>;
+	};
+
+	pinctrl_usbh1: usbh1grp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D30__USB_H1_OC	0x1b098
+		>;
+	};
+
+	pinctrl_usbh1_vbus: usbh1-vbus {
+		fsl,pins = <
+			MX6QDL_PAD_ENET_TXD1__GPIO1_IO29	0x98
+		>;
+	};
+
+	pinctrl_usbotg: usbotggrp {
+		fsl,pins = <
+			MX6QDL_PAD_ENET_RX_ER__USB_OTG_ID	0x1b098
+			MX6QDL_PAD_EIM_D21__USB_OTG_OC		0x1b098
+		>;
+	};
+
+	pinctrl_usbotg_vbus: usbotg-vbus {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D22__GPIO3_IO22	0x98
+		>;
+	};
+
+	pinctrl_usdhc4: usdhc4grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD4_CMD__SD4_CMD	0x1f069
+			MX6QDL_PAD_SD4_CLK__SD4_CLK	0x10069
+			MX6QDL_PAD_SD4_DAT0__SD4_DATA0	0x17069
+			MX6QDL_PAD_SD4_DAT1__SD4_DATA1	0x17069
+			MX6QDL_PAD_SD4_DAT2__SD4_DATA2	0x17069
+			MX6QDL_PAD_SD4_DAT3__SD4_DATA3	0x17069
+			MX6QDL_PAD_SD4_DAT4__SD4_DATA4	0x17069
+			MX6QDL_PAD_SD4_DAT5__SD4_DATA5	0x17069
+			MX6QDL_PAD_SD4_DAT6__SD4_DATA6	0x17069
+			MX6QDL_PAD_SD4_DAT7__SD4_DATA7	0x17069
+		>;
+	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_1__WDOG2_B	0x1b0b0
+		>;
+	};
+};
+
+&ipu1_di0_disp0 {
+	remote-endpoint = <&lcd_display_in>;
+};
+
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1>;
+	status = "disabled";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	status = "disabled";
+};
+
+&usbh1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbh1>;
+	vbus-supply = <&reg_usb_h1_vbus>;
+	over-current-active-low;
+	status = "disabled";
+};
+
+&usbotg {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg>;
+	vbus-supply = <&reg_usb_otg_vbus>;
+	over-current-active-low;
+	srp-disable;
+	hnp-disable;
+	adp-disable;
+	status = "okay";
+};
+
+&usbphy1 {
+	fsl,tx-d-cal = <106>;
+	status = "okay";
+};
+
+&usbphy2 {
+	fsl,tx-d-cal = <109>;
+	status = "disabled";
+};
+
+&usdhc4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc4>;
+	bus-width = <8>;
+	non-removable;
+	no-1-8-v;
+	keep-power-in-suspend;
+	vmmc-supply = <&sw2_reg>;
+	status = "okay";
+};
+
+&wdog1 {
+	status = "disabled";
+};
+
+&wdog2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6q-yapp4-pegasus.dts b/arch/arm/boot/dts/imx6q-yapp4-pegasus.dts
new file mode 100644
index 000000000000..ec6651ba4ba2
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-yapp4-pegasus.dts
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2021 Y Soft Corporation, a.s.
+
+/dts-v1/;
+
+#include "imx6q.dtsi"
+#include "imx6dl-yapp43-common.dtsi"
+
+/ {
+	model = "Y Soft IOTA Pegasus i.MX6Quad board";
+	compatible = "ysoft,imx6q-yapp4-pegasus", "fsl,imx6q";
+
+	memory@10000000 {
+		device_type = "memory";
+		reg = <0x10000000 0xf0000000>;
+	};
+};
+
+&gpio_oled {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&leds {
+	status = "okay";
+};
+
+&oled_1305 {
+	status = "okay";
+};
+
+&oled_1309 {
+	status = "okay";
+};
+
+&reg_pu {
+	regulator-always-on;
+};
+
+&reg_usb_h1_vbus {
+	status = "okay";
+};
+
+&touchkeys {
+	status = "okay";
+};
+
+&usbh1 {
+	status = "okay";
+};
+
+&usbphy2 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6qp-yapp4-pegasus-plus.dts b/arch/arm/boot/dts/imx6qp-yapp4-pegasus-plus.dts
new file mode 100644
index 000000000000..4a961a33bf2d
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qp-yapp4-pegasus-plus.dts
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2021 Y Soft Corporation, a.s.
+
+/dts-v1/;
+
+#include "imx6qp.dtsi"
+#include "imx6dl-yapp43-common.dtsi"
+
+/ {
+	model = "Y Soft IOTA Pegasus+ i.MX6QuadPlus board";
+	compatible = "ysoft,imx6qp-yapp4-pegasus-plus", "fsl,imx6qp";
+
+	memory@10000000 {
+		device_type = "memory";
+		reg = <0x10000000 0xf0000000>;
+	};
+};
+
+&gpio_oled {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&leds {
+	status = "okay";
+};
+
+&oled_1305 {
+	status = "okay";
+};
+
+&oled_1309 {
+	status = "okay";
+};
+
+&reg_pu {
+	regulator-always-on;
+};
+
+&reg_usb_h1_vbus {
+	status = "okay";
+};
+
+&touchkeys {
+	status = "okay";
+};
+
+&usbh1 {
+	status = "okay";
+};
+
+&usbphy2 {
+	status = "okay";
+};
-- 
2.25.1

