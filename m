Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D0F5B54DD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 08:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiILG5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 02:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiILG5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 02:57:15 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF08F1C11E;
        Sun, 11 Sep 2022 23:57:14 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id u22so7673423plq.12;
        Sun, 11 Sep 2022 23:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=WdPMA2pH0mS9gX0lH3J9f/5y/00ONBhVpJZxWxuBUaU=;
        b=lJxEXq+Wmjwgm8aMmXgcGNBKUbXJmsjxZVvVK1JJtCawBesCNpiiPeTPdL9/9yYzwk
         QU7vDvZnCHyq5sfG8dpX/Htvs9FbtfBcfAcdAtMj35m7OEMhbdlGLW+ElI5V3TkTCfKo
         0k+9hu1CUsB1YdGeb440n26SS80bLNwFJTFcJz30b6rpnJmgr79E9UJs4cP1jWCoPBci
         gnVKe0DuqGfe6HoxS1AT+cXpRHjBvkue2XfZgvezdPg37CiLbh4MAUbsizyafM5rCJri
         kMFSAXmVJ8eAZ8S7DzZ4XG49VPSEBG6pUEpobXgoq3Z8hCvYEJoiiksWS0Bzw5C8gfDT
         vsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=WdPMA2pH0mS9gX0lH3J9f/5y/00ONBhVpJZxWxuBUaU=;
        b=DUhw6pAXoqmFctyLS9AZlIDiMJclZRrXkCyO/x7dnU8wlRi0qbrGKfnmTvwFkS9LjY
         W8n2F5Kou5Q6EQyInWEkx9xGofScZHoOrFw9A9g733Im/W+rUjBz95dSH2MzhBLBq59R
         Cvr6RmRVpodK/lNq1pUGg1lSG426fts2iyGp6lv8JLZs22w61PhxxEfMECOs9tEJTBow
         E9CJW7j09P/O8EPtN8ODo7x4XwyiGZPiT7MJSImYsaUBjacEDpqXK4LZpVqnagNohz56
         V2YVWKGkbkbEFt+ANgZr0vJxGTUnJvSjV8/NrCpQhGXbw+3k6lP05BMk2u1TWX23ZGVM
         nz/Q==
X-Gm-Message-State: ACgBeo298Oog8vGP7yo72lGYva99xPsM3TrUZxauTci+67RlLWrHQZTv
        M0yW41CocKCgjBfG9m06ib1BeZ6m57k=
X-Google-Smtp-Source: AA6agR4twqGzyhV34KDF8zi+LdZOntqxEWpKLhK7jhmFjZs8laEop16lW42X1A0u3epS5G0yvWmtgQ==
X-Received: by 2002:a17:902:a70e:b0:172:c859:dcc1 with SMTP id w14-20020a170902a70e00b00172c859dcc1mr25942319plq.121.1662965834110;
        Sun, 11 Sep 2022 23:57:14 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:569:7171:597e:5b7:9ff9:1cd5])
        by smtp.gmail.com with ESMTPSA id l12-20020a170903244c00b001743be790b4sm5044611pls.215.2022.09.11.23.57.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Sep 2022 23:57:13 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sre@kernel.org
Cc:     mazziesaccount@gmail.com, alina_yu@richtek.com,
        cy_huang@richtek.com, alinayu829@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v4 1/3] dt-bindings: power: supply: Add Richtek RT9471 battery charger
Date:   Mon, 12 Sep 2022 14:57:01 +0800
Message-Id: <1662965823-17760-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1662965823-17760-1-git-send-email-u0084500@gmail.com>
References: <1662965823-17760-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add bindings for the Richtek RT9471 I2C controlled battery charger.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Co-developed-by: Alina Yu <alina_yu@richtek.com>
Signed-off-by: Alina Yu <alina_yu@richtek.com>
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
Since v3
- Move unevaluatedProperties line after $ref for binding patch.
- Add Reviewed-by tag for binding patch.

Since v2
- Remove the properties for interrupt controller things in the binding documentation.
- Fix dtc error for typo, it's 'regulator-name', not 'regulator-compatible'.
- Add regulator min/max microamp to allow otg vbus current adjustable in example.
- Specify the active-level for charge-enable-gpios in binding example.

---
 .../bindings/power/supply/richtek,rt9471.yaml      | 73 ++++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9471.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt9471.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt9471.yaml
new file mode 100644
index 00000000..fbb54cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/richtek,rt9471.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/richtek,rt9471.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT9471 3A Single Cell Switching Battery charger
+
+maintainers:
+  - Alina Yu <alina_yu@richtek.com>
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  RT9471 is a switch-mode single cell Li-Ion/Li-Polymer battery charger for
+  portable applications. It supports USB BC1.2 port detection, current and
+  voltage regulations in both charging and boost mode.
+
+  Datasheet is available at
+  https://www.richtek.com/assets/product_file/RT9471=RT9471D/DS9471D-02.pdf
+
+properties:
+  compatible:
+    const: richtek,rt9471
+
+  reg:
+    maxItems: 1
+
+  charge-enable-gpios:
+    description: GPIO used to turn on and off charging.
+    maxItems: 1
+
+  wakeup-source: true
+
+  interrupts:
+    maxItems: 1
+
+  usb-otg-vbus-regulator:
+    type: object
+    $ref: /schemas/regulator/regulator.yaml#
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - wakeup-source
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      charger@53 {
+        compatible = "richtek,rt9471";
+        reg = <0x53>;
+        charge-enable-gpios = <&gpio26 1 GPIO_ACTIVE_LOW>;
+        wakeup-source;
+        interrupts-extended = <&gpio_intc 32 IRQ_TYPE_EDGE_FALLING>;
+
+        usb-otg-vbus-regulator {
+          regulator-name = "usb-otg-vbus";
+          regulator-min-microvolt = <4850000>;
+          regulator-max-microvolt = <5300000>;
+          regulator-min-microamp = <500000>;
+          regulator-max-microamp = <1200000>;
+        };
+      };
+    };
-- 
2.7.4

