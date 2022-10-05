Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D325F5686
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 16:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiJEOfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 10:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiJEOfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 10:35:46 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F4B4B0F2
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 07:35:44 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id w18so17509608wro.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 07:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date;
        bh=/HLruxGgGVWFncdsJK8Ic/uhD33pY74fCK6mndQ+k2E=;
        b=iXvh/tjfyMnaFTN5VgIjAIzg+3dicavaT6RFTn4CZ+JKhqAU1ksm8OuGyL9AQIIfW7
         jxSqNMd9zB8F02sVt2iNjPA0W/MC+ce397iGEH7jaXsCr7yIaIyAdG5qRg7QSZM1pkLc
         PIFFRIFiq1VNsVlwFY+YLXRO0AiH4g9p9Hy0V1ZSbpg19rd2sod4f6U2w49DbWQIDvRz
         WPYg0/ZrafkpM1d1HGCpM8Jl574HMQsqT8ZFgoWoAAqN6iDWwMftKJ+pbtSSQ2lWQg6S
         9kGpBVsq2lgGhjnqC+20BTc3bBaItTkVYxH95rH44cFX4EbuQEBA7zHE/KC+EYCelBYA
         x+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=/HLruxGgGVWFncdsJK8Ic/uhD33pY74fCK6mndQ+k2E=;
        b=HtrYmEHTG130K2nKI38efcXYxpr8jtTvxmsmoigr/yDc0QtFbphtlK+ItOCw45cZh2
         Q6ZxZkB2w+3lJu3j1iFhVitnxS2yKG/8iqArrfMW9YZfRuUJiYSBjtpwinGvnZS0/eat
         rFxhSsbkrdsZ3FuimebUu5pZST3JeSfSGmN0+Xt360GH8dPvxRftyrr8s6qZtp9yh/+N
         XX+yTfpb7F+mv2jLmGmxPDf3LOg3Mx8dotALmTJfuuoaQR+5n9mmprAe2VE3F+noabNw
         2fR35n9VB92wSgdPOZy+YwaawzIrK3kQaC0NzB3NjPXmRzpgTAV7SGgGcjjBJoFn3x3d
         M8hQ==
X-Gm-Message-State: ACrzQf1ZBZoJKwZUvi38w6yp9mMoCcgBYS1zV0RRTl1GTE45ouiA385g
        rDVOqlest4XnJljlJoAkoFuSF+HtyXKAk3HW
X-Google-Smtp-Source: AMsMyM6xk3AaqFbnfAxaVppmHv2Jhiw0GLUhZm3dE+EW1cRugi1IlT5aYpmLUb8c2LSNZiZN27WFPg==
X-Received: by 2002:a5d:5a05:0:b0:22e:5b81:c295 with SMTP id bq5-20020a5d5a05000000b0022e5b81c295mr20118wrb.588.1664980543529;
        Wed, 05 Oct 2022 07:35:43 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id l19-20020a5d5273000000b00228dbf15072sm15508956wrc.62.2022.10.05.07.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 07:35:42 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 05 Oct 2022 14:35:36 +0000
Subject: [PATCH] dt-bindings: pinctrl: convert semtech,sx150xq bindings to
 dt-schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mdm9615-sx1509q-yaml-v1-0-0c26649b637c@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org,
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

This converts the Semtech SX150Xq bindings to dt-schemas, add necessary
bindings documentation to cover all differences between HW variants
and current bindings usage.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-gpio@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 .../devicetree/bindings/pinctrl/pinctrl-sx150x.txt |  72 -------
 .../bindings/pinctrl/semtech,sx1501q.yaml          | 207 +++++++++++++++++++++
 2 files changed, 207 insertions(+), 72 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-sx150x.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-sx150x.txt
