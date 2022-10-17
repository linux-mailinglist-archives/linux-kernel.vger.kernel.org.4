Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE0D600B66
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbiJQJqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiJQJpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:45:40 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A6D4C617
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:45:35 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id bh7-20020a05600c3d0700b003c6fb3b2052so405537wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pk+5cT4R+rjX7Iv2a4OPV6jhHWag3vklZMTyv2veMWU=;
        b=A+5KCveXazFOFynAbsnosfvrlu0TJMZiNT3cXgUxoI7NgQLaCg/ZSPpOlhROZwUD1w
         oEPinChptvBL8RhQKQqFVNTrjJgMsfddVZHCQVIpH0ftWxTymJQVSZUZZ+H0u48cRsXV
         P5T+kcHfTKYDp6fvjdCS+XdcLC18/JFgUiDMma+Mm44YT19RJnDN3rBM5k9LERmGjspr
         lZj5UyCY81vmFaR8G3HI8Ebosnf+OkTixnKF6QVgeO1vzqDrxrSYXzWisqFmQwzf9i/u
         pQc83YO5fCkWHw4HWfAh4Q2kDsPtgPA2hQ7i8xnqEe3d6mQ5QbB5lQSRfzMSa+6qt8Bt
         IYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pk+5cT4R+rjX7Iv2a4OPV6jhHWag3vklZMTyv2veMWU=;
        b=lJhswJPXiwfLVO3EgM16/s4xgyoK5j0+BgjM+3bEbw9L6bqDGqX/v9reX4NlUMmeWm
         jYz/lZTcHW1A5ft1wdDvVFM6o3nMiCROsf6zW7Sz9fg31ZvYBP4lisKJTbmrPaQdUuYr
         lKOjoQOUcefKaUgSiZE5uyh5PwiVWsDcYthPqjt32ADRblGfkl7TE1UCSccOu4ruIpj2
         GKyR9EadTSqyYvHjKaDqECLyXpfhIfO59+kdcebvTSCitdh6hs+pJl7kmJR0dxILz2a1
         Xupd13fIl1g7Nq0amRQwpR9jfUMLmgkO/po79UxX3bppGOHTci2FwSqLbKZNAVcN6UE6
         KuDg==
X-Gm-Message-State: ACrzQf0GWKlaFqy68pWeVnssQEKrhtTAfVpxYDKX0qIo/QaB4e8iVVZH
        PED+vIPNa9pFIKZcfx1hE7JGlg==
X-Google-Smtp-Source: AMsMyM6R1N/Xegqz/c30Eq5iOEvB+8cEnG69RI8ffDTMxLlGH2nEii0cdsh2p8d5x1D/H85IkMa2NA==
X-Received: by 2002:a05:600c:548a:b0:3c6:fb49:4f84 with SMTP id iv10-20020a05600c548a00b003c6fb494f84mr616182wmb.153.1665999933833;
        Mon, 17 Oct 2022 02:45:33 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id d12-20020adfa40c000000b0022ca921dc67sm7824305wra.88.2022.10.17.02.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 02:45:33 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 17 Oct 2022 11:45:30 +0200
Subject: [PATCH v3 05/11] dt-bindings: mfd: qcom-pm8xxx: document qcom,pm8921 as
 fallback of qcom,pm8018
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220928-mdm9615-dt-schema-fixes-v3-5-531da552c354@linaro.org>
References: <20220928-mdm9615-dt-schema-fixes-v3-0-531da552c354@linaro.org>
In-Reply-To: <20220928-mdm9615-dt-schema-fixes-v3-0-531da552c354@linaro.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     linux-rtc@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-input@vger.kernel.org
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PM8018 is used as compatible with PM8921 on the MDM9615, document this situation,
and an example section to validate this change.

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
