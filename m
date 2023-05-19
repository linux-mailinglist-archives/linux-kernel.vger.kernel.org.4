Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0AA709D75
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjESRGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbjESRFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:05:18 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2A61A1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:04:51 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f26f437b30so3998202e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684515890; x=1687107890;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ppRfvpEzKntx7DzSp5zW1I4Fc3JFfOMmEmtjxYhv2RE=;
        b=yZnkjyb5A5MRZrT7msho2TdEwx8Dqmdl0B1+Qt4i0PJCAiv4bnobpVDzlvnIruQItB
         XoCu4xG7Nfjv6Z6peYj61vwsgk6ofiR9alcV2/ycEaRC7ad5mDya5hHfrppcyWByinZq
         Tdr8+/XFuoSzn9gqR9msSt/y4LV3NbvRxhkEvBMmBmVh0nxee1rmWW0A3KIXeJxHPwrI
         bw0Ekg4Kmpz+N51bdOzZ7fYK+WcSAU3TgkiZ9tYYOmRI373nTnzP9VTNRR3HD0e+ZIIC
         jj2phM+S8mpheHMTyL1u1iyLkmRmZrD45qSRacNHX0C3wVdiqRc8YlvGpvxf0i6TZFT1
         DKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684515890; x=1687107890;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ppRfvpEzKntx7DzSp5zW1I4Fc3JFfOMmEmtjxYhv2RE=;
        b=lPR1aCFXDF58JulSXKTE8/AqVuO7nvroOWTvFbALabiboy96HnoytDJLj8svGtDXwE
         6qbPxQLYnihhuZECIjfv2tXjAMhOdRtf0w/KgitkNPFd/LopkoIPCTKW9y/EiE4GJ3b7
         tziWDJP5yVQQlJ1aUdYuYm2A495Tc/O++QcqkyUar5DFispXgS6bsyCSlcjf6bOo+OF9
         K7EcrjMTvtDb21mghwFZvF21y3DOHbzNQJkExL1LwN9zKv3lmgTI8iJHdKV4Wel69Tpf
         4iAUpl5nVowTDz6DEvFYHXnOYLWLnuQJjWxEFcg9Lkqji3JremzQpFizD8o/5xNRadmF
         lV1A==
X-Gm-Message-State: AC+VfDy/4uKSyO8ZQyiFiy7SP81sKBRr1+agi/f7FUqLNRUiqz0wDspe
        gvToG+NQiMcZBV/jnjRITWN1GQ==
X-Google-Smtp-Source: ACHHUZ4SdkxsWCzkHrPg/XhlGeB08jcKZiy+JJ8XYc5WTrd/LY7hhcZRCk5LoKthWwvQR4nh+Dy3Ww==
X-Received: by 2002:a19:f002:0:b0:4ea:fa07:1182 with SMTP id p2-20020a19f002000000b004eafa071182mr945077lfc.14.1684515889909;
        Fri, 19 May 2023 10:04:49 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id a6-20020a19f806000000b004f38260f196sm654478lff.218.2023.05.19.10.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 10:04:49 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 19 May 2023 19:04:31 +0200
Subject: [PATCH v4 10/12] iommu/arm-smmu-qcom: Sort the compatible list
 alphabetically
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-topic-straitlagoon_mdss-v4-10-68e7e25d70e1@linaro.org>
References: <20230411-topic-straitlagoon_mdss-v4-0-68e7e25d70e1@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v4-0-68e7e25d70e1@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684515870; l=965;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=9/++xt/utIOxLufVN9PZF2yMVmu78Xo8NRamuKy95SI=;
 b=IFT0R7GXWdOBF7o2llf/YR7q+v6c4wSJLLLXlQkT78L1b6w2wlyTtawVoAyaEvOvNO+cpgEI2
 iipx+WNKFSmADcnC6AgQgDR56IjlTcRn+t3vjytXV8Fupw7JEsRLp4i
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

It got broken at some point, fix it up.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index ae09c627bc84..f945ae3d9d06 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -251,10 +251,10 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,sc7280-mss-pil" },
 	{ .compatible = "qcom,sc8180x-mdss" },
 	{ .compatible = "qcom,sc8280xp-mdss" },
-	{ .compatible = "qcom,sm8150-mdss" },
-	{ .compatible = "qcom,sm8250-mdss" },
 	{ .compatible = "qcom,sdm845-mdss" },
 	{ .compatible = "qcom,sdm845-mss-pil" },
+	{ .compatible = "qcom,sm8150-mdss" },
+	{ .compatible = "qcom,sm8250-mdss" },
 	{ }
 };
 

-- 
2.40.1

