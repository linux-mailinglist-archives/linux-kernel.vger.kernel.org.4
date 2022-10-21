Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A84A60737B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 11:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbiJUJJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 05:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbiJUJI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:08:57 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525941A3E11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 02:08:55 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id bu30so3813157wrb.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 02:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ivMBc50CrwMvnmWsDZJ3cyLehbUxsvRfzqxDjLbxT80=;
        b=no/QzRG5oCHxPbpyAtJdc2hxek8h0kycEwYqm9yysNQ+p56Wzw0mgQQr/txnj0N+8L
         C77sVn1mCPJ5jDzcyGW5mMQSFLgQp6M52zFTJR6tUrhgutloF0g9sg5JLSGRLh4O2lrg
         j2xwWrf2Tyj7BS8KTU6TtZ+RwhppBpp2pPUwhgBp/7Ik+FRyZqP+PAz+H/hKlH5+wVzx
         KoJU+BVwIa3wqh9s3r6HTdV+/DniBGYeioJqg14b5v1m1ExJqm96goz0DLUE0liUPmOD
         NzqZIDFdL5lWIALUhiNFrN/PU38eR+tTLHSUEP9Wwas7HpWLgyQLb9ocnkZycO5KVAV5
         W9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ivMBc50CrwMvnmWsDZJ3cyLehbUxsvRfzqxDjLbxT80=;
        b=Z4a581PaPDAPQoaPyU+OmPx1aIDEFbjR5y7KCf/CZ1mgIbRLc2FiR/1C5qDIyN1qn7
         X9QjZGa3e51CYbXCaF4lGv8Vju6wNmVxaGlbK8zNGxajipqlKc+nVGAFTrejAD2iWZzA
         N+EJCOZGN0ZWj9puBIhO+R/J4gqYvLWSlG1rziVbjgIROeaWiSxiDfXx9DI+ATzIuLb8
         ESwaQoocF3MPzC+YMSHRX2F+v9jisdAk0/kAvfpw6zirj/HPt1ypRxKRqOiKqLZgRdTu
         2bw+9hTKg2jTttcOQlFXql+zg6Q30BQEAgjKT7rA2GW886kbILgCC7iorRFqCkg98g//
         TtNA==
X-Gm-Message-State: ACrzQf1wPag6bRNLNHheH3Vf86zbKIybz1cS5n8rSsvFT1JNnkvWhgx2
        5cGMIgCRozlnSb4eSxvYYOLknA==
X-Google-Smtp-Source: AMsMyM4NVxyxxS10jNKy98DlGvIwDh/+gJTbrGu6SXYNr8gpjKefuBDAB4PLdy3mb441vKkEB1r4LQ==
X-Received: by 2002:adf:f0c5:0:b0:22f:fef4:7746 with SMTP id x5-20020adff0c5000000b0022ffef47746mr12175627wro.610.1666343333301;
        Fri, 21 Oct 2022 02:08:53 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c444a00b003c6f27d275dsm2230286wmn.33.2022.10.21.02.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 02:08:53 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 21 Oct 2022 11:06:41 +0200
Subject: [PATCH v4 05/11] dt-bindings: mfd: qcom-pm8xxx: document qcom,pm8921 as
 fallback of qcom,pm8018
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220928-mdm9615-dt-schema-fixes-v4-5-dac2dfaac703@linaro.org>
References: <20220928-mdm9615-dt-schema-fixes-v4-0-dac2dfaac703@linaro.org>
In-Reply-To: <20220928-mdm9615-dt-schema-fixes-v4-0-dac2dfaac703@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andy Gross <agross@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PM8018 is used as compatible with PM8921 on the MDM9615, document this situation,
and an example section to validate this change.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/mfd/qcom-pm8xxx.yaml       | 33 ++++++++++++++++++----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml b/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml
index 61bd0b3ce02f..84b87f01e029 100644
--- a/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml
@@ -15,11 +15,15 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - qcom,pm8018
-      - qcom,pm8058
-      - qcom,pm8821
-      - qcom,pm8921
+    oneOf:
+      - enum:
+          - qcom,pm8058
+          - qcom,pm8821
+          - qcom,pm8921
+      - items:
+          - enum:
+              - qcom,pm8018
+          - const: qcom,pm8921
 
   reg:
     maxItems: 1
@@ -52,4 +56,23 @@ required:
   - interrupt-controller
 
 additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    ssbi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      pmic@0 {
+        compatible = "qcom,pm8921";
+        reg = <0>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+
+        interrupt-parent = <&tlmm>;
+        interrupts = <32 IRQ_TYPE_EDGE_RISING>;
+      };
+    };
 ...

-- 
b4 0.10.1
