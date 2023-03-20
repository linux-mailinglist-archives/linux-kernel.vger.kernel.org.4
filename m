Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115256C25DE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 00:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjCTXmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 19:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjCTXmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:42:24 -0400
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC73937B4C;
        Mon, 20 Mar 2023 16:41:28 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id a23-20020a4ad5d7000000b005250867d3d9so2192396oot.10;
        Mon, 20 Mar 2023 16:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679355574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QbrxJ0fwPhPLKh98WJtIL8glo9hyZk6OP6hoto5Dg3E=;
        b=amXeBOz/FJMkUUoPQR76R/ESdA5zxevdJPGwQR6o42GVN0hGnt7cGkKoZjgZUkkPXO
         tUQEmgNUv1TahUbaYielfmQTbJOe2UgfMGDF1nFG8ka+iCYJwzQ1zPtMLwowb/Uzo8P9
         hBgn3Y3UkF7CELjopvykn2z7G1j37gHZ2quwrxmHQ0cGljWAKk1C99qcE8tkdQzn6BeI
         qNl3WxPzNloeK6mje1Goi4hKMsKjERHtGJZQu0DpddXnJVkF8YQ78yqIF0ughgiaV+N4
         R/weF8/mE1mG6Kfjqq1kocUzTyfc7nUJCFWFj9bbOlMktbctADSjII9VG/In+gs11l/j
         a8qg==
X-Gm-Message-State: AO0yUKX9SubSZM5H0KdxUa74zF9XGoKh+duXKUPYChj1rdZqPBS/5c5S
        PQjXxFW3PAsk/SNxcmkFfQ==
X-Google-Smtp-Source: AK7set+VY226nc37Mz5PtD72QjJb4B/DciJqhSrxo7tuaqvkbUo3OFvcwJIaV3bzvjJaDPD+3QpqnQ==
X-Received: by 2002:a4a:490e:0:b0:53b:5510:958d with SMTP id z14-20020a4a490e000000b0053b5510958dmr105786ooa.0.1679355574641;
        Mon, 20 Mar 2023 16:39:34 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v11-20020a4aaecb000000b0053732f1acd2sm4428977oon.5.2023.03.20.16.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 16:39:33 -0700 (PDT)
Received: (nullmailer pid 2920813 invoked by uid 1000);
        Mon, 20 Mar 2023 23:39:32 -0000
From:   Rob Herring <robh@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-riscv@lists.infradead.org
Subject: [PATCH] dt-bindings: interrupt-controller: Drop unneeded quotes
Date:   Mon, 20 Mar 2023 18:39:27 -0500
Message-Id: <20230320233928.2920693-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/interrupt-controller/actions,owl-sirq.yaml   | 4 ++--
 .../bindings/interrupt-controller/fsl,irqsteer.yaml       | 4 ++--
 .../interrupt-controller/intel,ce4100-ioapic.yaml         | 4 ++--
 .../bindings/interrupt-controller/intel,ce4100-lapic.yaml | 4 ++--
 .../interrupt-controller/intel,ixp4xx-interrupt.yaml      | 4 ++--
 .../bindings/interrupt-controller/loongson,htpic.yaml     | 4 ++--
 .../bindings/interrupt-controller/loongson,htvec.yaml     | 4 ++--
 .../bindings/interrupt-controller/loongson,liointc.yaml   | 8 ++++----
 .../bindings/interrupt-controller/loongson,pch-msi.yaml   | 8 ++++----
 .../bindings/interrupt-controller/loongson,pch-pic.yaml   | 6 +++---
 .../bindings/interrupt-controller/mrvl,intc.yaml          | 4 ++--
 .../interrupt-controller/mscc,ocelot-icpu-intr.yaml       | 4 ++--
 .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml  | 2 +-
 13 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
index 5da333c644c9..27756d0c5419 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
@@ -32,7 +32,7 @@ properties:
       The first cell is the input IRQ number, between 0 and 2, while the second
       cell is the trigger type as defined in interrupt.txt in this directory.
 
-  'interrupts':
+  interrupts:
     description: |
       Contains the GIC SPI IRQs mapped to the external interrupt lines.
       They shall be specified sequentially from output 0 to 2.
@@ -44,7 +44,7 @@ required:
   - reg
   - interrupt-controller
   - '#interrupt-cells'
-  - 'interrupts'
+  - interrupts
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
index bcb5e20fa9ca..20ad4ad82ad6 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
@@ -48,13 +48,13 @@ properties:
     const: 1
 
   fsl,channel:
-    $ref: '/schemas/types.yaml#/definitions/uint32'
+    $ref: /schemas/types.yaml#/definitions/uint32
     description: |
       u32 value representing the output channel that all input IRQs should be
       steered into.
 
   fsl,num-irqs:
-    $ref: '/schemas/types.yaml#/definitions/uint32'
+    $ref: /schemas/types.yaml#/definitions/uint32
     description: |
       u32 value representing the number of input interrupts of this channel,
       should be multiple of 32 input interrupts and up to 512 interrupts.
