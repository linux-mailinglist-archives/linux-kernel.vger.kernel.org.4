Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A4C6D2F3F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 11:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjDAJN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 05:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDAJNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 05:13:24 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BFED33C02;
        Sat,  1 Apr 2023 02:13:14 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.77])
        by gateway (Coremail) with SMTP id _____8AxJMSp9Sdk+DMVAA--.21388S3;
        Sat, 01 Apr 2023 17:13:13 +0800 (CST)
Received: from loongson-PC.loongson.cn (unknown [10.20.42.77])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxHL6g9Sdk4r8SAA--.15842S2;
        Sat, 01 Apr 2023 17:13:11 +0800 (CST)
From:   Liu Peibao <liupeibao@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        wanghongliang <wanghongliang@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2] dt-bindings: interrupt-controller: loongarch: Fix mismathed compatible
Date:   Sat,  1 Apr 2023 17:13:04 +0800
Message-Id: <20230401091304.12633-1-liupeibao@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxHL6g9Sdk4r8SAA--.15842S2
X-CM-SenderInfo: xolx1vpled0qxorr0wxvrqhubq/1tbiAQAICmQmzXcHTgACsw
X-Coremail-Antispam: 1Uk129KBjvJXoW7ZF48KrW7Xr4DJrW5uw1rWFg_yoW8Wr13pF
        W7CFZxWF4jvF15Aa1kKa40kFnxZFnxJrn3uan3tw4xGr12g34UXFWj9F95JFWFgFZ2qrWU
        Zr1Fva10qasrJF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7xYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I
        0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
        GVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
        0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0
        rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r
        4UYxBIdaVFxhVjvjDU0xZFpf9x07URa0PUUUUU=
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "compatible" doesn't match what the kernel is using. Fix it as
kernel using.

Fixes: 6b2748ada244 ("dt-bindings: interrupt-controller: add yaml for LoongArch CPU interrupt controller")
Reported-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/all/20221208020954.GA3368836-robh@kernel.org/
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
---
V1 -> V2: Correct the commit ID in commit log.

 .../loongarch,cpu-interrupt-controller.yaml                   | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongarch,cpu-interrupt-controller.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongarch,cpu-interrupt-controller.yaml
index 2a1cf885c99d..81e4c0feb11e 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/loongarch,cpu-interrupt-controller.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/loongarch,cpu-interrupt-controller.yaml
@@ -11,7 +11,7 @@ maintainers:
 
 properties:
   compatible:
-    const: loongarch,cpu-interrupt-controller
+    const: loongson,cpu-interrupt-controller
 
   '#interrupt-cells':
     const: 1
@@ -28,7 +28,7 @@ required:
 examples:
   - |
     interrupt-controller {
-      compatible = "loongarch,cpu-interrupt-controller";
+      compatible = "loongson,cpu-interrupt-controller";
       #interrupt-cells = <1>;
       interrupt-controller;
     };
-- 
2.20.1

