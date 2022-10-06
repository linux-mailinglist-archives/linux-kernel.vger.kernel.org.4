Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD895F6408
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 11:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbiJFJ6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 05:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbiJFJ6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:58:10 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C45289AC7
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 02:58:06 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id bg9-20020a05600c3c8900b003bf249616b0so596002wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 02:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=aDVuuxohN8L8ZPRLCLlwdW9F2UODgJO1tJLK75PaPoY=;
        b=FjaAUYk8yLz+J7RTwBMVHlYLleAJ6GPpH2sp6njsj/FylHJXlskVWcZOTcwXtdLfeg
         wTBRTuEM9MuM9/HaQIuyK/Fwn/gNWeOcRj7t8LWbA5JQA5yG3pY4Ph2hZpinMf18SSKg
         9GeC0BjaiiWR3Vq4VavRLLSA7y0NJvmcnxq8LicGbnUiiW7oOwjsxMcf4gMEKGZI5EgM
         CaxmNZDZu6geXz1nM6Ak/5y/Nyp1Lh5s5+JPeZMQHP/M/0v/ozhXMw9cGF0JN/FuvxUZ
         uyVoHNDTzP6+7tgsw6jcdzkeZ8ln+jnG/sUFakQ6OsxZhnm9ER9cl2cM6qZ/zhyS1bke
         MHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=aDVuuxohN8L8ZPRLCLlwdW9F2UODgJO1tJLK75PaPoY=;
        b=kdvQ86oZrYUZWxWjU37cnvEWe4MPRChrBFtrK8v8LXZUKfZLUCrezH+iCpdgV17C6L
         TJYU1oJMCYOTgGYk040ERWmDho5T1abCnMN24pwnL2OWz8qZt/8udLKQ9lw/K/HrCA4M
         NRibJD7eI+JWMy6fazCYY1MMHGPufJ+MqitesUy6UOeL5vnsQ3Qb5noWHT6R9jvuCjYw
         cwpGNnW8qHKXYQGt8za9OU2cN71i3zJD1ZMpGiLO9utUMUrynCAtsKVIVuq2vJ37+GzI
         DxIS40OCsF8zXUAEAysDqkEThftWmnekzkrijDtSovKSNMHnfNnNOcahIQRI7Giq08Sx
         PLPA==
X-Gm-Message-State: ACrzQf3r/aOMNRh/TzlIjojE4gCRbxyNmM3wFNwIdgiZVqA8Odf0ZvvH
        2Dadhfi6GRQx+UipmXPH8GXP+g==
X-Google-Smtp-Source: AMsMyM4X8o94CxKxfj/ssUFMcxzBjpK7EdIIsB8b020Bl1OvlaUBb8nXaqjc+Q1/BCZdsvYM0Go7WA==
X-Received: by 2002:a05:600c:524d:b0:3b4:91ee:933e with SMTP id fc13-20020a05600c524d00b003b491ee933emr2619096wmb.80.1665050284332;
        Thu, 06 Oct 2022 02:58:04 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id q11-20020adf9dcb000000b0022ac672654dsm17935603wre.58.2022.10.06.02.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 02:58:03 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 06 Oct 2022 09:58:01 +0000
Subject: [PATCH 4/6] dt-bindings: soc: qcom: convert non-smd RPM bindings to
 dt-schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mdm9615-pinctrl-yaml-v1-4-0cbc006e2a30@linaro.org>
References: <20221005-mdm9615-pinctrl-yaml-v1-0-0cbc006e2a30@linaro.org>
In-Reply-To: <20221005-mdm9615-pinctrl-yaml-v1-0-0cbc006e2a30@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>, Lee Jones <lee@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-gpio@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
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

Convert the non-SMD RPM node bindings to dt-schema, the regulators subnode
refers to regulators,yaml until we have the proper bindings.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/mfd/qcom-rpm.txt | 39 +-----------
 .../devicetree/bindings/soc/qcom/qcom,ipc-rpm.yaml | 73 ++++++++++++++++++++++
 2 files changed, 74 insertions(+), 38 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/qcom-rpm.txt b/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
index b823b8625243..b622359e73c2 100644
--- a/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
+++ b/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
@@ -5,44 +5,7 @@ various Qualcomm platforms. The RPM allows each component in the system to vote
 for state of the system resources, such as clocks, regulators and bus
 frequencies.
 
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: must be one of:
-		    "qcom,rpm-apq8064"
-		    "qcom,rpm-msm8660"
-		    "qcom,rpm-msm8960"
-		    "qcom,rpm-ipq8064"
-		    "qcom,rpm-mdm9615"
-
-- reg:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: base address and size of the RPM's message ram
-
-- interrupts:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: three entries specifying the RPM's:
-		    1. acknowledgement interrupt
-		    2. error interrupt
-		    3. wakeup interrupt
-
-- interrupt-names:
-	Usage: required
-	Value type: <string-array>
-	Definition: must be the three strings "ack", "err" and "wakeup", in order
-
-- qcom,ipc:
-	Usage: required
-	Value type: <prop-encoded-array>
-
-	Definition: three entries specifying the outgoing ipc bit used for
-		    signaling the RPM:
-		    - phandle to a syscon node representing the apcs registers
-		    - u32 representing offset to the register within the syscon
-		    - u32 representing the ipc bit within the register
-
+Please refer to soc/qcom/qcom,ipc-rpm.yaml
 
 = SUBNODES
 
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,ipc-rpm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,ipc-rpm.yaml
new file mode 100644
index 000000000000..d416950189d1
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,ipc-rpm.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/soc/qcom/qcom,ipc-rpm.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm Resource Power Manager (RPM) over IPC
+
+description: |
+  This driver is used to interface with the Resource Power Manager (RPM) found
+  in various Qualcomm platforms. The RPM allows each component in the system
+  to vote for state of the system resources, such as clocks, regulators and bus
+  frequencies.
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - qcom,rpm-apq8064
+      - qcom,rpm-msm8660
+      - qcom,rpm-msm8960
+      - qcom,rpm-ipq8064
+      - qcom,rpm-mdm9615
+
+  reg: true
+
+  interrupts:
+    minItems: 3
+
+  interrupt-names:
+    items:
+      - const: ack
+      - const: err
+      - const: wakeup
+
+  qcom,ipc:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to a syscon node representing the APCS registers
+          - description: u32 representing offset to the register within the syscon
+          - description: u32 representing the ipc bit within the register
+    description:
+      Three entries specifying the outgoing ipc bit used for signaling the RPM.
+
+  regulators:
+    type: object
+    $ref: /schemas/regulator/regulator.yaml#
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - qcom,ipc
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    rpm@108000 {
+      compatible = "qcom,rpm-msm8960";
+      reg = <0x108000 0x1000>;
+      qcom,ipc = <&apcs 0x8 2>;
+
+      interrupts = <GIC_SPI 19 IRQ_TYPE_NONE>, <GIC_SPI 21 IRQ_TYPE_NONE>, <GIC_SPI 22 IRQ_TYPE_NONE>;
+      interrupt-names = "ack", "err", "wakeup";
+    };

-- 
b4 0.10.1
