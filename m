Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7968370A20B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 23:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjESVtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 17:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjESVt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 17:49:26 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B3AE72
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 14:49:10 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64d41d8bc63so423485b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 14:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684532946; x=1687124946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prFhwvSxBQ/UQ8d4CbWdnfwjRcrN8xUyHXxMGOEWxfk=;
        b=xneVNezdg3Qhn1i2UsRdOk8txhSI55rOdul9umRKZJcSkSmgwvSfoNUekhfpIoAwRZ
         9fmM2AlcqJub567tFBFZbwqRjYJ48FjGexMiUu+Ahu9wKJ9QoKGi4w/UEoO3i9B3h3j1
         asLOwJbbeip0sRtP7OxxEPcnDoYPwILOd5oHGukLgSmeesLf5jsQ8OoXQBr4Tcy+wGEL
         CAVBWiGFt50gLliyfsPsN6pQAHQpdRye07mi73EHasmneZvHsLZkF+0nbbbSL9JUfUq+
         eC1RCSHdUzwnDhra44eGW5i7YJXbhzIy4BqVLlJX3FwgJqW8GAD+2EGNini/oEnlhywL
         7+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684532946; x=1687124946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=prFhwvSxBQ/UQ8d4CbWdnfwjRcrN8xUyHXxMGOEWxfk=;
        b=gQeC27dPZxZ7Y3oiG2d0/d3gqS1qDHRKu7V7EeMncKsycqTL7AMxR6S7XsDTrRRSXH
         2kzLWxPmizyY+Ml1h7QeRi5Mf9+Ng1JRrWEmjaUVnvs4h/sCjaba7fpx7n9qtZ7cXzeD
         cou+gd3cv7RJQkriX+/UdweaunHzJOY62sN+G1B3N82ZvnnPBuwXBN2kR5a0DJ4QJePH
         6BJwdrR2G4rFI/rR1yDTLK0NAlaVVbJwHUSi97RhIAbnX4+EIqpFoEIzzcHFSdcSbRvL
         rTyP6WpyyVQ3kKAcT2txtSQfb8UUrVfFVNczmc5w537giVhl/w0S9TWxz0D9LLKRhYoT
         /kWA==
X-Gm-Message-State: AC+VfDxJMCh/Y+zZ89HJkq/2PtFcnP7YRyUl9BTlZ807t+SiHwxQnM2s
        0rPFvFgtJZErymFdcZTT0aAFuw==
X-Google-Smtp-Source: ACHHUZ4OencxIyiteR1gTHN/w956BWq0wYUIUAZ9LQOtewlzLnCvF9imBXrVLIFeLde8f6Cz/JoV6A==
X-Received: by 2002:a05:6a00:893:b0:634:7ba3:d142 with SMTP id q19-20020a056a00089300b006347ba3d142mr4831542pfj.10.1684532946605;
        Fri, 19 May 2023 14:49:06 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:d309:883d:817e:8e91:be39])
        by smtp.gmail.com with ESMTPSA id n14-20020aa7904e000000b006470a6ef529sm144891pfo.88.2023.05.19.14.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 14:49:06 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org, djakov@kernel.org,
        stephan@gerhold.net, Anders Roxell <anders.roxell@linaro.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH v7 06/11] dt-bindings: qcom-qce: Add compatibles for SM6115 and QCM2290
Date:   Sat, 20 May 2023 03:18:08 +0530
Message-Id: <20230519214813.2593271-7-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230519214813.2593271-1-bhupesh.sharma@linaro.org>
References: <20230519214813.2593271-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core clock for the Crypto Engine block on Qualcomm SoCs SM6115 and
QCM2290 are provided via the RPM block.

So mark the compatibles for these SoCs to indicate that only 'core'
clock is required for such SoCs.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Anders Roxell <anders.roxell@linaro.org>
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 .../devicetree/bindings/crypto/qcom-qce.yaml  | 44 +++++++++++++++----
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
index 90ddf98a6df9..bb828068c3b8 100644
--- a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
@@ -35,7 +35,9 @@ properties:
               - qcom,ipq6018-qce
               - qcom,ipq8074-qce
               - qcom,msm8996-qce
+              - qcom,qcm2290-qce
               - qcom,sdm845-qce
+              - qcom,sm6115-qce
           - const: qcom,ipq4019-qce
           - const: qcom,qce
 
@@ -52,16 +54,12 @@ properties:
     maxItems: 1
 
   clocks:
-    items:
-      - description: iface clocks register interface.
-      - description: bus clocks data transfer interface.
-      - description: core clocks rest of the crypto block.
+    minItems: 1
+    maxItems: 3
 
   clock-names:
-    items:
-      - const: iface
-      - const: bus
-      - const: core
+    minItems: 1
+    maxItems: 3
 
   iommus:
     minItems: 1
@@ -95,9 +93,37 @@ allOf:
             enum:
               - qcom,crypto-v5.1
               - qcom,crypto-v5.4
-              - qcom,ipq4019-qce
+              - qcom,ipq6018-qce
+              - qcom,ipq8074-qce
+              - qcom,msm8996-qce
+              - qcom,sdm845-qce
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          items:
+            - const: iface
+            - const: bus
+            - const: core
+      required:
+        - clocks
+        - clock-names
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,qcm2290-qce
+              - qcom,sm6115-qce
     then:
+      properties:
+        clocks:
+          maxItems: 1
+        clock-names:
+          items:
+            - const: core
       required:
         - clocks
         - clock-names
-- 
2.38.1