deleted file mode 100644
index 4023bad2fe39..000000000000
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-sx150x.txt
+++ /dev/null
@@ -1,72 +0,0 @@
-SEMTECH SX150x GPIO expander bindings
-
-Please refer to pinctrl-bindings.txt, ../gpio/gpio.txt, and
-../interrupt-controller/interrupts.txt for generic information regarding
-pin controller, GPIO, and interrupt bindings.
-
-Required properties:
-- compatible: should be one of :
-			"semtech,sx1501q",
-			"semtech,sx1502q",
-			"semtech,sx1503q",
-			"semtech,sx1504q",
-			"semtech,sx1505q",
-			"semtech,sx1506q",
-			"semtech,sx1507q",
-			"semtech,sx1508q",
-			"semtech,sx1509q".
-
-- reg: The I2C slave address for this device.
-
-- #gpio-cells: Should be 2. The first cell is the GPIO number and the
-		second cell is used to specify optional parameters:
-		bit 0: polarity (0: normal, 1: inverted)
-
-- gpio-controller: Marks the device as a GPIO controller.
-
-Optional properties :
-- interrupts: Interrupt specifier for the controllers interrupt.
-
-- interrupt-controller: Marks the device as a interrupt controller.
-
-- semtech,probe-reset: Will trigger a reset of the GPIO expander on probe,
-		only for sx1507q, sx1508q and sx1509q
-
-The GPIO expander can optionally be used as an interrupt controller, in
-which case it uses the default two cell specifier.
-
-Required properties for pin configuration sub-nodes:
- - pins: List of pins to which the configuration applies.
-
-Optional properties for pin configuration sub-nodes:
-----------------------------------------------------
- - bias-disable: disable any pin bias, except the OSCIO pin
- - bias-pull-up: pull up the pin, except the OSCIO pin
- - bias-pull-down: pull down the pin, except the OSCIO pin
- - bias-pull-pin-default: use pin-default pull state, except the OSCIO pin
- - drive-push-pull: drive actively high and low
- - drive-open-drain: drive with open drain only for sx1507q, sx1508q and sx1509q and except the OSCIO pin
- - output-low: set the pin to output mode with low level
- - output-high: set the pin to output mode with high level
-
-Example:
-
-	i2c0gpio-expander@20{
-		#gpio-cells = <2>;
-		#interrupt-cells = <2>;
-		compatible = "semtech,sx1506q";
-		reg = <0x20>;
-		interrupt-parent = <&gpio_1>;
-		interrupts = <16 0>;
-
-		gpio-controller;
-		interrupt-controller;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&gpio1_cfg_pins>;
-
-		gpio1_cfg_pins: gpio1-cfg {
-			pins = "gpio1";
-			bias-pull-up;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/pinctrl/semtech,sx1501q.yaml b/Documentation/devicetree/bindings/pinctrl/semtech,sx1501q.yaml
new file mode 100644
index 000000000000..5c21f54b0e2b
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/semtech,sx1501q.yaml
@@ -0,0 +1,207 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2022 Linaro Ltd.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/semtech,sx1501q.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Semtech SX150x GPIO expander
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+properties:
+  compatible:
+    enum:
+      - semtech,sx1501q
+      - semtech,sx1502q
+      - semtech,sx1503q
+      - semtech,sx1504q
+      - semtech,sx1505q
+      - semtech,sx1506q
+      - semtech,sx1507q
+      - semtech,sx1508q
+      - semtech,sx1509q
+
+  reg: true
+
+  interrupts:
+    maxItems: 1
+
+  '#interrupt-cells':
+    const: 2
+
+  interrupt-controller: true
+
+  '#gpio-cells':
+    const: 2
+
+  gpio-controller: true
+
+  semtech,probe-reset:
+    description: Will trigger a reset of the GPIO expander on probe
+    type: boolean
+
+patternProperties:
+  '-cfg$':
+    type: object
+    properties:
+      pins: true
+
+      bias-disable: true
+      bias-pull-up: true
+      bias-pull-down: true
+      bias-pull-pin-default: true
+      drive-push-pull: true
+      output-low: true
+      output-high: true
+      drive-open-drain: true
+
+    required:
+      - pins
+
+    allOf:
+      - $ref: "pincfg-node.yaml#"
+      - $ref: "pinmux-node.yaml#"
+      - if:
+          properties:
+            pins:
+              contains:
+                const: "oscio"
+        then:
+          properties:
+            bias-disable: false
+            bias-pull-up: false
+            bias-pull-down: false
+            bias-pull-pin-default: false
+            drive-open-drain: false
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - '#gpio-cells'
+  - gpio-controller
+
+allOf:
+  - $ref: "pinctrl.yaml#"
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - semtech,sx1507q
+                - semtech,sx1508q
+                - semtech,sx1509q
+    then:
+      properties:
+        semtech,probe-reset: false
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - semtech,sx1501q
+              - semtech,sx1504q
+    then:
+      patternProperties:
+        '-cfg$':
+          properties:
+            pins:
+              items:
+                pattern: '^gpio[0-3]$'
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - semtech,sx1502q
+              - semtech,sx1505q
+    then:
+      patternProperties:
+        '-cfg$':
+          properties:
+            pins:
+              items:
+                pattern: '^gpio[0-7]$'
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - semtech,sx1503q
+              - semtech,sx1506q
+    then:
+      patternProperties:
+        '-cfg$':
+          properties:
+            pins:
+              items:
+                pattern: '^gpio[0-15]$'
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: semtech,sx1507q
+    then:
+      patternProperties:
+        '-cfg$':
+          properties:
+            pins:
+              items:
+                pattern: '^(oscio|gpio[0-3])$'
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: semtech,sx1508q
+    then:
+      patternProperties:
+        '-cfg$':
+          properties:
+            pins:
+              items:
+                pattern: '^(oscio|gpio[0-7])$'
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: semtech,sx1509q
+    then:
+      patternProperties:
+        '-cfg$':
+          properties:
+            pins:
+              items:
+                pattern: '^(oscio|gpio[0-15])$'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c@1000 {
+        reg = <0x1000 0x80>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pinctrl@20 {
+            compatible = "semtech,sx1501q";
+            reg = <0x20>;
+
+            #gpio-cells = <2>;
+            #interrupt-cells = <2>;
+
+            interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
+
+            gpio-controller;
+            interrupt-controller;
+
+            gpio1-cfg {
+                  pins = "gpio1";
+                  bias-pull-up;
+            };
+        };
+    };

---
base-commit: 4fe89d07dcc2804c8b562f6c7896a45643d34b2f
change-id: 20221005-mdm9615-sx1509q-yaml-7cfabf896fff

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
