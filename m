Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4CC660F7E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 15:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbjAGOUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 09:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbjAGOTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 09:19:32 -0500
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C6B4ECAC;
        Sat,  7 Jan 2023 06:19:26 -0800 (PST)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id CA0C6420D2;
        Sat,  7 Jan 2023 19:19:19 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1673101160; bh=wof4fgqPiEpvf5PTbXWjQ8PMVh6W5qvzhiX/kwadRNk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I8Fi+BJRwICcw84dwCz92ReFZYlkvBz33up9ZwBSJWZXJgjZjHgSeQnuIKUJXvrf6
         1p/y7CDLJzUYVHXl3xCRREu7Uw/MuYTebXfj1XlK35EsHzSr0B5yNZ0GDC1NOvoi6b
         AjqCrcj3ssA1b+Qv1fiEch5C6wahQ7zScQV3Jtu3mqDOoaJ4RukcNRELHkgY2dgXhm
         ghFG5Hf/My7Cxw1ldCaQYnp4a3/RD6XrZdpoRhpSpj9ejINHRWp3op+av0xrhCyN3c
         czYIu+e9ufgZfXVmIIzzyD4LYKBrrKTWRQb78sCJ2Iy2zwWv0Lt2b/SOTikgdQo9Kh
         QJ2X+JQKsHiDg==
From:   Nikita Travkin <nikita@trvn.ru>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Siddharth Manthan <siddharth.manthan@gmail.com>,
        Jasper Korten <jja2000@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Siddharth Manthan <siddharth_manthan@outlook.com>,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v3 2/3] arm64: dts: qcom: Add device tree for Samsung Galaxy Tab A 9.7 (2015)
Date:   Sat,  7 Jan 2023 19:19:10 +0500
Message-Id: <20230107141911.47229-3-nikita@trvn.ru>
In-Reply-To: <20230107141911.47229-1-nikita@trvn.ru>
References: <20230107141911.47229-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jasper Korten <jja2000@gmail.com>

The Galaxy Tab A 9.7 (2015) is a Snapdragon 410 based tablet.

This commit introduces basic support for the tablet including the
following features:
- SDHCI (internal and external storage)
- USB Device Mode
- UART
- Regulators
- WCNSS (WiFi/BT)
- GPIO keys
- Fuel gauge
- Touchscreen
- Accelerometer

Part of the DT is split out into a common dtsi since the tablet shares
majority of the design with another variant having a different screen
size.

Signed-off-by: Jasper Korten <jja2000@gmail.com>
Co-developed-by: Siddharth Manthan <siddharth_manthan@outlook.com>
Signed-off-by: Siddharth Manthan <siddharth_manthan@outlook.com>
Co-developed-by: Nikita Travkin <nikita@trvn.ru>
Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../dts/qcom/msm8916-samsung-gt5-common.dtsi  | 296 ++++++++++++++++++
 .../boot/dts/qcom/msm8916-samsung-gt510.dts   | 113 +++++++
 3 files changed, 410 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index b42362c7be1b..70e3b109aeff 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -19,6 +19,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-a5u-eur.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-e5.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-e7.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-grandmax.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-gt510.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-j5.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-serranove.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt88047.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
