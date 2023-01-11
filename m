Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F450665D74
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238368AbjAKOOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236599AbjAKOOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:14:23 -0500
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD53638B4;
        Wed, 11 Jan 2023 06:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1673446457;
        bh=WeAfG4q7lscsbUtzVg64kqY5IfCJe6Z4UI1XTaa+95M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=vyaHVrHvAm0tS9JiSoVZ/vqOv7WMXNSotk5MHCRxuc9wypuwaHn9P1FXaGzPsJyr/
         kj0URfXjp7ncYS7r+I5c8kNAcxd5smu++WY1g2PEH3PtwHMYUCs4ONOfxQzlE5hIQO
         BaauUdOEminWqXseKo1+TbXYaxJBV/c56GZIW2yc=
Received: from localhost.localdomain ([111.60.247.106])
        by newxmesmtplogicsvrszc2-1.qq.com (NewEsmtp) with SMTP
        id 37731CEB; Wed, 11 Jan 2023 22:13:55 +0800
X-QQ-mid: xmsmtpt1673446454t2pfeo66q
Message-ID: <tencent_F934F7427EB7B986E8AF70A95A397436E007@qq.com>
X-QQ-XMAILINFO: Md8NwmqZYy3fbANy6RbzLrwah382LG/Bqb3hJJQps1++cwqE2CbVfTWMLQ3Mq7
         Eeq8AY6dPPl95QXgxE3xvM4x/SC0WmH+OuqIV4nxUxPpoJ7Zg4USLrdILJV4DaP8SS73Bh2dOZue
         jBURo+oR8N/3bGRTn8wNVMUlasKFl8/MCofj9Sav9LfTEQBHGARKmcd0gKoqgCS/Mk7qFzObRWhe
         uc9lUSIdQlkW3FUVCz38ZS9JP2KWWe7izEnLJADDflGi7uwr6hl+S9u2Wk0PyZpQYUn3wv7YWOcI
         wAJJym2pj6T+xB/iM7/IlzHil/sOq49UMKE+qVJ3SDazDfnr8zgYYkfpWoC+/04iXWHgdEY437Vs
         n1+D/QfCxvXF7u9PKb5xn6cqTX60wlfSEtl+2Tsob05126F29LKHoVqnfcsOZVN30UoCAuQ8efhk
         3a2kUmkB0RNA3XarP0zq3LHT5xaN8Z41+20hHh0JElXIPt8bKp8xgUM4yrL/1C2DMUe68ecMq8tO
         j6JlDEKgfXID8WMSeHF9h4pvm8T22y51GUtuLgd5PrZ8druzaDqaVYShj9hU1maTmEdrJ0QyUZdd
         +LY38uUtQjnH/Xp4soTjo8sVqK7qmzlZzJriagSg8SdOy/jZKs9EDRC/IV17EprMyHL1BDmUJiR7
         LXW2PrA965B1e9YSZxoYBZ28dYKWyhddzqwTq7exMYO/3M2P/xvRyelN6B4+hP7hkec2sks793r3
         hbzOTk3reZ896MhVg4G9XDso5Vif6E/SK2Eqcvq1PMVG9YF3OXliEJoTXpJOwBHd/heXlKpp5yA1
         lPi4rj5oZdPwjfCSzJG7nRAksBt8IJNbNdMPBLDr9hSkSz0I/VEGgrmcCldJPnWa9E2yrNdWnzwP
         C892ORSeYwCxG02dm125Qs/ZtyfLlzlr+XjRNr8Gl4+6RQcwRS3pxxkuiCCuJBTYV5K+cD4GGBK8
         Bht4d//ZbqbHCdMHctuVLIdDK3o1Ms3ddC4s6JgkArINyjPfpGZVIoojNzhkM3DAeGdwBkg1VQte
         xhQNoWqQ==
From:   Yang Xiwen <forbidden405@foxmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jaime Breva <jbreva@nayarsystems.com>,
        Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Yang Xiwen <forbidden405@foxmail.com>
Subject: [PATCH v2 3/3] arm64: dts: qcom: msm8916-thwc: Add initial device tree for Tong Heng Wei Chuang Wifi/LTE dongle UFI-001C and uf896
Date:   Wed, 11 Jan 2023 22:13:11 +0800
X-OQ-MSGID: <20230111141311.14682-4-forbidden405@foxmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111141311.14682-1-forbidden405@foxmail.com>
References: <20230111141311.14682-1-forbidden405@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
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
 .../boot/dts/qcom/msm8916-thwc-uf896.dts      |  41 +++
 .../boot/dts/qcom/msm8916-thwc-ufi001c.dts    |  39 +++
 arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi     | 246 ++++++++++++++++++
 4 files changed, 328 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-thwc-uf896.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index b42362c7be1bf..523dbe6d06be8 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -21,6 +21,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-e7.dtb
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
index 0000000000000..79447ca48dd3a
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-thwc-uf896.dts
@@ -0,0 +1,41 @@
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
+	function = LED_FUNCTION_WLAN;
+};
+
+&led_b {
+	gpios = <&msmgpio 81 GPIO_ACTIVE_HIGH>;
+	function = LED_FUNCTION_WAN;
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
index 0000000000000..286768d0fbe70
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
@@ -0,0 +1,246 @@
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
+		/* gpio is board-specific */
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
+		/* GPIOs are board-specific */
+		led_r: led-r {
+			color = <LED_COLOR_ID_RED>;
+			default-state = "on";
+			function = LED_FUNCTION_INDICATOR;
+		};
+
+		led_g: led-g {
+			color = <LED_COLOR_ID_GREEN>;
+			default-state = "off";
+			function = LED_FUNCTION_INDICATOR;
+		};
+
+		led_b: led-b {
+			color = <LED_COLOR_ID_BLUE>;
+			default-state = "off";
+			function = LED_FUNCTION_INDICATOR;
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

