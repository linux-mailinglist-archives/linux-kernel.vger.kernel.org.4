Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2FA6B763F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjCMLmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjCMLl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:41:56 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F96865C4E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:41:22 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id g17so15319860lfv.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678707678;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VaeNat/r39kxcqF7BN2wWc7swe6HV6M8E5ETNmOYRZQ=;
        b=YUk/I/O3kiX/JKsTnxRfOsR8Zky9UKva3xOg+ByHwUbKeu7YcHMS0i5RNenXBJPUaZ
         +Qt1P+AWVxaxP9j02K5Y5Sk+jAzdEfFImcdOj4K9iN4iCAGtbYdVKobtGSklmVUOSXW2
         E8XEnsLYHNi3TT5PPReJk0UB4DWqMz0tle2w/SgaqAsEqeil6NQ1/fyMYCgUGvHKZ9qU
         5gCxt66CCtO5fF28YTY/MQ2B5uOxfQkw3isRoFU1HJYbdzIZESJHi5yfyMvv3TOXqILU
         49F786nnFj/W4xkceWhjdmyzksLFUZXUsKqfOeeeQFZdYmdtBcb3fgGg9jxVSeZt25g+
         phEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678707678;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VaeNat/r39kxcqF7BN2wWc7swe6HV6M8E5ETNmOYRZQ=;
        b=utHrKjdNHZNC4scHXFUf9w9jfK55fkjTHNFuqF6OjIsoPqOWOb5fGklWqShzeLxhoa
         C4JlDTmNRFAh+OJzed7x5pB3Xfu/qCWWc7OWKGJqfq4D6lC4W9OliPhEbeR+IaR060ze
         +Ybx/SJhcHBHPIDXoSroHVorcGPlQVrEkkgWJHx+ffXEZ2wwcL3LTlqq7PRxCHB/Hm43
         LnW1RB51eiJR/fKXWwCaS55AJyWAug7q2oXlJtl6+EjkXNVz0uYAjWrjD3d/oKwJ5Ohn
         kwoLU48HrTLpBDH6MkzSQIGTZvF4gkEnwGyVlsu5gJAU86172GXbpzpJnE3C73AzjKFs
         c7BA==
X-Gm-Message-State: AO0yUKW1iPRUK94SomVEoUehrBreUPO3cadYw7slwG2MsCFBMPj6F0Gu
        Dlhh+fSBx5fJ5WdgjzqlzpTUft1NFajkclHIFjM=
X-Google-Smtp-Source: AK7set90kRV+4rOoqD9GMvOoW28cV+Q+7sP+gOoKNg27pxmJlh8TNHtJb9YwJpeePPn8282Kyz1brg==
X-Received: by 2002:ac2:5391:0:b0:4dd:abb9:dae4 with SMTP id g17-20020ac25391000000b004ddabb9dae4mr10139714lfh.25.1678707678010;
        Mon, 13 Mar 2023 04:41:18 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id i2-20020ac25222000000b004d86808fd33sm948465lfl.15.2023.03.13.04.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 04:41:17 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 13 Mar 2023 12:41:07 +0100
Subject: [PATCH v2 1/7] dt-bindings: interconnect: qcom,msm8998-bwmon:
 Resolve MSM8998 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230304-topic-ddr_bwmon-v2-1-04db989db059@linaro.org>
References: <20230304-topic-ddr_bwmon-v2-0-04db989db059@linaro.org>
In-Reply-To: <20230304-topic-ddr_bwmon-v2-0-04db989db059@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678707675; l=3131;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=SbN98Ibah4gas5eacqICwCuMX8VfaPWlZmkr7n14GAg=;
 b=DdyWr1FxIsUnPNy/1QEqjJJtlRLNjh6PqilSYN3ygAQcO44LPckma+4V/1hDmmIjwyBAFbysYGX1
 Dz6T7uwpDLzhX+9LiT3WKSbb7aQXxdaPXvTOC12NEsCFPDAhU6D1
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
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

