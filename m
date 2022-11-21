Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79951632316
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 14:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiKUNEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 08:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiKUNEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:04:23 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A537140936
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 05:04:21 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id g12so19724372wrs.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 05:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JTMxU+6gfRPvxZA59rbrUjR3s8BRx+fpfpTMx5IUg4=;
        b=kYRi09O4jMyvtQMcpFEVv+DDGspQBWH7zGviGjCMIAcjarbUS1gGLq61SvS+ZzLV1T
         JzE0ZEQPK/9FoH28jK0KaFvRMjBwus853Gu9fqI7hZxacQ9pmyNwJ+IM9a31TmQ0cDM8
         570Pwfoc67fJN9pb5L4W6KC2qCVo6w+C90pJfiWE+y4wQJwsLL22lSRicnXXrAe/pY9w
         HNVthFNcb/Hp0VYKPh6n3ISKv8Tk5iBqrMMmXcZhpNCCbi0fVmX2iFHP5W6MgEcrYVaJ
         GGsjvU4DhhuFZGUBmAotz4cZ/rpPD43qTLUFHRyaRBJURGrFJljiy+tWAYjCI6Ng0ez3
         rbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8JTMxU+6gfRPvxZA59rbrUjR3s8BRx+fpfpTMx5IUg4=;
        b=Z9T2yUEDQ4mmfYoDK5X+W4+AVW4/gDcCaPBALWCxzMcXProbQPljEwyXOWCR2YhXHU
         94uHxZilInXUJwnKURCXotX3JhEHrdBPCLZT6CcXgPp9652fXsmX3msFRuAyjaAIfFqc
         hjRq60uAHFSVxktsf5OpGk7Me7gBkDgG9FL3Jd+Rapz2BtXt/YVhGr5BstbKJbbYGlP2
         gBPFL70KPsM5Sqr0dMEKWcIv2YqUMbVaLM7qWLtPmCmAKRmClRNJPSAT0iXQMzauYfJo
         LFLQ9Tex2LpS7lgQKxymbvwKVx7e3BEhB2qEh8xlfL+jSY9pu5RTcUMJnvD1qoYoByBe
         w2Hw==
X-Gm-Message-State: ANoB5pl6HioHOMsGm6Rbs5SffViU8optP1xRQhMjRKa9UyRn+TozdUUG
        kBzh2Rl7YjqIuB4xECItLkBo2w==
X-Google-Smtp-Source: AA0mqf4R9hDYMQjc2bmedtpvyefpFFaRyELlTtys6lBQsksmrbw8BZzkzR34uFNdw1IPuwxQtzP4Mg==
X-Received: by 2002:adf:de0a:0:b0:241:cdf6:6a81 with SMTP id b10-20020adfde0a000000b00241cdf66a81mr1045965wrm.243.1669035860013;
        Mon, 21 Nov 2022 05:04:20 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id a13-20020a5d53cd000000b002383edcde09sm11133898wrw.59.2022.11.21.05.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 05:04:19 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     agross@kernel.org, andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 3/3] arm64: dts: qcom: sc8280xp-x13s: Add soundcard support
Date:   Mon, 21 Nov 2022 13:04:03 +0000
Message-Id: <20221121130403.161817-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221121130403.161817-1-srinivas.kandagatla@linaro.org>
References: <20221121130403.161817-1-srinivas.kandagatla@linaro.org>
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
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 213 ++++++++++++++++++
 1 file changed, 213 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 568c6be1ceaa..eefa22ea1ed7 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -172,6 +172,14 @@ vreg_wwan: regulator-wwan {
 
 		regulator-boot-on;
 	};
+
+	vreg_vph_pwr: regulator-vph-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "VPH_VCC3R9";
+		regulator-min-microvolt = <3900000>;
+		regulator-max-microvolt = <3900000>;
+		regulator-always-on;
+	};
 };
 
 &apps_rsc {
@@ -181,6 +189,13 @@ pmc8280-1-rpmh-regulators {
 
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
@@ -188,6 +203,13 @@ vreg_s11b: smps11 {
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
@@ -216,6 +238,7 @@ vreg_l6b: ldo6 {
 	pmc8280c-rpmh-regulators {
 		compatible = "qcom,pm8350c-rpmh-regulators";
 		qcom,pmic-id = "c";
+		vdd-bob-supply = <&vreg_vph_pwr>;
 
 		vreg_l1c: ldo1 {
 			regulator-name = "vreg_l1c";
@@ -237,6 +260,13 @@ vreg_l13c: ldo13 {
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
@@ -596,6 +626,161 @@ &remoteproc_nsp0 {
 	status = "okay";
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
+&swr1 {
+	status = "okay";
+
+	wcd_rx: wcd9380-rx@0,4 {
+		compatible = "sdw20217010d00";
+		reg = <0 4>;
+		qcom,rx-port-mapping = <1 2 3 4 5>;
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
 &usb_0 {
 	status = "okay";
 };
@@ -808,6 +993,26 @@ qup2_i2c5_default: qup2-i2c5-default-state {
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
 		int-n-pins {
 			pins = "gpio182";
@@ -830,4 +1035,12 @@ reset-n-pins {
 			drive-strength = <16>;
 		};
 	};
+
+	wcd_default: wcd-default-state {
+		reset-pins {
+			pins = "gpio106";
+			function = "gpio";
+			bias-disable;
+		};
+	};
 };
-- 
2.25.1

