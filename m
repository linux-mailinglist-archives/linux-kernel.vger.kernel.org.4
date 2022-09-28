Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B5D5ED8F8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 11:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbiI1JaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 05:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbiI1J35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 05:29:57 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343012558F;
        Wed, 28 Sep 2022 02:29:55 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id v1so11292354plo.9;
        Wed, 28 Sep 2022 02:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=DRyGKGjmx6/87dwv7fQUEtlvvNihtjjN7QSKtIzTRUU=;
        b=d6A6RyklC7FeucSGAdtmEN2TAcO1jGzUlj3kW7S5UqlfZW6cD70lmggzuM8O8Ui+Kf
         0oBByuhkuvtDmTH3PNj/kqLmyzdpjY6XGPubS2uHuLs15HsRXPFSlsHAM5HmhLUkEhwH
         MgPMarprnwx1ejU4tXmnCpaLKUE/P73SorSvuSxTdxg4qmDzVdNFWJY+C6SrHYKbUWMi
         0dXgq+sbq00F7K0NHpv4BSnSTfvtIiJiM4sZ5AvN/Te5hz2iWX8rJ2iQUgXUM9sBL2cx
         oU4e0eoMZ/D79tDSSMOYrG0FxKEXK304HIpW9t5N3zJGkB8OwTHEx3vx+ym4aQN3Pb3+
         xKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=DRyGKGjmx6/87dwv7fQUEtlvvNihtjjN7QSKtIzTRUU=;
        b=cx0Q3+M5G7WaWXOkDgss3vO5aecyi56kSLcZS6Npu+CqANVlnDL+VamHLYBMZPefOM
         fWPlwyFQK7+JZFcd/FZCV8vYw4QoKpdnYKOccJ6GDjqYgEmR0IgXgqDECj8nc4cfwzzV
         d78LRC0HdJG+jG/EiGeMaTqpTkYFpZvYHHYeukFlyhZe5SlRFirW5aGOxZUSeUmq4/03
         lAorgUfUkMxeXm3lDDsuoxpLAenp43HLuSCIE9BlejGc1/sVWoUWc5eMqg2YE9yGRT92
         fkNbT1oto5ij8hyt6vx0M5OCHEuhzt1v5a6mANGXhek3f6TsDY6/+nIBv6usBDSHgqTz
         qJkA==
X-Gm-Message-State: ACrzQf3WpkCXkZWK5E2V5mN3DNPwSSd2hV0NuIkyzRHEUlBXNUMFyWAa
        0Jlu+RiHbI4BKhipYVmS3Yg=
X-Google-Smtp-Source: AMsMyM4CHp5WD84Jvj+v/gEQcs1hVM2ThRmu7xaBx4kjtiYAcKlkmGGE6iiPdsS5PxfjuZDfkHkXCw==
X-Received: by 2002:a17:90a:7642:b0:200:4a5e:1227 with SMTP id s2-20020a17090a764200b002004a5e1227mr9328457pjl.91.1664357394135;
        Wed, 28 Sep 2022 02:29:54 -0700 (PDT)
Received: from xm06403pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id b22-20020a17090a101600b0020071acaecasm1026831pja.42.2022.09.28.02.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 02:29:53 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] dt-bindings: gpio: Conver Unisoc EIC controller binding to yaml
Date:   Wed, 28 Sep 2022 17:29:36 +0800
Message-Id: <20220928092937.27120-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220928092937.27120-1-zhang.lyra@gmail.com>
References: <20220928092937.27120-1-zhang.lyra@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Convert the Unisoc EIC controller binding to DT schema format.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 .../bindings/gpio/gpio-eic-sprd.txt           |  97 ------------
 .../bindings/gpio/sprd,gpio-eic.yaml          | 145 ++++++++++++++++++
 2 files changed, 145 insertions(+), 97 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/sprd,gpio-eic.yaml

