Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E876CF35E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjC2Tm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjC2TmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:42:03 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0069D7682
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:41:33 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id h25so21639933lfv.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680118891;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Y1vep5MRfA4TA7L1eU5Bq6skz65ILYeD7nqdBGMCUM=;
        b=VVHxGMK+scnRi4nToWXmWXPNM9cNGkcZqY2gmk/UE4R36nIv8gcF6iA8ujYxjuElN8
         tdoATJ9HlytUxFHC/FkkkXpi5NqjXzk2VuewWfuctp4GLSMiOB4FS0ZET6TXq6jWemLo
         03gzOqawj3FPUdYdHQT5nDKx1ievmLcUhWD3QA1uQzEMdzZ9T/gP3S2Vp0xcq2SzAIEH
         +ZcV+C0nh2EuqX10Tt75HXjGKZoQCf6jRBIdhtEajeBMWOIHfHy+tle31NQaIzCCzNx4
         zHnl3zfIkQpNQLCa5NDbZ38tEHgregZ0jSQbDedQwLk0kvEv2v9p4H6Q/+2HWSXvySKM
         gOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680118891;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Y1vep5MRfA4TA7L1eU5Bq6skz65ILYeD7nqdBGMCUM=;
        b=7Bynj6F0qKzU7vDI7lJVxo4BYSrIroc99w1Um+nPz7Uy3fQYQE6azQDsWzk82ox92a
         QVuU7Kvo1HRfRcSZPpZiJpy2CKF4OenR7koI6+HXxfkf2ShQJWxc7ghvEfg1ewpVWzY5
         QfRNOBwRTA8YTQnMYiunvWYWO7rPSiJBuJGKRbsKpete9gd7TGky/nRocoFNkX22lPv2
         Z63RxIJh2LPvJy16wwzEEFl9b6uBSDQx6q6g56BJHo8MjSOVWBgZFVC2Mppk0dyRrK3b
         s7G1WEHTrQvdakw6Lu4d4JBARuWkkyx+dg6U0uSKvqezszWxiaOj+98VBH4uATLwNVfG
         kbYg==
X-Gm-Message-State: AAQBX9eTpq4xQrGct0vswZO8eC1sfy2QRvgHg6OC71q/lyahNsCeK4ut
        FoUrXlRDm0TsUHuVx/Jdyf2U6UdGWHuDU1VRV2A=
X-Google-Smtp-Source: AKy350aXYW2ggfmX8BYZmkdCWODhwlyijjV3RCFvL5JVly1Vq+fFyUCOyO8AlkLngK1E+5CBc3Rocg==
X-Received: by 2002:ac2:5318:0:b0:4ea:fa26:2378 with SMTP id c24-20020ac25318000000b004eafa262378mr5801650lfh.23.1680118890890;
        Wed, 29 Mar 2023 12:41:30 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id q22-20020ac25296000000b004eae672e96bsm3955048lfm.255.2023.03.29.12.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 12:41:30 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 29 Mar 2023 21:41:18 +0200
Subject: [PATCH v3 1/6] arm64: dts: qcom: sdm845-tama: Add display nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230313-topic-tama_disp-v3-1-2b1567c039d7@linaro.org>
References: <20230313-topic-tama_disp-v3-0-2b1567c039d7@linaro.org>
In-Reply-To: <20230313-topic-tama_disp-v3-0-2b1567c039d7@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680118888; l=5881;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=NA4JdwFCaJflBTxqU1PkjMiDYiTiaiqZBqyrG3vKNIU=;
 b=AASYwoBFDI3kH8sDzxt6hgKZz2QlsKcfSyNm3DGr50PIG3c4s6z0RPT066VsSkv99vP1AZU1wEx5
 8tzhUUAJCU2GSTpRghobkEIuPGbzlUPiW86i/PIMkWnOcSF0rqo0
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 .../boot/dts/qcom/sdm845-sony-xperia-tama.dtsi     | 93 ++++++++++++++++++++++
 4 files changed, 146 insertions(+), 1 deletion(-)

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
index 4984c7496c31..3c7d129d9d8e 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
@@ -356,6 +356,43 @@ vreg_s3c_0p6: smps3 {
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
+		pinctrl-0 = <&sde_dsi_active &sde_te_active_sleep>;
+		pinctrl-1 = <&sde_dsi_sleep &sde_te_active_sleep>;
+		pinctrl-names = "default", "sleep";
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
@@ -388,6 +425,31 @@ &i2c14 {
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
@@ -422,6 +484,16 @@ snapshot_n: snapshot-n-state {
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
@@ -465,6 +537,27 @@ data-pins {
 			bias-pull-up;
 		};
 	};
+
+	sde_dsi_active: sde-dsi-active-state {
+		pins = "gpio6";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-disable;
+	};
+
+	sde_dsi_sleep: sde-dsi-sleep-state {
+		pins = "gpio6";
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
2.40.0

