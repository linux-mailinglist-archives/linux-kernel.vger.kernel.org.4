Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430B67242BE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237439AbjFFMol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237684AbjFFMog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:44:36 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1C71708
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:44:11 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b1a6777dd8so72025301fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 05:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686055448; x=1688647448;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HwN0tI2Kl+T0HN09yLqjcLaiWYt+x33veuBBB/2tgTQ=;
        b=aVWZFuHUTRWDrX0ticH4FlzHopsuDKvHUr124ajPfFWICxW6XYstyo1cqBGcB1hjJo
         SzOlOJ3v3H0PXU2Z+AJTmtihRZbKjLYpP1pCRdnD/oD/6KPqgXrzjP15M442rAmVWF+w
         cXtw1HZdvMYKbMBpnASuMSyILmM1QqNn4IB0VCjqCvRWMiT3xVqUho8ukTIvHtcne2ND
         isBrW1qcAVtJafjViAOEcb0zs+8J8lrNNwNDyCyzZ17h7m0D4dGUlacHszw2bELdpIbT
         XIUJF7tAtVg26qTJ1sWSjFTGkZBvaAvZb7mu7PC4aPT+CkdXmIhmL9iS9e7+oVujy1TC
         8cOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686055448; x=1688647448;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HwN0tI2Kl+T0HN09yLqjcLaiWYt+x33veuBBB/2tgTQ=;
        b=BZQBaV7Tm+u7iZtDbm0Vf6jSV+yicWY+y6orqgk3cgZvzDS4ItuKkijEZOdlMRdHIq
         XchQKn2m9vL9dyqnOG9G+5BkUhm0Psxzg823SNqRvozb9H4gxe+c9pXCwwW3XHM9gMRc
         z8L+vc7IpOde+POzCLwKLsrNVioHPVXEGI/5u3m8Mz6iKlNtV7qFBTf3471+B751O/Z1
         rxtbAPrxKcvmshxz4y4G2mc6zmvSWhA7yKRZpfO9NEDQtUbFeF61cSI7wvY9Bols53OH
         7N0l5f4A/mBaQUR9VSVfRkywDA8XHb/HjmZSD03do/GfEWGXNfido+QMFc4hflvZz9dE
         Qoow==
X-Gm-Message-State: AC+VfDyTrDk0wbKuJMaR+IDLf77qvaj71UJb3kggF84sARiAOBGHeHBE
        NTkmO3pCms0LlpOU+u2TcgloCA==
X-Google-Smtp-Source: ACHHUZ6aO/1pq8KEvhZVd8M0EaZRDyi2x3/mS986KEl4lpoS9FLEUfcwiol40awMVLj9BbM/1PnLkw==
X-Received: by 2002:a2e:9258:0:b0:2ac:dd01:e169 with SMTP id v24-20020a2e9258000000b002acdd01e169mr993850ljg.40.1686055448226;
        Tue, 06 Jun 2023 05:44:08 -0700 (PDT)
Received: from [192.168.1.101] (abyl150.neoplus.adsl.tpnet.pl. [83.9.31.150])
        by smtp.gmail.com with ESMTPSA id u23-20020a2e9f17000000b002a9ebff8431sm1830823ljk.94.2023.06.06.05.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 05:44:07 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 06 Jun 2023 14:43:52 +0200
Subject: [PATCH v6 01/12] dt-bindings: display/msm: dsi-controller-main:
 Add SM6350
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-topic-straitlagoon_mdss-v6-1-dee6a882571b@linaro.org>
References: <20230411-topic-straitlagoon_mdss-v6-0-dee6a882571b@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v6-0-dee6a882571b@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686055444; l=1129;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=jRckpE5DBdoe5VmYMwGlXlu4F2L97YNKmiEsTH+Z5Jc=;
 b=kpFcKUbuEtgTQtQl2WDDIygCPWJ3FbhWGRd2lOkRMB99UVp6BQaxv4NPaP1Br9hU0SNvditq6
 nCiQe0g3DZXBUQZexQr5BOBbwfYCSYUsPu8ssuRodOg2s9+x9rkQOu6
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

Add the DSI host found on SM6350.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index 660e0f496826..8081ced7b297 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -27,6 +27,7 @@ properties:
               - qcom,sdm660-dsi-ctrl
               - qcom,sdm845-dsi-ctrl
               - qcom,sm6115-dsi-ctrl
+              - qcom,sm6350-dsi-ctrl
               - qcom,sm8150-dsi-ctrl
               - qcom,sm8250-dsi-ctrl
               - qcom,sm8350-dsi-ctrl
@@ -299,6 +300,7 @@ allOf:
           contains:
             enum:
               - qcom,msm8998-dsi-ctrl
+              - qcom,sm6350-dsi-ctrl
     then:
       properties:
         clocks:

-- 
2.40.1

