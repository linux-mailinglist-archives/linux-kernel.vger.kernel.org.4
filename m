Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0905B62C195
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbiKPO5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbiKPO4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:56:55 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC88910055;
        Wed, 16 Nov 2022 06:56:52 -0800 (PST)
Received: from g550jk.arnhem.chello.nl (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 4ABD9D05CD;
        Wed, 16 Nov 2022 14:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1668610611; bh=iBM2d0vBat5ZFgDCbZjjmK/mChO+wHHFauDbHUV6pcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Gc9gAvRCZzJvbE7fqvgviknS6NXUCYJeFY125AEuembqNwvMw2+w7EEecGAmq0fNm
         Q/z0//+OJ/mM5Gy2HoEzH6nbKiPuL4i06BsmxKkEe/a/wUUw63Qu/92vX/WFbkAHGW
         gUkelp+fn5UguZI8XOTzuG0ah9sNMTM3y9hYIETo=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Alejandro Tafalla <atafalla@dnyon.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] arm64: dts: qcom: msm8953: Add device tree for Xiaomi Mi A2 Lite
Date:   Wed, 16 Nov 2022 15:56:05 +0100
Message-Id: <20221116145616.17884-5-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116145616.17884-1-luca@z3ntu.xyz>
References: <20221116145616.17884-1-luca@z3ntu.xyz>
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

From: Alejandro Tafalla <atafalla@dnyon.com>

Add device tree for the Xiaomi Mi A2 Lite (daisy) smartphone. This
device is based on Snapdragon 625 (msm8953) SoC.

Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>
---
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/msm8953-xiaomi-daisy.dts    | 316 ++++++++++++++++++
 2 files changed, 317 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 21a6a7b5a2cf..6a80a36465f7 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -22,6 +22,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-j5.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-serranove.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt88047.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-motorola-potter.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-daisy.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-lg-bullhead-rev-10.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-lg-bullhead-rev-101.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-msft-lumia-octagon-talkman.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts
