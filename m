Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8BE6F8B62
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 23:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbjEEVlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 17:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbjEEVlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 17:41:37 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C499459ED
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 14:40:46 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2ac770a99e2so25626681fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 14:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683322845; x=1685914845;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Olp/PVXIJr8fEMjOP3fCHDkSYD0xJnBud5aoQtWwMD4=;
        b=bcyb7PU+mB0xuZcC98A3z4xrQTA4cCO9fBd6WOSZ4BXU+qSJ1uguBXdCQkKkfa1qOG
         tz29LlHe+jDhfBGEkFjUPX0kG/zMnGQdZaUbfQGKVC24x4niiJcGNPPWgl7i8TZEGNgy
         zKaTUKwGCrCIiCDNEutlCwoHmLJVBCSeUhO+emE5U24E0omFmV1YfVxmBKvL5bsPsNb/
         CvU5JYSMOwJrZmG3cpVKwpR/DwiFu6t/cGXEaeJzn/dSt0Glh6iKohWshJo9Q21rz8DN
         vmzfXNbcmz8axbxYCWdVpFDXPsbEUSf3l2CUlGgX6r3WJ1n0PqpnxZs7iJ2vu3RlcxlH
         j+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683322845; x=1685914845;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Olp/PVXIJr8fEMjOP3fCHDkSYD0xJnBud5aoQtWwMD4=;
        b=YfYT3ey++ikKX5xjobexXr3s4/3zfAqx7MZi2vES1UaTe0oKUwFVK5VK10dZ5Cr1ab
         F8w7qZE3iVd/4nNpUTAFV2rfKHJQrjfRigRNo1CHc61AHQVwUUv9WgxWv9AEngL2rXx0
         5k1z+BxSBT4xfPyfBVXXt/KMVHdkUekoZTdUIkuCHU8w2v15rYtwzouLB+vckDK9AIwN
         K7S0XCnbE9S7oNOClsnI8ijv4fP/IPNhO8m4cDiauY+1oNBFMti4AMeT5/ssslxZODPX
         qHjYo5o3I1e1ObWzQB+/EbvEhPTxfGhSLsLVSsEkJdGWet83XUNfM1wZVYTILUj0lL1J
         oHaQ==
X-Gm-Message-State: AC+VfDyFCcEO45KDzdJzxKSse+1knGqKZ/BTg8TWWnKeWFEuZAkqLgyP
        /BrQErf3APG9KV0QqBNjwYCagg==
X-Google-Smtp-Source: ACHHUZ4gXaB+RYZgmcooayAAK8tmsa/H8nYRTCwojYzNiGeovBEiytzLG1KPmci+aNtG4Z3ZdQlYPQ==
X-Received: by 2002:a2e:8815:0:b0:2a8:bf35:3b7 with SMTP id x21-20020a2e8815000000b002a8bf3503b7mr821445ljh.32.1683322845019;
        Fri, 05 May 2023 14:40:45 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id n12-20020a2e720c000000b002a776dbc277sm126453ljc.124.2023.05.05.14.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 14:40:44 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 05 May 2023 23:40:28 +0200
Subject: [PATCH v3 02/12] dt-bindings: display/msm: dsi-controller-main:
 Add SM6375
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-topic-straitlagoon_mdss-v3-2-9837d6b3516d@linaro.org>
References: <20230411-topic-straitlagoon_mdss-v3-0-9837d6b3516d@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v3-0-9837d6b3516d@linaro.org>
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
        iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683322839; l=1145;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=VsWoYP7GHCgHOv33piyXwEtJ6/KtKH5SJYQ2EDUVEdo=;
 b=+3R0ILIrXzT82PWwbsl52w/wP4I53hpnomknSN5Kg5vAI7isrjcQm4SRnGPHieDAD+1Jm6gke
 4m7bCcjT25dAP6HBg9UzJaX/QBj7wkbo8MX8s82R3DQp7aHegBP1CeB
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

