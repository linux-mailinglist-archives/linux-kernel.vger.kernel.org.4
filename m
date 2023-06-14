Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB2B72FE0B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244466AbjFNMMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244464AbjFNMMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:12:10 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CE126A2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:11:58 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f6370ddd27so8466649e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686744716; x=1689336716;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2GKvZ616V2FdbMtm5spz/6erBtMA2Hst579nyomUNLg=;
        b=Bw0+UTUC/qX0S8ZcEFmLN1g7S6E6bNXgFugnyQV4/YFAYrbS9L3rKBGw1WQal1pmaO
         kUhInhxIBHw9+LTsqP6eY0kCjbfYcn2HCWCj1JEDAXJEnp7apbNoacGOyFejZi1DPSWP
         ap/Tu4Stti5RWjktyaIf3yMWA5JtTtP9Skh7+MY+Ol8wqsiXkr/L2Xv8bMYwFTmdO/Pc
         bRdWfT/dF8l4kyrLrPyJmfiX6THKLmjVQ6OEjtDwW3+qrMChRxEpfYPEDmj11eRoR1KD
         PgADeottRZbOCca8ZRTJCN84URHocbaBCTmgy+p3pz1+d0/Ndg+uEYOBHS13SFShKbjH
         BLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686744716; x=1689336716;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GKvZ616V2FdbMtm5spz/6erBtMA2Hst579nyomUNLg=;
        b=FHfr+fNxlTfd6dez6Dh5S1NVigt+8e0Tnc+oF0vBtZIMJ2yuQ0o1eB0tcY0N3iSgUp
         8qAQHvmxug0MLHvgg36uDA13s3MUxy5fcy1VbWCunU/GzEscAADJbq6wvZyQViLSzaNa
         tiRoLDsIqxHPcdmp2mzTiYnLdAdN7PdobDZi5HmMzkYRRUh0BMEct7FlO7h3rK7tGEY9
         Wqpi9ICllyzw5riFLDMhEj2JNzuMIFhSw79IcRg4PmGnwtpbifWM8JpMcACXt+RNcqZR
         bXdNybLGNEhDbfR5Lcc7XkUoXxxC9jFjnkS2siPH6I3Bijv0+Klxe+18gVNDe/Y/bHgh
         o/Ww==
X-Gm-Message-State: AC+VfDzvsk+Ss9bedm03lWF/78FtPsl+0y726mPYC578MmHy2xrJRRKc
        B3n8YnCSfHZC6cLvbvTRYcJZ2TFe1hUsPdTvIF4=
X-Google-Smtp-Source: ACHHUZ7MJAc2ayOShMAuvLLIYCrfWEKo2WZ7Ygh5WVoM63afj4ClelMlxOfoG4CxxKK9J29mBeJbEA==
X-Received: by 2002:a19:6756:0:b0:4f1:26f5:77fb with SMTP id e22-20020a196756000000b004f126f577fbmr8018150lfj.28.1686744716565;
        Wed, 14 Jun 2023 05:11:56 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id d2-20020ac25ec2000000b004f24e797c55sm2109793lfq.25.2023.06.14.05.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 05:11:56 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 14 Jun 2023 14:11:47 +0200
Subject: [PATCH 2/4] arm64: dts: qcom: sm8250-edo: Add GPIO line names for
 PMIC GPIOs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230614-topic-edo_pinsgpiopmic-v1-2-cf88a0bac26c@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686744712; l=3755;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=NNKUHsnSrdS4vf/kgCib1So5nPpERojtp2HUS+mt0M8=;
 b=+FciPhTwrnNb2M60+ATv4cP3yTRrZN8r0tkISE83J3oT3M5ofKFlHv1GieBCdeS3Jh2Xf9wEM
 qf1tEVfJWT/ANZbMkFNtfN9kpiTRaTT2RFopdnfrZLmZ696GzhB8YfO
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

Sony ever so graciously provides GPIO line names in their downstream
kernel (though sometimes they are not 100% accurate and you can judge
that by simply looking at them and with what drivers they are used).

Add these to the PDX203&206 DTSIs to better document the hardware.

Diff between 203 and 206:
pm8009_gpios
<                         "CAM_PWR_LD_EN",
>                         "NC",

