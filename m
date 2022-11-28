Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF4163AEE4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbiK1R0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbiK1R0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:26:18 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E1B27929;
        Mon, 28 Nov 2022 09:26:15 -0800 (PST)
Received: from g550jk.arnhem.chello.nl (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 036D0D1E0D;
        Mon, 28 Nov 2022 17:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1669656344; bh=dmo/YOaylkpZ/u5w7kpIO263ccAyQ5s7XIWS8DcmI0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=DkawFmOb9FBoJAoIPC1J7aXBp46IV67kD1CT+uTf8broyvU6FkYYZrz/y2j5L0M4C
         6xFZN6M5An2k+WT7YIExSTVJIPul0gC29CzHk+9uzyuIkjN/ijd1zp1TnM5JuqhLGp
         7MiBGRdB5OlJgEQXdy0WoBxc7Tb4EkegzTbSzwqs=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Julian Goldsmith <julian@juliangoldsmith.com>,
        Oleg Chernovskiy <kanedias@keemail.me>,
        Luca Weiss <luca@z3ntu.xyz>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] ARM: dts: qcom: msm8974: Add OnePlus One
Date:   Mon, 28 Nov 2022 18:25:30 +0100
Message-Id: <20221128172531.828660-2-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221128172531.828660-1-luca@z3ntu.xyz>
References: <20221128172531.828660-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julian Goldsmith <julian@juliangoldsmith.com>

OnePlus One is a smartphone launched in 2014 and is based on the
Snapdragon 801 SoC (-AC variant).

Supported features:
* ADSP
* Charger
* Coincell charger
* Fuel gauge
* Internal storage
* Touchscreen
* UART
* USB
* Wifi/Bluetooth

Signed-off-by: Julian Goldsmith <julian@juliangoldsmith.com>
Co-developed-by: Oleg Chernovskiy <kanedias@keemail.me>
Signed-off-by: Oleg Chernovskiy <kanedias@keemail.me>
Co-developed-by: Luca Weiss <luca@z3ntu.xyz>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes in v2:
* Rebase on https://lore.kernel.org/linux-arm-msm/20221128171623.825572-1-luca@z3ntu.xyz/T/
  Clean up USB node like for the other devices in the commit above

 arch/arm/boot/dts/Makefile                    |   1 +
 .../dts/qcom-msm8974pro-oneplus-bacon.dts     | 417 ++++++++++++++++++
 2 files changed, 418 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 90bb9866cc88..3c76e3e4785b 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1064,6 +1064,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-msm8974-sony-xperia-rhine-amami.dtb \
 	qcom-msm8974-sony-xperia-rhine-honami.dtb \
 	qcom-msm8974pro-fairphone-fp2.dtb \
+	qcom-msm8974pro-oneplus-bacon.dtb \
 	qcom-msm8974pro-samsung-klte.dtb \
 	qcom-msm8974pro-sony-xperia-shinano-castor.dtb \
 	qcom-mdm9615-wp8548-mangoh-green.dtb \
