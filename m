Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DCE611F48
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 04:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiJ2CVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 22:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJ2CVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 22:21:46 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A264E1A0FAA;
        Fri, 28 Oct 2022 19:21:44 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8DxPLc3jlxjBDYDAA--.361S3;
        Sat, 29 Oct 2022 10:21:43 +0800 (CST)
Received: from localhost.localdomain (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx_eEwjlxj5aMGAA--.22825S3;
        Sat, 29 Oct 2022 10:21:42 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        zhanghongchen <zhanghongchen@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>
Subject: [PATCH v5 2/2] dt-bindings: pinctrl: add loongson-2 pinctrl
Date:   Sat, 29 Oct 2022 10:21:30 +0800
Message-Id: <20221029022130.19914-2-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221029022130.19914-1-zhuyinbo@loongson.cn>
References: <20221029022130.19914-1-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx_eEwjlxj5aMGAA--.22825S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxXF47tFy8Kr4fJF43AFW8JFb_yoW5tw13pF
        43C3sxGr1IqF4xX39xCa40vw13Gan7AF9rC3ZFv34jqr4Dta4vvay5Krn0q3yDCF47JFW5
        WFy5u34UXF1UCr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bzxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc80
        4VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67
        AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48I
        cxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4
        IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
        MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
        WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
        6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcS
        sGvfC2KfnxnUUI43ZEXa7IU1tl1PUUUUU==
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_SBL_CSS,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Loongson-2 pinctrl binding with DT schema format using
json-schema.

Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
---
Change in v5:
		1. Drop dependencies.
		2. Add spaces after '='.
		3. Replace string loongson2 with loongson-2 in title.

 .../pinctrl/loongson,ls2k-pinctrl.yaml        | 125 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 126 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/loongson,ls2k-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/loongson,ls2k-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/loongson,ls2k-pinctrl.yaml
new file mode 100644
index 000000000000..34683a4856ad
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/loongson,ls2k-pinctrl.yaml
@@ -0,0 +1,125 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/loongson,ls2k-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Loongson-2 SoC Pinctrl Controller
+
+maintainers:
+  - zhanghongchen <zhanghongchen@loongson.cn>
+  - Yinbo Zhu <zhuyinbo@loongson.cn>
+
+allOf:
+  - $ref: pinctrl.yaml#
+
+properties:
+  compatible:
+    const: loongson,ls2k-pinctrl
+
+  reg:
+    maxItems: 1
+
+patternProperties:
+  '-pins$':
+    type: object
+
+    additionalProperties: false
+
+    patternProperties:
+      'pinmux$':
+        type: object
+        description: node for pinctrl.
+        $ref: pinmux-node.yaml#
+
+        unevaluatedProperties: false
+
+        properties:
+          groups:
+            description:
+              One or more groups of pins to mux to a certain function
+            items:
+              enum: [gpio, sdio, can1, can0, pwm3, pwm2, pwm1, pwm0, i2c1, i2c0,
+                     nand, sata_led, lio, i2s, hda, uart2, uart1, camera, dv01,
+                     dvo0]
+          function:
+            description:
+              The function that a group of pins is muxed to
+            enum: [gpio, sdio, can1, can0, pwm3, pwm2, pwm1, pwm0, i2c1, i2c0,
+                   nand, sata_led, lio, i2s, hda, uart2, uart1, camera, dv01,
+                   dvo0]
+
+        required:
+          - groups
+          - function
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    pctrl: pinctrl@1fe00420 {
+        compatible = "loongson,ls2k-pinctrl";
+        reg = <0x1fe00420 0x18>;
+        sdio_pins_default: sdio-pins {
+            sdio-pinmux {
+                groups = "sdio";
+                function = "sdio";
+            };
+
+            sdio-det-pinmux {
+                groups = "pwm2";
+                function = "gpio";
+            };
+        };
+
+        pwm1_pins_default: pwm1-pins {
+            pinmux {
+                groups = "pwm1";
+                function = "pwm1";
+            };
+        };
+
+        pwm0_pins_default: pwm0-pins {
+            pinmux {
+                groups = "pwm0";
+                function = "pwm0";
+            };
+        };
+
+        i2c1_pins_default: i2c1-pins {
+            pinmux {
+                groups = "i2c1";
+                function = "i2c1";
+            };
+        };
+
+        i2c0_pins_default: i2c0-pins {
+            pinmux {
+                groups = "i2c0";
+                function = "i2c0";
+            };
+        };
+
+        nand_pins_default: nand-pins {
+            pinmux {
+                groups = "nand";
+                function = "nand";
+            };
+        };
+
+        hda_pins_default: hda-pins {
+            grp0-pinmux {
+                groups = "hda";
+                function = "hda";
+            };
+
+            grp1-pinmux {
+                groups = "i2s";
+                function = "gpio";
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 8afa53595124..4fc949c36a44 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11927,6 +11927,7 @@ M:	zhanghongchen <zhanghongchen@loongson.cn>
 M:	Yinbo Zhu <zhuyinbo@loongson.cn>
 L:	linux-gpio@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/pinctrl/loongson,ls2k-pinctrl.yaml
 F:	drivers/pinctrl/pinctrl-loongson2.c
 
 LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
-- 
2.31.1

