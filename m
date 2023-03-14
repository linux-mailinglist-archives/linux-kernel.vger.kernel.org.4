Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28226B9908
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 16:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjCNP2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 11:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjCNP2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 11:28:44 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B616743467
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 08:28:41 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id t14so16423502ljd.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 08:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678807720;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dDrs6JyeTYzM6UbBJjwqEiLM0mM7HZ/Cu05l6aEARFA=;
        b=IFE6Gu3pkatgASwbx1ImpERuqNfGoEv4bKaRQZJgSsFYmX9pyq789ui74anr0GCEgf
         2xhhKtZyoTkYjXzPauAL1Zp41IK+Vpjlwq+hoO13s91dFAMtE6VgaJnabahi+PpOaeQo
         7cDgmExTSrb/GiJspQc4v8qgRrsmpmSSEM7cUYx38aDmKcw+l1lyUJ+yGQkPUySaOkpL
         1jT0ETnMz6lohpMpRS3SwQcgxd/g2g4M6hw4mQ2lAJYlCijRKOLW0Y5X40UVcfpE3jPE
         885KfrBnSHaQMS1LZzaG2dZVEoQFavz1LBj4jqiCpXSqIda3x3QRT0E1SgBQ7WHVOlY9
         cTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678807720;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dDrs6JyeTYzM6UbBJjwqEiLM0mM7HZ/Cu05l6aEARFA=;
        b=zq7o/B/JY9UfBtW2YlLEUqRNg/ib9BvgYlcConxAcjFUqg+M9HUmZM6JU71xbuD3Te
         lEGbn6sICekqc2cwC2TOAIw+gMH/zUIY0yWNL2LzMyDAXmILX9wSUQTTgnpJIUIblz4S
         GHkU4wo4KrLjMgVWEPxcgcZTyRV59R0DiUwbRqWh5J1NjeYi2o+D3EgFuUPKZXLNY24e
         uD5Q/u6i/FWPaUxg2G0qidHMlDA6QLFhKYbnusJn70ob2lI202/dyTRTAtCx+fjWwP1s
         rjSDhyfey6CgiG8hM7eZTLoc/VYgDC6IjNxxOvIEdCYaQKNVlFGT1M1ofqVAPq4ADUkD
         4ixg==
X-Gm-Message-State: AO0yUKVLSqHkPI91EL36jQP2Gjcw3YM83fRDXEDWUhl8u77MA7Rkftay
        R/MUneNPIysy6y0+Zg0+G9YyoQ==
X-Google-Smtp-Source: AK7set+AKW5h3+gpYUWs5M8YeHUiHDyWaDoRGbpKtAv13E6yGkGt34J83LUQNCU+EhNDQZ0o+KzEBA==
X-Received: by 2002:a2e:83c6:0:b0:293:5360:162b with SMTP id s6-20020a2e83c6000000b002935360162bmr4084469ljh.11.1678807719958;
        Tue, 14 Mar 2023 08:28:39 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id 27-20020a2e165b000000b002986a977bf2sm491529ljw.90.2023.03.14.08.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 08:28:39 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 14 Mar 2023 16:28:32 +0100
Subject: [PATCH v4 01/14] dt-bindings: display/msm: gpu: Document GMU
 wrapper-equipped A6xx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-gmuwrapper-v4-1-e987eb79d03f@linaro.org>
References: <20230223-topic-gmuwrapper-v4-0-e987eb79d03f@linaro.org>
In-Reply-To: <20230223-topic-gmuwrapper-v4-0-e987eb79d03f@linaro.org>
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
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678807716; l=3204;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=6sAUPUwHP7+WUPx0qnkXu1yRwFCLU2UOzBhHFKkRGTM=;
 b=mV+9zzv7CDxkMqctTdkZFuDUkQFR5lB3OtJchHXfOYHhrrpWJ/oHSNLECv+KrnMciFrDa+s7/Rx9
 dsByIHe1CGn7Aexc8isUndJ0jhglIt6f9uZXVUBWv3VqK6RfeBKH
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
 .../devicetree/bindings/display/msm/gpu.yaml       | 57 ++++++++++++++++++----
 1 file changed, 48 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index d4191cca71fb..ac1a9bce2042 100644
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
@@ -157,16 +154,58 @@ allOf:
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

