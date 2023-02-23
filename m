Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C657E6A07F9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 13:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbjBWMGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 07:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjBWMGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 07:06:49 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E71954548
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 04:06:47 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id h3so4564479lja.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 04:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K4YZhIq9YW/FxqiUeK4bZw1x51EA5wPW9LCdn2zDvdc=;
        b=OohLjLKJXyjraOAySmUv+UmUZOeAqv0jpujjxE8+ocLORTL2AXpQkvVd5IKmcnbI14
         SzPbv4PrLCCbBfbotURghv6LoMk+jJH2fADhyx192N1q/Pw0pNNrie1Qw+zFOfad9lx8
         79/2kZG9Y70Zy3UT81Cc/xZX89mwyKmN3/6mDTexIXgQ+GY3CGB8BGsd6aMFvA2/07FJ
         0RR0DmLmij1wb6xEpWSGuB03PdKUSVcbMYDc+H7nti1MEo1cUGrkE9/zZz3NG77iUwOy
         dyYs7MreM4JQO50+Af39oL+xwv+Iu0+0pa1K9eLUYA28MLN2qVYzH6q20kuLsNBBZfBv
         JRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4YZhIq9YW/FxqiUeK4bZw1x51EA5wPW9LCdn2zDvdc=;
        b=UCk8PRCpBUlqZLmZGuJo9IEn9dIt2Hbp1l8Mmt6pVzqT/KXhfvpCw4VTV5AktrJfOY
         GGC84XuASFogvN6HpFpmr1vjFWnoIzqgLVw124okSn8/CbcepZ+jDE5Ln0PIO/plqCKY
         dVo5WnX3B8g8ccSUuVx+Ougm4vbJR4T3VMFxJpi0HhyaRIlc7ssY6ZYxD/kDqQ5ioIjQ
         3k5qXcTP0Suaak9mAE2wUI0g1gfXbWNJOEOyOtt2jPu2H0baE01AtFjJVbn5vKhtRUA7
         vQzlR5ly5pehO3z3gI9W1wCBXXtRV+1Is8391MvuI/7HfzUCv16RU827XhPZTmGnL/IN
         a6ZQ==
X-Gm-Message-State: AO0yUKWsAbiw/2fzWAvZOLpz1QStT99S2YftXOQLxgbAlf2RDfeP1+DH
        Cp2UWYolRiV8WdUjbCk3WgNRDA==
X-Google-Smtp-Source: AK7set/IoyMZjZzt4A4lV3MF5z2ACmTHA5JBD9wWI5PQ1ERTAqq4xAvNRkIyljJW3Fmd0z0wwTGnFA==
X-Received: by 2002:a2e:9c43:0:b0:28b:6f21:d929 with SMTP id t3-20020a2e9c43000000b0028b6f21d929mr3786573ljj.32.1677154006004;
        Thu, 23 Feb 2023 04:06:46 -0800 (PST)
Received: from [192.168.1.101] (abxi151.neoplus.adsl.tpnet.pl. [83.9.2.151])
        by smtp.gmail.com with ESMTPSA id h23-20020a2ea497000000b0029599744c02sm414838lji.75.2023.02.23.04.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 04:06:45 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 23 Feb 2023 13:06:35 +0100
Subject: [PATCH v3 01/15] dt-bindings: display/msm: gpu: Document GMU
 wrapper-equipped A6xx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-gmuwrapper-v3-1-5be55a336819@linaro.org>
References: <20230223-topic-gmuwrapper-v3-0-5be55a336819@linaro.org>
In-Reply-To: <20230223-topic-gmuwrapper-v3-0-5be55a336819@linaro.org>
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
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677154003; l=3199;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=OIF3FsTi5KZskII9c6hJUDloiyLRqqB5VQtoA0QmTtI=;
 b=dmENyDnriBzpDTZ/hIUGR6DQxTsH8p61XQNnYXfjQwEfZZ9ngl3L7w9SMdpp+lueOdSvjcYs3NXl
 6r1QPtrNAmBbqGp7SUn+vCOg4vhyL0O/ePwkzd4hgzIahrAmm/v0
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GMU wrapper-equipped A6xx GPUs require clocks and clock-names to be
specified under the GPU node, just like their older cousins.
Account for that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/display/msm/gpu.yaml       | 63 ++++++++++++++++++----
 1 file changed, 53 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index d4191cca71fb..e6d3160601bc 100644
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
@@ -147,26 +144,72 @@ allOf:
                 description: GPU Alternative Memory Interface clock
               - const: gfx3d
                 description: GPU 3D engine clock
+              - const: gmu
+                description: CX GMU clock
               - const: rbbmtimer
                 description: GPU RBBM Timer for Adreno 5xx series
               - const: rbcpr
                 description: GPU RB Core Power Reduction clock
+              - const: xo
+                description: GPUCC clocksource clock
           minItems: 2
-          maxItems: 7
+          maxItems: 9
 
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
2.39.2