new file mode 100644
index 000000000000..d920b7247d82
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
@@ -0,0 +1,296 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/dts-v1/;
+
+#include "msm8916-pm8916.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	aliases {
+		serial0 = &blsp1_uart2;
+	};
+
+	chosen {
+		stdout-path = "serial0";
+	};
+
+	reserved-memory {
+		/* Additional memory used by Samsung firmware modifications */
+		tz-apps@85500000 {
+			reg = <0x0 0x85500000 0x0 0xb00000>;
+			no-map;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		pinctrl-0 = <&gpio_keys_default>;
+		pinctrl-names = "default";
+
+		label = "GPIO Buttons";
+
+		volume-up-button {
+			label = "Volume Up";
+			gpios = <&msmgpio 107 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+		};
+
+		home-button {
+			label = "Home";
+			gpios = <&msmgpio 109 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_HOMEPAGE>;
+		};
+	};
+
+	gpio-hall-sensor {
+		compatible = "gpio-keys";
+
+		pinctrl-0 = <&gpio_hall_sensor_default>;
+		pinctrl-names = "default";
+
+		label = "GPIO Hall Effect Sensor";
+
+		hall-sensor-switch {
+			label = "Hall Effect Sensor";
+			gpios = <&msmgpio 52 GPIO_ACTIVE_LOW>;
+			linux,input-type = <EV_SW>;
+			linux,code = <SW_LID>;
+			linux,can-disable;
+		};
+	};
+};
+
+&blsp_i2c4 {
+	status = "okay";
+
+	fuelgauge@36 {
+		compatible = "maxim,max77849-battery";
+		reg = <0x36>;
+
+		maxim,rsns-microohm = <10000>;
+		maxim,over-heat-temp = <600>;
+		maxim,over-volt = <4400>;
+
+		interrupt-parent = <&msmgpio>;
+		interrupts = <121 IRQ_TYPE_EDGE_FALLING>;
+
+		pinctrl-0 = <&fuelgauge_int_default>;
+		pinctrl-names = "default";
+	};
+};
+
+&blsp_i2c2 {
+	status = "okay";
+
+	light-sensor@10 {
+		compatible = "capella,cm3323";
+		reg = <0x10>;
+	};
+
+	accelerometer@1d {
+		compatible = "st,lis2hh12";
+		reg = <0x1d>;
+
+		vdd-supply = <&pm8916_l17>;
+		vddio-supply = <&pm8916_l5>;
+
+		interrupt-parent = <&msmgpio>;
+		interrupts = <115 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "INT1";
+
+		st,drdy-int-pin = <1>;
+		mount-matrix = "0", "1", "0",
+			      "-1", "0", "0",
+			       "0", "0", "1";
+
+		pinctrl-0 = <&accel_int_default>;
+		pinctrl-names = "default";
+	};
+};
+
+&blsp1_uart2 {
+	status = "okay";
+};
+
+&pm8916_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
+};
+
+/* FIXME: Replace with MAX77849 MUIC when driver is available */
+&pm8916_usbin {
+	status = "okay";
+};
+
+&pronto {
+	status = "okay";
+
+	iris {
+		compatible = "qcom,wcn3660b";
+	};
+};
+
+&sdhc_1 {
+	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
+	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
+	pinctrl-names = "default", "sleep";
+
+	status = "okay";
+};
+
+&sdhc_2 {
+	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_on>;
+	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
+	pinctrl-names = "default", "sleep";
+
+	cd-gpios = <&msmgpio 38 GPIO_ACTIVE_LOW>;
+
+	status = "okay";
+};
+
+&usb {
+	dr_mode = "peripheral";
+	extcon = <&pm8916_usbin>;
+
+	status = "okay";
+};
+
+&usb_hs_phy {
+	extcon = <&pm8916_usbin>;
+};
+
+&smd_rpm_regulators {
+	vdd_l1_l2_l3-supply = <&pm8916_s3>;
+	vdd_l4_l5_l6-supply = <&pm8916_s4>;
+	vdd_l7-supply = <&pm8916_s4>;
+
+	s3 {
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1300000>;
+	};
+
+	s4 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <2100000>;
+	};
+
+	l1 {
+		regulator-min-microvolt = <1225000>;
+		regulator-max-microvolt = <1225000>;
+	};
+
+	l2 {
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+	};
+
+	l4 {
+		regulator-min-microvolt = <2050000>;
+		regulator-max-microvolt = <2050000>;
+	};
+
+	l5 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	l6 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	l7 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	l8 {
+		regulator-min-microvolt = <2850000>;
+		regulator-max-microvolt = <2900000>;
+	};
+
+	l9 {
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	l10 {
+		regulator-min-microvolt = <2700000>;
+		regulator-max-microvolt = <2800000>;
+	};
+
+	l11 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <2950000>;
+		regulator-system-load = <200000>;
+		regulator-allow-set-load;
+	};
+
+	l12 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <2950000>;
+	};
+
+	l13 {
+		regulator-min-microvolt = <3075000>;
+		regulator-max-microvolt = <3075000>;
+	};
+
+	l14 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	l15 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	l16 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	l17 {
+		regulator-min-microvolt = <2850000>;
+		regulator-max-microvolt = <2850000>;
+	};
+
+	l18 {
+		regulator-min-microvolt = <2700000>;
+		regulator-max-microvolt = <2700000>;
+	};
+};
+
+&msmgpio {
+	accel_int_default: accel-int-default-state {
+		pins = "gpio115";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	fuelgauge_int_default: fuelgauge-int-default-state {
+		pins = "gpio121";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	gpio_keys_default: gpio-keys-default-state {
+		pins = "gpio107", "gpio109";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
+	gpio_hall_sensor_default: gpio-hall-sensor-default-state {
+		pins = "gpio52";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts
new file mode 100644
index 000000000000..607a5dc8a534
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/dts-v1/;
+
+#include "msm8916-samsung-gt5-common.dtsi"
+
+/ {
+	model = "Samsung Galaxy Tab A 9.7 (2015)";
+	compatible = "samsung,gt510", "qcom,msm8916";
+	chassis-type = "tablet";
+
+	clk_pwm: pwm {
+		compatible = "clk-pwm";
+		#pwm-cells = <2>;
+
+		clocks = <&gcc GCC_GP2_CLK>;
+
+		pinctrl-0 = <&motor_pwm_default>;
+		pinctrl-names = "default";
+	};
+
+	reg_motor_vdd: regulator-motor-vdd {
+		compatible = "regulator-fixed";
+		regulator-name = "motor_vdd";
+		regulator-min-microvolt = <3000000>;
+		regulator-max-microvolt = <3000000>;
+
+		gpio = <&msmgpio 76 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&motor_en_default>;
+		pinctrl-names = "default";
+	};
+
+	reg_tsp_1p8v: regulator-tsp-1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "tsp_1p8v";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+
+		gpio = <&msmgpio 73 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&tsp_en_default>;
+		pinctrl-names = "default";
+	};
+
+	reg_tsp_3p3v: regulator-tsp-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "tsp_3p3v";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&msmgpio 73 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vibrator {
+		compatible = "pwm-vibrator";
+
+		pwms = <&clk_pwm 0 100000>;
+		pwm-names = "enable";
+
+		vcc-supply = <&reg_motor_vdd>;
+	};
+};
+
+&blsp_i2c5 {
+	status = "okay";
+
+	touchscreen@4a {
+		compatible = "atmel,maxtouch";
+		reg = <0x4a>;
+		interrupt-parent = <&msmgpio>;
+		interrupts = <13 IRQ_TYPE_LEVEL_LOW>;
+
+		vdd-supply = <&reg_tsp_1p8v>;
+		vdda-supply = <&reg_tsp_3p3v>;
+
+		reset-gpios = <&msmgpio 114 GPIO_ACTIVE_LOW>;
+
+		pinctrl-0 = <&tsp_int_rst_default>;
+		pinctrl-names = "default";
+	};
+};
+
+&msmgpio {
+	motor_en_default: motor-en-default-state {
+		pins = "gpio76";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	motor_pwm_default: motor-pwm-default-state {
+		pins = "gpio50";
+		function = "gcc_gp2_clk_a";
+	};
+
+	tsp_en_default: tsp-en-default-state {
+		pins = "gpio73";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	tsp_int_rst_default: tsp-int-rst-default-state {
+		pins = "gpio13", "gpio114";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+};
-- 
2.38.1

