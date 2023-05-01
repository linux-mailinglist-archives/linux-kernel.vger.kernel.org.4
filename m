Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070A56F36AB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 21:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbjEATZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 15:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbjEATYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 15:24:52 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9F62724
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 12:24:49 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-63b46186c03so3333637b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 12:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682969088; x=1685561088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPsBIL7uoiC5DZZtXnqdAvBon8Zv1+SeehoREZW26xk=;
        b=pgyknais4aRab1t8pmNSA0qMa1ozYTzChr8M7CXa8qRg2oxhzSom0qyDRFUJ+f1erU
         jZWydaadlr4eL0JdWMc8tqJ5wKlbdpQeg4PLXCoktQuIWrHCKRD20XTque+y+JSKGuVd
         0rqW9+F0aB6RLb5TAj0tzkRIOBI7zgD/3TUzZjJ4iowAh305WiTQ5mv6TTpa6G1iBNPe
         96pbLMZXYNNdZs7H695/hzZ9uQXKbSu4sVMieyscIO3VDG5CMGZ3xifchs+Llm2pDq1q
         icrjKjTUQVFkujL+u5xRdBNky0sIIdn/Nl+c/7i09p2rbIzBzWTtMN+pBB0kXl1BMKCj
         3SEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969088; x=1685561088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jPsBIL7uoiC5DZZtXnqdAvBon8Zv1+SeehoREZW26xk=;
        b=EYOuXCeDoxI2q63nUpMh6700i13BJVrC/52nmRE5/5/g2ngwvy8kl92qoQQl9UoWch
         2Vgqk7jy5Uo6s0xaE9AZzFn29aCQTwhacsk07yLL3QfCgvHaM1l8E6ACn/O5vywoTANT
         LNwimPmNoDbQ2ELhwuuW/0BV/y5oVOgvEGJhCDOfn0JG87ulxbKuu10XptJMFu6HkIH1
         jNh6+4JsfPc1XWGxIVjACt/lDAIcPr/BuoAanFd6hIe9NnqtkFFihspNDXOmJkAZkNGZ
         CRxY/64tD2tlBEZPXmNmpLE8sJFdV/oIFpMKxH/Cw7PaDpXKaIzA9g4brnXV7l+dXnqy
         H76Q==
X-Gm-Message-State: AC+VfDzHXC618gfoyT9yWBL+Z1vAfHtZZhqwQCn+1zY/coRWO7MIMdbe
        nrSPi3E+wfxpRUltyRm7XSK+ww==
X-Google-Smtp-Source: ACHHUZ7sREX3Zv6nkVkFFrf4WGA8ndPhcbEV/7rDkQXbuGPz9UEh/nfjA/Bfqf679yxKsnvjpgwqKA==
X-Received: by 2002:a05:6a20:3949:b0:f0:302a:ccdf with SMTP id r9-20020a056a20394900b000f0302accdfmr3932495pzg.52.1682969088010;
        Mon, 01 May 2023 12:24:48 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1f3b:58fa:39f6:37e1:bb9a:a094])
        by smtp.gmail.com with ESMTPSA id 189-20020a6304c6000000b00513cc8c9597sm17459144pge.10.2023.05.01.12.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:24:47 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        andersson@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, konrad.dybcio@linaro.org, kishon@kernel.org,
        vkoul@kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH v9 1/4] dt-bindings: phy: qcom,qmp-usb: Drop legacy bindings and move to newer one (SM6115 & QCM2290)
Date:   Tue,  2 May 2023 00:54:29 +0530
Message-Id: <20230501192432.1220727-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230501192432.1220727-1-bhupesh.sharma@linaro.org>
References: <20230501192432.1220727-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'qcom,msm8996-qmp-usb3-phy.yaml' defines bindings for several PHYs
which predate USB -> USB+DP migration. Since SM6115 and QCM2290
nodes for USB QMP phy are being added to dtsi files by followup patches,
move these bindings instead to the newer style
'qcom,sc8280xp-qmp-usb3-uni-phy.yaml' file.

