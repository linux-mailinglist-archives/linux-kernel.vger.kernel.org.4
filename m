Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAC06BFA54
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 14:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjCRNnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 09:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjCRNm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 09:42:58 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6675427D64
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 06:42:56 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id x36so7789580ljq.7
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 06:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679146974;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gR7d4RO2oXpB/c3r0bQ4Ajknjymjb6WOVIZPuCDVi/s=;
        b=H+KKwkXjEOO0xzTuKFQmmnSBPzTcBRlFbmOuHHf0Uf1URi+8D0dsxGBIdjFfhSufft
         DrJpuK0pjFw5vgPotYM8FgqBQan/tczhlitMFlsrMRdr6y1YoAiafr7ZNKsSQhjxcP9i
         QdGlVVNlQVzg2orND8EdgzhC7jo6B2q11qv2GhzXuxoRIPLQsqaKpQR8yYmitCbxFlf6
         8ePht5xEcqLrc9tJ/+GOPrYedYc/80thHuI+k1zq2FBRjOTtam2lDB+hz6s/gbG+/4vc
         nKCUA3ZMHKf8TG1JhXh7229zquYFFboM05CWaQpMqtUQQcK0bYW25K/WR2h7EV2y+JD6
         bT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679146974;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gR7d4RO2oXpB/c3r0bQ4Ajknjymjb6WOVIZPuCDVi/s=;
        b=nFoa0pN6C+eo66Pk9EwmvkbEAqTgu88d59WORgPV4fNp7TXonNfYvb/Wo355aP00IC
         zuSyon7+2nRBnHpLgzVRCdG6GDUKvBrD5VKjGCr4Zvf3jC0ClOq8wmfq9N7gDlLBSyMv
         n30u5K/MVNKyaMUs/S+OCnsJNbO+NQqyH0D9AkfxczM7YA5RPifPKPeRY5sIVR+juSuM
         CJ84g7JKYsjVadWd8GDxrFO241kQvrxfe7I8kWyysaK1PcXHJsq7cUrobU4QFJY7cUv1
         oe8k5F+/kTpVUJoFJvD37iNmYXPnFTq3FtLg5d2cB6av4I6+8tcKxxB+E0B6yRyLjjth
         kY4w==
X-Gm-Message-State: AO0yUKUg1Rw6YqFR9Yec8ec8iWu508u+tRocG0eOYGmRSgjdUb4mQDLI
        uv0aOyQQOnSL1as5t8Cu5gPAfgW7J6222uHoTFc=
X-Google-Smtp-Source: AK7set9GN9auH9hYdKHl3gOJyNgaD+0SoeqFRn4nVBRLI6bcjVlPdnl1lVslCbG8ftxVuXbiMtxUiw==
X-Received: by 2002:a05:651c:391:b0:298:9db0:a9dd with SMTP id e17-20020a05651c039100b002989db0a9ddmr3848542ljp.50.1679146974706;
        Sat, 18 Mar 2023 06:42:54 -0700 (PDT)
Received: from [192.168.1.101] (abym238.neoplus.adsl.tpnet.pl. [83.9.32.238])
        by smtp.gmail.com with ESMTPSA id c2-20020a2e9d82000000b0029a0b50a34asm888367ljj.36.2023.03.18.06.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 06:42:54 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 18 Mar 2023 14:42:47 +0100
Subject: [PATCH v6 1/9] dt-bindings: display/msm: dsi-controller-main: Fix
 deprecated QCM2290 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230307-topic-dsi_qcm-v6-1-70e13b1214fa@linaro.org>
References: <20230307-topic-dsi_qcm-v6-0-70e13b1214fa@linaro.org>
In-Reply-To: <20230307-topic-dsi_qcm-v6-0-70e13b1214fa@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1679146971; l=1481;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=lSCVKFJ04QtIFibtVglZV7BCCs/8/zx27+lAfw7WMPU=;
 b=X/s/41QPUlm8nRs2vQaKIl635XNevr5YacB1S+xQkmK9HwhcN8L3ph+JFfv/IpLFvBj0pHm1IC6M
 af8muWHKDv5rbdPZkHE5JmnQP98Q8umthXsGYo2492dX8ODNKJbj
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The point of the previous cleanup was to disallow "qcom,mdss-dsi-ctrl"
alone. This however didn't quite work out and the property became
undocumented instead of deprecated. Fix that.

Additionally, the "qcom," prefix was missed previously. Fix it.

Fixes: 0c0f65c6dd44 ("dt-bindings: msm: dsi-controller-main: Add compatible strings for every current SoC")
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/display/msm/dsi-controller-main.yaml       | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index e75a3efe4dac..ecc89011bec4 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -31,10 +31,9 @@ properties:
               - qcom,sm8450-dsi-ctrl
               - qcom,sm8550-dsi-ctrl
           - const: qcom,mdss-dsi-ctrl
-      - items:
-          - enum:
-              - dsi-ctrl-6g-qcm2290
-          - const: qcom,mdss-dsi-ctrl
+      - enum:
+          - qcom,dsi-ctrl-6g-qcm2290
+          - qcom,mdss-dsi-ctrl # This should always come with an SoC-specific compatible
         deprecated: true
 
   reg:

-- 
2.39.2

