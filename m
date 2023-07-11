Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBCE74EBBA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 12:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjGKK21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 06:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjGKK20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 06:28:26 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D5FE42
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 03:28:24 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fb8574a3a1so8446942e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 03:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689071302; x=1691663302;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NyZ8tGGEOmeJVu8EC8qxSRaeNCjOU6ONoIt2Vl89luE=;
        b=X5buVxt+KuCkOgj/KaZqhBOVzH2mKBG2uR/fietaam6PmKctkFr/m+xqMp3kXCTYi/
         oBGjo9HYIEacnJPqbPVoH4wLIBoXjp2yKrK/Ga7v7/+7qDG5lEuKHiWhwlhY7mZD5xw1
         i0JH7JtfQ2iFf3TCUD3uJn+Rc7lUkzWfU2Ob2Th0SPOhUhUbZsHmJ9NqZ76VBs80cc7v
         26RqbmeduzcSDhspc2R/yTJrz2ddh08AfORZZCR0arBBosdCcYTkdAMw8vGjmWCToGOu
         jEI+kZy1SQ4VzjB5wbqtQqXBbi1oPRkkqm5Dgh3qff9xP8an3rqssV+oMkt2fxykTRG/
         W5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689071302; x=1691663302;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NyZ8tGGEOmeJVu8EC8qxSRaeNCjOU6ONoIt2Vl89luE=;
        b=HcTf2dggOeCaWABR2oCg09VYc3xWH9DtsRtJM2GjS7Ak6rg6bBrre/5mJFF/Ro3+WX
         KlLcoj471smMZ3tOWzLYkIGxCP7CZvdZ1+1lo0VZFmBjJUGwyqRBktRMG6qBQ4rFGUKQ
         Nn9xFwoGL0JVYl73MULWl8eNRxWfvQ+B0SU+DZYC4OU4nEfrW4+Hkk/T6nyG72i8mgeR
         8/Vn8GwQnNJPdGtAuVPVfimGh0NgAahkQNWCfKT4rHkTrj9f3PfhoHwxZ6cEzoG+ohPi
         bWsXmimVQBjjR5IJWBdrqyRz/MbJvkepE44qwUkHI/1RtuNMxRfMj9TfBvifa0x9RlFv
         ahCQ==
X-Gm-Message-State: ABy/qLYO81/0WQS7jAM2eSCVdloMKP0FHjl9eOyLWzCwAcEJ3CJ/G9qh
        qo0O2RsaYVV22xn/lS8dMxZAlg==
X-Google-Smtp-Source: APBJJlFY0OPAg9KBzEmGJo45IrEN8V/NYW2KAtXpBh6A2uqQLVZwfCfuC168pnIIbKJ9GMQ8pCfbOA==
X-Received: by 2002:a19:6601:0:b0:4fb:7447:e724 with SMTP id a1-20020a196601000000b004fb7447e724mr12807977lfc.8.1689071302424;
        Tue, 11 Jul 2023 03:28:22 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id b26-20020ac247fa000000b004fbb207ee0asm260092lfp.206.2023.07.11.03.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 03:28:22 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 12:28:17 +0200
Subject: [PATCH] arm64: dts: qcom: qrb2210-rb1: Add regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230711-topic-rb1_regulator-v1-1-bc4398c35800@linaro.org>
X-B4-Tracking: v=1; b=H4sIAMAurWQC/x2N0QrCMAwAf2Xk2cDaFUV/RWSkXdwCpR3pJsLYv
 xt8vIPjDmiswg0e3QHKH2lSi4G7dJAWKjOjTMbgez/0N+dwq6sk1OhG5XnPtFXFEFKgie+DD1e
 wMlJjjEolLdaWPWeTq/Jbvv/V83WeP+qmkcl6AAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689071300; l=8057;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Iba3nS85j60Hy+togLR/dX0iY23cMPgt7+PGSw52Izc=;
 b=sZMBSlLzoztBrESJW0fOCRIgMEf10JSI/h9W9GIfu1cLcJ/vF6qyKTpQMfgfkblHkvZXJLuQb
 FQPaZdWgZt7CoBniFotFMyYx+uUHWx9Z+xBu+gZyZX+k8NGbDq7teOv
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add and assign RPM regulators coming from PM2250.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 266 +++++++++++++++++++++++++++++++
 1 file changed, 266 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
