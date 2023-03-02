Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8926A7C5D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 09:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjCBIRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 03:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjCBIRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 03:17:23 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48A3E32502;
        Thu,  2 Mar 2023 00:17:20 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8DxE1yPWwBk+ioHAA--.7979S3;
        Thu, 02 Mar 2023 16:17:19 +0800 (CST)
Received: from user-pc.202.106.0.20 (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxIL+IWwBkYzdGAA--.22878S2;
        Thu, 02 Mar 2023 16:17:18 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org (open list),
        Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v12 1/2] dt-bindings: gpio: add loongson gpio
Date:   Thu,  2 Mar 2023 16:17:10 +0800
Message-Id: <20230302081711.27334-1-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxIL+IWwBkYzdGAA--.22878S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW3XrWUWr1xtw17tr18XrWkJFb_yoW7AF1fpF
        1DZF9xX3y2qr13AFs8Ka17Xr4fAr1kAw1ruwnxC34xtrWUKw13XF4fWFykG3Z3WrWUXF13
        JanxurWrJ3W3Aw7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bq8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY
        6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCY1x0264kExV
        AvwVAq07x20xyl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VWrMxC20s026xCa
        FVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
        IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
        aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUxApnDUUUU
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_SBL_CSS,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
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
Change in v12:
		1. NO change, but other patch in this series of patches set has
		   change.
Change in v11:
		1. Place this patch in fron of driver patch.
Change in v10:
		1. NO change, but other patch in this series of patches set has
		   change.
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
 MAINTAINERS                                   |   6 +
 2 files changed, 132 insertions(+)
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
index 57d1d6ecb33d..b54b36187e75 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12086,6 +12086,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pinctrl/loongson,ls2k-pinctrl.yaml
 F:	drivers/pinctrl/pinctrl-loongson2.c
 
+LOONGSON GPIO DRIVER
+M:	Yinbo Zhu <zhuyinbo@loongson.cn>
+L:	linux-gpio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
+
 LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
 M:	Sathya Prakash <sathya.prakash@broadcom.com>
 M:	Sreekanth Reddy <sreekanth.reddy@broadcom.com>
-- 
2.31.1

