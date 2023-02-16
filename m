Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE46F699558
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjBPNOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 08:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjBPNOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:14:32 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE92432CF1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 05:14:30 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id g28so2776207lfv.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 05:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VVwCQxzpAEIpXPHUGXDu/BMLdh/4/iLGwabsMvVeo9s=;
        b=q03UgKpiEoJBmxNezi5NqpijnGwzNYxs5oGEGmO/NHMMDwx4dlrZVRvHQith9AcxGd
         +p0xzN/DvA1NpDiJUqGtbXEbqowlXnSPdVngC1rqUjrXIuoUYon7SYpu1eeC+feaZU/z
         0ES2jtb35DpDGqc/4bYzWGf6RJh/nTfH/jVcAgf2I9pSY1Me5MruXocXGdYMQElgOxgU
         +dWRVe7zZLJgEbuSbbsBTiGO/CONuAVO2mH2xPe0xKkFTzo+hmWlfYALMYfp8f4YCWsy
         TdUcE5xaHrFvih2uLcaqnD5Oc3Wfxdltob/6tIs4IgiuluW2QGH7wqsgGvFwC2HbqBEB
         8jCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VVwCQxzpAEIpXPHUGXDu/BMLdh/4/iLGwabsMvVeo9s=;
        b=oez50KCrvM10Rf31Ga0MlMozPSqfEupfDKTfjEMD9XT/t1l0bNWZbhKKCACCsdiv+8
         KKC0IHtTLScFJKdwODwAIM9/c3obTm9/uory8Umnrx8Pm3mRoe/+UOpTo7HGtW/V6ZHj
         s3pQn9vGlrUpXL5tppFmt0CeqvsKJJWqgdfuKVMRS0rrck8wnLsMdzDlPPRR/aNSAWhn
         p4qVVnkUyZ89AByKLxKxyBHxx1YSafuEmkpI7OgZb6UpYyZN7Bzw+CYr8FYMqPhzP9bp
         gbwtEqxPPl+jQNMsaawrkY3v0XuMlrXlGHAv36J54gXxwOrJKlAwuIzZYezC0B1xMMcB
         9xjA==
X-Gm-Message-State: AO0yUKV1B5YWaJ9aAb5rhe7uy7O74OZ4XpfHrvCLXMaUqBjjsUO11hqk
        MIAwmBw3FOGGXdqRfIV6wjSEaA==
X-Google-Smtp-Source: AK7set9PQdq/g/J4VmXzutAPqIkKGvuAGjNk9zhTJ0J8cTy2tvdj+6cVYtTdkp1c8gaa+9R44kCg4Q==
X-Received: by 2002:a19:f009:0:b0:4b5:b46d:e60 with SMTP id p9-20020a19f009000000b004b5b46d0e60mr1786545lfc.27.1676553269112;
        Thu, 16 Feb 2023 05:14:29 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id w7-20020ac25987000000b004d862e9b453sm290306lfn.196.2023.02.16.05.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 05:14:28 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: display: msm: sm6115-mdss: Fix DSI compatible
Date:   Thu, 16 Feb 2023 14:14:26 +0100
Message-Id: <20230216131426.3996378-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the DSI autodetection is bound to work correctly on 6115 now,
switch to using the correct per-SoC + generic fallback compatible
combo.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Depends on (and should have been a part of):

https://lore.kernel.org/linux-arm-msm/20230213121012.1768296-1-konrad.dybcio@linaro.org/
 .../devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml     | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
index 2491cb100b33..146d3e36d1c9 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
@@ -40,7 +40,9 @@ patternProperties:
     type: object
     properties:
       compatible:
-        const: qcom,dsi-ctrl-6g-qcm2290
+        items:
+          - const: qcom,sm6115-dsi-ctrl
+          - const: qcom,mdss-dsi-ctrl
 
   "^phy@[0-9a-f]+$":
     type: object
-- 
2.39.1

