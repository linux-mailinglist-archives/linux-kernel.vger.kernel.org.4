Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52ABA61E89B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 03:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiKGCeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 21:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiKGCeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 21:34:15 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16C352AE3;
        Sun,  6 Nov 2022 18:34:12 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.77])
        by gateway (Coremail) with SMTP id _____8Axz7ejbmhjgu0EAA--.11534S3;
        Mon, 07 Nov 2022 10:34:11 +0800 (CST)
Received: from loongson-PC.loongson.cn (unknown [10.20.42.77])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dxr+Ccbmhj2D0OAA--.40061S3;
        Mon, 07 Nov 2022 10:34:09 +0800 (CST)
From:   Liu Peibao <liupeibao@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: interrupt-controller: add yaml for LoongArch CPU interrupt controller
Date:   Mon,  7 Nov 2022 10:34:04 +0800
Message-Id: <20221107023404.26730-2-liupeibao@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221107023404.26730-1-liupeibao@loongson.cn>
References: <20221107023404.26730-1-liupeibao@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dxr+Ccbmhj2D0OAA--.40061S3
X-CM-SenderInfo: xolx1vpled0qxorr0wxvrqhubq/1tbiAQADCmNno+QHGAAAsU
X-Coremail-Antispam: 1Uk129KBjvJXoW7CFy5Gw4xKF17Gw1kWrWfZrb_yoW8CF1kpF
        W7CanxWF40qF43Cws2ga40krnxZFnxJrna9ws3tw47Gr1ag343XFW29F95JFW8GrZ2qw17
        Z3WFv3W0q3ZrJF7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bS8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAa
        w2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2
        jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262
        kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km
        07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
        CVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r
        1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
        YxBIdaVFxhVjvjDU0xZFpf9x07jrcTPUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
---
 .../loongarch,cpu-interrupt-controller.yaml   | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongarch,cpu-interrupt-controller.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongarch,cpu-interrupt-controller.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongarch,cpu-interrupt-controller.yaml
new file mode 100644
index 000000000000..30b742661a3f
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/loongarch,cpu-interrupt-controller.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/loongarch,cpu-interrupt-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LoongArch CPU Interrupt Controller
+
+description: >
+   On LoongArch the loongarch_cpu_irq_of_init() helper can be used to initialize
+   the 14 CPU IRQs from a devicetree file and create a irq_domain for this IRQ
+   controller.
+
+   With the irq_domain in place we can describe how the 14 IRQs are wired to the
+   platforms internal interrupt controller cascade.
+
+maintainers:
+  - Liu Peibao <liupeibao@loongson.cn>
+
+properties:
+  compatible:
+    const: loongarch,cpu-interrupt-controller
+
+  '#interrupt-cells':
+    const: 1
+
+  interrupt-controller: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - '#interrupt-cells'
+  - interrupt-controller
+
+examples:
+  - |
+    interrupt-controller {
+      compatible = "loongarch,cpu-interrupt-controller";
+      #interrupt-cells = <1>;
+      interrupt-controller;
+    };
-- 
2.20.1

