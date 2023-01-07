Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBA6660F7D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 15:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbjAGOUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 09:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbjAGOTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 09:19:32 -0500
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C640D4D4B6;
        Sat,  7 Jan 2023 06:19:27 -0800 (PST)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id BB1054BF42;
        Sat,  7 Jan 2023 19:19:20 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1673101161; bh=98yN+f2gbc0QP8iZEQUmpTCgZk/fJzPj6sESd2fvICU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=feEc1IHTz6shvxyG9chz4pYm2EfEJZst/iv7un6D4UKntYxv2zUSHmulAb+psKcaL
         74zhTqu2WTGFgV1FSBaGPZVOaDLUVULKeGX9tKgLve+awfh6wJctFl04U5TyIMCJum
         tYUIepSrldRtQaXRl/uttlu23KrsLMc6eo7d7jViLqNWsMKGRoYkxwRfVIyu+MYrXh
         AI1W8E9y1Bdm1eXysIB+o0Z+6y/DgRCRuJHLV4ibECtXz7zbErdhNAtW2HA/Zrh7vp
         8Y+nQeGSeKTU5A+yypt0V+W3J1/BV1I85S7Ooms4wH7owyGphmrJrRvaCF8B0JJO8K
         mWinzZl0SRYOw==
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
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v3 3/3] arm64: dts: qcom: Add device tree for Samsung Galaxy Tab A 8.0 (2015)
Date:   Sat,  7 Jan 2023 19:19:11 +0500
Message-Id: <20230107141911.47229-4-nikita@trvn.ru>
In-Reply-To: <20230107141911.47229-1-nikita@trvn.ru>
References: <20230107141911.47229-1-nikita@trvn.ru>
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

From: Siddharth Manthan <siddharth.manthan@gmail.com>

Galaxy Tab A 8.0 is a tablet, very similar to Tab A 9.7 with major
differences being the display and touchscreen.

Add it's devicetree reusing a common dtsi from gt510.

Signed-off-by: Siddharth Manthan <siddharth.manthan@gmail.com>
[Squashed multiple commits]
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 arch/arm64/boot/dts/qcom/Makefile             |  1 +
 .../boot/dts/qcom/msm8916-samsung-gt58.dts    | 75 +++++++++++++++++++
 2 files changed, 76 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 70e3b109aeff..062561db33f1 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -20,6 +20,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-e5.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-e7.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-grandmax.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-gt510.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-gt58.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-j5.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-serranove.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt88047.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts
new file mode 100644
index 000000000000..5d6f8383306b
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts
@@ -0,0 +1,75 @@
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
+
+	reg_vdd_tsp: regulator-vdd-tsp {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_tsp";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&msmgpio 73 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&reg_tsp_en_default>;
+		pinctrl-names = "default";
+	};
+
+	vibrator {
+		compatible = "gpio-vibrator";
+		enable-gpios = <&msmgpio 76 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-0 = <&vibrator_en_default>;
+		pinctrl-names = "default";
+	};
+};
+
+&blsp_i2c5 {
+	status = "okay";
+
+	touchscreen@20 {
+		compatible = "zinitix,bt532";
+		reg = <0x20>;
+		interrupt-parent = <&msmgpio>;
+		interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
+
+		touchscreen-size-x = <768>;
+		touchscreen-size-y = <1024>;
+
+		vcca-supply = <&reg_vdd_tsp>;
+		vdd-supply = <&pm8916_l6>;
+
+		pinctrl-0 = <&tsp_int_default>;
+		pinctrl-names = "default";
+	};
+};
+
+&msmgpio {
+	reg_tsp_en_default: reg-tsp-en-default-state {
+		pins = "gpio73";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	tsp_int_default: tsp-int-default-state {
+		pins = "gpio13";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	vibrator_en_default: vibrator-en-default-state {
+		pins = "gpio76";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+};
-- 
2.38.1

