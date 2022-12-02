Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE86640205
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 09:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbiLBIUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 03:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbiLBITK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 03:19:10 -0500
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AD3CE1A;
        Fri,  2 Dec 2022 00:18:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1669969105; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=FpQaqfHYP5GHGr5ts8bcTnxrbeeev/iddGX/Q72Ehs+T1pfW+WDYQ1rrBklV/hGw2zziPdIffiPjHA+AVxj8FyWOZeffrv8IB9UQOfnCcWatYFSYyTrMrlkLSTVmx6Wi2Dvp7PsIfyUWviTPwgiFVdw4v74Aj19ICeZTYPPYrJY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1669969105; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=8ECuMZawpjSVHvQjUBetfP6Pc3GP52JI3GjpdBPc0V4=; 
        b=fNbTMSSWh2qSdwgYnXccsZb+q1h90pgpDE5dGVo/EEhCXLe3hwtZ6Q6IRheI/FTp04Il1yWqIb/4dH8AA6moFS0cde2mOPpmZEJ+/ESj9FJMYpfgVlozJsBD8nVMYeWVwCuWE7WV7U2y9LOU7jE2XqoBWRo373vv/W+g+ThBjmw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1669969105;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=8ECuMZawpjSVHvQjUBetfP6Pc3GP52JI3GjpdBPc0V4=;
        b=Wss7KYQO6OjtvcTvd+BhmqDFiS08z2Yspp2Gf0eegLlx9Z9AVtRg6qXMhpoVAA48
        QvvLrvLi+DHOGlU3omcKAMiENjyToeggHAbpSvc88ID3lJA5YOYGC3d1DSCLOdMc9hN
        0ZoyAd7hFQuOiZTASAlEVUp06OI2sJFOxiZXGlmk=
Received: from edelgard.fodlan.icenowy.me (120.85.99.229 [120.85.99.229]) by mx.zohomail.com
        with SMTPS id 1669969103150602.338938716538; Fri, 2 Dec 2022 00:18:23 -0800 (PST)
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH v2 6/6] arm64: dts: allwinner: h6: add Rongpin RP-H6C SoM and RP-H6B board
Date:   Fri,  2 Dec 2022 16:16:47 +0800
Message-Id: <20221202081647.3183870-7-uwu@icenowy.me>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221202081647.3183870-1-uwu@icenowy.me>
References: <20221202081647.3183870-1-uwu@icenowy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rongpin RP-H6C is an Allwinner H6 SoM by Rongpin, with Allwinner H6 SoC,
AXP805 PMIC, LPDDR3 memory and eMMC storage on it.

RP-H6B is their official evaluation board of RP-H6C, with an onboard
GL850G USB hub, Ampak AP6212 Wi-Fi module and some circuits about LVDS
display. It also exports the OTG USB port, the USB 3.0 port, PCIe bus
(as mPCIe slot), internal Ethernet PHY, analog audio/video and HDMI
port.

