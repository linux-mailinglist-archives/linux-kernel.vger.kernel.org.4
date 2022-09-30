Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172DE5F07DF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiI3JpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbiI3JpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:45:15 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DE56B16D;
        Fri, 30 Sep 2022 02:45:04 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id j6-20020a17090a31c600b0020a07b184deso930149pjf.3;
        Fri, 30 Sep 2022 02:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=WdPMA2pH0mS9gX0lH3J9f/5y/00ONBhVpJZxWxuBUaU=;
        b=PJIrRJqNIjxt8p1As5voLLFtTXNXaHJMOrSqb1O3LKagobtN89waTC4p2iOXIbg3QM
         jlg8nH7ItCZsadrBHd6avfFUVv4VXGLPp2gXQmFrlsC8sVYv/XhIgl9whs1bUPPq3VAI
         hQ8fvVFgYlmCJu2fM5vbJcF15010O5b/08xP9T0XM9kw6B4R8tiWUBLRoooXMFJyhTWJ
         80N39UfjGDrIOaH6/lBrvPcMXz7B5B2s3s1y03CSaaZ2hqZSzeuJYKEQciIDkDKhzMrU
         /gl1jWlOZu7AZwaM2JX30nkc0Obh6TJgFWTjKOyamZgnntEDv0Ohu4sv/dKjx8G44OwT
         28CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=WdPMA2pH0mS9gX0lH3J9f/5y/00ONBhVpJZxWxuBUaU=;
        b=yfDwnJvz4ZsnPHZEaLASpgUf2b00nb4GPx/rCG4mtzaPB1rGdEZgmp8wZD+zC3+CUA
         OxNDW3oaaq50qXmYGXPvT1j4uMfxeYeFfl3nE4ijCFy41T1B79uMfyu64ZFpFuVILEqe
         2U0+vtF8iNSirHPCWinvKb/4FhaiKQHudmf5tFFx4yweP/sowf8UBUTma93ci3+iBeK9
         zrhxy6DhOST3+zawRd+Wqx+Qvhx76ywXTaZ+Xz87FzqGKlDq1UsP4bhhlUJnj77KEx2d
         mu7NMxJia3GpixlAIfHwevgX3/v90RVeo3q1GQVXaYh13d8ryIumnryoemdmM/qR+Wvk
         zsaQ==
X-Gm-Message-State: ACrzQf1Ox1yI8GI45xWNXsfsisX92mDx0V98TFOepGDyhuWqut/8a2+L
        YdTOO2Lq+a6/AH93irmYv3JZJOzqCGdOww==
X-Google-Smtp-Source: AMsMyM4lt6AuOeNY5CmTH3YJZ1qhDVT2SQD+EffMIuSpo55nUh5Ty4YP5knuQW2Qpvu0rKtfjJqFcA==
X-Received: by 2002:a17:90b:4a8a:b0:202:8eec:b87a with SMTP id lp10-20020a17090b4a8a00b002028eecb87amr21468614pjb.48.1664531103734;
        Fri, 30 Sep 2022 02:45:03 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:579:1b3a:4d22:d83a:1d4a:43f1])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902650700b0016dc78d0153sm1398051plk.296.2022.09.30.02.45.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Sep 2022 02:45:03 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sre@kernel.org
Cc:     mazziesaccount@gmail.com, alina_yu@richtek.com,
        cy_huang@richtek.com, alinayu829@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/3] dt-bindings: power: supply: Add Richtek RT9471 battery charger
Date:   Fri, 30 Sep 2022 17:44:37 +0800
Message-Id: <1664531079-15915-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1664531079-15915-1-git-send-email-u0084500@gmail.com>
References: <1664531079-15915-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

