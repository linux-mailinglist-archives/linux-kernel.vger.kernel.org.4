Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758206B964F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjCNNcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjCNNcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:32:04 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEF5A9DF9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:28:47 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id f18so20049639lfa.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678800521;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=On0Sn5ODlBIWJUId5IrSccw6/czdShXkavsZLO1moks=;
        b=JOEK6IsqR9hXgwXOUVjAuX20RouL0XkQwE8y3nDJogyDQmg37O4J7Us6Uccr7+3t8D
         xU+YDQps2TlWspFxK0SGXkbCZMA7ujRmT5lE+Slo+PvPZH82MsMCAEfzdvW+w17Xmyc5
         n6l5LhcoE2J4BMhCiESpIc2ZvDX69cLMEQhfoUvjqB62LZby6mcT1ZmJhhWN2GWXE1H3
         KJSiQmeQ6VA4YzZdNOC0UZ21T5pYVupu03KY9SfFGFrYiHBT8FNQWCSQFLKQgbsJX/eK
         nVldWFqCcA5sK0j6n85igX/cxWnWzZGdV1Njay9sh1EOD5x9d09VtNHLShFG4TRx2s2o
         4osA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678800521;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=On0Sn5ODlBIWJUId5IrSccw6/czdShXkavsZLO1moks=;
        b=CTZS3aa8ZVe3aIsLacoUtng0hPVE3PJ85yqTcxy9kLsXUBZ4sMZ34XfwSJFd9D2uLp
         jIjMQppBB9CUhIjvzs8opb9vJcKQ82SEWkp3M6D9pDN+NveP+EI/HJquwJPxkGPd7bNj
         9s6i40Wmm80K2ycG2RA8uTxbmhQTZkfCGnuv9m9JOFznObeMiZ4bCxGkEGfdkaF55GdQ
         YR543k1kfmMxySSBKBjhIVbTj5pqeUTXnJ8bZZN+wLzxA4Q2+AvlWBMFDHvKhjVQetIe
         N0neaCiOehY4LDpmDy+fMYTdMxwDp6/L2VpkbbVZWyLsaBo4S7l7hyU3O2WYAJSTFhO5
         pUWw==
X-Gm-Message-State: AO0yUKU9zDfstp+z7gGAJUB8OBHqXjrpJZgKTvymNvmMfKFuKFU12o+O
        zu0unfOMoNQPNV3lvxc1akJYYw==
X-Google-Smtp-Source: AK7set/cD5weaLXxuOZOEunDt8gdT/nazgj8O5ojnseb5rU4WoJc/yH6mZMJD/Ulc9uo7CswoukEKA==
X-Received: by 2002:ac2:4a8c:0:b0:4dc:4e1e:ebfc with SMTP id l12-20020ac24a8c000000b004dc4e1eebfcmr780195lfp.62.1678800520946;
        Tue, 14 Mar 2023 06:28:40 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id s9-20020a19ad49000000b004dda74eccafsm406012lfd.68.2023.03.14.06.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 06:28:40 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 14 Mar 2023 14:28:35 +0100
Subject: [PATCH v2 2/2] arm64: dts: qcom: msm8998-yoshino: Use actual pin
 names for pin nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230314-topic-yoshino_gpio-v2-2-4cb80e187e38@linaro.org>
References: <20230314-topic-yoshino_gpio-v2-0-4cb80e187e38@linaro.org>
In-Reply-To: <20230314-topic-yoshino_gpio-v2-0-4cb80e187e38@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678800516; l=7699;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=6GcliGblReeLYCni8H/SCTgW54WjlWd0vVAVmyIP5rE=;
 b=rHLQh38E+T2WXwZN1QAA9ypvdX2QiPKqp+tFP6vL2jqnGXaN1PxGwJRowAxcewVTzDkhrMcgimbY
 bcdROkFmDkMTC0VW48Z9DOab1Zj34fBv7Ahn/p+2F6Eg8e5gPXv4
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the gpio-line-names in place coming from SONY themselves, we can
now make the pin nodes and their labels to more closely resemble the
actual thing. 4k has been renamed to four_k due to dtc limitations.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../dts/qcom/msm8998-sony-xperia-yoshino-maple.dts |  4 +-
 .../boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi | 59 +++++++++++-----------
 2 files changed, 31 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-maple.dts b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-maple.dts
index 8b6a718835c7..055b6a643d82 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-maple.dts
+++ b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-maple.dts
@@ -22,7 +22,7 @@ disp_dvdd_vreg: disp-dvdd-vreg {
 		enable-active-high;
 		gpio = <&pmi8998_gpios 10 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&disp_dvdd_en>;
+		pinctrl-0 = <&four_k_disp_dcdc_en>;
 	};
 };
 
