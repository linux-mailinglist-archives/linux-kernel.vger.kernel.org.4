Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F12C70A7C4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 14:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjETMT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 08:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjETMTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 08:19:55 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59ABE1A6
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 05:19:53 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4eed764a10cso4755410e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 05:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684585191; x=1687177191;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aflMIgmCUBYIv+NH+OHNReBuMm35dTbYVoSEqXv7yrc=;
        b=fx/9Muw9bgoGfvtDGVdm7j3y7AzHlyAWMg4frsIa436LA0m4rMmV8FHEWrKQczJwZW
         sHCH4e3OSYtbutkTlAZRrFhjy1AO0MIco6/8N/GpEV3TMb0GzK8tsjof9uMuR320UnER
         X+y/I1bAiLdPwOmoMab1Ocm3hsRgDG9Kmf0eA5ma7OaczM628FV5EyyTXkthprhUJJW2
         dcGV2ZEOZPqAjKG184rpZQRyJC7+n8tDeSS4bOd2/8GGVX3bZD4I/7rK+9hQM3I5ZVpK
         znBL3GHpT25V6R6vbyENwWyAvUzXik+onnRD4RVhhLT5sdtZGTnzoeIzu465wdTPio3H
         AVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684585191; x=1687177191;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aflMIgmCUBYIv+NH+OHNReBuMm35dTbYVoSEqXv7yrc=;
        b=LVlGbWHykESjT09kqZ33gcxTAv3ReQCpQz8YwbKboyB1RIRSTGw2h6HctWJ8yy1tB3
         IPbP9JyUZsMXLbItALLZcqwfDVZ+wPYE2hGWQydC3gXXmjvW2EtQuw+K3EUsE2YIdTwr
         4Jg2VusnBsgLuPjri5s9kSGc7ef9UJXvvQpiy4xrYYUovtaSQ5k1sa2f5tfsX80OlSUO
         fl9SPGo9kVcJBE6dUdRGHXFrqBw4/g2BXsuB3Y+/bcYVojt9xVE14YD6tb8fp6CJhhKk
         R/75k0BCq2DnlH7QOLPz4TePKvr+yZY2W4qw6uESfYU6bKXb4ki9/6BREDB4owoC3jAU
         rzOA==
X-Gm-Message-State: AC+VfDx804H+4BQBIkl+aUKRiW2ES2+AQj8PuErhaczp0kRV3BJDvxYp
        Uuh+FZcjxmRTicexB1bgbgEsNg==
X-Google-Smtp-Source: ACHHUZ774MwJc8Wk3NInYSY5MaLCHEkMf2w3NPGUWuPL6jUTcrThHOMj2EaaXiURuSOmawg1uKvjzA==
X-Received: by 2002:a19:ad02:0:b0:4f2:509b:87ba with SMTP id t2-20020a19ad02000000b004f2509b87bamr1529394lfc.50.1684585191243;
        Sat, 20 May 2023 05:19:51 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id y6-20020ac24466000000b004f37bd02a89sm244766lfl.287.2023.05.20.05.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 05:19:50 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 20 May 2023 14:19:42 +0200
Subject: [PATCH v7 02/18] dt-bindings: display/msm/gmu: Add GMU wrapper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-gmuwrapper-v7-2-ecc7aab83556@linaro.org>
References: <20230223-topic-gmuwrapper-v7-0-ecc7aab83556@linaro.org>
In-Reply-To: <20230223-topic-gmuwrapper-v7-0-ecc7aab83556@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684585186; l=3381;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=SZ3bdkEe3SX6unXxVV9E3rtrVD2hZogfDv0FUHcSBSw=;
 b=TG+x5ZWY4hRPEk+ic1Y0KwdRZafHrgQwU/jLIhBJl5zYcTsFO8FZcfdFN1I3fc9gIuLCd73Yx
 TZVGILR57QlB9ovcbMvYurvr6xYTnN/rtDUlCYYrRaWqHny9F7d0yuG
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

The "GMU Wrapper" is Qualcomm's name for "let's treat the GPU blocks
we'd normally assign to the GMU as if they were a part of the GMU, even
though they are not". It's a (good) software representation of the GMU_CX
and GMU_GX register spaces within the GPUSS that helps us programatically
treat these de-facto GMU-less parts in a way that's very similar to their
GMU-equipped cousins, massively saving up on code duplication.

The "wrapper" register space was specifically designed to mimic the layout
of a real GMU, though it rather obviously does not have the M3 core et al.

To sum it all up, the GMU wrapper is essentially a register space within
the GPU, which Linux sees as a dumbed-down regular GMU: there's no clocks,
interrupts, multiple reg spaces, iommus and OPP. Document it.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/display/msm/gmu.yaml       | 50 ++++++++++++++++------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Documentation/devicetree/bindings/display/msm/gmu.yaml
index 029d72822d8b..e36c40b935de 100644
--- a/Documentation/devicetree/bindings/display/msm/gmu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gmu.yaml
@@ -19,16 +19,18 @@ description: |
 
 properties:
   compatible:
-    items:
-      - pattern: '^qcom,adreno-gmu-6[0-9][0-9]\.[0-9]$'
-      - const: qcom,adreno-gmu
+    oneOf:
+      - items:
+          - pattern: '^qcom,adreno-gmu-6[0-9][0-9]\.[0-9]$'
+          - const: qcom,adreno-gmu
+      - const: qcom,adreno-gmu-wrapper
 
   reg:
-    minItems: 3
+    minItems: 1
     maxItems: 4
 
   reg-names:
-    minItems: 3
+    minItems: 1
     maxItems: 4
 
   clocks:
@@ -44,7 +46,6 @@ properties:
       - description: GMU HFI interrupt
       - description: GMU interrupt
 
-
   interrupt-names:
     items:
       - const: hfi
@@ -72,14 +73,8 @@ required:
   - compatible
   - reg
   - reg-names
-  - clocks
-  - clock-names
-  - interrupts
-  - interrupt-names
   - power-domains
   - power-domain-names
-  - iommus
-  - operating-points-v2
 
 additionalProperties: false
 
@@ -217,6 +212,28 @@ allOf:
             - const: axi
             - const: memnoc
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,adreno-gmu-wrapper
+    then:
+      properties:
+        reg:
+          items:
+            - description: GMU wrapper register space
+        reg-names:
+          items:
+            - const: gmu
+    else:
+      required:
+        - clocks
+        - clock-names
+        - interrupts
+        - interrupt-names
+        - iommus
+        - operating-points-v2
+
 examples:
   - |
     #include <dt-bindings/clock/qcom,gpucc-sdm845.h>
@@ -249,3 +266,12 @@ examples:
         iommus = <&adreno_smmu 5>;
         operating-points-v2 = <&gmu_opp_table>;
     };
+
+    gmu_wrapper: gmu@596a000 {
+        compatible = "qcom,adreno-gmu-wrapper";
+        reg = <0x0596a000 0x30000>;
+        reg-names = "gmu";
+        power-domains = <&gpucc GPU_CX_GDSC>,
+                        <&gpucc GPU_GX_GDSC>;
+        power-domain-names = "cx", "gx";
+    };

-- 
2.40.1

