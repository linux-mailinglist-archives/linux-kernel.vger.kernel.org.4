Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5917149AA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 14:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjE2Mr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 08:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjE2MrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 08:47:19 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C76D8;
        Mon, 29 May 2023 05:47:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685364425; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=NQbDS+ZcMPBOIraFHREPjuyEeEoXCcvInprgV4TZ16yYmC9paLseGMxv8QKbTYsv58
    KMI3NIl4lKWe0ru8VicIYPdolZapwR7/0S6FEcuD1eB0DrpaWf96Xjqk+5nbUeyA3PPU
    N1pKNll4gHGKEPcCCg1spC5UyQGwcV5qBM+p1WkOgud/XklwntmpPyKmo5WhWxxeEuQ2
    u7ThxmjjLGFhxPNlFvWvsmU5erAz3eoXzWz4lc5DKwG1QlM72JNmH73LB86tJps9ZK/L
    DtOz7v8mPj7scVZlXHRjMMfLI0Pfp8kblFL8OMp5+S3yoTjC/6YvEgYd+jKKjvKsR+VX
    peQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685364425;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=oCE7duxpJ+L+TbayDAFlqf4orcOYvvGX1dSAeHvQNfU=;
    b=C6ws3eoFV1haKvDkZJIJsTFhihG+RJZXomUiyz4YT8Oz1C3aD6atGroW9Ayv2RjIUY
    gISiQknvGmNCH6AKnlg/O9hkOg9ggBq3HHYSecDS4rlig0EoYh2uXvCMRYybyiyTfBow
    +sWT7LZsXLx0Kv9TR/qgqdVk2TtDAqnKt2zEIDWrrOCmUt/TtSLtNySc7WyfDvlGbxO5
    h9tPQLKKcMIg6oxUjYbTfJ5zh5XGzKOT8XJlR/+CIwsImMJ28wR9JzqMtFz5Dhkr8QrM
    JoOD8vxBO8wMqg5qFN3uTeZfNdQGQ8fabxxpD/Cy7Cgzu75VOwhWhm9hPjcbHlrd5MWL
    s1vw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685364425;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=oCE7duxpJ+L+TbayDAFlqf4orcOYvvGX1dSAeHvQNfU=;
    b=QyrXAoAzHU9STw9Dfxgbnxm2DHfyQewcZyVcLT4pS6qZl+hqSq2wbNulWbqJhQMAdb
    Jo1gYC17zxjpgOBKYkzYrxTvEoaeneqfeNhTlMrnim9KMB9NJglY9Fa8Lc53flKa+7KB
    8/t4JZahul187e3Rb+iOQX6Inag6syDl5x8xY7XRQ6QWYDiIJThqGUpQ3jvkEZxkaBEw
    jHmCUcmsiGtDs5iCC76eRWYX0SNurqvbTfVN2alcMPaGE7bggqv6stQhmcEr5sePBShz
    Rc/XQ5rdkr4bdLC7ORyEJOsK+BaBBJAgb7aUL2N+/fn7VJxrJd1bvnLBvxI3Q4FQwnNx
    +vWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685364425;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=oCE7duxpJ+L+TbayDAFlqf4orcOYvvGX1dSAeHvQNfU=;
    b=7ryxh1lorBRz3iCuCbL9tBo7SWLaxymZTV4n1sCao8RPR0pfBP5w34OI8qhyh+19Wa
    5b5B5y7QjYnwlR8FeqAw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOH8mT0="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4TCl5f8Y
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 29 May 2023 14:47:05 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Mon, 29 May 2023 14:47:02 +0200
Subject: [PATCH 5/6] arm64: dts: qcom: pm8916: Rename &wcd_codec ->
 &pm8916_codec
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230525-msm8916-labels-v1-5-bec0f5fb46fb@gerhold.net>
References: <20230525-msm8916-labels-v1-0-bec0f5fb46fb@gerhold.net>
In-Reply-To: <20230525-msm8916-labels-v1-0-bec0f5fb46fb@gerhold.net>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All definitions in pm8916.dtsi use the &pm8916_ label suffix, only the
codec uses the &wcd_codec label. &wcd_codec is confusing because the
codec on MSM8916 is split into a "wcd-digital" and "wcd-analog" part
and both could be described with &wcd_codec.

