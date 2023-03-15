Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61046BB591
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbjCOOLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbjCOOLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:11:30 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADF984F5A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:11:28 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id t11so24490252lfr.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678889486;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GUHDXikvsif8IOtL+hvOsXwd5d2A9CMOSSomT6p2Ew8=;
        b=n35855/nbuSop7UI6I9+2cU54Nj6y+nMkomIR74AGv/c2KcvJRBOdB86ucEyXQvCJq
         2zheT2Z7uLfDxWH5nQ+/jcBnjAurtuYhQiuaepogNZOvBlFm/kbdI6WT+ePfaVrQgCXq
         E0+DfOHvuEIIxGFtYd/WZKGcchf2Ex2P5f9ztsjLnNsIHn+nkEx4rKIuMnz4PM1oIUz0
         2SLuOkSJX1qgFPHern8HF4jk9hns1Bj7RoBWYY6ojfyiNVnZ6WCeWF/uuVqjw/Z0vxOb
         gavc9NxCwFWdWpwFQmudv7rvvPQD8ncFuSoHBIFFm3tX7W6Mh8PnLHA/bTrvShUDwuMb
         VkQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678889486;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GUHDXikvsif8IOtL+hvOsXwd5d2A9CMOSSomT6p2Ew8=;
        b=nnQ2odxMK4fcRzfmYcfikMAkZQlaHynYn0ie2XjxIBpd7LK5DFwHJZEBwQNT3rX36k
         98foiE5uvon6GvWnRYDWHeVjtvhrxjPzNjE6qJCH/JjCRo06oitHmM7Yl/eN4+3+Fe9n
         0NMdV/InUPH4AJgcA2XfhEcDW78VUn+ihvNeAVtIWgRavhp6Rdw/NU/1Hk/LcXq0+ax1
         ULZ9hAsSGkL1qWnCwt6mt4f6h/S8Qmy7ndy+9Wi3nDsavz9Yfh4bIHElHs8gxi0NTBZD
         qDJra+L+KzJ1aQSIi2AMc0W1ySUocFZk6SCLje6AFnomWGbot7g3c/r0JNPAbS7vniJ0
         TU8Q==
X-Gm-Message-State: AO0yUKUPO94VRgsAsPKfVsPqHFgsgP2VbWfC83Q/1RNjndWv5fPjAIjJ
        bU2kxAtCk8ZhF12/81S2+VDTKQ==
X-Google-Smtp-Source: AK7set8BXw06brp1ctivIy4BKbUPYCUuL0+4nWJIGPyQAhrDuAjeBkcTJEGTfBbtrRVOpnF+NuNVOg==
X-Received: by 2002:a19:c501:0:b0:4dd:ac8d:671f with SMTP id w1-20020a19c501000000b004ddac8d671fmr1723747lfe.34.1678889486432;
        Wed, 15 Mar 2023 07:11:26 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id b8-20020ac25e88000000b004e845a08567sm824678lfq.291.2023.03.15.07.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 07:11:25 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 15 Mar 2023 15:11:19 +0100
Subject: [PATCH v3 1/7] dt-bindings: interconnect: qcom,msm8998-bwmon:
 Resolve MSM8998 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230304-topic-ddr_bwmon-v3-1-77a050c2fbda@linaro.org>
References: <20230304-topic-ddr_bwmon-v3-0-77a050c2fbda@linaro.org>
In-Reply-To: <20230304-topic-ddr_bwmon-v3-0-77a050c2fbda@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678889480; l=3198;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=46GX24BwrnA0NyNxXdAtsdOmycpBdNb3M3oef2DCgaI=;
 b=WWKutA0jBcYE25QwX++BpXSspC7Fp3hZSBClmXDaadptiAxrADsX0C6EleInwHhzoTY6QeHRr0wi
 ctno1RGrAPxxz5R0JFl7Uhj6Hej8dn8hVdWghI/57tb9b+q51Gx8
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

BWMONv4 has two sets of registers: one for handling the monitor itself
and one called "global" which hosts some sort of a headswitch and an
interrupt control register. We did not handle that one before, as on
SoCs starting with SDM845 they have been merged into a single contiguous
range.

To make the qcom,msm8998-bwmon less confusing and in preparation for
actual MSM8998 support, describe the global register space and introduce
new "qcom,sdm845-cpu-bwmon" compatible while keeping the
"qcom,sdm845-bwmon" as a fallback for SoCs with this merged register space
scheme.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/interconnect/qcom,msm8998-bwmon.yaml  | 41 ++++++++++++++++++----
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
index 12a0d3ecbabb..5d17bdcfdf70 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
@@ -22,14 +22,14 @@ description: |
 properties:
   compatible:
     oneOf:
+      - const: qcom,msm8998-bwmon       # BWMON v4
       - items:
           - enum:
               - qcom,sc7280-cpu-bwmon
               - qcom,sc8280xp-cpu-bwmon
-              - qcom,sdm845-bwmon
+              - qcom,sdm845-cpu-bwmon
               - qcom,sm8550-cpu-bwmon
-          - const: qcom,msm8998-bwmon
-      - const: qcom,msm8998-bwmon       # BWMON v4
+          - const: qcom,sdm845-bwmon    # BWMON v4, unified register space
       - items:
           - enum:
               - qcom,sc8280xp-llcc-bwmon
@@ -49,9 +49,13 @@ properties:
     type: object
 
   reg:
-    # BWMON v4 (currently described) and BWMON v5 use one register address
-    # space.  BWMON v2 uses two register spaces - not yet described.
-    maxItems: 1
+    # BWMON v5 uses one register address space, v1-v4 use one or two.
+    minItems: 1
+    maxItems: 2
+
+  reg-names:
+    minItems: 1
+    maxItems: 2
 
 required:
   - compatible
@@ -63,13 +67,36 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          const: qcom,msm8998-bwmon
+    then:
+      properties:
+        reg:
+          minItems: 2
+
+        reg-names:
+          items:
+            - const: monitor
+            - const: global
+
+    else:
+      properties:
+        reg:
+          maxItems: 1
+
+        reg-names:
+          maxItems: 1
+
 examples:
   - |
     #include <dt-bindings/interconnect/qcom,sdm845.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
 
     pmu@1436400 {
-        compatible = "qcom,sdm845-bwmon", "qcom,msm8998-bwmon";
+        compatible = "qcom,sdm845-cpu-bwmon", "qcom,sdm845-bwmon";
         reg = <0x01436400 0x600>;
         interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
         interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_LLCC 3>;

-- 
2.39.2

