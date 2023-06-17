Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D87733EA4
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 08:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjFQGYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 02:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjFQGY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 02:24:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A792683
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 23:24:27 -0700 (PDT)
Date:   Sat, 17 Jun 2023 06:24:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686983065;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NylHAmCmQ76Rw791ZTTP1U3oqUEJrmR6kqmyV/Ln66Y=;
        b=WTNWfJrZt3z/qhSQHEU0riAIl9l6Aoef/THPnnRUEBlmqCtOoQd19tDw6ab9yIX/f4HuL5
        r0Jjy9BXN8zJrD3NK61SniT4h1GtDhehGyEvSWldkbvfYMdizz4CNJ4iN43Vgsp1Rd/qo9
        l1kiCnIO0XptiDsOCXlZqkvs+6MrQGrRdkg20c6gHuwM4hS9AboE9iVwJAIh/PeGjDU6ta
        hqM63fK63i74i+seI+QAPnvCtjO4phjv+TN91vvvJv16C/2k660YJJTR98wdCle78CcH0Q
        HMgnHZiM0gIZSIvC8xQhiAhIFRiK/z2n5+Nr/vqFsOR7Be+18CmxcWtHlTksbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686983065;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NylHAmCmQ76Rw791ZTTP1U3oqUEJrmR6kqmyV/Ln66Y=;
        b=uZ58zR3hvFYosyMqg8FtpWq/SBH4gKwx50N/S8IkyljQNLQ16LY0etVFqJo+K95kOA5dKv
        uDm5gkQ2H76dYgDA==
From:   "irqchip-bot for Binbin Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] dt-bindings: interrupt-controller: Add
 Loongson EIOINTC
Cc:     Binbin Zhou <zhoubinbin@loongson.cn>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: =?utf-8?q?=3C4369959615eda101e612c450b8974d76ce7e8821=2E16832?=
 =?utf-8?q?79769=2Egit=2Ezhoubinbin=40loongson=2Ecn=3E?=
References: =?utf-8?q?=3C4369959615eda101e612c450b8974d76ce7e8821=2E168327?=
 =?utf-8?q?9769=2Egit=2Ezhoubinbin=40loongson=2Ecn=3E?=
MIME-Version: 1.0
Message-ID: <168698306469.404.6921468886954595002.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     2c23c07a359649b7a053c1af320044329768b1fd
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/2c23c07a359649b7a053c1af320044329768b1fd
Author:        Binbin Zhou <zhoubinbin@loongson.cn>
AuthorDate:    Fri, 05 May 2023 17:46:48 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 17 Jun 2023 07:16:09 +01:00

dt-bindings: interrupt-controller: Add Loongson EIOINTC

Add Loongson Extended I/O Interrupt controller binding with DT schema
format using json-schema.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/4369959615eda101e612c450b8974d76ce7e8821.1683279769.git.zhoubinbin@loongson.cn
---
 Documentation/devicetree/bindings/interrupt-controller/loongson,eiointc.yaml | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,eiointc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,eiointc.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,eiointc.yaml
new file mode 100644
index 0000000..393c128
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,eiointc.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/loongson,eiointc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Loongson Extended I/O Interrupt Controller
+
+maintainers:
+  - Binbin Zhou <zhoubinbin@loongson.cn>
+
+description: |
+  This interrupt controller is found on the Loongson-3 family chips and
+  Loongson-2K series chips and is used to distribute interrupts directly to
+  individual cores without forwarding them through the HT's interrupt line.
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - loongson,ls2k0500-eiointc
+      - loongson,ls2k2000-eiointc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - '#interrupt-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    eiointc: interrupt-controller@1fe11600 {
+      compatible = "loongson,ls2k0500-eiointc";
+      reg = <0x1fe10000 0x10000>;
+
+      interrupt-controller;
+      #interrupt-cells = <1>;
+
+      interrupt-parent = <&cpuintc>;
+      interrupts = <3>;
+    };
+
+...
