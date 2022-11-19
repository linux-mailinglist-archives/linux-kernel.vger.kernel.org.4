Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8CA630F90
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 17:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbiKSQox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 11:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbiKSQok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 11:44:40 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13152EA2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 08:44:34 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id cl5so13841119wrb.9
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 08:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kL9Vrr8MqLlSXcoKfYmXg48ruAsZ82320yLE2edaij4=;
        b=IARl2Zh8ywm95fyw1GAQFbA7pTqWfGKaKBb7rLvA5WIAqm8EtUBK1zf+7PaRIZ2POY
         u4V5w6xcveET3WNQ1+noYwnE/ukD98Z/k3isFxJCpFZMwcsFYbY845hxFH7N4X3l2Kwy
         7tDaGK0HxfX6qRav+ewbx1Iqau6IWc3pFbpS+/+IqfwqZgFrCa/+GuJibnPez9MM3Nly
         XIvwl4N9GJxAoUNTGybZxhgzxcc6Yp2+Un1vO7g2tThEFKKTkpAW1DhcvQOsyevbHbWO
         5Srb7Y0fnT0oPI6oXOKHvz6rCgqNi3nDqIW6NNwYuDsCITEU7sdhVjy9giK9e6NOQ4br
         RIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kL9Vrr8MqLlSXcoKfYmXg48ruAsZ82320yLE2edaij4=;
        b=f+8Y7xiXswO5vZtfylYdmET+umu8e2Jzp//Cfd9pX+PEEVMcj2Mh5l6/fnMgQjGIK6
         CuMI7AdPL7M0SECzj//oMJAdURaAV2GyZLjX7iU3Ur8Po3s/6JnNwCN6/lOQ6791Rlie
         42Thbiwc35I+eBc5+zoLj7HJjYbQYBCxwEgMPBC9OgGsYKjEpG6bXbsFwymqty5Z6wKZ
         u8v4vs2KBY7tsC66kjmD+bE7/HpLUqwmCWwC4R4E7EZwEcLD0KGljTXYffu/JPntzobd
         7oYW/xkSC30iF4ayesuRCbkTD0oaKFucfFTsPAYB8GLuMiVxCiz02UkTOmabGMUbVDlX
         g74g==
X-Gm-Message-State: ANoB5pk21klj1RAuXqPhOKqJpsw6IKevxL8OnhZSBHI2r0p+oM/Hh272
        nmj3OA3byHjGDKRlp9jRB9wnaA==
X-Google-Smtp-Source: AA0mqf4xpqgTNAewBqQQbDNtHW/KT0dvyKzC+cxtlidQwz+InFcHq6stH1xbVHxbvOev3fhSnrTx2w==
X-Received: by 2002:a5d:6746:0:b0:22e:39c9:a4a6 with SMTP id l6-20020a5d6746000000b0022e39c9a4a6mr7215384wrw.170.1668876273378;
        Sat, 19 Nov 2022 08:44:33 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 23-20020a05600c229700b003cf75213bb9sm12312220wmf.8.2022.11.19.08.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 08:44:32 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     agross@kernel.org, andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 3/3] arm64: dts: qcom: sc8280xp: Add soundcard support
Date:   Sat, 19 Nov 2022 16:44:25 +0000
Message-Id: <20221119164425.86014-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221119164425.86014-1-srinivas.kandagatla@linaro.org>
References: <20221119164425.86014-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for SoundCard on X13s. This patch adds support for Headset
Playback, record and 2 DMICs on the Panel along with the regulators
required for powering up the LPASS codecs.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 217 ++++++++++++++++++
 1 file changed, 217 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index b2b744bb8a53..f1f93fc4fa2d 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -58,6 +58,16 @@ vreg_misc_3p3: regulator-misc-3p3 {
 		regulator-boot-on;
 		regulator-always-on;
 	};
