Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB2E6C791D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 08:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjCXHlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 03:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjCXHlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 03:41:39 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991F525B81
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:41:37 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b20so4465800edd.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1679643696;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e0n73iZ8VJIt54nEx9Q7fNmrfFMw8zxjDedrs3LziIE=;
        b=ZgoCJhbx7jqrXRcPUZMkEl51Sb5ctO/NU6fKtzeFTfNP1oNNxxD9ihAaBkwLDBxnrP
         jO4HJBcfgCEjbRTNTNMa8IiAjtqWV6itywJhUg0dksc+NVYbi1M/mwNSAtCl/RQafFfu
         cMeOj527FqHLT+mt2w1m+kOKsdTD62sAG4yuidM05mE/Z1EdvjDE/zdhY4qtF7hZuFAC
         OGSLIcRrraavOdOg8I1Oc3ILsDnMHv+agbnXyDRmlAjrho17JK2PRt5ylXhb/jab5ZAH
         Ef/PdRbCRy7Az12rQb2HNXfhQjPrTBJT69BMq4/v16OUv9U+hyDu90HuHnqHKbC+SoTn
         QixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679643696;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0n73iZ8VJIt54nEx9Q7fNmrfFMw8zxjDedrs3LziIE=;
        b=kcnC/99HmjZqGuJQbRDBFqjF1JV8B+FRzES7rfrjO6GgFWb/YPKjgakiOIMfO1Y7GR
         R930bscjiUZHExGsWRgHQJcoz7fHcyTyJX91jQ/ob4FxRNiJ1js1w/dbCfj45k2/nYnL
         8pV2xFCR3HV1IiTWdKbko9Rr6Fv9RVqBNvJThEz+oye4Y3RRnQv29JuxyY2Lxej8HkGP
         MuZ7DXAIhb4hxEWTHjIWnpGQIX7dY4W9CYe8VpU5QlAgdfc+z42b/4NgXZwcRmBn1J6d
         WVdfQN+Qq70qO/823ADekrWBKUOeOTcp9uHnBzEwaB0+yKzO/zT6MRTCDMoeDXfL0JgL
         Fpeg==
X-Gm-Message-State: AAQBX9dgIh4Y33cpDRfQZyMM523XyfpThlG0uwb1Sk5y2wIPRNS+xn+D
        XPtW/B4l3yLIsP94gcaADhT5gg==
X-Google-Smtp-Source: AKy350abskR8P4cqQaIB6SmOAJ/5w82M5UcNawDqlSgx0L7XYyF4R1ERvpCx/v3JOC3ev2IBCfj27g==
X-Received: by 2002:a17:907:1905:b0:8b1:3467:d71b with SMTP id ll5-20020a170907190500b008b13467d71bmr1987216ejc.48.1679643696142;
        Fri, 24 Mar 2023 00:41:36 -0700 (PDT)
Received: from [192.168.0.29] (84-115-214-73.cable.dynamic.surfer.at. [84.115.214.73])
        by smtp.gmail.com with ESMTPSA id d23-20020a50f697000000b004fd2a7aa1ecsm10271227edn.32.2023.03.24.00.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 00:41:35 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Fri, 24 Mar 2023 08:41:29 +0100
Subject: [PATCH v3 2/3] dt-bindings: ufs: qcom: Add reg-names property for
 ICE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221209-dt-binding-ufs-v3-2-499dff23a03c@fairphone.com>
References: <20221209-dt-binding-ufs-v3-0-499dff23a03c@fairphone.com>
In-Reply-To: <20221209-dt-binding-ufs-v3-0-499dff23a03c@fairphone.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Iskren Chernev <me@iskren.info>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code in ufs-qcom-ice.c needs the ICE reg to be named "ice". Add this
in the bindings so the existing dts can validate successfully.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index 23447281deec..ebc8e1adbc6f 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -75,6 +75,10 @@ properties:
     minItems: 1
     maxItems: 2
 
+  reg-names:
+    minItems: 1
+    maxItems: 2
+
   required-opps:
     maxItems: 1
 
@@ -129,6 +133,8 @@ allOf:
         reg:
           minItems: 1
           maxItems: 1
+        reg-names:
+          maxItems: 1
 
   - if:
       properties:
@@ -157,6 +163,12 @@ allOf:
         reg:
           minItems: 2
           maxItems: 2
+        reg-names:
+          items:
+            - const: std
+            - const: ice
+      required:
+        - reg-names
 
   - if:
       properties:
@@ -185,6 +197,8 @@ allOf:
         reg:
           minItems: 1
           maxItems: 1
+        reg-names:
+          maxItems: 1
 
   - if:
       properties:
@@ -210,6 +224,12 @@ allOf:
         reg:
           minItems: 2
           maxItems: 2
+        reg-names:
+          items:
+            - const: std
+            - const: ice
+      required:
+        - reg-names
 
     # TODO: define clock bindings for qcom,msm8994-ufshc
 

-- 
2.40.0

