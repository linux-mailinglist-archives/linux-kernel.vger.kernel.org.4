Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F5070D75A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 10:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235911AbjEWIZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 04:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236229AbjEWIYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 04:24:53 -0400
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42572111
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 01:22:20 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4f3b9755961so3104120e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 01:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684830079; x=1687422079;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+njLtj9xbvOIFM7dHEkaORkCFR8dY1HcWLWxadiCjHQ=;
        b=XAOsXQw2lAaRRnIy4XpH/8q6eFR6AzCz4vuatCcTJ2gv86nTxBndezEUE4DRpsRFB4
         UKBEgY8HxRdXFAg1QT0jpYK92whTjyvCKSN2T2Hr3Qb1DuX6HeaAmyi80UZaOt0oo9rO
         12RpW7PlV6vXngud6A/JW5lrYQrSlQfya4O524TjrdpzxssrALZ8DEAvmpXoTpaLi3mq
         VUK9H7tJ2AOPGlB+Znd9d9wRo3MH3T+CsykUkYmJ5kWj9he6/tBFQaJVGXDKaTyQRxjF
         nI+UYdC7r6kX95Idy6QYstOOft5PAIdn7wDqBTLxB0B07hCobJeP5oCZfKC+QFRk6ldm
         RQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684830079; x=1687422079;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+njLtj9xbvOIFM7dHEkaORkCFR8dY1HcWLWxadiCjHQ=;
        b=LgZLXr0uItxv7FafH+mcyOyJcWGzCIKCeIol6qZtX/r2FfAaEcYy9nXrXHzZMo7+PA
         BDlmkFS13jU6Xdkv5Vxlvx/fiHoFRWN4s35VZ6/f+tyOKBVZj6CMaOZWy1u1dzeOnYoa
         Y7+UdyJi/KDyyDu9j1WWocEuUQCABLys81uzBbKXoPqSN7Txm0gJmx3lE+eEGHYLgH+p
         f8VOtF75/6+ptDD1C80+sXLaWNIcyEITRVkPkcCQX3ntQZnfJee+IJs7luhEATeAKhbx
         08M41hq2UFDloCXyCjjK9BgoxiGXs1lfhjT5blrKqPoQl2QPMR+aJYRRQCc5/owIfJyY
         ClHg==
X-Gm-Message-State: AC+VfDzGLX7+psPy8WCX01yyJXibzGZ/1MklJbj1TlGEf5GX0DM4FNWV
        vyHOKueF/tLTsg9DCOankqinoSGu4fTlEXg8Kdo=
X-Google-Smtp-Source: ACHHUZ6Z1IporAEVTmntbzww2mlpou5nSlMKw864voVy8UcwTx7EkZjpX4C/Gxnrt4UFoN9aF+FP5Q==
X-Received: by 2002:a19:ad02:0:b0:4f3:7b3c:2e16 with SMTP id t2-20020a19ad02000000b004f37b3c2e16mr4243599lfc.39.1684828008720;
        Tue, 23 May 2023 00:46:48 -0700 (PDT)
Received: from [192.168.1.101] (abyk138.neoplus.adsl.tpnet.pl. [83.9.30.138])
        by smtp.gmail.com with ESMTPSA id t9-20020ac25489000000b004eb0c51780bsm1257070lfk.29.2023.05.23.00.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 00:46:48 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 23 May 2023 09:46:13 +0200
Subject: [PATCH v5 02/12] dt-bindings: display/msm: dsi-controller-main:
 Add SM6375
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-topic-straitlagoon_mdss-v5-2-998b4d2f7dd1@linaro.org>
References: <20230411-topic-straitlagoon_mdss-v5-0-998b4d2f7dd1@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v5-0-998b4d2f7dd1@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684828003; l=1145;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=1vb4mQXJIaOy+L2bFISsNkN0kUA69WSBSqQBJvQrOv8=;
 b=CBoqH84rn/pGKj9+tRprI5mq7KUtB5xc8n/iP2tnHJB7nuo3bD0S+ruz8fSKu0FIa/VAcT8yg
 /AEykRyGeNKCgjUs5bmGWxRpZkDJKXvjg9dSfvoyQFAbIoAeaTXT/oR
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
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
index 43f801a94d79..0cb1198eb3d0 100644
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
@@ -366,6 +367,7 @@ allOf:
             enum:
               - qcom,sdm845-dsi-ctrl
               - qcom,sm6115-dsi-ctrl
+              - qcom,sm6375-dsi-ctrl
     then:
       properties:
         clocks:

-- 
2.40.1

