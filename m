Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0459E66A9B0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 07:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjANGkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 01:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjANGjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 01:39:45 -0500
Received: from out203-205-251-66.mail.qq.com (out203-205-251-66.mail.qq.com [203.205.251.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196444ECF;
        Fri, 13 Jan 2023 22:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1673678381;
        bh=LoHcNcNBm454Xb58IODkRejrbBSItfWpQRmpyrOreb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=x7TUfCiPnwXpZiSOeRMLWd0IUwEnjt1o0lEwCiDh5dpV+fk2lLA7BPIJ3cWFvIyXC
         i2jzaYCI7PMRtoT/DlY0dmnUO8TY/2DGgle/P2wAXK9PKF1Wt/V9IvoOhB6FSVylZi
         1NQHsBSBnXQUX+pWpC/KOwMRcUdCg90sSfKJRMy8=
Received: from localhost.localdomain ([111.60.247.106])
        by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
        id 9D611E2E; Sat, 14 Jan 2023 14:39:22 +0800
X-QQ-mid: xmsmtpt1673678377td2ciffeo
Message-ID: <tencent_AB776DFEB1B993E8B3F0BD5A4BF420600407@qq.com>
X-QQ-XMAILINFO: NafziRg7Bx69Vf9z4k7XGSrblza44G8FUoObSmRwFY6VtfKlonHOc/GBpk/u6R
         oj8OXrE0vmtoHDQLGjKU1rxCicqBosCt9DPy3rKCiNKdwidErA2/OJ/YT4A6rnwcNxJ1Dftwb3+y
         1W3xzlrvNcuSvzGrVoSQqMcXy9F0BKHQ9ydKTi1pKfA/Z51RLho490dB61N11wARRgxXirnpvzX1
         wL0q/XoVdonVBBG0GCQ3JEn13ckrKFbg5Gs27Rq+EGGfm8cYlHgcUNZP3M7a+g4GLosfXOs1UYA9
         DOoE3+M1A3RjueCmGlOA1/pRy+L+s7kCWZ/tuC4MHyVFD0HVgqwPU8PTwXadteIHpvkUO4DVKWD6
         Q3ef60X+/v+EvxwVcNH1C0KjVEDoM+yhReolFOx7h/Dg6IfZlLZ7xZZSqZBNt2daMtHsjugyPyFQ
         RLcYj1fDZogWMglXqJLmM7BiQ1AFfAf5e+5hC/N7FLaPy2e6Brp+NaWxUNymdlHI5Q09XJj+qOwT
         YRhkbizmqe8ubFPha43OzWkYlDAh+tdHn91fRBXm8qPDK0ACxQ3qYwp9HXqAToM74owMR4M2mLKg
         Fr+UYTkwDBtxiSzptT7Mr4MCiV97PAFM+M23J03mc+QCEA4OiwbFbf7vJrgJQ/WnQHb7J88aLh9L
         wba9ouPAgjdCdoMHiiIqjCQh+77HJhwONz9RLHRdIgGkxHy0L0P6kLNXlvLRqxOoFcZZ4gG3KrFb
         S9rtPCKDFUBCOn1H1oAnOKhKmwaIWarvrXeVIub8FmPvYcNu3oH1asoN99hluyRFNZvxtnB7X8VO
         opopan7Nm8IYjfQvzKKlpMm1JFU9ji8Xt7vzj7m5HLL7eiJo4tfeejlLiLn/HPwqLAWCQ5bQLz2W
         ZB2/OflHAMM/HpqHg/PqQbepJLxHR2yi0u1YfE/aNX6bt9QGYbkqlyPaog1eU/Du2WphdV97t5xn
         1Vj9N17ybBQgDDdfUQ0RXt18JQ6J3VkvQXr+PNOIfgHT65DXZVDrUzox5IqVu1LqOah08A0MPZWw
         TJhZjtAGT1IWS2oJ5d
From:   Yang Xiwen <forbidden405@foxmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Yang Xiwen <forbidden405@foxmail.com>,
        Jaime Breva <jbreva@nayarsystems.com>,
        Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v4 3/3] arm64: dts: qcom: msm8916-thwc: Add initial device trees
Date:   Sat, 14 Jan 2023 14:38:46 +0800
X-OQ-MSGID: <20230114063846.2633-4-forbidden405@foxmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230114063846.2633-1-forbidden405@foxmail.com>
References: <20230114063846.2633-1-forbidden405@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds support for the ufi-001C and uf896 WiFi/LTE dongle made by
Tong Heng Wei Chuang based on MSM8916.
uf896 is another variant for the usb stick. The board design
differs by using different gpios for the keys and leds.

Note: The original firmware does not support 64-bit OS. It is necessary
to flash 64-bit TZ firmware to boot arm64.

Currently supported:
- All CPU cores
- Buttons
- LEDs
- Modem
- SDHC
- USB Device Mode
- UART

Co-developed-by: Jaime Breva <jbreva@nayarsystems.com>
Signed-off-by: Jaime Breva <jbreva@nayarsystems.com>
Co-developed-by: Nikita Travkin <nikita@trvn.ru>
Signed-off-by: Nikita Travkin <nikita@trvn.ru>
Signed-off-by: Yang Xiwen <forbidden405@foxmail.com>
---
 arch/arm64/boot/dts/qcom/Makefile             |   2 +
 .../boot/dts/qcom/msm8916-thwc-uf896.dts      |  39 +++
 .../boot/dts/qcom/msm8916-thwc-ufi001c.dts    |  39 +++
 arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi     | 250 ++++++++++++++++++
 4 files changed, 330 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-thwc-uf896.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index e442a81895d04..d83e02c84d42c 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -22,6 +22,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-e7.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-grandmax.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-j5.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-serranove.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-thwc-uf896.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-thwc-ufi001c.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt88047.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-motorola-potter.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-daisy.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8916-thwc-uf896.dts b/arch/arm64/boot/dts/qcom/msm8916-thwc-uf896.dts
new file mode 100644
index 0000000000000..c492db8561904
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-thwc-uf896.dts
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/dts-v1/;
+
+#include "msm8916-ufi.dtsi"
+
+/ {
+	model = "uf896 4G Modem Stick";
+	compatible = "thwc,uf896", "qcom,msm8916";
+};
+
+&button_restart {
+	gpios = <&msmgpio 35 GPIO_ACTIVE_LOW>;
+};
+
+&led_r {
+	gpios = <&msmgpio 82 GPIO_ACTIVE_HIGH>;
+};
+
+&led_g {
+	gpios = <&msmgpio 83 GPIO_ACTIVE_HIGH>;
+};
+
+&led_b {
+	gpios = <&msmgpio 81 GPIO_ACTIVE_HIGH>;
+};
+
+&button_default {
+	pins = "gpio35";
+	bias-pull-up;
+};
+
+&gpio_leds_default {
+	pins = "gpio81", "gpio82", "gpio83";
+};
+
+&sim_ctrl_default {
+	pins = "gpio1", "gpio2";
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts b/arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts
new file mode 100644
index 0000000000000..700cf81cbf8c0
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/dts-v1/;
+
+#include "msm8916-ufi.dtsi"
+
+/ {
+	model = "ufi-001c/ufi-001b 4G Modem Stick";
+	compatible = "thwc,ufi001c", "qcom,msm8916";
+};
+
+&button_restart {
+	gpios = <&msmgpio 37 GPIO_ACTIVE_HIGH>;
+};
+
+&led_r {
+	gpios = <&msmgpio 22 GPIO_ACTIVE_HIGH>;
+};
+
+&led_g {
+	gpios = <&msmgpio 21 GPIO_ACTIVE_HIGH>;
+};
+
+&led_b {
+	gpios = <&msmgpio 20 GPIO_ACTIVE_HIGH>;
+};
+
+&button_default {
+	pins = "gpio37";
+	bias-pull-down;
+};
+
+&gpio_leds_default {
+	pins = "gpio20", "gpio21", "gpio22";
+};
+
+&sim_ctrl_default {
+	pins = "gpio1", "gpio2";
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
new file mode 100644
index 0000000000000..790a9696da9de
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
@@ -0,0 +1,250 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "msm8916-pm8916.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	chassis-type = "embedded";
+
+	aliases {
+		serial0 = &blsp1_uart2;
+	};
+
+	chosen {
+		stdout-path = "serial0";
+	};
+
+	reserved-memory {
+		mpss_mem: mpss@86800000 {
+			reg = <0x0 0x86800000 0x0 0x5500000>;
+			no-map;
+		};
+
+		gps_mem: gps@8bd00000 {
+			reg = <0x0 0x8bd00000 0x0 0x200000>;
+			no-map;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		pinctrl-0 = <&button_default>;
+		pinctrl-names = "default";
+
+		label = "GPIO Buttons";
+
+		/* GPIO is board-specific */
+		button_restart: button-restart {
+			label = "Restart";
+			linux,code = <KEY_RESTART>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		pinctrl-0 = <&gpio_leds_default>;
+		pinctrl-names = "default";
+
+		/*
+		 * GPIOs are board-specific.
+		 * Functions and default-states defined here are fallbacks.
+		 * Feel free to override them if your board is different.
+		 */
+		led_r: led-r {
+			color = <LED_COLOR_ID_RED>;
+			default-state = "on";
+			function = LED_FUNCTION_POWER;
+		};
+
+		led_g: led-g {
+			color = <LED_COLOR_ID_GREEN>;
+			default-state = "off";
+			function = LED_FUNCTION_WLAN;
+		};
+
+		led_b: led-b {
+			color = <LED_COLOR_ID_BLUE>;
+			default-state = "off";
+			function = LED_FUNCTION_WAN;
+		};
+	};
+};
+
+&bam_dmux {
+	status = "okay";
+};
+
+&bam_dmux_dma {
+	status = "okay";
+};
+
+&blsp1_uart2 {
+	status = "okay";
+};
+
+/* Remove &dsi_phy0 from clocks to make sure that gcc probes with display disabled */
+&gcc {
+	clocks = <&xo_board>, <&sleep_clk>, <0>, <0>, <0>, <0>, <0>;
+};
+
+&mpss {
+	pinctrl-0 = <&sim_ctrl_default>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&pm8916_usbin {
+	status = "okay";
+};
+
+&pronto {
+	status = "okay";
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
+&usb {
+	extcon = <&pm8916_usbin>;
+	dr_mode = "peripheral";
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
+	/* pins are board-specific */
+	button_default: button-default-state {
+		function = "gpio";
+		drive-strength = <2>;
+	};
+
+	gpio_leds_default: gpio-leds-default-state {
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	sim_ctrl_default: sim-ctrl-default-state {
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		output-low;
+	};
+};
-- 
2.39.0

