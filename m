Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A85646123
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 19:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiLGScE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 13:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiLGSbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 13:31:35 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65BF6E57A;
        Wed,  7 Dec 2022 10:31:34 -0800 (PST)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 992B2CA474;
        Wed,  7 Dec 2022 18:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1670437862; bh=S3rdsnAd+EN2Xrpqco5hkvF1iY6KBSEemrYqRZ09QIY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=NitHY5mmigiSLN0KzddnI4U8I1P+e/GPwsuiYMVvUk3fgQHv2oAU5qaTWWRJhGw62
         kID9XpLQGuOI4EcYDoSYj5TJzs++KjAhX7DD8UpPFOlUBWtH597lonc0VPUAzLJm36
         yD1qDaCtAWZ5WiyVqAV84LYQe0TpUr1dL1VWaxLI=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Wed, 07 Dec 2022 19:30:46 +0100
Subject: [PATCH v3 9/9] arm64: dts: qcom: sdm632: Add device tree for Motorola G7
 Power
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221207-msm8953-6-1-next-dtbs-v3-v3-9-a64b3b0af0eb@z3ntu.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7685; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=9S+RsrnSlN1BSxEP9zi4JIArpOHnf7x58PHkAZu4K3Q=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBjkNvhL9fP9Ci+H+fvhrD9iSucX4ZnGxU5W4r4UJf1
 j3su3nmJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCY5Db4QAKCRBy2EO4nU3XVua6D/
 9b6T+4I5jNQ1mqGef+/ce+CAx10lgbDZWvaulXM8gPe/vDVcWNX3xShsfn1BZVGFNnUmJTh+LHG1CU
 megwbI7ioJrxizo1PVSuSH89NEwHVrLlO0laLzr6XFEidUVVhI8mHN4XLgNer5jyCB7X71x/px6rmi
 MyuilswLTL061Fn90DBFBmv+mnE+E5wZC04FKirXKIYSYjTp8unJb5eSf4PT3d/Gs+EW3peEIriw3j
 1Q5hJvAo4XNVGwWpFgsAtFNe0+sCvLVVT8LwRyJRvsjQoA8oXNlGPI5MkaM2barcRoOAQ+QOPGfFlk
 Aawm2dj5nteV3b1RB+nP1awti7BFZsM1za8rByzfO+l1fPCjBhLcWn7/pHLVYqh53H3Hq+KPay+T60
 pf7jpKfQ1Y8Yp/geS7dU+QPOMl7j+4fmU8TtA67A+BMabdTKwn4IoKDQOnOhDvqIKshzdphUxP9c6O
 8FfHn8OjTveGG7o3q0palzkYySHPeAICm7QjE2WWXJp9Ier0gvuW1jP2Vq587/u1/QmzdgxjqKV5RH
 sfH517Wef+BoxEDof3i5UIN0sT5OaBeZyEQ56z/lQMobRwqo1dZWNwsBgcLNVoLJOSOlGbxZCJ5wX6
 sj3K/g1ynCN6VOjuAJV+uC66jwqDd30TfNZmPVWLeaH6X5JwhOUTK0b3LwXg==
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

From: Gabriela David <ultracoolguy@disroot.org>

Add device tree for the Motorola G7 Power (ocean) smartphone. This
device is based on Snapdragon 632 (sdm632) SoC which is a variant of
MSM8953.

Signed-off-by: Gabriela David <ultracoolguy@disroot.org>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/Makefile                  |   1 +
 arch/arm64/boot/dts/qcom/sdm632-motorola-ocean.dts | 291 +++++++++++++++++++++
 2 files changed, 292 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 995973d3960a..21fd4aae31bc 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -138,6 +138,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-discovery.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-pioneer.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-voyager.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm632-fairphone-fp3.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sdm632-motorola-ocean.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm636-sony-xperia-ganges-mermaid.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm660-xiaomi-lavender.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm670-google-sargo.dtb
