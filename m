Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D48B72FE10
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244501AbjFNMMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244475AbjFNMMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:12:12 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097A21FF9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:12:00 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f762b3227dso1253875e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686744718; x=1689336718;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XKJjIqwo51G5MZT6SpaYZZUQ0YwGWBzq25MeRmDl6v0=;
        b=ryLVxtszJHlGn9jJNvghIbxyAQ0G4AW2fFncXa/D5064gk4R+2VYntZakRZrkDvmhl
         r8htnxAGqnl8xP6dt2mVxAZUYrS+UC1QlxhdS79hX8u/fiC9/3yxzKPaPVgBLELbIxNW
         1Ea01P3t8MoF314FVJQJhgiIWtj6yMAC5CyFX72EYBcnao/0cMeO8qtwtN17h2AnPqZX
         Y6nPm+DxvWDodbKwS8BuhOp/q9OsVB3FRqsShpcS//MGDooJQMnEYv2NrSAbRxT2J/DH
         DCxWhJlSECAJQn1iT84xRFBBCIPUCGL0NAUTP+rjEySsZM+6VrS0q2OLswEcDOGEn0pI
         H9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686744718; x=1689336718;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKJjIqwo51G5MZT6SpaYZZUQ0YwGWBzq25MeRmDl6v0=;
        b=QlVsVMHriJ38apa/6Oh3I9dgGEJNE0ChKMxoTCZpA+t4ElWx7zr20GkgDSYzhUWaAc
         j5H61qIYb+XAoJiIz9YGnEHG9xVup/ZreZbeiQVeIG1njlLA6eleLpGiV6Cb922pr0TD
         9QLckV+PLe1OMA7QYPMbhM18IwH3PTv0S2pqVd4zDieqUqFbGglhS9/2pSbKaGxEjKdd
         bgfNIx9soFJzcvJX1AMQVzx7/Oh1rdZrPWmLBrckyGcWxiz/GOeobX0cJ6w9dXfhLzpI
         L6nXm9RgNFUddchkylg1RM9oeltGlZP8AMEwuSYLQW+sJoB2HGHi0et36rwq0pqB+fTS
         9zAw==
X-Gm-Message-State: AC+VfDxqnzlXtLmb/QZ9MCRhQPuEKUAB18CvFOIWiLGg9RtkJ/Ztaff1
        GsHiSSD9+Y66WbvW6Kq7QEodZw==
X-Google-Smtp-Source: ACHHUZ5bIfPY2CWP+J6X2Mm7KzPdFTQ2Otn0myIy6BrG1QfZexX4yWX4KBMMkBJOfpLz0qEvm+9FHw==
X-Received: by 2002:a19:6503:0:b0:4f7:6730:c456 with SMTP id z3-20020a196503000000b004f76730c456mr496263lfb.12.1686744718153;
        Wed, 14 Jun 2023 05:11:58 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id d2-20020ac25ec2000000b004f24e797c55sm2109793lfq.25.2023.06.14.05.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 05:11:57 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 14 Jun 2023 14:11:48 +0200
Subject: [PATCH 3/4] arm64: dts: qcom: sm8250-pdx203: Configure SLG51000
 PMIC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230614-topic-edo_pinsgpiopmic-v1-3-cf88a0bac26c@linaro.org>
References: <20230614-topic-edo_pinsgpiopmic-v1-0-cf88a0bac26c@linaro.org>
In-Reply-To: <20230614-topic-edo_pinsgpiopmic-v1-0-cf88a0bac26c@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686744712; l=4795;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=U+VpiqRYoSq3szDzn4mqCWpp8VBKg2i1duDfVUSEXA0=;
 b=AtEJTttxBfSQCwlzW+eZ79+BDaFTFCmIHqS6kI31PKLsK1RAtFgaEUXohqSonhz0MyM7lp7Ri
 hAa1lk0o2XNCsFcTlzE0eQgKpIRdpEYfbD92EvI5SXL9EHbzZpg2wpJ
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
index 8d4352c8c543..9f9e7e9784fe 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
@@ -485,13 +485,6 @@ cs35l41_r: speaker-amp@41 {
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

