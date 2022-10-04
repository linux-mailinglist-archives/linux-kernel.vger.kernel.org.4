Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B211C5F3DDB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiJDIJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiJDIId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:08:33 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175703F1F8
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 01:08:31 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id c11so20079521wrp.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 01:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=TcuoQ5ktJcYo5F9N8q9LPRH5UGZVfAhMsLe4JEH78bo=;
        b=uSiT4PAloi7jX8+OTdwLZ5lN/jpJPvhIJ1zoe8j/Zp6raBfLGf9VEjr5jvrd58SeJV
         3cVrQ4sw4lkisaOMIe6oz2UOfNOrsQ1SVfzaMsvH8e3P+iyMhM0oy2aJXPgqUA3k2zER
         diTxwpx8fnnNGsD9/e0LavO9C/VSoKXGMQqPDHZLgEngANSYWKfh/j/UIyxLQY8tXCc0
         E7i+hczB3jUyPSAEq/5OsEdfduXRy7OiNvCZNLppkaU2kMtTqnCOQvKWplS7p1e7WWnI
         0nNxOr5o2AGswziKNP07J+e2+G0gbRsy6i1gzNEesVtlqMwnK2/t/NS0zzfTJcVD9dft
         +1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=TcuoQ5ktJcYo5F9N8q9LPRH5UGZVfAhMsLe4JEH78bo=;
        b=ykkCh7Tn/7HoWP5Kh7uezp4yVG3cAF6sT9e0V0zMh98CuDfvriLWZpGsUM7FNJhwur
         FDKo7JDHQo9RXjqXvATsX2EDfR4iJ79UyqtMZIvIL7+a+NlfW1nv7jUfRg9nymvlmxCG
         pUMF+JwXGFxx7xiYYLMXn3lyoAebrcr6408nemkcvWA+I61yVMmdNK4SMyylg5SbiFFv
         IezrERZDzD7um36CgXjMcTgrxhmAJenr1pP4+zIPa3w4sLYcpIfPIybii1RhXsV2UMwd
         q1HzqBliF6HbDPN3B7fa8UPS/fr9yucjEHPn4jANrcirWHOc9O9gHMIp5vvj38y8eJkq
         ZHJg==
X-Gm-Message-State: ACrzQf2j1GjKf90jVg/0k1kzvwKBYlpk/OPWO0u5ykaFAzAFDhX0bku3
        /VFWFZQD5/n1UtAvOUjRjItoEg==
X-Google-Smtp-Source: AMsMyM4sYj+uy8z8eudjBw8BBWnpIphj/kOgOecKP1QXmoTnAjcB89PA8+Q2KVvGr3us4HgXfLsoTw==
X-Received: by 2002:adf:f982:0:b0:22e:343f:8daf with SMTP id f2-20020adff982000000b0022e343f8dafmr7319516wrr.475.1664870909366;
        Tue, 04 Oct 2022 01:08:29 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id l2-20020a1c7902000000b003b33943ce5esm20228866wme.32.2022.10.04.01.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 01:08:28 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 04 Oct 2022 08:08:21 +0000
Subject: [PATCH v2 05/11] dt-bindings: mfd: qcom-pm8xxx: document qcom,pm8921 as
 fallback of qcom,pm8018
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220928-mdm9615-dt-schema-fixes-v2-5-87fbeb4ae053@linaro.org>
References: <20220928-mdm9615-dt-schema-fixes-v2-0-87fbeb4ae053@linaro.org>
In-Reply-To: <20220928-mdm9615-dt-schema-fixes-v2-0-87fbeb4ae053@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-input@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org
X-Mailer: b4 0.10.0
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

diff --git a/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml b/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml
index 61bd0b3ce02f..24d71918ff8a 100644
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
@@ -52,4 +56,35 @@ required:
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
+
+      pmic@1 {
+        compatible = "qcom,pm8018", "qcom,pm8921";
+        reg = <1>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+
+        interrupt-parent = <&tlmm>;
+        interrupts = <33 IRQ_TYPE_EDGE_RISING>;
+      };
+    };
 ...

-- 
b4 0.10.0
