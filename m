Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF46629544
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiKOKHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbiKOKG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:06:57 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5849E5F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:06:55 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id t4so9306764wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r6J2lsA0Wo197QAgdKxOXmtdQ23amoC9lDrXaGdR/FQ=;
        b=RXsBzvZsf7KCOSfh2YF3gb4x2ca7GWci0hQ80sX9RbhHT0CwRxVHX3aQ7JsEYsP4yJ
         U/xYGh3/K7RWX/Z4mMJ+P8hRuq9piViCBeOjdPvIrG00e24ltWTKqHjhdFyCT+h6rLXG
         fKrOM0rLMIUVZ1SbWNsBTIgFd3iWhwHGynymr64zu6Zn+QS1pV8R9VuKDQ05Bce/aOzj
         T8g5Aj1qx4lWXp75KkZSs8T50h6iNEXF8hA5NdjSIwy28GcOXsSeT6fkwCR1znmNI5cb
         ZISNz96aGCWleN8yu/LTUdO0tlUNSIdQ0SSulTXnI4KTrzIUzsQTVvZujhy5N2IBc2Qf
         oNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r6J2lsA0Wo197QAgdKxOXmtdQ23amoC9lDrXaGdR/FQ=;
        b=GCOIbaYRtjS1nQwQXqSGTn4q83NryBmk4nbKzuCruvne916bJgr9xcW+foOVlX4ZhQ
         EWX64c4Jf2rHRBBKN6Fr0ggwRhMkbpLzkzE6M2UpOxehbRHNsJwoeMRKPbwx+rH1VQU6
         t28M8dTab61shIfhk4IELljnY5ZbQu8+sk076INRGIbJNKcFMHe3q89aWNmmoWikMXv9
         i12UP8kMFlYQzmjvJPHC3J4eYYn9XWPXWsRowtPivX95jImm0bWYVlxGE6LPPSsQoJ2l
         +iZELwfBXlyHgTLEAc57jjs5lew1G4+omA+ptqX3ClJXriFo5XbDFOJaAACIAaA2iI6R
         pZ1A==
X-Gm-Message-State: ANoB5pmWOVU+60sPHZvrwrBPk+ywzaKw1dEyRTw2y4AIGOZxogKG89+k
        cpT53MhUWWLioE2OStVaYnDAiQ==
X-Google-Smtp-Source: AA0mqf60kkOnsL2coIZUUusLLQoO8xcZuEF7Ejs909LN8vxM5+59flaYZZSPiG41TJq6qWFXdwGk3w==
X-Received: by 2002:a05:600c:3b27:b0:3cf:6263:bfc5 with SMTP id m39-20020a05600c3b2700b003cf6263bfc5mr196888wms.137.1668506814125;
        Tue, 15 Nov 2022 02:06:54 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id o7-20020a05600c4fc700b003a6125562e1sm16199370wmq.46.2022.11.15.02.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 02:06:53 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 15 Nov 2022 11:06:47 +0100
Subject: [PATCH v3] dt-bindings: pinctrl: convert semtech,sx150xq bindings to
 dt-schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mdm9615-sx1509q-yaml-v3-0-e8b349eb1900@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        linux-gpio@vger.kernel.org
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

This converts the Semtech SX150Xq bindings to dt-schemas, add necessary
bindings documentation to cover all differences between HW variants
and current bindings usage.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
To: Linus Walleij <linus.walleij@linaro.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-gpio@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes in v3:
- Resent with missing To: Linus Walleij
- Link to v2: https://lore.kernel.org/r/20221005-mdm9615-sx1509q-yaml-v2-0-a4a5b8eecc7b@linaro.org

Changes in v2:
- fixed rob comments
- added rob's Reviewed-by
- Link to v1: https://lore.kernel.org/r/20221005-mdm9615-sx1509q-yaml-v1-0-0c26649b637c@linaro.org
---
 .../devicetree/bindings/pinctrl/pinctrl-sx150x.txt |  72 -------
 .../bindings/pinctrl/semtech,sx1501q.yaml          | 208 +++++++++++++++++++++
 2 files changed, 208 insertions(+), 72 deletions(-)

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
index 000000000000..df429a396ba3
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/semtech,sx1501q.yaml
@@ -0,0 +1,208 @@
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
+  reg:
+    maxItems: 1
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
+                const: oscio
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