diff --git a/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts b/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts
new file mode 100644
index 000000000000..b5606623f968
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts
@@ -0,0 +1,417 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "qcom-msm8974pro.dtsi"
+#include "qcom-pm8841.dtsi"
+#include "qcom-pm8941.dtsi"
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+
+/ {
+	model = "OnePlus One";
+	compatible = "oneplus,bacon", "qcom,msm8974pro", "qcom,msm8974";
+	chassis-type = "handset";
+	qcom,msm-id = <194 0x10000>;
+	qcom,board-id = <8 0>;
+
+	aliases {
+		serial0 = &blsp1_uart2;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&blsp1_i2c1 {
+	status = "okay";
+
+	fuel-gauge@55 {
+		compatible = "ti,bq27541";
+		reg = <0x55>;
+		power-supplies = <&bq24196_charger>;
+	};
+};
+
+&blsp1_i2c2 {
+	status = "okay";
+
+	rmi4-i2c-dev@20 {
+		compatible = "syna,rmi4-i2c";
+		reg = <0x20>;
+
+		syna,startup-delay-ms = <100>;
+
+		interrupts-extended = <&tlmm 61 IRQ_TYPE_EDGE_FALLING>;
+		vdd-supply = <&pm8941_l22>;
+		vio-supply = <&pm8941_lvs3>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&touch_default_state>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		rmi4-f01@1 {
+			reg = <0x1>;
+			syna,nosleep-mode = <1>;
+		};
+
+		rmi4-f12@12 {
+			reg = <0x12>;
+			syna,sensor-type = <1>;
+			/*
+			 * Touchscreen size is 2040x1080, y-values between
+			 * 1920-2040 are used for touchkey (menu, home & back).
+			 * For now clip it off so we don't get touch events
+			 * outside of the display area.
+			 */
+			syna,clip-y-high = <1920>;
+		};
+	};
+};
+
+&blsp1_i2c6 {
+	status = "okay";
+
+	bq24196_charger: charger@6b {
+		compatible = "ti,bq24196";
+		reg = <0x6b>;
+		interrupts-extended = <&tlmm 31 IRQ_TYPE_EDGE_FALLING>;
+		omit-battery-class;
+	};
+};
+
+&blsp1_uart2 {
+	status = "okay";
+};
+
+&gcc {
+	compatible = "qcom,gcc-msm8974pro-ac";
+};
+
+&pm8941_coincell {
+	qcom,rset-ohms = <800>;
+	qcom,vset-millivolts = <3200>;
+
+	status = "okay";
+};
+
+&pronto {
+	vddmx-supply = <&pm8841_s1>;
+	vddcx-supply = <&pm8841_s2>;
+	vddpx-supply = <&pm8941_s3>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&wcnss_pin_a>;
+
+	status = "okay";
+
+	iris {
+		vddxo-supply = <&pm8941_l6>;
+		vddrfa-supply = <&pm8941_l11>;
+		vddpa-supply = <&pm8941_l19>;
+		vdddig-supply = <&pm8941_s3>;
+	};
+
+	smd-edge {
+		qcom,remote-pid = <4>;
+		label = "pronto";
+
+		wcnss {
+			status = "okay";
+		};
+	};
+};
+
+&remoteproc_adsp {
+	cx-supply = <&pm8841_s2>;
+
+	status = "okay";
+};
+
+&rpm_requests {
+	regulators-0 {
+		compatible = "qcom,rpm-pm8841-regulators";
+
+		pm8841_s1: s1 {
+			regulator-min-microvolt = <675000>;
+			regulator-max-microvolt = <1050000>;
+		};
+
+		pm8841_s2: s2 {
+			regulator-min-microvolt = <875000>;
+			regulator-max-microvolt = <1050000>;
+			regulator-always-on;
+		};
+
+		pm8841_s3: s3 {
+			regulator-min-microvolt = <1050000>;
+			regulator-max-microvolt = <1050000>;
+		};
+	};
+
+	regulators-1 {
+		compatible = "qcom,rpm-pm8941-regulators";
+
+		vdd_l1_l3-supply = <&pm8941_s1>;
+		vdd_l2_lvs1_2_3-supply = <&pm8941_s3>;
+		vdd_l4_l11-supply = <&pm8941_s1>;
+		vdd_l5_l7-supply = <&pm8941_s2>;
+		vdd_l6_l12_l14_l15-supply = <&pm8941_s2>;
+		vdd_l8_l16_l18_l19-supply = <&vreg_vph_pwr>;
+		vdd_l9_l10_l17_l22-supply = <&vreg_boost>;
+		vdd_l13_l20_l23_l24-supply = <&vreg_boost>;
+		vdd_l21-supply = <&vreg_boost>;
+
+		pm8941_s1: s1 {
+			regulator-min-microvolt = <1300000>;
+			regulator-max-microvolt = <1300000>;
+
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		pm8941_s2: s2 {
+			regulator-min-microvolt = <2150000>;
+			regulator-max-microvolt = <2150000>;
+
+			regulator-boot-on;
+		};
+
+		pm8941_s3: s3 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-system-load = <154000>;
+
+			regulator-always-on;
+			regulator-boot-on;
+			regulator-allow-set-load;
+		};
+
+		pm8941_l1: l1 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1225000>;
+
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		pm8941_l2: l2 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		pm8941_l3: l3 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1225000>;
+		};
+
+		pm8941_l4: l4 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1225000>;
+		};
+
+		pm8941_l5: l5 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8941_l6: l6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+
+			regulator-boot-on;
+		};
+
+		pm8941_l7: l7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+
+			regulator-boot-on;
+		};
+
+		pm8941_l8: l8 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8941_l9: l9 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		pm8941_l10: l10 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		pm8941_l11: l11 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1350000>;
+		};
+
+		pm8941_l12: l12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+
+			regulator-always-on;
+			regulator-boot-on;
+			regulator-allow-set-load;
+		};
+
+		pm8941_l13: l13 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+
+			regulator-boot-on;
+		};
+
+		pm8941_l14: l14 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8941_l15: l15 {
+			regulator-min-microvolt = <2050000>;
+			regulator-max-microvolt = <2050000>;
+		};
+
+		pm8941_l16: l16 {
+			regulator-min-microvolt = <2700000>;
+			regulator-max-microvolt = <2700000>;
+		};
+
+		pm8941_l17: l17 {
+			regulator-min-microvolt = <2850000>;
+			regulator-max-microvolt = <2850000>;
+		};
+
+		pm8941_l18: l18 {
+			regulator-min-microvolt = <2850000>;
+			regulator-max-microvolt = <2850000>;
+		};
+
+		pm8941_l19: l19 {
+			regulator-min-microvolt = <2900000>;
+			regulator-max-microvolt = <3350000>;
+		};
+
+		pm8941_l20: l20 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+
+			regulator-system-load = <200000>;
+			regulator-allow-set-load;
+			regulator-boot-on;
+		};
+
+		pm8941_l21: l21 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+
+			regulator-boot-on;
+		};
+
+		pm8941_l22: l22 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+			regulator-allow-set-load;
+		};
+
+		pm8941_l23: l23 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+		};
+
+		pm8941_l24: l24 {
+			regulator-min-microvolt = <3075000>;
+			regulator-max-microvolt = <3075000>;
+
+			regulator-boot-on;
+		};
+
+		pm8941_lvs3: lvs3 {};
+	};
+};
+
+&sdhc_1 {
+	vmmc-supply = <&pm8941_l20>;
+	vqmmc-supply = <&pm8941_s3>;
+
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sdc1_on>;
+	pinctrl-1 = <&sdc1_off>;
+
+	status = "okay";
+};
+
+&tlmm {
+	sdc1_on: sdc1-on-state {
+		clk-pins {
+			pins = "sdc1_clk";
+			drive-strength = <4>;
+			bias-disable;
+		};
+
+		cmd-data-pins {
+			pins = "sdc1_cmd", "sdc1_data";
+			drive-strength = <4>;
+			bias-pull-up;
+		};
+	};
+
+	touch_default_state: touch-default-state {
+		int-pins {
+			pins = "gpio61";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-disable;
+			input-enable;
+		};
+
+		reset-pins {
+			pins = "gpio60";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
+	wcnss_pin_a: wcnss-pin-active-state {
+		wlan-pins {
+			pins = "gpio36", "gpio37", "gpio38", "gpio39", "gpio40";
+			function = "wlan";
+			drive-strength = <6>;
+			bias-pull-down;
+		};
+
+		bt-pins {
+			pins = "gpio35", "gpio43", "gpio44";
+			function = "bt";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+	};
+};
+
+&usb {
+	phys = <&usb_hs1_phy>;
+	phy-select = <&tcsr 0xb000 0>;
+	extcon = <&smbb>, <&usb_id>;
+	vbus-supply = <&chg_otg>;
+
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+
+	status = "okay";
+};
+
+&usb_hs1_phy {
+	status = "okay";
+
+	v1p8-supply = <&pm8941_l6>;
+	v3p3-supply = <&pm8941_l24>;
+
+	extcon = <&smbb>;
+	qcom,init-seq = /bits/ 8 <0x1 0x64>;
+};
-- 
2.38.1

