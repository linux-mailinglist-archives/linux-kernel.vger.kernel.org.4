Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32113710B89
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 13:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241031AbjEYLyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 07:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241086AbjEYLy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 07:54:27 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB96E7
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 04:54:26 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f603ff9c02so3754075e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 04:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685015664; x=1687607664;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qI+tnKYeBV4GMz2vKFYWfls6bVP2/IwsUcGIW95Xkqc=;
        b=ElRL56OwNSd47fe/sFFtAF2z8s2v/dwV3Yzhy+U5huR5oyUl1zoIAtsvfIIQnZSVN+
         soPEWiCe8Z7/WZYj2vw8hDH/99VuxybfzFEC4Z9aXpk8AkWfMNRsB4e5k9In/e3lyXDH
         oUSrp7yOtoOWgfYQXJICLr30VYW1gdiTV2YFNSKkaqaOwACHvAy8EGFuTQ5QmwziEYrT
         FDTYkmuFG9g9DD0w592h/+YjoDOv+5ixDuE/NOJzxc+7QR1GFOl3+3hcRa+G5m3f7/aU
         qMFTKf/r/v5VjT8WTZYizUBBhZi/YGIYI8u8U6BY8XV16A/qyNyrDROn1rHQL8hLLyjR
         o3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685015664; x=1687607664;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qI+tnKYeBV4GMz2vKFYWfls6bVP2/IwsUcGIW95Xkqc=;
        b=BZrIZwJO61E735zZOewUrssLSBv+W/QvRDqTtXVxPmGhEPrUYcZEw/AMyLRcFI3RFa
         +H3Ezyc8cejrhCq1gfslaEqy3FyNbcinWLwgfbzy1FwU/cTy8B4G6S6Du7ZDn2WTVQQ2
         S8L/5ApTdoT6nLbpO/Isgjs3GYsMDD94o+2oj/vEdbWSPDgXKC7AhFxLuUYzInyOiCf5
         MocA5Sr5jyVZoYFpjyNLgvZxHnklY4KIIoREwfAus1e8kUHXi1yiv2VZ5WzKXF7jqlDJ
         phGBX0rh79dBs2psKzUKbcV8kmyzHfLOdXhQniwsS/SJLg5qBHPFDPZwjyPIG94lql1L
         vecw==
X-Gm-Message-State: AC+VfDxtIRBjOHw5zhM5NcuTcRlFoKNUbbq9IDBWOKFkt8AKXamGH+ue
        52lzBYzEyKOPnkydsxzWcMPAb8IQXNwNc+xYWT0q/w==
X-Google-Smtp-Source: ACHHUZ7ZsYE/qGR8bzj6kdG24EqFTFMOldOjYZwJKNYVYXoHjTPLdHGhE3ouPaKwjFLVZZgfDzferQ==
X-Received: by 2002:a05:600c:2193:b0:3f6:a966:ee8d with SMTP id e19-20020a05600c219300b003f6a966ee8dmr2411769wme.26.1685015664571;
        Thu, 25 May 2023 04:54:24 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id n26-20020a7bc5da000000b003f42894ebe2sm5545497wmk.23.2023.05.25.04.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 04:54:24 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 25 May 2023 13:54:22 +0200
