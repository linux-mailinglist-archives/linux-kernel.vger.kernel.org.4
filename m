Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E516E9F17
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 00:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbjDTWcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 18:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbjDTWcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 18:32:13 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33756A7C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 15:31:45 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4eca19c3430so961732e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 15:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682029903; x=1684621903;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J8QyMbXoOHe4maJ/141Gl2opRXdF3vmPM4GP90Suqw8=;
        b=I0RuJim/ZifvTMm7CVHkzXSjJOF2vA532KiwtNLFVTQXWBbhF+e+ARmTjaDBf18orf
         qiKADkH5X0erT010RrJfLz4JiZfUTBQc7LnyAcaj+kXCPtP8M26HKUaUBYcmqV3JSio1
         S0JmaO1Ubte8l9JRUmFkjhmj+gL5Fn27RRXMiCrkZacFiX+oNJ02ZpYQOPXkrT3fXswV
         upgGN5hgqC37TjWrUtT2TsWS1Di/+9IZzoWAl+LZj3XIq+61sTWVq8yl+sNFV5pUb4uM
         o7ddN/EfAW+F3mxpGcj2YWLcuCrMLKrcdKbyxgLN8tur0LLLWV/O9et6c8Hbry4HJtC3
         v9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682029903; x=1684621903;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J8QyMbXoOHe4maJ/141Gl2opRXdF3vmPM4GP90Suqw8=;
        b=aB0WUGx8x9aXfeaDbkwO89lhj5RH7NBkkb2QB6MdROHT56pqy/jMjqvwLk0Ro7WQan
         QYNZeoN+k+tHWoD/vtU8bfk6AEve3trF85gIwe+0wCENxIDEQ5DMf34sbAaHoEMeA5Mt
         Q5VZbQBjEoWhBqNn2PeTzpFzpG7XvJpyTBbT9J4q+sqkLeOWnpDz1cLsWgwrm+wUKfst
         Jc5TL+9uDxunYMterqO9e2owxgweyy00jvLnxNaS5fkXW0zW8KPM8gxsDtqCijugCCey
         VybuOsRverDLKtCZQb/hVt/gcN88Jsh2ExCQBpXp7bFCzMvZe3jVB0oD3KHwaqj7hvsI
         6Lsw==
X-Gm-Message-State: AAQBX9c0MCreMDGbu0e24Bc0Ti9nQZhhcbhvXzj/LUVRwCcMQmJUx96z
        dFVx4f/9xEPE7ikBg3vklw0mUw==
X-Google-Smtp-Source: AKy350a1EqNhSqyvroEQFXEC3oNWZWKJ59j7Y7boNYcM6me6/l6zelpIdJE5bpeODyX5Mgx2NKVt3A==
X-Received: by 2002:a05:6512:388e:b0:4eb:104b:bf61 with SMTP id n14-20020a056512388e00b004eb104bbf61mr801740lft.58.1682029903471;
        Thu, 20 Apr 2023 15:31:43 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id w8-20020ac25d48000000b004eedb66983csm324256lfd.273.2023.04.20.15.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 15:31:43 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 21 Apr 2023 00:31:22 +0200
Subject: [PATCH v2 13/13] iommu/arm-smmu-qcom: Sort the compatible list
 alphabetically
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-topic-straitlagoon_mdss-v2-13-5def73f50980@linaro.org>
References: <20230411-topic-straitlagoon_mdss-v2-0-5def73f50980@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v2-0-5def73f50980@linaro.org>
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
        Joerg Roedel <joro@8bytes.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1682029879; l=1047;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=4qlkXIpajO/screcnHozmWYEhsqRxqVWMGV9cb8adn0=;
 b=ku9MGWJ3g/n4SA+sMB5iIoSn/fJTWnS8wuxtVJXhCx8ML1znDgY0ILA0SMGsj+MXNuuj71iXZ8bD
 ZTVT1H7eBDFOQ12L6qLMqL1bRuGLZ14HOqrXVKTsCzbIlw32UOfb
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

It got broken at some point, fix it up.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 2daaa600ac75..e64c737724c4 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -251,12 +251,12 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,sc7280-mss-pil" },
 	{ .compatible = "qcom,sc8180x-mdss" },
 	{ .compatible = "qcom,sc8280xp-mdss" },
-	{ .compatible = "qcom,sm8150-mdss" },
-	{ .compatible = "qcom,sm8250-mdss" },
 	{ .compatible = "qcom,sdm845-mdss" },
 	{ .compatible = "qcom,sdm845-mss-pil" },
 	{ .compatible = "qcom,sm6350-mdss" },
 	{ .compatible = "qcom,sm6375-mdss" },
+	{ .compatible = "qcom,sm8150-mdss" },
+	{ .compatible = "qcom,sm8250-mdss" },
 	{ }
 };
 

-- 
2.40.0

