Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A466B7DAD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 17:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjCMQeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 12:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjCMQdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 12:33:52 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3284F23119
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 09:33:17 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id z42so13200861ljq.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 09:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678725185;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aeDTqpYrlEuhoUXI4F8sH20zpNB5C5a3olN6IJ1itsk=;
        b=IqO5XBrkP4LcNFJQGw6NEsp9eROq29iwspwRRjj/sphobyqS+meh/3vuDREn4U9R6E
         1SibD1wxrLnBD6GK6HMaNp3mhuMMfsEAkpVTCf1ek4pAIiF4bMEiN8gneTmmpiMcfvCo
         spH58lqSRXbKIA1xEyMBebk+PcveYLiSkyGtlFLx3tZqVYu4ol8RX/9tmi9amfDrs1WV
         lSYHTHtSbn2kar2DVQoRWrfURjUWglV84yIsflE2UrYtxLnFwVd/v9cMbwHUjeEnKibV
         oC5xLLumrwTkyb+ua9rucXOQwmiKPVRdGTQZvFPZi3q2M+Mf4EEf9K3mHX4mpaflv1Og
         FBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678725185;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aeDTqpYrlEuhoUXI4F8sH20zpNB5C5a3olN6IJ1itsk=;
        b=ip47NXvkVTcvgkcFtxmUyqp740Wi6bUKTKmBjByU5jgogOzr9yfVKgE2R05Emv2XMm
         2rHQyiR7udY81iCs+UcLy7tt1zaZZ/POC7OGsbjtCLIVft0NewTNXJfpbT1NOm++Wa/8
         nvVXzoOjR+vBbd3Z23nZSBlzJsN1lYB/SXBI8Fh1BqQ9Vr/7uq7N8PE3QtAFpXCpwoCO
         OL6hCxtH8h6z3dN1g6B6Nlp8b8FcE1gigoPi6FCDaDfdao5rJ/AquA7cPBOA/wE25LOS
         DkhtSndwnPb9kr1nWa0IhM+ZhU+3oQ4I2eIQ2wA8y+xNET5LmY9rz2zx0OozmY6HEsBN
         pUtA==
X-Gm-Message-State: AO0yUKUDNjb/cKoxtYo3umS/d4AczTxSgurIBg7ZTTXyDU41if17subl
        SJi6qXxhtCkExgGlqc2FGaLguA==
X-Google-Smtp-Source: AK7set/vA1etLpBGO+oWE50piwazpDW+XUBBMbAFXpuF3mteVPJ4rDhVL/pom0mJIcwemhka8zV3LA==
X-Received: by 2002:a2e:8894:0:b0:295:9c8e:2428 with SMTP id k20-20020a2e8894000000b002959c8e2428mr10477512lji.35.1678725185798;
        Mon, 13 Mar 2023 09:33:05 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id q62-20020a2e5c41000000b00295765966d9sm57417ljb.86.2023.03.13.09.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 09:33:05 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 13 Mar 2023 17:32:36 +0100
Subject: [PATCH v2 1/6] arm64: dts: qcom: sdm845-tama: Add display nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230313-topic-tama_disp-v2-1-37ececf43770@linaro.org>
References: <20230313-topic-tama_disp-v2-0-37ececf43770@linaro.org>
In-Reply-To: <20230313-topic-tama_disp-v2-0-37ececf43770@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678725183; l=5953;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=gi5TYyCK8LCeQTNbOf59KMyqJE30CmsOmZNp3LJn1UQ=;
 b=3cQzviDZNCW5N7aT6mcc8F7D3kDINELpygCs0qDPwpBGopgsvWNNbuBTTd7EcwH8LRTUkhQWe4oF
 aBR1WJEaBz6lb5NRU91HSProQPAYUkOvIBOMxYw/+qIGK7Rss8Y6
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konrad Dybcio <konrad.dybcio@somainline.org>

Add required nodes to support display on XZ2/XZ2c. XZ3 has a
different power rail setup and needs to be handled separately.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../dts/qcom/sdm845-sony-xperia-tama-akari.dts     |  4 +
 .../dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts  | 44 +++++++++-
 .../dts/qcom/sdm845-sony-xperia-tama-apollo.dts    |  6 ++
 .../boot/dts/qcom/sdm845-sony-xperia-tama.dtsi     | 96 ++++++++++++++++++++++
 4 files changed, 149 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akari.dts b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akari.dts
index 34f84f1f1eb4..d97b7f1e7140 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akari.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akari.dts
@@ -11,3 +11,7 @@ / {
 	model = "Sony Xperia XZ2";
 	compatible = "sony,akari-row", "qcom,sdm845";
 };