Subject: [PATCH v2] dt-bindings: leds: qcom-lpg: document PM8550 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230522-topic-sm8550-upstream-pm8550-lpg-v2-1-c5117f1d41f9@linaro.org>
X-B4-Tracking: v=1; b=H4sIAG1Mb2QC/5WOQQ6DIBBFr2JYdxpEsdpV79G4QBx1EgQCatoY7
 15qT9Dle4v//s4iBsLI7tnOAm4UydkE4pIxPSk7IlCfmAkuCi6FgMV50hDnWkoOq49LQDWD/7H
 xI8huKHlTl0IXPUsznYoIXVBWT2nIrsYk6QMO9Dq7zzbxRHFx4X3e2PKv/aO45ZDDwPNK3uq+w
 ap4GLIquKsLI2uP4/gAVQGBPOYAAAA=
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1997;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=kPRYNV4K17vjrM7zMU7IVDGSk2yNxMfdEXdzViHYqSw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkb0xvItfRk4e/KvAfmzFLi/cqFz22RkU2hSMfXzgP
 Ju3oQ02JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZG9MbwAKCRB33NvayMhJ0el4D/
 99ARndkHN3yS2uDwGyYZPU1G8qvaTzlv6AaH+JmDAH3Bi29ZvJpyNsISflLK48qU2IYqdNiwAyPVEG
 JgMublBb7PUNu7VpXyRAJYfUTfTW03ahJDpVN6YghHCj7JsiIcIKs7Y7rFfZUi4RzAznB8+vbyDY+2
 sBL+1eGMEaDd1FWGPjdOtuvwq0RPud1hEDPG9z8OU1qnjlDk7buEHaPpdiW/xEWILR+DXj/PeT6p0k
 JcyK0pXv4GwvVh9unIriel+FblvoPjZauJ0bD3XYNLWPbNgWflRIDVeJNy6yTv44kicIhYeoXJRpGO
 4BlN2OEF1Asvyqb12uTq4NLCCiG/2siaTNLG5bQCXNB4nGW8Z6oHHnxPqXfzNE/MtvDMYL6FaEXbSd
 YObQycLsS6N0ZsQ5v/bms3AHAWll8yeRH+uyLKvezxxHLeZYMUVNo5QtRO1fQrp16dxwZ4ziXsuCHB
 mMR/+1b4cWBA/BCEL64rJJc9fKo0d0TZvbcXrTVm/9gcjfZzWGqrdgNncVty16y7JwFAUWa0m/6i07
 tg3PTWq3hqL6pAt0s2GK5YCGbVXrarVZ7Mig+UG/HCxy0NW3+LyjSOI4WPr/Dd6j5MPWxztZ+FV4on
 EuircZi6PKJuepgSR20uZs9fGkwtK8CrNWa4CfW+hsgUi57r7Ios0SJVYYpA==
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

The PM8550 PWM modules are compatible with the PM8350c PWM modules,
document the PM8350c PWM compatible as fallback for the PM8550 PWM.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Rebased on for-leds-next
- Link to v1: https://lore.kernel.org/r/20230522-topic-sm8550-upstream-pm8550-lpg-v1-1-f016578d9e63@linaro.org
---
 .../devicetree/bindings/leds/leds-qcom-lpg.yaml    | 31 +++++++++++++---------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
index 5550eef16593..e6f1999cb22f 100644
--- a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
@@ -16,19 +16,24 @@ description: >
 
 properties:
   compatible:
-    enum:
-      - qcom,pm660l-lpg
-      - qcom,pm8150b-lpg
-      - qcom,pm8150l-lpg
-      - qcom,pm8350c-pwm
-      - qcom,pm8916-pwm
-      - qcom,pm8941-lpg
-      - qcom,pm8994-lpg
-      - qcom,pmc8180c-lpg
-      - qcom,pmi632-lpg
-      - qcom,pmi8994-lpg
-      - qcom,pmi8998-lpg
-      - qcom,pmk8550-pwm
+    oneOf:
+      - enum:
+          - qcom,pm660l-lpg
+          - qcom,pm8150b-lpg
+          - qcom,pm8150l-lpg
+          - qcom,pm8350c-pwm
+          - qcom,pm8916-pwm
+          - qcom,pm8941-lpg
+          - qcom,pm8994-lpg
+          - qcom,pmc8180c-lpg
+          - qcom,pmi632-lpg
+          - qcom,pmi8994-lpg
+          - qcom,pmi8998-lpg
+          - qcom,pmk8550-pwm
+      - items:
+          - enum:
+              - qcom,pm8550-pwm
+          - const: qcom,pm8350c-pwm
 
   "#pwm-cells":
     const: 2

---
base-commit: 0113cea8fd729ea6187e8d330f74a7e2a73bd970
change-id: 20230522-topic-sm8550-upstream-pm8550-lpg-5bf409842c3d

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

