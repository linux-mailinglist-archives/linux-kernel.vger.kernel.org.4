Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E466660A0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 17:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238311AbjAKQfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 11:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235423AbjAKQeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:34:36 -0500
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A4B8FC6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 08:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1673454851; x=1676046851;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DIVSltv1EoxJ/HckyzieslouUpu2jYUZiLJc7CfcCaE=;
        b=GhEs4vp8Uz3g3xY3kL8CQoszNpr1KORB/4yxAxTVdk7Knqa0Eckp/M9aYs8dspFn
        krokQP5triDkCwdcWWdfkmiXdosTgQcntOU8m/x/v/qf4I91VX/bflRcwRGhYDrj
        iKufekjOExZDvY2umxxLS1XHU8IZiS4fO9U/AWJ3HlM=;
X-AuditID: ac14000a-917fe70000007ecb-a4-63bee503c4b7
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id C1.F6.32459.305EEB36; Wed, 11 Jan 2023 17:34:11 +0100 (CET)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 11 Jan
 2023 17:34:11 +0100
From:   Wadim Egorov <w.egorov@phytec.de>
To:     <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <upstream@lists.phytec.de>
CC:     <riku.voipio@iki.fi>, <alexandre.belloni@bootlin.com>,
        <a.zummo@towertech.it>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <lee@kernel.org>, <pavel@ucw.cz>
Subject: [PATCH v2 1/2] dt-bindings: leds: Convert PCA9532 to dtschema
Date:   Wed, 11 Jan 2023 17:34:03 +0100
Message-ID: <20230111163404.3526248-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsWyRpKBR5f56b5kg63vzSyWXLzKbtH+bhm7
        xfwj51gt+l48ZLbY0baQxeLyrjlsFlvfrGO0OLb6CpvF3VNH2SxObrjEZtG69wi7Rfc7dQce
        j3lrqj0Of13I4rFpVSebx51re9g8+rtbWD2mz/vJ5LFi9Xd2j8+b5AI4orhsUlJzMstSi/Tt
        ErgyevZ9Yi04oFZxYd1ZxgbGXtkuRk4OCQETiTPdK5i6GLk4hAQWM0l8fvWeGcJ5wijR3bSZ
        DaSKTUBd4s6Gb6wgCRGB2YwSHW83gFUxC2xilJhy8zgLSJWwgJvE1eaDrCA2i4CqxMTup+xd
        jBwcvAKWEhf/10Gsk5eYeek7O4jNKyAocXLmE7BWZqB489bZzBC2hMTBFy/AbCGg+ItLy1lg
        eqede80MYYdKbP2ynWkCo8AsJKNmIRk1C8moBYzMqxiFcjOTs1OLMrP1CjIqS1KT9VJSNzGC
        4kWEgWsHY98cj0OMTByMhxglOJiVRHhXcu5JFuJNSaysSi3Kjy8qzUktPsQozcGiJM57v4cp
        UUggPbEkNTs1tSC1CCbLxMEp1cAYpKTBfECRVYh9wtpI3fu23dPPXVp6XyF22e20k2UC9cyu
        n5tk8r+UCSzw8F7ItPb454smn+obz/zMWVklOfPMzncfLkYrvmrh9s1umvhCI/546GudZQkl
        3YaK1p27zsysenXSd+3ryc+/nmRXPLdAdv/cHTH65ho9z4+9eOzQM/HyZYP5q28uUWIpzkg0
        1GIuKk4EAH0/IumFAgAA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the PCA9532 LED dimmer to dtschema.
While at it, also update and the the example to match
recommended node names and the link to the product datasheet.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
v2:
  - Rename yaml file to match compatibles, nxp,pca953x.yaml
  - Remove Jacek Anaszewski from maintainers list
  - Remove color labels in example
  - Restore labels/default-states from original example
  - Drop reg description
  - Add unevaluatedProperties to patternProperties scope
  - Update description of type property & set default to 0
  - Fix indentation in example
---
 .../devicetree/bindings/leds/leds-pca9532.txt | 49 -----------
 .../devicetree/bindings/leds/nxp,pca953x.yaml | 85 +++++++++++++++++++
 2 files changed, 85 insertions(+), 49 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/leds/leds-pca9532.txt
 create mode 100644 Documentation/devicetree/bindings/leds/nxp,pca953x.yaml

