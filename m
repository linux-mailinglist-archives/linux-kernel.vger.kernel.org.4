Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277CA736A50
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 13:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbjFTLGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 07:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbjFTLFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:05:51 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1950100
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:05:49 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b4826ba943so23044631fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687259140; x=1689851140;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ToCmia0PXRpaSenikhacrjnmxFSrHT1/63mpMtPp/dU=;
        b=ZaYRGZzCQcqA0eB5LkknyimTp5qTWWEm3BSMUW6cH3+XYkqxxTeNaGvRG3dDQBWDSS
         15Tkkb6uqEDEA+xIgneoE3u02qqbGyCSXpXZux+SU3a8LYUxoHs18qU9crbOMJ/IOXiU
         6GC3sJLZNEKrmYO6+ueUaV2u4fGt3cOPrPoyO/fmWCU3venuMxzkyDFC4RIRlgtBwvqg
         vSc6XovhhnkdZ1TW7+0fyBWbbjtGO7FyJM0ksXUVPzWWhQ7CJUE6i0afUlQ6+dESVwUU
         5UfnyWs4UDMiKip69lR0qPwQK0702Tn/qt44wAJx6n/IzoLDFgGyNO7tdGI0mjv5rNGR
         zaTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687259140; x=1689851140;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ToCmia0PXRpaSenikhacrjnmxFSrHT1/63mpMtPp/dU=;
        b=Yei6DY2AlgzHiVAy42EG1sbFGHMx6bnbrE71A5VgWqedtTt/SwJ0s00opUN52CulRx
         SJaGPOjaziYHZzKFE8LFbq8TE0u/ZY+IV/HOLmbTHQbaxmsFnrTEFJbp9KGgwYRuQn+h
         c4NZga/CARUpCpIu7q7SzmmmSjihaf0D9iryXZveOvItQ3VsCG/aQTSr/8rmQeVuNcOU
         otZm11xaEwIF5n8RzgFhIrIw0ryRgAbf8G7HF1/LFbdDh6XusJLx6Er7Qp51M6jXWZM6
         LoDZsla6G5vHL3wA13kbV+BegsGpE35d1YLFp8wRlBaQMwiu9otxBeW/+AcEbCMeRNHO
         2Ivg==
X-Gm-Message-State: AC+VfDzgp7Aupb1435fmJ3KvGIrB9lOJ15W/w5V8JBDrVjQGq9Xvlwa1
        kisZClkAGF5w8eC6teY5BRp9aw==
X-Google-Smtp-Source: ACHHUZ5xUesOcnI+PzghCY2RHYS5gUieS4t/zAkpgFT7e/jZu9P2j30qma69aEr7JriPHz4wrpvw4w==
X-Received: by 2002:a05:651c:23a:b0:2b5:7ecc:bb08 with SMTP id z26-20020a05651c023a00b002b57eccbb08mr784328ljn.10.1687259140312;
        Tue, 20 Jun 2023 04:05:40 -0700 (PDT)
Received: from [192.168.1.101] (abxj193.neoplus.adsl.tpnet.pl. [83.9.3.193])
        by smtp.gmail.com with ESMTPSA id 11-20020a05651c008b00b002ac7b0fc473sm369047ljq.38.2023.06.20.04.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 04:05:40 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 20 Jun 2023 13:05:36 +0200
Subject: [PATCH v2 3/4] arm64: dts: qcom: sm8250-pdx203: Configure SLG51000
 PMIC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230614-topic-edo_pinsgpiopmic-v2-3-6f90bba54c53@linaro.org>
References: <20230614-topic-edo_pinsgpiopmic-v2-0-6f90bba54c53@linaro.org>
In-Reply-To: <20230614-topic-edo_pinsgpiopmic-v2-0-6f90bba54c53@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687259134; l=4795;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ntXT2oOXZaov8tiTHi3wvxvjxZX5gQ3JPbXY/oE7Ou4=;
 b=nJwpL+3TCbjE8BVievBS4IWiZCALKT824ptCOtSgJcx6KeH9oArzVHaw6DOyd5wSBKGud/cn5
 G+cDSxHbduBBZGf55wgTPAIu69kzbaOXb9pod8pq43srQmpiAWMyXhT
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xperia 1 II / PRO use the Dialog SLG51000 PMIC for powering some camera
sensors. Add the required nodes to support it and remove its remnants
from -edo.dtsi, as it's absent on 5 II.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../dts/qcom/sm8250-sony-xperia-edo-pdx203.dts     | 131 +++++++++++++++++++++
 .../boot/dts/qcom/sm8250-sony-xperia-edo.dtsi      |   7 --
 2 files changed, 131 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dts b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dts
