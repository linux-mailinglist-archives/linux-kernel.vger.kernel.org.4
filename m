Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D21C691CD4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 11:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbjBJKfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 05:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbjBJKe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 05:34:57 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E849D6D62F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 02:34:56 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso5946926wms.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 02:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HgLUw1PhteCNPI8sPDiupyYC9yeutB/HXKoZYukFVKI=;
        b=xLSuCxtgzIt1SrtWhhHQbOXoV910RujM7FZAYSUlNOYFH/wQwtAbjnP1PU89PRSWpq
         JG3c/DRgCgtvvyediOtIPoy4035xUKs9hdBJePfO42ZFaxPn5oI7RF5/I+faQdjnmB8v
         gws507y9JPogUHvr54LnbClFUBMjlqy1QWrw4u5EN8bfL6tCB0x/pqOqvB0sgFX7gzXG
         v2kTOGiLum/gfWjuUAbH04MK/Cr1e4FhjeQW/YZN/wjQxyzx5MPcK0/xcbuMjP4cfrWZ
         1wqpKBtkiP8dLxVyxUELvV36YfN6GssLDtS+d8wXN64heEqBayMH/+ej8R18Or0TqJzf
         VUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgLUw1PhteCNPI8sPDiupyYC9yeutB/HXKoZYukFVKI=;
        b=RKcYUzTwT8Ke2Cu9fpxAv0tFqkzXwPas17QXbTWkUOa3M5y1M10MnQ/qR/GhB4zYn5
         cN8IWfEE8rZ6946dYTOARNE2SvNLsecAyDb2in4K7D7cHU+fefdZw/s8LWmvzgXvgf2C
         9TSfm3Kjkm5P7vTY9S+SCcMr7RbUyCxP6IPmVcffcHDgoLmDfUljFJgRzEeZG0JgZzmC
         JuUGugXSEDkRQmOsFLGKZtnQOciywTaA28fWcLBYB8bnjA4jOoyqWAsiKVk3aO83pzWi
         52sJSrxZCV25ZJI3oeQ6UnDkmQZ6MOYifUkeuiv7Cfz4nodd6PF++X2pDYkn45o1D2sH
         sSaw==
X-Gm-Message-State: AO0yUKXjuORfQROUTMIPki0yf9GjyjyPSjxhUHX30kz1n/31sUxCC/4g
        p5FnVu2xld31hfQg/Hk6gtkg0g==
X-Google-Smtp-Source: AK7set9cuj8TlG1EIrMpXEoARaeczICbTNeZbhRngvYeX65Qs5XdVco0wZ80MHNMBz40jtEjjWmrwg==
X-Received: by 2002:a05:600c:340a:b0:3dc:45a7:2b8a with SMTP id y10-20020a05600c340a00b003dc45a72b8amr12542640wmp.10.1676025295517;
        Fri, 10 Feb 2023 02:34:55 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id b18-20020a05600c4e1200b003e00c453447sm7937958wmq.48.2023.02.10.02.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 02:34:54 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 10 Feb 2023 11:34:50 +0100
Subject: [PATCH v2 1/5] dt-bindings: display: msm: dp-controller: document
 SM8450 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230206-topic-sm8450-upstream-dp-controller-v2-1-529da2203659@linaro.org>
References: <20230206-topic-sm8450-upstream-dp-controller-v2-0-529da2203659@linaro.org>
In-Reply-To: <20230206-topic-sm8450-upstream-dp-controller-v2-0-529da2203659@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SM8450 & SM350 shares the same DT TX IP version, use the
SM8350 compatible as fallback for SM8450.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/display/msm/dp-controller.yaml        | 25 +++++++++++++---------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index 0e8d8df686dc..f0c2237d5f82 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -15,16 +15,21 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - qcom,sc7180-dp
-      - qcom,sc7280-dp
-      - qcom,sc7280-edp
-      - qcom,sc8180x-dp
-      - qcom,sc8180x-edp
-      - qcom,sc8280xp-dp
-      - qcom,sc8280xp-edp
-      - qcom,sdm845-dp
-      - qcom,sm8350-dp
+    oneOf:
+      - enum:
+          - qcom,sc7180-dp
+          - qcom,sc7280-dp
+          - qcom,sc7280-edp
+          - qcom,sc8180x-dp
+          - qcom,sc8180x-edp
+          - qcom,sc8280xp-dp
+          - qcom,sc8280xp-edp
+          - qcom,sdm845-dp
+          - qcom,sm8350-dp
+      - items:
+          - enum:
+              - qcom,sm8450-dp
+          - const: qcom,sm8350-dp
 
   reg:
     minItems: 4

-- 
2.34.1

