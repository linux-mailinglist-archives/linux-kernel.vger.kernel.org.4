Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5A573704E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbjFTPUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbjFTPTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:19:44 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25ACF132
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 08:19:43 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f9b37cd58bso18868415e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 08:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687274381; x=1689866381;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mE4VjD0UC/mx9MRHv74c8SBo0/G+ZgbMYrMysjMI6p8=;
        b=dsRL0Gl6wDrfvoArQOSHh5Z9+zmsc9G5ziM1u/jWhxXx4LercvnLS1OMzbXJ7tZTl2
         YGdInhbNIqAakFoV2Wyh9jA+ZLn4w1LVoLsxX1cHsYyF1+RwG6RCyJQiL/xeg0w+pnzZ
         Zgpy5FB3nDWeM7VyHEoZIhL6v4yoWs2dYW1V9arSBLxRowxFNJycliC8KPFSnwIkL0qV
         ZkurVRnBONB5j7l9e+vyU4xW0IHda022DJJhGoekG7MuFIbuLbfmnJg80e5uClCDq7n3
         gBBi49C9p3SLPifUeNPD+5Mmk3z8Dz9UFaSbLsMGVSk2WgDo0Al0lRw1lH7qV2gRbJ9a
         O3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687274381; x=1689866381;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mE4VjD0UC/mx9MRHv74c8SBo0/G+ZgbMYrMysjMI6p8=;
        b=dU52kYYJ4zAuq1h0VUFnZQ7AW9cGiVnMb3lcoXjwJH/Uk2K0z9Iq0iy0dZGHWKIFAf
         XB+shcMJgDyUlM+DKEkUw8h+0MBPC8uZtdHD+libA8PYLZZ/NSn71gbC1PJ6jbK0q1zG
         WxSRQG8w1BhXGF69OJb5Fv03vo5osC0urzqPkxGr1Wy1105+HwbqLPzQAB115kAcawmo
         q4akgq6f9G+GOqX707BGDvGxCjvFQYRy1jF54NJOjBy4XOlCwxcs3Ug1q+ljKmUeh1uj
         reHM+XYEsgMIQbsxbmA5P1/FObnM0mp1A9OjBPMgUpUdM3ujD8l0JwCSVevy0m8yVODn
         G20A==
X-Gm-Message-State: AC+VfDy0DI2e7A0pLEeB+EHkF97DBxS9D9y2wh9pPMgGbe2E+fuNpwVc
        JWkMRqUBIurOxeOJ9K31P4PcJA==
X-Google-Smtp-Source: ACHHUZ7ifkwMcjR6VfzC1mw0iiDujkAUv87V6PC2X4oail3nVuNc2MbOp8lLC1VZEUI7cnHIQ1g2qg==
X-Received: by 2002:a05:600c:2197:b0:3f9:b358:ac20 with SMTP id e23-20020a05600c219700b003f9b358ac20mr3458180wme.37.1687274381524;
        Tue, 20 Jun 2023 08:19:41 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id x23-20020a05600c21d700b003f427687ba7sm2518659wmj.41.2023.06.20.08.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 08:19:41 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 20 Jun 2023 17:19:36 +0200
Subject: [PATCH 1/4] dt-bindings: net: bluetooth: qualcomm: document
 WCN7850 chipset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-topic-sm8550-upstream-bt-v1-1-4728564f8872@linaro.org>
References: <20230620-topic-sm8550-upstream-bt-v1-0-4728564f8872@linaro.org>
In-Reply-To: <20230620-topic-sm8550-upstream-bt-v1-0-4728564f8872@linaro.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1812;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Ujrhm0ILfBHIvctx7fFmL5jlXiqXUTm9FgwTzkhv1BI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkkcOJnzWD93WHMOLjrfltAL+pMgn9iPfdyOnvlyAh
 OHWq12+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJHDiQAKCRB33NvayMhJ0bbrEA
 CNtrxdcyViExvOj5EFssA7Mk8biKZ0olbgrUvwvYD4frXz2eVPtGSqzSmkgGq2AtuQRicpWwpdX4Cf
 y4KyNIHXuyvSLHgNxeGrgjIkNnnrJ9ZLcLQ9RYnMOs2evtGx/8QrPnpHQvdds9qeDWIxELmNEffkjw
 SWMCRy0H5DjsmW3fYw6Oiu3vrxSks1Nnawa+sRUkWV7DfNB7ITm4sEZUO+68LHAMCAQtrDCDo7CZAb
 /91yVXdMQmu1HfjCJhUs/DAryHcGA/hlaHFQMY542WOzEk3mu1r2qlpb20/lhNuwTNoGj2435Y9eaz
 mnpCg/HmlaaXzRuC+ez5lO8q39AUryhJ73PWL7y05sXepomNJRqqFQAgbJ6j/B2Mg9AXRuz23QDJIz
 6FbBeV6XzgxHPuZC/P+qkyaFn+LWMwUD17bEKQwfQRZS1KI6zgooQzsDDjrEgg9GWGZwSAvb/0CluM
 XzQNXlfdHjUbcVZumUuPcT+ZeCT4VL+BGEgGRNwsJrJ/PaTc94+egGlU5gs9Of3LzyLcFluwKJnLz4
 q1ZFKA7DemN4qJn01GuClW4EBXbWrzdwfugEYFPRyz1yfje0K8a0Z5BJWLWZuJGHyLWGKvmJlFAL6t
 uxglrOn20EsipjUQlmoaANa5tYqXBPnn6lpSv/hGw0YzMrmEHJaOpGsxpa8w==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the WCN7850 Bluetooth chipset.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
index 28296b6d35b2..abc81d0a706e 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -25,6 +25,7 @@ properties:
       - qcom,qca6390-bt
       - qcom,wcn6750-bt
       - qcom,wcn6855-bt
+      - qcom,wcn7850-bt
 
   enable-gpios:
     maxItems: 1
@@ -54,6 +55,9 @@ properties:
   vddaon-supply:
     description: VDD_AON supply regulator handle
 
+  vdddig-supply:
+    description: VDD_DIG supply regulator handle
+
   vddbtcxmx-supply:
     description: VDD_BT_CXMX supply regulator handle
 
@@ -69,6 +73,9 @@ properties:
   vddrfa1p2-supply:
     description: VDD_RFA_1P2 supply regulator handle
 
+  vddrfa1p9-supply:
+    description: VDD_RFA_1P9 supply regulator handle
+
   vddrfa2p2-supply:
     description: VDD_RFA_2P2 supply regulator handle
 
@@ -152,6 +159,22 @@ allOf:
         - vddrfa0p8-supply
         - vddrfa1p2-supply
         - vddrfa1p7-supply
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,wcn7850-bt
+    then:
+      required:
+        - enable-gpios
+        - swctrl-gpios
+        - vddio-supply
+        - vddaon-supply
+        - vdddig-supply
+        - vddrfa0p8-supply
+        - vddrfa1p2-supply
+        - vddrfa1p9-supply
 
 examples:
   - |

-- 
2.34.1