Since no device trees use these bindings presently, so we have no ABI breakages
with this patch.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 .../phy/qcom,msm8996-qmp-usb3-phy.yaml        | 27 ------------
 .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml   | 44 ++++++++++++++++---
 2 files changed, 39 insertions(+), 32 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
index e81a38281f8c..4c96dab5b9e3 100644
--- a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
@@ -23,14 +23,12 @@ properties:
       - qcom,ipq8074-qmp-usb3-phy
       - qcom,msm8996-qmp-usb3-phy
       - qcom,msm8998-qmp-usb3-phy
-      - qcom,qcm2290-qmp-usb3-phy
       - qcom,sc7180-qmp-usb3-phy
       - qcom,sc8180x-qmp-usb3-phy
       - qcom,sdm845-qmp-usb3-phy
       - qcom,sdm845-qmp-usb3-uni-phy
       - qcom,sdx55-qmp-usb3-uni-phy
       - qcom,sdx65-qmp-usb3-uni-phy
-      - qcom,sm6115-qmp-usb3-phy
       - qcom,sm8150-qmp-usb3-phy
       - qcom,sm8150-qmp-usb3-uni-phy
       - qcom,sm8250-qmp-usb3-phy
@@ -248,29 +246,6 @@ allOf:
             - const: phy
             - const: common
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,qcm2290-qmp-usb3-phy
-              - qcom,sm6115-qmp-usb3-phy
-    then:
-      properties:
-        clocks:
-          maxItems: 3
-        clock-names:
-          items:
-            - const: cfg_ahb
-            - const: ref
-            - const: com_aux
-        resets:
-          maxItems: 2
-        reset-names:
-          items:
-            - const: phy_phy
-            - const: phy
-
   - if:
       properties:
         compatible:
@@ -318,12 +293,10 @@ allOf:
             enum:
               - qcom,ipq6018-qmp-usb3-phy
               - qcom,ipq8074-qmp-usb3-phy
-              - qcom,qcm2290-qmp-usb3-phy
               - qcom,sc7180-qmp-usb3-phy
               - qcom,sc8180x-qmp-usb3-phy
               - qcom,sdx55-qmp-usb3-uni-phy
               - qcom,sdx65-qmp-usb3-uni-phy
-              - qcom,sm6115-qmp-usb3-phy
               - qcom,sm8150-qmp-usb3-uni-phy
               - qcom,sm8250-qmp-usb3-phy
     then:
diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
index 16fce1038285..05335e6bbb58 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
@@ -16,7 +16,9 @@ description:
 properties:
   compatible:
     enum:
+      - qcom,qcm2290-qmp-usb3-phy
       - qcom,sc8280xp-qmp-usb3-uni-phy
+      - qcom,sm6115-qmp-usb3-phy
 
   reg:
     maxItems: 1
@@ -25,11 +27,7 @@ properties:
     maxItems: 4
 
   clock-names:
-    items:
-      - const: aux
-      - const: ref
-      - const: com_aux
-      - const: pipe
+    maxItems: 4
 
   power-domains:
     maxItems: 1
@@ -71,6 +69,42 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,qcm2290-qmp-usb3-phy
+              - qcom,sm6115-qmp-usb3-phy
+    then:
+      properties:
+        clocks:
+          maxItems: 4
+        clock-names:
+          items:
+            - const: cfg_ahb
+            - const: ref
+            - const: com_aux
+            - const: pipe
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc8280xp-qmp-usb3-uni-phy
+    then:
+      properties:
+        clocks:
+          maxItems: 4
+        clock-names:
+          items:
+            - const: aux
+            - const: ref
+            - const: com_aux
+            - const: pipe
+
 examples:
   - |
     #include <dt-bindings/clock/qcom,gcc-sc8280xp.h>
-- 
2.38.1

