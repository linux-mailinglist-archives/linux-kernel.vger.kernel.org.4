Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA3A6DF845
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjDLOVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbjDLOVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:21:11 -0400
X-Greylist: delayed 903 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Apr 2023 07:21:09 PDT
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79723183
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 07:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1681308364; x=1683900364;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WrFn9iDbaV5x+FOAg2G6WdULkedjfTsa5Xa3aWRozy8=;
        b=ln7NV5u4bPOkbVIEo4bVSySZ1QkcNe16fZW1WSzLKfCNTcZ/pS57pIUyAATD23PO
        lRD1Ki/V0SzbJ7c+jgBfQsPhM/G1pWbmXJBRrTOhxDgWRyW1KzIk0dQGwO5eB72s
        QoUgO3c208CwvmNyc7799BVuGoGOMGo6n7NYaBpeQdE=;
X-AuditID: ac14000a-917fe70000007ecb-cc-6436bacc0738
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id B4.6A.32459.CCAB6346; Wed, 12 Apr 2023 16:06:04 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 12 Apr
 2023 16:06:19 +0200
From:   Wadim Egorov <w.egorov@phytec.de>
To:     <upstream@lists.phytec.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-leds@vger.kernel.org>
CC:     <riku.voipio@iki.fi>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <lee@kernel.org>, <pavel@ucw.cz>
Subject: [PATCH v3] dt-bindings: leds: Convert PCA9532 to dtschema
Date:   Wed, 12 Apr 2023 16:05:51 +0200
Message-ID: <20230412140552.451527-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBLMWRmVeSWpSXmKPExsWyRpKBR/fMLrMUg3+TBSzmHznHatH34iGz
        xY62hSwWl3fNYbPY+mYdo8XdU0fZLE5uuMRm0br3CLtF9zt1B06Pw18XsnhsWtXJ5nHn2h42
        j/7uFlaPFau/s3t83iQXwBbFZZOSmpNZllqkb5fAlfF6zQfmgkWaFYu3NbM2MK6S72Lk5JAQ
        MJGYu+IJUxcjF4eQwBImiX2XL7JDOE8YJSasmcACUsUmoC5xZ8M3VhBbRKBG4venX4wgNrNA
        uUT7l5lADRwcwgJOElsOe4GEWQRUJTau7mMHsXkFLCTab+9jgVgmLzHz0neouKDEyZlPWCDG
        yEs0b53NDGFLSBx88QLMFgKKv7i0HK532rnXzBB2qMTWL9uZJjAKzEIyahaSUbOQjFrAyLyK
        USg3Mzk7tSgzW68go7IkNVkvJXUTIyj0RRi4djD2zfE4xMjEwXiIUYKDWUmE94eLaYoQb0pi
        ZVVqUX58UWlOavEhRmkOFiVx3vs9TIlCAumJJanZqakFqUUwWSYOTqkGxlCO2ku3Mk0/fLFp
        PrYyT2xKSOuFttO/PZ9N3L3hjAGfyOvjXf+PJMwwTdwZXOVj+oIv4V7/HbV9EsdeZpsuZT67
        chPTRP2yFbV6LdvPfKrn+ZmwqNXC4vEX8SWTIyauWm1++dMSMYcbBk/UjPY9t19gtVM0fXJW
        yKJ/d9j0b4vk7spSeGa18aQSS3FGoqEWc1FxIgDqLQHcawIAAA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the PCA9532 LED Dimmer to dtschema.
While at it, update the example to match recommended node names and
the link to the product datasheet. Also add GPIO properties since
the driver allows to use unused pins as GPIOs.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
v3:
  - Add gpio-controller & gpio-cells property, fixes
    arch/arm/boot/dts/lpc3250-ea3250.dtb: pca9532@60: '#gpio-cells', 'gpio-controller'
    do not match any of the regexes: '^led-[0-9a-z]+$', 'pinctrl-[0-9]+'

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
 .../devicetree/bindings/leds/leds-pca9532.txt | 49 ----------
 .../devicetree/bindings/leds/nxp,pca953x.yaml | 90 +++++++++++++++++++
 2 files changed, 90 insertions(+), 49 deletions(-)
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
index 000000000000..edf6f55df685
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/nxp,pca953x.yaml
@@ -0,0 +1,90 @@
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
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 2
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
2.25.1

