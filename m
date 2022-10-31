Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0968613BB1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 17:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbiJaQrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 12:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbiJaQrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 12:47:36 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6270F1277D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 09:47:33 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id cl5so5159816wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 09:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vqtJ0U0dQHjak7CeAguxz3E+6JTNx3+rjvuNDtKIyWI=;
        b=hbo0X9UAYygih2LBF0g43pPCBDE/SOsn2aL2y6YhVQ0ifMlAVcKO/FA0kCiIGicPY0
         vfdXsnfq4OywaFGkU3YJD1dMdv9OXmEi5kbD1H1DMkWQQeqaRT22DKUitwI/xMGGw6o/
         bwxfn7jLnVliw8D9GFhY0aoyuHsBYe1ebq7bmDPxLBJOLRJzjsUBkCYb7Dat/peGtBFE
         jCoW8eC2+rG6g1CIKIlAwDHXNVfne57rkWR+3cVI5AxQSYdu3A1+P9/ELDXitVTCS4EQ
         DvyjOH/YUA3raxwzLynaCY4Nc9N3z/x63I67B3Jj9qTYZsETd9fw//IYAbAkEJXiFPtp
         72dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vqtJ0U0dQHjak7CeAguxz3E+6JTNx3+rjvuNDtKIyWI=;
        b=n1+nyMGKTpXbsY95zAGieynFywiGznDdHvs68x7igyZvYzh4kz8DsUcFwz61QgtJF3
         p19VFrO6bUns7lVyiTJPQyS3INtH3m9ZxGlwqrlYA1ZCp5vGsIQsU9dshATd88qTSMa1
         IHH3/upinoAv49idwtfVPXPu+ELks+F530VC4h4LUqhXUHvx9ho77IZBfzoW2yJ0k1hZ
         vqVuBHBMlOlW90PQPUWi2oVH7j9oDC34vsJwDjll36bExsN+DlrtSpNia6UE1n11RxN6
         9ywJpWQgVM04ybK4eczg8KA+UCTjjWf5xubi8IE6q83+TkxeDTMLrlj/8uM6OupvgH5L
         Y82Q==
X-Gm-Message-State: ACrzQf2RfRGW2Q7ijc7cApjo6GVv2z8t3En5WatCNsHrHHtI4lgjzTwN
        y2fTHTZT+Tqg7v2YlSfWLyi4qQ==
X-Google-Smtp-Source: AMsMyM7C9KEJl9MTrolh+YNUrz+y5v0hTKKQM6uz8A+wvOQ7BAPKMNAA7u/PBr2qnc3RWpdgV3B/bg==
X-Received: by 2002:a5d:54c2:0:b0:235:897d:38b7 with SMTP id x2-20020a5d54c2000000b00235897d38b7mr8696197wrv.604.1667234851873;
        Mon, 31 Oct 2022 09:47:31 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id q8-20020a05600c46c800b003b4868eb71bsm7488871wmo.25.2022.10.31.09.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 09:47:31 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 31 Oct 2022 17:47:28 +0100
Subject: [PATCH 4/4] arm64: dts: amlogic: add initial Odroid Go Ultra DTS
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <20221031-b4-odroid-go-ultra-initial-v1-4-42e3dbea86d5@linaro.org>
References: <20221031-b4-odroid-go-ultra-initial-v1-0-42e3dbea86d5@linaro.org>
In-Reply-To: <20221031-b4-odroid-go-ultra-initial-v1-0-42e3dbea86d5@linaro.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds initial support for the Hardkernel Odroid Go Ultra.

The Odroid Go Ultra is a portable gaming device with the following
characteristics:
- Amlogic S922X SoC
- RK817 & RK818 PMICs
- 2GiB LPDDR4
- On board 16GiB eMMC
- Micro SD Card slot
- 5inch 854×480 MIPI-DSI TFT LCD
- Earphone stereo jack, 0.5Watt 8Ω Mono speaker
- Li-Polymer 3.7V/4000mAh Battery
- USB-A 2.0 Host Connector
- x16 GPIO Input Buttons
- 2x ADC Analog Joysticks
- USB-C Port for USB2 Device and Charging