new file mode 100644
index 000000000000..8ddf075ccda4
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts
@@ -0,0 +1,316 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 The Linux Foundation. All rights reserved.
+ */
+/dts-v1/;
+
+#include "msm8953.dtsi"
+#include "pm8953.dtsi"
+#include "pmi8950.dtsi"
+
+/ {
+	model = "Xiaomi Mi A2 Lite";
+	compatible = "xiaomi,daisy", "qcom,msm8953";
+	chassis-type = "handset";
+	qcom,msm-id = <293 0>;
+	qcom,board-id= <0x1000b 0x9>;
+
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		framebuffer@90001000 {
+			compatible = "simple-framebuffer";
+			reg = <0 0x90001000 0 (1920 * 2280 * 3)>;
+
+			width = <1080>;
+			height = <2280>;
+			stride = <(1080 * 3)>;
+			format = "r8g8b8";
+
+			power-domains = <&gcc MDSS_GDSC>;
+
+			clocks = <&gcc GCC_MDSS_AHB_CLK>,
+				 <&gcc GCC_MDSS_AXI_CLK>,
+				 <&gcc GCC_MDSS_VSYNC_CLK>,
+				 <&gcc GCC_MDSS_MDP_CLK>,
+				 <&gcc GCC_MDSS_BYTE0_CLK>,
+				 <&gcc GCC_MDSS_PCLK0_CLK>,
+				 <&gcc GCC_MDSS_ESC0_CLK>;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio_key_default>;
+
+		key-volume-up {
+			label = "Volume Up";
+			gpios = <&tlmm 85 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+		};
+	};
+
+	reserved-memory {
+		/delete-node/ memory@85b00000;
+
+		memory@84b00000 {
+			reg = <0x0 0x84a00000 0x0 0x1900000>;
+			no-map;
+		};
+
+		adsp_fw_mem: memory@8d600000 {
+			reg = <0x0 0x8d600000 0x0 0x1200000>;
+			no-map;
+		};
+
+		/delete-node/ memory@8e700000;
+		wcnss_fw_mem: memory@8e800000 {
+			reg = <0x0 0x8e800000 0x0 0x700000>;
+			no-map;
+		};
+	};
+
+	sensors: i2c-sensors {
+		compatible = "i2c-gpio";
+		sda-gpios = <&tlmm 14 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&tlmm 15 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+		i2c-gpio,delay-us = <2>;        /* ~100 kHz */
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		lsm6dsl@6a {
+			compatible = "st,lsm6dsl";
+			reg = <0x6a>;
+			vdd-supply = <&pm8953_l10>;
+			vddio-supply = <&pm8953_l6>;
+
+			mount-matrix = "-1", "0", "0",
+					"0", "-1", "0",
+					"0", "0", "1";
+		};
+	};
+
+	vph_pwr: vph-pwr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&hsusb_phy {
+	vdd-supply = <&pm8953_l3>;
+	vdda-pll-supply = <&pm8953_l7>;
+	vdda-phy-dpdm-supply = <&pm8953_l13>;
+
+	status = "okay";
+};
+
+&i2c_2 {
+	status = "okay";
+
+	speaker_codec: audio-codec@3a {
+		compatible = "maxim,max98927";
+		reg = <0x3a>;
+
+		reset-gpios = <&tlmm 89 GPIO_ACTIVE_LOW>;
+
+		vmon-slot-no = <1>;
+		imon-slot-no = <1>;
+		interleave_mode = <0>;
+
+		#sound-dai-cells = <0>;
+	};
+};
+
+&i2c_3 {
+	status = "okay";
+
+	touchscreen@38 {
+		compatible = "edt,edt-ft5406";
+		reg = <0x38>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <65 IRQ_TYPE_EDGE_FALLING>;
+
+		reset-gpios = <&tlmm 64 GPIO_ACTIVE_LOW>;
+
+		vcc-supply = <&pm8953_l10>;
+
+		touchscreen-size-x = <1080>;
+		touchscreen-size-y = <2280>;
+	};
+};
+
+&pm8953_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
+};
+
+&pmi8950_wled {
+	qcom,current-limit-microamp = <20000>;
+	qcom,ovp-milivolt = <29500>;
+	qcom,num-strings = <2>;
+
+	status = "okay";
+};
+
+&rpm_requests {
+	regulators {
+		compatible = "qcom,rpm-pm8953-regulators";
+
+		vdd_s1-supply = <&vph_pwr>;
+		vdd_s2-supply = <&vph_pwr>;
+		vdd_s3-supply = <&vph_pwr>;
+		vdd_s4-supply = <&vph_pwr>;
+		vdd_s5-supply = <&vph_pwr>;
+		vdd_s6-supply = <&vph_pwr>;
+		vdd_s7-supply = <&vph_pwr>;
+		vdd_l1-supply = <&pm8953_s3>;
+		vdd_l2_l3-supply = <&pm8953_s3>;
+		vdd_l4_l5_l6_l7_l16_l19-supply = <&pm8953_s4>;
+		vdd_l8_l11_l12_l13_l14_l15-supply = <&vph_pwr>;
+		vdd_l9_l10_l17_l18_l22-supply = <&vph_pwr>;
+
+		pm8953_s1: s1 {
+			regulator-min-microvolt = <863000>;
+			regulator-max-microvolt = <1152000>;
+		};
+
+		pm8953_s3: s3 {
+			regulator-min-microvolt = <1224000>;
+			regulator-max-microvolt = <1224000>;
+		};
+
+		pm8953_s4: s4 {
+			regulator-min-microvolt = <1896000>;
+			regulator-max-microvolt = <2048000>;
+		};
+
+		pm8953_l1: l1 {
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1100000>;
+		};
+
+		pm8953_l2: l2 {
+			regulator-min-microvolt = <975000>;
+			regulator-max-microvolt = <1225000>;
+		};
+
+		pm8953_l3: l3 {
+			regulator-min-microvolt = <925000>;
+			regulator-max-microvolt = <925000>;
+			regulator-allow-set-load;
+		};
+
+		pm8953_l5: l5 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8953_l6: l6 {
+			regulator-always-on;
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8953_l7: l7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1900000>;
+		};
+
+		pm8953_l8: l8 {
+			regulator-min-microvolt = <2900000>;
+			regulator-max-microvolt = <2900000>;
+		};
+
+		pm8953_l9: l9 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		pm8953_l10: l10 {
+			regulator-always-on;
+			regulator-min-microvolt = <2850000>;
+			regulator-max-microvolt = <2850000>;
+		};
+
+		pm8953_l11: l11 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		pm8953_l12: l12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		pm8953_l13: l13 {
+			regulator-min-microvolt = <3125000>;
+			regulator-max-microvolt = <3125000>;
+		};
+
+		pm8953_l16: l16 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8953_l17: l17 {
+			regulator-min-microvolt = <2850000>;
+			regulator-max-microvolt = <2850000>;
+		};
+
+		pm8953_l19: l19 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1350000>;
+		};
+
+		pm8953_l22: l22 {
+			regulator-always-on;
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2850000>;
+		};
+
+		pm8953_l23: l23 {
+			regulator-min-microvolt = <975000>;
+			regulator-max-microvolt = <1225000>;
+		};
+	};
+};
+
+&sdhc_1 {
+	status = "okay";
+};
+
+&sdhc_2 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_on>;
+	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
+
+	cd-gpios = <&tlmm 133 GPIO_ACTIVE_LOW>;
+
+	status = "okay";
+};
+
+&tlmm {
+	gpio-reserved-ranges = <0 4>, <16 4>, <135 4>;
+};
+
+&uart_0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart_console_active>;
+
+	status = "okay";
+};
+
+&usb3 {
+	status = "okay";
+};
+
+&usb3_dwc3 {
+	dr_mode = "peripheral";
+};
-- 
2.38.1

