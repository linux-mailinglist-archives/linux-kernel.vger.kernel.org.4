Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2E86E4D4E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 17:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjDQPbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 11:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjDQPbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 11:31:40 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C790B46E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 08:31:02 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4ec94eb6dcaso1568363e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 08:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681745428; x=1684337428;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hUGnN7QmHFXWvkEalaWeWFmgMZnzSnPU7k2aFfVSknQ=;
        b=b48X3TNr8x0xwcnL9k2Alm3yyl/qFo8VMA9g3p2UCJmh7v3XG+eV0kL8LoTcNHq+e+
         hrTlFeselhHOQp9hqlV/QkxOl6XD0LnF/pvdpgwh8mtfIPUKusX5lKkPrgtLWJUJo5GR
         7L+QNLIXQVcU6p/AY28X4eOm4EZU5zUTdu79KV2Ylb78O1uDB9FTod9tn4iCWaNQ+WUQ
         H4RDaET6z7Qx/Px37ZY7KAOOmcXr0imjCXximuEsz1scm+kX7B0dis5bbSdguzMuluiK
         ZiMTC6p7CuW7p8t3SaywKuARPlwH9zbzGzb2dgWBFJbBGsF1nPXjKtPLqeXVo6EAqnUJ
         Pvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681745428; x=1684337428;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUGnN7QmHFXWvkEalaWeWFmgMZnzSnPU7k2aFfVSknQ=;
        b=SM0okXujoi4JJMgkf5RorxHQ3txe4iGeDDa7gvvnJWiuXtMIMrhBzPU/W/IGszcgqu
         fcctp+6W8qIt9DXx2m37vgoKSrh2kcS/fEmtZnvAnjnog99y2KL9EDXu5RWwTcl21Y60
         gqLI9A+p3BP7wnOJpiDBOIiOocdi8/kzAj6bqEuOHK9lKsrPUhw7tnPHVy+/VZ7I/Uv8
         DaUXgLjpt3T4vjwQrKu1K4VFIZBQXUe3HcpCMfkSbQqOyc0pcQJdNaDpikhITcIiz9Iu
         vY/r13UOWMqIQ34Hp6BdfHu8ciMUFSiWXgbr7epYye9k+5eJsFZ8vG7U0h9Hw5UtMhyZ
         Lkdg==
X-Gm-Message-State: AAQBX9fjR29s49q2MJCs0IPOYy8BJEZM4eivaH51dYrAo35UL6F+wycK
        dCKExX/NiIHSPb/cfVPUx0FXIAMbd6PQIq1pJbU=
X-Google-Smtp-Source: AKy350aVcGCz0I18YLBMozsCg0j2xuZX+ENATzTw/Z9m/9K5H3xo357Cw68Kxt0jP4lRQZo7OjAxwA==
X-Received: by 2002:ac2:42ca:0:b0:4ec:b1bf:a562 with SMTP id n10-20020ac242ca000000b004ecb1bfa562mr2112180lfl.51.1681745427914;
        Mon, 17 Apr 2023 08:30:27 -0700 (PDT)
Received: from [192.168.1.101] (abyk99.neoplus.adsl.tpnet.pl. [83.9.30.99])
        by smtp.gmail.com with ESMTPSA id b16-20020ac25e90000000b004ec8a3d4200sm2053439lfq.293.2023.04.17.08.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 08:30:27 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 17 Apr 2023 17:30:17 +0200
Subject: [PATCH 3/5] drm/msm/mdss: Rename path references to mdp_path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230417-topic-dpu_regbus-v1-3-06fbdc1643c0@linaro.org>
References: <20230417-topic-dpu_regbus-v1-0-06fbdc1643c0@linaro.org>
In-Reply-To: <20230417-topic-dpu_regbus-v1-0-06fbdc1643c0@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681745422; l=2175;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=mFT0UyX9LhxCNCpprLZW/XLO+LLNqKMZSGZE8MZeFUU=;
 b=BXHtHcUcP4g/hixvZ0bGJVRvqCP7askf6+3q9wseZvQ/7VfvWeLIM9JhT3BU/O5D9uFsmsKTreg+
 diV6OtW0D5MqNkqhqHE4VLhrMAs+6iejgdtaEbsRGpVZvrINpjs1
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

The DPU1 driver needs to handle all MDPn<->DDR paths, as well as
CPU<->SLAVE_DISPLAY_CFG. The former ones share how their values are
calculated, but the latter one has static predefines spanning all SoCs.

In preparation for supporting the CPU<->SLAVE_DISPLAY_CFG path, rename
the path-related struct members to include "mdp_".

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/msm_mdss.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index e8c93731aaa1..9e2ce7f22677 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -48,8 +48,8 @@ struct msm_mdss {
 		struct irq_domain *domain;
 	} irq_controller;
 	const struct msm_mdss_data *mdss_data;
-	struct icc_path *path[2];
-	u32 num_paths;
+	struct icc_path *mdp_path[2];
+	u32 num_mdp_paths;
 };
 
 static int msm_mdss_parse_data_bus_icc_path(struct device *dev,
@@ -62,13 +62,13 @@ static int msm_mdss_parse_data_bus_icc_path(struct device *dev,
 	if (IS_ERR_OR_NULL(path0))
 		return PTR_ERR_OR_ZERO(path0);
 
-	msm_mdss->path[0] = path0;
-	msm_mdss->num_paths = 1;
+	msm_mdss->mdp_path[0] = path0;
+	msm_mdss->num_mdp_paths = 1;
 
 	path1 = of_icc_get(dev, "mdp1-mem");
 	if (!IS_ERR_OR_NULL(path1)) {
-		msm_mdss->path[1] = path1;
-		msm_mdss->num_paths++;
+		msm_mdss->mdp_path[1] = path1;
+		msm_mdss->num_mdp_paths++;
 	}
 
 	return 0;
@@ -79,16 +79,16 @@ static void msm_mdss_put_icc_path(void *data)
 	struct msm_mdss *msm_mdss = data;
 	int i;
 
-	for (i = 0; i < msm_mdss->num_paths; i++)
-		icc_put(msm_mdss->path[i]);
+	for (i = 0; i < msm_mdss->num_mdp_paths; i++)
+		icc_put(msm_mdss->mdp_path[i]);
 }
 
 static void msm_mdss_icc_request_bw(struct msm_mdss *msm_mdss, unsigned long bw)
 {
 	int i;
 
-	for (i = 0; i < msm_mdss->num_paths; i++)
-		icc_set_bw(msm_mdss->path[i], 0, Bps_to_icc(bw));
+	for (i = 0; i < msm_mdss->num_mdp_paths; i++)
+		icc_set_bw(msm_mdss->mdp_path[i], 0, Bps_to_icc(bw));
 }
 
 static void msm_mdss_irq(struct irq_desc *desc)

-- 
2.40.0

