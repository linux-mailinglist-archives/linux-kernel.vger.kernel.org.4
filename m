Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830AF70A7D8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 14:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjETMUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 08:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbjETMTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 08:19:53 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C2A132
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 05:19:51 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f3a611b3ddso2236788e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 05:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684585189; x=1687177189;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rmQkm9eIpP4KwgdytmogY94a+6CcbBOn0isFTbbL77w=;
        b=GhljqGlQ9QrJYz01T97CgWhEuftE3BCFDJDfX8TOr0Uv/vrDwwoJqb/dKqtIiSQihy
         0Up8USCanLryU+94kUSU7vvMIvjV2YL2czuJdiNg0eOiUvnBzPu4fHYDVzhcOp0PcrE0
         5YrHorq91hnQE8hlZt1EBdxlxro9KhJOfk1rBmUrJrq6Jrrwyb4Q3eqEDMto1j/n58a/
         s4My0zz7ngoMT6xnFRjocwmTGD0DT4G6gFcEAuAU7Bve06sjn8FzWQCrT5emDVb3bc8Y
         mZPzgEDHZl5SIDrmeb+NBK9gooBw/4udrf6Kg8z4t0sq7h2uOKKKSW26Ns8SE58mgxdD
         ATaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684585189; x=1687177189;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rmQkm9eIpP4KwgdytmogY94a+6CcbBOn0isFTbbL77w=;
        b=hJutwGmIFgV1vuSg861Ye4N3fgD3LgLss20tUDWx6VgaCR19ap0i+dm9Ay8Nj6599A
         G7wpgrVTZDN4fcBlpyfrfBZ8Y7XEMjfeCExtynGAI1Tn/6z35IfZpeh7cCuf8rBY0+t8
         D30V6RUPLHmsNjNtLlBRC8AyTCwrfTwtFK1wAcohcD2BRS8TD9iOScf9Xw+Q3snkDDty
         wGIhgEmx5zYmAqj7szwIxW4240tJ4/h+ylK/WapozcExnFU/ScN/vVnlliPQs08hiV+O
         p165N74CC/kdEDSwsUx+wFTdyINrdYD9mGxp9biz4WEHZKC6WfWJPrSiw+2+n0lXsN5z
         gtZw==
X-Gm-Message-State: AC+VfDy+pLH1EkAtZ6fFVZm52OZm/G7yCatemXv8ZNd4HXe0rp9+l5pq
        MG3A27oTCKY5n31VrMhCgoc8qA==
X-Google-Smtp-Source: ACHHUZ5SMYtQfZSfOxdP+wpOVRJcr3gIYTgyH8YLTpTt7snj1X5zK2JPWv1wybnTZC2EWbGlj5mtHA==
X-Received: by 2002:a19:ad02:0:b0:4f3:89e6:23c0 with SMTP id t2-20020a19ad02000000b004f389e623c0mr1959554lfc.31.1684585189530;
        Sat, 20 May 2023 05:19:49 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id y6-20020ac24466000000b004f37bd02a89sm244766lfl.287.2023.05.20.05.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 05:19:49 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 20 May 2023 14:19:41 +0200
Subject: [PATCH v7 01/18] dt-bindings: display/msm: gpu: Document GMU
 wrapper-equipped A6xx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-gmuwrapper-v7-1-ecc7aab83556@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684585186; l=3340;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=tsvULNaXlyrWUrFums1fREzn1GspuB/dkdkyVKPR2+Q=;
 b=hR7lS9j6vc87ibCvNyBxqs7N/dQx3yhb9sIDnPNtz7efm6lV4/n3C7lWkHZk9yVlTHVZZ3nbu
 a0jmxVcYWhaA1kOIGODDbGjjjmV+Qym+7PsP4b0BrjjEQcJkr6RbRlR
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

GMU wrapper-equipped A6xx GPUs require clocks and clock-names to be
specified under the GPU node, just like their older cousins. Account
for that.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

