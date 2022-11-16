Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6778A62C19B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbiKPO5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbiKPO47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:56:59 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90205389B;
        Wed, 16 Nov 2022 06:56:58 -0800 (PST)
Received: from g550jk.arnhem.chello.nl (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 09161D05D1;
        Wed, 16 Nov 2022 14:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1668610617; bh=SKb2rWteWM0mnRZuriHaYT75eRqWzQfUzGQ3ZY5C6/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=uuN+HxG8K3XSRIFz25gMLMRtgb3MTFD5d+hgY7DahOx79pMB8Q7hWskktEmZXiEoL
         1fzpP+A8hayjzqfGIG0CBRJtLgUg+qJIYchqW5M9MEaiaUIzgzttS1w5nj4cyyFFrC
         m37/LRZG/Sk/jz8wq8xUFBG4DirRgK4IfcYU1MFQ=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Gabriela David <ultracoolguy@disroot.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 8/8] arm64: dts: qcom: sdm632: Add device tree for Motorola G7 Power
Date:   Wed, 16 Nov 2022 15:56:09 +0100
Message-Id: <20221116145616.17884-9-luca@z3ntu.xyz>
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

From: Gabriela David <ultracoolguy@disroot.org>

Add device tree for the Motorola G7 Power (ocean) smartphone. This
device is based on Snapdragon 632 (sdm632) SoC which is a variant of
MSM8953.

Signed-off-by: Gabriela David <ultracoolguy@disroot.org>
---
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/sdm632-motorola-ocean.dts   | 287 ++++++++++++++++++
 2 files changed, 288 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm632-motorola-ocean.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index bed490c095dd..d125ea98ce3b 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -126,6 +126,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-discovery.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-pioneer.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-voyager.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm632-fairphone-fp3.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sdm632-motorola-ocean.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm636-sony-xperia-ganges-mermaid.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm660-xiaomi-lavender.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-cheza-r1.dtb
diff --git a/arch/arm64/boot/dts/qcom/sdm632-motorola-ocean.dts b/arch/arm64/boot/dts/qcom/sdm632-motorola-ocean.dts
new file mode 100644
index 000000000000..7ec7ec0ef2d5
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sdm632-motorola-ocean.dts
@@ -0,0 +1,287 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/dts-v1/;
+
+#include "sdm632.dtsi"
+#include "pm8953.dtsi"
+#include <dt-bindings/leds/common.h>
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
+		/delete-node/ memory@85b00000;
+
+		memory@84300000 {
+			reg = <0x0 0x84300000 0x0 0x2000000>;
+			no-map;
+		};
+
+		memory@90001000 {
+			reg = <0x0 0x90001000 0x0 (720 * 1520 * 3)>;
+			no-map;
+		};
+
+		memory@eefa1800 {
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
+		pm8953_l6: l6 { // other ocean models use l22 instead
+			regulator-always-on;
+			regulator-boot-on;
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
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_on>;
+	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
+
+	vmmc-supply = <&pm8953_l11>;
+	vqmmc-supply = <&pm8953_l12>;
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
2.38.1