diff --git a/Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt b/Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt
deleted file mode 100644
index 54040a2bfe3a..000000000000
--- a/Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt
+++ /dev/null
@@ -1,97 +0,0 @@
-Spreadtrum EIC controller bindings
-
-The EIC is the abbreviation of external interrupt controller, which can
-be used only in input mode. The Spreadtrum platform has 2 EIC controllers,
-one is in digital chip, and another one is in PMIC. The digital chip EIC
-controller contains 4 sub-modules: EIC-debounce, EIC-latch, EIC-async and
-EIC-sync. But the PMIC EIC controller contains only one EIC-debounce sub-
-module.
-
-The EIC-debounce sub-module provides up to 8 source input signal
-connections. A debounce mechanism is used to capture the input signals'
-stable status (millisecond resolution) and a single-trigger mechanism
-is introduced into this sub-module to enhance the input event detection
-reliability. In addition, this sub-module's clock can be shut off
-automatically to reduce power dissipation. Moreover the debounce range
-is from 1ms to 4s with a step size of 1ms. The input signal will be
-ignored if it is asserted for less than 1 ms.
-
-The EIC-latch sub-module is used to latch some special power down signals
-and generate interrupts, since the EIC-latch does not depend on the APB
-clock to capture signals.
-
-The EIC-async sub-module uses a 32kHz clock to capture the short signals
-(microsecond resolution) to generate interrupts by level or edge trigger.
-
-The EIC-sync is similar with GPIO's input function, which is a synchronized
-signal input register. It can generate interrupts by level or edge trigger
-when detecting input signals.
-
-Required properties:
-- compatible: Should be one of the following:
-  "sprd,sc9860-eic-debounce",
-  "sprd,sc9860-eic-latch",
-  "sprd,sc9860-eic-async",
-  "sprd,sc9860-eic-sync",
-  "sprd,sc2731-eic".
-- reg: Define the base and range of the I/O address space containing
-  the GPIO controller registers.
-- gpio-controller: Marks the device node as a GPIO controller.
-- #gpio-cells: Should be <2>. The first cell is the gpio number and
-  the second cell is used to specify optional parameters.
-- interrupt-controller: Marks the device node as an interrupt controller.
-- #interrupt-cells: Should be <2>. Specifies the number of cells needed
-  to encode interrupt source.
-- interrupts: Should be the port interrupt shared by all the gpios.
-
-Example:
-	eic_debounce: gpio@40210000 {
-		compatible = "sprd,sc9860-eic-debounce";
-		reg = <0 0x40210000 0 0x80>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
-	};
-
-	eic_latch: gpio@40210080 {
-		compatible = "sprd,sc9860-eic-latch";
-		reg = <0 0x40210080 0 0x20>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
-	};
-
-	eic_async: gpio@402100a0 {
-		compatible = "sprd,sc9860-eic-async";
-		reg = <0 0x402100a0 0 0x20>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
-	};
-
-	eic_sync: gpio@402100c0 {
-		compatible = "sprd,sc9860-eic-sync";
-		reg = <0 0x402100c0 0 0x20>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
-	};
-
-	pmic_eic: gpio@300 {
-		compatible = "sprd,sc2731-eic";
-		reg = <0x300>;
-		interrupt-parent = <&sc2731_pmic>;
-		interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-	};
diff --git a/Documentation/devicetree/bindings/gpio/sprd,gpio-eic.yaml b/Documentation/devicetree/bindings/gpio/sprd,gpio-eic.yaml
new file mode 100644
index 000000000000..e25ee1884c07
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/sprd,gpio-eic.yaml
@@ -0,0 +1,145 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2022 Unisoc Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/sprd,gpio-eic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Unisoc EIC controller
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+description:
+  The EIC is the abbreviation of external interrupt controller, which can
+  be used only in input mode. The Spreadtrum platform has 2 EIC controllers,
+  one is in digital chip, and another one is in PMIC. The digital chip EIC
+  controller contains 4 sub-modules, i.e. EIC-debounce, EIC-latch, EIC-async and
+  EIC-sync. But the PMIC EIC controller contains only one EIC-debounce sub-
+  module.
+
+  The EIC-debounce sub-module provides up to 8 source input signal
+  connections. A debounce mechanism is used to capture the input signals'
+  stable status (millisecond resolution) and a single-trigger mechanism
+  is introduced into this sub-module to enhance the input event detection
+  reliability. In addition, this sub-module's clock can be shut off
+  automatically to reduce power dissipation. Moreover the debounce range
+  is from 1ms to 4s with a step size of 1ms. The input signal will be
+  ignored if it is asserted for less than 1 ms.
+
+  The EIC-latch sub-module is used to latch some special power down signals
+  and generate interrupts, since the EIC-latch does not depend on the APB
+  clock to capture signals.
+
+  The EIC-async sub-module uses a 32kHz clock to capture the short signals
+  (microsecond resolution) to generate interrupts by level or edge trigger.
+
+  The EIC-sync is similar with GPIO's input function, which is a synchronized
+  signal input register. It can generate interrupts by level or edge trigger
+  when detecting input signals.
+
+properties:
+  compatible:
+    enum:
+      - sprd,sc9860-eic-debounce
+      - sprd,sc9860-eic-latch
+      - sprd,sc9860-eic-async
+      - sprd,sc9860-eic-sync
+      - sprd,sc2731-eic
+
+  reg:
+    minItems: 1
+    maxItems: 4
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+  interrupts:
+    maxItems: 1
+    description: The interrupt shared by all GPIO lines for this controller.
+
+required:
+  - compatible
+  - reg
+  - gpio-controller
+  - "#gpio-cells"
+  - interrupt-controller
+  - "#interrupt-cells"
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        eic_debounce: gpio@40210000 {
+            compatible = "sprd,sc9860-eic-debounce";
+            reg = <0 0x40210000 0 0x80>;
+            gpio-controller;
+            #gpio-cells = <2>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
+            interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+        };
+
+        eic_latch: gpio@40210080 {
+            compatible = "sprd,sc9860-eic-latch";
+            reg = <0 0x40210080 0 0x20>;
+            gpio-controller;
+            #gpio-cells = <2>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
+            interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+        };
+
+        eic_async: gpio@402100a0 {
+            compatible = "sprd,sc9860-eic-async";
+            reg = <0 0x402100a0 0 0x20>;
+            gpio-controller;
+            #gpio-cells = <2>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
+            interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+        };
+
+        eic_sync: gpio@402100c0 {
+            compatible = "sprd,sc9860-eic-sync";
+            reg = <0 0x402100c0 0 0x20>;
+            gpio-controller;
+            #gpio-cells = <2>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
+            interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
+
+    sc2730_pmic {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic_eic: gpio@300 {
+            compatible = "sprd,sc2731-eic";
+            reg = <0x300>;
+            interrupt-parent = <&sc2731_pmic>;
+            interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
+            gpio-controller;
+            #gpio-cells = <2>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
+        };
+    };
+...
-- 
2.25.1

