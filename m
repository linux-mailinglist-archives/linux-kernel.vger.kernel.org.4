Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395D66274B8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 03:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235720AbiKNCt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 21:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbiKNCty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 21:49:54 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4382913F51;
        Sun, 13 Nov 2022 18:49:53 -0800 (PST)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8DxTtvQrHFjGcgGAA--.20674S3;
        Mon, 14 Nov 2022 10:49:52 +0800 (CST)
Received: from localhost.localdomain (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxJlfIrHFjcjkSAA--.31072S3;
        Mon, 14 Nov 2022 10:49:51 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        zhanghongchen <zhanghongchen@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>
Subject: [PATCH v10 2/2] dt-bindings: pinctrl: add loongson-2 pinctrl
Date:   Mon, 14 Nov 2022 10:49:42 +0800
Message-Id: <20221114024942.8111-2-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221114024942.8111-1-zhuyinbo@loongson.cn>
References: <20221114024942.8111-1-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxJlfIrHFjcjkSAA--.31072S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxXF47tFy5XFW7Gr4DAF4ruFg_yoWrCF4DpF
        4fur93GF17ta1fu398Aa40vw1rGan3AFZrCa12v34jqr4qqa4qvay3Kr90qrWDur43Jay5
        WFy5C347XF1UCr7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b3xFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr
        1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkE
        cVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F4
        0Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC
        6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l42xK82IY6x8Erc
        xFaVAv8VWrMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E
        5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
        W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY
        1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
        0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7I
        U8QzVUUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Loongson-2 pinctrl binding with DT schema format using
json-schema.

Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
---
Change in v10:
		1. Remove lio/uart2/uart1/carmera/dvo1/dvo0 pins resue configuration.
Change in v9:
		1. NO change, but other patch in this series patches set has
		   change.
Change in v8:
		1. NO change, but other patch in this series patches set has
		   change.
Change in v7:
		1. Add all change log information. 
Change in v6:
		1. NO change, but other patch in this series patches set has
		   change.
Change in v5:
		1. Drop dependencies.
		2. Add spaces after '='.
		3. Replace string loongson2 with loongson-2 in title.
Change in v4:
		1. Replace Loongson2 with Loongson-2.
Change in v3:
		1. Drop the quotes in "pinctrl.yaml#".
		2. Remove the items in function node.
		3. Add requird node for "group" and "function" in properties.
Change in v2: 
                1. Add "$ref to pinctrl.yaml".
                2. Put required after patternProperties.
                3. Add "additionalProperties: false" after '-pins$'
                4. Add "unevaluatedProperties: false" after 'pinmux$'
                5. Fixup the broken indentation in patternProperties node.
                6. Use 4 spaces for example indentation. 

 .../pinctrl/loongson,ls2k-pinctrl.yaml        | 123 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 124 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/loongson,ls2k-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/loongson,ls2k-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/loongson,ls2k-pinctrl.yaml
new file mode 100644
index 000000000000..bd8a45843566
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/loongson,ls2k-pinctrl.yaml
@@ -0,0 +1,123 @@
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
+                     nand, sata_led, i2s, hda]
+          function:
+            description:
+              The function that a group of pins is muxed to
+            enum: [gpio, sdio, can1, can0, pwm3, pwm2, pwm1, pwm0, i2c1, i2c0,
+                   nand, sata_led, i2s, hda]
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
index 0e493b4d6e39..e85b0c1aeebb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12041,6 +12041,7 @@ M:	zhanghongchen <zhanghongchen@loongson.cn>
 M:	Yinbo Zhu <zhuyinbo@loongson.cn>
 L:	linux-gpio@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/pinctrl/loongson,ls2k-pinctrl.yaml
 F:	drivers/pinctrl/pinctrl-loongson2.c
 
 LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
-- 
2.31.1

