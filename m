Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15C9646B5E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 10:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiLHJEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 04:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiLHJDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 04:03:40 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3939E45090;
        Thu,  8 Dec 2022 01:03:17 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 3416332002E2;
        Thu,  8 Dec 2022 04:03:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 08 Dec 2022 04:03:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1670490194; x=1670576594; bh=L0
        3R5UOqdFsXF7bNKaU0GuQgsHYbRrJLIpv1mwem1Ns=; b=t5lvVBdKqgIUN72wGl
        dlO+Nbo3dQfjwjhd6uVyjtxB2PkQybLzFa+j8cCCu5WJE3BDyn9Ws4r6I7Ek3+hf
        oWUMAP+uNaixFDQ8eXbhtSVuHgJWSMgifH0oZxHeqqeIeJLMFWCC25j6LF0KPy3a
        7HfxX8mzQ0arxVu7gFNv2Mr+TG6kuv7MnoqTCtsFrDamOs1KLUuZUTcdDW+8Ygqb
        oNVLrkooyzzZjj7YDrr02iQK103pf5whfvOCz6lIllJ8HC0icm1fqdCCuTOSt1ZQ
        W2bkGEVgNAbEeyPXDwPhy0eWAPa6Wn3RBY8okNo294TF54Y4f0vvRjGSY2XQlWFL
        fQ+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1670490194; x=1670576594; bh=L03R5UOqdFsXF
        7bNKaU0GuQgsHYbRrJLIpv1mwem1Ns=; b=nXUDB4YoDIZbhjOVIdHB0UGNvKuQr
        lzAjCkW6HDQ/aQKOUwSTlpbbe/vp/+fAwMesK0bFVqAFHQXuK18ga2N6UaGJYkPF
        LDwJTiyy6835C+LxFUtNMEOvX4V3+oGYg0JWNw6ECfkVt3IKIcJBfAEdklnEvAMm
        ZLT4cbnM/6hwugoSJg69L6x6kxs7d50d4MPtiy2LJ2kRBAGaqTAN6/YzLP6iXKLo
        0OztoEQf+g3AfSBQgG9LOuxWwhyvpSRgkcIvIw8q7h+CH1+FPfszyQ1vHcKVBzGH
        5qnI9CFwYTVsJrYYpqAmEPsegClDxzP0siE0XtVP6rC2pRlU6yuAZ1ZgA==
X-ME-Sender: <xms:UqiRY8ZJYQO5UZsorBjvK7b4-u57wEcmpBrEmWpszuVqal1__BZtsw>
    <xme:UqiRY3ZpMtdA7QR7fgcXVpDPFXO6n8TbQlTQ8VZMGbb5HLePDyiUiqLtVE6hxwT_g
    8R4QF330GxOWo0HZw>
X-ME-Received: <xmr:UqiRY29DX28scN6yElGWKB4j1YmECjci2hiZN9ocKHM-8p3hZz9g2M1AYIQ3bcGB319hezLLVKGJ3yaiqmwdt1dlgpAb8rLP7UBvX0BO7hH0zBE316vIWxQ9_G7rUhM6b_uqkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfj
    ohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrfgrth
    htvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefgudefiedt
    veetnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    grmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:UqiRY2rcXLMulAhRb4Ip5jhE1O0NO7-1qaV0QU0zpUF_iUb8K7WTSg>
    <xmx:UqiRY3rZjCaYxOncMmPHdWrShYkdxEpHEAAkIh1wuB2wz4NRMAMdlQ>
    <xmx:UqiRY0TRur57IeWzvN1Ekbkk7rapinH8kfcGydGX46jcnsACkGq7Sg>
    <xmx:UqiRYyD-n1pOms7Nq1SuwvBJKS3ML9LKgjor-OtLzB1fYByXqHlqHA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Dec 2022 04:03:13 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org
Cc:     Jisheng Zhang <jszhang@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        Andre Przywara <andre.przywara@arm.com>,
        Samuel Holland <samuel@sholland.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v3 10/12] riscv: dts: allwinner: Add ClockworkPi and DevTerm devicetrees
Date:   Thu,  8 Dec 2022 03:02:35 -0600
Message-Id: <20221208090237.20572-11-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221208090237.20572-1-samuel@sholland.org>
References: <20221208090237.20572-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clockwork Tech manufactures several SoMs for their RasPi CM3-compatible
"ClockworkPi" mainboard. Their R-01 SoM features the Allwinner D1 SoC.
The R-01 contains only the CPU, DRAM, and always-on voltage regulation;
it does not merit a separate devicetree.