+
+	vreg_vph_pwr: regulator-vph-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "VPH_VCC3R9";
+		regulator-min-microvolt = <3900000>;
+		regulator-max-microvolt = <3900000>;
+
+		regulator-always-on;
+		regulator-boot-on;
+	};
 };
 
 &apps_rsc {
@@ -67,6 +77,13 @@ pmc8280-1-rpmh-regulators {
 
 		vdd-l3-l5-supply = <&vreg_s11b>;
 
+		vreg_s10b: smps10 {
+			regulator-name = "vreg_s10b";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
 		vreg_s11b: smps11 {
 			regulator-name = "vreg_s11b";
 			regulator-min-microvolt = <1272000>;
@@ -74,6 +91,13 @@ vreg_s11b: smps11 {
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
+		vreg_s12b: smps12 {
+			regulator-name = "vreg_s12b";
+			regulator-min-microvolt = <984000>;
+			regulator-max-microvolt = <984000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
 		vreg_l3b: ldo3 {
 			regulator-name = "vreg_l3b";
 			regulator-min-microvolt = <1200000>;
@@ -102,6 +126,7 @@ vreg_l6b: ldo6 {
 	pmc8280c-rpmh-regulators {
 		compatible = "qcom,pm8350c-rpmh-regulators";
 		qcom,pmic-id = "c";
+		vdd-bob-supply = <&vreg_vph_pwr>;
 
 		vreg_l1c: ldo1 {
 			regulator-name = "vreg_l1c";
@@ -123,6 +148,13 @@ vreg_l13c: ldo13 {
 			regulator-max-microvolt = <3072000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
+
+		vreg_bob: bob {
+			regulator-name = "vreg_bob";
+			regulator-min-microvolt = <3008000>;
+			regulator-max-microvolt = <3960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
+		};
 	};
 
 	pmc8280-2-rpmh-regulators {
@@ -346,6 +378,163 @@ edp_bl_pwm: edp-bl-pwm-state {
 	};
 };
 
+&soc {
+	wcd938x: codec {
+		compatible = "qcom,wcd9380-codec";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wcd_default>;
+		reset-gpios = <&tlmm 106 GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <1>;
+
+		vdd-buck-supply = <&vreg_s10b>;
+		vdd-rxtx-supply = <&vreg_s10b>;
+		vdd-io-supply = <&vreg_s10b>;
+		vdd-mic-bias-supply = <&vreg_bob>;
+		qcom,micbias1-microvolt = <1800000>;
+		qcom,micbias2-microvolt = <1800000>;
+		qcom,micbias3-microvolt = <1800000>;
+		qcom,micbias4-microvolt = <1800000>;
+		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
+		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
+		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
+		qcom,rx-device = <&wcd_rx>;
+		qcom,tx-device = <&wcd_tx>;
+	};
+};
+
+&sound {
+	compatible = "qcom,sc8280xp-sndcard";
+	model = "SC8280XP-LENOVO-X13S";
+	audio-routing =
+		"SpkrLeft IN", "WSA_SPK1 OUT",
+		"SpkrRight IN", "WSA_SPK2 OUT",
+		"IN1_HPHL", "HPHL_OUT",
+		"IN2_HPHR", "HPHR_OUT",
+		"AMIC2", "MIC BIAS2",
+		"VA DMIC0", "MIC BIAS1",
+		"VA DMIC1", "MIC BIAS1",
+		"VA DMIC2", "MIC BIAS3",
+		"TX DMIC0", "MIC BIAS1",
+		"TX DMIC1", "MIC BIAS2",
+		"TX DMIC2", "MIC BIAS3",
+		"TX SWR_ADC1", "ADC2_OUTPUT";
+
+	wcd-playback-dai-link {
+		link-name = "WCD Playback";
+		cpu {
+			sound-dai = <&q6apmbedai RX_CODEC_DMA_RX_0>;
+		};
+
+		codec {
+			sound-dai = <&wcd938x 0>, <&swr1 0>, <&rxmacro 0>;
+		};
+
+		platform {
+			sound-dai = <&q6apm>;
+		};
+	};
+
+	wcd-capture-dai-link {
+		link-name = "WCD Capture";
+		cpu {
+			sound-dai = <&q6apmbedai TX_CODEC_DMA_TX_3>;
+		};
+
+		codec {
+			sound-dai = <&wcd938x 1>, <&swr2 0>, <&txmacro 0>;
+		};
+
+		platform {
+			sound-dai = <&q6apm>;
+		};
+	};
+
+	wsa-dai-link {
+		link-name = "WSA Playback";
+		cpu {
+			sound-dai = <&q6apmbedai WSA_CODEC_DMA_RX_0>;
+		};
+
+		codec {
+			sound-dai = <&left_spkr>, <&right_spkr>, <&swr0 0>, <&wsamacro 0>;
+		};
+
+		platform {
+			sound-dai = <&q6apm>;
+		};
+	};
+
+	va-dai-link {
+		link-name = "VA Capture";
+		cpu {
+			sound-dai = <&q6apmbedai TX_CODEC_DMA_TX_3>;
+		};
+
+		platform {
+			sound-dai = <&q6apm>;
+		};
+
+		codec {
+			sound-dai = <&vamacro 0>;
+		};
+	};
+};
+
+&swr0 {
+	left_spkr: wsa8830-left@0,1 {
+		compatible = "sdw10217020200";
+		reg = <0 1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&spkr_1_sd_n_default>;
+		powerdown-gpios = <&tlmm 178 GPIO_ACTIVE_LOW>;
+		#thermal-sensor-cells = <0>;
+		sound-name-prefix = "SpkrLeft";
+		#sound-dai-cells = <0>;
+		vdd-supply = <&vreg_s10b>;
+	};
+
+	right_spkr: wsa8830-right@0,2{
+		compatible = "sdw10217020200";
+		reg = <0 2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&spkr_2_sd_n_default>;
+		powerdown-gpios = <&tlmm 179 GPIO_ACTIVE_LOW>;
+		#thermal-sensor-cells = <0>;
+		sound-name-prefix = "SpkrRight";
+		#sound-dai-cells = <0>;
+		vdd-supply = <&vreg_s10b>;
+	};
+};
+
+
+&swr1 {
+	status = "okay";
+
+	wcd_rx: wcd9380-rx@0,4 {
+		compatible = "sdw20217010d00";
+		reg = <0 4>;
+		qcom,rx-port-mapping = <1 2 3 4 5 6>;
+
+	};
+};
+
+&swr2 {
+	status = "okay";
+
+	wcd_tx: wcd9380-tx@0,3 {
+		compatible = "sdw20217010d00";
+		reg = <0 3>;
+		qcom,tx-port-mapping = <1 1 2 3>;
+	};
+};
+
+&vamacro {
+	pinctrl-0 = <&dmic01_default>, <&dmic02_default>;
+	pinctrl-names = "default";
+	vdd-micb-supply = <&vreg_s10b>;
+	qcom,dmic-sample-rate = <600000>;
+};
+
 &tlmm {
 	gpio-reserved-ranges = <70 2>, <74 6>, <83 4>, <125 2>, <128 2>, <154 7>;
 
@@ -369,6 +558,14 @@ reset {
 		};
 	};
 
+	wcd_default: wcd-default-state {
+		reset-pins {
+			pins = "gpio106";
+			function = "gpio";
+			bias-disable;
+		};
+	};
+
 	qup0_i2c4_default: qup0-i2c4-default-state {
 		pins = "gpio171", "gpio172";
 		function = "qup4";
@@ -383,6 +580,26 @@ qup2_i2c5_default: qup2-i2c5-default-state {
 		drive-strength = <16>;
 	};
 
+	spkr_1_sd_n_default: spkr-1-sd-n-default-state {
+		perst-n-pins {
+			pins = "gpio178";
+			function = "gpio";
+			drive-strength = <16>;
+			bias-disable;
+			output-high;
+		};
+	};
+
+	spkr_2_sd_n_default: spkr-2-sd-n-default-state {
+		perst-n-pins {
+			pins = "gpio179";
+			function = "gpio";
+			drive-strength = <16>;
+			bias-disable;
+			output-high;
+		};
+	};
+
 	tpad_default: tpad-default-state {
 		int-n {
 			pins = "gpio182";
-- 
2.25.1

