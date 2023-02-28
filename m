Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9422C6A6109
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 22:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjB1VMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 16:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjB1VLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 16:11:53 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143DC2CC65;
        Tue, 28 Feb 2023 13:11:29 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 376985FD0B;
        Wed,  1 Mar 2023 00:11:27 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1677618687;
        bh=iFLbpUTpFjtEgq/BU8HqjGefc3Kz1N0Yah+LPjcdhyk=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=SAKDJNV7kJPrA5+5HfiFn1FLJrpHSjiHVCoEQCEnuzZxvHY5oIBOKi9JDOvPtRiYa
         cPhf9DX7OmJeIFXH+F/eq1O/K3/hkJVOQ3fEKSHVPcovt6Co4kLiaJQhTfy7rcbE5G
         FjJlf9297Bs4YKFRBJgXho0iaMLWTmV68mAW4hNpXnn6W3RbZY3wAPsYHeKscDJIHu
         i9t2Yiy2v7EyCcKutXvaNOQfArUQYvdjpJx03YlTlC9lkJdNg1frfqlrLwMIK/0cEa
         dtzP4oAfwIvVJ6IzbdtzrtZupwcPeixC3/KW9DlK3M/k2AA/tG4XucY/BhxbROSfCl
         dXI8wptglV3TQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed,  1 Mar 2023 00:11:27 +0300 (MSK)
From:   Martin Kurbanov <mmkurbanov@sberdevices.ru>
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@sberdevices.ru>,
        Martin Kurbanov <mmkurbanov@sberdevices.ru>
Subject: [PATCH v2 1/2] dt-bindings: leds: add binding for aw200xx
Date:   Wed, 1 Mar 2023 00:10:45 +0300
Message-ID: <20230228211046.109693-2-mmkurbanov@sberdevices.ru>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230228211046.109693-1-mmkurbanov@sberdevices.ru>
References: <20230228211046.109693-1-mmkurbanov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/02/28 15:18:00 #20903376
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,T_SPF_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML devicetree binding for AWINIC AW20036/AW20052/AW20074
led driver.

Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
---
 .../bindings/leds/awinic,aw200xx.yaml         | 126 ++++++++++++++++++
 1 file changed, 126 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml

diff --git a/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml b/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
new file mode 100644
index 000000000000..08181703e223
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
@@ -0,0 +1,126 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/awinic,aw200xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AWINIC AW200XX LED
+
+maintainers:
+  - Martin Kurbanov <mmkurbanov@sberdevices.ru>
+
+description: |
+  This controller is present on AW20036/AW20054/AW20072.
+  It is a 3x12/6x9/6x12 matrix LED programmed via
+  an I2C interface, up to 36/54/72 LEDs or 12/18/24 RGBs,
+  3 pattern controllers for auto breathing or group dimming control.
+
+  For more product information please see the link below:
+  aw20036 - https://www.awinic.com/Public/Uploads/uploadfile/files/20200509/20200509151532_5eb65894d205a.pdf
+  aw20054 - https://www.awinic.com/Public/Uploads/uploadfile/files/20200509/20200509151602_5eb658b2b77cb.pdf
+  aw20072 - https://www.awinic.com/Public/Uploads/uploadfile/files/20200509/20200509151754_5eb659227a145.pdf
+
+properties:
+  compatible:
+    enum:
+      - awinic,aw20036
+      - awinic,aw20054
+      - awinic,aw20072
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  awinic,display-rows:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Leds matrix size
+
+patternProperties:
+  "^led@[0-9a-f]$":
+    type: object
+    $ref: common.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        description:
+          LED number
+        maxItems: 1
+
+      led-max-microamp:
+        default: 9780
+        description: |
+          Note that a driver will take the minimum of all LED limits
+          since the chip has a single global setting.
+          The maximum output current of each LED is calculated by the
+          following formula:
+            IMAXled = 160000 * (592 / 600.5) * (1 / display-rows)
+          And the minimum output current formula:
+            IMINled = 3300 * (592 / 600.5) * (1 / display-rows)
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - awinic,display-rows
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: awinic,aw20036
+    then:
+      properties:
+        awinic,display-rows:
+          enum: [1, 2, 3]
+    else:
+      properties:
+        awinic,display-rows:
+          enum: [1, 2, 3, 4, 5, 6, 7]
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        led-controller@3a {
+            compatible = "awinic,aw20036";
+            reg = <0x3a>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            awinic,display-rows = <3>;
+
+            led@0 {
+                reg = <0x0>;
+                color = <LED_COLOR_ID_RED>;
+                led-max-microamp = <9780>;
+            };
+
+            led@1 {
+                reg = <0x1>;
+                color = <LED_COLOR_ID_GREEN>;
+                led-max-microamp = <9780>;
+            };
+
+            led@2 {
+                reg = <0x2>;
+                color = <LED_COLOR_ID_BLUE>;
+                led-max-microamp = <9780>;
+            };
+        };
+    };
+
+...
-- 
2.38.1

