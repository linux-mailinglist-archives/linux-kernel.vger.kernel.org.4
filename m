Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD0C6DDCC1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjDKNt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjDKNtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:49:22 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F9710C3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 06:49:21 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id z8so12308473lfb.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 06:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681220960;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nqqJwELWN/hOjlu4C15VTf6hm+l2eGEBIz6GNcstEPs=;
        b=DNV7MqW3fFKZlLv+rkJpU8edIPWDasEBRKp2Vmx8zYdpfwkastWtpOmJbr64NBG5Cr
         nZkjyC5FiYOibGBXPuTG0F1lDfV7e+o4l+Q3tm49CibfoVLecHUGCjKAVbGHmaWRukxw
         FGKylUbmK6+GMx9osc2IEHUILhDeG6fIjJ9M4nccTxtGxVpto2HmjJrg96gL6p9qEqyD
         UlbqnQomu36w33WDLBQCyBRID8VYKtHbFCCBO62lIgVnXGGHPx38YE1ASUh5yXrpZcEb
         NbvqSwtbV+0/OAlyYAMccw6R6eqfZBv0oxYDQ6xr4FE2pdg3oy2dUwEPgkBmthZ7Mz6C
         FJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681220960;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nqqJwELWN/hOjlu4C15VTf6hm+l2eGEBIz6GNcstEPs=;
        b=OEF17DRiD4bY1RXYfIWZQFG122futT+00GpSC3YMmx2up/iRrF1/MV+HedwHOEb4EF
         Q1wmq6AdwkFVzpAsG2B/t3D9Y2C+w1+25SF9088IlAPtFqr+nlzufJwYRstAQaFw6szO
         RfYuJNCW8/J7pwytUJiRTgLquMnhqQx05WTgJTeGH9Ypm/QfAEdBJ5JdRmtiZDC4pvkv
         JS3c67K8yRUNHdwEmj/ZKUHlycczVKYZBfsSCf146D3DJPR4UNVa4ihGV/BaTfxu5rp6
         Ur3JD4edgNkmoCJxKzKua3SFTsCS+d1uFfv+07wxirg4RrbQhQWszCfhNmirGtqe2kUj
         kVSA==
X-Gm-Message-State: AAQBX9dNNVV8S2DL6uyq5bWwX5O7HkBn+pNbuksqQjNoaO0Om0lXrhs9
        dRF4JWduflB3ZAB/iFYCdupZNw==
X-Google-Smtp-Source: AKy350aYme6S8DX2hEjnZVyFhP57OQ4bR4ooy6Cm+5hIFb8ygRmADtmHlS71Fei3P0R2RCQkeTDnfw==
X-Received: by 2002:ac2:428c:0:b0:4e8:61d2:72ee with SMTP id m12-20020ac2428c000000b004e861d272eemr4388495lfh.5.1681220960045;
        Tue, 11 Apr 2023 06:49:20 -0700 (PDT)
Received: from [192.168.1.101] (abxj23.neoplus.adsl.tpnet.pl. [83.9.3.23])
        by smtp.gmail.com with ESMTPSA id y9-20020ac255a9000000b004eb2d6160a4sm2563707lfg.32.2023.04.11.06.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 06:49:19 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Apr 2023 15:49:15 +0200
Subject: [PATCH 1/4] arm64: dts: qcom: sm8150-kumano: Add GPIO line names
 for PMIC GPIOs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230315-topic-kumano_dts0-v1-1-f1852c2a2378@linaro.org>
References: <20230315-topic-kumano_dts0-v1-0-f1852c2a2378@linaro.org>
In-Reply-To: <20230315-topic-kumano_dts0-v1-0-f1852c2a2378@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681220957; l=1914;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=vhljNcoTVkBBoXt4/XMAQL+2xQrVuzZ9DHcx/LIdZ+o=;
 b=cqUwvMqNsJt/c29SYpKHkQvIviO8e6Ruj2D3FKl1UnVXOb7LgSTvsFOZ8F7A+kylm9NQDu0kpJef
 5lm2SZxtB2KOPmq9JioZ76doM2/qYf0Gr72xOqSWsfclpYzTpakI
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

Sony ever so graciously provides GPIO line names in their downstream
kernel (though sometimes they are not 100% accurate and you can judge
that by simply looking at them and with what drivers they are used).

Add these to the Griffin and Bahamut device trees to better document
the hardware.

They are the same on both devices! Very nice!

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi   | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi b/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
index 47e2430991ca..6753c65d75bc 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
@@ -456,6 +456,17 @@ &i2c10 {
 };
 
 &pm8150_gpios {
+	gpio-line-names = "VOL_DOWN_N", /* GPIO_1 */
+			  "",
+			  "NC",
+			  "NC",
+			  "",
+			  "NC",
+			  "SUPWC_PWR_EN",
+			  "",
+			  "NC",
+			  "NC"; /* GPIO_10 */
+
 	vol_down_n: vol-down-n-state {
 		pins = "gpio1";
 		function = "normal";
@@ -466,6 +477,19 @@ vol_down_n: vol-down-n-state {
 };
 
 &pm8150b_gpios {
+	gpio-line-names = "SNAPSHOT_N", /* GPIO_1 */
+			  "FOCUS_N",
+			  "NC",
+			  "NC",
+			  "RF_LCD_ID_EN",
+			  "NC",
+			  "TS_VDDH_EN",
+			  "LCD_ID",
+			  "",
+			  "NC", /* GPIO_10 */
+			  "NC",
+			  "RF_ID";
+
 	snapshot_n: snapshot-n-state {
 		pins = "gpio1";
 		function = "normal";
@@ -483,6 +507,21 @@ focus_n: focus-n-state {
 	};
 };
 
+&pm8150l_gpios {
+	gpio-line-names = "TS_VDDIO_EN", /* GPIO_1 */
+			  "NC",
+			  "MAIN_CAM_PWR_VMDR_EN",
+			  "NC",
+			  "",
+			  "NC",
+			  "NC",
+			  "FP_LDO_EN",
+			  "NC",
+			  "NC", /* GPIO_10 */
+			  "NC",
+			  "NC";
+};
+
 &pon_pwrkey {
 	status = "okay";
 };

-- 
2.40.0

