Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F92F6DE3A5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 20:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjDKSO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 14:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjDKSOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 14:14:49 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B32173D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 11:14:48 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id e11so11485206lfc.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 11:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681236886; x=1683828886;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nqqJwELWN/hOjlu4C15VTf6hm+l2eGEBIz6GNcstEPs=;
        b=K4/nRHo7yRVICWQe0XOmu/tHCVYqh+WIEW8SSj+/yDC6zQohYU95hKB7WQloIk4zTF
         I4oIjPTAQnHkQXeGZHm7zd6gM6RHRvr6ecNgh/E4XABk7fOU4v64H+WuWoVXMhPUR63d
         oseOFtHD+7sCkVm0UiOBJuQs60ZxKm92ahpE2Ksil90vNKQh1SFHMuhlw6GIHZR1vZCb
         A8FJodz+b6x7gIASQO1Rh8CSAsptUDdnWRov3a6lLEx9ghbeG8S0+LsBO/Kp8BhqXr0m
         lUXUPrcQMRoaJGjjH2s9tMT64gSjBFcKhj1WtvcanyAyFuV3omDpKFJrWZKuLdGVTiUH
         OO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681236886; x=1683828886;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nqqJwELWN/hOjlu4C15VTf6hm+l2eGEBIz6GNcstEPs=;
        b=ytTqAyFG0Q6eiQnT2qX5nxQxr9m55754ESh1Y7iz9510rWoVXosidMwhPno7bo7p5T
         YtsKE1eXA796Sf7c/NkjcE+aA/bNEHs2mTzrsrUJjwKLI9WzMVeNY7X2FuhThfXT9hSP
         IlgAU196ZqtRFEiB13NqNByes6T90Sj95/bN0hZnIkv1xZDumuy279NWuJkw39X9W0zl
         oVeObYZJgieLRXjfTYGuK0D6Rt94b6EA+rIO8hyXm+wxPvlBJlM2nue1I2QgYQ/6uHG/
         WnYdhMkPQ5eVgCkJXF8iORDROyoFlF+IDKaC2mx6jXMCoZQgN9FAzH6OCQDMaxOJRalu
         tr1Q==
X-Gm-Message-State: AAQBX9flDD+WWK6adVhlI671tU7n8AtF8G+Lc+pPjKrp9pTMTDTt+g6x
        R6y7GzyvJKBZ+/xCxWCfBaNFvA==
X-Google-Smtp-Source: AKy350b4YXolWix5cd3uWufPAM/EQ1w8H9k6It6Oz89DFAw3qNvUbKVbrETw2Kx817n0DTKD8EDa+w==
X-Received: by 2002:ac2:430c:0:b0:4ec:8816:f4fc with SMTP id l12-20020ac2430c000000b004ec8816f4fcmr1844175lfh.6.1681236886736;
        Tue, 11 Apr 2023 11:14:46 -0700 (PDT)
Received: from [192.168.1.101] (abxj23.neoplus.adsl.tpnet.pl. [83.9.3.23])
        by smtp.gmail.com with ESMTPSA id u25-20020ac243d9000000b004da8168eba2sm2593868lfl.237.2023.04.11.11.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 11:14:46 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Apr 2023 20:14:41 +0200
Subject: [PATCH v2 1/4] arm64: dts: qcom: sm8150-kumano: Add GPIO line
 names for PMIC GPIOs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230315-topic-kumano_dts0-v2-1-0ca7fa521b86@linaro.org>
References: <20230315-topic-kumano_dts0-v2-0-0ca7fa521b86@linaro.org>
In-Reply-To: <20230315-topic-kumano_dts0-v2-0-0ca7fa521b86@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681236884; l=1914;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=vhljNcoTVkBBoXt4/XMAQL+2xQrVuzZ9DHcx/LIdZ+o=;
 b=iMKCwt7JcDcjABvyC8m0M5OTEfSMbHwmL6AY4n954o15jrxLolhjCiTp1sQ4O6a2Uui/xySHMZPI
 V0eLhcutCN61TR6fOAYkbdPe5Eiw4mAt00vGX3cTOCg+NTc35lmH
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

