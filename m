Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450C763B799
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 03:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbiK2CBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 21:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234693AbiK2CA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 21:00:59 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 14B4D450BF;
        Mon, 28 Nov 2022 18:00:56 -0800 (PST)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8DxOenYZ4Vj3+EBAA--.1315S3;
        Tue, 29 Nov 2022 10:00:56 +0800 (CST)
Received: from localhost.localdomain (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxR1fRZ4Vj89odAA--.57349S3;
        Tue, 29 Nov 2022 10:00:54 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Juxin Gao <gaojuxin@loongson.cn>,
        Bibo Mao <maobibo@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        Arnaud Patard <apatard@mandriva.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v9 2/2] dt-bindings: gpio: add loongson gpio
Date:   Tue, 29 Nov 2022 10:00:47 +0800
Message-Id: <20221129020047.12151-2-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221129020047.12151-1-zhuyinbo@loongson.cn>
References: <20221129020047.12151-1-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxR1fRZ4Vj89odAA--.57349S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxXF47tF4DJw1xAF47Ww45Wrg_yoW7Jw1UpF
        1DZFZxX3y2gr1ayFs8Ka17Xr4fAr1kC3Wruwn8C34xtrWUKw13XFWfWFykG3Z3WrWUXF13
        JwsxurWrJa43Aw7anT9S1TB71UUUUjJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr
        1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkE
        cVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F4
        0Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC
        6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2
        Ij64vIr41l42xK82IY6x8ErcxFaVAv8VWrMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI
        1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
        Wlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j
        6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr
        0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUv
        cSsGvfC2KfnxnUUI43ZEXa7IU86yIUUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Loongson platform gpio binding with DT schema format using
json-schema.

Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Change in v9:
		1. NO change, but other patch in this series of patches set has
		   change.
Change in v8:
		1. NO change, but other patch in this series of patches set has
		   change.
Change in v7:
		1. NO change, but other patch in this series of patches set has
		   change.
Change in v6:
		1. NO change, but other patch in this series of patches set has
		   change.
Change in v5:
		1. NO change, but other patch in this series of patches set has
		   change.
Change in v4:
		1. Remove the string "series".
		2. Add the reviewed-by information.
Change in v3:
		1. Separate some changes of MAINTAINERS file and enter the first patch.
Change in v2:
		1. Drop "loongson,gpio_base" and "gpio-ranges" will cover it.
		1. Drop "loongson,conf_offset", "loongson,out_offset", "loongson,in_offset",
		   "loongson,support_irq" and kernel driver will initial them that depend
		   compatible in kernel.
		3. Fixup maintainer for this driver.

 .../bindings/gpio/loongson,ls-gpio.yaml       | 126 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 127 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml b/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