The ClockworkPi mainboard features analog audio, a MIPI-DSI panel, USB
host and peripheral ports, an Ampak AP6256 WiFi/Bluetooth module, and an
X-Powers AXP228 PMIC for managing a Li-ion battery.

The DevTerm is a complete system which extends the ClockworkPi mainboard
with a MIPI-DSI panel and a pair of expansion boards. These expansion
boards provide a fan, a USB keyboard, speakers, and a thermal printer.

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v3:
 - Drop mmc alias

Changes in v2:
 - Added PMIC GPIO controller node (binding merged for 6.2)

 arch/riscv/boot/dts/allwinner/Makefile        |   2 +
 .../allwinner/sun20i-d1-clockworkpi-v3.14.dts | 252 ++++++++++++++++++
 .../dts/allwinner/sun20i-d1-devterm-v3.14.dts |  36 +++
 3 files changed, 290 insertions(+)
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-clockworkpi-v3.14.dts
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-devterm-v3.14.dts

diff --git a/arch/riscv/boot/dts/allwinner/Makefile b/arch/riscv/boot/dts/allwinner/Makefile
index 87f70b1af6b4..1c91be38ea16 100644
--- a/arch/riscv/boot/dts/allwinner/Makefile
+++ b/arch/riscv/boot/dts/allwinner/Makefile
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_SUNXI) += sun20i-d1-clockworkpi-v3.14.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun20i-d1-devterm-v3.14.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun20i-d1-dongshan-nezha-stu.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun20i-d1-lichee-rv-86-panel-480p.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun20i-d1-lichee-rv-86-panel-720p.dtb
diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1-clockworkpi-v3.14.dts b/arch/riscv/boot/dts/allwinner/sun20i-d1-clockworkpi-v3.14.dts
new file mode 100644
index 000000000000..750aec6cf2f2
--- /dev/null
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1-clockworkpi-v3.14.dts
@@ -0,0 +1,252 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// Copyright (C) 2022 Samuel Holland <samuel@sholland.org>
+
+#include <dt-bindings/gpio/gpio.h>
+
+/dts-v1/;
+
+#include "sun20i-d1.dtsi"
+#include "sun20i-common-regulators.dtsi"
+
+/ {
+	model = "ClockworkPi v3.14 (R-01)";
+	compatible = "clockwork,r-01-clockworkpi-v3.14", "allwinner,sun20i-d1";
+
+	aliases {
+		ethernet0 = &ap6256;
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	/*
+	 * This regulator is PWM-controlled, but the PWM controller is not
+	 * yet supported, so fix the regulator to its default voltage.
+	 */
+	reg_vdd_cpu: vdd-cpu {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd-cpu";
+		regulator-min-microvolt = <1100000>;
+		regulator-max-microvolt = <1100000>;
+		vin-supply = <&reg_vcc>;
+	};
+
+	wifi_pwrseq: wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&pio 6 11 GPIO_ACTIVE_LOW>; /* PG11/GPIO3 */
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&reg_vdd_cpu>;
+};
+
+&dcxo {
+	clock-frequency = <24000000>;
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&i2c0 {
+	pinctrl-0 = <&i2c0_pb10_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	axp221: pmic@34 {
+		compatible = "x-powers,axp228", "x-powers,axp221";
+		reg = <0x34>;
+		interrupt-parent = <&pio>;
+		interrupts = <4 9 IRQ_TYPE_LEVEL_LOW>; /* PE9/GPIO2 */
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		ac_power_supply: ac-power {
+			compatible = "x-powers,axp221-ac-power-supply";
+		};
+
+		axp_adc: adc {
+			compatible = "x-powers,axp221-adc";
+			#io-channel-cells = <1>;
+		};
+
+		battery_power_supply: battery-power {
+			compatible = "x-powers,axp221-battery-power-supply";
+		};
+
+		axp_gpio: gpio {
+			compatible = "x-powers,axp221-gpio";
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		regulators {
+			x-powers,dcdc-freq = <3000>;
+
+			reg_dcdc1: dcdc1 {
+				regulator-name = "sys-3v3";
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			reg_dcdc3: dcdc3 {
+				regulator-name = "sys-1v8";
+				regulator-always-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+			};
+
+			reg_aldo1: aldo1 {
+				regulator-name = "aud-3v3";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			reg_aldo2: aldo2 {
+				regulator-name = "disp-3v3";
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			reg_aldo3: aldo3 {
+				regulator-name = "vdd-wifi";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+			};
+
+			/* DLDO1 and ELDO1-3 are connected in parallel. */
+			reg_dldo1: dldo1 {
+				regulator-name = "vbat-wifi-a";
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			/* DLDO2-DLDO4 are connected in parallel. */
+			reg_dldo2: dldo2 {
+				regulator-name = "vcc-3v3-ext-a";
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			reg_dldo3: dldo3 {
+				regulator-name = "vcc-3v3-ext-b";
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			reg_dldo4: dldo4 {
+				regulator-name = "vcc-3v3-ext-c";
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			reg_eldo1: eldo1 {
+				regulator-name = "vbat-wifi-b";
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			reg_eldo2: eldo2 {
+				regulator-name = "vbat-wifi-c";
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			reg_eldo3: eldo3 {
+				regulator-name = "vbat-wifi-d";
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+			};
+		};
+
+		usb_power_supply: usb-power {
+			compatible = "x-powers,axp221-usb-power-supply";
+			status = "disabled";
+		};
+	};
+};
+
+&mmc0 {
+	broken-cd;
+	bus-width = <4>;
+	disable-wp;
+	vmmc-supply = <&reg_dcdc1>;
+	vqmmc-supply = <&reg_vcc_3v3>;
+	pinctrl-0 = <&mmc0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&mmc1 {
+	bus-width = <4>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	non-removable;
+	vmmc-supply = <&reg_dldo1>;
+	vqmmc-supply = <&reg_aldo3>;
+	pinctrl-0 = <&mmc1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	ap6256: wifi@1 {
+		compatible = "brcm,bcm43456-fmac", "brcm,bcm4329-fmac";
+		reg = <1>;
+		interrupt-parent = <&pio>;
+		interrupts = <6 10 IRQ_TYPE_LEVEL_LOW>; /* PG10/GPIO4 */
+		interrupt-names = "host-wake";
+	};
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&pio {
+	vcc-pg-supply = <&reg_ldoa>;
+};
+
+&uart0 {
+	pinctrl-0 = <&uart0_pb8_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&uart1 {
+	uart-has-rtscts;
+	pinctrl-0 = <&uart1_pg6_pins>, <&uart1_pg8_rts_cts_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm4345c5";
+		interrupt-parent = <&pio>;
+		interrupts = <6 17 IRQ_TYPE_LEVEL_HIGH>; /* PG17/GPIO6 */
+		device-wakeup-gpios = <&pio 6 16 GPIO_ACTIVE_HIGH>; /* PG16/GPIO7 */
+		shutdown-gpios = <&pio 6 18 GPIO_ACTIVE_HIGH>; /* PG18/GPIO5 */
+		max-speed = <1500000>;
+		vbat-supply = <&reg_dldo1>;
+		vddio-supply = <&reg_aldo3>;
+	};
+};
+
+&usb_otg {
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&usbphy {
+	usb0_vbus_power-supply = <&ac_power_supply>;
+	usb1_vbus-supply = <&reg_vcc>;
+	status = "okay";
+};
diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1-devterm-v3.14.dts b/arch/riscv/boot/dts/allwinner/sun20i-d1-devterm-v3.14.dts
new file mode 100644
index 000000000000..bc5c84f22762
--- /dev/null
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1-devterm-v3.14.dts
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// Copyright (C) 2022 Samuel Holland <samuel@sholland.org>
+
+#include "sun20i-d1-clockworkpi-v3.14.dts"
+
+/ {
+	model = "Clockwork DevTerm (R-01)";
+	compatible = "clockwork,r-01-devterm-v3.14",
+		     "clockwork,r-01-clockworkpi-v3.14",
+		     "allwinner,sun20i-d1";
+
+	fan {
+		compatible = "gpio-fan";
+		gpios = <&pio 3 10 GPIO_ACTIVE_HIGH>; /* PD10/GPIO41 */
+		gpio-fan,speed-map = <0    0>,
+				     <6000 1>;
+		#cooling-cells = <2>;
+	};
+
+	i2c-gpio-0 {
+		compatible = "i2c-gpio";
+		sda-gpios = <&pio 3 14 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>; /* PD14/GPIO44 */
+		scl-gpios = <&pio 3 15 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>; /* PD15/GPIO45 */
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		adc@54 {
+			compatible = "ti,adc101c";
+			reg = <0x54>;
+			interrupt-parent = <&pio>;
+			interrupts = <4 12 IRQ_TYPE_LEVEL_LOW>; /* PE12/GPIO35 */
+			vref-supply = <&reg_dldo2>;
+			#io-channel-cells = <1>;
+		};
+	};
+};
-- 
2.37.4

