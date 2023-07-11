Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40ABC74EE90
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjGKMV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjGKMVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:21:17 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4ED2271B
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:20:08 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b701e1c80fso85717841fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689077957; x=1691669957;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9mLuew5zgjzaN+tG4LFNS3rreDraB5w4e3ZMY58XgsY=;
        b=vvxaGnbe11lhmDT+XdN0kJ6KKJi8aF2RjRLtmlE9A/ihPsDkHXzLPSlE6cBUKFMRKM
         ocULQm3cZBjoFQypFWDT3lKvD1WbYymmmLBoVzWPFBrEJl1ATzRP7D9ZGf8j6fMmEDXj
         GFWVLox34nTPw8KEs4hgvmcVUvxw1mI2T8AhkrNfkWsCsQ53Lt4PjvzKY2fNeZ+T+BNl
         BzeEg2oLZ59EXJsGvwvIanyHuxiUZOXOoVwvnApm7/Q1Ihu7eCOXH66xo75DaneWTE0M
         z2yzJcCn52VOdB91xGdqjsrC4fDKpINgZf1v3B4KSRwza6xjj5dEMShVNtOj6y4M8zJj
         p+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077957; x=1691669957;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9mLuew5zgjzaN+tG4LFNS3rreDraB5w4e3ZMY58XgsY=;
        b=WSEjHpTJeUa5DheXHyzWY8Zlq4RoeoDJrjIHMhKa8cYsIKq1Z8De4fKlCE7UXCUyVm
         pzgbp1jcnuBU5Ex+e3FQ/Ua+BuYA2pXogRVcNzF9DqqgMaAv2MRI3O+6inV+7ld8r9zw
         SEb5FNGHTm1BvoDTpRbLBrxvVe0MoVD32x2u/R0pv0QhMKw5xRx4G1wRiXOPfrXQcjsf
         CRuH5iyAWuAWVh6y2uCPbBL28mJEHJZG3/MS8egqm3eo2x5Id1MYTs3IcxgEISrO9mLP
         j4bIz7zntYdKjaMOrJzmWnWU/oSbgqgy2lfUgbgdN8RZuDdw840cT42Q2iQt9lAwujo8
         f86A==
X-Gm-Message-State: ABy/qLbthZHM0VZx7wvxuuVqy1nO20yuDZ1jrU+qzr7LmNGBvF3opSNw
        yHZw5+DgLqNJnRcjkTxEwiTsVg==
X-Google-Smtp-Source: APBJJlGa6PYiX6RAqLPgNrp8RP+7cwVVc6VZfagMsHb1oIMItRTj5g4Ls+QLw0+n+gYFG/dfd9Yrjg==
X-Received: by 2002:a2e:7802:0:b0:2b6:fcd0:2aa1 with SMTP id t2-20020a2e7802000000b002b6fcd02aa1mr14053280ljc.43.1689077957095;
        Tue, 11 Jul 2023 05:19:17 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:19:16 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:37 +0200
Subject: [PATCH 38/53] arm64: dts: qcom: sc8280xp: add qcom,bcm-voter-idx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-38-b223bd2ac8dd@linaro.org>
References: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
In-Reply-To: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=1056;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=hBBGgOqK76JiEy1Y4zr3la6Mn+bAAjoLLiY2eeUBjv0=;
 b=JKLU4Q8Oos+cK0u7H0/xlo8WQFeN27LnL/bSuf2rwkYhgICdcFnbjGEyukSjuv1FZhS/9OfPN
 H61d300OZhTBmJtnuW1aUe/Gejqhqj2u6mQF5et6yp7IJjx8G6/JlGE
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

To improve the representation and ease handling, identify each BCM voter

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 0756b7c141ff..67fe019b3c89 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/clock/qcom,gpucc-sc8280xp.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/clock/qcom,sc8280xp-lpasscc.h>
+#include <dt-bindings/interconnect/qcom,icc.h>
 #include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interconnect/qcom,sc8280xp.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -4303,6 +4304,7 @@ apps_rsc: rsc@18200000 {
 
 			apps_bcm_voter: bcm-voter {
 				compatible = "qcom,bcm-voter";
+				qcom,bcm-voter-idx = <ICC_BCM_VOTER_APPS>;
 			};
 
 			rpmhcc: clock-controller {

-- 
2.41.0

