Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADEA62B7A2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbiKPKUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbiKPKUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:20:09 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E61912A9D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:20:08 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5so11556193wmo.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=abLnCQfmT+XQT6aD06ckoOE5xV2tdrjNEbUU00A7GbU=;
        b=uS7ki5F34mhuwfL0SfdXPitiKSVZkMAIG7y611sNMJi6qXzh6/BTOuMINJQRLMJIyU
         QUwLURyU7Vw6Bxo7JaOSPYdBszqOdWabEau/5fZPFDbE5TFXS2ztTF/4RiPI2ohPNQWM
         jPU6mjdbhRu82oOrRcOB4urwV7n+kdnJozJ2rWBwbEjI7M9gfNt2a7PlHu6GGcXkaS5i
         4qNfDomQp8jdSMowJrj6AV08ZsuVjnUYmR+B92OTXFrf0BXnyHBo1YjPK+q9Ohw+fmQu
         r0Gq2kpd/h9Gk/mHER2m2kOuQ1b56u5xBpsmQBvTxZovoJlWCmnECpJ7OsJwKf/L+157
         5PDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abLnCQfmT+XQT6aD06ckoOE5xV2tdrjNEbUU00A7GbU=;
        b=XO8DLln31v0qkAbYjPM7Bd+9cG12eo9Em6I+LlbF2JW//brB3GLYHO+lHAH1j+aBxF
         3ZifOYSbxN4uWIqvql8NkS7/Y3N3gp1eTgOLipgm2dcCDarTc2PKL1XLwCLmA/DSf+zT
         Bt7ZqBoeTBuoPu+ZA6VOOXyO/q4+dgq84ykpNZm3DWy3+1o1ltDKijgX1lOH1Tut0dah
         SkwdBQqa7nz6eG/egp6B+pMtlJFmCCX+yX4IX+Zwqe71D6t2HzECTj7hzizKUSRDbKOp
         XahesR04n8MDTWz72Q3xRITkfmcUcWVb/UXc9F5MX7/ZTSbHEI4Q6s8ykBiPq9tklOIX
         x4eA==
X-Gm-Message-State: ANoB5pmRksBr7L9Ff436Okpt4iZx4fADY+FPwZd1oP8djBpIQrUPnEIf
        g8GhCBlo8WhJgLqterenh6g9Hg==
X-Google-Smtp-Source: AA0mqf5gF84ZE8euD1zwPwjPj7xUiFfdK2JpKCMpW1Ikx2XVN8KYsocbCrdhtuQEUP6hNGg1Fmiswg==
X-Received: by 2002:a05:600c:524a:b0:3cf:6a41:9aec with SMTP id fc10-20020a05600c524a00b003cf6a419aecmr1644226wmb.159.1668594006964;
        Wed, 16 Nov 2022 02:20:06 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c4f1200b003c6f3f6675bsm1709900wmq.26.2022.11.16.02.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:20:06 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 16 Nov 2022 11:20:04 +0100
Subject: [PATCH 1/4] dt-bindings: remoteproc: qcom: adsp: document sm8550 adsp,
 cdsp & mpss compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221114-narmstrong-sm8550-upstream-remoteproc-v1-1-104c34cb3b91@linaro.org>
References: <20221114-narmstrong-sm8550-upstream-remoteproc-v1-0-104c34cb3b91@linaro.org>
In-Reply-To: <20221114-narmstrong-sm8550-upstream-remoteproc-v1-0-104c34cb3b91@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     devicetree@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This documents the compatible for the component used to boot the
aDSP, cDSP and MPSS on the SM8550 SoC.

The SM8550 boot process on SM8550 now requires a secondary "Devicetree"
firmware to be passed along the main Firmware, and the cDSP a new power
domain named "NSP".

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/remoteproc/qcom,adsp.yaml  | 60 +++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
index db9e0f0c2bea..678cb73f10de 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
@@ -55,6 +55,9 @@ properties:
       - qcom,sm8450-cdsp-pas
       - qcom,sm8450-mpss-pas
       - qcom,sm8450-slpi-pas
+      - qcom,sm8550-adsp-pas
+      - qcom,sm8550-cdsp-pas
+      - qcom,sm8550-mpss-pas
 
   reg:
     maxItems: 1
@@ -116,8 +119,13 @@ properties:
     $ref: /schemas/types.yaml#/definitions/string
     description: Firmware name for the Hexagon core
 
+  qcom,dtb-firmware-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: Devicetree Firmware name for the Hexagon core
+
   memory-region:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
     description: Reference to the reserved-memory for the Hexagon core
 
   qcom,qmp:
@@ -212,6 +220,9 @@ allOf:
               - qcom,sm8450-cdsp-pas
               - qcom,sm8450-slpi-pas
               - qcom,sm8450-mpss-pas
+              - qcom,sm8550-adsp-pas
+              - qcom,sm8550-cdsp-pas
+              - qcom,sm8550-mpss-pas
     then:
       properties:
         clocks:
@@ -327,6 +338,8 @@ allOf:
               - qcom,sm8450-adsp-pas
               - qcom,sm8450-cdsp-pas
               - qcom,sm8450-slpi-pas
+              - qcom,sm8550-adsp-pas
+              - qcom,sm8550-cdsp-pas
     then:
       properties:
         interrupts:
@@ -347,6 +360,7 @@ allOf:
               - qcom,sm8150-mpss-pas
               - qcom,sm8350-mpss-pas
               - qcom,sm8450-mpss-pas
+              - qcom,sm8550-mpss-pas
     then:
       properties:
         interrupts:
@@ -448,6 +462,7 @@ allOf:
               - qcom,sm8150-mpss-pas
               - qcom,sm8350-mpss-pas
               - qcom,sm8450-mpss-pas
+              - qcom,sm8550-mpss-pas
     then:
       properties:
         power-domains:
@@ -475,6 +490,7 @@ allOf:
               - qcom,sm8350-slpi-pas
               - qcom,sm8450-adsp-pas
               - qcom,sm8450-slpi-pas
+              - qcom,sm8550-adsp-pas
     then:
       properties:
         power-domains:
@@ -504,6 +520,25 @@ allOf:
             - const: cx
             - const: mxc
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8550-cdsp-pas
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: CX power domain
+            - description: MXC power domain
+            - description: NSP power domain
+        power-domain-names:
+          items:
+            - const: cx
+            - const: mxc
+            - const: nsp
+
   - if:
       properties:
         compatible:
@@ -573,6 +608,29 @@ allOf:
       properties:
         qcom,qmp: false
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8550-adsp-pas
+              - qcom,sm8550-cdsp-pas
+              - qcom,sm8550-mpss-pas
+    then:
+      properties:
+        memory-region:
+          minItems: 2
+          description:
+            First entry is a phandle for a reserved memory area that holds
+            the main Firmware for authentication, and second entry a phandle for a
+            reserved memory area that holds the Devicetree Firmware for authentication.
+    else:
+      properties:
+        qcom,dtb-firmware-name: false
+
+        memory-region:
+          maxItems: 1
+
 examples:
   - |
     #include <dt-bindings/clock/qcom,rpmcc.h>

-- 
b4 0.10.1
