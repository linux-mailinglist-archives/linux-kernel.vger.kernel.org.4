Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABADE600B64
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiJQJp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiJQJpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:45:40 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9158050716
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:45:37 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id j7so17601925wrr.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5B2y+sKndDSQfGcgLhS+10QweGKjE1dYN1ycNWO2IKo=;
        b=W+9Tjco/FlSwNeCm9bm+6WaQvn1hw5Oz08sH6n0XEk77QzOsdf0CzXOXryNDbLbGNl
         TL3Qfh36BDOEDInDmacLjlR2rolkd+jaangXT8EO7H/3eKZ5H+jzDSV8k4z5j01snjUo
         HbtbTssFUlDTh5X8W4Wmqq8389myQmeTVAMuzdG7ZWTRCn5srpoD+tzj234I9bTq1cKV
         hUb0SoX1VsbwBEjxMp8Z5fKrcY8E/RotJ7Orr14ACqAIe4xVwQsjO1DW8j9vFrf9cEnM
         14KmarnmMNWK/Ze2O2elnts6klM0ygK3rZdilSp4E5tc6f/pfIrPsdSEPzKZQ3Sy4o6O
         OZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5B2y+sKndDSQfGcgLhS+10QweGKjE1dYN1ycNWO2IKo=;
        b=UBwHrUdy/OZ+eTHr/+vqmEMpkhZNxKKptuw/OwKw5eH3hpuyvEAgO5OewYZRugATJq
         onsRtKX3155swPdGJJnkkLdqifGN311BWvSj+eOZbTznj9KoivTpmDvSSq6TVAvoJ7Hi
         q57rNf4/QCp+HEnnLQwarQBwoFcjKY1t5YwsmmI0ooLNTD9chTFszZahtdtEHvgrKeHG
         ZurpRomvDhs/20gGkdJ9Orxu3YMbj5fvq/gnSt6YbnHFyImAJgDduTUlvv34u0q9Y5C9
         NeFGozpJZHf4I9eDXPI2KCjz5+dwdg8MKir2Wn63cWZyRDnefzaVH7pSiyQGqkxH63jv
         dJsg==
X-Gm-Message-State: ACrzQf1buVGTP0mLzVmhtVBKgVAXA3p+vGwtS461L0f7lK2SGearFsiC
        qoD7WHaG49vzvvmY2EdRXCqmkA==
X-Google-Smtp-Source: AMsMyM5JUQ4bgd7o8Kw7tQCxq+3XhMEWhqa5FuQfr8bZVFDEOEZLfPQnmAzJmqItGpwUtrfcJiJ6dw==
X-Received: by 2002:a5d:47a8:0:b0:231:ca77:ac57 with SMTP id 8-20020a5d47a8000000b00231ca77ac57mr5564756wrb.384.1665999934759;
        Mon, 17 Oct 2022 02:45:34 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id d12-20020adfa40c000000b0022ca921dc67sm7824305wra.88.2022.10.17.02.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 02:45:34 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 17 Oct 2022 11:45:31 +0200
Subject: [PATCH v3 06/11] dt-bindings: input: qcom,pm8921-pwrkey: convert to dt-schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220928-mdm9615-dt-schema-fixes-v3-6-531da552c354@linaro.org>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert input/qcom,pm8xxx-pwrkey.txt to YAML, and take in account that
the PM8921 pwrkey compatible is used as fallback for the PM8018 pwrkey.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/input/qcom,pm8921-pwrkey.yaml         | 75 ++++++++++++++++++++++
 .../bindings/input/qcom,pm8xxx-pwrkey.txt          | 46 -------------
 2 files changed, 75 insertions(+), 46 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/qcom,pm8921-pwrkey.yaml b/Documentation/devicetree/bindings/input/qcom,pm8921-pwrkey.yaml
new file mode 100644
index 000000000000..9591f77aa22a
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/qcom,pm8921-pwrkey.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/qcom,pm8921-pwrkey.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm PM8921 PMIC Power Key
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+
+allOf:
+  - $ref: input.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - qcom,pm8921-pwrkey
+          - qcom,pm8058-pwrkey
+      - items:
+          - enum:
+              - qcom,pm8018-pwrkey
+          - const: qcom,pm8921-pwrkey
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: key release
+      - description: key press
+
+  debounce:
+    description: |
+          Time in microseconds that key must be pressed or
+          released for state change interrupt to trigger.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  pull-up:
+    description: |
+           Presence of this property indicates that the KPDPWR_N
+           pin should be configured for pull up.
+    $ref: /schemas/types.yaml#/definitions/flag
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+   #include <dt-bindings/interrupt-controller/irq.h>
+   ssbi {
+     #address-cells = <1>;
+     #size-cells = <0>;
+
+     pmic@0 {
+       reg = <0x0>;
+       #address-cells = <1>;
+       #size-cells = <0>;
+
+       pwrkey@1c {
+         compatible = "qcom,pm8921-pwrkey";
+         reg = <0x1c>;
+         interrupt-parent = <&pmicint>;
+         interrupts = <50 IRQ_TYPE_EDGE_RISING>, <51 IRQ_TYPE_EDGE_RISING>;
+         debounce = <15625>;
+         pull-up;
+       };
+     };
+   };
+...
diff --git a/Documentation/devicetree/bindings/input/qcom,pm8xxx-pwrkey.txt b/Documentation/devicetree/bindings/input/qcom,pm8xxx-pwrkey.txt
deleted file mode 100644
index 588536cc96ed..000000000000
--- a/Documentation/devicetree/bindings/input/qcom,pm8xxx-pwrkey.txt
+++ /dev/null
@@ -1,46 +0,0 @@
-Qualcomm PM8xxx PMIC Power Key
-
-PROPERTIES
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: must be one of:
-		    "qcom,pm8058-pwrkey"
-		    "qcom,pm8921-pwrkey"
-
-- reg:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: address of power key control register
-
-- interrupts:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: the first interrupt specifies the key release interrupt
-		    and the second interrupt specifies the key press interrupt.
-		    The format of the specifier is defined by the binding
-		    document describing the node's interrupt parent.
-
-- debounce:
-	Usage: optional
-	Value type: <u32>
-	Definition: time in microseconds that key must be pressed or release
-		    for state change interrupt to trigger.
-
-- pull-up:
-	Usage: optional
-	Value type: <empty>
-	Definition: presence of this property indicates that the KPDPWR_N pin
-		    should be configured for pull up.
-
-EXAMPLE
-
-	pwrkey@1c {
-		compatible = "qcom,pm8921-pwrkey";
-		reg = <0x1c>;
-		interrupt-parent = <&pmicintc>;
-		interrupts = <50 1>, <51 1>;
-		debounce = <15625>;
-		pull-up;
-	};

-- 
b4 0.10.1
