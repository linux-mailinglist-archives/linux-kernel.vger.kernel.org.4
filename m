Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4F773A03E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 13:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjFVL6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 07:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjFVL6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 07:58:09 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A489210B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 04:58:02 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f955850e30so683090e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 04:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687435080; x=1690027080;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qd4+5bYIJSD1AWeQPTgthQXsn71VUDPalDNC260pIEQ=;
        b=s0PIpjdHBrUCmeQJXzRAvu/7Mwfkh5y9yHnSBMd/UCbKepsIHfBNbp1Ck5i4GSkk6W
         Ypof/0JQ4qeLyg4e5sM0TyAwowvArVeU+FnQO5mXoIoyqEkvCdwiL/a9jT8baQZVWdjH
         jjKfLQOfsufM6WNmjlKHKSF0P/FbW/XEtI57A6VQfdtDuaiM8Gb+8DdXzFH6BBk+Mmml
         c/bL5/g5YiZm2g2pe9Tqrj+8sM7xfOeGQNYsvesoY7ak0ZaU6cDeHfjQn+1EVGrPf79y
         rwtB4glx+8vV1qCKtbx9jrcnsU1UeQCLQDGvwmw6fG8TZkZo4aUwQkL/ge9wGP9adtl4
         E1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687435080; x=1690027080;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qd4+5bYIJSD1AWeQPTgthQXsn71VUDPalDNC260pIEQ=;
        b=KM4IPp8G9Vadvdfyt6TeydcH9n6pRj8MTe5SSLr8bq5ueI9UwaQUpLAPZAu8bxqMT0
         jHn2khvl/SwNYrbehsHhB/u5AzLjK7sKyjmrRuG9/mdwkMSw+ZAsJJMRu+WtPZXehYyX
         S1A81WZwIr6x0Jj0w7/txrKp7HnNsR2HKDCJcVqBFAp4D/QhMUw8eFmEyQtKoIEY3Qge
         teITOEgPBnDnLuGPsQcmbgUPc1Db5Ga1lO0rNlNdE9+mylbjs5vAuJeWgSN0z9tmXj4u
         a1n+HZs7miPbMKWSleZursN8cr2fW73a/eBRMKmXeUOBVN+fvoLr9+Slw1lyDD72jfuE
         ZvfQ==
X-Gm-Message-State: AC+VfDxgsNmzuWC0SacvvOGXPcHppBKp0n6hU4AQoQTVhmaoxtWZ6YJ4
        klyA3N0DA5bm95wwUioxf5vplQ==
X-Google-Smtp-Source: ACHHUZ6mSwfTPRX+hOMQU4jgq9OD77Do6O2v/qGaMaDRKmBcy6Ihebui932eq6rSNRtrcEfrp5P2Cw==
X-Received: by 2002:a05:6512:12d1:b0:4f7:65a7:4d94 with SMTP id p17-20020a05651212d100b004f765a74d94mr8080678lfg.7.1687435080447;
        Thu, 22 Jun 2023 04:58:00 -0700 (PDT)
Received: from [192.168.1.101] (abyl165.neoplus.adsl.tpnet.pl. [83.9.31.165])
        by smtp.gmail.com with ESMTPSA id eq21-20020a056512489500b004f4c3feb9fbsm1099235lfb.61.2023.06.22.04.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 04:58:00 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 22 Jun 2023 13:57:49 +0200
Subject: [PATCH 9/9] arm64: dts: qcom: msm8998: Use the correct GPLL0_DIV
 leg for MMCC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230622-topic-8998clk-v1-9-5b7a0d6e98b1@linaro.org>
References: <20230622-topic-8998clk-v1-0-5b7a0d6e98b1@linaro.org>
In-Reply-To: <20230622-topic-8998clk-v1-0-5b7a0d6e98b1@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Taniya Das <tdas@codeaurora.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687435067; l=1056;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=gJtjlM23H/np8JPlgrRMMzMMmFruemZY5INaIEO4+Kg=;
 b=ZOzGxwxyKdjB5CuoCZtPs1vOWhS12y7dZRhQ3MdXQ/4bwzI2xByM4FWZDx1OQatfW2recggXb
 6Hy5kqKivQtDFlZuMQ0ki2sV22O+49Wdan7ocq1Q56hCZGjMNz5OB1y
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MMCC has its own GPLL0 legs - one for 1-1 and one for div-2 output.
We've already been using the correct one in the non-div case, start
doing so for the other one as well.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 74bd05579796..c4faba092368 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -2718,7 +2718,8 @@ mmcc: clock-controller@c8c0000 {
 				      "dsi1byte",
 				      "hdmipll",
 				      "dplink",
-				      "dpvco";
+				      "dpvco",
+				      "gpll0_div";
 			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
 				 <&gcc GCC_MMSS_GPLL0_CLK>,
 				 <0>,
@@ -2727,7 +2728,8 @@ mmcc: clock-controller@c8c0000 {
 				 <0>,
 				 <0>,
 				 <0>,
-				 <0>;
+				 <0>,
+				 <&gcc GCC_MMSS_GPLL0_DIV_CLK>;
 		};
 
 		mmss_smmu: iommu@cd00000 {

-- 
2.41.0

