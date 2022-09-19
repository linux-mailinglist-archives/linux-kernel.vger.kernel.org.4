Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E3A5BD6DC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 00:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiISWI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 18:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiISWIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 18:08:21 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC374E60B
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 15:08:20 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id e5so954858pfl.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 15:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=0uhb+h75Lws/eNCmPPe/5qfT854SCHIYjHdtTeIrM1s=;
        b=H/CVVGEfjX4VNoeOR6sVXR3j1N8GdiyewfD7qkleynNoSxCGFE68s0aVwiCR8RqQ/R
         sizBSu62MJdLGKsWNXgQ5BF4r70w+73Pj1CfFl8AUJGCq1j6TvOHmnAcWf8XW+a49dZE
         f1Ktr9S6wp9MJdmxYkosIqCLW50Oh3nx91kvzkqVAOfmWzhIJ4Qd/2z55VRYysFKA26m
         ZvmXX5iy5/tDVqaxr+NNUHbALwKlgWgRHvy93eJoo0Qm8up13YhX+xZZzzO4FTBMeU5w
         DMKYFMp6yBO3lqvaY+rOVQCzmyvaD3sXjoSzs/fny9TzvAoubQt+U9aeZFcnUnbMSaMI
         NCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=0uhb+h75Lws/eNCmPPe/5qfT854SCHIYjHdtTeIrM1s=;
        b=fizs90p+wnWV0vNtUPOpg9HGfJJ3ZHBF8PZnUo7ajgjJ62/b/6afxaxzReb5j/bwP3
         M8kJKzMqKNrk6ItjKDxVSU4/DsMd1ads7I9hPzeLK2jHWqOoN2SS9ul3DTEcA4UllDMh
         fTS4Oi5IqRNLiKl8Iu3538v/RTWjeA91Edaw6X43Gp6ZDPGshEMACknU0YKjBRMQcMU+
         QoxNJWVDZieP5UEqWEGCEtM9Ms4wIwX8ftjHY+X/ED1b4WdAWbY9huK8lpfcsIL7/0fT
         XQJuPtGtcWBXdT/D4elRPbqfDVM9QjpGZ27mmAHUZ7HhgspuDJ0/HNAw01q/3ceIeyeI
         W3QQ==
X-Gm-Message-State: ACrzQf0ezQag2Ww4vzURljbyz6jGfqRsqmu6aop2G4Bc1/3rtlNwNevG
        mAKCyMcy2r0J81Ubgk5cm/HwLw==
X-Google-Smtp-Source: AMsMyM70Y+b95Czu0Nv+1rBIAS3Sf4mjTd2oQ9LxfcHJ9f0fpYpNjD1kedH4P6Pp4L+3vcFDZeb1Zw==
X-Received: by 2002:a63:cf56:0:b0:439:41ed:78fc with SMTP id b22-20020a63cf56000000b0043941ed78fcmr18063162pgj.419.1663625300078;
        Mon, 19 Sep 2022 15:08:20 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c61:6535:ca5f:67d1:670d:e188])
        by smtp.gmail.com with ESMTPSA id u2-20020a17090a6a8200b001eee8998f2esm7068167pjj.17.2022.09.19.15.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 15:08:19 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, thara.gopinath@gmail.com,
        devicetree@vger.kernel.org, robh@kernel.org,
        krzysztof.kozlowski@linaro.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        Jordan Crouse <jorcrous@amazon.com>
Subject: [PATCH v6 1/4] ARM: dts: qcom: Use new compatibles for crypto nodes
Date:   Tue, 20 Sep 2022 03:38:01 +0530
Message-Id: <20220919220804.1047292-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220919220804.1047292-1-bhupesh.sharma@linaro.org>
References: <20220919220804.1047292-1-bhupesh.sharma@linaro.org>
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

Since we are using soc specific qce crypto IP compatibles
in the bindings now, use the same in the device tree files
which include the crypto nodes.

Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Tested-by: Jordan Crouse <jorcrous@amazon.com>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm/boot/dts/qcom-ipq4019.dtsi   | 2 +-
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index b23591110bd2..9c40714562d5 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -314,7 +314,7 @@ cryptobam: dma-controller@8e04000 {
 		};
 
 		crypto: crypto@8e3a000 {
-			compatible = "qcom,crypto-v5.1";
+			compatible = "qcom,ipq4019-qce";
 			reg = <0x08e3a000 0x6000>;
 			clocks = <&gcc GCC_CRYPTO_AHB_CLK>,
 				 <&gcc GCC_CRYPTO_AXI_CLK>,
diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index a7c7ca980a71..0ae3c601b279 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -198,7 +198,7 @@ cryptobam: dma-controller@704000 {
 		};
 
 		crypto: crypto@73a000 {
-			compatible = "qcom,crypto-v5.1";
+			compatible = "qcom,ipq6018-qce";
 			reg = <0x0 0x0073a000 0x0 0x6000>;
 			clocks = <&gcc GCC_CRYPTO_AHB_CLK>,
 				<&gcc GCC_CRYPTO_AXI_CLK>,
diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index a47acf9bdf24..0683ef931413 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -286,7 +286,7 @@ cryptobam: dma-controller@704000 {
 		};
 
 		crypto: crypto@73a000 {
-			compatible = "qcom,crypto-v5.1";
+			compatible = "qcom,ipq8074-qce";
 			reg = <0x0073a000 0x6000>;
 			clocks = <&gcc GCC_CRYPTO_AHB_CLK>,
 				 <&gcc GCC_CRYPTO_AXI_CLK>,
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index c0a2baffa49d..0dd6e1fea99c 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -755,7 +755,7 @@ cryptobam: dma-controller@644000 {
 		};
 
 		crypto: crypto@67a000 {
-			compatible = "qcom,crypto-v5.4";
+			compatible = "qcom,msm8996-qce";
 			reg = <0x0067a000 0x6000>;
 			clocks = <&gcc GCC_CE1_AHB_CLK>,
 				 <&gcc GCC_CE1_AXI_CLK>,
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index d761da47220d..4aa5a82bd265 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2566,7 +2566,7 @@ cryptobam: dma-controller@1dc4000 {
 		};
 
 		crypto: crypto@1dfa000 {
-			compatible = "qcom,crypto-v5.4";
+			compatible = "qcom,sdm845-qce";
 			reg = <0 0x01dfa000 0 0x6000>;
 			clocks = <&gcc GCC_CE1_AHB_CLK>,
 				 <&gcc GCC_CE1_AXI_CLK>,
-- 
2.37.1

