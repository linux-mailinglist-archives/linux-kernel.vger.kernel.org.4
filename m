Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD248664661
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 17:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238989AbjAJP6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 10:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234577AbjAJP60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 10:58:26 -0500
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CAD4FCDF;
        Tue, 10 Jan 2023 07:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1673366300;
        bh=8bqvx3BWXzFFayEeDBru/f9hwZ1Rgjr2YK0gvWf45+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Lh8vv+2xF0BsD8bOc3vQ0kVY3rm2o/yOCIgB92/vlAIYNwMGDKCpuDZ5nUndOW4/u
         VHe6fuVDMSFixZOoNYmSye9elZVm4TQL0ysCNCCZHqiJ13cGqe6PkTgLkeO19tWK42
         PnO9lkvzWqXjogpqFJfrfAu6rmzarbrmVs7yr6jQ=
Received: from localhost.localdomain ([2409:8a4c:808f:5b0:d92f:83a8:9ac7:4de5])
        by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
        id C9A3CA11; Tue, 10 Jan 2023 23:50:26 +0800
X-QQ-mid: xmsmtpt1673365858tg30zhx95
Message-ID: <tencent_A7FA00B086BB0EFFDC1C64744FF85DAD2B06@qq.com>
X-QQ-XMAILINFO: NY3HYYTs4gYSmKakgqwzKQuI84tWzRESKw9GcMWu+ohrxgzMEw3UU2ExUqik37
         /QUxQA7UyO6ZSI9/qx88L3WjnBIP3F2VV+nCy06fS/FzbqHQKNa0wn0cHaKiEft0EoJYwMY95jMm
         GybBYATDUjtAeUN7J06wc5QTjodgzYpOhTbh6mWslyD/KYM80MY6skyC349DhrDFPurkJ09TST/S
         0wjY9t3cab85/DU4tE23MhfDORM7h9zqFLHStqXYnz9T0ExXMiyvrWC/J6nHbWrngMFxzz3FmZqg
         vNg7HOSN+jSEUEND2is+oXseAXCdQEIa6xtkmW+l+i8bTyICRZPUOcftqnSEDfaPCZY7I/Yh77BF
         1sZ4C6Dcss8g76lCx1b0N8uQqZE7OjhcHsGrqIZNFIhDTstigBbqxOr/j3scd85jfChIYV0mpEUl
         XUL7nACLxTcO0iqlAxLBN8N6mxpZntzhZzyOgm5sfvqbcR7a3f+WeK+pqSHgIbCrUzeThBuh3J6Z
         E0y3sQC+42PKZUqy+DkJPfIOmG6vztVHwfMq9PjnNatNLtA6X8QlcPJzHWG1phP9HBztG3jhFXys
         XOnmvhRnZVuuyjn8mzm366CdtckV3achlUJu0Lygds+pcdbVt4682pGuVs8Z+eC5N/zhVNf6b/c3
         cAsb3JIbjMgZ49tMcAsnG6d5+S6kfb7fZGC/Z4oJ0tkE7OiBiN64MYXUU3uVrQWkO5zHB2pzhNXp
         2loUw+y0LNUAMhdmhBGQSFnd60872iVAP97Vt83OWz4btAsjZtirc9SOdvqM9pb6l/H2xNrqjI4T
         oQkmvjSAEwCbp4VSDXTSrmCWywHSiC83Pp4fpMk5RDjYoyY5ZaIJt1jftULuKmmQkva8SEmjM2WC
         HMYAi3x7uxd0y+2Cn5KPMWzuKpPLEBaYPqB7JRf4fwr6lVUiHQxH+qXgmC+zKJDYnBKHCofz8ggO
         za1eTQXE/nfJXjMzCvq74Q5fxHHWqRy4cAGzvdY5+aUNuj5HcHx3ScMfOR1BfXM2qs7JqMOp1wH7
         qddLrtgUV9mPSaIxl3bcW30xRahHYsT5BBT7x/H0kb/vSgjgCNayc/flvUEGU=
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
Subject: [PATCH 3/3] arm64: dts: qcom: msm8916-zhihe: Add initial device tree for zhihe Wifi/LTE dongle UFI-001C and uf896
Date:   Tue, 10 Jan 2023 23:50:14 +0800
X-OQ-MSGID: <20230110155014.31664-4-forbidden405@foxmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110155014.31664-1-forbidden405@foxmail.com>
References: <20230110155014.31664-1-forbidden405@foxmail.com>
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
unknown manufactures based on MSM8916.
uf896 is another variant for the zhihe usb stick. The board design
difers by using different gpios for the keys and leds.

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
 .../boot/dts/qcom/msm8916-zhihe-uf896.dts     |  41 +++
 .../boot/dts/qcom/msm8916-zhihe-ufi001c.dts   |  39 +++
 arch/arm64/boot/dts/qcom/msm8916-zhihe.dtsi   | 246 ++++++++++++++++++
 4 files changed, 328 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-zhihe-uf896.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-zhihe-ufi001c.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-zhihe.dtsi

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index b42362c7be1bf..7abc7bb19c9fc 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -21,6 +21,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-e7.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-grandmax.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-j5.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-serranove.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-zhihe-uf896.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-zhihe-ufi001c.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt88047.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-motorola-potter.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-daisy.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8916-zhihe-uf896.dts b/arch/arm64/boot/dts/qcom/msm8916-zhihe-uf896.dts
new file mode 100644
index 0000000000000..2ddceb1d8b210
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-zhihe-uf896.dts
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/dts-v1/;
+
+#include "msm8916-zhihe.dtsi"
+
+/ {
+	model = "uf896 4G Modem Stick";
+	compatible = "zhihe,uf896", "qcom,msm8916";
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
diff --git a/arch/arm64/boot/dts/qcom/msm8916-zhihe-ufi001c.dts b/arch/arm64/boot/dts/qcom/msm8916-zhihe-ufi001c.dts
new file mode 100644
index 0000000000000..715874a2b8650
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-zhihe-ufi001c.dts
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/dts-v1/;
+
+#include "msm8916-zhihe.dtsi"
+
+/ {
+	model = "ufi-001c/ufi-001b 4G Modem Stick";
+	compatible = "zhihe,ufi001c", "qcom,msm8916";
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
diff --git a/arch/arm64/boot/dts/qcom/msm8916-zhihe.dtsi b/arch/arm64/boot/dts/qcom/msm8916-zhihe.dtsi
new file mode 100644
index 0000000000000..286768d0fbe70
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-zhihe.dtsi
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