index ef3616093289..eadba066972e 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
@@ -38,6 +38,91 @@ key-volume-up {
 			wakeup-source;
 		};
 	};
+
+	vreg_hdmi_out_1p2: regulator-hdmi-out-1p2 {
+		compatible = "regulator-fixed";
+		regulator-name = "VREG_HDMI_OUT_1P2";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		vin-supply = <&vdc_1v2>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	lt9611_3v3: regulator-lt9611-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "LT9611_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vdc_3v3>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	/* Main barrel jack input */
+	vdc_12v: regulator-vdc-12v {
+		compatible = "regulator-fixed";
+		regulator-name = "DC_12V";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	/* 1.2V supply stepped down from the barrel jack input */
+	vdc_1v2: regulator-vdc-1v2 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDC_1V2";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		vin-supply = <&vdc_12v>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	/* 3.3V supply stepped down from the barrel jack input */
+	vdc_3v3: regulator-vdc-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDC_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vdc_12v>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	/* 5V supply stepped down from the barrel jack input */
+	vdc_5v: regulator-vdc-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "VDC_5V";
+
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	/* "Battery" voltage for the SoM, stepped down from the barrel jack input */
+	vdc_vbat_som: regulator-vdc-vbat {
+		compatible = "regulator-fixed";
+		regulator-name = "VBAT_SOM";
+		regulator-min-microvolt = <4200000>;
+		regulator-max-microvolt = <4200000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	/* PM2250 charger out, supplied by VBAT */
+	vph_pwr: regulator-vph-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+		vin-supply = <&vdc_vbat_som>;
+
+		regulator-always-on;
+		regulator-boot-on;
+	};
 };
 
 &pm2250_resin {
@@ -49,7 +134,183 @@ &qupv3_id_0 {
 	status = "okay";
 };
 
+&rpm_requests {
+	regulators {
+		compatible = "qcom,rpm-pm2250-regulators";
+		vdd_s3-supply = <&vph_pwr>;
+		vdd_s4-supply = <&vph_pwr>;
+		vdd_l1_l2_l3_l5_l6_l7_l8_l9_l10_l11_l12-supply = <&pm2250_s3>;
+		vdd_l4_l17_l18_l19_l20_l21_l22-supply = <&vph_pwr>;
+		vdd_l13_l14_l15_l16-supply = <&pm2250_s4>;
+
+		/*
+		 * S1 - VDD_APC
+		 * S2 - VDD_CX
+		 */
+
+		pm2250_s3: s3 {
+			/* 0.4V-1.6625V -> 1.3V (Power tree requirements) */
+			regulator-min-microvolts = <1350000>;
+			regulator-max-microvolts = <1350000>;
+			regulator-boot-on;
+		};
+
+		pm2250_s4: s4 {
+			/* 1.2V-2.35V -> 2.05V (Power tree requirements) */
+			regulator-min-microvolts = <2072000>;
+			regulator-max-microvolts = <2072000>;
+			regulator-boot-on;
+		};
+
+		/* L1 - VDD_MX */
+
+		pm2250_l2: l2 {
+			/* LPDDR4X VDD2 */
+			regulator-min-microvolts = <1136000>;
+			regulator-max-microvolts = <1136000>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		pm2250_l3: l3 {
+			/* LPDDR4X VDDQ */
+			regulator-min-microvolts = <616000>;
+			regulator-max-microvolts = <616000>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		pm2250_l4: l4 {
+			/* max = 3.05V -> max = just below 3V (SDHCI2) */
+			regulator-min-microvolts = <1648000>;
+			regulator-max-microvolts = <2992000>;
+			regulator-allow-set-load;
+		};
+
+		pm2250_l5: l5 {
+			/* CSI/DSI */
+			regulator-min-microvolts = <1232000>;
+			regulator-max-microvolts = <1232000>;
+			regulator-allow-set-load;
+			regulator-boot-on;
+		};
+
+		pm2250_l6: l6 {
+			/* DRAM PLL */
+			regulator-min-microvolts = <928000>;
+			regulator-max-microvolts = <928000>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		pm2250_l7: l7 {
+			/* Wi-Fi CX/MX */
+			regulator-min-microvolts = <664000>;
+			regulator-max-microvolts = <664000>;
+		};
+
+		/*
+		 * L8 - VDD_LPI_CX
+		 * L9 - VDD_LPI_MX
+		 */
+
+		pm2250_l10: l10 {
+			/* Wi-Fi RFA */
+			regulator-min-microvolts = <1300000>;
+			regulator-max-microvolts = <1300000>;
+		};
+
+		pm2250_l11: l11 {
+			/* GPS RF1 */
+			regulator-min-microvolts = <1000000>;
+			regulator-max-microvolts = <1000000>;
+			regulator-boot-on;
+		};
+
+		pm2250_l12: l12 {
+			/* USB PHYs */
+			regulator-min-microvolts = <928000>;
+			regulator-max-microvolts = <928000>;
+			regulator-allow-set-load;
+			regulator-boot-on;
+		};
+
+		pm2250_l13: l13 {
+			/* USB/QFPROM/PLLs */
+			regulator-min-microvolts = <1800000>;
+			regulator-max-microvolts = <1800000>;
+			regulator-allow-set-load;
+			regulator-boot-on;
+		};
+
+		pm2250_l14: l14 {
+			/* SDHCI1 VQMMC */
+			regulator-min-microvolts = <1800000>;
+			regulator-max-microvolts = <1800000>;
+			regulator-allow-set-load;
+			/* Broken hardware, never turn it off! */
+			regulator-always-on;
+		};
+
+		pm2250_l15: l15 {
+			/* WCD/DSI/BT VDDIO */
+			regulator-min-microvolts = <1800000>;
+			regulator-max-microvolts = <1800000>;
+			regulator-allow-set-load;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		pm2250_l16: l16 {
+			/* GPS RF2 */
+			regulator-min-microvolts = <1800000>;
+			regulator-max-microvolts = <1800000>;
+			regulator-boot-on;
+		};
+
+		pm2250_l17: l17 {
+			regulator-min-microvolts = <3000000>;
+			regulator-max-microvolts = <3000000>;
+		};
+
+		pm2250_l18: l18 {
+			/* VDD_PXn */
+			regulator-min-microvolts = <1800000>;
+			regulator-max-microvolts = <1800000>;
+		};
+
+		pm2250_l19: l19 {
+			/* VDD_PXn */
+			regulator-min-microvolts = <1800000>;
+			regulator-max-microvolts = <1800000>;
+		};
+
+		pm2250_l20: l20 {
+			/* SDHCI1 VMMC */
+			regulator-min-microvolts = <2856000>;
+			regulator-max-microvolts = <2856000>;
+			regulator-allow-set-load;
+		};
+
+		pm2250_l21: l21 {
+			/* SDHCI2 VMMC */
+			regulator-min-microvolts = <2960000>;
+			regulator-max-microvolts = <3300000>;
+			regulator-allow-set-load;
+			regulator-boot-on;
+		};
+
+		pm2250_l22: l22 {
+			/* Wi-Fi */
+			regulator-min-microvolts = <3312000>;
+			regulator-max-microvolts = <3312000>;
+		};
+	};
+};
+
 &sdhc_1 {
+	vmmc-supply = <&pm2250_l20>;
+	vqmmc-supply = <&pm2250_l14>;
 	pinctrl-0 = <&sdc1_state_on>;
 	pinctrl-1 = <&sdc1_state_off>;
 	pinctrl-names = "default", "sleep";
@@ -61,6 +322,8 @@ &sdhc_1 {
 };
 
 &sdhc_2 {
+	vmmc-supply = <&pm2250_l21>;
+	vqmmc-supply = <&pm2250_l4>;
 	cd-gpios = <&tlmm 88 GPIO_ACTIVE_LOW>;
 	pinctrl-0 = <&sdc2_state_on &sd_det_in_on>;
 	pinctrl-1 = <&sdc2_state_off &sd_det_in_off>;
@@ -104,6 +367,9 @@ &usb {
 };
 
 &usb_hsphy {
+	vdd-supply = <&pm2250_l12>;
+	vdda-pll-supply = <&pm2250_l13>;
+	vdda-phy-dpdm-supply = <&pm2250_l21>;
 	status = "okay";
 };
 

---
base-commit: 8e4b7f2f3d6071665b1dfd70786229c8a5d6c256
change-id: 20230711-topic-rb1_regulator-44c4ade93246

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