Add a DTSI file for the SoM and a DTS for the full board.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
Changes in v2:
- Name all regulator nodes regulator-xxx.
- Fixed underscores in node names.

 arch/arm64/boot/dts/allwinner/Makefile        |   1 +
 .../boot/dts/allwinner/sun50i-h6-rp-h6b.dts   | 239 ++++++++++++++++++
 .../boot/dts/allwinner/sun50i-h6-rp-h6c.dtsi  | 180 +++++++++++++
 3 files changed, 420 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-rp-h6b.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-rp-h6c.dtsi

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index 6a96494a2e0a..e289fedcac29 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -36,6 +36,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-lite2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-one-plus.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-model-b.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-rp-h6b.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6-mini.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-orangepi-zero2.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-rp-h6b.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-rp-h6b.dts
new file mode 100644
index 000000000000..d9994e9beb81
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-rp-h6b.dts
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+/*
+ * Copyright (C) 2022 Icenowy Zheng <icenowy@aosc.io>
+ */
+/dts-v1/;
+
+#include "sun50i-h6-rp-h6c.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "Rongpin RP-H6B baseboard";
+	compatible = "rongpin,rp-h6b", "rongpin,rp-h6c",
+		     "allwinner,sun50i-h6";
+
+	aliases {
+		ethernet0 = &emac;
+		serial0 = &uart0;
+		/*
+		 * Prioritize the external RTC because it's powered
+		 * by a cell battery.
+		 */
+		rtc0 = &hym8563;
+		rtc1 = &rtc;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	hdmi_connector: connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led {
+			label = "rongpin:red:link";
+			gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>; /* PL3 */
+			/*
+			 * On the schematics this LED is marked as "lit when
+			 * powering on and blinking when running".
+			 */
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	/*
+	 * The VDD_5V power rail is connected to the internal regulator
+	 * of GL850G, to power up the 3.3V core of it.
+	 */
+	reg_v33_hub: regulator-v33-hub {
+		compatible = "regulator-fixed";
+		regulator-name = "v33-hub";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&reg_vdd_5v>;
+	};
+
+	/*
+	 * This board inputs 5V to AP6212 via a SS34 diode. Use this
+	 * regulator as the model of the internal regulator of AP6212.
+	 */
+	reg_vcc3v3_ap6212: regulator-vcc3v3-ap6212 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3-ap6212";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&reg_ps>;
+	};
+
+	reg_vdd_5v: regulator-vdd-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd-5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		startup-delay-us = <100000>;
+		gpio = <&r_pio 0 5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply = <&reg_ps>;
+	};
+
+	/* For mPCIe slot WWAN modules / PCIe cards */
+	reg_vdd_3g: regulator-vdd-3g {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd-3g";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <100000>;
+		gpio = <&r_pio 0 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply = <&reg_ps>;
+		/*
+		 * As a hack for lacking of control of a hub downstream
+		 * port's Vbus.
+		 */
+		regulator-always-on;
+	};
+
+	wifi_pwrseq: wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&r_pio 1 3 GPIO_ACTIVE_LOW>; /* PM3 */
+		post-power-on-delay-ms = <200>;
+	};
+};
+
+&de {
+	status = "okay";
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci3 {
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	hub@1 {
+		/* Genesys Logic GL850G usb hub */
+		compatible = "usb5e3,608";
+		reg = <1>;
+		vdd-supply = <&reg_v33_hub>;
+		reset-gpios = <&pio 7 2 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&hdmi {
+	status = "okay";
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
+&i2c0 {
+	status = "okay";
+
+	hym8563: rtc@51 {
+		compatible = "haoyu,hym8563";
+		reg = <0x51>;
+		#clock-cells = <0>;
+	};
+};
+
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins>;
+	vmmc-supply = <&reg_cldo1>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+	vmmc-supply = <&reg_vcc3v3_ap6212>;
+	vqmmc-supply = <&reg_bldo3>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	non-removable;
+	bus-width = <4>;
+	status = "okay";
+
+	brcmf: wifi@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+		interrupt-parent = <&r_pio>;
+		interrupts = <1 0 IRQ_TYPE_LEVEL_LOW>; /* PM0 */
+		interrupt-names = "host-wake";
+	};
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+/* Converted from 12v with a fixed DC-DC on the baseboard */
+&reg_ps {
+	regulator-min-microvolt = <5000000>;
+	regulator-max-microvolt = <5000000>;
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_ph_pins>;
+	status = "okay";
+};
+
+/* Bluetooth */
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		max-speed = <1500000>;
+		clocks = <&rtc CLK_OSC32K_FANOUT>;
+		clock-names = "lpo";
+		vbat-supply = <&reg_ps>;
+		vddio-supply = <&reg_bldo3>;
+		device-wakeup-gpios = <&r_pio 1 2 GPIO_ACTIVE_HIGH>; /* PM2 */
+		shutdown-gpios = <&r_pio 1 4 GPIO_ACTIVE_HIGH>; /* PM4 */
+		interrupt-parent = <&r_pio>;
+		interrupts = <1 1 IRQ_TYPE_EDGE_FALLING>; /* PM1 */
+		interrupt-names = "host-wakeup";
+	};
+};
+
+&uart1_pins {
+	bias-pull-up;
+};
+
+&uart1_rts_cts_pins {
+	bias-pull-up;
+};
+
+&usb2otg {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usb2phy {
+	usb0_vbus-supply = <&reg_vdd_5v>;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-rp-h6c.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-rp-h6c.dtsi
new file mode 100644
index 000000000000..637c194016c4
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-rp-h6c.dtsi
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+/*
+ * Copyright (C) 2019-2022 Icenowy Zheng <icenowy@aosc.io>
+ */
+
+#include "sun50i-h6.dtsi"
+#include "sun50i-h6-cpu-opp.dtsi"
+#include "sun50i-h6-gpu-opp.dtsi"
+
+/ {
+	ext_osc32k: ext-osc32k-clk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+		clock-output-names = "ext_osc32k";
+	};
+
+	/* Marked 3.4v~5.5v on SoM schematics */
+	reg_ps: regulator-ps {
+		compatible = "regulator-fixed";
+		regulator-name = "ps";
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&reg_dcdca>;
+};
+
+&gpu {
+	mali-supply = <&reg_dcdcc>;
+	status = "okay";
+};
+
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_pins>;
+	vmmc-supply = <&reg_cldo1>;
+	vqmmc-supply = <&reg_bldo2>;
+	non-removable;
+	cap-mmc-hw-reset;
+	bus-width = <8>;
+	status = "okay";
+};
+
+&pio {
+	vcc-pc-supply = <&reg_bldo2>;
+	vcc-pd-supply = <&reg_aldo2>;
+	vcc-pg-supply = <&reg_bldo3>;
+};
+
+&r_pio {
+	/*
+	 * FIXME: We can't add that supply for now since it would
+	 * create a circular dependency between pinctrl, the regulator
+	 * and the RSB Bus.
+	 *
+	 * vcc-pl-supply = <&reg_aldo1>;
+	 */
+	vcc-pm-supply = <&reg_bldo3>;
+};
+
+&r_rsb {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	axp805: pmic@745 {
+		compatible = "x-powers,axp805", "x-powers,axp806";
+		reg = <0x745>;
+		interrupt-parent = <&r_intc>;
+		interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		x-powers,self-working-mode;
+		vina-supply = <&reg_ps>;
+		vinb-supply = <&reg_ps>;
+		vinc-supply = <&reg_ps>;
+		vind-supply = <&reg_ps>;
+		vine-supply = <&reg_ps>;
+		aldoin-supply = <&reg_ps>;
+		bldoin-supply = <&reg_ps>;
+		cldoin-supply = <&reg_ps>;
+
+		regulators {
+			reg_aldo1: aldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc-pl";
+			};
+
+			reg_aldo2: aldo2 {
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc-ac200";
+				regulator-enable-ramp-delay = <100000>;
+			};
+
+			aldo3 {
+				/* unused */
+			};
+
+			reg_bldo1: bldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc-bias-pll";
+			};
+
+			reg_bldo2: bldo2 {
+				regulator-always-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc-efuse-pcie-hdmi-io";
+			};
+
+			reg_bldo3: bldo3 {
+				regulator-always-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc-dcxoio";
+			};
+
+			bldo4 {
+				/* unused */
+			};
+
+			reg_cldo1: cldo1 {
+				/* This regulator is connected with ALDO3 */
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc-3v3-2";
+			};
+
+			cldo2 {
+				/* unused */
+			};
+
+			cldo3 {
+				/* unused */
+			};
+
+			reg_dcdca: dcdca {
+				regulator-always-on;
+				regulator-min-microvolt = <810000>;
+				regulator-max-microvolt = <1160000>;
+				regulator-ramp-delay = <2500>;
+				regulator-name = "vdd-cpu";
+			};
+
+			reg_dcdcc: dcdcc {
+				regulator-min-microvolt = <810000>;
+				regulator-max-microvolt = <1080000>;
+				regulator-name = "vdd-gpu";
+			};
+
+			reg_dcdcd: dcdcd {
+				regulator-always-on;
+				regulator-min-microvolt = <960000>;
+				regulator-max-microvolt = <960000>;
+				regulator-name = "vdd-sys";
+			};
+
+			reg_dcdce: dcdce {
+				regulator-always-on;
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-name = "vcc-dram";
+			};
+
+			sw {
+				/* unused */
+			};
+		};
+	};
+};
+
+&rtc {
+	clocks = <&ext_osc32k>;
+};
-- 
2.38.1

