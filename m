Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3649B71565D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjE3HPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjE3HPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:15:46 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC7590;
        Tue, 30 May 2023 00:15:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685430935; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=fzFfNO45Xbujb2E6voW6py3+JNJxAtnfo4Zgo+xLaMaq8rubyfhGmXV9IIAye6tTLp
    XmzXsfAXlo+ZDQeS26UPitgGt42hu3z8fBUO/fH8irGe6MgFCI5CZMW3iINivkg16oKQ
    uiWT3/m+8vmuqq0ou0QapspEzIQsWGDwxiyHMee3oaVnniDl87VgGlAlLv+42WVkakil
    exbjlMuGbyw+EX4l8CaxB2z0AUvTNs8TcuYgEP6D0sojLFRYxyFo/XtEzeilCykzOlh2
    0AImzBApL4ZJJdMvgdqwfIp4mXkAKbCO2/4OB46NQYZGIabD5ioecWThZVdNrdBXnygK
    fZmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685430935;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=dRZtr79ErwnwuygFe8nM4s+Jbz3ePK61Tv55tWXTd80=;
    b=iTktMiKamMMdDRxvTTHDnLScb9sf9KI2NvqpFwIOIqCHnrtboZdgOtZGaXroV8KD/h
    K6ww5JBTyF3FT6hTPikLxpkqFAdEwYPI59Jps8XITcywntVkko7OfwWu1aelZ9WrK2Ed
    cChmXT637YF7rfj0IL6uS7KduNDA9LeTpPebKUqn2M4m7QHxPrzS5/QlrQBbgRxgPTEy
    Wa58C/P+s6/2mEJtVCAMzLgY+8sgrb/X10bavQeuqCZJfMTxKMpiO6Fy//ncprLyGM58
    1RfPVLPJty0emjug3QBQ0+Yr1EYcBdpGMG+ug6M2WP8+qJi7Mcgn3w8c+0wYPy8B4Cos
    Mrdg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685430935;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=dRZtr79ErwnwuygFe8nM4s+Jbz3ePK61Tv55tWXTd80=;
    b=Yp2P0TITzwbxCxV+StevGIft6X88/IohpdIuuyzBw1bP3FbiOH/OlMXmyDRQYbjRIt
    TXSvezCO09JSx6xM2KspUkHi75ni4OXw7vH0y6WcnS8VfDFu5Xp8gIdJi4zg5dzHsGRT
    symQft6I0csULM8X4wYu7ls8DDEpDDDNpJzsWo+gPT8p1/vOMXw+gMbq/b5NkMB5tEsO
    fNBhFmkHEGatyIMwV4PM9IJzHIg/RR2ynRKXkkZr7CHUFIJJq8jx+fsTp9rsml640vRO
    sV5G4nuyvBuOPjWGnA8agnJmby5uRizqiWDG83fxhD8dzEGpCB90eN/HYGLkO+jQn2EY
    87hA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685430935;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=dRZtr79ErwnwuygFe8nM4s+Jbz3ePK61Tv55tWXTd80=;
    b=P9QX7EUmNO3L9KNjJccaBHvFfMlYfX2yRQAOLVHEHXt+9xjEAKW85Id78E7PQKA6LU
    w89Hp2QhWsZrYEUniZBg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4xxmw=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4U7FZgY2
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 30 May 2023 09:15:35 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Tue, 30 May 2023 09:15:25 +0200
Subject: [PATCH 4/6] arm64: dts: qcom: msm8916/39: Cleanup audio pinctrl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230529-msm8916-pinctrl-v1-4-11f540b51c93@gerhold.net>
References: <20230529-msm8916-pinctrl-v1-0-11f540b51c93@gerhold.net>
In-Reply-To: <20230529-msm8916-pinctrl-v1-0-11f540b51c93@gerhold.net>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The audio pinctrl in MSM8916/MSM8939 is very similar but still has
subtle differences, e.g. &cdc_pdm_lines_act on MSM8916 vs
&cdc_pdm_lines_default on MSM8939.

