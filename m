Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776696A07FC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 13:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbjBWMG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 07:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbjBWMGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 07:06:51 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3690054577
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 04:06:49 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id y14so3479381ljq.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 04:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7GfFVek+ElBU/x4Gj7bclUI24uP1/zbAkUCH7g+3I3E=;
        b=SFzlXW25c2p4gmoVDowFXTsP5M8MKa9SLmR9b6XVCY+h18lAKnP8yoYhiEZ0+jdxXo
         RO+5/lzqt4SUkwxXvwRV3Yx4FoS48uKXXeqKv4cuVg5pO91p8hHIN+jLA9wlnWMHsgXC
         R/Gm0Ev8ftdKzILltKVZlw3gvE4RTsmDwRlhvwSzjRUXj/Ydih6ZG4fQpToXwpnSwnd6
         k9nxQHFzkYI6FcohI0E5yzAXuKWRK2KerIvUDB3jW44Rtm87LO4hNhSLmxl/m7wLsxa+
         lmpjA2lfRabtij/IW2dEzn0J9K2WsQSvlXsCNAhSiW83Wn3o8xK8aM6NDu9ajLNZWgVP
         kwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7GfFVek+ElBU/x4Gj7bclUI24uP1/zbAkUCH7g+3I3E=;
        b=bXDwfyU7dPa97YfnD0CZ4ZkRJzz1CZuHTmDEdCzXLuey+2VHBb+3THbisaeKjKQvxr
         kHf7gGVlwgqAJ91n4cbEPIfqy6AjY0KdeTVlPLhBeZM0R1LvnPuJMqWGECMAtYFJSuxo
         4aAh3CewjdOZfrzKVl6dBtZ2cuuVjyAYqDvsskjFNvF1ivutS0F/pzxsMQajl37huMDQ
         KXFn8oVvVmY2HrhO9Ws+ig+66ZU69t1rzgExxU7kFfavrhjruoGfUog/S0aIiHK+i3gB
         B5PTkArPWRDA0jLwg6sBeHQX+fS6Z7VEnphz6790IbKmYJ4vHSeZ5jzfH4DUbD2O1gIy
         Mp4Q==
X-Gm-Message-State: AO0yUKXqB3ALK0rKv0alUn6E/XeNByGj8vegTvidQRwbbZz/2vmk3Rv2
        D3LxyfkCASIHIEAdx70n2P6oaA==
X-Google-Smtp-Source: AK7set/R8hp0OHle8W9yidCEv0lkrsZraNX5wicXprVVmMdsiLMN7wglCaVXpAb3H22Bb1WLOAP1KA==
X-Received: by 2002:a2e:a408:0:b0:293:4e57:2bd4 with SMTP id p8-20020a2ea408000000b002934e572bd4mr4273974ljn.8.1677154007553;
        Thu, 23 Feb 2023 04:06:47 -0800 (PST)
Received: from [192.168.1.101] (abxi151.neoplus.adsl.tpnet.pl. [83.9.2.151])
        by smtp.gmail.com with ESMTPSA id h23-20020a2ea497000000b0029599744c02sm414838lji.75.2023.02.23.04.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 04:06:47 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 23 Feb 2023 13:06:36 +0100
Subject: [PATCH v3 02/15] dt-bindings: display/msm/gmu: Add GMU wrapper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-gmuwrapper-v3-2-5be55a336819@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677154003; l=2667;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=jy8JJ/4jpW1OOt7PFexguPcdOFWIzV/3CRPopFhMDDQ=;
 b=dRvrwjzYmrX1k0lskf2jeL30yaDbqDq+7qdA9yECMw94dbVSOYzqxXXt3wtV3xaxyycXAe7tcqkV
 pt9s2rj4A+e0HjnTBfiV51jBmIDjMDD6C9/u0io1VJ3L6Qlr3dC1
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GMU wrapper is essentially a register space within the GPU, which
Linux sees as a dumbed-down regular GMU: there's no clocks,
interrupts, multiple regs, iommus and OPP. Document it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/display/msm/gmu.yaml       | 49 ++++++++++++++++------
 1 file changed, 37 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Documentation/devicetree/bindings/display/msm/gmu.yaml
index ab14e81cb050..021373e686e1 100644
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
 
@@ -216,6 +211,27 @@ allOf:
             - const: cxo
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
 
 examples:
   - |
@@ -249,3 +265,12 @@ examples:
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
2.39.2

