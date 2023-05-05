Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA896F8B63
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 23:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbjEEVlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 17:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbjEEVlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 17:41:37 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5FC5B89
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 14:40:48 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2ac7462d9f1so26312371fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 14:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683322847; x=1685914847;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NO5fRgfBpga7Z40GIKnv5Lmg/IglAEvXvStQNi4ygG0=;
        b=rsLrKdrhy2a2Rdz5SOu60AlU7/txqFbmO0OQH8+ltM/lW7FX9rbeTouQ6vJyl0+RiU
         p1HId9R0wqX8PyhheHxe6biuExlNfHhvZ8CMrCNOBbszxA5K9rCKzn4xoSOkDxhG2Kox
         2Uh5EiLbpL0ZGmx4MkXpriy0J83Hq6im4kmOzEMn/+mkfjorCpGTiJJ+JvizLOhmJUQB
         KMjdQv+81CtZJRmo4scmg0KiajwCfaY/1LD84lkq348SripmPGITWsY48s4Gr3B+1no0
         jElDpJzebopdjfEuTKiUlorIhOOhyUqQ1d1NNWxXQ35SLSMh//ekq//SfxdMb+VGUr8Y
         iXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683322847; x=1685914847;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NO5fRgfBpga7Z40GIKnv5Lmg/IglAEvXvStQNi4ygG0=;
        b=bRzJrjxqnehDd/b9KyN4dDKSbahV5Aov/to34+NODucI/3gRn6PA6T9tthaz8M425n
         8u0+qsbTbfkxN0Y1li7YqLAl9VbelhVNuVlSVPyZYu7I5yy6ZVSwq3ijo3LYsdIRJpRC
         7YS0hKSteW76RYePouOmUWdIcGgIu6bH7/WauU3sc4H76aCILUuzUz8ADH8ZXXqFmn3c
         Axu6dws39ZkLSQTEsnVlx5vAqZFlnXhGhsDqcezdTHfvi9eOSQ2Cko4JvpCVjysUI9yY
         /71JwVxKb5NErwxmEJHM2lMoW3+KVtFWZJuDydrQ6RlxDBMojAutL9/xpLtJJ4B/vfOm
         tlbA==
X-Gm-Message-State: AC+VfDxM2kXxn4e2FymbJ5qWCE2Ec6n1GYJc1yoqg4CIAkOIEvLi9cAv
        UNG1le/v7O9yYokDVkBDiiVU8A==
X-Google-Smtp-Source: ACHHUZ4gXeCJE4zlDMMHxTrHrsNhicdcqhAMyXIpqTGgh3AleIuYXLThx3eNJjWiq9OkwNC2MIBVIA==
X-Received: by 2002:a2e:c52:0:b0:2a8:c374:c0f2 with SMTP id o18-20020a2e0c52000000b002a8c374c0f2mr914494ljd.42.1683322846941;
        Fri, 05 May 2023 14:40:46 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id n12-20020a2e720c000000b002a776dbc277sm126453ljc.124.2023.05.05.14.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 14:40:46 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 05 May 2023 23:40:29 +0200
Subject: [PATCH v3 03/12] dt-bindings: display/msm: sc7180-dpu: Describe
 SM6350 and SM6375
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-topic-straitlagoon_mdss-v3-3-9837d6b3516d@linaro.org>
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
        iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683322839; l=2117;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=0YTG0EAw+lDImyg5bB4Ke78N5DjTkdTQlY35rQdmXMI=;
 b=klLfGuhE6s72yhtk0LTrI5AIStLgGemG4Bbu3dYCHWIq3DabAQyTXOmCql9t0a70N13bG4Qk8
 2aXq/aWxoCqBMDTNWXPK0q3mCrWZdN+WYlos93WAVJtJZRjvr17jIOl
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SC7180, SM6350 and SM6375 use a rather similar hw setup for DPU, with
the main exception being that the last one requires an additional
throttle clock.

It is not well understood yet, but failing to toggle it on makes the
display hardware stall and not output any frames.

Document SM6350 and SM6375 DPU.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/display/msm/qcom,sc7180-dpu.yaml      | 23 +++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
index 1fb8321d9ee8..630b11480496 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
@@ -13,7 +13,10 @@ $ref: /schemas/display/msm/dpu-common.yaml#
 
 properties:
   compatible:
-    const: qcom,sc7180-dpu
+    enum:
+      - qcom,sc7180-dpu
+      - qcom,sm6350-dpu
+      - qcom,sm6375-dpu
 
   reg:
     items:
@@ -26,6 +29,7 @@ properties:
       - const: vbif
 
   clocks:
+    minItems: 6
     items:
       - description: Display hf axi clock
       - description: Display ahb clock
@@ -33,8 +37,10 @@ properties:
       - description: Display lut clock
       - description: Display core clock
       - description: Display vsync clock
+      - description: Display core throttle clock
 
   clock-names:
+    minItems: 6
     items:
       - const: bus
       - const: iface
@@ -42,6 +48,7 @@ properties:
       - const: lut
       - const: core
       - const: vsync
+      - const: throttle
 
 required:
   - compatible
@@ -52,6 +59,20 @@ required:
 
 unevaluatedProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          const: qcom,sm6375-dpu
+
+    then:
+      properties:
+        clocks:
+          minItems: 7
+
+        clock-names:
+          minItems: 7
+
 examples:
   - |
     #include <dt-bindings/clock/qcom,dispcc-sc7180.h>

-- 
2.40.1