Let's just name it &pm8916_codec so it's consistent with all other PMIC
device nodes.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts       | 20 ++++++++++----------
 arch/arm64/boot/dts/qcom/apq8039-t2.dts        | 18 +++++++++---------
 arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts | 20 ++++++++++----------
 arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi   | 12 ++++++------
 arch/arm64/boot/dts/qcom/pm8916.dtsi           |  2 +-
 5 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index 9081825c9574..923646766ef1 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -324,6 +324,14 @@ &mpss {
 	firmware-name = "qcom/apq8016/mba.mbn", "qcom/apq8016/modem.mbn";
 };
 
+&pm8916_codec {
+	status = "okay";
+	clocks = <&gcc GCC_CODEC_DIGCODEC_CLK>;
+	clock-names = "mclk";
+	qcom,mbhc-vthreshold-low = <75 150 237 450 500>;
+	qcom,mbhc-vthreshold-high = <75 150 237 450 500>;
+};
+
 &pm8916_resin {
 	status = "okay";
 	linux,code = <KEY_VOLUMEDOWN>;
@@ -403,7 +411,7 @@ cpu {
 			sound-dai = <&lpass MI2S_PRIMARY>;
 		};
 		codec {
-			sound-dai = <&lpass_codec 0>, <&wcd_codec 0>;
+			sound-dai = <&lpass_codec 0>, <&pm8916_codec 0>;
 		};
 	};
 
@@ -413,7 +421,7 @@ cpu {
 			sound-dai = <&lpass MI2S_TERTIARY>;
 		};
 		codec {
-			sound-dai = <&lpass_codec 1>, <&wcd_codec 1>;
+			sound-dai = <&lpass_codec 1>, <&pm8916_codec 1>;
 		};
 	};
 };
@@ -431,14 +439,6 @@ &usb_hs_phy {
 	extcon = <&usb_id>;
 };
 
-&wcd_codec {
-	status = "okay";
-	clocks = <&gcc GCC_CODEC_DIGCODEC_CLK>;
-	clock-names = "mclk";
-	qcom,mbhc-vthreshold-low = <75 150 237 450 500>;
-	qcom,mbhc-vthreshold-high = <75 150 237 450 500>;
-};
-
 &wcnss {
 	status = "okay";
 	firmware-name = "qcom/apq8016/wcnss.mbn";
diff --git a/arch/arm64/boot/dts/qcom/apq8039-t2.dts b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
index 07f4c6398b41..e783b0af355e 100644
--- a/arch/arm64/boot/dts/qcom/apq8039-t2.dts
+++ b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
@@ -139,6 +139,13 @@ &mdss {
 	status = "okay";
 };
 
+&pm8916_codec {
+	qcom,hphl-jack-type-normally-open;
+	qcom,mbhc-vthreshold-low = <75 150 237 450 500>;
+	qcom,mbhc-vthreshold-high = <75 150 237 450 500>;
+	status = "okay";
+};
+
 &pm8916_gpios {
 	gpio-line-names =
 		"PM_GPIO1",     /* WIFI_GPIO1_PRE */
@@ -265,7 +272,7 @@ cpu {
 			sound-dai = <&lpass MI2S_PRIMARY>;
 		};
 		codec {
-			sound-dai = <&lpass_codec 0>, <&wcd_codec 0>;
+			sound-dai = <&lpass_codec 0>, <&pm8916_codec 0>;
 		};
 	};
 
@@ -275,7 +282,7 @@ cpu {
 			sound-dai = <&lpass MI2S_TERTIARY>;
 		};
 		codec {
-			sound-dai = <&lpass_codec 1>, <&wcd_codec 1>;
+			sound-dai = <&lpass_codec 1>, <&pm8916_codec 1>;
 		};
 	};
 };