+
+&panel {
+	compatible = "sony,td4353-jdi-tama";
+};
diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts
index 2f5e12deaada..81cbf535cb76 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts
@@ -10,9 +10,51 @@
 / {
 	model = "Sony Xperia XZ3";
 	compatible = "sony,akatsuki-row", "qcom,sdm845";
+
+	/* Fixed DCDC for the OLED panel */
+	ts_vddio_supply: ts-vddio-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "ts_vddio";
+
+		regulator-min-microvolt = <1840000>;
+		regulator-max-microvolt = <1840000>;
+
+		gpio = <&tlmm 133 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-boot-on;
+	};
+};
+
+&ibb {
+	status = "disabled";
+};
+
+&lab {
+	status = "disabled";
+};
+
+&panel {
+	/* Akatsuki uses an OLED panel. */
+	/delete-property/ backlight;
+	/delete-property/ vsp-supply;
+	/delete-property/ vsn-supply;
+	/delete-property/ touch-reset-gpios;
+};
+
+&pmi8998_wled {
+	status = "disabled";
+};
+
+&tlmm {
+	ts_vddio_en: ts-vddio-en-state {
+		pins = "gpio133";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		output-high;
+	};
 };
 
-/* For the future: WLED + LAB/IBB/OLEDB are not used on Akatsuki */
 &vreg_l14a_1p8 {
 	regulator-min-microvolt = <1840000>;
 	regulator-max-microvolt = <1840000>;
diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-apollo.dts b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-apollo.dts
index c9e62c72f60e..cd056f78070f 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-apollo.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-apollo.dts
@@ -11,3 +11,9 @@ / {
 	model = "Sony Xperia XZ2 Compact";
 	compatible = "sony,apollo-row", "qcom,sdm845";
 };
+
+&panel {
+	compatible = "sony,td4353-jdi-tama";
+	height-mm = <112>;
+	width-mm = <56>;
+};
diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
index 4984c7496c31..ac0dfb383892 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
@@ -356,6 +356,46 @@ vreg_s3c_0p6: smps3 {
 	};
 };
 
+&dsi0 {
+	vdda-supply = <&vreg_l26a_1p2>;
+	status = "okay";
+
+	panel: panel@0 {
+		/* The compatible is assigned in device DTs. */
+		reg = <0>;
+
+		backlight = <&pmi8998_wled>;
+		vddio-supply = <&vreg_l14a_1p8>;
+		vsp-supply = <&lab>;
+		vsn-supply = <&ibb>;
+		panel-reset-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
+		touch-reset-gpios = <&tlmm 99 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&sde_dsi_active &sde_te_active_sleep>;
+		pinctrl-1 = <&sde_dsi_sleep &sde_te_active_sleep>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&dsi0_out>;
+			};
+		};
+	};
+};
+
+&dsi0_out {
+	remote-endpoint = <&panel_in>;
+	data-lanes = <0 1 2 3>;
+};
+
+&dsi0_phy {
+	vdds-supply = <&vreg_l1a_0p9>;
+	status = "okay";
+};
+
 &gcc {
 	protected-clocks = <GCC_QSPI_CORE_CLK>,
 			<GCC_QSPI_CORE_CLK_SRC>,
@@ -388,6 +428,31 @@ &i2c14 {
 	/* AMS TCS3490 RGB+IR color sensor @ 72 */
 };
 
+&ibb {
+	qcom,discharge-resistor-kohms = <300>;
+	regulator-min-microvolt = <5500000>;
+	regulator-max-microvolt = <5700000>;
+	regulator-min-microamp = <0>;
+	regulator-max-microamp = <800000>;
+	regulator-over-current-protection;
+	regulator-soft-start;
+	regulator-pull-down;
+};
+
+&lab {
+	regulator-min-microvolt = <5500000>;
+	regulator-max-microvolt = <5700000>;
+	regulator-min-microamp = <200000>;
+	regulator-max-microamp = <200000>;
+	regulator-over-current-protection;
+	regulator-soft-start;
+	regulator-pull-down;
+};
+
+&mdss {
+	status = "okay";
+};
+
 &pm8998_gpios {
 	focus_n: focus-n-state {
 		pins = "gpio2";
@@ -422,6 +487,16 @@ snapshot_n: snapshot-n-state {
 	};
 };
 
+&pmi8998_wled {
+	default-brightness = <800>;
+	qcom,switching-freq = <800>;
+	qcom,ovp-millivolt = <29600>;
+	qcom,current-boost-limit = <970>;
+	qcom,current-limit-microamp = <20000>;
+	qcom,enabled-strings = <0 1 2 3>;
+	status = "okay";
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
@@ -465,6 +540,27 @@ data-pins {
 			bias-pull-up;
 		};
 	};
+
+	sde_dsi_active: sde-dsi-active-state {
+		pins = "gpio6", "gpio52";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-disable;
+	};
+
+	sde_dsi_sleep: sde-dsi-sleep-state {
+		pins = "gpio6", "gpio52";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	sde_te_active_sleep: sde-te-active-sleep-state {
+		pins = "gpio10";
+		function = "mdp_vsync";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
 };
 
 &uart6 {

-- 
2.39.2

