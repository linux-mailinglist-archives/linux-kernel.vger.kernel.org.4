Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C35D6868B1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 15:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbjBAOnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 09:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbjBAOnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 09:43:12 -0500
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF8B2E819;
        Wed,  1 Feb 2023 06:43:04 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AEAB6C00E3;
        Wed,  1 Feb 2023 15:34:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1675262096; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=MjLoVQc1RTDuq1zZZzBKnhQUzoJ04kzFHyZmhNIUaWs=;
        b=spjaJgzmNsNJYfBkVEYRJKvJQFzMRn1FUYNuO4U2YOFo6WNhl4gFXP7VNY3+DO8DbbhKnZ
        pCtmGlTp1+RBxMd8C2QFwjJCRNqe7RV6VIXAIrz7KLehDVMeWGc27T8YEDnlLv3WW8J61A
        c28Faflv191Q3jKkv4PygmYs+VzhSOSyW7J6TIq+zIO8p8LWKP8frD/mXq3vbGzsJlA0BP
        UcMOhavzQb6nTErryt0UluYi6nSlj4k5ll3cXiRltnTazQTqww6CcmfaaVfu1zlzXod0fD
        8UK7NrSGX7pMbTx/xSFvTGBj4TIGIsqGPAdGw3o7h3FBMsD2+lKwVmENWV3g5Q==
From:   Frieder Schrempf <frieder@fris.de>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Rob Herring <robh@kernel.org>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH 1/7] dt-bindings: rtc: Move RV3028 to separate binding file
Date:   Wed,  1 Feb 2023 15:34:23 +0100
Message-Id: <20230201143431.863784-2-frieder@fris.de>
In-Reply-To: <20230201143431.863784-1-frieder@fris.de>
References: <20230201143431.863784-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The RV3028 driver uses properties that are not covered by the
trivial-rtc bindings. Use custom bindings for it.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 .../bindings/rtc/microcrystal,rv3028.yaml     | 56 +++++++++++++++++++
 .../devicetree/bindings/rtc/trivial-rtc.yaml  |  2 -
 2 files changed, 56 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/microcrystal,rv3028.yaml

diff --git a/Documentation/devicetree/bindings/rtc/microcrystal,rv3028.yaml b/Documentation/devicetree/bindings/rtc/microcrystal,rv3028.yaml
new file mode 100644
index 000000000000..4667ba86fd0c
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/microcrystal,rv3028.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/microcrystal,rv3028.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip RV-3028 RTC
+
+allOf:
+  - $ref: "rtc.yaml#"
+
+maintainers:
+  - Alexandre Belloni <alexandre.belloni@bootlin.com>
+
+properties:
+  compatible:
+    const: microcrystal,rv3028
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  start-year: true
+
+  trickle-resistor-ohms:
+    enum:
+      - 3000
+      - 5000
+      - 9000
+      - 15000
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        rtc@51 {
+            compatible = "microcrystal,rv3028";
+            reg = <0x52>;
+            pinctrl-0 = <&rtc_nint_pins>;
+            interrupts-extended = <&gpio1 16 IRQ_TYPE_LEVEL_HIGH>;
+            trickle-resistor-ohms = <3000>;
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
index d9fc120c61cc..84cce1f0ca0c 100644
--- a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
@@ -48,8 +48,6 @@ properties:
       # Intersil ISL12022 Real-time Clock
       - isil,isl12022
       # Real Time Clock Module with I2C-Bus
-      - microcrystal,rv3028
-      # Real Time Clock Module with I2C-Bus
       - microcrystal,rv3029
       # Real Time Clock
       - microcrystal,rv8523
-- 
2.39.1

