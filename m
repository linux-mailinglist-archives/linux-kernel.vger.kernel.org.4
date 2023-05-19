Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A2E709D52
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjESRFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjESRFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:05:06 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102CCE73
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:04:38 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f3b337e842so398161e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684515876; x=1687107876;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Olp/PVXIJr8fEMjOP3fCHDkSYD0xJnBud5aoQtWwMD4=;
        b=P9a3mKGxCtfXzLKVP5SAo8qOjOSf2qX1HaGd/cu8Xc9t6oXlMn3jlr7AlPWcfXUcGc
         uUhl0unwQ+QMiJ6B95v/v6z2cKzszb/5BcyqYLd7UX6POBBNCYBgyiW9RxMBgaN6hejk
         e5D56a96OYOJrhs0upUZj0VDGFDjlBPbXLW5Zn8C16wqz0mPgyN8kUQ3fqDgk7Namlas
         HVeSscM5QregjAWpfKtNE+sc6VScflt0U/8InDCjzdAoRKFZyZmym1t93dB0RircufHa
         bGbO6VyI3Gi0Ao+Ofz035mXiB43bMiH19+BPZ+69ER1Vz9PioKXed9KGziR2h0GuwWKh
         kjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684515876; x=1687107876;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Olp/PVXIJr8fEMjOP3fCHDkSYD0xJnBud5aoQtWwMD4=;
        b=LyLv5ezJwrupVWdZBg83JBwxjtlkeDHigxFu3YRBYs95E+OmCwB0rF/aQ3qKl68lJl
         vOuFsf4oCoauep1bbV2ugq82XURQDPsI6AMeVNQ3pG9K8vbffWeFykojAcNx4c5dmeVM
         mMMkICBNU20uhNsmw63/nzOC0o4nWwUs7RDSsr/nS9UbVP/oLIvS9o/jrxOKBnifvhx6
         LZm4R4CO/uFy9e/KrkVCGLNvb2cud19Y1dMaeoZZgHwyZ1eDB3x0hsRLEqPHY/gnLr1R
         psbfEHE5/yCwN7gZFOy2sIIquIHkXGU8yrL8IS6bjGhmCQkj0hMX7Dk39yHbvipXHo23
         ZPSA==
X-Gm-Message-State: AC+VfDwv3iqLbLMzOoETqaKwStII9xYLTIjUjz64/zln2jEZglt3xCJg
        FPT8ZMzjuK7RSn2to83abayJiA==
X-Google-Smtp-Source: ACHHUZ4IeHr3sqM5Wn5U1+TjNStYTlQDUVag+a9X5qZ3WvOtBOeS4Z5TH4sFCy3lI4XYAyk9EC+kwg==
X-Received: by 2002:ac2:4c90:0:b0:4f1:95cf:11eb with SMTP id d16-20020ac24c90000000b004f195cf11ebmr972148lfl.6.1684515876323;
        Fri, 19 May 2023 10:04:36 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id a6-20020a19f806000000b004f38260f196sm654478lff.218.2023.05.19.10.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 10:04:35 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 19 May 2023 19:04:23 +0200
Subject: [PATCH v4 02/12] dt-bindings: display/msm: dsi-controller-main:
 Add SM6375
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-topic-straitlagoon_mdss-v4-2-68e7e25d70e1@linaro.org>
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
        iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684515870; l=1145;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=VsWoYP7GHCgHOv33piyXwEtJ6/KtKH5SJYQ2EDUVEdo=;
 b=QPzbrNxaTLE/p9WkBiuxekU0fx4pSTlLLWeihi35wm/6b4DUhAxEznO6YIPT1cqT9vE73a++B
 KIBa/uP4RVtC4cpGHCHGC0eyloeNuPrCeuqwfmpNxDSXB2Gr7rCN3Yh
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

Add the DSI host found on SM6375.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index 6f367a1fabf8..f7dc05a65420 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -27,6 +27,7 @@ properties:
               - qcom,sdm845-dsi-ctrl
               - qcom,sm6115-dsi-ctrl
               - qcom,sm6350-dsi-ctrl
+              - qcom,sm6375-dsi-ctrl
               - qcom,sm8150-dsi-ctrl
               - qcom,sm8250-dsi-ctrl
               - qcom,sm8350-dsi-ctrl
@@ -354,6 +355,7 @@ allOf:
             enum:
               - qcom,sdm845-dsi-ctrl
               - qcom,sm6115-dsi-ctrl
+              - qcom,sm6375-dsi-ctrl
     then:
       properties:
         clocks:

-- 
2.40.1

