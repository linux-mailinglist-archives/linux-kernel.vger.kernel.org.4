Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEF5602C61
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiJRNGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiJRNF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:05:56 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91A50C58BB;
        Tue, 18 Oct 2022 06:05:48 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8AxzNirpE5jhG0AAA--.2549S3;
        Tue, 18 Oct 2022 21:05:47 +0800 (CST)
Received: from localhost.localdomain (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxbuCipE5j_LMAAA--.2960S4;
        Tue, 18 Oct 2022 21:05:45 +0800 (CST)
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
Subject: [PATCH v1 3/3] dt-bindings: clock: add loongson2k clock binding
Date:   Tue, 18 Oct 2022 21:05:31 +0800
Message-Id: <20221018130531.301-3-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221018130531.301-1-zhuyinbo@loongson.cn>
References: <20221018130531.301-1-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxbuCipE5j_LMAAA--.2960S4
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxXF47tF4kGr1UAr1fXw1UZFb_yoW5XrW8pF
        nrC345Gr1IvF17ZwsYgFyxAwn5ua97AF17ZFnrAa42kr98W3W5XF43KryDZa9rAFyxZa9r
        ZFyfWr4UC3W8uw7anT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bSxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84
        ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWl
        n4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxV
        Aaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxY
        O2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
        WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
        Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rV
        WUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4U
        JbIYCTnIWIevJa73UjIFyTuYvjxU4Xo7DUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the loongson2k clock binding with DT schema format using
json-schema.

Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
---
 .../bindings/clock/loongson,ls2k-clk.yaml     | 77 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/loongson,ls2k-clk.yaml

diff --git a/Documentation/devicetree/bindings/clock/loongson,ls2k-clk.yaml b/Documentation/devicetree/bindings/clock/loongson,ls2k-clk.yaml
new file mode 100644
index 000000000000..cf42e7cd4c7e
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/loongson,ls2k-clk.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/loongson,ls2k-clk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Loongson2 SoC Clock Control Module Binding
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
+    minItems: 1
+
+  clock-names:
+    minItems: 1
+
+  '#clock-cells':
+    const: 1
+    description:
+      The clock consumer should specify the desired clock by having the clock
+      ID in its "clocks" phandle cell. See include/dt-bindings/clock/loongson2-clock.h
+      for the full list of loongson2 SoC clock IDs.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: loongson,ls2k-clk
+    then:
+      properties:
+        clocks:
+          items:
+            - description: 100m refclk
+        clock-names:
+          items:
+            - const: refclk_100m
+
+additionalProperties: false
+
+examples:
+  - |
+    refclk_100m: clock-refclk-100m {
+        compatible = "fixed-clock";
+        #clock-cells = <0>;
+        clock-frequency = <100000000>;
+        clock-output-names = "refclk_100m";
+    };
+
+  - |
+    clk: clock-controller@1fe00480 {
+        compatible = "loongson,ls2k-clk";
+        reg = <0x1fe00480 0x58>;
+        #clock-cells = <1>;
+        clocks = <&refclk_100m>;
+        clock-names = "refclk_100m";
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 4caea1d99310..38cea8df9068 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11918,6 +11918,7 @@ LOONGSON2 SOC SERIES CLOCK DRIVER
 M:	Yinbo Zhu <zhuyinbo@loongson.cn>
 L:	linux-clk@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/clock/loongson,ls2k-clk.yaml
 F:	drivers/clk/clk-loongson2.c
 F:	include/dt-bindings/clock/loongson2-clock.h
 
-- 
2.20.1

