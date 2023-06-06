Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B70F7242C2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237472AbjFFMoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235673AbjFFMoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:44:37 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7F5170F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:44:13 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b1a4250b07so71473851fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 05:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686055450; x=1688647450;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VBUZ1meZbbD/0QuuPzRJYb6UmJbfmwDGrvNyug3ZzLk=;
        b=jnSK7+1zpmu991qwBvJ3ZIlu+slBKXGIaE6jPEh+vp4xRg4XK5Eg0Ulf+Dh4cvUger
         aVCFNYbhes3vqHGdfRUemxoEAFAVH1StyXTGhuaXHeT4EXnWTmtZ0iiPqlevEP+9BiJm
         OkmZt5nXShGf4ChSji90Kq7vSYB31u/f25sEM4OV5WecEdtV2clD0ym4yolryzqCc50z
         YEfsjEbEWYfJNZdquwFH4BYpge9qzfZS9QtRYWfgedfVXf25wrtVGFi65aMMoWJzfZs6
         uljNOg5AvakquOdwTs4PE++mwRYu3IUBCezN1fPaksOQoDCd7raQ3/blX4U1gVp0j1HF
         qiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686055450; x=1688647450;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VBUZ1meZbbD/0QuuPzRJYb6UmJbfmwDGrvNyug3ZzLk=;
        b=KuCtBNrfhLmizn+uXIK2xRLbYWm2jJTJsaTA8aY/L4Eq9FT8vThW671nfHfJgbNNAE
         +omWnGgCVnqcI6EWKU79AE8bKih3dFuXhU1Aj5WNfZbyCwLUUDUfoUpfPMwAzwskEZFr
         1TtizXXW84Vnc18kLRo7+bWdwG7HezRrILzsknh4J4afYvJ+iJ8qPGBMW8XhkOIMVNgj
         ICFZfuNYjcbreYmq65G5eZVn9q29tX8tOgpOmfdwKAdS0/BESVmTxBWN6zi8LEsEc341
         GmhFpTMf+NoZDYyne+Ika06HwqNKcUFGJaEHK61UYp98tj102sLvHZ7O5EKaHViL2BpF
         HfwQ==
X-Gm-Message-State: AC+VfDxW2v7OKXRRiXn22CnRRejurfolAwZEGg4vaCzHmVhVCM/kift9
        T0zGvxUNTTpU05YaMQktMQuujg==
X-Google-Smtp-Source: ACHHUZ5cXQn+wOXfu/FSV6zagKC6P/GKQV30mrRDGFF+nDCp51PKEcK6E+D5czHT1DI6IDbNtQ2YxA==
X-Received: by 2002:a2e:8195:0:b0:2b0:5a04:a5bd with SMTP id e21-20020a2e8195000000b002b05a04a5bdmr1206729ljg.42.1686055449867;
        Tue, 06 Jun 2023 05:44:09 -0700 (PDT)
Received: from [192.168.1.101] (abyl150.neoplus.adsl.tpnet.pl. [83.9.31.150])
        by smtp.gmail.com with ESMTPSA id u23-20020a2e9f17000000b002a9ebff8431sm1830823ljk.94.2023.06.06.05.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 05:44:09 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 06 Jun 2023 14:43:53 +0200
Subject: [PATCH v6 02/12] dt-bindings: display/msm: dsi-controller-main:
 Add SM6375
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-topic-straitlagoon_mdss-v6-2-dee6a882571b@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686055444; l=1145;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=JGKnL4ZgwMWnoMOWE82d7ZP3M4qFGKoVV5n7o2Z/y7Q=;
 b=lM/5jSBScLTQJPlH/4rHxJICwUc4pVMdaa7jz7nt1RK8NQYVckLGy55vAm97QbYEzpbzfXiDU
 CRpyempUinMAK9WwmDGdJUFc3uocptnLkZc6eiZUH1jAdgg5le/FicX
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
index 8081ced7b297..01848bdd5873 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -28,6 +28,7 @@ properties:
               - qcom,sdm845-dsi-ctrl
               - qcom,sm6115-dsi-ctrl
               - qcom,sm6350-dsi-ctrl
+              - qcom,sm6375-dsi-ctrl
               - qcom,sm8150-dsi-ctrl
               - qcom,sm8250-dsi-ctrl
               - qcom,sm8350-dsi-ctrl
@@ -368,6 +369,7 @@ allOf:
             enum:
               - qcom,sdm845-dsi-ctrl
               - qcom,sm6115-dsi-ctrl
+              - qcom,sm6375-dsi-ctrl
     then:
       properties:
         clocks:

-- 
2.40.1

