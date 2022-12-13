Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C84264AC65
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 01:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbiLMAZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 19:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234044AbiLMAYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 19:24:40 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A17658B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:24:38 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id b3so2344754lfv.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/RD5hHLuEtAj/FzoPif1UajBsEkjm276Up5taVp820=;
        b=LCnmv98yFk3t0xLleAbDjXpqUSXUe4CTn7EIS6uVu2hDYrIOsor5WWZf9AoJ9iYAlh
         7KEmIDepRi0t6HYYPDVoQQkBN1TKiWSR5G7lCd3BEnZj4PmCbeDO6qWN3XhHOJe2k5rc
         lkEXq48UsHIvRRKbjeqPMwbN+7pSs1T/2gjFOwEH7Y2TxGQn8ymfkmjuWTaq8uYq2i/a
         ovgzWjDIXRXI/BE5I+oKw/ZChzKRk127n7XbAsLPuC7M1vmbEmZVJK5fbFSpL7af84Lw
         W3bwQMlqs6mi39eU7QBcp0L5TrrVngt4N6bumvoVNW/rjPqWy9cJzRQXY10SSubvIyoN
         ZsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/RD5hHLuEtAj/FzoPif1UajBsEkjm276Up5taVp820=;
        b=L/zntlrdNcbKfOjrEu1XshgPNomshOlC+2VTuHBQjWhuRhbKwrUZfH4M3nlvPXhA+x
         yUx6t2imIZ7YPQvzG7zOPM1Yf5yOHvHI2Z+An/vPeEP7xXvLQ7/B2nhpKJWaVohWSyYR
         SSnltdIvBK6iY4pI1+yowijmhoiYhdFKJpYZ9y/Z05KOxL8rsDyqE/URB65pWCBeD7pB
         ChlefEiKNnH+X2UojEAbr4qoFnmfulbE2XYupaNaEaNNVaIAt5qHI5OtaTIX6Q3LcEj7
         apidiZgp+yftl0kU6y1hNp8J+i5KvmoclxB2fX19tJ7ytkaTtNz+Pkkc+RPFoUnNg2CD
         2zMA==
X-Gm-Message-State: ANoB5pke+8X2a6mOm7wgDadU5uqhebOubCdq0mY5CQXeC2Gqf/RJVrX3
        ONU4bT5uNvjSGMEQ2Bqa4F+jzQ==
X-Google-Smtp-Source: AA0mqf5mWFMg/PdRlmixBPZVoe2Lvk5H6sRTTnI2EyTlQiibBSHwxZPb7R/rzg2W7YYBZFAlkKJDRQ==
X-Received: by 2002:ac2:430d:0:b0:4b5:cda:44cf with SMTP id l13-20020ac2430d000000b004b50cda44cfmr4823620lfh.67.1670891076956;
        Mon, 12 Dec 2022 16:24:36 -0800 (PST)
Received: from localhost.localdomain (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id m23-20020ac24257000000b004978e51b691sm137352lfl.266.2022.12.12.16.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 16:24:36 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] arm64: dts: qcom: sm8150: Don't start Adreno in headless mode
Date:   Tue, 13 Dec 2022 01:24:21 +0100
Message-Id: <20221213002423.259039-6-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221213002423.259039-1-konrad.dybcio@linaro.org>
References: <20221213002423.259039-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that there's display support, there is no reason to assume the default
mode for Adreno should be headless. Keep it like that for boards that
previously enabled it, so as not to create regressions though.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150-hdk.dts |  5 +++++
 arch/arm64/boot/dts/qcom/sm8150-mtp.dts |  5 +++++
 arch/arm64/boot/dts/qcom/sm8150.dtsi    | 10 +---------
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150-hdk.dts b/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
index 3331ee957d64..0ee5309408b9 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
@@ -359,6 +359,11 @@ &gmu {
 };
 
 &gpu {
+	/*
+	 * NOTE: "amd,imageon" makes Adreno start in headless mode, remove it
+	 * after display support is added on this board.
+	 */
+	compatible = "qcom,adreno-640.1", "qcom,adreno", "amd,imageon";
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sm8150-mtp.dts b/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
index 46b5cf9a1192..9dfecbf89b21 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
@@ -354,6 +354,11 @@ &gmu {
 };
 
 &gpu {
+	/*
+	 * NOTE: "amd,imageon" makes Adreno start in headless mode, remove it
+	 * after display support is added on this board.
+	 */
+	compatible = "qcom,adreno-640.1", "qcom,adreno", "amd,imageon";
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index fad70032a98a..e160acb47cd9 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -2125,15 +2125,7 @@ compute-cb@3 {
 		};
 
 		gpu: gpu@2c00000 {
-			/*
-			 * note: the amd,imageon compatible makes it possible
-			 * to use the drm/msm driver without the display node,
-			 * make sure to remove it when display node is added
-			 */
-			compatible = "qcom,adreno-640.1",
-				     "qcom,adreno",
-				     "amd,imageon";
-
+			compatible = "qcom,adreno-640.1", "qcom,adreno";
 			reg = <0 0x02c00000 0 0x40000>;
 			reg-names = "kgsl_3d0_reg_memory";
 
-- 
2.39.0

