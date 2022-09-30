Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B625F0657
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 10:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiI3IY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 04:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiI3IYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 04:24:22 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CD410D676;
        Fri, 30 Sep 2022 01:24:21 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id b5so3574281pgb.6;
        Fri, 30 Sep 2022 01:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=tJu5+3r8ivCyAS03HPqEIU5aJjM4gwmSBQgnIQ+4SPM=;
        b=fAJIiZqwcEJKoychhLUqwOatGSkUkSf1J1oYyJEiO2/5zOQ28qmETqM8xtzxk0k6DK
         QeAVuBg9ReogFNlT9xx1oylBF1O8LVwhBvmIzVqfXF3P5t1VYShZQlQpcKbhqBafCHMk
         YC7DpE6idAWbAw/j9goAjiYc4sFkbzGLMRgCPhvuncUA3mtHbe+IA8jc8ia1tm96ayFU
         qiBd4/GkxxvA3mw1D7sKswFI2d5AvIDJ3nOWcOvoHDTht9hBh3ox1SfK4aWesgFX5x1A
         //O6glbjhRgekIeQ3NOGlWE3P6firfVtmC03U3ZKDLD3tNAc598v3cYpwJy8Pfg+G37v
         gOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=tJu5+3r8ivCyAS03HPqEIU5aJjM4gwmSBQgnIQ+4SPM=;
        b=05+Zpvc3gkxk024Ju0upaeCzXVeyJM2KjpseTuEI84mur3MxhA0/4Yhd63P1JL1ETd
         IsUeOA+g+Fxk2LNDua0xL+fna3TX+N0Xnc2CGnrybDiUpVPlU5HV/f9Tr8LGJel2oq05
         v63U2+FmxyGuKhj46jUn/sklvkCysCsiCs8kQEYiQoTBMcljWlIw65orMiO4wZ/yP+LC
         OiWpzvovwV2tAG5vHJ+Eb20HBHs0J2nLnFTKk45DDi/b9TAFRed+D1JHgxlTxwlUEIuZ
         GWG6nNjS81iNiKjVoo87ziriIgKPAuI6dh1q0p5B3Jyq+4f6/GypPGe9xjBcFoByzCDx
         nnUQ==
X-Gm-Message-State: ACrzQf17sl5feYHnZ9R2gk3+L4alvSete9QF1hqoj27W3r227r/EHpyi
        Oz35NySzlZNsqjRF3xtWUZ0=
X-Google-Smtp-Source: AMsMyM5oNd0aUlUQ1DenOvqD6qCv/IK1WF/t0e9peAbCBx1Ro4BidSbo1VSwsid61WEsJd3VFA0faQ==
X-Received: by 2002:aa7:8704:0:b0:542:5288:5e32 with SMTP id b4-20020aa78704000000b0054252885e32mr7687116pfo.84.1664526260759;
        Fri, 30 Sep 2022 01:24:20 -0700 (PDT)
Received: from xm06403pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 63-20020a620442000000b00540d03f3792sm1132083pfe.81.2022.09.30.01.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 01:24:20 -0700 (PDT)
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
Subject: [PATCH V2 1/3] dt-bindings: gpio: Convert Unisoc GPIO controller binding to yaml
Date:   Fri, 30 Sep 2022 16:24:03 +0800
Message-Id: <20220930082405.1761-2-zhang.lyra@gmail.com>
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

Convert the Unisoc gpio controller binding to DT schema format.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 .../devicetree/bindings/gpio/gpio-sprd.txt    | 28 --------
 .../devicetree/bindings/gpio/sprd,gpio.yaml   | 70 +++++++++++++++++++
 2 files changed, 70 insertions(+), 28 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-sprd.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/sprd,gpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/gpio-sprd.txt b/Documentation/devicetree/bindings/gpio/gpio-sprd.txt
deleted file mode 100644
index eca97d45388f..000000000000
--- a/Documentation/devicetree/bindings/gpio/gpio-sprd.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-Spreadtrum GPIO controller bindings
-
-The controller's registers are organized as sets of sixteen 16-bit
-registers with each set controlling a bank of up to 16 pins. A single
-interrupt is shared for all of the banks handled by the controller.
-
-Required properties:
-- compatible: Should be "sprd,sc9860-gpio".
-- reg: Define the base and range of the I/O address space containing
-the GPIO controller registers.
-- gpio-controller: Marks the device node as a GPIO controller.
-- #gpio-cells: Should be <2>. The first cell is the gpio number and
-the second cell is used to specify optional parameters.
-- interrupt-controller: Marks the device node as an interrupt controller.
-- #interrupt-cells: Should be <2>. Specifies the number of cells needed
-to encode interrupt source.
-- interrupts: Should be the port interrupt shared by all the gpios.
-
-Example:
-	ap_gpio: gpio@40280000 {
-		compatible = "sprd,sc9860-gpio";
-		reg = <0 0x40280000 0 0x1000>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
-	};
diff --git a/Documentation/devicetree/bindings/gpio/sprd,gpio.yaml b/Documentation/devicetree/bindings/gpio/sprd,gpio.yaml
new file mode 100644
index 000000000000..c0cd1ed9809b
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/sprd,gpio.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2022 Unisoc Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/sprd,gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Unisoc GPIO controller
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+description:
+  The controller's registers are organized as sets of sixteen 16-bit
+  registers with each set controlling a bank of up to 16 pins. A single
+  interrupt is shared for all of the banks handled by the controller.
+
+properties:
+  compatible:
+    const: sprd,sc9860-gpio
+
+  reg:
+    maxItems: 1
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
+        ap_gpio: gpio@40280000 {
+            compatible = "sprd,sc9860-gpio";
+            reg = <0 0x40280000 0 0x1000>;
+            gpio-controller;
+            #gpio-cells = <2>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
+            interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
+...
-- 
2.25.1

