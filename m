Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D4A6DA874
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 07:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237539AbjDGFJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 01:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjDGFI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 01:08:58 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A204493;
        Thu,  6 Apr 2023 22:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DKqiILTeinQyjMir8pU1blclYjb+7qQXUWSAhv738uU=; b=797liZRR6v0e2UdI2adkzGsF1x
        9RsJs/zjxIkAo7IRO56V96ziNeELCFwUsykxgvChnmYqyV+Qps7hmk6i08FAGDeDAbbECyWOROd3W
        6BtTcu2XTHAL6g0g1dIXSDs39KzORQxRT4+2dAd5xidSy1QfNkVeEcK3+kz2WqEIKp6KPD7nrkYd7
        P7J3CznReiiuBOIbT7SpMCPskjFUb6+yIkQ6FWOkB73GbBD/mHr9zczISZ8uTokYDfbbl6O+MCxFk
        6g4XGFBWvX3Y3IY2Hk+IkL5hGN9KRi9kFd2dCwUzjUawxoq0JxR/VEJEc4D/LgXEQmV/v2ayHCHWR
        33aCilaQ==;
Received: from p200300ccff0cf1001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0c:f100:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pkeKU-0003s0-9m; Fri, 07 Apr 2023 07:08:45 +0200
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1pkeKU-000iQk-02;
        Fri, 07 Apr 2023 07:08:06 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     pavel@ucw.cz, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andreas@kemnade.info,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: leds: ROHM BD2606MVV LED driver
Date:   Fri,  7 Apr 2023 07:08:02 +0200
Message-Id: <20230407050803.170773-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230407050803.170773-1-andreas@kemnade.info>
References: <20230407050803.170773-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document ROHM BD2606MVV LED driver devicetree bindings.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 .../bindings/leds/rohm,bd2606mvv.yaml         | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/rohm,bd2606mvv.yaml

diff --git a/Documentation/devicetree/bindings/leds/rohm,bd2606mvv.yaml b/Documentation/devicetree/bindings/leds/rohm,bd2606mvv.yaml
new file mode 100644
index 0000000000000..7f53d09e7b054
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/rohm,bd2606mvv.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/rohm,bd2606mvv.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: BD2606MVV LED controller
+
+maintainers:
+  - Andreas Kemnade <andreas@kemnade.info>
+
+description:
+  The BD2606 MVV is a programmable LED controller connected via I2C that can
+  drive 6 separate lines. Each of them can be individually switched on and off
+  but the brightness setting is shared between two of them.
+
+  Datasheet is available at
+  https://fscdn.rohm.com/en/products/databook/datasheet/ic/power/led_driver/bd2606mvv_1-e.pdf
+
+properties:
+  compatible:
+    const: rohm,bd2606mvv
+
+  reg:
+    description: I2C slave address of the controller.
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  enable-gpios:
+    maxItems: 1
+    description: GPIO pin to enable/disable the device.
+
+patternProperties:
+  "^led@[0-6]$":
+    type: object
+    $ref: common.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 6
+
+    required:
+      - reg
+
+additionalProperties: false
+
+examples:
+  - |
+
+    #include <dt-bindings/leds/common.h>
+
+    i2c0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        led-controller@66 {
+            compatible = "rohm,bd2606mvv";
+            #address-cells = <1>;
+            #size-cells = <0>;
+            reg = <0x66>;
+
+            led@0 {
+                color = <LED_COLOR_ID_RED>;
+                function = LED_FUNCTION_POWER;
+                reg = <0x0>;
+            };
+
+            led@2 {
+                color = <LED_COLOR_ID_WHITE>;
+                function = LED_FUNCTION_STATUS;
+                reg = <0x2>;
+            };
+        };
+    };
+
+...
-- 
2.39.2

