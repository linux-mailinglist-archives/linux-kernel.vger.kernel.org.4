Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30B96070D4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 09:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiJUHRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 03:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiJUHRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 03:17:25 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB2981F9A34;
        Fri, 21 Oct 2022 00:17:15 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8DxvreJ9VFjH0YBAA--.991S3;
        Fri, 21 Oct 2022 09:27:37 +0800 (CST)
Received: from localhost.localdomain (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxLeCC9VFjxFUCAA--.9496S3;
        Fri, 21 Oct 2022 09:27:35 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        zhanghongchen <zhanghongchen@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>
Subject: [PATCH v1 2/2] dt-bindings: pinctrl: add loongson2 pinctrl
Date:   Fri, 21 Oct 2022 09:27:28 +0800
Message-Id: <20221021012728.22373-2-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221021012728.22373-1-zhuyinbo@loongson.cn>
References: <20221021012728.22373-1-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxLeCC9VFjxFUCAA--.9496S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxXF47tFy8Kr4fJF43AFW8JFb_yoW5urW8pF
        4fC3sxGF1xtF4xX39xCa40vw1fGan7AF9rCasFv34jqr4Dta4vvay5Krn0q3yDCF43ArW5
        WFy5u342qF1UAw7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b78Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUGVWUXwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l
        57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r126r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VWrMxC20s026x
        CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
        JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
        1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_
        Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
        UvcSsGvfC2KfnxnUUI43ZEXa7IU8cBMtUUUUU==
X-Gw-Check: 27be656114213f6f
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the loongson2 pinctrl binding with DT schema format using
json-schema.

Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
---
 .../pinctrl/loongson,ls2k-pinctrl.yaml        | 118 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 119 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/loongson,ls2k-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/loongson,ls2k-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/loongson,ls2k-pinctrl.yaml
new file mode 100644
index 000000000000..038d38ad1785
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/loongson,ls2k-pinctrl.yaml
@@ -0,0 +1,118 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/loongson,ls2k-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Loongson2 SoC Pinctrl Controller
+
+maintainers:
+  - zhanghongchen <zhanghongchen@loongson.cn>
+  - Yinbo Zhu <zhuyinbo@loongson.cn>
+
+properties:
+  compatible:
+    const: loongson,ls2k-pinctrl
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+patternProperties:
+  '-pins$':
+    type: object
+    patternProperties:
+      'pinmux$':
+        type: object
+        description: node for pinctrl.
+        $ref: pinmux-node.yaml#
+
+    properties:
+      groups:
+        description:
+          One or more groups of pins to mux to a certain function
+        items:
+          enum: [gpio, sdio, can1, can0, pwm3, pwm2, pwm1, pwm0, i2c1, i2c0,
+                 nand, sata_led, lio, i2s, hda, uart2, uart1, camera, dv01,
+                 dvo0]
+      function:
+        description:
+          The function that a group of pins is muxed to
+        items:
+          enum: [gpio, sdio, can1, can0, pwm3, pwm2, pwm1, pwm0, i2c1, i2c0,
+                 nand, sata_led, lio, i2s, hda, uart2, uart1, camera, dv01,
+                 dvo0]
+
+    dependencies:
+      groups: [function]
+      function: [groups]
+
+additionalProperties: false
+
+examples:
+  - |
+    pctrl: pinctrl@1fe00420 {
+           compatible = "loongson,ls2k-pinctrl";
+           reg = <0x1fe00420 0x18>;
+           sdio_pins_default: sdio-pins {
+                sdio-pinmux {
+                        groups ="sdio";
+                        function ="sdio";
+                };
+
+                sdio-det-pinmux {
+                        groups ="pwm2";
+                        function ="gpio";
+                };
+           };
+
+           pwm1_pins_default: pwm1-pins {
+                        pinmux {
+                                groups ="pwm1";
+                                function ="pwm1";
+                        };
+           };
+
+           pwm0_pins_default: pwm0-pins {
+                        pinmux {
+                                groups ="pwm0";
+                                function ="pwm0";
+                        };
+           };
+
+           i2c1_pins_default: i2c1-pins {
+                        pinmux {
+                                groups ="i2c1";
+                                function ="i2c1";
+                        };
+           };
+
+           i2c0_pins_default: i2c0-pins {
+                        pinmux {
+                                groups ="i2c0";
+                                function ="i2c0";
+                        };
+           };
+
+           nand_pins_default: nand-pins {
+                        pinmux {
+                                groups ="nand";
+                                function ="nand";
+                        };
+           };
+
+           hda_pins_default: hda-pins {
+                        grp0-pinmux {
+                                groups ="hda";
+                                function ="hda";
+                        };
+
+                        grp1-pinmux {
+                                groups ="i2s";
+                                function ="gpio";
+                        };
+           };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index c9883f145acb..2d002509fc65 100644
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
2.20.1

