Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81CB60D98A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 05:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbiJZDED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 23:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbiJZDDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 23:03:11 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A655D8274F;
        Tue, 25 Oct 2022 20:03:06 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8Bxfdppo1hjPIUCAA--.10179S3;
        Wed, 26 Oct 2022 11:03:05 +0800 (CST)
Received: from localhost.localdomain (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxPuBio1hjWR0FAA--.19405S4;
        Wed, 26 Oct 2022 11:03:03 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 3/3] dt-bindings: clock: add loongson2 clock
Date:   Wed, 26 Oct 2022 11:02:56 +0800
Message-Id: <20221026030256.30512-3-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221026030256.30512-1-zhuyinbo@loongson.cn>
References: <20221026030256.30512-1-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxPuBio1hjWR0FAA--.19405S4
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxXF47tF4kJw4fKFyfWF1kuFg_yoW5GrWrpF
        nxC345GryIvF17Zws5Ka4xC3Z5Za1kCF17ZFnrAa42kr98G3W5XF17KryDZa9rAFy7Za9r
        ZFyxCr4UCa18Cr7anT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfkFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY
        6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
        0EwIxGrwCF04k20xvE74AGY7Cv6cx26rWl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xF
        xVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
        C2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_
        Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
        WUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
        CTnIWIevJa73UjIFyTuYvjxU2iFxUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the loongson2 clock binding with DT schema format using
json-schema.

Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/clock/loongson,ls2k-clk.yaml     | 63 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/loongson,ls2k-clk.yaml

diff --git a/Documentation/devicetree/bindings/clock/loongson,ls2k-clk.yaml b/Documentation/devicetree/bindings/clock/loongson,ls2k-clk.yaml
new file mode 100644
index 000000000000..6cc6e0755735
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/loongson,ls2k-clk.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/loongson,ls2k-clk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Loongson2 SoC Clock Control Module
+
+maintainers:
+  - Yinbo Zhu <zhuyinbo@loongson.cn>
+
+description: |
+  Loongson2 SoC clock control module is an integrated clock controller, which
+  generates and supplies to all modules.
+
+properties:
+  compatible:
+    enum:
+      - loongson,ls2k-clk
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: 100m ref
+
+  clock-names:
+    items:
+      - const: ref_100m
+
+  '#clock-cells':
+    const: 1
+    description:
+      The clock consumer should specify the desired clock by having the clock
+      ID in its "clocks" phandle cell. See include/dt-bindings/clock/loongson,ls2k-clk.h
+      for the full list of loongson2 SoC clock IDs.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    ref_100m: clock-ref-100m {
+        compatible = "fixed-clock";
+        #clock-cells = <0>;
+        clock-frequency = <100000000>;
+        clock-output-names = "ref_100m";
+    };
+
+    clk: clock-controller@1fe00480 {
+        compatible = "loongson,ls2k-clk";
+        reg = <0x1fe00480 0x58>;
+        #clock-cells = <1>;
+        clocks = <&ref_100m>;
+        clock-names = "ref_100m";
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index f01d60cd5c3b..f61a431ad8ca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11911,6 +11911,7 @@ LOONGSON2 SOC SERIES CLOCK DRIVER
 M:	Yinbo Zhu <zhuyinbo@loongson.cn>
 L:	linux-clk@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/clock/loongson,ls2k-clk.yaml
 F:	drivers/clk/clk-loongson2.c
 F:	include/dt-bindings/clock/loongson,ls2k-clk.h
 
-- 
2.31.1

