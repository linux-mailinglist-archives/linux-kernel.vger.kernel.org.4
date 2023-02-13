Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4FF694595
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjBMMPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjBMMPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:15:35 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF7F17ECE;
        Mon, 13 Feb 2023 04:15:29 -0800 (PST)
Received: from loongson.cn (unknown [112.20.108.204])
        by gateway (Coremail) with SMTP id _____8AxqtngKepjfBQAAA--.224S3;
        Mon, 13 Feb 2023 20:15:28 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.108.204])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxPuTdKepjPEQyAA--.58840S3;
        Mon, 13 Feb 2023 20:15:27 +0800 (CST)
From:   Binbin Zhou <zhoubinbin@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        loongarch@lists.linux.dev, devicetree@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn,
        Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH V2 1/2] dt-bindings: interrupt-controller: Add Loongson EIOINTC
Date:   Mon, 13 Feb 2023 20:15:27 +0800
Message-Id: <a9f697906df6599e6b001981e668479da71aa7a0.1676289084.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1676289084.git.zhoubinbin@loongson.cn>
References: <cover.1676289084.git.zhoubinbin@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxPuTdKepjPEQyAA--.58840S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7ZF18Jr17ZF15ur18JryxXwb_yoW5JF43pF
        W7C3ZxWF4UtF17AayrtFy0kF15ZrZ5AwnxCws7J3y7JF9rK34UXr4akFn8J3W3Cr97X3W2
        vF1F93W8Kay7AF7anT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bS8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAa
        w2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2
        jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262
        kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km
        07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8
        JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r
        1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
        YxBIdaVFxhVjvjDU0xZFpf9x07jz5lbUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Loongson Extended I/O Interrupt controller binding with DT schema
format using json-schema.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 .../loongson,eiointc.yaml                     | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,eiointc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,eiointc.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,eiointc.yaml
new file mode 100644
index 000000000000..88580297f955
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,eiointc.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/interrupt-controller/loongson,eiointc.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Loongson Extended I/O Interrupt Controller
+
+maintainers:
+  - Binbin Zhou <zhoubinbin@loongson.cn>
+
+description: |
+  This interrupt controller is found on the Loongson-3 family chips and
+  Loongson-2K0500 chip and is used to distribute interrupts directly to
+  individual cores without forwarding them through the HT's interrupt line.
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - loongson,eiointc-1.0
+
+  reg:
+    minItems: 1
+    maxItems: 3
+
+  interrupt-controller: true
+
+  interrupts:
+    description:
+      Interrupt source of the CPU interrupts.
+
+  interrupt-names:
+    description:
+      List of names for the parent interrupts.
+    items:
+      - const: int0
+
+  '#interrupt-cells':
+    const: 1
+
+  'loongson,eio-num-vecs':
+    description:
+      The number of devices supported by the extended I/O interrupt vector.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 1
+    maximum: 256
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - '#interrupt-cells'
+  - 'loongson,eio-num-vecs'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    eiointc: interrupt-controller@1fe11600 {
+      compatible = "loongson,eiointc-1.0";
+      reg = <0x1fe11600 0x8
+             0x1fe11700 0x8
+             0x1fe11800 0x8>;
+
+      interrupt-controller;
+      #interrupt-cells = <1>;
+
+      interrupt-parent = <&cpuintc>;
+      interrupts = <3>;
+      interrupt-names = "int0";
+
+      loongson,eio-num-vecs = <128>;
+
+    };
+
+...
-- 
2.39.0

