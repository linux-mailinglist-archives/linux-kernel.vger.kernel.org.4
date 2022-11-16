Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C6862B38D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 07:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbiKPGyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 01:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbiKPGxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 01:53:53 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40166A8;
        Tue, 15 Nov 2022 22:53:48 -0800 (PST)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8CxPLb7iHRjOqsHAA--.10502S3;
        Wed, 16 Nov 2022 14:53:47 +0800 (CST)
Received: from localhost.localdomain (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx_1fxiHRjC4sUAA--.54738S3;
        Wed, 16 Nov 2022 14:53:46 +0800 (CST)
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
Subject: [PATCH v3 2/2] dt-bindings: gpio: add loongson series gpio
Date:   Wed, 16 Nov 2022 14:53:35 +0800
Message-Id: <20221116065335.8823-2-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221116065335.8823-1-zhuyinbo@loongson.cn>
References: <20221116065335.8823-1-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx_1fxiHRjC4sUAA--.54738S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxXF47tFy8Ww43XFy5Gw4xXrb_yoWrZrykp3
        WDZFZxX3y2grnxtF45KanrZr4xAr1kC3WrurnxC3yxtrW7KwnxXFWfWFykG3Z3WrWUXF17
        JwsrurWFya43Aw7anT9S1TB71UUUUjJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfkFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUAVWUZwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY
        6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
        0EwIxGrwCF04k20xvE74AGY7Cv6cx26rWl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xF
        xVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
        C2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_
        Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
        WUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
        CTnIWIevJa73UjIFyTuYvjxU24EEUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Loongson series gpio binding with DT schema format using
json-schema.

Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
---
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
index 000000000000..f54048d03d9b
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
@@ -0,0 +1,126 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/loongson,ls-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Loongson series GPIO controller.
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
index bbd7a0d946eb..cfef13aada3b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12056,6 +12056,7 @@ M:	Huacai Chen <chenhuacai@kernel.org>
 M:	Yinbo Zhu <zhuyinbo@loongson.cn>
 L:	linux-gpio@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
 F:	drivers/gpio/gpio-loongson.c
 F:	include/linux/platform_data/gpio-loongson.h
 
-- 
2.31.1

