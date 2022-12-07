Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6AC646113
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 19:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiLGSbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 13:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiLGSbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 13:31:32 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D3C6C738;
        Wed,  7 Dec 2022 10:31:31 -0800 (PST)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 7E8E4CA46E;
        Wed,  7 Dec 2022 18:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1670437859; bh=3NYobxsgmI/f1HWzVhaq1CGDv252AX/ZxmEmqHEFhmE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=lx4oaurzqOtPSl+fPQohVYH3UpKDyEKAwA3Zm7gzZAFwSFIv7J5RNphwQ2owj85ve
         qURAl5ckONxr8C/bTJ4lpIgbYtH0UE+gu25YCbiz9HG74WLl5F6UOonMy6XmquGfQl
         iWWXw+sIIa0gkOLxeXI5H4NLNztBUy743HHcIVAg=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Wed, 07 Dec 2022 19:30:40 +0100
Subject: [PATCH v3 3/9] arm64: dts: qcom: sdm450: Add device tree for Motorola Moto
 G6
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221207-msm8953-6-1-next-dtbs-v3-v3-3-a64b3b0af0eb@z3ntu.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6927; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=rX1h49uDBw+/pYJ6x2ppOAB8FuHs0pUY9JI/ADxtvo4=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBjkNvczbNQXVfIFJgUDTv7UHnFT1RjYuyv9cKQHdnb
 cUoJNkSJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCY5Db3AAKCRBy2EO4nU3XVjunD/
 4m1OWQBy6hh6thKtSv5thmNDb3bOQom5pu0wR0S6lgwDeAytJBuwY2H7PIfZPmaqkeakx7DxvGUCSE
 6SBRllytmSBFoj+gh0uibZ1uJ59NLqzs4igajH9LP/4O3htYl3viFk2TTs9sS8G1Bf2abgr3XTp5t1
 zFFGJ0d1LZjOKeOsd9UXNEwtvprbLjJ7JJtX3cd2DI2XujpRI6L/ytJJe13ATmMrvF1fXdyitqKtV1
 +iFEaOWW9tLiIp/a9SWLbKZf75vh73KFZ+6rT/5ZAOYVzbksAOkMwwx+cdxiXO17BRS0+11uTBnwDr
 L0tQNnq77GTIzYF2/JEgP3meWdICWntQlukOuc2IgKiDDlktSgFYwWJ/BmaN+RRbpUavUT/1xyx862
 WzMxdVNNSCz7k8AT5PZ2LW+SNsY5KOfL2n7kvlycu07BB70bv54DdKBkK1wjTuMjb/KSXdKAnAs/Nb
 dFVx6+hdo1SDss5pJ/Ht4sSU/Rh9yzW3WyXXqjcHZzdT7eg0YNTLoA11rrCFIJAb2xuhmp4HoMGUT5
 s9Kj7jRHYIGHus8Lirv6EP3gVcCmllin3iZzTcI1nT4+pwkoklYmKAioSDHmoLsoUAGTrmP7EsurwE
 2elsNqjkPl0xZdDGC7nLte30o2LvpqyrEQ8wcSXMldPGLIoB4E4+8RyYJj3w==
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

From: Julian Braha <julianbraha@gmail.com>

Add device tree for the Motorola Moto G6 (ali) smartphone. This device
is based on Snapdragon 450 (sdm450) SoC which is a variant of MSM8953.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/Makefile                |   1 +
 arch/arm64/boot/dts/qcom/sdm450-motorola-ali.dts | 252 +++++++++++++++++++++++
 2 files changed, 253 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 3e79496292e7..dcca6f084509 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -127,6 +127,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-crd-r3.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc8280xp-crd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc8280xp-lenovo-thinkpad-x13s.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sda660-inforce-ifc6560.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sdm450-motorola-ali.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-ganges-kirin.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-discovery.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-pioneer.dtb
diff --git a/arch/arm64/boot/dts/qcom/sdm450-motorola-ali.dts b/arch/arm64/boot/dts/qcom/sdm450-motorola-ali.dts
new file mode 100644
index 000000000000..362be5719dd2
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sdm450-motorola-ali.dts
@@ -0,0 +1,252 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2022, Julian Braha <julianbraha@gmail.com>
+ */
+/dts-v1/;
+
+#include "msm8953.dtsi"
+#include "pm8953.dtsi"
+#include "pmi8950.dtsi"
+
+/delete-node/ &qseecom_mem;
+
+/ {
+	model = "Motorola Moto G6";
+	compatible = "motorola,ali", "qcom,sdm450";
+	chassis-type = "handset";
+	qcom,msm-id = <338 0>;
+	qcom,board-id = <0x43 0xc200>;
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		key-volume-up {
+			label = "volume_up";
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
+		ramoops@ef000000 {
+			compatible = "ramoops";
+			reg = <0x0 0xef000000 0x0 0xc0000>;
+			console-size = <0x40000>;
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
+	touchscreen@38 {
+		compatible = "edt,edt-ft5406";
+		reg = <0x38>;
+		interrupt-parent = <&tlmm>;
+		interrupts = <65 IRQ_TYPE_EDGE_FALLING>;
+		vcc-supply = <&pm8953_l10>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&ts_int_active &ts_reset_active>;
+
+		reset-gpios = <&tlmm 64 GPIO_ACTIVE_LOW>;
+		touchscreen-size-x = <1080>;
+		touchscreen-size-y = <2160>;
+	};
+};
+
+&pm8953_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
+};
+
+&pmi8950_wled {
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
+			regulator-min-microvolt = <795000>;
+			regulator-max-microvolt = <1081000>;
+		};
+
+		pm8953_s3: s3 {
+			regulator-min-microvolt = <1224000>;
+			regulator-max-microvolt = <1224000>;
+		};
+
+		pm8953_s4: s4 {
+			regulator-min-microvolt = <1900000>;
+			regulator-max-microvolt = <2050000>;
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
+	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_off>;
+	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
+
+	status = "okay";
+};
+
+&tlmm {
+	gpio-reserved-ranges = <95 5>, <111 1>, <126 1>;
+
+	ts_int_active: ts-int-active-state {
+		pins = "gpio65";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+	};
+
+	ts_reset_active: ts-reset-active-state {
+		pins = "gpio64";
+		function = "gpio";
+		drive-strength = <0x08>;
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