index 62590c6bd306..f4c4575eb03b 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dts
@@ -15,6 +15,123 @@ / {
 
 /delete-node/ &vreg_l7f_1p8;
 
+&i2c5 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	pmic@75 {
+		compatible = "dlg,slg51000";
+		reg = <0x75>;
+		dlg,cs-gpios = <&tlmm 69 GPIO_ACTIVE_HIGH>;
+		vin5-supply = <&vreg_s1f_1p2>;
+		vin6-supply = <&vreg_s1f_1p2>;
+
+		pinctrl-0 = <&cam_pwr_b_cs>;
+		pinctrl-names = "default";
+
+		regulators {
+			slg51000_1_ldo1: ldo1 {
+				regulator-name = "slg51000_b_ldo1";
+				regulator-min-microvolt = <2400000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			slg51000_1_ldo2: ldo2 {
+				regulator-name = "slg51000_b_ldo2";
+				regulator-min-microvolt = <2400000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			slg51000_1_ldo3: ldo3 {
+				regulator-name = "slg51000_b_ldo3";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3750000>;
+			};
+
+			slg51000_1_ldo4: ldo4 {
+				regulator-name = "slg51000_b_ldo4";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3750000>;
+			};
+
+			slg51000_1_ldo5: ldo5 {
+				regulator-name = "slg51000_b_ldo5";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1200000>;
+			};
+
+			slg51000_1_ldo6: ldo6 {
+				regulator-name = "slg51000_b_ldo6";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1200000>;
+			};
+
+			slg51000_1_ldo7: ldo7 {
+				regulator-name = "slg51000_b_ldo7";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3750000>;
+			};
+		};
+	};
+};
+
+&i2c15 {
+	pmic@75 {
+		compatible = "dlg,slg51000";
+		reg = <0x75>;
+		dlg,cs-gpios = <&tlmm 71 GPIO_ACTIVE_HIGH>;
+		vin5-supply = <&vreg_l2f_1p3>;
+		vin6-supply = <&vreg_l2f_1p3>;
+
+		pinctrl-0 = <&cam_pwr_a_cs>;
+		pinctrl-names = "default";
+
+		regulators {
+			slg51000_0_ldo1: ldo1 {
+				regulator-name = "slg51000_a_ldo1";
+				regulator-min-microvolt = <2400000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			slg51000_0_ldo2: ldo2 {
+				regulator-name = "slg51000_a_ldo2";
+				regulator-min-microvolt = <2400000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			slg51000_0_ldo3: ldo3 {
+				regulator-name = "slg51000_a_ldo3";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3750000>;
+			};
+
+			slg51000_0_ldo4: ldo4 {
+				regulator-name = "slg51000_a_ldo4";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3750000>;
+			};
+
+			slg51000_0_ldo5: ldo5 {
+				regulator-name = "slg51000_a_ldo5";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1200000>;
+			};
+
+			slg51000_0_ldo6: ldo6 {
+				regulator-name = "slg51000_a_ldo6";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1200000>;
+			};
+
+			slg51000_0_ldo7: ldo7 {
+				regulator-name = "slg51000_a_ldo7";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3750000>;
+			};
+		};
+	};
+};
+
 &pm8009_gpios {
 	gpio-line-names = "NC", /* GPIO_1 */
 			  "CAM_PWR_LD_EN",
@@ -246,4 +363,18 @@ &tlmm {
 			  "HST_BLE_SNS_UART6_RX",
 			  "HST_WLAN_UART_TX",
 			  "HST_WLAN_UART_RX";
+
+	cam_pwr_b_cs: cam-pwr-b-state {
+		pins = "gpio69";
+		drive-strength = <2>;
+		bias-disable;
+		output-low;
+	};
+
+	cam_pwr_a_cs: cam-pwr-a-state {
+		pins = "gpio71";
+		drive-strength = <2>;
+		bias-disable;
+		output-low;
+	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
index 8ab82bacba81..70da10fb9d9d 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
@@ -486,13 +486,6 @@ cs35l41_r: speaker-amp@41 {
 	};
 };
 
-&i2c5 {
-	status = "okay";
-	clock-frequency = <400000>;
-
-	/* Dialog SLG51000 CMIC @ 75 */
-};
-
 &i2c9 {
 	status = "okay";
 	clock-frequency = <400000>;

-- 
2.41.0