new file mode 100644
index 000000000000..fb86e8ce6349
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
@@ -0,0 +1,126 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/loongson,ls-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Loongson GPIO controller.
+
+maintainers:
+  - Yinbo Zhu <zhuyinbo@loongson.cn>
+
+properties:
+  compatible:
+    enum:
+      - loongson,ls2k-gpio
+      - loongson,ls7a-gpio
+
+  reg:
+    maxItems: 1
+
+  ngpios:
+    minimum: 1
+    maximum: 64
+
+  "#gpio-cells":
+    const: 2
+
+  gpio-controller: true
+
+  gpio-ranges: true
+
+  interrupts:
+    minItems: 1
+    maxItems: 64
+
+required:
+  - compatible
+  - reg
+  - ngpios
+  - "#gpio-cells"
+  - gpio-controller
+  - gpio-ranges
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    gpio0: gpio@1fe00500 {
+      compatible = "loongson,ls2k-gpio";
+      reg = <0x1fe00500 0x38>;
+      ngpios = <64>;
+      #gpio-cells = <2>;
+      gpio-controller;
+      gpio-ranges = <&pctrl 0 0 15>,
+                    <&pctrl 16 16 15>,
+                    <&pctrl 32 32 10>,
+                    <&pctrl 44 44 20>;
+      interrupt-parent = <&liointc1>;
+      interrupts = <28 IRQ_TYPE_LEVEL_LOW>,
+                   <29 IRQ_TYPE_LEVEL_LOW>,
+                   <30 IRQ_TYPE_LEVEL_LOW>,
+                   <30 IRQ_TYPE_LEVEL_LOW>,
+                   <26 IRQ_TYPE_LEVEL_LOW>,
+                   <26 IRQ_TYPE_LEVEL_LOW>,
+                   <26 IRQ_TYPE_LEVEL_LOW>,
+                   <26 IRQ_TYPE_LEVEL_LOW>,
+                   <26 IRQ_TYPE_LEVEL_LOW>,
+                   <26 IRQ_TYPE_LEVEL_LOW>,
+                   <26 IRQ_TYPE_LEVEL_LOW>,
+                   <26 IRQ_TYPE_LEVEL_LOW>,
+                   <26 IRQ_TYPE_LEVEL_LOW>,
+                   <26 IRQ_TYPE_LEVEL_LOW>,
+                   <26 IRQ_TYPE_LEVEL_LOW>,
+                   <>,
+                   <26 IRQ_TYPE_LEVEL_LOW>,
+                   <26 IRQ_TYPE_LEVEL_LOW>,
+                   <26 IRQ_TYPE_LEVEL_LOW>,
+                   <26 IRQ_TYPE_LEVEL_LOW>,
+                   <26 IRQ_TYPE_LEVEL_LOW>,
+                   <26 IRQ_TYPE_LEVEL_LOW>,
+                   <26 IRQ_TYPE_LEVEL_LOW>,
+                   <26 IRQ_TYPE_LEVEL_LOW>,
+                   <26 IRQ_TYPE_LEVEL_LOW>,
+                   <26 IRQ_TYPE_LEVEL_LOW>,
+                   <26 IRQ_TYPE_LEVEL_LOW>,
+                   <26 IRQ_TYPE_LEVEL_LOW>,
+                   <26 IRQ_TYPE_LEVEL_LOW>,
+                   <26 IRQ_TYPE_LEVEL_LOW>,
+                   <26 IRQ_TYPE_LEVEL_LOW>,
+                   <26 IRQ_TYPE_LEVEL_LOW>,
+                   <27 IRQ_TYPE_LEVEL_LOW>,
+                   <27 IRQ_TYPE_LEVEL_LOW>,
+                   <27 IRQ_TYPE_LEVEL_LOW>,
+                   <27 IRQ_TYPE_LEVEL_LOW>,
+                   <27 IRQ_TYPE_LEVEL_LOW>,
+                   <>,
+                   <27 IRQ_TYPE_LEVEL_LOW>,
+                   <27 IRQ_TYPE_LEVEL_LOW>,
+                   <27 IRQ_TYPE_LEVEL_LOW>,
+                   <27 IRQ_TYPE_LEVEL_LOW>,
+                   <>,
+                   <>,
+                   <27 IRQ_TYPE_LEVEL_LOW>,
+                   <27 IRQ_TYPE_LEVEL_LOW>,
+                   <27 IRQ_TYPE_LEVEL_LOW>,
+                   <27 IRQ_TYPE_LEVEL_LOW>,
+                   <27 IRQ_TYPE_LEVEL_LOW>,
+                   <27 IRQ_TYPE_LEVEL_LOW>,
+                   <27 IRQ_TYPE_LEVEL_LOW>,
+                   <27 IRQ_TYPE_LEVEL_LOW>,
+                   <27 IRQ_TYPE_LEVEL_LOW>,
+                   <27 IRQ_TYPE_LEVEL_LOW>,
+                   <27 IRQ_TYPE_LEVEL_LOW>,
+                   <27 IRQ_TYPE_LEVEL_LOW>,
+                   <27 IRQ_TYPE_LEVEL_LOW>,
+                   <27 IRQ_TYPE_LEVEL_LOW>,
+                   <27 IRQ_TYPE_LEVEL_LOW>,
+                   <27 IRQ_TYPE_LEVEL_LOW>,
+                   <27 IRQ_TYPE_LEVEL_LOW>,
+                   <27 IRQ_TYPE_LEVEL_LOW>,
+                   <27 IRQ_TYPE_LEVEL_LOW>,
+                   <27 IRQ_TYPE_LEVEL_LOW>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 2854da69cabb..b8a02a60973d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12055,6 +12055,7 @@ LOONGSON GPIO DRIVER
 M:	Yinbo Zhu <zhuyinbo@loongson.cn>
 L:	linux-gpio@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
 F:	drivers/gpio/gpio-loongson-64bit.c
 
 LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
-- 
2.31.1

