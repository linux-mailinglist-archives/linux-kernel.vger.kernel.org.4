Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0663964610D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 19:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiLGSbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 13:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiLGSbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 13:31:03 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882D86A759;
        Wed,  7 Dec 2022 10:31:02 -0800 (PST)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 74F94CA470;
        Wed,  7 Dec 2022 18:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1670437860; bh=BMCHmKOc0vteuXLh+B2pFCmznzoV9ucRHz1r68RLUHk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=Wt8q+nZIfDGwLlbItU1Mlc5WyX3HL76+1+h2mLQUegpKcHqjFuet30dP7Kso8xWMX
         hW+ZIe2Gv+y9M8WQlbrNp0Vf3VaQnK7KqtwJBtEkO+UsdIxXUGh3mtV8psuRWSZij+
         r5Xd941ZEOEGYMQkh6bY8bx+iad/o/YKv7L5bguw=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Wed, 07 Dec 2022 19:30:42 +0100
Subject: [PATCH v3 5/9] arm64: dts: qcom: msm8953: Add device tree for Xiaomi Mi A2
 Lite
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221207-msm8953-6-1-next-dtbs-v3-v3-5-a64b3b0af0eb@z3ntu.xyz>
References: <20221207-msm8953-6-1-next-dtbs-v3-v3-0-a64b3b0af0eb@z3ntu.xyz>
In-Reply-To: <20221207-msm8953-6-1-next-dtbs-v3-v3-0-a64b3b0af0eb@z3ntu.xyz>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Tony Luck <tony.luck@intel.com>
Cc:     Gabriela David <ultracoolguy@disroot.org>,
        Eugene Lepshy <fekz115@gmail.com>,
        linux-hardening@vger.kernel.org,
        Anton Bambura <jenneron@protonmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Adam Skladowski <a39.skl@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        Danila Tikhonov <JIaxyga@protonmail.com>,
        Gianluca Boiano <morf3089@gmail.com>,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Julian Braha <julianbraha@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Alejandro Tafalla <atafalla@dnyon.com>
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=8532; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=1J049reWA5VsT/IP0WCS7ErWf1Dn+n7hE8IAJpanTn8=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBjkNvdM/foUXS1yCnJfsFJ1M/ZVbKhvMu5YxCzK+w8
 +8yCgp+JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCY5Db3QAKCRBy2EO4nU3XVpZOD/
 98tB7Fr/RkDARmdIPRMGih5p6w/RglqNCKInAJ0C+JcVuyaj41I2MfUXWezSsJ1580QdgdQPm99DWm
 E4sxW9HgbXyDM8fb9NO+9CXaguFmoSAy0+1T1qbBKlruYYLhB0/e0rVitRO7xrqYC0x9+gAUXxe3uP
 FaBouVyTeQXCWgeTcJuixFkeO6vaAa0Me+RX7ic4P0lgyj7UT20AOgf6A5iSAbOv7ImWyEN3xezepM
 VPVabSZYltoh65Lt0ix3N04VW5b2WEbc1VmflSzqyFmpuPjA1wH9MIKkf7xLEgd75s3nlXz0axSfoz
 cg6VPWVvwllerbmx6Dck6qJ4bLsF3h2CbwibTwOV9QKbMDt8SSLNa5TyeP6ukp60vZnsADG+bg6CYY
 gVr63u6Cdyb/Fo6pxop5yy6JWFTHrv5qu9+tyYhKCWHAw7cmZLTlwTE2ChuBv0wG6OjF+jo1nLNGvB
 Bq4rfS6P0HEyqL0JaCWx4CCsyasVPz/mNpKhvtPd0RnxsNNLZsayTRqcIWV3qXhnOx4EYFJ0fAEhcK
 Yey+MAa/J3CvQG6K64x7kh4+vkcUA6Xte68vy4S6gMuSlbjGztsDXDiPEc7JtQCDNWCQ3OzfWhJlfE
 XcNUivOm5WEBi8PQgRZ+RcwNxk5Y2AVMBoz/Q4m9wnyiKlXsLgBKyUgs6pmg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=ham
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
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/Makefile                 |   1 +
 arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts | 325 ++++++++++++++++++++++
 2 files changed, 326 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index a054c902943b..f5976bfc5ff0 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -22,6 +22,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-j5.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-serranove.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt88047.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-motorola-potter.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-daisy.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8956-sony-xperia-loire-kugo.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8956-sony-xperia-loire-suzu.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-lg-bullhead-rev-10.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts
new file mode 100644
index 000000000000..1d672e608653
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts
@@ -0,0 +1,325 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2022, Alejandro Tafalla
+ */
+/dts-v1/;
+
+#include "msm8953.dtsi"
+#include "pm8953.dtsi"
+#include "pmi8950.dtsi"
+
+/delete-node/ &adsp_fw_mem;
+/delete-node/ &qseecom_mem;
+/delete-node/ &wcnss_fw_mem;
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
+		qseecom_mem: qseecom@84a00000 {
+			reg = <0x0 0x84a00000 0x0 0x1900000>;
+			no-map;
+		};
+
+		adsp_fw_mem: adsp@8d600000 {
+			reg = <0x0 0x8d600000 0x0 0x1200000>;
+			no-map;
+		};
+
+		wcnss_fw_mem: wcnss@8e800000 {
+			reg = <0x0 0x8e800000 0x0 0x700000>;
+			no-map;
+		};
+	};
+
+	/*
+	 * We bitbang on &i2c_4 because BLSP is protected by TZ as sensors are
+	 * normally proxied via ADSP firmware. GPIOs aren't protected.
+	 */
+	i2c-sensors {
+		compatible = "i2c-gpio";
+		sda-gpios = <&tlmm 14 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&tlmm 15 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+		i2c-gpio,delay-us = <2>; /* ~100 kHz */
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		imu@6a {
+			compatible = "st,lsm6dsl";
+			reg = <0x6a>;
+			vdd-supply = <&pm8953_l10>;
+			vddio-supply = <&pm8953_l6>;
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
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
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
+			regulator-min-microvolt = <2850000>;
+			regulator-max-microvolt = <2850000>;
+			regulator-always-on;
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
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2850000>;
+			regulator-always-on;
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
+	vmmc-supply = <&pm8953_l8>;
+	vqmmc-supply = <&pm8953_l5>;
+
+	status = "okay";
+};
+
+&sdhc_2 {
+	vmmc-supply = <&pm8953_l11>;
+	vqmmc-supply = <&pm8953_l12>;
+
+	cd-gpios = <&tlmm 133 GPIO_ACTIVE_LOW>;
+
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_on>;
+	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
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
b4 0.10.1
