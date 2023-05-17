Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B74707293
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 21:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjEQTxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 15:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjEQTxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 15:53:00 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D936555A9;
        Wed, 17 May 2023 12:52:56 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 481E25FD48;
        Wed, 17 May 2023 22:52:54 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1684353174;
        bh=I7/4CVIoC9+TGp8GwFUh+0busZ3FOuWXAFKMy9pjxXo=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=a74y8ElYgByCpWEN5XnrNJrJR78ThBkVOn/Mrb3VHkTaruxDpYgXXfHlmJK4Unt9l
         R52fGfEZWU/AOV6TaJ17sp8VGqOfzGJaZBkAfL75zEubAgEehJLdj8QvAsREuVoJ6R
         2ZWE3XrIQbJgwhpTKOxKds/0oLriJCilkz5CeF0WAXFm1gfmqIjt/HudvDm4g76oG3
         58aj49wzWQXcnU9pcLzdqQjqvozz/zqaehITqHfcyuQnEYP+yl01945SG7x+iO1Vl1
         cBsE0jiFwAJoV9SJRYvfoSIqPLV2Ztp1UglY3EVtSLHPXXWP6vWKl3kdqfb5NsC/NM
         i1sx/oZwIodSQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 17 May 2023 22:52:54 +0300 (MSK)
From:   Martin Kurbanov <mmkurbanov@sberdevices.ru>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <kernel@sberdevices.ru>,
        Martin Kurbanov <mmkurbanov@sberdevices.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/2] dt-bindings: leds: add binding for aw200xx
Date:   Wed, 17 May 2023 22:52:37 +0300
Message-ID: <20230517195238.34069-2-mmkurbanov@sberdevices.ru>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230517195238.34069-1-mmkurbanov@sberdevices.ru>
References: <20230517195238.34069-1-mmkurbanov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/17 11:04:00 #21328336
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML devicetree binding for AWINIC AW20036/AW20052/AW20074
led driver.

Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/leds/awinic,aw200xx.yaml         | 126 ++++++++++++++++++
 1 file changed, 126 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml

diff --git a/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml b/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
new file mode 100644
index 000000000000..feb5febaf361
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
+  aw20036 - https://www.awinic.com/en/productDetail/AW20036QNR#tech-docs
+  aw20054 - https://www.awinic.com/en/productDetail/AW20054QNR#tech-docs
+  aw20072 - https://www.awinic.com/en/productDetail/AW20072QNR#tech-docs
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
2.40.0

