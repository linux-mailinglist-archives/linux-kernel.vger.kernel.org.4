Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6540C5F065B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 10:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiI3IYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 04:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiI3IY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 04:24:26 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457E9116C09;
        Fri, 30 Sep 2022 01:24:25 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id g1-20020a17090a708100b00203c1c66ae3so3599088pjk.2;
        Fri, 30 Sep 2022 01:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=iW2VGf7Q36OdUgb6flheeEmtoQs790VvyBEPObUvJEQ=;
        b=JW6Bs39NnMEPnMg27urBNayA4yvB03F6WzlrYQD5FhgLnnAZnPwrBUrfqpc6xEo84H
         T+m5UQacOlqHcVZIT3oUy8bnB80BwyPVa+YmSDpR1ttcUzSnHPU115YGhewkW+PKwUSk
         f5RHLPrLTvSgAUJi9OEymNQozer98Ni/ygMyx1gFs7hNccOOyS9s8uxrY1qHJ+OJANWh
         x+gM6bA3G8KWfHvGXdXuofrvQDJtG0hIKn/pEh9D/BB7LOLZqK3U+BzZ3UaLnhODsqF4
         +ARtFZviKapb6UKvT0vCrTyZnb25OqBR7IFirCWpAroENpWio1mpxnWh1PcuGecI9KYz
         QTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=iW2VGf7Q36OdUgb6flheeEmtoQs790VvyBEPObUvJEQ=;
        b=l19hotBG4GfQ5/o6JDEkb2yEbRU4cpb4q59hJUlmjjFnh7BjUqsztf+O6oyJureMza
         wARBVhE35RoIRnTGMzxiqNq78sN4d4RZuJ21yLg+PAl0vOpxE5OjFIAgs6cchEx4k0Bb
         0w5hlJiJv5Pcr/Dm6wQeu8hGc39t/EgtqpRsM4P7L4CZL/zNp85h/3aGIkkTzE8dnEKW
         ZNeWJwI4qMS8uW8HIsw9BCVNAzq1q1NaOg7IAGJNJwTrE8/eyboFUTxIo2xPBg5gAall
         mAEqTXySdglDzzG5IAPoswF1NHPyq8ehYUeUzUZNIT+RX2jgykMvGni0iBGMK/ORV0Ax
         /URw==
X-Gm-Message-State: ACrzQf34evcSOzSweXjjdp4vIJjBPCzdigAgKq5P+nkBuOvNdmRFJUeY
        HYSDkex6o1s/0LGs2iaiuFo=
X-Google-Smtp-Source: AMsMyM7xzM3gH7y1puQdkxiJ/a9YecziFnQ62SitOZwfCSZh6dEU0ISVgGSEmXzcZOD9SH5AdrKdgQ==
X-Received: by 2002:a17:902:ccc2:b0:178:29f9:5c5e with SMTP id z2-20020a170902ccc200b0017829f95c5emr7332089ple.21.1664526264665;
        Fri, 30 Sep 2022 01:24:24 -0700 (PDT)
Received: from xm06403pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 63-20020a620442000000b00540d03f3792sm1132083pfe.81.2022.09.30.01.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 01:24:24 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 2/3] dt-bindings: gpio: Convert Unisoc EIC controller binding to yaml
Date:   Fri, 30 Sep 2022 16:24:04 +0800
Message-Id: <20220930082405.1761-3-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220930082405.1761-1-zhang.lyra@gmail.com>
References: <20220930082405.1761-1-zhang.lyra@gmail.com>
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
Update the maxItems of 'reg' property, since the current gpio-eic-sprd
driver supports 3 reg items. Also remove three redundant examples.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 .../bindings/gpio/gpio-eic-sprd.txt           |  97 --------------
 .../bindings/gpio/sprd,gpio-eic.yaml          | 119 ++++++++++++++++++
 2 files changed, 119 insertions(+), 97 deletions(-)
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
index 000000000000..c288a8dd44c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/sprd,gpio-eic.yaml
@@ -0,0 +1,119 @@
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
+    maxItems: 3
+    description:
+      EIC controller can support maximum 3 banks which has its own
+      address base.
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
+    description:
+      The interrupt shared by all GPIO lines for this controller.
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