diff --git a/arch/arm64/boot/dts/qcom/sdm632-motorola-ocean.dts b/arch/arm64/boot/dts/qcom/sdm632-motorola-ocean.dts
new file mode 100644
index 000000000000..c82d6e628d2c
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sdm632-motorola-ocean.dts
@@ -0,0 +1,291 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2022, Gabriela David
+ */
+/dts-v1/;
+
+#include "sdm632.dtsi"
+#include "pm8953.dtsi"
+#include <dt-bindings/leds/common.h>
+
+/delete-node/ &cont_splash_mem;
+/delete-node/ &qseecom_mem;
+
+/ {
+	model = "Motorola G7 Power";
+	compatible = "motorola,ocean", "qcom,sdm632";
+	chassis-type = "handset";
+	qcom,msm-id = <349 0>;
+	qcom,board-id = <0x141 0xc100>;
+	qcom,pmic-id = <0x10016 0x25 0x00 0x00>;
+
+	backlight: backlight {
+		compatible = "led-backlight";
+		leds = <&led>;
+	};
+
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		framebuffer@90001000 {
+			compatible = "simple-framebuffer";
+			reg = <0 0x90001000 0 (720 * 1520 * 3)>;
+
+			width = <720>;
+			height = <1520>;
+			stride = <(720 * 3)>;
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
+		qseecom_mem: qseecom@84300000 {
+			reg = <0x0 0x84300000 0x0 0x2000000>;
+			no-map;
+		};
+
+		cont_splash_mem: cont-splash@90001000 {
+			reg = <0x0 0x90001000 0x0 (720 * 1520 * 3)>;
+			no-map;
+		};
+
+		reserved@eefa1800 {
+			reg = <0x00 0xeefa1800 0x00 0x5e800>;
+			no-map;
+		};
+
+		ramoops@ef000000 {
+			compatible = "ramoops";
+			reg = <0x0 0xef000000 0x0 0xbf800>;
+			console-size = <0x40000>;
+			pmsg-size = <0x40000>;
+			record-size = <0x3f800>;
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
+&i2c_3 {
+	status = "okay";
+
+	touchscreen@41 {
+		compatible = "ilitek,ili2117";
+		reg = <0x41>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <65 IRQ_TYPE_EDGE_FALLING>;
+
+		touchscreen-inverted-x;
+	};
+};
+
+&i2c_5 {
+	status = "okay";
+
+	led-controller@36 {
+		compatible = "ti,lm3697";
+		reg = <0x36>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led: led@1 {
+			reg = <1>;
+			default-trigger = "backlight";
+			function = LED_FUNCTION_BACKLIGHT;
+			led-sources = <0 1 2>;
+		};
+	};
+};
+
+&pm8953_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
+};
+
+&rpm_requests {
+	regulators {
+		compatible = "qcom,rpm-pm8953-regulators";
+
+		vdd_l1-supply = <&pm8953_s3>;
+		vdd_l2_l3-supply = <&pm8953_s3>;
+		vdd_l4_l5_l6_l7_l16_l19-supply = <&pm8953_s4>;
+		vdd_l8_l11_l12_l13_l14_l15-supply = <&vph_pwr>;
+		vdd_l9_l10_l17_l18_l22-supply = <&vph_pwr>;
+
+		pm8953_s3: s3 {
+			regulator-min-microvolt = <984000>;
+			regulator-max-microvolt = <1240000>;
+		};
+
+		pm8953_s4: s4 {
+			regulator-min-microvolt = <1036000>;
+			regulator-max-microvolt = <2040000>;
+		};
+
+		pm8953_l1: l1 {
+			regulator-min-microvolt = <975000>;
+			regulator-max-microvolt = <1050000>;
+		};
+
+		pm8953_l2: l2 {
+			regulator-min-microvolt = <975000>;
+			regulator-max-microvolt = <1175000>;
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
+			regulator-boot-on;
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
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <3000000>;
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
+		pm8953_l18: l18 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2700000>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		pm8953_l19: l19 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1350000>;
+		};
+
+		pm8953_l22: l22 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
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
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_on>;
+	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
+
+	status = "okay";
+};
+
+&tlmm {
+	gpio-reserved-ranges = <96 4>;
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
