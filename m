Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F165FD4E8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 08:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiJMGhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 02:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJMGhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 02:37:23 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73AF127BD6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 23:37:21 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id n12so1267422wrp.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 23:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oxbXLa/OkrAlq9sH7IAcKO/2VyaTjHyhzuKFWcjpua4=;
        b=LdA9EUFsCneYmrpA0WuTMuqDbpaiUbi6FXtzMqfcYH3HGxDQDtuMIqfx757QWPGXwm
         KEd+fzW6yw+PZGHR/FcnsgGKxzub4jpEVHkDiIZhHDXam8L3dRqM19s1t5vDOPxZ3kap
         hGa+snE/pGlPVRJ0nHzfgjo9LHh3IjIjtlm1kp8h2MzjpWN5G52K+33JP+SgdueN6WoZ
         aWhb2/FgFERkW/u480+5jgL2MNs/UFQxYBsW+zf8LWQvTZnbupE7SunbWzg1RB8b3sb2
         5/WO9aFMNgLYm0qx6eRaR9en29UeLHRFjhv/Ex4YIu7Pw+aK1dg85zQyuXweSb1PAgpd
         NeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oxbXLa/OkrAlq9sH7IAcKO/2VyaTjHyhzuKFWcjpua4=;
        b=PtfjvoDU+Wj3VeUzbEj3UVYSHsesGqAJ3filtal/acV133d1LVfTtWdUs/UhTyPx1O
         Ncb5oMhj0pknzUHqEbTpIHEXRM8KsEI9VW/kZfnm/GSA6w9HRMtfqaMqz1cR9jZpavJX
         ZO7CY3byQzsiiWFHwVpzrkRnZ0YjbF8fYc9tn4o4HkR7RRzjiL+XOv5T8yLHTKZFRDEX
         1iJWC1hb4rMAVOZrAAaNW8Je6gwiprGCkTzQOZRZOku4f7CH8+XTKxUb7Tpm0DsLz1Gk
         KVV/0xT4vZo460ol/Ir1ngQZUKNvBlKa3t7QGDUZRt58/y2+5+/dFBohTdrPeJJdqiHz
         ij8A==
X-Gm-Message-State: ACrzQf3GVmkbHLlf9ZatvoLIiiYhpufLhohuyCpgp/0gRAZTo1EbB1Sq
        2pTjWPIpMto8SZ16naopydpoJrJ49s6cOgs+
X-Google-Smtp-Source: AMsMyM4bIi23LgtF6kiFvLoX6o8AXvJvrNyGZ4ctGEIzwC4nGMXaHRO4U7pqRn4lUqpxnKUtwO0tPg==
X-Received: by 2002:adf:f850:0:b0:22e:7ae8:a38f with SMTP id d16-20020adff850000000b0022e7ae8a38fmr19774672wrq.68.1665643040266;
        Wed, 12 Oct 2022 23:37:20 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id g17-20020a05600c001100b003c6bbe910fdsm4244184wmc.9.2022.10.12.23.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 23:37:19 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 13 Oct 2022 08:37:15 +0200
Subject: [PATCH v2] dt-bindings: pinctrl: convert semtech,sx150xq bindings to
 dt-schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mdm9615-sx1509q-yaml-v2-0-a4a5b8eecc7b@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org
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
Reviewed-by: Rob Herring <robh@kernel.org>
---
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-gpio@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
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