@@ -476,13 +483,6 @@ otg_ep: endpoint {
 	};
 };
 
-&wcd_codec {
-	qcom,hphl-jack-type-normally-open;
-	qcom,mbhc-vthreshold-low = <75 150 237 450 500>;
-	qcom,mbhc-vthreshold-high = <75 150 237 450 500>;
-	status = "okay";
-};
-
 &wcnss {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts b/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
index cbf53de44ef3..1334bfcf3cee 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
@@ -222,6 +222,14 @@ &lpass_codec {
 	status = "okay";
 };
 
+&pm8916_codec {
+	status = "okay";
+	qcom,micbias-lvl = <2800>;
+	qcom,mbhc-vthreshold-low = <75 150 237 450 500>;
+	qcom,mbhc-vthreshold-high = <75 150 237 450 500>;
+	qcom,hphl-jack-type-normally-open;
+};
+
 &pm8916_l8 {
 	regulator-min-microvolt = <2950000>;
 	regulator-max-microvolt = <2950000>;
@@ -298,7 +306,7 @@ cpu {
 			sound-dai = <&lpass MI2S_PRIMARY>;
 		};
 		codec {
-			sound-dai = <&lpass_codec 0>, <&wcd_codec 0>;
+			sound-dai = <&lpass_codec 0>, <&pm8916_codec 0>;
 		};
 	};
 
@@ -308,7 +316,7 @@ cpu {
 			sound-dai = <&lpass MI2S_TERTIARY>;
 		};
 		codec {
-			sound-dai = <&lpass_codec 1>, <&wcd_codec 1>;
+			sound-dai = <&lpass_codec 1>, <&pm8916_codec 1>;
 		};
 	};
 };
@@ -322,14 +330,6 @@ &usb_hs_phy {
 	extcon = <&usb_id>;
 };
 
-&wcd_codec {
-	status = "okay";
-	qcom,micbias-lvl = <2800>;
-	qcom,mbhc-vthreshold-low = <75 150 237 450 500>;
-	qcom,mbhc-vthreshold-high = <75 150 237 450 500>;
-	qcom,hphl-jack-type-normally-open;
-};
-
 &wcnss {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi
index 4e7289e6d22d..b1a7eafbee31 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi
@@ -28,6 +28,12 @@ &mpss {
 	pll-supply = <&pm8916_l7>;
 };
 
+&pm8916_codec {
+	vdd-cdc-io-supply = <&pm8916_l5>;
+	vdd-cdc-tx-rx-cx-supply = <&pm8916_l5>;
+	vdd-micbias-supply = <&pm8916_l13>;
+};
+
 &sdhc_1 {
 	vmmc-supply = <&pm8916_l8>;
 	vqmmc-supply = <&pm8916_l5>;
@@ -43,12 +49,6 @@ &usb_hs_phy {
 	v3p3-supply = <&pm8916_l13>;
 };
 
-&wcd_codec {
-	vdd-cdc-io-supply = <&pm8916_l5>;
-	vdd-cdc-tx-rx-cx-supply = <&pm8916_l5>;
-	vdd-micbias-supply = <&pm8916_l13>;
-};
-
 &wcnss {
 	vddpx-supply = <&pm8916_l7>;
 };
diff --git a/arch/arm64/boot/dts/qcom/pm8916.dtsi b/arch/arm64/boot/dts/qcom/pm8916.dtsi
index 864bb1cd68db..1ea8920ff369 100644
--- a/arch/arm64/boot/dts/qcom/pm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8916.dtsi
@@ -139,7 +139,7 @@ pm8916_vib: vibrator@c000 {
 			status = "disabled";
 		};
 
-		wcd_codec: audio-codec@f000 {
+		pm8916_codec: audio-codec@f000 {
 			compatible = "qcom,pm8916-wcd-analog-codec";
 			reg = <0xf000>;
 			reg-names = "pmic-codec-core";

-- 
2.40.1

