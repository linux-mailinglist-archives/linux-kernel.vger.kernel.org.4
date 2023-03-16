Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1393C6BCA07
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 09:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjCPIw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 04:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjCPIw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 04:52:26 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A97B6928
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 01:51:24 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id f16so833178ljq.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 01:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678956678;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FyfU1KJpQXcUs5jhogFBaoFTlgPH63DY/U4xjNHTWjQ=;
        b=GVmkANiUKzqsxfD8qE2iPUWkvUhJ/HzvfWw1Dliysqxk4sB8mXoZ9qRqQ/bjIqWTYY
         +96IqV9GT0cjHMbBllayjzzkmU04uve1BpJKTolaOvuxUGLB0C9Q54+mAbmpgAOaEKRN
         cFgKdSeSIFBA9h9x/6QLpJk9FKkoizH6in3GYnnh0Oxu3fw/socVTYoYz1nsZfYB5rrh
         mjPSNO/LE54ep0NDVEZfovEYzitlfNDsp8OCw8Qv21w6SNwvfu0pjwVeUSnmWNP8haYo
         vicBPhw8JREVjuYDic/lf85fY7FZLbwSJjjJyD+I6T68BCa24+kdy+ZJwpvMzcjlDSch
         VlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678956678;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FyfU1KJpQXcUs5jhogFBaoFTlgPH63DY/U4xjNHTWjQ=;
        b=OHCMjTwb8e9iJResxqKeR21ut8uRsWhdZO1sv4dl9hooEbMmiczUKNlbbAdxG8rRQh
         Ggu37TG7p6XgdJITmiT9iaRP0B6ob+x0UsAyy7w0m16B6dwiQNHvuHQTJS/ctwTL13VZ
         6ghV3mbl43/kSjsU02ZT8AVwmun8V75fqxnLNWuQsGnyAmy98RRnl1w9mlcxObqKuwd8
         GOnebUMSvmegsHRxsTGPIrGoasAcFKK0xb7CjeVeQLmzKJi0dQwZBwrZfrj70rlnEbxh
         nFGj7qoGIJumwt/di2BipBPD04Yujt6c8drD9AVX8IhxrggzRxeLu8ElzMDdg4Bv/QK7
         Z7YA==
X-Gm-Message-State: AO0yUKXmoD37WitSTLdohFey009lToMlurF1sfiGU/aL6Qp8I4KL6wL8
        iC7JkF6PlvNGX+wk2pqOOyzUvA==
X-Google-Smtp-Source: AK7set88JzAx3XXuUlQBet7+3BDgmO2U3N7bMdqpCAlN7dxwhc05DzBxKegTLBqJ7UBI/B/QPBGPQQ==
X-Received: by 2002:a2e:9682:0:b0:299:aa9d:cea1 with SMTP id q2-20020a2e9682000000b00299aa9dcea1mr319553lji.47.1678956678537;
        Thu, 16 Mar 2023 01:51:18 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id o11-20020a2e730b000000b002991baef49bsm251566ljc.12.2023.03.16.01.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 01:51:18 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 16 Mar 2023 09:51:11 +0100
Subject: [PATCH v5 05/10] drm/msm/dsi: dsi_cfg: Merge SC7180 config into
 SDM845
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230307-topic-dsi_qcm-v5-5-9d4235b77f4f@linaro.org>
References: <20230307-topic-dsi_qcm-v5-0-9d4235b77f4f@linaro.org>
In-Reply-To: <20230307-topic-dsi_qcm-v5-0-9d4235b77f4f@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678956668; l=2206;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=+ePdH/Gl1hrkxIW7hm63Vg7SPtBJUhhLLi5EVaR0ltI=;
 b=8w//WdCiKTQ1Q2mhPCF/4PAiIaiCmaFTpPkBRC3P/oNR0L6U5mJ93AkvvZdml7I4DSw1vUGThg5m
 +c0fcqs/A/gr4u5jrlAebphEnTwXQjUTFvQNHhrO7qkuDhYuOU8S
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The configs are identical, other than the number of *maximum* DSI
hosts allowed. This isn't an issue, unless somebody deliberately
tries to access the inexistent host by adding a dt node for it.

Remove the SC7180 struct and point the hw revision match to the
SDM845's one. On a note, this could have been done back when
7180 support was introduced.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/dsi/dsi_cfg.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
index 039f503233d7..03d98cbcc978 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
@@ -169,7 +169,7 @@ static const struct msm_dsi_config sdm845_dsi_cfg = {
 	.bus_clk_names = dsi_v2_4_clk_names,
 	.num_bus_clks = ARRAY_SIZE(dsi_v2_4_clk_names),
 	.io_start = {
-		{ 0xae94000, 0xae96000 },
+		{ 0xae94000, 0xae96000 }, /* SDM845 / SDM670 / SC7180 */
 	},
 };
 
@@ -188,17 +188,6 @@ static const struct msm_dsi_config sm8550_dsi_cfg = {
 	},
 };
 
-static const struct msm_dsi_config sc7180_dsi_cfg = {
-	.io_offset = DSI_6G_REG_SHIFT,
-	.regulator_data = dsi_v2_4_regulators,
-	.num_regulators = ARRAY_SIZE(dsi_v2_4_regulators),
-	.bus_clk_names = dsi_v2_4_clk_names,
-	.num_bus_clks = ARRAY_SIZE(dsi_v2_4_clk_names),
-	.io_start = {
-		{ 0xae94000 },
-	},
-};
-
 static const struct regulator_bulk_data sc7280_dsi_regulators[] = {
 	{ .supply = "vdda", .init_load_uA = 8350 },	/* 1.2 V */
 };
@@ -291,7 +280,7 @@ static const struct msm_dsi_cfg_handler dsi_cfg_handlers[] = {
 	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_4_0,
 		&sdm845_dsi_cfg, &msm_dsi_6g_v2_host_ops},
 	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_4_1,
-		&sc7180_dsi_cfg, &msm_dsi_6g_v2_host_ops},
+		&sdm845_dsi_cfg, &msm_dsi_6g_v2_host_ops},
 	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_5_0,
 		&sc7280_dsi_cfg, &msm_dsi_6g_v2_host_ops},
 	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_6_0,

-- 
2.39.2

