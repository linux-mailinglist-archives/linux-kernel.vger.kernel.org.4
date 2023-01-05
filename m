Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539E865EB0C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 13:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbjAEMva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 07:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbjAEMvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:51:24 -0500
X-Greylist: delayed 1043 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 Jan 2023 04:51:22 PST
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AD948CD7;
        Thu,  5 Jan 2023 04:51:22 -0800 (PST)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 19899420CD;
        Thu,  5 Jan 2023 17:33:56 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1672922036; bh=oPZ1t+DpMVviHoMdVYbzlv1d7V7KYP6byecE4ht5AYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1onlXCH2a88j7Kp/Yx0oDp82WiXbP40Se/FpM7OWMX/4VdchZorGFybOsjv3hZLcc
         nhL0yQ+3VRC4nsxd05KhxijG83jRclOVK+Ef8TJEfTOzumbdi+URpStyP59q/uyMao
         mQ5wN9zJJvtOFQtdC9m9VtmpqENCUKDpaqAVfjPZHGRibj1C2NrSC0fzwxszdLtj2K
         6lKpkLf+gDoBfgjx52/0A+ztL8LWgPYfLi73JTlLN4IZSkskCXlUq2PuFKmS2/7tqF
         n1HI8zBX3Xt+77qeeGcZrdN6mmbDoZn45Ggw1SqBulJLQDrH4SyKZn4e+9v9dQmPc9
         gHc7psBhjDseA==
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
Subject: [PATCH 2/8] arm64: dts: qcom: Add device tree for Samsung Galaxy Tab A (2015)
Date:   Thu,  5 Jan 2023 17:32:34 +0500
Message-Id: <20230105123240.1089375-3-nikita@trvn.ru>
In-Reply-To: <20230105123240.1089375-1-nikita@trvn.ru>
References: <20230105123240.1089375-1-nikita@trvn.ru>
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

This dts adds support for wifi and lte variants of
Samsung Galaxy Tab A tablets released in 2015. (with both 8.0 and
9.7 inch displays)

Add a device tree for gt58 and gt510 with initial support for:

- SDHCI (internal and external storage)
- USB Device Mode
- UART
- Regulators
- WCNSS (WiFi/BT)
- GPIO keys

Most of the device tree is separated into
msm8916-samsung-gt5-common.dtsi as these devices share a lot of
hardware with each other.

Signed-off-by: Jasper Korten <jja2000@gmail.com>
Co-developed-by: Siddharth Manthan <siddharth_manthan@outlook.com>
Signed-off-by: Siddharth Manthan <siddharth_manthan@outlook.com>
Co-developed-by: Nikita Travkin <nikita@trvn.ru>
Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 arch/arm64/boot/dts/qcom/Makefile             |   2 +
 .../dts/qcom/msm8916-samsung-gt5-common.dtsi  | 236 ++++++++++++++++++
 .../boot/dts/qcom/msm8916-samsung-gt510.dts   |  11 +
 .../boot/dts/qcom/msm8916-samsung-gt58.dts    |  11 +
 4 files changed, 260 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index b42362c7be1b..062561db33f1 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -19,6 +19,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-a5u-eur.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-e5.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-e7.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-grandmax.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-gt510.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-gt58.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-j5.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-serranove.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt88047.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
new file mode 100644
index 000000000000..9cdb33247691
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
@@ -0,0 +1,236 @@
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
+		regulator-allow-set-load;
+		regulator-system-load = <200000>;
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
+	gpio_keys_default: gpio-keys-default-state {
+		pins = "gpio107", "gpio109";
+		function = "gpio";
+
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
+	gpio_hall_sensor_default: gpio-hall-sensor-default-state {
+		pins = "gpio52";
+		function = "gpio";
+
+		drive-strength = <2>;
+		bias-disable;
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts
new file mode 100644
index 000000000000..e9916199e5a3
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts
@@ -0,0 +1,11 @@
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
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts
new file mode 100644
index 000000000000..688e9be590ba
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/dts-v1/;
+
+#include "msm8916-samsung-gt5-common.dtsi"
+
+/ {
+	model = "Samsung Galaxy Tab A 8.0 (2015)";
+	compatible = "samsung,gt58", "qcom,msm8916";
+	chassis-type = "tablet";
+};
-- 
2.38.1

