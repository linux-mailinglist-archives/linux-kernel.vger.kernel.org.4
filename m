Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9535E63805A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 21:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiKXUtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 15:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiKXUtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 15:49:11 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000587F59D;
        Thu, 24 Nov 2022 12:49:06 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id D8AF85FD24;
        Thu, 24 Nov 2022 23:49:03 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1669322943;
        bh=kmP/Zy5qWYCcTKYScky3kpRF3e13A2vHiJGOpNfEiYU=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=YMCdBGAUPSUZmIea/GEeNd+wp8TZovBARXg2pBo3c23dLgBBTFp19bYccFXS7U35I
         9gWK8nNUP9rEKubzf6NMbVOMuL8Hk3epGLGTDSw+d/CXj8GIhnOX6WwPyrBpwVzaNL
         Z4mkaTt2V4+QC7yxnmY5NKCz9Vt2t5rG8oXQoSY+Z6m4O/ETeJJu/W8RIURQfT7oWu
         myFQpFEKZDDXK7SjbQTy/sR+FIuzmHsVmKVti6izzjsDk8Hsw/FZ9qCh6R++8GOuUT
         y+P7gEui82kUNKhKTegsGIO3FVihSWa81hzT/wRafwdxy9gKfXTC7JkoJY3EiV1sJ1
         7yGdHqfVND4fA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Thu, 24 Nov 2022 23:49:03 +0300 (MSK)
From:   Martin Kurbanov <mmkurbanov@sberdevices.ru>
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <kernel@sberdevices.ru>,
        Martin Kurbanov <mmkurbanov@sberdevices.ru>
Subject: [PATCH v1 1/2] dt-bindings: leds: add binding for aw200xx
Date:   Thu, 24 Nov 2022 23:48:06 +0300
Message-ID: <20221124204807.1593241-2-mmkurbanov@sberdevices.ru>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221124204807.1593241-1-mmkurbanov@sberdevices.ru>
References: <20221124204807.1593241-1-mmkurbanov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/11/24 17:43:00 #20605348
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML devicetree binding for AWINIC AW20036/AW20052/AW20074
led driver.

Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
---
 .../bindings/leds/leds-aw200xx.yaml           | 110 ++++++++++++++++++
 include/dt-bindings/leds/leds-aw200xx.h       |  48 ++++++++
 2 files changed, 158 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-aw200xx.yaml
 create mode 100644 include/dt-bindings/leds/leds-aw200xx.h

diff --git a/Documentation/devicetree/bindings/leds/leds-aw200xx.yaml b/Documentation/devicetree/bindings/leds/leds-aw200xx.yaml
new file mode 100644
index 000000000000..3bdadcbc2ee2
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-aw200xx.yaml
@@ -0,0 +1,110 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/leds-aw200xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AWINIC AW200XX LED Driver
+
+maintainers:
+  - Martin Kurbanov <mmkurbanov@sberdevices.ru>
+
+description: |
+  This controller is present on AW20036/AW20054/AW20072.
+  It is a 3x12/6x9/6x12 matrix LED driver programmed via
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
+  interrupts:
+    maxItems: 1
+
+  display-size:
+    maxItems: 1
+    description:
+      Leds matrix size, see dt-bindings/leds/leds-aw200xx.h
+
+  imax:
+    maxItems: 1
+    description:
+      Maximum supply current, see dt-bindings/leds/leds-aw200xx.h
+
+patternProperties:
+  "^led@[0-9a-f]$":
+    type: object
+    $ref: common.yaml#
+
+    properties:
+      reg:
+        description:
+          LED number
+        maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - display-size
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/leds/common.h>
+    #include <dt-bindings/leds/leds-aw200xx.h>
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
+            interrupt-parent = <&gpio_intc>;
+            interrupts = <13 IRQ_TYPE_LEVEL_LOW>;
+
+            display-size = <AW20036_DSIZE_3X12>;
+            imax = <AW200XX_IMAX_60MA>;
+
+            led@0 {
+                reg = <0x0>;
+                color = <LED_COLOR_ID_RED>;
+            };
+
+            led@1 {
+                reg = <0x1>;
+                color = <LED_COLOR_ID_GREEN>;
+            };
+
+            led@2 {
+                reg = <0x2>;
+                color = <LED_COLOR_ID_BLUE>;
+            };
+        };
+    };
+
+...
diff --git a/include/dt-bindings/leds/leds-aw200xx.h b/include/dt-bindings/leds/leds-aw200xx.h
new file mode 100644
index 000000000000..6b2ba4c3c6b1
--- /dev/null
+++ b/include/dt-bindings/leds/leds-aw200xx.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/**
+ * This header provides constants for aw200xx LED bindings.
+ *
+ * Copyright (c) 2022, SberDevices. All Rights Reserved.
+ *
+ * Author: Martin Kurbanov <mmkurbanov@sberdevices.ru>
+ */
+#ifndef _DT_BINDINGS_LEDS_AW200XX_H
+#define _DT_BINDINGS_LEDS_AW200XX_H
+
+/* Global max current (IMAX) */
+#define AW200XX_IMAX_3_3MA  8
+#define AW200XX_IMAX_6_7MA  9
+#define AW200XX_IMAX_10MA   0
+#define AW200XX_IMAX_13_3MA 11
+#define AW200XX_IMAX_20MA   1
+#define AW200XX_IMAX_26_7MA 13
+#define AW200XX_IMAX_30MA   2
+#define AW200XX_IMAX_40MA   3
+#define AW200XX_IMAX_53_3MA 15
+#define AW200XX_IMAX_60MA   4
+#define AW200XX_IMAX_80MA   5
+#define AW200XX_IMAX_120MA  6
+#define AW200XX_IMAX_160MA  7
+
+/* Display size for aw20036 */
+#define AW20036_DSIZE_1X12 0
+#define AW20036_DSIZE_2X12 1
+#define AW20036_DSIZE_3X12 2
+
+/* Display size for aw20054 */
+#define AW20054_DSIZE_1X9 0
+#define AW20054_DSIZE_2X9 1
+#define AW20054_DSIZE_3X9 2
+#define AW20054_DSIZE_4X9 3
+#define AW20054_DSIZE_5X9 4
+#define AW20054_DSIZE_6X9 5
+
+/* Display size for aw20072 */
+#define AW20072_DSIZE_1X12 0
+#define AW20072_DSIZE_2X12 1
+#define AW20072_DSIZE_3X12 2
+#define AW20072_DSIZE_4X12 3
+#define AW20072_DSIZE_5X12 4
+#define AW20072_DSIZE_6X12 5
+
+#endif /* !_DT_BINDINGS_LEDS_AW200XX_H */
-- 
2.38.1