diff --git a/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-ioapic.yaml b/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-ioapic.yaml
index 39ab8cdd19b4..a3ac818f067d 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-ioapic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-ioapic.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/interrupt-controller/intel,ce4100-ioapic.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/interrupt-controller/intel,ce4100-ioapic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Intel I/O Advanced Programmable Interrupt Controller (IO APIC)
 
diff --git a/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-lapic.yaml b/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-lapic.yaml
index d2d0145cb889..6b20a5fa8590 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-lapic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-lapic.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/interrupt-controller/intel,ce4100-lapic.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/interrupt-controller/intel,ce4100-lapic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Intel Local Advanced Programmable Interrupt Controller (LAPIC)
 
diff --git a/Documentation/devicetree/bindings/interrupt-controller/intel,ixp4xx-interrupt.yaml b/Documentation/devicetree/bindings/interrupt-controller/intel,ixp4xx-interrupt.yaml
index 14dced11877b..a02a6b5af205 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/intel,ixp4xx-interrupt.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/intel,ixp4xx-interrupt.yaml
@@ -2,8 +2,8 @@
 # Copyright 2018 Linaro Ltd.
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/interrupt-controller/intel,ixp4xx-interrupt.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/interrupt-controller/intel,ixp4xx-interrupt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Intel IXP4xx XScale Networking Processors Interrupt Controller
 
diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,htpic.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,htpic.yaml
index d6bc1a687fc7..f0acd5671bb1 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/loongson,htpic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,htpic.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/interrupt-controller/loongson,htpic.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/interrupt-controller/loongson,htpic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Loongson-3 HyperTransport Interrupt Controller
 
diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,htvec.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,htvec.yaml
index 87a74558204f..1d145763908e 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/loongson,htvec.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,htvec.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/interrupt-controller/loongson,htvec.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/interrupt-controller/loongson,htvec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Loongson-3 HyperTransport Interrupt Vector Controller
 
diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
index 750cc44628e9..00b570c82903 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/interrupt-controller/loongson,liointc.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/interrupt-controller/loongson,liointc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Loongson Local I/O Interrupt Controller
 
@@ -54,7 +54,7 @@ properties:
   '#interrupt-cells':
     const: 2
 
-  'loongson,parent_int_map':
+  loongson,parent_int_map:
     description: |
       This property points how the children interrupts will be mapped into CPU
       interrupt lines. Each cell refers to a parent interrupt line from 0 to 3
@@ -71,7 +71,7 @@ required:
   - interrupts
   - interrupt-controller
   - '#interrupt-cells'
-  - 'loongson,parent_int_map'
+  - loongson,parent_int_map
 
 
 unevaluatedProperties: false
diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,pch-msi.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,pch-msi.yaml
index 31e6bfbc3fd3..a71fc2218ede 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/loongson,pch-msi.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,pch-msi.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/interrupt-controller/loongson,pch-msi.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/interrupt-controller/loongson,pch-msi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Loongson PCH MSI Controller
 
@@ -25,7 +25,7 @@ properties:
     description:
       u32 value of the base of parent HyperTransport vector allocated
       to PCH MSI.
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
     maximum: 255
 
@@ -33,7 +33,7 @@ properties:
     description:
       u32 value of the number of parent HyperTransport vectors allocated
       to PCH MSI.
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 1
     maximum: 256
 
diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,pch-pic.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,pch-pic.yaml
index fdd6a38a31db..b7bc5cb1dff2 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/loongson,pch-pic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,pch-pic.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/interrupt-controller/loongson,pch-pic.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/interrupt-controller/loongson,pch-pic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Loongson PCH PIC Controller
 
@@ -25,7 +25,7 @@ properties:
     description:
       u32 value of the base of parent HyperTransport vector allocated
       to PCH PIC.
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
     maximum: 192
 
diff --git a/Documentation/devicetree/bindings/interrupt-controller/mrvl,intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/mrvl,intc.yaml
index 9acc21028413..b7c5022eec84 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/mrvl,intc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/mrvl,intc.yaml
@@ -53,8 +53,8 @@ allOf:
           maxItems: 1
         reg-names:
           items:
-            - const: 'mux status'
-            - const: 'mux mask'
+            - const: mux status
+            - const: mux mask
       required:
         - interrupts
     else:
diff --git a/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.yaml b/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.yaml
index 27b798bfe29b..4ff609faba32 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/interrupt-controller/mscc,ocelot-icpu-intr.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/interrupt-controller/mscc,ocelot-icpu-intr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Microsemi Ocelot SoC ICPU Interrupt Controller
 
diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 63bc89e13480..b089e62f90aa 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -90,7 +90,7 @@ properties:
       riscv,cpu-intc node, which has a riscv node as parent.
 
   riscv,ndev:
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
     description:
       Specifies how many external interrupts are supported by this controller.
 
-- 
2.39.2