@@ -60,7 +60,7 @@ &pmi8998_gpios {
 			  "SPMI_I2C_SEL",
 			  "NC";
 
-	disp_dvdd_en: disp-dvdd-en-active-state {
+	four_k_disp_dcdc_en: 4k-disp-dcdc-en-state {
 		pins = "gpio10";
 		function = "normal";
 		bias-disable;
diff --git a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
index ede12a583236..5609c4a7d3c3 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
@@ -21,7 +21,7 @@ / {
 	clocks {
 		div1_mclk: divclk1 {
 			compatible = "gpio-gate-clock";
-			pinctrl-0 = <&audio_mclk_pin>;
+			pinctrl-0 = <&div_clk1>;
 			pinctrl-names = "default";
 			clocks = <&rpmcc RPM_SMD_DIV_CLK1>;
 			#clock-cells = <0>;
@@ -46,7 +46,7 @@ cam0_vdig_vreg: cam0-vdig {
 		enable-active-high;
 		gpio = <&tlmm 21 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&cam0_vdig_default>;
+		pinctrl-0 = <&main_cam_pwr_en>;
 	};
 
 	cam1_vdig_vreg: cam1-vdig {
@@ -56,7 +56,7 @@ cam1_vdig_vreg: cam1-vdig {
 		enable-active-high;
 		gpio = <&tlmm 25 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&cam1_vdig_default>;
+		pinctrl-0 = <&chat_cam_pwr_en>;
 		vin-supply = <&vreg_s3a_1p35>;
 	};
 
@@ -67,7 +67,7 @@ cam_vio_vreg: cam-vio-vreg {
 		enable-active-high;
 		gpio = <&pmi8998_gpios 1 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&cam_vio_default>;
+		pinctrl-0 = <&main_cam_pwr_io_en>;
 		vin-supply = <&vreg_lvs1a_1p8>;
 	};
 
@@ -92,15 +92,14 @@ extcon_usb: extcon-usb {
 		id-gpio = <&tlmm 38 GPIO_ACTIVE_HIGH>;
 		vbus-gpio = <&tlmm 128 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&usb_extcon_active &usb_vbus_active>;
+		pinctrl-0 = <&cc_dir_default &usb_detect_en>;
 	};
 
 	gpio-keys {
 		compatible = "gpio-keys";
 		label = "Side buttons";
 		pinctrl-names = "default";
-		pinctrl-0 = <&vol_down_pin_a>, <&cam_focus_pin_a>,
-			    <&cam_snapshot_pin_a>;
+		pinctrl-0 = <&vol_down_n &focus_n &snapshot_n>;
 		button-vol-down {
 			label = "Volume Down";
 			gpios = <&pm8998_gpios 5 GPIO_ACTIVE_LOW>;
@@ -131,7 +130,7 @@ gpio-hall-sensor {
 		compatible = "gpio-keys";
 		label = "Hall sensors";
 		pinctrl-names = "default";
-		pinctrl-0 = <&hall_sensor0_default>;
+		pinctrl-0 = <&acc_cover_open>;
 
 		event-hall-sensor0 {
 			label = "Cover Hall Sensor";
@@ -189,7 +188,7 @@ vibrator {
 		compatible = "gpio-vibrator";
 		enable-gpios = <&pmi8998_gpios 5 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&vib_default>;
+		pinctrl-0 = <&vib_ldo_en>;
 	};
 };
 
@@ -263,7 +262,7 @@ proximity@29 {
 		vdd-supply = <&cam_vio_vreg>;
 
 		pinctrl-names = "default";
-		pinctrl-0 = <&tof_int &tof_reset>;
+		pinctrl-0 = <&tof_int_n &tof_reset>;
 	};
 };
 
@@ -338,7 +337,7 @@ &pm8998_gpios {
 			  "OPTION_2 (DISALLOWED)",
 			  "PM_SLB (DISALLOWED)";
 
-	vol_down_pin_a: vol-down-active-state {
+	vol_down_n: vol-down-n-state {
 		pins = "gpio5";
 		function = PMIC_GPIO_FUNC_NORMAL;
 		bias-pull-up;
@@ -346,7 +345,7 @@ vol_down_pin_a: vol-down-active-state {
 		qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
 	};
 
-	cam_focus_pin_a: cam-focus-btn-active-state {
+	focus_n: focus-n-state {
 		pins = "gpio7";
 		function = PMIC_GPIO_FUNC_NORMAL;
 		bias-pull-up;
@@ -354,7 +353,7 @@ cam_focus_pin_a: cam-focus-btn-active-state {
 		qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
 	};
 
-	cam_snapshot_pin_a: cam-snapshot-btn-active-state {
+	snapshot_n: snapshot-n-state {
 		pins = "gpio8";
 		function = PMIC_GPIO_FUNC_NORMAL;
 		bias-pull-up;
@@ -362,7 +361,7 @@ cam_snapshot_pin_a: cam-snapshot-btn-active-state {
 		qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
 	};
 
-	audio_mclk_pin: audio-mclk-pin-active-state {
+	div_clk1: div-clk1-state {
 		pins = "gpio13";
 		function = "func2";
 		power-source = <0>;
@@ -385,7 +384,7 @@ &pmi8998_gpios {
 			  "SPMI_I2C_SEL",
 			  "NC";
 
-	cam_vio_default: cam-vio-active-state {
+	main_cam_pwr_io_en: main-cam-pwr-io-en-state {
 		pins = "gpio1";
 		function = PMIC_GPIO_FUNC_NORMAL;
 		bias-disable;
@@ -395,7 +394,7 @@ cam_vio_default: cam-vio-active-state {
 		power-source = <1>;
 	};
 
-	vib_default: vib-en-state {
+	vib_ldo_en: vib-ldo-en-state {
 		pins = "gpio5";
 		function = PMIC_GPIO_FUNC_NORMAL;
 		bias-disable;
@@ -790,7 +789,7 @@ &tlmm {
 			  "RFFE1_DATA",
 			  "RFFE1_CLK";
 
-	mdp_vsync_n: mdp-vsync-n-state {
+	mdp_vsync_p: mdp-vsync-p-state {
 		pins = "gpio10";
 		function = "mdp_vsync_a";
 		drive-strength = <2>;
@@ -805,14 +804,14 @@ nfc_ven: nfc-ven-state {
 		output-low;
 	};
 
-	msm_mclk0_default: msm-mclk0-active-state {
+	cam_mclk0_active: cam-mclk0-active-state {
 		pins = "gpio13";
 		function = "cam_mclk";
 		drive-strength = <2>;
 		bias-disable;
 	};
 
-	msm_mclk1_default: msm-mclk1-active-state {
+	cam_mclk1_active: cam-mclk1-active-state {
 		pins = "gpio14";
 		function = "cam_mclk";
 		drive-strength = <2>;
@@ -833,14 +832,14 @@ cci1_default: cci1-default-state {
 		drive-strength = <2>;
 	};
 
-	cam0_vdig_default: cam0-vdig-default-state {
+	main_cam_pwr_en: main-cam-pwr-en-default-state {
 		pins = "gpio21";
 		function = "gpio";
 		bias-disable;
 		drive-strength = <2>;
 	};
 
-	tof_int: tof-int-state {
+	tof_int_n: tof-int-n-state {
 		pins = "gpio22";
 		function = "gpio";
 		bias-pull-up;
@@ -848,28 +847,28 @@ tof_int: tof-int-state {
 		input-enable;
 	};
 
-	cam1_vdig_default: cam1-vdig-default-state {
+	chat_cam_pwr_en: chat-cam-pwr-en-default-state {
 		pins = "gpio25";
 		function = "gpio";
 		bias-disable;
 		drive-strength = <2>;
 	};
 
-	usb_extcon_active: usb-extcon-active-state {
-		pins = "gpio38";
+	tof_reset: tof-reset-state {
+		pins = "gpio27";
 		function = "gpio";
 		bias-disable;
-		drive-strength = <16>;
+		drive-strength = <2>;
 	};
 
-	tof_reset: tof-reset-state {
-		pins = "gpio27";
+	cc_dir_default: cc-dir-active-state {
+		pins = "gpio38";
 		function = "gpio";
 		bias-disable;
-		drive-strength = <2>;
+		drive-strength = <16>;
 	};
 
-	hall_sensor0_default: acc-cover-open-state {
+	acc_cover_open: acc-cover-open-state {
 		pins = "gpio124";
 		function = "gpio";
 		bias-disable;
@@ -884,7 +883,7 @@ ts_int_n: ts-int-n-state {
 		bias-pull-up;
 	};
 
-	usb_vbus_active: usb-vbus-active-state {
+	usb_detect_en: usb-detect-en-active-state {
 		pins = "gpio128";
 		function = "gpio";
 		bias-disable;

-- 
2.39.2

