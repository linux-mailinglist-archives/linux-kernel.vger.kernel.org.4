Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CFB714ABF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjE2Nwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjE2Nwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:52:30 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69198AB
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:52:28 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f3b4ed6fdeso3438407e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685368346; x=1687960346;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0cuLBlArSvHUOuH6GEvI+l8s8FmhxL3706TAOMTxRVY=;
        b=XxzGjWQkuX8LH1JQ7CLt/0mi5Dm/25JxSyFPsjCuYSfUVBVhjRGwGqv91xjoy68Dyx
         lQm/v31HyrGZI+4mNlbjrfyKWeKwnDHvMVAfwwZ3iaHhZtSDRYNTzl9fcupcp3lMvm7T
         Bfz68Iq/fF7OA5qoyiAO6aCQ9EyIj3WA6YmyZqINJvt45HyDp1VXFe8klqk/1Vk0xeTT
         zOGGXvyxs6PPMOmd7/8ZYMkX8BxHNFdldENu1RaKkDI706eS3M+AJ6rmLCzk4qAPrJ4b
         1V8Kd0vkfkV0Ni2NrMDul1J/ZJwckXbHjX7rJyy1u+clEEq87I73Q8GDww8Nevtck83B
         i93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685368346; x=1687960346;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0cuLBlArSvHUOuH6GEvI+l8s8FmhxL3706TAOMTxRVY=;
        b=FMf60nbvkS4diDolhCbKBXtmJKMl9V3wHaroG5yNyN258nKf3jP5oP/Onj3qHUHem/
         TUeWbdj/h1fiO0iu0IYhAbXA9z7AwiSMSy0COQstfWYpKdhXpwo7+8CVkXmsRLBx0DvG
         w+gA0ic2q1NUszPElhtx5GlicbN0Y/dvfMzupcJBvYtNHpwePw7HIkViFS5Q+NxgF6iF
         7OJzWqYjeT6wH+2nLjCdfT8R0LbDthbUgQqniq81qK4mc30hQU9k/AhvSby3dUwB4RlP
         Fhbk0eoOdRVXnIRX1GGY1RrJSN75oxUQu0eDz8RoFCFfuWpgiCks2eBkB3sQ8sEoOlFI
         LBuQ==
X-Gm-Message-State: AC+VfDyDiFNcOQDaLJzjh6bqdYG1Ql7l/hF5hFm12JeTfO6WbuqqJUAU
        u7Ct+845i/iyAOB/ivsO1bH3cQ==
X-Google-Smtp-Source: ACHHUZ7dMjgZ9WVHIEU+tVT0Q3+//eHqvTy4CAUADfUE1SAhXgcKAYZrLMtD+SYYS9149f1KFUihVQ==
X-Received: by 2002:ac2:4a76:0:b0:4f4:dfd4:33e4 with SMTP id q22-20020ac24a76000000b004f4dfd433e4mr3271117lfp.51.1685368346747;
        Mon, 29 May 2023 06:52:26 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id c16-20020ac25310000000b004f2532cfbc1sm4700lfh.81.2023.05.29.06.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 06:52:26 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 29 May 2023 15:52:20 +0200
Subject: [PATCH v8 01/18] dt-bindings: display/msm: gpu: Document GMU
 wrapper-equipped A6xx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-gmuwrapper-v8-1-69c68206609e@linaro.org>
References: <20230223-topic-gmuwrapper-v8-0-69c68206609e@linaro.org>
In-Reply-To: <20230223-topic-gmuwrapper-v8-0-69c68206609e@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685368343; l=3273;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=b6+fi5fCGzlZMR9R+EmbwaeFE4doeq5ZoHaz6yo6/U0=;
 b=m5YOP8qYT6dteRhaCWAzqoub/NNS3RW0KZBOeIYF3MKua6KdI4RiWWLpW7I6Fy6ZMfxp+15X6
 +rinzEhHTBwB/9fp6GCRvBGXTrTZMh02HHtjB9HCnCO5j/+wfoW3B3f
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

The "GMU Wrapper" is Qualcomm's name for "let's treat the GPU blocks
we'd normally assign to the GMU as if they were a part of the GMU, even
though they are not". It's a (good) software representation of the GMU_CX
and GMU_GX register spaces within the GPUSS that helps us programatically
treat these de-facto GMU-less parts in a way that's very similar to their
GMU-equipped cousins, massively saving up on code duplication.

The "wrapper" register space was specifically designed to mimic the layout
of a real GMU, though it rather obviously does not have the M3 core et al.

GMU wrapper-equipped A6xx GPUs require clocks and clock-names to be
specified under the GPU node, just like their older cousins. Account
for that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/display/msm/gpu.yaml       | 61 ++++++++++++++++++----
 1 file changed, 52 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index 5dabe7b6794b..58ca8912a8c3 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -36,10 +36,7 @@ properties:
 
   reg-names:
     minItems: 1
-    items:
-      - const: kgsl_3d0_reg_memory
-      - const: cx_mem
-      - const: cx_dbgc
+    maxItems: 3
 
   interrupts:
     maxItems: 1
@@ -157,16 +154,62 @@ allOf:
       required:
         - clocks
         - clock-names
+
   - if:
       properties:
         compatible:
           contains:
-            pattern: '^qcom,adreno-6[0-9][0-9]\.[0-9]$'
-
-    then: # Since Adreno 6xx series clocks should be defined in GMU
+            enum:
+              - qcom,adreno-610.0
+              - qcom,adreno-619.1
+    then:
       properties:
-        clocks: false
-        clock-names: false
+        clocks:
+          minItems: 6
+          maxItems: 6
+
+        clock-names:
+          items:
+            - const: core
+              description: GPU Core clock
+            - const: iface
+              description: GPU Interface clock
+            - const: mem_iface
+              description: GPU Memory Interface clock
+            - const: alt_mem_iface
+              description: GPU Alternative Memory Interface clock
+            - const: gmu
+              description: CX GMU clock
+            - const: xo
+              description: GPUCC clocksource clock
+
+        reg-names:
+          minItems: 1
+          items:
+            - const: kgsl_3d0_reg_memory
+            - const: cx_dbgc
+
+      required:
+        - clocks
+        - clock-names
+    else:
+      if:
+        properties:
+          compatible:
+            contains:
+              pattern: '^qcom,adreno-6[0-9][0-9]\.[0-9]$'
+
+      then: # Starting with A6xx, the clocks are usually defined in the GMU node
+        properties:
+          clocks: false
+          clock-names: false
+
+          reg-names:
+            minItems: 1
+            items:
+              - const: kgsl_3d0_reg_memory
+              - const: cx_mem
+              - const: cx_dbgc
 
 examples:
   - |

-- 
2.40.1

