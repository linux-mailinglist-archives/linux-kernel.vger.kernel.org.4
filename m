Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A61646120
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 19:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiLGSb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 13:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiLGSbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 13:31:33 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A706DCED;
        Wed,  7 Dec 2022 10:31:31 -0800 (PST)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 05D4ACA46F;
        Wed,  7 Dec 2022 18:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1670437860; bh=ziYJ5alYgPDCYdKyrJ3ErxhzqWB2pyFGEyyXqN3xjjo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=aVbvCdIAVoupaHT0KMAujPYJ4floEP9ZpngUZG/pu6KWp7L0b5UkM8slMj9+PaP4x
         Kup322oaK7r7UmBCdiUIMcZAKjN1MA1kHIgSQ+A3oM3qnQj2A+buoBbDqNqObiTPIP
         wiBfU3N2lf+tMBQHPVbAqHqJ5qOAjkBJBjmYklzA=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Wed, 07 Dec 2022 19:30:41 +0100
Subject: [PATCH v3 4/9] arm64: dts: qcom: msm8953: Add device tree for Motorola G5
 Plus
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221207-msm8953-6-1-next-dtbs-v3-v3-4-a64b3b0af0eb@z3ntu.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8084; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=eFObl3NPc+KgvXBxwx4ThXe25S6Q9ZZ6hfwUqvnRK/c=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBjkNvcvLAs5kbF36N+x0drZUZR6am/uKeZJzGf7a2W
 yaS/g5SJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCY5Db3AAKCRBy2EO4nU3XVnKGD/
 9rgVAngR4gDiLi7sYEOmkp3SGjR80sXkt6MHu6dIeHyYp9ypdNvG9rR2POYBpByxrOA8rV8IWwy49J
 q2IeptgSVhj3UZcS8x4ozlbp3jyJ/l/Vje9e7tiS0ixcXWmju99xw0t6KIB0ZQrIePstmSRXDPI3Mp
 iMA7O65421G1dOSaUsmECkWNeafXeOEjQNB8kUYBrBPIOB8rWf9HjAtKZfxZTFMLe2SfRPuHVz3QSU
 MNM/CU70qm0XaS0frpQrBRYLGt4ap0WhoUhK55Up9fyxOWY54Tvgf8TWNW21NZn0s89dOjNUCtvlX+
 NxkmQXOjsauEs8tw+PuT7uXyG7Md+48XkQDfDEsf2TZxTHdw9get6qr7naDqXSoj94fUuNvuUumLot
 IrYkDPVw8dH31q3jDu/XUCe39mQtqZHuhgcQ9tan9NoocXq+QOiG0vEb0MqznsgrtmyPaW+y/AYa7Q
 BN2u8XJEewhuLPKLNamu/eY7zs7QTjTYfhr98pw0BpcNSvbpHhVaQj3CjF9URJocptqFEA7zAsUC9p
 Yakll7iHJ81ALO6k+zRFufS7Jn2KsbeDRyzBXsVrQ5LmU2RRKmpONohAXh1n1YPtgsFsuNgZ2TfPLS
 cJEvzE5pClYRK6jCTTGzXTr9dpDyJlf1XasElT39g28sLGB0l+ouoLT7xZLw==
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

From: Sireesh Kodali <sireeshkodali1@gmail.com>

Add device tree for the Motorola G5 Plus (potter) smartphone. This
device is based on Snapdragon 625 (msm8953) SoC.

Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/Makefile                  |   1 +
 .../boot/dts/qcom/msm8953-motorola-potter.dts      | 305 +++++++++++++++++++++
 2 files changed, 306 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index dcca6f084509..a054c902943b 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -21,6 +21,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-grandmax.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-j5.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-serranove.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt88047.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-motorola-potter.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8956-sony-xperia-loire-kugo.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8956-sony-xperia-loire-suzu.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-lg-bullhead-rev-10.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8953-motorola-potter.dts b/arch/arm64/boot/dts/qcom/msm8953-motorola-potter.dts
new file mode 100644
index 000000000000..711d84dad9d7
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8953-motorola-potter.dts
@@ -0,0 +1,305 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2022, Sireesh Kodali
+ */
+/dts-v1/;
+
+#include "msm8953.dtsi"
+#include "pm8953.dtsi"
+#include "pmi8950.dtsi"
+
+/delete-node/ &cont_splash_mem;
+/delete-node/ &qseecom_mem;
+
+/ {
+	model = "Motorola G5 Plus";
+	compatible = "motorola,potter", "qcom,msm8953";
+	chassis-type = "handset";
+	qcom,msm-id = <293 0>;
+	qcom,board-id = <0x46 0x83a0>;
+
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		framebuffer@90001000 {
+			compatible = "simple-framebuffer";
+			reg = <0 0x90001000 0 (2220 * 1920 * 3)>;
+
+			width = <1080>;
+			height = <1920>;
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
+		qseecom_mem: qseecom@84300000 {
+			reg = <0x0 0x84300000 0x0 0x2000000>;
+			no-map;
+		};
+
+		cont_splash_mem: cont-splash@90001000 {
+			reg = <0x0 0x90001000 0x0 (1080 * 1920 * 3)>;
+			no-map;
+		};
+
+		reserved@aefd2000 {
+			reg = <0x0 0xaefd2000 0x0 0x2e000>;
+			no-map;
+		};
+
+		reserved@eefe4000 {
+			reg = <0x0 0xeefe4000 0x0 0x1c000>;
+			no-map;
+		};
+
+		ramoops@ef000000 {
+			compatible = "ramoops";
+			reg = <0x0 0xef000000 0x0 0x80000>;
+			console-size = <0x40000>;
+			ftrace-size = <0>;
+			record-size = <0x3f800>;
+			pmsg-size = <0x800>;
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
+	touchscreen@20 {
+		reg = <0x20>;
+		compatible = "syna,rmi4-i2c";
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <65 IRQ_TYPE_EDGE_FALLING>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&ts_reset>;
+
+		vdd-supply = <&pm8953_l22>;
+		vio-supply = <&pm8953_l6>;
+
+		syna,reset-delay-ms = <200>;
+		syna,startup-delay-ms = <500>;
+	};
+};
+
+&pm8953_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
+};
+
+&pmi8950_wled {
+	qcom,current-limit-microamp = <25000>;
+	qcom,num-strings = <3>;
+	qcom,external-pfet;
+	qcom,cabc;
+
+	status = "okay";
+};
+
+&rpm_requests {
+	regulators {
+		compatible = "qcom,rpm-pm8953-regulators";
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
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1000000>;
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
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8953_l11: l11 {
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <3000000>;
+		};
+
+		pm8953_l12: l12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3000000>;
+		};
+
+		pm8953_l13: l13 {
+			regulator-min-microvolt = <3075000>;
+			regulator-max-microvolt = <3125000>;
+		};
+
+		pm8953_l15: l15 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8953_l16: l16 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8953_l17: l17 {
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <3000000>;
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
+	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_off>;
+	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
+
+	status = "okay";
+};
+
+&tlmm {
+	gpio-reserved-ranges = <1 2>, <96 4>, <111 1>, <126 1>;
+
+	ts_reset: ts-reset-state {
+		pins = "gpio64";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
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
