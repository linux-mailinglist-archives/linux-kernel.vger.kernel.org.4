Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0BC639634
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 14:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiKZNft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 08:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiKZNfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 08:35:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7B01D674
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 05:34:49 -0800 (PST)
Date:   Sat, 26 Nov 2022 13:34:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669469687;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KvHJ7jlKpYZk3pzLo0+rM+uRdAXs08XEQZ3v20Ebbag=;
        b=ma+9AkEyvhIiLx1ilHiZe2CKGGnw6XQGnGkMWFM4bBvI2e1IwqqV1KjS5yXBnmEQuxXYVh
        5pvnnMOdtXboxf8l/T3x4tBZ162w8wpmnB1D61ldG3q5drMNlRt+T6rDZa2eunv6QxCWBV
        tR9b/SpQF1RDL8frtLLWaGbVqkYuy6gNHlebuGCoUITO7Ht/4X7K82zKH//wCbJSXtamW0
        gn67vZyKzKfOeYpQ5CwUWQX5wJP28s/JwqI2PXIOqpbj5hHfmpbD1n5MgRdDtHtewLAdjI
        a+E9a+1SmTzMIC/Pi37p8uY1HJKrt27rOblc/WuuqfLg3MNc7zn0tkZuzP2RCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669469687;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KvHJ7jlKpYZk3pzLo0+rM+uRdAXs08XEQZ3v20Ebbag=;
        b=F+yaEDSUdx8cjJ6wh7F0POXd8fRb66R1xeAkVBtyo+tpOBEe0MxtN5Yc9GDzijFSUxphAf
        YJQICsb0XMPb4WAA==
From:   "irqchip-bot for Liu Peibao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] dt-bindings: interrupt-controller: add
 yaml for LoongArch CPU interrupt controller
Cc:     Liu Peibao <liupeibao@loongson.cn>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20221114113824.1880-3-liupeibao@loongson.cn>
References: <20221114113824.1880-3-liupeibao@loongson.cn>
MIME-Version: 1.0
Message-ID: <166946968615.4906.13490870742447683383.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     6b2748ada244c7597e9b677a0bdda4e8781a8d8f
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/6b2748ada244c7597e9b677a0bdda4e8781a8d8f
Author:        Liu Peibao <liupeibao@loongson.cn>
AuthorDate:    Mon, 14 Nov 2022 19:38:24 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 26 Nov 2022 11:54:11 

dt-bindings: interrupt-controller: add yaml for LoongArch CPU interrupt controller

Current LoongArch compatible CPUs support 14 CPU IRQs. We can describe how
the 14 IRQs are wired to the platform's internal interrupt controller by
devicetree.

Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221114113824.1880-3-liupeibao@loongson.cn
---
 Documentation/devicetree/bindings/interrupt-controller/loongarch,cpu-interrupt-controller.yaml | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongarch,cpu-interrupt-controller.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongarch,cpu-interrupt-controller.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongarch,cpu-interrupt-controller.yaml
new file mode 100644
index 0000000..2a1cf88
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/loongarch,cpu-interrupt-controller.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/loongarch,cpu-interrupt-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LoongArch CPU Interrupt Controller
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
