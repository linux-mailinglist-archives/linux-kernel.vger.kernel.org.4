Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D91C6120CC
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 08:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiJ2Gwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 02:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJ2Gwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 02:52:31 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BCAF080BFE;
        Fri, 28 Oct 2022 23:52:29 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8Dx_NiszVxj3zsDAA--.12166S3;
        Sat, 29 Oct 2022 14:52:28 +0800 (CST)
Received: from localhost.localdomain (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxiFenzVxj0S8HAA--.5930S3;
        Sat, 29 Oct 2022 14:52:27 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yun Liu <liuyun@loongson.cn>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        loongarch@lists.linux.dev, Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 2/2] dt-bindings: hpet: add loongson-2 hpet
Date:   Sat, 29 Oct 2022 14:52:22 +0800
Message-Id: <20221029065222.27912-2-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221029065222.27912-1-zhuyinbo@loongson.cn>
References: <20221029065222.27912-1-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxiFenzVxj0S8HAA--.5930S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7uF15Xw1xKw17Aw47Kr4kZwb_yoW8tFW8pa
        nrCF95Jr40kF17Z395KFy0k3WrZ3s7AFy7WF17J3WUKFyDX3W5X3W3Ka4DZwsxCFW8Xay7
        ZFWSkr45KayUur7anT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bSAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUAVWUZwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr
        1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkE
        cVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F4
        0Ex7xfMcIj6xIIjxv20xvE14v26rWY6Fy7McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCa
        FVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28Icx
        kI7VAKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km
        07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5
        JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rV
        WUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_
        Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jOTmhUUUUU=
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_SBL_CSS,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Loongson-2 High Precision Event Timer (HPET) binding
with DT schema format using json-schema.

Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/timer/loongson,ls2k-hpet.yaml    | 50 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/loongson,ls2k-hpet.yaml

diff --git a/Documentation/devicetree/bindings/timer/loongson,ls2k-hpet.yaml b/Documentation/devicetree/bindings/timer/loongson,ls2k-hpet.yaml
new file mode 100644
index 000000000000..30685c8fbead
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/loongson,ls2k-hpet.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/loongson,ls2k-hpet.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Loongson-2 High Precision Event Timer (HPET)
+
+maintainers:
+  - Yinbo Zhu <zhuyinbo@loongson.cn>
+
+properties:
+  compatible:
+    const: loongson,ls2k-hpet
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: SoC apb clock
+
+  clock-names:
+    items:
+      - const: apb
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/loongson,ls2k-clk.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    timer@1fe24000 {
+        compatible = "loongson,ls2k-hpet";
+        reg = <0x1fe24000 0x15f>;
+        clocks = <&clk LOONGSON2_APB_CLK>;
+        clock-names = "apb";
+        interrupt-parent = <&liointc0>;
+        interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 21c455d7a99a..e677c77136a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11919,6 +11919,7 @@ LOONGSON-2 SOC SERIES HPET DRIVER
 M:	Yinbo Zhu <zhuyinbo@loongson.cn>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/timer/loongson,ls2k-hpet.yaml
 F:	drivers/clocksource/loongson2_hpet.c
 
 LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
-- 
2.31.1