The following are not yet handled:
- Battery RK818 Gauge and Charging
- Earphone stereo jack detect
- 5inch 854×480 MIPI-DSI TFT LCD

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/amlogic/Makefile               |   1 +
 .../dts/amlogic/meson-g12b-odroid-go-ultra.dts     | 730 +++++++++++++++++++++
 2 files changed, 731 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index e213aeebb774..97b42e2100e0 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -12,6 +12,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-g12b-a311d-khadas-vim3.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gsking-x.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gtking-pro.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gtking.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-go-ultra.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-n2-plus.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-n2.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-s922x-khadas-vim3.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts
new file mode 100644
index 000000000000..3bda11b37d5e
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts
@@ -0,0 +1,730 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2022 Neil Armstrong <neil.armstrong@linaro.org>
+ */
+
+/dts-v1/;
+
+#include "meson-g12b-s922x.dtsi"
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/gpio/meson-g12a-gpio.h>
+#include <dt-bindings/sound/meson-g12a-toacodec.h>
+#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
+
+/ {
+	compatible = "hardkernel,odroid-go-ultra", "amlogic,s922x", "amlogic,g12b";
+	model = "Hardkernel ODROID-GO-Ultra";
+
+	aliases {
+		serial0 = &uart_AO;
+		rtc0 = &vrtc;
+	};
+
+	adc-joystick-left {
+		compatible = "adc-joystick";
+		io-channels = <&saradc 2>, <&saradc 3>;
+		poll-interval = <10>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		axis@0 {
+			reg = <0>;
+			linux,code = <ABS_Y>;
+			abs-range = <3150 950>;
+			abs-fuzz = <32>;
+			abs-flat = <64>;
+		};
+		axis@1 {
+			reg = <1>;
+			linux,code = <ABS_X>;
+			abs-range = <700 2900>;
+			abs-fuzz = <32>;
+			abs-flat = <64>;
+		};
+	};
+
+	adc-joystick-right {
+		compatible = "adc-joystick";
+		io-channels = <&saradc 0>, <&saradc 1>;
+		poll-interval = <10>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		axis@0 {
+			reg = <0>;
+			linux,code = <ABS_RY>;
+			abs-range = <3150 950>;
+			abs-fuzz = <32>;
+			abs-flat = <64>;
+		};
+		axis@1 {
+			reg = <1>;
+			linux,code = <ABS_RX>;
+			abs-range = <800 3000>;
+			abs-fuzz = <32>;
+			abs-flat = <64>;
+		};
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	codec_clk: codec-clk {
+		compatible = "fixed-clock";
+		clock-frequency = <12288000>;
+		clock-output-names = "codec_clk";
+		#clock-cells = <0>;
+	};
+
+	gpio-keys-polled {
+		compatible = "gpio-keys-polled";
+		poll-interval = <10>;
+		pinctrl-0 = <&keypad_gpio_pins>;
+		pinctrl-names = "default";
+
+		volume-up-button {
+			label = "VOLUME-UP";
+			linux,code = <KEY_VOLUMEUP>;
+			gpios = <&gpio GPIOX_8 GPIO_ACTIVE_LOW>;
+		};
+		volume-down-button {
+			label = "VOLUME-DOWN";
+			linux,code = <KEY_VOLUMEDOWN>;
+			gpios = <&gpio GPIOX_9 GPIO_ACTIVE_LOW>;
+		};
+		dpad-up-button {
+			label = "DPAD-UP";
+			linux,code = <BTN_DPAD_UP>;
+			gpios = <&gpio GPIOX_0 GPIO_ACTIVE_LOW>;
+		};
+		dpad-down-button {
+			label = "DPAD-DOWN";
+			linux,code = <BTN_DPAD_DOWN>;
+			gpios = <&gpio GPIOX_1 GPIO_ACTIVE_LOW>;
+		};
+		dpad-left-button {
+			label = "DPAD-LEFT";
+			linux,code = <BTN_DPAD_LEFT>;
+			gpios = <&gpio GPIOX_2 GPIO_ACTIVE_LOW>;
+		};
+		dpad-right-button {
+			label = "DPAD-RIGHT";
+			linux,code = <BTN_DPAD_RIGHT>;
+			gpios = <&gpio GPIOX_3 GPIO_ACTIVE_LOW>;
+		};
+		a-button {
+			label = "A";
+			linux,code = <BTN_EAST>;
+			gpios = <&gpio GPIOX_4 GPIO_ACTIVE_LOW>;
+		};
+		b-button {
+			label = "B";
+			linux,code = <BTN_SOUTH>;
+			gpios = <&gpio GPIOX_5 GPIO_ACTIVE_LOW>;
+		};
+		y-button {
+			label = "Y";
+			linux,code = <BTN_WEST>;
+			gpios = <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
+		};
+		x-button {
+			label = "X";
+			linux,code = <BTN_NORTH>;
+			gpios = <&gpio GPIOX_7 GPIO_ACTIVE_LOW>;
+		};
+		f1-button {
+			label = "F1";
+			linux,code = <BTN_TRIGGER_HAPPY1>;
+			gpios = <&gpio GPIOX_17 GPIO_ACTIVE_LOW>;
+		};
+		f2-button {
+			label = "F2";
+			linux,code = <BTN_TRIGGER_HAPPY2>;
+			gpios = <&gpio GPIOX_10 GPIO_ACTIVE_LOW>;
+		};
+		f3-button {
+			label = "F3";
+			linux,code = <BTN_TRIGGER_HAPPY3>;
+			gpios = <&gpio GPIOX_11 GPIO_ACTIVE_LOW>;
+		};
+		f4-button {
+			label = "F4";
+			linux,code = <BTN_TRIGGER_HAPPY4>;
+			gpios = <&gpio GPIOX_12 GPIO_ACTIVE_LOW>;
+		};
+		f5-button {
+			label = "F5";
+			linux,code = <BTN_TRIGGER_HAPPY5>;
+			gpios = <&gpio GPIOX_13 GPIO_ACTIVE_LOW>;
+		};
+		f6-button {
+			label = "F6";
+			linux,code = <BTN_TRIGGER_HAPPY6>;
+			gpios = <&gpio GPIOX_16 GPIO_ACTIVE_LOW>;
+		};
+		top-left-button {
+			label = "TOP Left";
+			linux,code = <BTN_TL>;
+			gpios = <&gpio GPIOX_14 GPIO_ACTIVE_LOW>;
+		};
+		top-left2-button {
+			label = "TOP Left 2";
+			linux,code = <BTN_TL2>;
+			gpios = <&gpio GPIOX_19 GPIO_ACTIVE_LOW>;
+		};
+		top-right-button {
+			label = "TOP Right";
+			linux,code = <BTN_TR>;
+			gpios = <&gpio GPIOX_15 GPIO_ACTIVE_LOW>;
+		};
+		top-right2-button {
+			label = "TOP Right 2";
+			linux,code = <BTN_TR2>;
+			gpios = <&gpio GPIOX_18 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x40000000>;
+	};
+
+	emmc_pwrseq: emmc-pwrseq {
+		compatible = "mmc-pwrseq-emmc";
+		reset-gpios = <&gpio BOOT_12 GPIO_ACTIVE_LOW>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-blue {
+			color = <LED_COLOR_ID_BLUE>;
+			gpios = <&gpio_ao GPIOAO_11 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	poweroff {
+		compatible = "hardkernel,odroid-go-ultra-poweroff";
+		hardkernel,rk817-pmic = <&rk817>;
+		hardkernel,rk818-pmic = <&rk818>;
+	};
+
+	vdd_sys: regulator-vdd_sys {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD_SYS";
+		regulator-min-microvolt = <3800000>;
+		regulator-max-microvolt = <3800000>;
+		regulator-always-on;
+	};
+
+	sound {
+		compatible = "amlogic,axg-sound-card";
+		model = "Odroid GO Ultra";
+		audio-widgets = "Microphone", "Mic Jack",
+				"Headphone", "Headphones",
+				"Speaker", "Internal Speakers";
+		audio-aux-devs = <&tdmout_b>, <&tdmin_b>, <&speaker_amp>;
+		audio-routing =	"TDMOUT_B IN 0", "FRDDR_A OUT 1",
+				"TDM_B Playback", "TDMOUT_B OUT",
+				"TDMIN_B IN 1", "TDM_B Capture",
+				"TDMIN_B IN 4", "TDM_B Loopback",
+				"TODDR_A IN 1", "TDMIN_B OUT",
+				"MICL", "Mic Jack",
+				"Headphones", "HPOL",
+				"Headphones", "HPOR",
+				"Speaker Amplifier INL", "HPOL",
+				"Speaker Amplifier INR", "HPOR",
+				"Internal Speakers", "Speaker Amplifier OUTL",
+				"Internal Speakers", "Speaker Amplifier OUTR";
+
+		assigned-clocks = <&clkc CLKID_MPLL2>,
+				  <&clkc CLKID_MPLL0>,
+				  <&clkc CLKID_MPLL1>;
+		assigned-clock-parents = <0>, <0>, <0>;
+		assigned-clock-rates = <294912000>,
+				       <270950400>,
+				       <393216000>;
+		status = "okay";
+
+		dai-link-0 {
+			sound-dai = <&frddr_a>;
+		};
+
+		dai-link-1 {
+			sound-dai = <&toddr_a>;
+		};
+
+		dai-link-2 {
+			sound-dai = <&tdmif_b>;
+			dai-format = "i2s";
+			dai-tdm-slot-tx-mask-0 = <1 1>;
+			mclk-fs = <256>;
+
+			codec-0 {
+				sound-dai = <&rk817>;
+			};
+		};
+	};
+
+	speaker_amp: speaker-amplifier {
+		compatible = "simple-audio-amplifier";
+		sound-name-prefix = "Speaker Amplifier";
+		VCC-supply = <&hp_5v>;
+	};
+};
+
+&arb {
+	status = "okay";
+};
+
+&cpu0 {
+	cpu-supply = <&vddcpu_b>;
+	operating-points-v2 = <&cpu_opp_table_0>;
+	clocks = <&clkc CLKID_CPU_CLK>;
+	clock-latency = <50000>;
+};
+
+&cpu1 {
+	cpu-supply = <&vddcpu_b>;
+	operating-points-v2 = <&cpu_opp_table_0>;
+	clocks = <&clkc CLKID_CPU_CLK>;
+	clock-latency = <50000>;
+};
+
+&cpu100 {
+	cpu-supply = <&vddcpu_a>;
+	operating-points-v2 = <&cpub_opp_table_1>;
+	clocks = <&clkc CLKID_CPUB_CLK>;
+	clock-latency = <50000>;
+};
+
+&cpu101 {
+	cpu-supply = <&vddcpu_a>;
+	operating-points-v2 = <&cpub_opp_table_1>;
+	clocks = <&clkc CLKID_CPUB_CLK>;
+	clock-latency = <50000>;
+};
+
+&cpu102 {
+	cpu-supply = <&vddcpu_a>;
+	operating-points-v2 = <&cpub_opp_table_1>;
+	clocks = <&clkc CLKID_CPUB_CLK>;
+	clock-latency = <50000>;
+};
+
+&cpu103 {
+	cpu-supply = <&vddcpu_a>;
+	operating-points-v2 = <&cpub_opp_table_1>;
+	clocks = <&clkc CLKID_CPUB_CLK>;
+	clock-latency = <50000>;
+};
+
+/* RK817 only supports 12.5mV steps, round up the values */
+&cpu_opp_table_0 {
+	opp-1000000000 {
+		opp-microvolt = <737500>;
+	};
+	opp-1200000000 {
+		opp-microvolt = <737500>;
+	};
+	opp-1398000000 {
+		opp-microvolt = <762500>;
+	};
+	opp-1512000000 {
+		opp-microvolt = <800000>;
+	};
+	opp-1608000000 {
+		opp-microvolt = <837500>;
+	};
+	opp-1704000000 {
+		opp-microvolt = <862500>;
+	};
+	opp-1896000000 {
+		opp-microvolt = <987500>;
+	};
+	opp-1992000000 {
+		opp-microvolt = <1012500>;
+	};
+};
+
+/* RK818 only supports 12.5mV steps, round up the values */
+&cpub_opp_table_1 {
+	opp-1000000000 {
+		opp-microvolt = <775000>;
+	};
+	opp-1200000000 {
+		opp-microvolt = <775000>;
+	};
+	opp-1398000000 {
+		opp-microvolt = <800000>;
+	};
+	opp-1512000000 {
+		opp-microvolt = <825000>;
+	};
+	opp-1608000000 {
+		opp-microvolt = <862500>;
+	};
+	opp-1704000000 {
+		opp-microvolt = <900000>;
+	};
+	opp-1800000000 {
+		opp-microvolt = <987500>;
+	};
+	opp-1908000000 {
+		opp-microvolt = <1025000>;
+	};
+};
+
+&i2c_AO {
+	status = "okay";
+	pinctrl-0 = <&i2c_ao_sck_pins>, <&i2c_ao_sda_pins>;
+	pinctrl-names = "default";
+
+	rk818: pmic@1c {
+		compatible = "rockchip,rk818";
+		reg = <0x1c>;
+		interrupt-parent = <&gpio_intc>;
+		interrupts = <7 IRQ_TYPE_LEVEL_LOW>; /* GPIOAO_7 */
+
+		vcc1-supply = <&vdd_sys>;
+		vcc2-supply = <&vdd_sys>;
+		vcc3-supply = <&vdd_sys>;
+		vcc4-supply = <&vdd_sys>;
+		vcc6-supply = <&vdd_sys>;
+		vcc7-supply = <&vcc_2v3>;
+		vcc8-supply = <&vcc_2v3>;
+		vcc9-supply = <&vddao_3v3>;
+		boost-supply = <&vdd_sys>;
+		switch-supply = <&vdd_sys>;
+
+		regulators {
+			vddcpu_a: DCDC_REG1 {
+				regulator-name = "vddcpu_a";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <775000>;
+				regulator-max-microvolt = <1025000>;
+				regulator-ramp-delay = <6001>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <775000>;
+				};
+			};
+
+			vdd_ee: DCDC_REG2 {
+				regulator-name = "vdd_ee";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <875000>;
+				regulator-max-microvolt = <1250000>;
+				regulator-ramp-delay = <6001>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <875000>;
+				};
+			};
+
+			vddq_1v1: DCDC_REG3 {
+				regulator-name = "vddq_1v1";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vddao_3v3: DCDC_REG4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vddao_3v3";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			hp_5v: DCDC_BOOST {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-name = "hp_5v";
+				regulator-min-microvolt = <5000000>;
+				regulator-max-microvolt = <5000000>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vddio_ao1v8: LDO_REG5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vddio_ao1v8";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vddq_1v8: LDO_REG7 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vddq_1v8";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vddio_c: LDO_REG9 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vddio_c";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vcc_sd: SWITCH_REG {
+				regulator-name = "vcc_sd";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			OTG_SWITCH {
+				regulator-name = "otg_switch";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+		};
+	};
+};
+
+&i2c3 {
+	status = "okay";
+	pinctrl-0 = <&i2c3_sda_a_pins>, <&i2c3_sck_a_pins>;
+	pinctrl-names = "default";
+
+	rk817: pmic@20 {
+		compatible = "rockchip,rk817";
+		reg = <0x20>;
+		status = "okay";
+		interrupt-parent = <&gpio_intc>;
+
+		interrupts = <5 IRQ_TYPE_LEVEL_LOW>; /* GPIOAO_5 */
+
+		vcc1-supply = <&vdd_sys>;
+		vcc2-supply = <&vdd_sys>;
+		vcc3-supply = <&vdd_sys>;
+		vcc4-supply = <&vdd_sys>;
+		vcc5-supply = <&vdd_sys>;
+		vcc6-supply = <&vdd_sys>;
+		vcc7-supply = <&vdd_sys>;
+		vcc8-supply = <&vdd_sys>;
+		vcc9-supply = <&rk817_boost>;
+
+		#sound-dai-cells = <0>;
+		clocks = <&codec_clk>;
+		clock-names = "mclk";
+
+		#clock-cells = <1>;
+
+		regulators {
+			vddcpu_b: DCDC_REG2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <737500>;
+				regulator-max-microvolt = <1012500>;
+				regulator-ramp-delay = <6001>;
+				regulator-initial-mode = <0x2>;
+				regulator-name = "vddcpu_b";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1000000>;
+				};
+			};
+
+			vcc_2v3: DCDC_REG3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <2300000>;
+				regulator-max-microvolt = <2400000>;
+				regulator-initial-mode = <0x2>;
+				regulator-name = "vcc_2v3";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			LDO_REG4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vdd_codec";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_lcd: LDO_REG8 {
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc_lcd";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			rk817_boost: BOOST {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <5000000>;
+				regulator-max-microvolt = <5400000>;
+				regulator-name = "rk817_boost";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			usb_host: OTG_SWITCH {
+				regulator-name = "usb_host";
+				regulator-min-microvolt = <5000000>;
+				regulator-max-microvolt = <5000000>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+		};
+	};
+};
+
+&clkc_audio {
+	status = "okay";
+};
+
+&eth_phy {
+	status = "disabled";
+};
+
+&frddr_a {
+	status = "okay";
+};
+
+&periphs_pinctrl {
+	keypad_gpio_pins: keypad-gpio {
+		mux {
+			groups = "GPIOX_0", "GPIOX_1", "GPIOX_2", "GPIOX_3",
+			         "GPIOX_4", "GPIOX_5", "GPIOX_6", "GPIOX_7",
+				 "GPIOX_8", "GPIOX_9", "GPIOX_10", "GPIOX_11",
+				 "GPIOX_12", "GPIOX_13", "GPIOX_14",  "GPIOX_15",
+				 "GPIOX_16", "GPIOX_17", "GPIOX_18",  "GPIOX_19";
+			function = "gpio_periphs";
+			bias-pull-up;
+			output-disable;
+		};
+	};
+};
+
+&saradc {
+	status = "okay";
+	vref-supply = <&vddio_ao1v8>;
+};
+
+/* SD card */
+&sd_emmc_b {
+	status = "okay";
+	pinctrl-0 = <&sdcard_c_pins>;
+	pinctrl-1 = <&sdcard_clk_gate_c_pins>;
+	pinctrl-names = "default", "clk-gate";
+
+	bus-width = <4>;
+	cap-sd-highspeed;
+	max-frequency = <50000000>;
+	disable-wp;
+
+	cd-gpios = <&gpio GPIOC_6 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&vcc_sd>;
+	vqmmc-supply = <&vddio_c>;
+
+};
+
+/* eMMC */
+&sd_emmc_c {
+	status = "okay";
+	pinctrl-0 = <&emmc_ctrl_pins>, <&emmc_data_8b_pins>, <&emmc_ds_pins>;
+	pinctrl-1 = <&emmc_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
+
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	max-frequency = <200000000>;
+	disable-wp;
+
+	mmc-pwrseq = <&emmc_pwrseq>;
+	vmmc-supply = <&vcc_sd>;
+	vqmmc-supply = <&vddio_ao1v8>;
+};
+
+
+&tdmif_b {
+	pinctrl-0 = <&tdm_b_dout0_pins>, <&tdm_b_fs_pins>, <&tdm_b_sclk_pins>, <&tdm_b_din1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	assigned-clocks = <&clkc_audio AUD_CLKID_TDM_SCLK_PAD1>,
+			  <&clkc_audio AUD_CLKID_TDM_LRCLK_PAD1>;
+	assigned-clock-parents = <&clkc_audio AUD_CLKID_MST_B_SCLK>,
+				 <&clkc_audio AUD_CLKID_MST_B_LRCLK>;
+	assigned-clock-rates = <0>, <0>;
+};
+
+&tdmin_b {
+	status = "okay";
+};
+
+&tdmout_b {
+	status = "okay";
+};
+
+&toddr_a {
+	status = "okay";
+};
+
+&uart_AO {
+	status = "okay";
+	pinctrl-0 = <&uart_ao_a_pins>;
+	pinctrl-names = "default";
+};
+
+&usb {
+	status = "okay";
+	dr_mode = "peripheral";
+};
+
+&usb2_phy0 {
+	status = "okay";
+};
+
+&usb2_phy1 {
+	status = "okay";
+	phy-supply = <&usb_host>;
+};

-- 
b4 0.10.1
