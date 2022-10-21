Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E136607FF8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiJUUlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiJUUkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:40:00 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011006A53E;
        Fri, 21 Oct 2022 13:39:59 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1364357a691so5012552fac.7;
        Fri, 21 Oct 2022 13:39:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K6Eb2ublFo6q3lOpf+Uk0fY6Rivd+7YhaiOS7t7JDm8=;
        b=iVjNQpXWed9P87E8LfpFnw3zeZsgcMb9UzJQ1zo9YhtaQxqRcgOmsm/jn+pWrcy+9O
         Q7Zncu4K6njV8JK4tER5cUCEuFLzB/P3rWdkifxrOKNasQ7MAJEjKkXFy4ekltkxrAav
         nfOZMUNBG7QIYnJaQHT4TRVF7bCuIayZBhJYcp8AzewcUVJTJngkvRS7zEljq18d+IPw
         erMCT6zqnjMaQdUKyj0kjT22ZX+C9gXY9ONbeQlpnGReefMHLfBu2T+GWbX9Y6+y+zWK
         /ZbSwCev6lYMoMBpKJK50+pvOAD+/ok4Wp9T+jXkbFzMkSHfA3pj+MK5SC1wrYQLohNv
         aoSQ==
X-Gm-Message-State: ACrzQf0qTL3ZV7SHS9VsjvDtsDDk2cXfrPxfLz6qIpGiYR5DKSPRKDc+
        9i3mgw8zzixTw7bCfxWB0sopIkYhyQ==
X-Google-Smtp-Source: AMsMyM52hn4D7jTJA3elk1Rszk4IlZK7yG47ZbVYBqkNcCQoOypZ5iwEPPxbiTwmrK5QJsRB/X4L9g==
X-Received: by 2002:a05:6870:6593:b0:13b:c1a:e8ac with SMTP id fp19-20020a056870659300b0013b0c1ae8acmr5689162oab.271.1666384798010;
        Fri, 21 Oct 2022 13:39:58 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s187-20020aca45c4000000b003436fa2c23bsm1546932oia.7.2022.10.21.13.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 13:39:57 -0700 (PDT)
Received: (nullmailer pid 286745 invoked by uid 1000);
        Fri, 21 Oct 2022 20:39:59 -0000
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: memory-controllers: arm,pl353-smc: Extend to support 'arm,pl354' SMC
Date:   Fri, 21 Oct 2022 15:39:28 -0500
Message-Id: <20221021203928.286169-1-robh@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Arm PL354 static memory controller to the existing
Arm PL353 binding. Both are different configurations of the same IP with
support for different types of memory interfaces.

The 'arm,pl354' binding has already been in use upstream for a long time
in Arm development boards. The existing users have only the controller
without any child devices, so drop the required address properties
(ranges, #address-cells, #size-cells). The schema for 'ranges' is too
constrained as the order is not important and the PL354 has 8
chipselects (And the PL353 actually has up to 8 too).

The clocks aren't really correct in either case. There's 1 bus clock and
then a clock for each of the 2 memory interfaces.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 ...{arm,pl353-smc.yaml => arm,pl35x-smc.yaml} | 80 ++++++++++++-------
 1 file changed, 53 insertions(+), 27 deletions(-)
 rename Documentation/devicetree/bindings/memory-controllers/{arm,pl353-smc.yaml => arm,pl35x-smc.yaml} (65%)

diff --git a/Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.yaml b/Documentation/devicetree/bindings/memory-controllers/arm,pl35x-smc.yaml
similarity index 65%
rename from Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.yaml
rename to Documentation/devicetree/bindings/memory-controllers/arm,pl35x-smc.yaml
index 01c9acf9275d..bd23257fe021 100644
--- a/Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/arm,pl35x-smc.yaml
@@ -1,26 +1,31 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/memory-controllers/arm,pl353-smc.yaml#
+$id: http://devicetree.org/schemas/memory-controllers/arm,pl35x-smc.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: ARM PL353 Static Memory Controller (SMC) device-tree bindings
+title: Arm PL35x Series Static Memory Controller (SMC)
 
 maintainers:
   - Miquel Raynal <miquel.raynal@bootlin.com>
   - Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
 
-description:
-  The PL353 Static Memory Controller is a bus where you can connect two kinds
+description: |
+  The PL35x Static Memory Controller is a bus where you can connect two kinds
   of memory interfaces, which are NAND and memory mapped interfaces (such as
-  SRAM or NOR).
+  SRAM or NOR) depending on the specific configuration.
+
+  The TRM is available here:
+  https://documentation-service.arm.com/static/5e8e2524fd977155116a58aa
 
 # We need a select here so we don't match all nodes with 'arm,primecell'
 select:
   properties:
     compatible:
       contains:
-        const: arm,pl353-smc-r2p1
+        enum:
+          - arm,pl353-smc-r2p1
+          - arm,pl354
   required:
     - compatible
 
@@ -30,7 +35,9 @@ properties:
 
   compatible:
     items:
-      - const: arm,pl353-smc-r2p1
+      - enum:
+          - arm,pl353-smc-r2p1
+          - arm,pl354
       - const: arm,primecell
 
   "#address-cells":
@@ -46,30 +53,25 @@ properties:
           The three chip select regions are defined in 'ranges'.
 
   clocks:
-    items:
-      - description: clock for the memory device bus
-      - description: main clock of the SMC
+    minItems: 1
+    maxItems: 2
 
   clock-names:
-    items:
-      - const: memclk
-      - const: apb_pclk
+    minItems: 1
+    maxItems: 2
 
   ranges:
     minItems: 1
-    description: |
-      Memory bus areas for interacting with the devices. Reflects
-      the memory layout with four integer values following:
-      <cs-number> 0 <offset> <size>
-    items:
-      - description: NAND bank 0
-      - description: NOR/SRAM bank 0
-      - description: NOR/SRAM bank 1
+    maxItems: 8
 
-  interrupts: true
+  interrupts:
+    minItems: 1
+    items:
+      - description: Combined or Memory interface 0 IRQ
+      - description: Memory interface 1 IRQ
 
 patternProperties:
-  "@[0-3],[a-f0-9]+$":
+  "@[0-7],[a-f0-9]+$":
     type: object
     description: |
       The child device node represents the controller connected to the SMC
@@ -87,7 +89,7 @@ patternProperties:
               - description: |
                   Chip-select ID, as in the parent range property.
                 minimum: 0
-                maximum: 2
+                maximum: 7
               - description: |
                   Offset of the memory region requested by the device.
               - description: |
@@ -102,12 +104,36 @@ required:
   - reg
   - clock-names
   - clocks
-  - "#address-cells"
-  - "#size-cells"
-  - ranges
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: arm,pl354
+    then:
+      properties:
+        clocks:
+          # According to TRM, really should be 3 clocks
+          maxItems: 1
+
+        clock-names:
+          const: apb_pclk
+
+    else:
+      properties:
+        clocks:
+          items:
+            - description: clock for the memory device bus
+            - description: main clock of the SMC
+
+        clock-names:
+          items:
+            - const: memclk
+            - const: apb_pclk
+
 examples:
   - |
     smcc: memory-controller@e000e000 {
-- 
2.35.1