pm8150_gpios
<                         "NC",
>                         "G_ASSIST_N",
<                         "WLC_EN_N", /* GPIO_10 */
>                         "NC", /* GPIO_10 */
Which is due to 5 II having an additional Google Assistant hardware
button and 1 II having a wireless charger & different camera wiring
to accommodate the additional 3D iToF sensor.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../dts/qcom/sm8250-sony-xperia-edo-pdx203.dts     | 50 ++++++++++++++++++++++
 .../dts/qcom/sm8250-sony-xperia-edo-pdx206.dts     | 50 ++++++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dts b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dts
index 84104d2b2010..62590c6bd306 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dts
@@ -15,6 +15,56 @@ / {
 
 /delete-node/ &vreg_l7f_1p8;
 
+&pm8009_gpios {
+	gpio-line-names = "NC", /* GPIO_1 */
+			  "CAM_PWR_LD_EN",
+			  "WIDEC_PWR_EN",
+			  "NC";
+};
+
+&pm8150_gpios {
+	gpio-line-names = "VOL_DOWN_N", /* GPIO_1 */
+			  "OPTION_2",
+			  "NC",
+			  "PM_SLP_CLK_IN",
+			  "OPTION_1",
+			  "NC",
+			  "NC",
+			  "SP_ARI_PWR_ALARM",
+			  "NC",
+			  "NC"; /* GPIO_10 */
+};
+
+&pm8150b_gpios {
+	gpio-line-names = "SNAPSHOT_N", /* GPIO_1 */
+			  "FOCUS_N",
+			  "NC",
+			  "NC",
+			  "RF_LCD_ID_EN",
+			  "NC",
+			  "NC",
+			  "LCD_ID",
+			  "NC",
+			  "WLC_EN_N", /* GPIO_10 */
+			  "NC",
+			  "RF_ID";
+};
+
+&pm8150l_gpios {
+	gpio-line-names = "NC", /* GPIO_1 */
+			  "PM3003A_EN",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "AUX2_THERM",
+			  "BB_HP_EN",
+			  "FP_LDO_EN",
+			  "PMX_RESET_N",
+			  "AUX3_THERM", /* GPIO_10 */
+			  "DTV_PWR_EN",
+			  "PM3003A_MODE";
+};
+
 &tlmm {
 	gpio-line-names = "AP_CTI_IN", /* GPIO_0 */
 			  "MDM2AP_ERR_FATAL",
diff --git a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dts b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dts
index fae6568cb79e..ea4571bf4fbf 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dts
@@ -30,6 +30,56 @@ g-assist-key {
 	};
 };
 
+&pm8009_gpios {
+	gpio-line-names = "NC", /* GPIO_1 */
+			  "NC",
+			  "WIDEC_PWR_EN",
+			  "NC";
+};
+
+&pm8150_gpios {
+	gpio-line-names = "VOL_DOWN_N", /* GPIO_1 */
+			  "OPTION_2",
+			  "NC",
+			  "PM_SLP_CLK_IN",
+			  "OPTION_1",
+			  "G_ASSIST_N",
+			  "NC",
+			  "SP_ARI_PWR_ALARM",
+			  "NC",
+			  "NC"; /* GPIO_10 */
+};
+
+&pm8150b_gpios {
+	gpio-line-names = "SNAPSHOT_N", /* GPIO_1 */
+			  "FOCUS_N",
+			  "NC",
+			  "NC",
+			  "RF_LCD_ID_EN",
+			  "NC",
+			  "NC",
+			  "LCD_ID",
+			  "NC",
+			  "NC", /* GPIO_10 */
+			  "NC",
+			  "RF_ID";
+};
+
+&pm8150l_gpios {
+	gpio-line-names = "NC", /* GPIO_1 */
+			  "PM3003A_EN",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "AUX2_THERM",
+			  "BB_HP_EN",
+			  "FP_LDO_EN",
+			  "PMX_RESET_N",
+			  "NC", /* GPIO_10 */
+			  "NC",
+			  "PM3003A_MODE";
+};
+
 &tlmm {
 	gpio-line-names = "AP_CTI_IN", /* GPIO_0 */
 			  "MDM2AP_ERR_FATAL",

-- 
2.41.0