diff --git a/Documentation/devicetree/bindings/leds/leds-pca9532.txt b/Documentation/devicetree/bindings/leds/leds-pca9532.txt
deleted file mode 100644
index f769c52e3643..000000000000
--- a/Documentation/devicetree/bindings/leds/leds-pca9532.txt
+++ /dev/null
@@ -1,49 +0,0 @@
-*NXP - pca9532 PWM LED Driver
-
-The PCA9532 family is SMBus I/O expander optimized for dimming LEDs.
-The PWM support 256 steps.
-
-Required properties:
-	- compatible:
-		"nxp,pca9530"
-		"nxp,pca9531"
-		"nxp,pca9532"
-		"nxp,pca9533"
-	- reg -  I2C slave address
-
-Each led is represented as a sub-node of the nxp,pca9530.
-
-Optional sub-node properties:
-	- label: see Documentation/devicetree/bindings/leds/common.txt
-	- type: Output configuration, see dt-bindings/leds/leds-pca9532.h (default NONE)
-	- linux,default-trigger: see Documentation/devicetree/bindings/leds/common.txt
-	- default-state: see Documentation/devicetree/bindings/leds/common.txt
-	  This property is only valid for sub-nodes of type <PCA9532_TYPE_LED>.
-
-Example:
-  #include <dt-bindings/leds/leds-pca9532.h>
-
-  leds: pca9530@60 {
-    compatible = "nxp,pca9530";
-    reg = <0x60>;
-
-    red-power {
-      label = "pca:red:power";
-      type = <PCA9532_TYPE_LED>;
-    };
-    green-power {
-      label = "pca:green:power";
-      type = <PCA9532_TYPE_LED>;
-    };
-    kernel-booting {
-      type = <PCA9532_TYPE_LED>;
-      default-state = "on";
-    };
-    sys-stat {
-      type = <PCA9532_TYPE_LED>;
-      default-state = "keep"; // don't touch, was set by U-Boot
-    };
-  };
-
-For more product information please see the link below:
-http://nxp.com/documents/data_sheet/PCA9532.pdf
diff --git a/Documentation/devicetree/bindings/leds/nxp,pca953x.yaml b/Documentation/devicetree/bindings/leds/nxp,pca953x.yaml
new file mode 100644
index 000000000000..f735379775a7
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/nxp,pca953x.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/nxp,pca953x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP PCA9532 LED Dimmer
+
+maintainers:
+  - Riku Voipio <riku.voipio@iki.fi>
+
+description: |
+  The PCA9532 family is SMBus I/O expander optimized for dimming LEDs.
+  The PWM support 256 steps.
+
+  For more product information please see the link below:
+    https://www.nxp.com/docs/en/data-sheet/PCA9532.pdf
+
+properties:
+  compatible:
+    enum:
+      - nxp,pca9530
+      - nxp,pca9531
+      - nxp,pca9532
+      - nxp,pca9533
+
+  reg:
+    maxItems: 1
+
+patternProperties:
+  "^led-[0-9a-z]+$":
+    type: object
+    $ref: common.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      type:
+        description: |
+          Output configuration, see include/dt-bindings/leds/leds-pca9532.h
+        $ref: /schemas/types.yaml#/definitions/uint32
+        default: 0
+        minimum: 0
+        maximum: 4
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/leds/leds-pca9532.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        led-controller@62 {
+            compatible = "nxp,pca9533";
+            reg = <0x62>;
+
+            led-1 {
+                label = "pca:red:power";
+                type = <PCA9532_TYPE_LED>;
+            };
+
+            led-2 {
+                label = "pca:green:power";
+                type = <PCA9532_TYPE_LED>;
+            };
+
+            led-3 {
+                type = <PCA9532_TYPE_LED>;
+                default-state = "on";
+            };
+
+            led-4 {
+                type = <PCA9532_TYPE_LED>;
+                default-state = "keep";
+            };
+        };
+    };
+
+...
-- 
2.34.1

