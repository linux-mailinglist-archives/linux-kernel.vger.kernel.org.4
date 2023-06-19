Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21503734BD4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 08:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjFSGnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 02:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjFSGnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 02:43:00 -0400
Received: from mail.inventec.com (mail.inventec.com [61.220.76.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B904B1B6;
        Sun, 18 Jun 2023 23:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
    s=sEx04; d=inventec.com;
    h=from:to:cc:subject:date:message-id:in-reply-to:mime-version:
      content-type;
    bh=eb5T0VtdtzKouwRPXB4PuHymzhd3Mg+INur6+8aDvIg=;
    b=HxeXED1tzjGTtsQHT5DvHGKoYdSQgukhtAQYdooI2ARgwbZtsKsu5HlETsuuW7
      Yf/sVi0Hdp8oC1kKomqcBGulg/0C4JUj19Fn5A58we9wZCo2WRQESHJk+KzWM8
      yEPmXxB3lPcceDYWNahFk4CJ3j8LWbjg02qNJn72IONibaI=
Received: from IEC1-EX2016-04.iec.inventec (10.1.254.222) by
 IEC1-EX2016-04.iec.inventec (10.1.254.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 19 Jun 2023 14:42:53 +0800
Received: from TAO-MailRelay-1.iec.inventec (10.6.254.133) by
 IEC1-EX2016-04.iec.inventec (10.1.254.222) with Microsoft SMTP Server id
 15.1.2507.23 via Frontend Transport; Mon, 19 Jun 2023 14:42:53 +0800
Received: from charon ([10.6.141.37]) by TAO-MailRelay-1.iec.inventec with Microsoft SMTPSVC(8.0.9200.16384);
         Mon, 19 Jun 2023 14:42:53 +0800
From:   PJ Chen <chen.pj@inventec.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-aspeed@lists.ozlabs.org>
CC:     <ye.vic@inventec.com>, <Huang.Alang@inventec.com>,
        Chen PJ <Chen.pj@inventec.com>
Subject: [PATCH v5 2/2] ARM: dts: aspeed: Adding Inventec Starscream BMC
Date:   Mon, 19 Jun 2023 14:42:49 +0800
Message-ID: <20230619064249.3623-2-chen.pj@inventec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230619064249.3623-1-chen.pj@inventec.com>
References: <20230619064249.3623-1-chen.pj@inventec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 19 Jun 2023 06:42:53.0247 (UTC) FILETIME=[45F384F0:01D9A279]
Content-Type: text/plain
X-TM-SNTS-SMTP: 680A6C23417125417F5BBD99C3B425B7C3B97B38C51D2BC9FF4CDD1F9771BCB22000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,WEIRD_QUOTING autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen PJ <Chen.pj@inventec.com>

Initial introduction of Inventec Starscream x86 family
equipped with AST2600 BMC SoC.

Signed-off-by: Chen PJ <Chen.pj@inventec.com>

---
 V4 -> V5:
  - Remove devices not defined in dt-binding yet.
 V3 -> V4:
  - Reply with devicetree binding
    https://lore.kernel.org/all/28f0ce0a82464083ae24f9ef2f598425@inventec.com/
 V2 -> V3:
  - Rename the node name to generic.
 V1 -> V2:
  - Correct License description
  - Remove not supported device
  - Using openbmc-flash-layout.dtsi
  - Correct device format
---
 arch/arm/boot/dts/Makefile                    |   1 +
 .../dts/aspeed-bmc-inventec-starscream.dts    | 465 ++++++++++++++++++
 2 files changed, 466 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-inventec-starscream.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index eb681903d50b..6a897ff40ff0 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1629,6 +1629,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-quanta-q71l.dtb \
 	aspeed-bmc-quanta-s6q.dtb \
 	aspeed-bmc-supermicro-x11spi.dtb \
+	aspeed-bmc-inventec-starscream.dtb \
 	aspeed-bmc-inventec-transformers.dtb \
 	aspeed-bmc-tyan-s7106.dtb \
 	aspeed-bmc-tyan-s8036.dtb \
diff --git a/arch/arm/boot/dts/aspeed-bmc-inventec-starscream.dts b/arch/arm/boot/dts/aspeed-bmc-inventec-starscream.dts
new file mode 100644
index 000000000000..9fd1dd5633af
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-inventec-starscream.dts
@@ -0,0 +1,465 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright 2023 Inventec Corp.
+
+/dts-v1/;
+
+#include "aspeed-g6.dtsi"
+#include "aspeed-g6-pinctrl.dtsi"
+#include <dt-bindings/i2c/i2c.h>
+#include <dt-bindings/gpio/aspeed-gpio.h>
+
+/ {
+	model = "STARSCREAM BMC";
+	compatible = "inventec,starscream-bmc", "aspeed,ast2600";
+
+	aliases {
+		serial4 = &uart5;
+	};
+
+	chosen {
+		stdout-path = &uart5;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x80000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		video_engine_memory: video {
+			size = <0x04000000>;
+			alignment = <0x01000000>;
+			compatible = "shared-dma-pool";
+			reusable;
+		};
+	};
+
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels =
+		<&adc_u74 0>, // P0_VDD11
+		<&adc_u74 1>, // P1_VDD11
+		<&adc_u74 2>, // P0_3V3_S5
+		<&adc_u74 3>, // P1_3V3_S5
+		<&adc_u74 4>, // P3V3
+		<&adc_u74 5>, // VBAT
+		<&adc_u74 6>, // P3V3_STBY
+		<&adc_u74 7>, // P5V_STBY
+		<&adc_u74 8>, // P5V
+		<&adc_u74 9>, // P12V
+		<&adc_u74 10>, // P1_VDD18_S5
+		<&adc_u74 11> // P0_VDD18_S5
+		;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		uid {
+			label = "UID_LED";
+			gpios = <&gpio0 ASPEED_GPIO(X, 2) GPIO_ACTIVE_LOW>;
+		};
+
+		heartbeat {
+			label = "HB_LED";
+			gpios = <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&mdio0 {
+	status = "okay";
+
+	ethphy0: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+	};
+};
+
+&mac2 {
+	status = "okay";
+	pinctrl-names = "default";
+	phy-mode = "rmii";
+	pinctrl-0 = <&pinctrl_rmii3_default>;
+	use-ncsi;
+};
+
+&mac3 {
+	status = "okay";
+
+	phy-mode = "rgmii";
+	phy-handle = <&ethphy0>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii4_default>;
+};
+
+&fmc {
+	status = "okay";
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bmc";
+		spi-max-frequency = <50000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+#include "openbmc-flash-layout.dtsi"
+	};
+
+	flash@1 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bmc2";
+		spi-max-frequency = <50000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+};
+
+&spi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1_default>;
+
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bios";
+		spi-max-frequency = <50000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+};
+
+
+&wdt1 {
+	status = "okay";
+};
+
+&vuart1 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&kcs3 {
+	aspeed,lpc-io-reg = <0xca2>;
+	status = "okay";
+};
+
+&uart_routing {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};
+&i2c1 {
+	status = "okay";
+};
+&i2c2 {
+	status = "okay";
+};
+&i2c3 {
+	status = "okay";
+};
+
+&i2c4 {
+	status = "okay";
+
+	// I2C EXPANDER
+	i2c-switch@71 {
+		compatible = "nxp,pca9546";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x71>;
+
+		i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			// AMD SB-TSI CPU1
+			sbtsi@4c {
+				compatible = "amd,sbtsi";
+				reg = <0x4c>;
+			};
+		};
+
+		i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			// AMD SB-TSI CPU2
+			sbtsi@48 {
+				compatible = "amd,sbtsi";
+				reg = <0x48>;
+			};
+		};
+	};
+};
+
+&i2c5 {
+	status = "okay";
+
+	// I2C EXPANDER U153
+	i2c-switch@70 {
+		compatible = "nxp,pca9546";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x70>;
+
+		usb_hub: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			// USB U114
+			usb-hub@2c {
+				compatible = "microchip,usb2514b";
+				reg = <0x2c>;
+			};
+		};
+
+		riser1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		riser2: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+};
+
+&i2c6 {
+	status = "okay";
+
+	// ADC_U74
+	adc_u74: adc@35 {
+		compatible = "maxim,max1139";
+		reg = <0x35>;
+		#io-channel-cells = <1>;
+	};
+
+	psu@58 {
+		compatible = "pmbus";
+		reg = <0x58>;
+	};
+
+	psu@5a {
+		compatible = "pmbus";
+		reg = <0x5a>;
+	};
+
+	// Motherboard Temp_U89
+	temperature-sensor@4e {
+		compatible = "ti,tmp421";
+		reg = <0x4e>;
+	};
+
+	// RunBMC Temp_U6
+	temperature-sensor@49 {
+		compatible = "ti,tmp75";
+		reg = <0x49>;
+	};
+};
+
+&i2c7 {
+	status = "okay";
+	// I2C EXPANDER U40
+	i2c-switch@70 {
+		compatible = "nxp,pca9545";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x70>;
+
+		i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+};
+
+
+&i2c8 {
+	status = "okay";
+	// FRU RunBMC
+	eeprom@51 {
+		compatible = "atmel,24c512";
+		reg = <0x51>;
+		pagesize = <128>;
+	};
+};
+
+&i2c9 {
+	status = "okay";
+};
+
+&i2c10 {
+	status = "okay";
+};
+
+&i2c11 {
+	status = "okay";
+};
+
+&i2c12 {
+	status = "okay";
+	// FRU SCM
+	eeprom@51 {
+		compatible = "atmel,24c512";
+		reg = <0x51>;
+		pagesize = <128>;
+	};
+
+	// SCM Temp_U17
+	temperature-sensor@4f {
+		compatible = "ti,tmp75";
+		reg = <0x4f>;
+	};
+};
+
+
+&gpio0 {
+	status = "okay";
+	gpio-line-names =
+	/*A0-A7*/   "","","","","","","","",
+	/*B0-B7*/   "alert-psu0-smb-r-n","bmc-ready","","assert-cpu0-prochot-r-n",
+	"","","","",
+	/*C0-C7*/   "","","","","","","","",
+	/*D0-D7*/   "","","","","","","","",
+	/*E0-E7*/   "","","","","","","","",
+	/*F0-F7*/   "","","","","reset-sgpio-r-n","","","",
+	/*G0-G7*/   "","","scm-jtag-mux-select","","","","","",
+	/*H0-H7*/   "","","","","reset-out","power-out","","",
+	/*I0-I7*/   "","","","","","","irq-bmc-cpu0-buf-nmi-n","",
+	/*J0-J7*/   "","","","","","","","",
+	/*K0-K7*/   "","","","","","","","",
+	/*L0-L7*/   "","","","","","","","",
+	/*M0-M7*/   "","","","","","","","",
+	/*N0-N7*/   "","","ncsi-ocp-clk-en-n","","","","","",
+	/*O0-O7*/   "","","","","","","cpu1-thermal-trip-n","",
+	/*P0-P7*/   "","","","","","","","",
+	/*Q0-Q7*/   "cpu0-prochot-n","","cpu1-prochot-n","","cpu0-pe-rst0","","","",
+	/*R0-R7*/   "","","","","","","","",
+	/*S0-S7*/   "","","","",
+	"","PCH_SLP_S4_BMC_N","cpu0-thermtrip-n","alert-psu1-smb-r-n",
+	/*T0-T7*/   "","","","","","","","",
+	/*U0-U7*/   "","","","","","","","",
+	/*V0-V7*/   "bios-recovery-buf-n","","assert-cpu1-prochot-r-n","",
+	"power-chassis-good","","","",
+	/*W0-W7*/   "","","","","","","","",
+	/*X0-X7*/   "","","","","platform-type","","","",
+	/*Y0-Y7*/   "","","","","","","","",
+	/*Z0-Z7*/   "","cpld-power-break-n","","","","","","",
+	/*AA0-AA7*/ "","","","","","","","",
+	/*AB0-AB7*/ "","","","","","","","",
+	/*AC0-AC7*/ "","","","","","","","";
+};
+
+&sgpiom0 {
+	status = "okay";
+	max-ngpios = <64>;
+	ngpios = <64>;
+	bus-frequency = <1000000>;
+	gpio-line-names =
+	/*in - out - in - out */
+	/*A0-A7*/   "","","","","","","","",
+	/*A0-A7*/   "","","","","","","","",
+	/*B0-B7*/   "","reset-cpu0-i2c-n","","reset-cpu1-i2c-n",
+	"","reset-i2c-bus7-n","","usb2514-1-reset-n",
+	/*B0-B7*/   "","bmc-cpu0-uart-en","","hdt-buff-en-n",
+	"","assert-clear-cmos","","hdt-mux-select-mon",
+	/*C0-C7*/   "led-identify","cpld-jtag-oe-r-n","cpu0-spd-host-ctrl-n","reset-cpld-hdt-n",
+	"","i3c-mux-select","","spi-mux-select",
+	/*C0-C7*/   "","","","","","","","",
+	/*D0-D7*/   "","","","","","","","",
+	/*D0-D7*/   "","","","","","","bios-post-complete-buf-n","",
+	/*E0-E7*/   "","","","","","","","",
+	/*E0-E7*/   "","","","","","","","",
+	/*F0-F7*/   "presence-fan0-n","","presence-fan1-n","",
+	"presence-fan2-n","","presence-fan3-n","",
+	/*F0-F7*/   "presence-fan4-n","","presence-fan5-n","",
+	"presence-cpu0-n","","presence-cpu1-n","",
+	/*G0-G7*/   "","","","","","","","",
+	/*G0-G7*/   "","","","","presence-psu0-cpld-n","","presence-psu1-cpld-n","",
+	/*H0-H7*/   "","","","","","","","",
+	/*H0-H7*/   "","","","","presence-riser0-n","","presence-riser1-n","";
+};
+
+
+&lpc_snoop {
+	status = "okay";
+	snoop-ports = <0x80>;
+};
+
+&emmc_controller {
+	status = "okay";
+};
+
+&emmc {
+	status = "okay";
+	non-removable;
+	max-frequency = <52000000>;
+	bus-width = <8>;
+};
+
+&video {
+	status = "okay";
+	memory-region = <&video_engine_memory>;
+};
+
+&vhub {
+	status = "okay";
+	aspeed,vhub-downstream-ports = <7>;
+	aspeed,vhub-generic-endpoints = <21>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb2ad_default>;
+};
+
+&rtc {
+	status = "okay";
+};
-- 
2.25.1