Make this consistent and use the chance to cleanup all of the audio
pinctrl: Drop unneeded outer nodes and replace the names taken over
from the vendor kernel with more clear ones that are similar to the
actual pinctrl function.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts       |   4 +-
 arch/arm64/boot/dts/qcom/apq8039-t2.dts        |   4 +-
 arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts |   4 +-
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi     | 135 ++++++++++++-------------
 arch/arm64/boot/dts/qcom/msm8939.dtsi          | 133 ++++++++++++------------
 5 files changed, 133 insertions(+), 147 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index dad7586712da..f3d65a606194 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -385,8 +385,8 @@ &sdhc_2 {
 &sound {
 	status = "okay";
 
-	pinctrl-0 = <&cdc_pdm_lines_act &ext_sec_tlmm_lines_act>;
-	pinctrl-1 = <&cdc_pdm_lines_sus &ext_sec_tlmm_lines_sus>;
+	pinctrl-0 = <&cdc_pdm_default &sec_mi2s_default>;
+	pinctrl-1 = <&cdc_pdm_sleep &sec_mi2s_sleep>;
 	pinctrl-names = "default", "sleep";
 	model = "DB410c";
 	audio-routing =
diff --git a/arch/arm64/boot/dts/qcom/apq8039-t2.dts b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
index 107795bf7e5c..2a39216ceef5 100644
--- a/arch/arm64/boot/dts/qcom/apq8039-t2.dts
+++ b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
@@ -260,8 +260,8 @@ &sound {
 	model = "apq8039-square-sndcard";
 	audio-routing = "AMIC2", "MIC BIAS Internal2";
 	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&cdc_pdm_lines_default>;
-	pinctrl-1 = <&cdc_pdm_lines_sleep>;
+	pinctrl-0 = <&cdc_pdm_default>;
+	pinctrl-1 = <&cdc_pdm_sleep>;
 
 	internal-codec-playback-dai-link {
 		link-name = "WCD";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts b/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
index abd409f10cfe..4239c8fda11b 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
@@ -295,8 +295,8 @@ &sound {
 		"AMIC3", "MIC BIAS External1";
 
 	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&cdc_pdm_lines_act>;
-	pinctrl-1 = <&cdc_pdm_lines_sus>;
+	pinctrl-0 = <&cdc_pdm_default>;
+	pinctrl-1 = <&cdc_pdm_sleep>;
 
 	primary-dai-link {
 		link-name = "WCD";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
index cbf0f3d311af..2cfaed37cb59 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
@@ -374,95 +374,89 @@ data-pins {
 		};
 	};
 
-	cdc-pdm-lines-state {
-		cdc_pdm_lines_act: pdm-lines-on-pins {
-			pins = "gpio63", "gpio64", "gpio65", "gpio66",
-			       "gpio67", "gpio68";
-			function = "cdc_pdm0";
+	cdc_pdm_default: cdc-pdm-default-state {
+		pins = "gpio63", "gpio64", "gpio65", "gpio66",
+		       "gpio67", "gpio68";
+		function = "cdc_pdm0";
 
-			drive-strength = <8>;
-			bias-disable;
-		};
-		cdc_pdm_lines_sus: pdm-lines-off-pins {
-			pins = "gpio63", "gpio64", "gpio65", "gpio66",
-			       "gpio67", "gpio68";
-			function = "cdc_pdm0";
+		drive-strength = <8>;
+		bias-disable;
+	};
 
-			drive-strength = <2>;
-			bias-pull-down;
-		};
+	cdc_pdm_sleep: cdc-pdm-sleep-state {
+		pins = "gpio63", "gpio64", "gpio65", "gpio66",
+		       "gpio67", "gpio68";
+		function = "cdc_pdm0";
+
+		drive-strength = <2>;
+		bias-pull-down;
 	};
 
-	ext-pri-tlmm-lines-state {
-		ext_pri_tlmm_lines_act: ext-pa-on-pins {
-			pins = "gpio113", "gpio114", "gpio115", "gpio116";
-			function = "pri_mi2s";
+	pri_mi2s_default: mi2s-pri-default-state {
+		pins = "gpio113", "gpio114", "gpio115", "gpio116";
+		function = "pri_mi2s";
 
-			drive-strength = <8>;
-			bias-disable;
-		};
-		ext_pri_tlmm_lines_sus: ext-pa-off-pins {
-			pins = "gpio113", "gpio114", "gpio115", "gpio116";
-			function = "pri_mi2s";
+		drive-strength = <8>;
+		bias-disable;
+	};
 
-			drive-strength = <2>;
-			bias-disable;
-		};
+	pri_mi2s_sleep: mi2s-pri-sleep-state {
+		pins = "gpio113", "gpio114", "gpio115", "gpio116";
+		function = "pri_mi2s";
+
+		drive-strength = <2>;
+		bias-disable;
 	};
 
-	ext-pri-ws-line-state {
-		ext_pri_ws_act: ext-pa-on-pins {
-			pins = "gpio110";
-			function = "pri_mi2s_ws";
+	pri_mi2s_ws_default: mi2s-pri-ws-default-state {
+		pins = "gpio110";
+		function = "pri_mi2s_ws";
 
-			drive-strength = <8>;
-			bias-disable;
-		};
-		ext_pri_ws_sus: ext-pa-off-pins {
-			pins = "gpio110";
-			function = "pri_mi2s_ws";
+		drive-strength = <8>;
+		bias-disable;
+	};
 
-			drive-strength = <2>;
-			bias-disable;
-		};
+	pri_mi2s_ws_sleep: mi2s-pri-ws-sleep-state {
+		pins = "gpio110";
+		function = "pri_mi2s_ws";
+
+		drive-strength = <2>;
+		bias-disable;
 	};
 
-	ext-mclk-tlmm-lines-state {
-		ext_mclk_tlmm_lines_act: mclk-lines-on-pins {
-			pins = "gpio116";
-			function = "pri_mi2s";
+	pri_mi2s_mclk_default: mi2s-pri-mclk-default-state {
+		pins = "gpio116";
+		function = "pri_mi2s";
 
-			drive-strength = <8>;
-			bias-disable;
-		};
-		ext_mclk_tlmm_lines_sus: mclk-lines-off-pins {
-			pins = "gpio116";
-			function = "pri_mi2s";
+		drive-strength = <8>;
+		bias-disable;
+	};
 
-			drive-strength = <2>;
-			bias-disable;
-		};
+	pri_mi2s_mclk_sleep: mi2s-pri-mclk-sleep-state {
+		pins = "gpio116";
+		function = "pri_mi2s";
+
+		drive-strength = <2>;
+		bias-disable;
 	};
 
-	/* secondary Mi2S */
-	ext-sec-tlmm-lines-state {
-		ext_sec_tlmm_lines_act: tlmm-lines-on-pins {
-			pins = "gpio112", "gpio117", "gpio118", "gpio119";
-			function = "sec_mi2s";
+	sec_mi2s_default: mi2s-sec-default-state {
+		pins = "gpio112", "gpio117", "gpio118", "gpio119";
+		function = "sec_mi2s";
 
-			drive-strength = <8>;
-			bias-disable;
-		};
-		ext_sec_tlmm_lines_sus: tlmm-lines-off-pins {
-			pins = "gpio112", "gpio117", "gpio118", "gpio119";
-			function = "sec_mi2s";
+		drive-strength = <8>;
+		bias-disable;
+	};
 
-			drive-strength = <2>;
-			bias-disable;
-		};
+	sec_mi2s_sleep: mi2s-sec-sleep-state {
+		pins = "gpio112", "gpio117", "gpio118", "gpio119";
+		function = "sec_mi2s";
+
+		drive-strength = <2>;
+		bias-disable;
 	};
 
-	cdc_dmic_lines_act: cdc-dmic-lines-on-state {
+	cdc_dmic_default: cdc-dmic-default-state {
 		clk-pins {
 			pins = "gpio0";
 			function = "dmic0_clk";
@@ -476,7 +470,8 @@ data-pins {
 			drive-strength = <8>;
 		};
 	};
-	cdc_dmic_lines_sus: cdc-dmic-lines-off-state {
+
+	cdc_dmic_sleep: cdc-dmic-sleep-state {
 		clk-pins {
 			pins = "gpio0";
 			function = "dmic0_clk";
diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
index 1f79444bc250..de5f8681d18d 100644
--- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
@@ -969,23 +969,7 @@ cci0_default: cci0-default-state {
 				bias-disable;
 			};
 
-			cdc_pdm_lines_default: pdm-lines-default-state {
-				pins = "gpio63", "gpio64", "gpio65", "gpio66",
-				       "gpio67", "gpio68";
-				function = "cdc_pdm0";
-				drive-strength = <8>;
-				bias-disable;
-			};
-
-			cdc_pdm_lines_sleep: pdm-lines-suspend-state {
-				pins = "gpio63", "gpio64", "gpio65", "gpio66",
-				       "gpio67", "gpio68";
-				function = "cdc_pdm0";
-				drive-strength = <2>;
-				bias-pull-down;
-			};
-
-			cdc_dmic_lines_act: cdc-dmic-lines-on-state {
+			cdc_dmic_default: cdc-dmic-default-state {
 				clk-pins {
 					pins = "gpio0";
 					function = "dmic0_clk";
@@ -999,7 +983,7 @@ data-pins {
 				};
 			};
 
-			cdc_dmic_lines_sus: cdc-dmic-lines-off-state {
+			cdc_dmic_sleep: cdc-dmic-sleep-state {
 				clk-pins {
 					pins = "gpio0";
 					function = "dmic0_clk";
@@ -1015,69 +999,76 @@ data-pins {
 				};
 			};
 
-			ext-mclk-tlmm-lines-state {
-				ext_mclk_tlmm_lines_act: mclk-lines-on-pins {
-					pins = "gpio116";
-					function = "pri_mi2s";
-					drive-strength = <8>;
-					bias-disable;
-				};
+			cdc_pdm_default: cdc-pdm-default-state {
+				pins = "gpio63", "gpio64", "gpio65", "gpio66",
+				       "gpio67", "gpio68";
+				function = "cdc_pdm0";
+				drive-strength = <8>;
+				bias-disable;
+			};
 
-				ext_mclk_tlmm_lines_sus: mclk-lines-off-pins {
-					pins = "gpio116";
-					function = "pri_mi2s";
-					drive-strength = <2>;
-					bias-disable;
-				};
+			cdc_pdm_sleep: cdc-pdm-sleep-state {
+				pins = "gpio63", "gpio64", "gpio65", "gpio66",
+				       "gpio67", "gpio68";
+				function = "cdc_pdm0";
+				drive-strength = <2>;
+				bias-pull-down;
 			};
 
-			ext-pri-tlmm-lines-state {
-				ext_pri_tlmm_lines_act: ext-pa-on-pins {
-					pins = "gpio113", "gpio114", "gpio115", "gpio116";
-					function = "pri_mi2s";
-					drive-strength = <8>;
-					bias-disable;
-				};
+			pri_mi2s_default: mi2s-pri-default-state {
+				pins = "gpio113", "gpio114", "gpio115", "gpio116";
+				function = "pri_mi2s";
+				drive-strength = <8>;
+				bias-disable;
+			};
 
-				ext_pri_tlmm_lines_sus: ext-pa-off-pins {
-					pins = "gpio113", "gpio114", "gpio115", "gpio116";
-					function = "pri_mi2s";
-					drive-strength = <2>;
-					bias-disable;
-				};
+			pri_mi2s_sleep: mi2s-pri-sleep-state {
+				pins = "gpio113", "gpio114", "gpio115", "gpio116";
+				function = "pri_mi2s";
+				drive-strength = <2>;
+				bias-disable;
 			};
 
-			ext-pri-ws-line-state {
-				ext_pri_ws_act: ext-pa-on-pins {
-					pins = "gpio110";
-					function = "pri_mi2s_ws";
-					drive-strength = <8>;
-					bias-disable;
-				};
+			pri_mi2s_mclk_default: mi2s-pri-mclk-default-state {
+				pins = "gpio116";
+				function = "pri_mi2s";
+				drive-strength = <8>;
+				bias-disable;
+			};
 
-				ext_pri_ws_sus: ext-pa-off-pins {
-					pins = "gpio110";
-					function = "pri_mi2s_ws";
-					drive-strength = <2>;
-					bias-disable;
-				};
+			pri_mi2s_mclk_sleep: mi2s-pri-mclk-sleep-state {
+				pins = "gpio116";
+				function = "pri_mi2s";
+				drive-strength = <2>;
+				bias-disable;
 			};
 
-			/* secondary Mi2S */
-			ext-sec-tlmm-lines-state {
-				ext_sec_tlmm_lines_act: tlmm-lines-on-pins {
-					pins = "gpio112", "gpio117", "gpio118", "gpio119";
-					function = "sec_mi2s";
-					drive-strength = <8>;
-					bias-disable;
-				};
+			pri_mi2s_ws_default: mi2s-pri-ws-default-state {
+				pins = "gpio110";
+				function = "pri_mi2s_ws";
+				drive-strength = <8>;
+				bias-disable;
+			};
 
-				ext_sec_tlmm_lines_sus: tlmm-lines-off-pins {
-					pins = "gpio112", "gpio117", "gpio118", "gpio119";
-					function = "sec_mi2s";
-					drive-strength = <2>;
-					bias-disable;
-				};
+			pri_mi2s_ws_sleep: mi2s-pri-ws-sleep-state {
+				pins = "gpio110";
+				function = "pri_mi2s_ws";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			sec_mi2s_default: mi2s-sec-default-state {
+				pins = "gpio112", "gpio117", "gpio118", "gpio119";
+				function = "sec_mi2s";
+				drive-strength = <8>;
+				bias-disable;
+			};
+
+			sec_mi2s_sleep: mi2s-sec-sleep-state {
+				pins = "gpio112", "gpio117", "gpio118", "gpio119";
+				function = "sec_mi2s";
+				drive-strength = <2>;
+				bias-disable;
 			};
 
 			sdc1_default: sdc1-default-state {

-- 
2.40.1

